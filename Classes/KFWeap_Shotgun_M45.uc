//=============================================================================
// Base File: KFWeap_Shotgun_MB500
//=============================================================================
// An M45 Shotgun
//=============================================================================
// Gear Shift Gaming 6/16/2019
//=============================================================================
class KFWeap_Shotgun_M45 extends KFWeap_ShotgunBase;

defaultproperties
{
	// Inventory
	InventorySize=6
	GroupPriority=75
	WeaponSelectTexture=Texture2D'M45.Textures.M45_UI_v1'

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
	PackageKey="M45"
	FirstPersonMeshName="M45.Mesh.Wep_1stP_M45_Rig"
	FirstPersonAnimSetNames(0)="M45.1stp_anims.Wep_1st_M45_Anim"
	PickupMeshName="M45.Mesh.M45_Pickup"
	AttachmentArchetypeName="M45.Archetype.Wep_M45_3P"
	MuzzleFlashTemplateName="M45.Archetype.Wep_M45_MuzzleFlash"

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)="ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle"
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(DEFAULT_FIREMODE)=35.0 //33
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M45'
	PenetrationPower(DEFAULT_FIREMODE)=3.0 //2
	FireInterval(DEFAULT_FIREMODE)=0.9 //0.85
	Spread(DEFAULT_FIREMODE)=0.08 //0.7
	FireOffset=(X=30,Y=3,Z=-3)
	NumPellets(DEFAULT_FIREMODE)=10

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M45'
	InstantHitDamage(BASH_FIREMODE)=25

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'Shared.Audio.Play_Fire_3P_Shotgun', FirstPersonCue=AkEvent'Shared.Audio.Play_Fire_1P_Shotgun')

    // using M4 dry fire sound. this is intentional.
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_M4.Play_WEP_SA_M4_Handling_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=true

	// Ammo
	MagazineCapacity[0]=6
	SpareAmmoCapacity[0]=42 //36
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

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.05f), (Stat=EWUS_Weight, Add=1))) //Scale=1.1
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Weight, Add=2))) //Scale=1.2
}