//=============================================================================
// Base File: KFWeap_RocketLauncher_RPG7
//=============================================================================
// A heatseeking rocket launcher that can fire two big rockets back to back
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================
class KFWeap_RocketLauncher_M41 extends KFWeap_GrenadeLauncher_Base;

defaultproperties
{
	ForceReloadTime=0.4f

	// Inventory
	InventoryGroup=IG_Primary
	GroupPriority=100
	InventorySize=9 //10
	WeaponSelectTexture=Texture2D'WEP_UI_RPG7_TEX.UI_WeaponSelect_RPG7'

    // FOV
	MeshFOV=70
	MeshIronSightFOV=65
	PlayerIronSightFOV=70

	// Depth of field
	DOF_FG_FocalRadius=50
	DOF_FG_MaxNearBlurSize=2.5

	// Zooming/Position
	PlayerViewOffset=(X=22.0,Y=7.8,Z=7.5) //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	FastZoomOutTime=0.2

	// Content
	PackageKey="M41"
	FirstPersonMeshName="M41.Mesh.Wep_1stP_M41_Rig"
	FirstPersonAnimSetNames(0)="M41.1stp_anims.Wep_1stP_M41_Anim"
	PickupMeshName="WEP_3P_RPG7_MESH.Wep_rpg7_Pickup"
	AttachmentArchetypeName="WEP_RPG7_ARCH.Wep_RPG7_3P"
	MuzzleFlashTemplateName="WEP_RPG7_ARCH.Wep_RPG7_MuzzleFlash"

   	// Zooming/Position
	IronSightPosition=(X=0,Y=0,Z=0)

	// Ammo
	MagazineCapacity[0]=2
	SpareAmmoCapacity[0]=15
	InitialSpareMags[0]=4
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

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
	HippedRecoilModifier=1.25

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'UI_FireModes_TEX.UI_FireModeSelect_Rocket'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSinglefiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Rocket_RPG7'
	FireInterval(DEFAULT_FIREMODE)=+1.0
	InstantHitDamage(DEFAULT_FIREMODE)=150.0
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_RPG7Impact'
	Spread(DEFAULT_FIREMODE)=0.025
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_RPG7'
	InstantHitDamage(BASH_FIREMODE)=29

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_RPG7.Play_WEP_SA_RPG7_Fire_3P', FirstPersonCue=AkEvent'WW_WEP_SA_RPG7.Play_WEP_SA_RPG7_Fire_1P')

	//@todo: add akevent when we have it
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_RPG7.Play_WEP_SA_RPG7_DryFire'

	// Animation
	bHasFireLastAnims=true
	IdleFidgetAnims=(Guncheck_v1)

	BonesToLockOnEmpty=(RW_Grenade1)
	MeleeAttackAnims=(Bash, Bash_2)

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=class'KFPerk_Demolitionist'

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'

	// Weapon Upgrade stat boosts
	//WeaponUpgrades[1]=(IncrementDamage=1.1f,IncrementWeight=1)

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.1f), (Stat=EWUS_Weight, Add=1)))
}
