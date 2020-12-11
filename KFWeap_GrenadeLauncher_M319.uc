//=============================================================================
// Base File: KFWeap_GrenadeLauncher_M79
//=============================================================================
// An M319 IGL Grenade Launcher
//=============================================================================
// Gear Shift Gaming 6/28/2019
//=============================================================================

class KFWeap_GrenadeLauncher_M319 extends KFWeap_GrenadeLauncher_Base;

var KFProj_ControlledExplosive_M319 LiveGrenade;
var KFProj_HighExplosive_M319 LiveGrenade_H;
var KFPlayerController KFPC;
var KFPerk InstigatorPerk;
var bool bNeedsLinking;

var array<MaterialInstanceConstant> DisplaySkull;
var array<MaterialInstanceConstant> DisplayBackplate;
var array<MaterialInstanceConstant> DisplayRangeDigits_Safe;
var array<MaterialInstanceConstant> DisplayRangeDigits_DangerClose;
var array<MaterialInstanceConstant> DisplayStatus_Safe;
var array<MaterialInstanceConstant> DisplayStatus_DangerClose;
var array<MaterialInstanceConstant> DisplayDecoration;
var array<MaterialInstanceConstant> GrenadeStatusLight;

var int ZedCount_InExplosionRadius;
var float ExplosiveRadius;

replication
{
	if (bNetDirty)
	LiveGrenade_H, LiveGrenade;
}

enum M319_MatSlot
{
	ZedCount_LeftDigit,
	MainBody,
	ZedCount_Skull,
	Range_MiddleDigit,
	StatusLight,
	GrenadeStatus,
	Range_LeftDigit,
	DisplayDecoration,
	Range_RightDigit,
	DisplayBackground,
	Decals,
	ZedCount_RightDigit
};

/*********************************************************************************************
 * State FireAndDetonate
 * The weapon is in this state while detonating a controlled explosive grenade
*********************************************************************************************/
simulated state FireAndDetonate extends WeaponSingleFiring
{
	simulated function KFProjectile SpawnProjectile( class<KFProjectile> KFProjClass, vector RealStartLoc, vector AimDir )
	{
		LiveGrenade = KFProj_ControlledExplosive_M319(super.SpawnProjectile( KFProjClass, RealStartLoc, AimDir ));

		bNeedsLinking = true;
		if(!IsTimerActive('LinkingTimer'))
		{
			SetTimer(0.5, false, 'LinkingTimer');
		}

		if(KFPC == none)
		{
			KFPC = KFPlayerController(Instigator.Controller);
		}

		return LiveGrenade;
	}
}

function LinkingTimer()
{
	return;
	//This is only here to stop logging errors.
}

/*********************************************************************************************
 * State WeaponSingleFireAndReload
 * The weapon is in this state while detonating a high explosive grenade
*********************************************************************************************/
simulated state M319_WeaponSingleFireAndReload extends WeaponSingleFireAndReload
{
	simulated function KFProjectile SpawnProjectile( class<KFProjectile> KFProjClass, vector RealStartLoc, vector AimDir )
	{
		LiveGrenade_H = KFProj_HighExplosive_M319(super.SpawnProjectile( KFProjClass, RealStartLoc, AimDir ));

		if(KFPC == none)
		{
			KFPC = KFPlayerController(Instigator.Controller);
		}

		return LiveGrenade_H;
	}
}

//Prevents a grenade from staying around when you switch weapons.
simulated function PutDownWeapon()
{
	super.PutDownWeapon();
	if (LiveGrenade != None && !LiveGrenade.bHasExploded && !LiveGrenade.bHasDisintegrated &&  Role == ROLE_Authority)
	{
		LiveGrenade.TriggerExplosion(LiveGrenade.Location, vect(0,0,1), None);
		LiveGrenade = None;
	}
}

simulated function EndFire(byte FireModeNum)
{
	super.EndFire(FireModeNum);

	if( Role == ROLE_Authority )
	{
		if (LiveGrenade != None && !LiveGrenade.bHasExploded && !LiveGrenade.bHasDisintegrated &&  Role == ROLE_Authority && FireModeNum != 3) //The last arg prevents an explosion if we are bashing.
		{
			//`log("OUT OF FUN. Explosive radius is: "$LiveGrenade.ExplosionTemplate.DamageRadius);
			SetTimer(0.85, false, 'GrenadeExplodedTimer');
			LiveGrenade.SetGrenadeExplodeTimer(0.001);		
		}
	}
	else
	{
		`log("M319 End Fire Role Check Failure.");
	}

	if(LiveGrenade_H != None && LiveGrenade_H.bHasExploded && LiveGrenade_H.bHasDisintegrated && Role == ROLE_Authority)
	{
		LiveGrenade_H = None;
	}

	ClearPendingFire(FireModeNum);
}

function GrenadeExplodedTimer()
{
	return;
	//This is only here to stop logging errors.
}

simulated event Tick( float DeltaTime )
{

	super.Tick(DeltaTime);
	if( LiveGrenade != none || LiveGrenade_H != none)
	{
		UpdateDisplay();
	}
	else
	{
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_Safe[0]);

		Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[0] );
		Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplaySkull[0]);
		Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplaySkull[0]);

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[0] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[0]);
		Mesh.SetMaterial( M319_MatSlot.StatusLight, GrenadeStatusLight[0]);
	}

	if( LiveGrenade_H != None && LiveGrenade_H.bHasExploded)
	{
		SetTimer(0.85, false, 'GrenadeExplodedTimer');
		LiveGrenade_H = None;
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_Safe[0]);

		Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[0] );
		Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplaySkull[0]);
		Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplaySkull[0]);

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[0] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[0]);
		Mesh.SetMaterial( M319_MatSlot.StatusLight, GrenadeStatusLight[0]);
	}

	if( LiveGrenade != None && LiveGrenade.bHasExploded)
	{
		SetTimer(0.85, false, 'GrenadeExplodedTimer');
		LiveGrenade = None;
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_Safe[0]);

		Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[0] );
		Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplaySkull[0]);
		Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplaySkull[0]);

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[0] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[0]);
		Mesh.SetMaterial( M319_MatSlot.StatusLight, GrenadeStatusLight[0]);
	}

	if(IsTimerActive('GrenadeExplodedTimer'))
	{
		Mesh.SetMaterial( M319_MatSlot.StatusLight, GrenadeStatusLight[2]);
		Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_Safe[1]);
	}
	else if(LiveGrenade == None && LiveGrenade_H == None) //!IsTimerActive('GrenadeExplodedTimer') && 
	{
		Mesh.SetMaterial( M319_MatSlot.StatusLight, GrenadeStatusLight[0]);
		Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_Safe[0]);
	}
}

reliable client function UpdateDisplay()
{

	if(KFPC == none)
	{
		KFPC = KFPlayerController(Instigator.Controller);
	}

	if(InstigatorPerk == none)
	{
		InstigatorPerk = KFPC.GetPerk();
	}

	if(LiveGrenade != none)
	{
		ExplosiveRadius = LiveGrenade.ExplosionTemplate.DamageRadius * InstigatorPerk.GetAoERadiusModifier();
		ZedCount_InExplosionRadius = LiveGrenade.CheckProx(ExplosiveRadius);
		UpdateDisplay_ControlledExplosive();
	}
	else if(LiveGrenade_H != none)
	{
		ExplosiveRadius = LiveGrenade_H.ExplosionTemplate.DamageRadius * InstigatorPerk.GetAoERadiusModifier();
		ZedCount_InExplosionRadius = LiveGrenade_H.CheckProx(ExplosiveRadius);
		UpdateDisplay_HighExplosive();
	}
	else
	{
		//`log("No Live grenade found");
	}
}

reliable client function UpdateDisplay_HighExplosive()
{
	local float DistanceFromGrenade;

	DistanceFromGrenade = Vsize(LiveGrenade_H.Location - KFPC.ViewTarget.Location);

	if( DistanceFromGrenade <= ExplosiveRadius ) //Danger Zone
	{
		//`log("DANGER! Current Damage Radius is: "$LiveGrenade_H.ExplosionTemplate.DamageRadius);

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[1] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[1]);

		if(LiveGrenade_H.bNeedsArming) //Arming
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_DangerClose[2]);
		}
		else //Armed
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_DangerClose[5]);
		}

		UpdaterangeDisplay_DangerZone(DistanceFromGrenade);
	}
	else //Safe
	{

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[0] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[0]);

		if(LiveGrenade_H.bNeedsArming) //Arming
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_Safe[2]);
		}
		else //Armed
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_Safe[5]);
		}
		
		UpdateRangeDisplay_Safe(DistanceFromGrenade);
	}
}

reliable client function UpdateDisplay_ControlledExplosive()
{
	local float DistanceFromGrenade;
	local int ZedCount_LeftDigit_Value;
	local int ZedCount_RightDigit_Value;

	Mesh.SetMaterial( M319_MatSlot.StatusLight, GrenadeStatusLight[1]);

	if(ZedCount_InExplosionRadius >= 99)
	{
		ZedCount_LeftDigit_Value = 9;
		ZedCount_RightDigit_Value = 9;
	}
	else if (ZedCount_InExplosionRadius >= 10)
	{
		ZedCount_LeftDigit_Value = int(Left(ZedCount_InExplosionRadius, 1));
		ZedCount_RightDigit_Value = int(Right(ZedCount_InExplosionRadius, 1));
	}
	else
	{
		ZedCount_LeftDigit_Value = 0;
		ZedCount_RightDigit_Value = ZedCount_InExplosionRadius;
	}

	DistanceFromGrenade = Vsize(LiveGrenade.Location - KFPC.ViewTarget.Location);

	if( DistanceFromGrenade <= ExplosiveRadius) //Danger Zone
	{
		if (ZedCount_InExplosionRadius > 0)
		{
			Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[1] );
			Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplayRangeDigits_DangerClose[ZedCount_LeftDigit_Value]);
			Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplayRangeDigits_DangerClose[ZedCount_RightDigit_Value]);
		}
		else
		{
			Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[0] );
			Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplaySkull[0] );
			Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplaySkull[0] );
		}

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[1] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[1]);

		if(bNeedsLinking)
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_DangerClose[4]);
			if(!IsTimerActive('LinkingTimer'))
			{
				bNeedsLinking = false;
			}
		}
		else
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_DangerClose[3]);
		}
		UpdaterangeDisplay_DangerZone(DistanceFromGrenade);
	}
	else //Safe
	{
		if (ZedCount_InExplosionRadius > 0)
		{
			Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[2] );
			Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplayRangeDigits_Safe[ZedCount_LeftDigit_Value]);
			Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplayRangeDigits_Safe[ZedCount_RightDigit_Value]);
		}
		else
		{
			Mesh.SetMaterial( M319_MatSlot.ZedCount_Skull, DisplaySkull[0] );
			Mesh.SetMaterial( M319_MatSlot.ZedCount_LeftDigit, DisplaySkull[0] );
			Mesh.SetMaterial( M319_MatSlot.ZedCount_RightDigit, DisplaySkull[0] );
		}

		Mesh.SetMaterial( M319_MatSlot.DisplayBackground, DisplayBackplate[0] );
		Mesh.SetMaterial( M319_MatSlot.DisplayDecoration, DisplayDecoration[0]);
		if(bNeedsLinking)
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_Safe[4]);
			if(!IsTimerActive('LinkingTimer'))
			{
				bNeedsLinking = false;
			}
		}
		else
		{
			Mesh.SetMaterial( M319_MatSlot.GrenadeStatus, DisplayStatus_Safe[3]);
		}
		UpdateRangeDisplay_Safe(DistanceFromGrenade);
	}
}

reliable client function UpdateRangeDisplay_Safe(float DistanceFromGrenade)
{
	local int LeftRangeDigit;
	local int MiddleRangeDigit;
	local int RightRangeDigit;

	LeftRangeDigit = int(Mid(DistanceFromGrenade / 100, 0, 1));
	MiddleRangeDigit= int(Mid(DistanceFromGrenade / 100, 1, 1)); 
	RightRangeDigit= int(Mid(DistanceFromGrenade / 100, 2, 1));

	if(DistanceFromGrenade /100 >= 100 )
	{
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_Safe[LeftRangeDigit]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_Safe[MiddleRangeDigit]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_Safe[RightRangeDigit]);
	}
	else if (DistanceFromGrenade /100 >= 10) 
	{
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_Safe[RightRangeDigit]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_Safe[LeftRangeDigit]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_Safe[MiddleRangeDigit]);	
	}
	else
	{
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_Safe[LeftRangeDigit]);	
	}
}

reliable client function UpdateRangeDisplay_DangerZone(float DistanceFromGrenade)
{
	local int LeftRangeDigit;
	local int MiddleRangeDigit;
	local int RightRangeDigit;

	LeftRangeDigit = int(Mid(DistanceFromGrenade / 100, 0, 1));
	MiddleRangeDigit= int(Mid(DistanceFromGrenade / 100, 1, 1)); 
	RightRangeDigit= int(Mid(DistanceFromGrenade / 100, 2, 1));

	if (DistanceFromGrenade /100 >= 10) 
	{
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_DangerClose[RightRangeDigit]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_DangerClose[LeftRangeDigit]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_DangerClose[MiddleRangeDigit]);	
	}
	else
	{
		Mesh.SetMaterial( M319_MatSlot.Range_LeftDigit, DisplayRangeDigits_DangerClose[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_MiddleDigit, DisplayRangeDigits_DangerClose[0]);
		Mesh.SetMaterial( M319_MatSlot.Range_RightDigit, DisplayRangeDigits_DangerClose[LeftRangeDigit]);	
	}
}

defaultproperties
{
	ForceReloadTime=0.3f

	// Inventory
	InventoryGroup=IG_Primary
	GroupPriority=100
	InventorySize=7
	WeaponSelectTexture=Texture2D'M319.Textures.M319_UI_v1'

	//Depth of Field
	DOF_bOverrideEnvironmentDOF=true
	DOF_SharpRadius=0
	DOF_FocalRadius=0
	DOF_MinBlurSize=0.0
	DOF_MaxNearBlurSize=0
	DOF_MaxFarBlurSize=0.0
	DOF_ExpFalloff=0
	DOF_MaxFocalDistance=0

	DOF_BlendInSpeed=0
	DOF_BlendOutSpeed=0

	DOF_FG_FocalRadius=0
	DOF_FG_SharpRadius=0
	DOF_FG_ExpFalloff=0

	// FOV
	MeshFOV=75 //80
	MeshIronSightFOV=52
	PlayerIronSightFOV=73

	// Zooming/Position
	PlayerViewOffset=(X=13.0,Y=13,Z=-4)
	IronSightPosition=(X=3,Y=0,Z=0.6)
	FastZoomOutTime=0.2

	// Content
	PackageKey="M319"
	FirstPersonMeshName="M319.Mesh.Wep_1stP_M319_Rig"
	FirstPersonAnimSetNames(0)="M319.1stp_anims.WEP_1P_M319_ANIM"
	PickupMeshName="M319.Mesh.Wep_3rdP_M319_Pickup"
	AttachmentArchetypeName="M319.Archetypes.Wep_M319_3P"
	MuzzleFlashTemplateName="WEP_M79_ARCH.Wep_M79_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=1
	SpareAmmoCapacity[0]=17 //20
	InitialSpareMags[0]=6
	AmmoPickupScale[0]=2.0
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
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'HaloPack_FireModeIcons.Timed_Explosive_FireMode_Icon' //DO NOT USE GROUPS. IT WILL ONLY PATH TO THE GROUP NAME, NOT THE FULL PATH!!!
	FiringStatesArray(DEFAULT_FIREMODE)=M319_WeaponSingleFireAndReload
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_HighExplosive_M319'
	FireInterval(DEFAULT_FIREMODE)=+0.25
	InstantHitDamage(DEFAULT_FIREMODE)=30.0 //40
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M319Impact'
	Spread(DEFAULT_FIREMODE)=0.015
	FireOffset=(X=23,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_Electricity'
	FiringStatesArray(ALTFIRE_FIREMODE)=FireAndDetonate
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_ControlledExplosive_M319'
	FireInterval(ALTFIRE_FIREMODE)=+0.25
	InstantHitDamage(ALTFIRE_FIREMODE)=30.0 //40
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_M319Impact'
	Spread(ALTFIRE_FIREMODE)=0.015

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M319'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M319.Audio.Play_Fire_3P_M319', FirstPersonCue=AkEvent'M319.Audio.Play_Fire_1P_M319')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'M319.Audio.Play_Fire_3P_M319', FirstPersonCue=AkEvent'M319.Audio.Play_Fire_1P_M319')

	//@todo: add akevent when we have it
	WeaponDryFireSnd(DEFAULT_FIREMODE)=none

	// Animation
	bHasFireLastAnims=true

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=class'KFPerk_Demolitionist'

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Weight, Add=1)))

	LiveGrenade = none
	LiveGrenade_H = none
	ZedCount_InExplosionRadius = 0;

	DisplaySkull[0] = MaterialInstanceConstant'Shared.Materials.Blank';
	DisplaySkull[1] = MaterialInstanceConstant'M319.Materials.M319_Skull';
	DisplaySkull[2] = MaterialInstanceConstant'M319.Materials.M319_Skull_Safe';

	DisplayBackplate[0] = MaterialInstanceConstant'M319.Materials.M319_Display_Safe';
	DisplayBackplate[1] = MaterialInstanceConstant'M319.Materials.M319_Display_DangerClose';

	DisplayRangeDigits_Safe[0] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_0';
	DisplayRangeDigits_Safe[1] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_1';
	DisplayRangeDigits_Safe[2] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_2';
	DisplayRangeDigits_Safe[3] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_3';
	DisplayRangeDigits_Safe[4] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_4';
	DisplayRangeDigits_Safe[5] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_5';
	DisplayRangeDigits_Safe[6] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_6';
	DisplayRangeDigits_Safe[7] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_7';
	DisplayRangeDigits_Safe[8] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_8';
	DisplayRangeDigits_Safe[9] = MaterialInstanceConstant'M319.DisplayDigits_Safe.M319_Display_9';

	DisplayRangeDigits_DangerClose[0] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_0';
	DisplayRangeDigits_DangerClose[1] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_1';
	DisplayRangeDigits_DangerClose[2] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_2';
	DisplayRangeDigits_DangerClose[3] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_3';
	DisplayRangeDigits_DangerClose[4] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_4';
	DisplayRangeDigits_DangerClose[5] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_5';
	DisplayRangeDigits_DangerClose[6] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_6';
	DisplayRangeDigits_DangerClose[7] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_7';
	DisplayRangeDigits_DangerClose[8] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_8';
	DisplayRangeDigits_DangerClose[9] = MaterialInstanceConstant'M319.DisplayDigits_DangerClose.M319_Display_9';

	DisplayDecoration[0] = MaterialInstanceConstant'M319.Materials.M319_DisplayDetails_Safe';
	DisplayDecoration[1] = MaterialInstanceConstant'M319.Materials.M319_DisplayDetails_DangerClose';

	DisplayStatus_Safe[0] = MaterialInstanceConstant'M319.DisplayStatus_Safe.M319_READY_Safe';
	DisplayStatus_Safe[1] = MaterialInstanceConstant'M319.DisplayStatus_Safe.M319_BOOM_Safe';
	DisplayStatus_Safe[2] = MaterialInstanceConstant'M319.DisplayStatus_Safe.M319_INAIR_Safe';
	DisplayStatus_Safe[3] = MaterialInstanceConstant'M319.DisplayStatus_Safe.M319_LNKED_Safe';
	DisplayStatus_Safe[4] = MaterialInstanceConstant'M319.DisplayStatus_Safe.M319_LNKING_Safe';
	DisplayStatus_Safe[5] = MaterialInstanceConstant'M319.DisplayStatus_Safe.M319_ARMED_Safe';

	DisplayStatus_DangerClose[0] = MaterialInstanceConstant'M319.DisplayStatus_DangerClose.M319_READY_DangerClose';
	DisplayStatus_DangerClose[1] = MaterialInstanceConstant'M319.DisplayStatus_DangerClose.M319_BOOM_DangerClose';
	DisplayStatus_DangerClose[2] = MaterialInstanceConstant'M319.DisplayStatus_DangerClose.M319_INAIR_DangerClose';
	DisplayStatus_DangerClose[3] = MaterialInstanceConstant'M319.DisplayStatus_DangerClose.M319_LNKED_DangerClose';
	DisplayStatus_DangerClose[4] = MaterialInstanceConstant'M319.DisplayStatus_DangerClose.M319_LNKNG_DangerClose';
	DisplayStatus_DangerClose[5] = MaterialInstanceConstant'M319.DisplayStatus_DangerClose.M319_ARMED_DangerClose';

	GrenadeStatusLight[0] = MaterialInstanceConstant'Shared.Materials.Blank';
	GrenadeStatusLight[1] = MaterialInstanceConstant'M319.Materials.M319_Controlled_Grenade_Armed';
	GrenadeStatusLight[2] = MaterialInstanceConstant'M45.Materials.M45_Lights';
}