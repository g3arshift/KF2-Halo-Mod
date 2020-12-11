//=============================================================================
// Base File: KFWeap_Pistol_Deagle
//=============================================================================
// An M6D Magnum, from Halo Combat Evolved
//=============================================================================
// Gear Shift Gaming Mods 7/19/2019
//=============================================================================

class KFWeap_Pistol_M6D extends KFWeap_PistolBase;

var KFPlayerController KFPC;
var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Headshot, Reticle_Friendly, ZoomCanvasIcon;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon ZoomFlavorIcon;

var Halo_Weapon_UI M6D_UI;

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	super.PlayWeaponEquip(ModifiedEquipTime);

	if(M6D_UI == none)
	{
		M6D_UI = New class'Halo_Weapon_UI';
		ZoomFlavorIcon = New class'FlavorIcon';
		ZoomFlavorIcon.MakeFlavorIcon(ZoomCanvasIcon, 1187, 976, 1579, 1352, 1739, 1288, 1579, 1054, 2310, 1619, 2019, 1054, 2853, 1054, 0.37, 0.44, 0.44, 0.44, 0.52, 0.44, 0.44);
		FlavorIcons.AddItem(ZoomFlavorIcon);
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

	if(!M6D_UI.isInitialized)
	{
		KFPC = KFPlayerController(Instigator.Controller);
		M6D_UI.InitializeWeaponUI(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, Reticle_Headshot, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		M6D_UI.RunWeaponUI(C);
	}
}

/*
Deprecated. More costly than the other draw function. Kept purely for reference.
event PostBeginPlay()
{
	PrepareDrawing();
}

function PrepareDrawing()
{
	local KFHUDBase KFHUD;

	if( GetALocalPlayerController() != none )
	{
		KFHUD = KFHUDBase(GetALocalPlayerController().myHud);
		KFHUD.SetShowOverlays( true );
		KFHUD.AddPostRenderedActor(self);
	}
	else
	{
		`log("Local Player Controller Not Found.");
	}
}

simulated event PostRenderFor( PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir )
{
	super.PostRenderFor( PC, Canvas, CameraPosition, CameraDir);
	if(bUsingSights)
	{
		Canvas.SetPos(1250.0, 690.0);
		Canvas.DrawTexture(Texture2D'M6D.Textures.M6D_Reticle', 0.5 ); //Base texture size is 128 x 128

		Canvas.SetPos(0.0, 0.0 ); //Sets the position to the top left of the screen.
		Canvas.DrawTexture(Texture2D'M6D.Textures.M6D_Reticle_Background', 1.0 ); //Base texture size is 2560 x 1440
	}
}
*/

//This is where we both create the zoom effects in canvas, and play the zoom sounds.
simulated function SetIronSights(bool bNewIronSights)
{
	local AkEvent ZoomIn;
	local AkEvent ZoomOut;

	super.SetIronSights(bNewIronSights);

	if(!bUsingSights)
	{
		ZoomOut=AkEvent'M6D.Audio.Play_M6D_zoom_out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
	}
	else
	{
		ZoomIn=AkEvent'M6D.Audio.Play_M6D_zoom_in';
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
    // FOV
	MeshFOV=86
	MeshIronSightFOV=5
    PlayerIronSightFOV=50

	// Depth of field
	DOF_FG_FocalRadius=50 //38
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=14.0,Y=10,Z=-4)

	//Lower FOV and increase DOF for canvas iron sights.

	// Content
	PackageKey="M6D"
	FirstPersonMeshName="M6D.Mesh.Wep_1stP_M6D_Rig"
	FirstPersonAnimSetNames(0)="M6D.1stp_anims.Wep_1st_M6D_Anim"
	PickupMeshName="M6D.Mesh.M6D_Static"
	AttachmentArchetypeName="M6D.Archetype.Wep_M6D_3P"
	MuzzleFlashTemplateName="M6D.Archetype.Wep_M6D_MuzzleFlash"

   	// Zooming/Position
	IronSightPosition=(X=11,Y=10,Z=0) //(X=11,Y=0,Z=0)

	// Ammo
	MagazineCapacity[0]=12
	SpareAmmoCapacity[0]=84 //96 //120
	InitialSpareMags[0]=0
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=450 //650
	minRecoilPitch=350 //550
	maxRecoilYaw=75 //150
	minRecoilYaw=-75 //-150
	RecoilRate=0.07
	RecoilMaxYawLimit=350 //500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=1250
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=500
	RecoilISMinPitchLimit=65485

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M6D'
	FireInterval(DEFAULT_FIREMODE)=+0.305
	InstantHitDamage(DEFAULT_FIREMODE)=235 //300
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M6D'
	PenetrationPower(DEFAULT_FIREMODE)=1.2 //1.0
	Spread(DEFAULT_FIREMODE)=0.01 //0.08
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M6D'
	InstantHitDamage(BASH_FIREMODE)=30

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M6D.Audio.Play_Fire_M6D_3P', FirstPersonCue=AkEvent'M6D.Audio.Play_Fire_M6D_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M392.Audio.Play_M392_Dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	// Inventory
	InventorySize=6 //4
	GroupPriority=75
	InventoryGroup=IG_Primary
	bCanThrow=true
	bDropOnDeath=true
	WeaponSelectTexture=Texture2D'M6D.Textures.M6D_UI_v1'
	bIsBackupWeapon=false
	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'
	AssociatedPerkClasses(1)=class'KFPerk_Demolitionist'

	// Custom animations
	FireSightedAnims=(Shoot_Iron, Shoot_Iron2, Shoot_Iron3)
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2, Guncheck_v3, Guncheck_v4)

	bHasFireLastAnims=true

	BonesToLockOnEmpty=(RW_Slide, RW_Bullets1)

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Medium_Recoil'

	UIBackgrounds[0] = Texture2D'Shared.UI.Basic_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'Shared.UI.Basic_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'Shared.UI.Basic_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'Shared.UI.Basic_Reticle_Background_v2'
	UIBackgrounds[4] = Texture2D'Shared.UI.Basic_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'Shared.UI.Basic_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'Shared.UI.Basic_Reticle_Background_32_9_v2'

	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1759, V=0, UL=128, VL=128)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=129, V=0, UL=128, VL=128)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=258, V=0, UL=128, VL=128)
	Reticle_Headshot = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=387, V=0, UL=128, VL=128)

	ZoomCanvasIcon = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=475, V=145, UL=162, VL=130)
}