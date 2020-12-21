//=============================================================================
// Base File: KFWeap_Revolver_SW500
//=============================================================================
// A Silenced M6C Pistol
//=============================================================================
// Gear Shift Gaming Mods 6/8/2019
//=============================================================================

class KFWeap_Pistol_M6C_SOCOM extends KFWeap_PistolBase;

var KFPlayerController KFPC;
var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Headshot, Reticle_Friendly, ZoomCanvasIcon;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon ZoomFlavorIcon;

var Halo_Weapon_UI M6C_SOCOM_UI;

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	super.PlayWeaponEquip(ModifiedEquipTime);

	if(M6C_SOCOM_UI == none)
	{
		M6C_SOCOM_UI = New class'Halo_Weapon_UI';
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

	if(!M6C_SOCOM_UI.isInitialized)
	{
		KFPC = KFPlayerController(Instigator.Controller);
		M6C_SOCOM_UI.InitializeWeaponUI(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, Reticle_Headshot, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		M6C_SOCOM_UI.RunWeaponUI(C);
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
/*
simulated state Reloading
{
	simulated function ReloadComplete()
	{
		Super.ReloadComplete();

		if(LaserSight.LaserSightMeshComp.SkeletalMesh = None || LaserSight.LaserSightMeshComp.StaticMesh == None)
		{
			LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
			LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
		}
	}

	simulated function AbortReload()
	{
		Super.AbortReload();

		if(LaserSight.LaserSightMeshComp.SkeletalMesh == None || LaserSight.LaserSightMeshComp.StaticMesh == None)
		{
			LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
			LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
		}
	}
}
*/
defaultproperties
{
    // FOV
	MeshFOV=86 //86
	MeshIronSightFOV=5 //77
    PlayerIronSightFOV=30

	// Depth of field
	DOF_FG_FocalRadius=38
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=20.0,Y=12,Z=-4) //-6 //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	IronSightPosition=(X=10,Y=10,Z=2.57) //(X=10,Y=0,Z=2.57)

	// Content
	PackageKey="M6C_SOCOM"
	FirstPersonMeshName="M6C-SOCOM.Meshes.Wep_1stP_M6C-SOCOM_Rig"
	FirstPersonAnimSetNames(0)="M6C-SOCOM.1stP_Anims.Wep_1stP_M6C-SOCOM_Anim"
	PickupMeshName="M6C-SOCOM.Meshes.M6C_SOCOM_Pickup"
	AttachmentArchetypeName="M6C-SOCOM.Archetypes.Wep_M6C_SOCOM_3P"
	MuzzleFlashTemplateName="M7S.Archetypes.Wep_M7S_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=12
	SpareAmmoCapacity[0]=180 //168
	InitialSpareMags[0]=4 //3
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=185 //200
	minRecoilPitch=185 //200
	maxRecoilYaw=50 //60
	minRecoilYaw=-45 //-55
	RecoilRate=0.07
	RecoilMaxYawLimit=460
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=700 //900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=100
	RecoilISMinPitchLimit=65485
	IronSightMeshFOVCompensationScale=4.0

	// DEFAULT_FIREMODE
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M6C_SOCOM'
	FireInterval(DEFAULT_FIREMODE)=+0.12 //0.14
	InstantHitDamage(DEFAULT_FIREMODE)=50 //42
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M6C_SOCOM'
	Spread(DEFAULT_FIREMODE)=0.01 //0.012
	PenetrationPower(DEFAULT_FIREMODE)=0.0 //2.0
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None


	// BASH_FIREMODE
	InstantHitDamage(BASH_FIREMODE)=23
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M6C_SOCOM'

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M6C-SOCOM.Audio.Play_Fire_3P', FirstPersonCue=AkEvent'M6C-SOCOM.Audio.Play_Fire_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M392.Audio.Play_M392_Dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false
	bHasLaserSight=true //true

	bWarnAIWhenAiming = false;

	// Inventory
	InventorySize=3 //3
	GroupPriority=59
	InventoryGroup=IG_Primary
	bCanThrow=true
	bDropOnDeath=true
	WeaponSelectTexture=Texture2D'M6C-SOCOM.Textures.M6S_UI_v1'
	bIsBackupWeapon=false
	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'
	AssociatedPerkClasses(1)=class'KFPerk_SWAT'

	// Custom animations
	FireSightedAnims=(Shoot_Iron, Shoot_Iron2, Shoot_Iron3)
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2, Guncheck_v3, Guncheck_v4)

	bHasFireLastAnims=true
	BonesToLockOnEmpty=(RW_Bolt, RW_Bullets1)

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Medium_Recoil'

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.1f)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.25f), (Stat=EWUS_Weight, Add=1)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.4f), (Stat=EWUS_Weight, Add=2)))

	UIBackgrounds[0] = Texture2D'Shared.UI.Basic_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'Shared.UI.Basic_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'Shared.UI.Basic_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'Shared.UI.Basic_Reticle_Background_v2'
	UIBackgrounds[4] = Texture2D'Shared.UI.Basic_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'Shared.UI.Basic_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'Shared.UI.Basic_Reticle_Background_32_9_v2'

	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=0, V=0, UL=128, VL=128)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=129, V=0, UL=128, VL=128)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=258, V=0, UL=128, VL=128)
	Reticle_Headshot = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=387, V=0, UL=128, VL=128)

	ZoomCanvasIcon = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=0, V=129, UL=162, VL=129)
}