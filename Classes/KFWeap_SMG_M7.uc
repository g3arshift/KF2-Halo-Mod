//=============================================================================
// Base File: KFWeap_SMG_P90
//=============================================================================
// Gear Shift Gaming 9/17/2019
//=============================================================================

class KFWeap_SMG_M7 extends KFWeap_SMGBase;

defaultproperties
{
	// Inventory
	InventorySize=3
	GroupPriority=61
	WeaponSelectTexture=Texture2D'M7.Textures.M7T_UI_v1'

	// FOV
	MeshFOV=80 //80
	MeshIronSightFOV=55
	PlayerIronSightFOV=65

	//Zooming/Position
	IronSightPosition=(X=-5.f,Y=0.1f,Z=2.2f) //X is back and forth, y is side to size, Z is up and down.
	PlayerViewOffset=(X=15,Y=10,Z=-0.5) //x=19 y=10 z=-0.5

	//Content
	PackageKey="M7"
	FirstPersonMeshName="M7.Mesh.Wep_1stP_M7_Rig"
	FirstPersonAnimSetNames(0)="M7.1stp_anims.Wep_1stP_M7_Anim"
	PickupMeshName="M7.Mesh.M7T_Static"
	AttachmentArchetypeName="M7.Archetypes.Wep_M7_3P"
	MuzzleFlashTemplateName="wep_p90_arch.Wep_P90_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=60
	SpareAmmoCapacity[0]=360
	InitialSpareMags[0]=2
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=120 //80
	minRecoilPitch=90 //60
	maxRecoilYaw=80 //65
	minRecoilYaw=-65 //-60
	RecoilRate=0.05 //0.06
	RecoilMaxYawLimit=600
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=600 //675
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=100 //80
	RecoilISMinYawLimit=65460
	RecoilISMaxPitchLimit=375
	RecoilISMinPitchLimit=65460
	IronSightMeshFOVCompensationScale=1.5

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M7'
	FireInterval(DEFAULT_FIREMODE)=+.066 // 1000 RPM
	Spread(DEFAULT_FIREMODE)=0.02
	InstantHitDamage(DEFAULT_FIREMODE)=22
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M7'
	InstantHitDamage(BASH_FIREMODE)=23

	//Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7.Audio.Play_M7_Fire_3P_Loop', FirstPersonCue=AkEvent'M7.Audio.Play_M7_Fire_1P_Loop')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'M7.Audio.Play_M7_Fire_3P_Single', FirstPersonCue=AkEvent'M7.Audio.Play_M7_Fire_1P_Single')
	WeaponFireLoopEndSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7.Audio.Play_M7_Fire_3P_EndLoop', FirstPersonCue=AkEvent'M7.Audio.Play_M7_Fire_1P_EndLoop')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'

	// Advanced (High RPM) Fire Effects.
	
	bLoopingFireAnim(DEFAULT_FIREMODE)=true
	bLoopingFireSnd(DEFAULT_FIREMODE)=true
	SingleFireSoundIndex=ALTFIRE_FIREMODE
	
	// Attachments
	bHasIronSights=true
	bHasFlashlight=true

	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	AssociatedPerkClasses(0)=class'KFPerk_Swat'

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Damage1, Scale=1.2f), (Stat=EWUS_Weight, Add=1)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.35f), (Stat=EWUS_Damage1, Scale=1.4f), (Stat=EWUS_Weight, Add=2)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.55f), (Stat=EWUS_Damage1, Scale=1.6f), (Stat=EWUS_Weight, Add=3)))
}
