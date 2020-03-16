//=============================================================================
// Base File: KFWeap_Bullpup
//=============================================================================
// An M392 DMR
//=============================================================================
// Gear Shift Gaming 3/14/2020
//=============================================================================

class KFWeap_AssaultRifle_M392 extends KFWeap_RifleBase;

//3 is right display
//4 is left display

var KFPlayerController KFPC;
var Standard_Ammo_Display M392_Display;

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	Super.PlayWeaponEquip( ModifiedEquipTime );
	if(KFPC == None )
	{
		KFPC = KFPlayerController(Instigator.Controller);
	}

	if(M392_Display == none)
	{
		M392_Display = New class'Standard_Ammo_Display';
	}

	M392_Display.InitializeDisplay(KFPC, 4, 3, 0.67, 0.334);
	M392_Display.RunDisplay(Mesh);
}

simulated function ConsumeAmmo( byte FireModeNum )
{
	super.ConsumeAmmo( FireModeNum );
	M392_UpdateDisplay();
}

simulated state Reloading
{
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		M392_UpdateDisplay();
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		M392_UpdateDisplay();
	}
}

reliable client function M392_UpdateDisplay()
{
	M392_Display.RunDisplay(Mesh);
}

defaultproperties
{
	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
    MeshFOV=60
	MeshIronSightFOV=52
    PlayerIronSightFOV=70

	// Depth of field
	DOF_FG_FocalRadius=85
	DOF_FG_MaxNearBlurSize=2.5

	// Content
	PackageKey="M392"
	FirstPersonMeshName="M392.Mesh.Wep_1stP_M392_Rig"
	FirstPersonAnimSetNames(0)="M392.1stp_anims.Wep_1st_M392_Anim" //"WEP_1P_L85A2_ANIM.Wep_1st_L85A2_Anim"
	PickupMeshName="WEP_3P_L85A2_MESH.Wep_L85A2_Pickup"
	AttachmentArchetypeName="WEP_L85A2_ARCH.Wep_L85A2_3P"
	MuzzleFlashTemplateName="WEP_L85A2_ARCH.Wep_L85A2_MuzzleFlash"

   	// Zooming/Position
	PlayerViewOffset=(X=6.5,Y=8.7,Z=-1.5) //(X=3.0,Y=9,Z=-3)
	IronSightPosition=(X=0,Y=0,Z=0)

	// Ammo
	MagazineCapacity[0]=15
	SpareAmmoCapacity[0]=90
	InitialSpareMags[0]=1
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=150
	minRecoilPitch=115
	maxRecoilYaw=115
	minRecoilYaw=-115
	RecoilRate=0.085
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=75
	RecoilISMinYawLimit=65460
	RecoilISMaxPitchLimit=375
	RecoilISMinPitchLimit=65460
	RecoilViewRotationScale=0.25
	IronSightMeshFOVCompensationScale=1.5
    HippedRecoilModifier=1.5

    // Inventory / Grouping
	InventorySize=6
	GroupPriority=50
	WeaponSelectTexture=Texture2D'ui_weaponselect_tex.UI_WeaponSelect_Bullpup'
   	AssociatedPerkClasses(0)=class'KFPerk_Commando'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M392'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M392'
	FireInterval(DEFAULT_FIREMODE)=+0.0909 // 660 RPM
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=30.0 //25
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M392'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_L85A2.Play_WEP_SA_L85A2_Fire_Single_M', FirstPersonCue=AkEvent'WW_WEP_SA_L85A2.Play_WEP_SA_L85A2_Fire_Single_S')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_L85A2.Play_WEP_SA_L85A2_Handling_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	//Custom Animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	// Weapon Upgrade stat boosts
	//WeaponUpgrades[1]=(IncrementDamage=1.3f,IncrementWeight=1)
	//WeaponUpgrades[2]=(IncrementDamage=1.65f,IncrementWeight=2)
	//WeaponUpgrades[3]=(IncrementDamage=1.85f,IncrementWeight=3)

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.3f), (Stat=EWUS_Damage1, Scale=1.3f), (Stat=EWUS_Weight, Add=1)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.65f), (Stat=EWUS_Damage1, Scale=1.65f), (Stat=EWUS_Weight, Add=2)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.85f), (Stat=EWUS_Damage1, Scale=1.85f), (Stat=EWUS_Weight, Add=3)))
}


