//=============================================================================
// Base File: KFWeap_Shotgun_M45
//=============================================================================
// An M45 Shotgun
//=============================================================================
// Gear Shift Gaming 6/19/2019
//=============================================================================
class KFWeap_Shotgun_M45_BrashWhisper extends KFWeap_ShotgunBase;

defaultproperties
{
	// Inventory
	InventorySize=11
	GroupPriority=75
	WeaponSelectTexture=Texture2D'M45_BrashWhisper.Textures.M45_BrashWhisper_UI_v1'

    // FOV
	MeshIronSightFOV=45
    PlayerIronSightFOV=70

	// Depth of field
	DOF_FG_FocalRadius=95
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=8.0,Y=10.0,Z=-3.5)
	IronSightPosition=(X=4,Y=0.7,Z=-2.8)
	//X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.

	// Content
	PackageKey="M45_BrashWhisper"
	FirstPersonMeshName="M45_BrashWhisper.Mesh.Wep_1stP_M45_BrashWhisper_Rig"
	FirstPersonAnimSetNames(0)="M45_BrashWhisper.1stp_anims.Wep_1st_M45_BrashWhisper_Anim"
	PickupMeshName="M45_BrashWhisper.Mesh.M45_BrashWhisper_Pickup"
	AttachmentArchetypeName="M45_BrashWhisper.Archetype.Wep_M45_BrashWhisper_3P"
	MuzzleFlashTemplateName="M45.Archetype.Wep_M45_MuzzleFlash"

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)="ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle"
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet_M45_BrashWhisper'
	InstantHitDamage(DEFAULT_FIREMODE)=50
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_SubMunition_Impact_M45_BrashWhisper'
	PenetrationPower(DEFAULT_FIREMODE)=3.0
	FireInterval(DEFAULT_FIREMODE)=0.75
	FireOffset=(X=30,Y=3,Z=-3)
	Spread(DEFAULT_FIREMODE)=0.30 //0.25
	NumPellets(DEFAULT_FIREMODE)=15

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M45_BrashWhisper'
	InstantHitDamage(BASH_FIREMODE)=25

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'Shared.Audio.Play_Fire_3P_Shotgun', FirstPersonCue=AkEvent'Shared.Audio.Play_Fire_1P_Shotgun')

    // using M4 dry fire sound. this is intentional.
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_M4.Play_WEP_SA_M4_Handling_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=true

	// Ammo
	MagazineCapacity[0]=8
	SpareAmmoCapacity[0]=56
	InitialSpareMags[0]=3
	bCanBeReloaded=true
	bReloadFromMagazine=false

	// Recoil
	maxRecoilPitch=900
	minRecoilPitch=775
	maxRecoilYaw=500
	minRecoilYaw=-500
	RecoilRate=0.085
	RecoilBlendOutRatio=0.35
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
	HippedRecoilModifier=1.30 //1.25

	AssociatedPerkClasses(0)=class'KFPerk_Support'
	AssociatedPerkClasses(1)=class'KFPerk_Demolitionist'

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'
}