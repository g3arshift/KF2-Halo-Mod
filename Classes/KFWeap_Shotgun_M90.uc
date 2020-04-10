//=============================================================================
// Base File: KFWeap_Shotgun_MB500
//=============================================================================
// An M90 Close Assault Weapon System Shotgun
//=============================================================================
// Gear Shift Gaming 6/13/2019
//=============================================================================
class KFWeap_Shotgun_M90 extends KFWeap_ShotgunBase;

var protected const array<vector2D> PelletSpread;

 /** Same as AddSpread(), but used with MultiShotSpread */
static function rotator AddMultiShotSpread( rotator BaseAim, float CurrentSpread, byte PelletNum )
{
	local vector X, Y, Z;
	local float RandY, RandZ;

	if (CurrentSpread == 0)
	{
		return BaseAim;
	}
	else
	{
		// Add in any spread.
		GetAxes(BaseAim, X, Y, Z);
		RandY = default.PelletSpread[PelletNum].Y * RandRange( 0.5f, 1.5f );
		RandZ = default.PelletSpread[PelletNum].X * RandRange( 0.5f, 1.5f );
		return rotator(X + RandY * CurrentSpread * Y + RandZ * CurrentSpread * Z);
	}
}

defaultproperties
{
	// Inventory
	InventorySize=10 //7
	GroupPriority=120
	WeaponSelectTexture=Texture2D'M90_CAWS.Textures.M90_CAWS_UI_v1'

    // FOV
	MeshIronSightFOV=45
    PlayerIronSightFOV=70

	// Depth of field
	DOF_FG_FocalRadius=95
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=8.0,Y=10.0,Z=-3.5)
	IronSightPosition=(X=4,Y=0.6,Z=-0.75)

	// Content
	PackageKey="M90_CAWS"
	FirstPersonMeshName="M90_CAWS.Mesh.Wep_1stP_M90_Rig"
	FirstPersonAnimSetNames(0)="M90_CAWS.1stp_anims.Wep_1st_M90_Anim"
	PickupMeshName="M90_CAWS.Mesh.M90_CAWS_Static"
	AttachmentArchetypeName="M90_CAWS.Archetype.Wep_M90_3P"
	MuzzleFlashTemplateName="M90_CAWS.Archetype.Wep_M90_MuzzleFlash"

	PelletSpread(0)=(X=0.0f,Y=0.0f)
	PelletSpread(1)=(X=0.5f,Y=0.15f) 			//0deg 
	PelletSpread(2)=(X=0.3214,Y=0.3830) 	//60deg
	PelletSpread(3)=(X=-0.25,Y=0.4330)		//120deg
	PelletSpread(4)=(X=-0.5f,Y=0.1f)			// Almost 180deg
	PelletSpread(5)=(X=-0.25f,Y=-0.4330)	//240deg
	PelletSpread(6)=(X=0.25,Y=-0.4330)		//300deg
	PelletSpread(7)=(X=0.1f,Y=0.2f)
	PelletSpread(8)=(X=0.8f,Y=0.766f)
	PelletSpread(9)=(X=0.4428,Y=0.966)
	PelletSpread(10)=(X=-0.3,Y=1.0660)
	PelletSpread(11)=(X=-1.1f,Y=-0.9f)
	PelletSpread(12)=(X=-0.6f,Y=-0.7660)
	PelletSpread(13)=(X=0.6,Y=-0.7660)
	PelletSpread(14)=(X=1.1f,Y=0.9f)

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)="ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle"
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(DEFAULT_FIREMODE)=45.0 //43
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M90'
	PenetrationPower(DEFAULT_FIREMODE)=1.0 //2.0 //2
	FireInterval(DEFAULT_FIREMODE)=0.9
	FireOffset=(X=30,Y=3,Z=-3)
	Spread(DEFAULT_FIREMODE)=0.1f
	NumPellets(DEFAULT_FIREMODE)=15

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M90'
	InstantHitDamage(BASH_FIREMODE)=30

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'Shared.Audio.Play_Fire_3P_Shotgun', FirstPersonCue=AkEvent'Shared.Audio.Play_Fire_1P_Shotgun')

    // using M4 dry fire sound. this is intentional.
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_M4.Play_WEP_SA_M4_Handling_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=true

	// Ammo
	MagazineCapacity[0]=12
	SpareAmmoCapacity[0]=60 //72 //48
	InitialSpareMags[0]=2
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

	// Weapon Upgrade stat boosts
	//WeaponUpgrades[1]=(IncrementDamage=1.25f,IncrementWeight=1)
	//WeaponUpgrades[2]=(IncrementDamage=1.5f,IncrementWeight=2)
	//WeaponUpgrades[3]=(IncrementDamage=1.75f,IncrementWeight=3)
	//WeaponUpgrades[4]=(IncrementDamage=2.0f,IncrementWeight=4)


	//WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.25f), (Stat=EWUS_Weight, Add=1)))
	//WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.5f), (Stat=EWUS_Weight, Add=2)))
	//WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.75f), (Stat=EWUS_Weight, Add=3)))
	//WeaponUpgrades[4]=(Stats=((Stat=EWUS_Damage0, Scale=2.0f), (Stat=EWUS_Weight, Add=4)))
}