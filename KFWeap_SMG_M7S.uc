//=============================================================================
// Base File: KFWeap_SMG_P90
//=============================================================================
// Class Description
//=============================================================================
// Killing Floor 2
// Gear Shift Gaming Mods
//  - Author 06/02/2019
//=============================================================================

class KFWeap_SMG_M7S extends KFWeap_SMGBase;

var KFPlayerController KFPC;
var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Headshot, Reticle_Friendly, SightCanvasIcon;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon SightFlavorIcon;

var Halo_Weapon_UI M7S_UI;

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

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	super.PlayWeaponEquip(ModifiedEquipTime);

	if(M7S_UI == none)
	{
		M7S_UI = New class'Halo_Weapon_UI';
		SightFlavorIcon = New class'FlavorIcon';
		SightFlavorIcon.MakeFlavorIcon(SightCanvasIcon, 639, 399, 890, 634, 1049, 569, 890, 330, 1409, 689, 1330, 330, 2170, 330, 0.15649, 0.190042, 0.190042, 0.190042, 0.24926, 0.190042, 0.190042);
		FlavorIcons.AddItem(SightFlavorIcon);
	}
}

//This function runs continuously, and when iron sights are being used it does the drawing.
simulated function DrawHUD( HUD H, Canvas C )
{
	super.DrawHUD(H, C);

	if(!M7S_UI.isInitialized)
	{
		KFPC = KFPlayerController(Instigator.Controller);
		M7S_UI.InitializeWeaponUI_NoHeadshot(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		M7S_UI.RunWeaponUI(C);
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
		ZoomOut=AkEvent'M6C-SOCOM.Audio.Play_M6S_zoom_out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}
	else
	{
		ZoomIn=AkEvent'M6C-SOCOM.Audio.Play_M6S_zoom_in';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(None);
		LaserSight.LaserDotMeshComp.SetStaticMesh(None);
	}
}

function ZoomTimer()
{
	return;
	//This is only here to stop logging errors.
}

simulated state Reloading
{
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}
}

defaultproperties
{
	// Inventory
	InventorySize=7
	GroupPriority=120
	WeaponSelectTexture=Texture2D'M7S.Textures.M7S_UI_v1'

	// FOV
	MeshFOV=75
	MeshIronSightFOV=5 //60
	PlayerIronSightFOV=65 //75

	// Zooming/Position
	IronSightPosition=(X=0,Y=10,Z=5.1)
	PlayerViewOffset=(X=19,Y=10,Z=-0.5)

	//Content
	PackageKey="M7S"
	FirstPersonMeshName="M7S.Mesh.Wep_1stP_M7S_Rig"
	FirstPersonAnimSetNames(0)="M7S.Anims.Wep_1stP_M7S_Anim"
	PickupMeshName="M7S.Mesh.Wep_3rdP_M7S_Pickup"
	AttachmentArchetypeName="M7S.Archetypes.Wep_M7S_3P"
	MuzzleFlashTemplateName="M7S.Archetypes.Wep_M7S_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=48
	SpareAmmoCapacity[0]=480 //432
	InitialSpareMags[0]=3
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=155 //120 //70
	minRecoilPitch=80 //55
	maxRecoilYaw=75 //55 //50
	minRecoilYaw=-55 //50
	RecoilRate=0.055 //0.06
	RecoilMaxYawLimit=400
	RecoilMinYawLimit=65135
	RecoilMaxPitchLimit=800
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=150 //130 //150
	RecoilISMinYawLimit=65385
	RecoilISMaxPitchLimit=220 //150
	RecoilISMinPitchLimit=65435
	IronSightMeshFOVCompensationScale=2.0

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M7S'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M7S'
	FireInterval(DEFAULT_FIREMODE)=+.0666 // 900 RPM
	InstantHitDamage(DEFAULT_FIREMODE)=45 //43
	FireOffset=(X=30,Y=4.5,Z=-5)
	Spread(DEFAULT_FIREMODE)=0.02 //0.012

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_M7S'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_M7S'
	FireInterval(ALTFIRE_FIREMODE)=+.0666
	InstantHitDamage(ALTFIRE_FIREMODE)=45 //43
	Spread(ALTFIRE_FIREMODE)=0.02 //0.012

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M7S'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_Single', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_Single')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_Single', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_Single')
	
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'

	/* 
	//Advanced (High RPM) Fire Effects
	bLoopingFireAnim(DEFAULT_FIREMODE)=true
	bLoopingFireSnd(DEFAULT_FIREMODE)=true
	WeaponFireLoopEndSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_EndLoop', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_EndLoop')
	SingleFireSoundIndex=ALTFIRE_FIREMODE
	*/

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false
	bHasLaserSight=true //true

	bWarnAIWhenAiming = false;

	//Custom Animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	AssociatedPerkClasses(0)=class'KFPerk_Swat'

	UIBackgrounds[0] = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'M7S.UI.M7S_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'M7S.UI.M7S_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'M7S.UI.M7S_Reticle_Background_16_9_v2'
	UIBackgrounds[4] = Texture2D'M7S.UI.M7S_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'M7S.UI.M7S_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'M7S.UI.M7S_Reticle_Background_32_9_v2'

	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=0, V=260, UL=224, VL=224)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=0, V=710, UL=224, VL=224)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=0, V=485, UL=224, VL=224)

	SightCanvasIcon = (Texture=Texture2D'M7S.UI.M7S_Sight_Elements', U=0, V=0, UL=4096, VL=4096)
}
