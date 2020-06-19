//=============================================================================
// KFWeap_Pistol_M6CDual
//=============================================================================
// Two M6C Pistols from Halo
//=============================================================================

class KFWeap_Pistol_M6CDual extends KFWeap_DualBase;

defaultproperties
{
    // FOV
	MeshFOV=75 //86
	MeshIronSightFOV=55 //77
    PlayerIronSightFOV=77

	// Depth of field
	DOF_FG_FocalRadius=38
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	FireOffset=(X=17,Y=4.0,Z=-2.25)
	LeftFireOffset=(X=17,Y=-4,Z=-2.25)

	// Zooming/Position
	IronSightPosition=(X=7,Y=0,Z=0)
	PlayerViewOffset=(X=14,Y=0,Z=-5)
	QuickWeaponDownRotation=(Pitch=-8192,Yaw=0,Roll=0)

	// Content
	PackageKey="M6CDual"
	FirstPersonMeshName="M6C.Mesh.Wep_1stP_Dual_M6C_Rig"
	FirstPersonAnimSetNames(0)="M6C.Anims_Dual.Wep_1stP_Dual_M6C_Anim"
	PickupMeshName="M6C.Mesh.Wep_M6C_Pickup"
	AttachmentArchetypeName="M6C.Archetypes.Wep_Dual_M6C_3P"
	MuzzleFlashTemplateName="WEP_Dual_Deagle_ARCH.Wep_Dual_Deagle_MuzzleFlash"

	SingleClass=class'KFWeap_Pistol_M6C'

	// Ammo
	MagazineCapacity[0]=16
	SpareAmmoCapacity[0]=160
	InitialSpareMags[0]=2
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=275 //250
	minRecoilPitch=225 //200
	maxRecoilYaw=75 //100
	minRecoilYaw=-75 //-100
	RecoilRate=0.07 //0.07
	RecoilMaxYawLimit=485 //500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=915 //900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=50 //50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=250 //250
	RecoilISMinPitchLimit=65485
	IronSightMeshFOVCompensationScale=2.0

	// DEFAULT_FIREMODE
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M6C'
	FireInterval(DEFAULT_FIREMODE)=+0.11
	InstantHitDamage(DEFAULT_FIREMODE)=40.0 //30
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M6C'
	PenetrationPower(DEFAULT_FIREMODE)=0.0
	Spread(DEFAULT_FIREMODE)=0.01

	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_M6C'
	FireInterval(ALTFIRE_FIREMODE)=+0.11
	InstantHitDamage(ALTFIRE_FIREMODE)=40.0 //30
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_M6C'
	PenetrationPower(ALTFIRE_FIREMODE)=0.0
	Spread(ALTFIRE_FIREMODE)=0.01

	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M6C'
	InstantHitDamage(BASH_FIREMODE)=26

	//Fire Effects
	//TODO: Replace fire sound effects with custom M6D sounds.
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M6C.Audio.Play_WEP_M6C_Fire_3P', FirstPersonCue=AkEvent'M6C.Audio.Play_WEP_M6C_Fire_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M392.Audio.Play_M392_Dryfire'

	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'M6C.Audio.Play_WEP_M6C_Fire_3P', FirstPersonCue=AkEvent'M6C.Audio.Play_WEP_M6C_Fire_1P')
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'M392.Audio.Play_M392_Dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=none

	// Inventory
	InventorySize=2
	GroupPriority=22
	bCanThrow=true
	InventoryGroup=IG_Secondary
	bDropOnDeath=true
	WeaponSelectTexture=Texture2D'M6C.Textures.Dual_M6C_UI_v1'
	bIsBackupWeapon=true

	bHasFireLastAnims=true

	BonesToLockOnEmpty=(RW_Bolt, RW_Bullets1)
    BonesToLockOnEmpty_L=(LW_Bolt, LW_Bullets1) //TODO: Rig the actual bullets

	//Weapon Upgrade stat boosts. Setting weight to 0 because single 9MM cannot be sold.
	//WeaponUpgrades[1]=(IncrementDamage=1.2f,IncrementWeight=0)
	//WeaponUpgrades[2]=(IncrementDamage=1.4f,IncrementWeight=0) //1
	//WeaponUpgrades[3]=(IncrementDamage=1.6f,IncrementWeight=0) //1
	//WeaponUpgrades[4]=(IncrementDamage=1.8f,IncrementWeight=0) //2
	//WeaponUpgrades[5]=(IncrementDamage=2.0f,IncrementWeight=0) //3

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.2f), (Stat=EWUS_Damage1, Scale=1.2f)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.4f), (Stat=EWUS_Damage1, Scale=1.4f)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.5f), (Stat=EWUS_Damage1, Scale=1.5f)))

}