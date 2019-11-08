//=============================================================================
// Base File: KFWeap_GrenadeLauncher_M79
//=============================================================================
// An M319 IGL Grenade Launcher
//=============================================================================
// Gear Shift Gaming 6/28/2019
//=============================================================================

class KFWeap_GrenadeLauncher_M319 extends KFWeap_GrenadeLauncher_Base;

/*********************************************************************************************
 * State FireAndDetonate
 * The weapon is in this state while detonating a live grenade
 * Ignore it, not currently using a custom firemode. Need to test detonations first.
*********************************************************************************************/
var KFProj_ControlledExplosive_M319 LiveGrenade;
var KFProj_HighExplosive_M319 LiveGrenade_H;
var KFPlayerController KFPC;
var bool FragRoundsActive;
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

simulated state FireAndDetonate extends WeaponSingleFiring
{
	simulated function KFProjectile SpawnProjectile( class<KFProjectile> KFProjClass, vector RealStartLoc, vector AimDir )
	{
		LiveGrenade = KFProj_ControlledExplosive_M319(super.SpawnProjectile( KFProjClass, RealStartLoc, AimDir ));

		bNeedsLinking = true;
		SetTimer(0.5, false, 'LinkingTimer');

		KFPC = KFPlayerController(GetALocalPlayerController());
		InstigatorPerk = KFPC.GetPerk();

		if(KFPerk_Demolitionist(InstigatorPerk) != none && KFPerk_Demolitionist(InstigatorPerk).IsAoEActive())
		{
			FragRoundsActive = true;
		}
		else
		{
			FragRoundsActive = false;
		}
		return LiveGrenade;
	}
}

simulated state M319_WeaponSingleFireAndReload extends WeaponSingleFireAndReload
{
	simulated function KFProjectile SpawnProjectile( class<KFProjectile> KFProjClass, vector RealStartLoc, vector AimDir )
	{
		LiveGrenade_H = KFProj_HighExplosive_M319(super.SpawnProjectile( KFProjClass, RealStartLoc, AimDir ));
		LiveGrenade_H.bNeedsArming = true;
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
		//`log("M319 Grenade detonated after put down.");
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
			LiveGrenade.TriggerExplosion(LiveGrenade.Location, vect(0,0,1), None);
			SetTimer(0.85, false, 'GrenadeExplodedTimer');
			LiveGrenade = None;

			Mesh.SetMaterial( 5, DisplayRangeDigits_Safe[0]);
			Mesh.SetMaterial( 8, DisplayRangeDigits_Safe[0]);
			Mesh.SetMaterial( 3, DisplayRangeDigits_Safe[0]);
			Mesh.SetMaterial( 9, DisplaySkull[0] );
			Mesh.SetMaterial( 2, DisplayBackplate[0] );
			Mesh.SetMaterial( 10, DisplaySkull[0]);
			Mesh.SetMaterial( 4, DisplayDecoration[0]);
			Mesh.SetMaterial( 7, GrenadeStatusLight[0]);
		}
	}
	else
	{
		`log("M319 End Fire Role Check Failure.");
	}

	ClearPendingFire(FireModeNum);
}

simulated event Tick( float DeltaTime )
{

	super.Tick(DeltaTime);

	if( LiveGrenade != none || LiveGrenade_H != none)
	{
		UpdateDisplay();
	}

	if( LiveGrenade_H != None && LiveGrenade_H.bHasExploded)
	{
		SetTimer(0.85, false, 'GrenadeExplodedTimer');
		LiveGrenade_H = None;
		Mesh.SetMaterial( 5, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( 8, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( 3, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial( 9, DisplaySkull[0] );
		Mesh.SetMaterial( 2, DisplayBackplate[0] );
		Mesh.SetMaterial( 10, DisplaySkull[0]);
		Mesh.SetMaterial( 4, DisplayDecoration[0]);
		Mesh.SetMaterial( 7, GrenadeStatusLight[0]);
	}

	if(IsTimerActive('GrenadeExplodedTimer'))
	{
		Mesh.SetMaterial(7, GrenadeStatusLight[2]);
		Mesh.SetMaterial(6, DisplayStatus_Safe[1]);
	}
	else if(LiveGrenade == None && LiveGrenade_H == None) //!IsTimerActive('GrenadeExplodedTimer') && 
	{
		Mesh.SetMaterial(7, GrenadeStatusLight[0]);
		Mesh.SetMaterial(6, DisplayStatus_Safe[0]);
	}
}

simulated function UpdateDisplay()
{

	/*
	//
	// 2 is the display background
	// 3 is the right digit
	// 4 is the display details
	// 5 is the left digit
	// 6 is the display status
	// 7 is the grenade status light
	// 8 is the middle digit
	// 9 is the skull
	// 10 is the number of enemies in the blast zone
	//
	*/

	if(KFPC == none)
	{
		KFPC = KFPlayerController(GetALocalPlayerController());
	}

	if(LiveGrenade != none)
	{
		UpdateDisplay_ControlledExplosive();
	}
	else if(LiveGrenade_H != none)
	{
		UpdateDisplay_HighExplosive();
	}
	else
	{
		
	}
}

simulated function UpdateDisplay_HighExplosive()
{
	local float DistanceFromGrenade;

	DistanceFromGrenade = Vsize(LiveGrenade_H.Location - KFPC.ViewTarget.Location);

	if( !FragRoundsActive && DistanceFromGrenade <= 670.0 ) //Danger Zone, Frag rounds off
	{
		Mesh.SetMaterial( 9, DisplaySkull[1] );
		Mesh.SetMaterial( 2, DisplayBackplate[1] );
		Mesh.SetMaterial( 10, DisplayRangeDigits_DangerClose[1]);
		Mesh.SetMaterial( 4, DisplayDecoration[1]);

		if(LiveGrenade_H.bNeedsArming) //Arming
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[2]);
		}
		else //Armed
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[5]);
		}

		UpdaterangeDisplay_DangerZone(DistanceFromGrenade);
	}
	else if( FragRoundsActive && DistanceFromGrenade <= 970.0 ) //Danger Zone, Frag Rounds on
	{
		Mesh.SetMaterial( 9, DisplaySkull[1] );
		Mesh.SetMaterial( 2, DisplayBackplate[1] );
		Mesh.SetMaterial( 10, DisplayRangeDigits_DangerClose[1]);
		Mesh.SetMaterial( 4, DisplayDecoration[1]);

		if(LiveGrenade_H.bNeedsArming) //Arming
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[2]);
		}
		else //Armed
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[5]);
		}
		
		UpdaterangeDisplay_DangerZone(DistanceFromGrenade);
	}
	else //Safe
	{
		Mesh.SetMaterial( 9, DisplaySkull[0] );
		Mesh.SetMaterial( 2, DisplayBackplate[0] );
		Mesh.SetMaterial( 10, DisplaySkull[0]);
		Mesh.SetMaterial( 4, DisplayDecoration[0]);

		if(LiveGrenade_H.bNeedsArming) //Arming
		{
			Mesh.SetMaterial(6, DisplayStatus_Safe[2]);
		}
		else //Armed
		{
			Mesh.SetMaterial(6, DisplayStatus_Safe[5]);
		}
		
		UpdateRangeDisplay_Safe(DistanceFromGrenade);
	}
}

simulated function UpdateDisplay_ControlledExplosive()
{
	local float DistanceFromGrenade;

	Mesh.SetMaterial(7, GrenadeStatusLight[1]);

	DistanceFromGrenade = Vsize(LiveGrenade.Location - KFPC.ViewTarget.Location);

	if( !FragRoundsActive && DistanceFromGrenade <= 670.0 ) //Danger Zone, Frag rounds off
	{
		Mesh.SetMaterial( 9, DisplaySkull[1] );
		Mesh.SetMaterial( 2, DisplayBackplate[1] );
		Mesh.SetMaterial( 10, DisplayRangeDigits_DangerClose[1]);
		Mesh.SetMaterial( 4, DisplayDecoration[1]);
		if(bNeedsLinking)
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[4]);
			if(!IsTimerActive('LinkingTimer'))
			{
				bNeedsLinking = false;
			}
		}
		else
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[3]);
		}
		UpdaterangeDisplay_DangerZone(DistanceFromGrenade);
	}
	else if( FragRoundsActive && DistanceFromGrenade <= 970.0 ) //Danger Zone, Frag Rounds on
	{
		Mesh.SetMaterial( 9, DisplaySkull[1] );
		Mesh.SetMaterial( 2, DisplayBackplate[1] );
		Mesh.SetMaterial( 10, DisplayRangeDigits_DangerClose[1]);
		Mesh.SetMaterial( 4, DisplayDecoration[1]);
		if(bNeedsLinking)
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[4]);
			if(!IsTimerActive('LinkingTimer'))
			{
				bNeedsLinking = false;
			}
		}
		else
		{
			Mesh.SetMaterial(6, DisplayStatus_DangerClose[3]);
		}
		UpdaterangeDisplay_DangerZone(DistanceFromGrenade);
	}
	else //Safe
	{
		Mesh.SetMaterial( 9, DisplaySkull[0] );
		Mesh.SetMaterial( 2, DisplayBackplate[0] );
		Mesh.SetMaterial( 10, DisplaySkull[0]);
		Mesh.SetMaterial( 4, DisplayDecoration[0]);
		if(bNeedsLinking)
		{
			Mesh.SetMaterial(6, DisplayStatus_Safe[4]);
			if(!IsTimerActive('LinkingTimer'))
			{
				bNeedsLinking = false;
			}
		}
		else
		{
			Mesh.SetMaterial(6, DisplayStatus_Safe[3]);
		}
		UpdateRangeDisplay_Safe(DistanceFromGrenade);
	}
}

simulated function UpdateRangeDisplay_Safe(float DistanceFromGrenade)
{
	local int LeftRangeDigit;
	local int MiddleRangeDigit;
	local int RightRangeDigit;

	LeftRangeDigit = int(Mid(DistanceFromGrenade / 100, 0, 1));
	MiddleRangeDigit= int(Mid(DistanceFromGrenade / 100, 1, 1)); 
	RightRangeDigit= int(Mid(DistanceFromGrenade / 100, 2, 1));

	if(DistanceFromGrenade /100 >= 100 )
	{
		Mesh.SetMaterial(5, DisplayRangeDigits_Safe[LeftRangeDigit]);
		Mesh.SetMaterial(8, DisplayRangeDigits_Safe[MiddleRangeDigit]);
		Mesh.SetMaterial(3, DisplayRangeDigits_Safe[RightRangeDigit]);
	}
	else if (DistanceFromGrenade /100 >= 10) 
	{
		Mesh.SetMaterial(5, DisplayRangeDigits_Safe[RightRangeDigit]);
		Mesh.SetMaterial(8, DisplayRangeDigits_Safe[LeftRangeDigit]);
		Mesh.SetMaterial(3, DisplayRangeDigits_Safe[MiddleRangeDigit]);	
	}
	else
	{
		Mesh.SetMaterial(5, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial(8, DisplayRangeDigits_Safe[0]);
		Mesh.SetMaterial(3, DisplayRangeDigits_Safe[LeftRangeDigit]);	
	}
}

simulated function UpdateRangeDisplay_DangerZone(float DistanceFromGrenade)
{
	local int LeftRangeDigit;
	local int MiddleRangeDigit;
	local int RightRangeDigit;

	LeftRangeDigit = int(Mid(DistanceFromGrenade / 100, 0, 1));
	MiddleRangeDigit= int(Mid(DistanceFromGrenade / 100, 1, 1)); 
	RightRangeDigit= int(Mid(DistanceFromGrenade / 100, 2, 1));

	if (DistanceFromGrenade /100 >= 10) 
	{
		Mesh.SetMaterial(5, DisplayRangeDigits_DangerClose[RightRangeDigit]);
		Mesh.SetMaterial(8, DisplayRangeDigits_DangerClose[LeftRangeDigit]);
		Mesh.SetMaterial(3, DisplayRangeDigits_DangerClose[MiddleRangeDigit]);	
	}
	else
	{
		Mesh.SetMaterial(5, DisplayRangeDigits_DangerClose[0]);
		Mesh.SetMaterial(8, DisplayRangeDigits_DangerClose[0]);
		Mesh.SetMaterial(3, DisplayRangeDigits_DangerClose[LeftRangeDigit]);	
	}

	Mesh.SetMaterial(9, DisplaySkull[1]);
}

defaultproperties
{
	ForceReloadTime=0.3f

	// Inventory
	InventoryGroup=IG_Primary
	GroupPriority=100
	InventorySize=7
	WeaponSelectTexture=Texture2D'M319.Textures.M319_UI_v1'

	// FOV
	MeshFOV=80
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
	SpareAmmoCapacity[0]=20
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
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_Grenade'
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

	DisplaySkull[0] = MaterialInstanceConstant'Shared.Materials.Blank';
	DisplaySkull[1] = MaterialInstanceConstant'M319.Materials.M319_Skull';

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