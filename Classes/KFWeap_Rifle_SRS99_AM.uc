//=============================================================================
// Base File: KFWeap_AssaultRifle_FNFal
//=============================================================================
//
//=============================================================================
// Gear Shift Gaming 3/6/2020
//=============================================================================

class KFWeap_Rifle_SRS99_AM extends KFWeap_RifleBase;

defaultproperties
{
	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
	MeshFOV=60
	MeshIronSightFOV=50
    PlayerIronSightFOV=70

	// Depth of field
	DOF_BlendInSpeed=3.0	
	DOF_FG_FocalRadius=0//70
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	IronSightPosition=(X=15,Y=0,Z=0) //(X=15,Y=0,Z=0)
	PlayerViewOffset=(X=17.0,Y=11,Z=-3.0) //(X=22.0,Y=11,Z=-3.0)

	// Content
	PackageKey="SRS99-AM"
	FirstPersonMeshName="SRS99_AM.Mesh.WEP_1stP_SRS99_AM_Rig"
	FirstPersonAnimSetNames(0)="WEP_1P_FNFAL_ANIM.Wep_1stP_FNFAL_Anim"
	PickupMeshName="WEP_3P_FNFAL_MESH.WEP_3rdP_FNFAL_Pickup"
	AttachmentArchetypeName="WEP_FNFAL_ARCH.Wep_FNFAL_3P"
	MuzzleFlashTemplateName="WEP_FNFAL_ARCH.Wep_FNFAL_MuzzleFlash" //NEED To REPLACE

	// Ammo
	MagazineCapacity[0]=20
	SpareAmmoCapacity[0]=160
	InitialSpareMags[0]=3
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=200 //185
	minRecoilPitch=165 //150
	maxRecoilYaw=190 //175
	minRecoilYaw=-165 //-150
	RecoilRate=0.09
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=150
	RecoilISMinYawLimit=65385
	RecoilISMaxPitchLimit=375
	RecoilISMinPitchLimit=65460
	RecoilViewRotationScale=0.6
	HippedRecoilModifier=1.5 //1.25

	// Inventory
	InventorySize=8
	GroupPriority=100
	WeaponSelectTexture=Texture2D'WEP_UI_FNFAL_TEX.UI_WeaponSelect_FNFAL'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_SRS99_AM'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_SRS99_AM'
	FireInterval(DEFAULT_FIREMODE)=+0.099 // 700 RPM 0.0857
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	Spread(DEFAULT_FIREMODE)=0.007
	InstantHitDamage(DEFAULT_FIREMODE)=70.0 //50

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	FireOffset=(X=30,Y=4.5,Z=-5)

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_SRS99_AM'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_FNFAL.Play_WEP_FNFAL_Fire_3P_Loop', FirstPersonCue=AkEvent'WW_WEP_FNFAL.Play_WEP_FNFAL_Fire_1P_Loop')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_FNFAL.Play_WEP_FNFAL_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'
}
