//=============================================================================
// Base File: KFWeap_RocketLauncher_RPG7
//=============================================================================
// A rocket launcher that can fire two big rockets back to back
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================
class KFWeap_RocketLauncher_M41 extends KFWeap_GrenadeLauncher_Base;

var KFPlayerController KFPC;
var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Friendly;
var CanvasIcon ZoomCanvasIcon, CircleCanvasIcon;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon ZoomFlavorIcon, CircleFlavorIcon;

var TextureMovie BulletMovie;

var CanvasIcon BulletCanvas, BulletMovieCanvas;
var FlavorIcon BulletFlavor, BulletMovieFlavor;
var array<int> BulletDistanceCollection;

var String AmmoText;

var Halo_Weapon_UI M41_UI;

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	super.PlayWeaponEquip(ModifiedEquipTime);

	if(M41_UI == none)
	{
		M41_UI = New class'Halo_Weapon_UI';

		ZoomFlavorIcon = New class'FlavorIcon';
		CircleFlavorIcon = New class'FlavorIcon';

		BulletFlavor = New class'FlavorIcon';
		BulletMovieFlavor = New class'FlavorIcon';

		ZoomFlavorIcon.MakeFlavorIcon(ZoomCanvasIcon, 1155, 860, 1498, 1246, 1651, 2286, 1498, 942, 2201, 1487, 1938, 942, 2278, 942, 0.26543, 0.25308, 0.28395, 0.25308, 0.37962, 0.25308, 0.25308);
		CircleFlavorIcon.MakeFlavorIcon(CircleCanvasIcon, 639, 397, 891, 635, 1051, 571, 891, 331, 1407, 687, 1331, 331, 2171, 331, 1.0, 1.0, 1.0, 1.0, 1.32046, 1.0, 1.0);

		//Do not add the below to the FlavorIcon array. Each position marker is the first (top-most) bullet in the display.
		BulletFlavor.MakeFlavorIcon(BulletCanvas, 722, 820, 1007, 1210, 1166, 1138, 1013, 904, 1558, 1433, 1448, 899, 2289, 899, 0.05172, 0.05258, 0.05086, 0.05258, 0.07887, 0.05258, 0.05258);
		BulletMovieFlavor.MakeFlavorIcon(BulletMovieCanvas, 722, 820, 1007, 1210, 1166, 1138, 1013, 904, 1558, 1433, 1448, 899, 2289, 899, 0.05172, 0.05258, 0.05086, 0.05258, 0.07887, 0.05258, 0.05258);

		FlavorIcons.AddItem(ZoomFlavorIcon);
		FlavorIcons.AddItem(CircleFlavorIcon);

		BulletMovie = TextureMovie(BulletMovieCanvas.Texture);

		KFPC = KFPlayerController(Instigator.Controller);
	}
}

//This function allows us to play a sound, in this case, the zoom sounds for the different weapons.
simulated function WeaponZoomSound(AkEvent ZoomSound)
{
	if( Instigator != None && !bSuppressSounds )
	{
		if ( ZoomSound != None && Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() )
		{
            Instigator.PlaySoundBase( ZoomSound, true, false, false );
		}
	}
}

//This function runs continuously, and when iron sights are being used it does the drawing.
simulated function DrawHUD( HUD H, Canvas C )
{
	super.DrawHUD(H, C);

	if(!M41_UI.isInitialized)
	{
		KFPC = KFPlayerController(Instigator.Controller);
		M41_UI.InitializeWeaponUI_NoHeadshot(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		M41_UI.RunWeaponUI(C);
		M41_UI.DrawAmmoUI(C, 2, BulletDistanceCollection, BulletFlavor, BulletMovieFlavor, BulletMovie, AmmoText);
	}
}

//This is where we both create the zoom effects in canvas, and play the zoom sounds.
simulated function SetIronSights(bool bNewIronSights)
{
	local AkEvent ZoomIn;
	local AkEvent ZoomOut;

	super.SetIronSights(bNewIronSights);

	if(!bUsingSights)
	{
		ZoomOut=AkEvent'M41.Audio.Play_M41_Zoom_Out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
	}
	else
	{
		ZoomIn=AkEvent'M41.Audio.Play_M41_Zoom_In';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
	}
}

function ZoomTimer()
{
	return;
	//This is only here to stop logging errors.
}

defaultproperties
{
	// Inventory
	InventoryGroup=IG_Primary
	GroupPriority=120
	InventorySize=9 //11
	WeaponSelectTexture=Texture2D'M41.UI.M41_UI_v1'

    // FOV
	MeshFOV=70
	MeshIronSightFOV=5
    PlayerIronSightFOV=50

	// Depth of field
	DOF_FG_FocalRadius=50
	DOF_FG_MaxNearBlurSize=2.5

	// Zooming/Position
	PlayerViewOffset=(X=22.0,Y=7.8,Z=7.5) //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	IronSightPosition=(X=0,Y=10,Z=0)
	FastZoomOutTime=0.2

	// Content
	PackageKey="M41"
	FirstPersonMeshName="M41.Mesh.Wep_1stP_M41_Rig"
	FirstPersonAnimSetNames(0)="M41.1stp_anims.Wep_1stP_M41_Anim"
	PickupMeshName="M41.Mesh.Wep_M41_Pickup"
	AttachmentArchetypeName="M41.Archetypes.Wep_M41_3P"
	MuzzleFlashTemplateName="M41.Archetypes.Wep_M41_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=2
	SpareAmmoCapacity[0]=8
	InitialSpareMags[0]=1
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=900
	minRecoilPitch=775
	maxRecoilYaw=500
	minRecoilYaw=-500
	RecoilRate=0.085
	//RecoilBlendOutRatio=0.35
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=1500
	RecoilMinPitchLimit=64785
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=500
	RecoilISMinPitchLimit=65485
	RecoilViewRotationScale=0.8
	FallingRecoilModifier=1.5
	HippedRecoilModifier=1.25

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'UI_FireModes_TEX.UI_FireModeSelect_Rocket'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSinglefiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Rocket_M41'
	FireInterval(DEFAULT_FIREMODE)=+1.2
	InstantHitDamage(DEFAULT_FIREMODE)=150.0
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M41Impact'
	Spread(DEFAULT_FIREMODE)=0.025
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None=AkEvent'M7S.Audio.Play_dryfire'

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M41'
	InstantHitDamage(BASH_FIREMODE)=35

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M41.Audio.Play_M41_Fire_3P', FirstPersonCue=AkEvent'M41.Audio.Play_M41_Fire_1P')

	//@todo: add akevent when we have it
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_RPG7.Play_WEP_SA_RPG7_DryFire'

	// Animation
	bHasFireLastAnims=true
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	BonesToLockOnEmpty=(RW_Grenade1)
	MeleeAttackAnims=(Bash, Bash_2)

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=class'KFPerk_Demolitionist'

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'

	UIBackgrounds[0] = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'M7S.UI.M7S_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'M7S.UI.M7S_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'M7S.UI.M7S_Reticle_Background_16_9_v2'
	UIBackgrounds[4] = Texture2D'M7S.UI.M7S_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'M7S.UI.M7S_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'M7S.UI.M7S_Reticle_Background_32_9_v2'

	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=224, V=276, UL=320, VL=320)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=224, V=597, UL=320, VL=320)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=224, V=918, UL=320, VL=320)

	ZoomCanvasIcon = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=475, V=145, UL=162, VL=130)
	CircleCanvasICon = (Texture=Texture2D'Shared.UI.General_Black_Circle', U=1, V=1, UL=777, VL=777)

	BulletCanvas = (Texture=Texture2D'M41.UI.M41_New_Rocket', U=0, V=0, UL=2320, VL=600)
	BulletMovieCanvas = (Texture=TextureMovie'M41.UI.M41_New_Rocket_Movie', U=0, V=0, UL=2320, VL=600)

	AmmoText = "Rockets"

	BulletDistanceCollection[0] = 48 //24 //4_3
	BulletDistanceCollection[1] = 40 //20 //5_4
	BulletDistanceCollection[2] = 56 //64 //32 //3_2
	BulletDistanceCollection[3] = 46 //48 //24 //16_9
	BulletDistanceCollection[4] = 68 //34 //16_10
	BulletDistanceCollection[5] = 48 //24 //21_9
	BulletDistanceCollection[6] = 48 //24 //32_9
}
