//=============================================================================
// KFWeap_Pistol_M6C
//=============================================================================
// An M6C Pistol from Halo
//=============================================================================

class KFWeap_Pistol_M6C extends KFWeap_PistolBase;

defaultproperties
{
    // FOV
	MeshFOV=75 //86
	MeshIronSightFOV=55 //60
    PlayerIronSightFOV=77

	// Depth of field
	DOF_FG_FocalRadius=38
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=20.0,Y=10,Z=-6) //y=12 //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	IronSightPosition=(X=10,Y=0,Z=0)

	// Content
	PackageKey="M6C"
	FirstPersonMeshName="M6C.Mesh.Wep_1stP_M6C_Rig"
	FirstPersonAnimSetNames(0)="M6C.Anims.Wep_1stP_M6C_Anim"
	PickupMeshName="M6C.Mesh.Wep_M6C_Pickup"
	AttachmentArchetypeName="M6C.Archetypes.Wep_M6C_3P"
	MuzzleFlashTemplateName="M6C.Archetypes.Wep_M6C_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=8
	SpareAmmoCapacity[0]=160
	InitialSpareMags[0]=4
	AmmoPickupScale[0]=2.0
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
	FireInterval(DEFAULT_FIREMODE)=+0.22
	InstantHitDamage(DEFAULT_FIREMODE)=40.0
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M6C'
	PenetrationPower(DEFAULT_FIREMODE)=0.0
	Spread(DEFAULT_FIREMODE)=0.01
	FireOffset=(X=20,Y=4.0,Z=-3)

	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M6C'
	InstantHitDamage(BASH_FIREMODE)=20

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M6C.Audio.Play_WEP_M6C_Fire_3P', FirstPersonCue=AkEvent'M6C.Audio.Play_WEP_M6C_Fire_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M392.Audio.Play_M392_Dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=none

	// Inventory
	InventorySize=0
	GroupPriority=12
	bCanThrow=true
	bDropOnDeath=true
	WeaponSelectTexture=Texture2D'M6C.Textures.M6C_UI_v1'
	bIsBackupWeapon=true

	DualClass=class'KFWeap_Pistol_M6CDual'

	// Custom animations
	FireSightedAnims=(Shoot_Iron, Shoot_Iron2, Shoot_Iron3)
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v3, Guncheck_v4, Guncheck_v6)

	bHasFireLastAnims=true

	BonesToLockOnEmpty=(RW_Bolt, RW_Bullets1) //TODO: Rig the actual bullets

	// Weapon Upgrade stat boosts. Setting weight to 0 because single 9MM cannot be sold.
	//WeaponUpgrades[1]=(IncrementDamage=1.2f,IncrementWeight=0)
	//WeaponUpgrades[2]=(IncrementDamage=1.4f,IncrementWeight=0) //1
	//WeaponUpgrades[3]=(IncrementDamage=1.6f,IncrementWeight=0) //1
	//WeaponUpgrades[4]=(IncrementDamage=1.8f,IncrementWeight=0) //2
	//WeaponUpgrades[5]=(IncrementDamage=2.0f,IncrementWeight=0) //3

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.2f)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.4f)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.50168f)))
}