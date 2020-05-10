//=============================================================================
// Base File: KFProj_HighExplosive_M79
//=============================================================================
// High explosive grenade launcher grenade for the M319 IGL
//=============================================================================
// Gear Shift Gaming 6/28/2019
//=============================================================================

class KFProj_ControlledExplosive_M319 extends KFProj_BallisticExplosive
	hidedropdown;

var(Projectile) ParticleSystem GrenadeWarningTemplate;

var float ExplosiveRadius;
var KFPerk InstigatorPerk;
var KFPlayerController KFPC;

var float NearCullDist;

replication
{
	if (bNetDirty)
	NearCullDist;
}

simulated function ModifyParticleCullSettings()
{
	//This is dynamically changing the cull distance of a particle emitter that is setup to show the safe and danger zones. It gets
	// explosive radius from KFPerk, so any mods not using KFPerk to increase explosive distance will break this.
	// The flow of the below array access is ParticleSystem.Emitters[EmitterNumber].LODLevels[LODLevel].Module[ModuleNumber].Variable
	// Module is just any member of ParticleLODLevel. It can also be RequiredModule to get the RequiredModule.

	// I did this shit at 4:20 in the morning on 4/23/2020. Jesus christ it took fucking hours. God damned UE3, with your ridiculous bullshit. I had to export a 
	// fucking particle system completely to a text object, then fucking DISSECT the code to figure it out since none of this shit is visible elsewhere.

	if(KFPC == none)
	{
		KFPC = KFPlayerController(Instigator.Controller);
	}

	if (InstigatorPerk == none)
	{
		InstigatorPerk = KFPC.GetPerk();
	}

	ExplosiveRadius = ExplosionTemplate.DamageRadius * InstigatorPerk.GetAoERadiusModifier();
	//`log("IN NADE. AOE Radius Mod is: "$InstigatorPerk.GetAoERadiusModifier());
	//`log("IN NADE. Explosive Radius is: $"$ExplosiveRadius);


	//Danger Arrow
	GrenadeWarningTemplate.Emitters[1].LODLevels[0].RequiredModule.NearCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 4;
	GrenadeWarningTemplate.Emitters[1].LODLevels[0].RequiredModule.NearFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 3;
	GrenadeWarningTemplate.Emitters[1].LODLevels[0].RequiredModule.FarFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 2;
	GrenadeWarningTemplate.Emitters[1].LODLevels[0].RequiredModule.FarCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 1;

	//Danger Text
	GrenadeWarningTemplate.Emitters[3].LODLevels[0].RequiredModule.NearCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 4;
	GrenadeWarningTemplate.Emitters[3].LODLevels[0].RequiredModule.NearFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 3;
	GrenadeWarningTemplate.Emitters[3].LODLevels[0].RequiredModule.FarFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 2;
	GrenadeWarningTemplate.Emitters[3].LODLevels[0].RequiredModule.FarCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 1;

	//Danger Circle
	GrenadeWarningTemplate.Emitters[5].LODLevels[0].RequiredModule.NearCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 4;
	GrenadeWarningTemplate.Emitters[5].LODLevels[0].RequiredModule.NearFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 3;
	GrenadeWarningTemplate.Emitters[5].LODLevels[0].RequiredModule.FarFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 2;
	GrenadeWarningTemplate.Emitters[5].LODLevels[0].RequiredModule.FarCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) - 1;

	//Safe Arrow
	GrenadeWarningTemplate.Emitters[2].LODLevels[0].RequiredModule.NearCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04);
	GrenadeWarningTemplate.Emitters[2].LODLevels[0].RequiredModule.NearFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) + 1;

	//Safe Grenade
	GrenadeWarningTemplate.Emitters[4].LODLevels[0].RequiredModule.NearCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04);
	GrenadeWarningTemplate.Emitters[4].LODLevels[0].RequiredModule.NearFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) + 1;

	//Safe Circle
	GrenadeWarningTemplate.Emitters[6].LODLevels[0].RequiredModule.NearCullDistance = ExplosiveRadius + (ExplosiveRadius * 0.04);
	GrenadeWarningTemplate.Emitters[6].LODLevels[0].RequiredModule.NearFadeDistance = ExplosiveRadius + (ExplosiveRadius * 0.04) + 1;
	
	NearCullDist = GrenadeWarningTemplate.Emitters[1].LODLevels[0].RequiredModule.NearCullDistance;
}

simulated function Destroyed()
{
    local Actor HitActor;
    local vector HitLocation, HitNormal;

	// Final Failsafe check for explosion effect
	if (!bHasExploded && !bHasDisintegrated)
	{
		GetExplodeEffectLocation(HitLocation, HitNormal, HitActor);
        TriggerExplosion(HitLocation, HitNormal, HitActor);
	}

	super.Destroyed();
}

simulated function GetExplodeEffectLocation(out vector HitLocation, out vector HitRotation, out Actor HitActor)
{
    local vector EffectStartTrace, EffectEndTrace;
	local TraceHitInfo HitInfo;

	EffectStartTrace = Location + vect(0,0,1) * 4.f;
	EffectEndTrace = EffectStartTrace - vect(0,0,1) * 32.f;

    // Find where to put the decal
	HitActor = Trace(HitLocation, HitRotation, EffectEndTrace, EffectStartTrace, false,, HitInfo, TRACEFLAG_Bullet);

	// If the locations are zero (probably because this exploded in the air) set defaults
    if( IsZero(HitLocation) )
    {
        HitLocation = Location;
    }

	if( IsZero(HitRotation) )
    {
        HitRotation = vect(0,0,1);
    }
}

function ExplodeTimer()
{
    local Actor HitActor;
    local vector HitLocation, HitNormal;

    GetExplodeEffectLocation(HitLocation, HitNormal, HitActor);

    TriggerExplosion(HitLocation, HitNormal, HitActor);
}

simulated function int CheckProx(float M319_ExplosiveRadius)
{
	local KFPawn_Monster KFPM;
	local int NumberOfZeds;

	foreach self.VisibleCollidingActors( class'KFPawn_Monster', KFPM, M319_ExplosiveRadius, self.Location)
	{
		if(KFPM.IsAliveAndWell())
		{
			NumberOfZeds++;
		}
	}
	return NumberOfZeds;
}

simulated function SetGrenadeExplodeTimer(float ControlledExplosiveFuseTime)
{
	SetTimer(ControlledExplosiveFuseTime, false, 'ExplodeTimer');
}

/**
 * Give a little bounce
 */
simulated event HitWall(vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
	// check to make sure we didn't hit a pawn
	if ( Pawn(Wall) != none )
	{
		return;
	}

    Bounce( HitNormal, Wall );

	// if we are moving too slowly stop moving and lay down flat
	// also, don't allow rest on -Z surfaces.
	if ( Speed < 40 && HitNormal.Z > 0 )
	{
		ImpactedActor = Wall;
		GrenadeIsAtRest();
	}
}

/** Adjusts movement/physics of projectile.
  * Returns true if projectile actually bounced / was allowed to bounce */
simulated function bool Bounce( vector HitNormal, Actor BouncedOff )
{
	local vector VNorm;

	if ( WorldInfo.NetMode != NM_DedicatedServer )
    {
        // do the impact effects
    	`ImpactEffectManager.PlayImpactEffects(Location, Instigator, HitNormal, GrenadeBounceEffectInfo, true );
    }

    // Reflect off BouncedOff w/damping
    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
    Speed = VSize(Velocity);

	// also done from ProcessDestructibleTouchOnBounce. update LastBounced to solve problem with bouncing rapidly between world/non-world geometry
	LastBounced.Actor = BouncedOff;
	LastBounced.Time = WorldInfo.TimeSeconds;

	return true;
}

/** Called once the grenade has finished moving */
simulated event GrenadeIsAtRest()
{
	ModifyParticleCullSettings();
	ProjEffects.SetTemplate(GrenadeWarningTemplate);
	ProjEffects.SetVectorParameter('Rotation', vect(0,0,0));

	ProjEffects.ActivateSystem();

	//`log("IN NADE. Grenade Cull Distance Near is: "$GrenadeWarningTemplate.Emitters[1].LODLevels[0].RequiredModule.NearCullDistance);

	SetPhysics(PHYS_None);
}

//==============
// Touching
simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	if ( Other != none && Other != Instigator && (!Other.bWorldGeometry || !Other.bStatic) )
	{
		if ( Pawn(other) != None )
		{
            // For opposing team, make the grenade stop and just start falling
			if( Pawn(Other).GetTeamNum() != GetTeamNum() )
			{
				// Setting SetCollision makes the grenade undetectable by the Siren's scream, so instead
				// disable Touch & HitWall event notifications. If there's a problem with using execDisable, we
				// can add a new flag instead, like "bStopBounce" to exit ProcessTouch & HitWall early if true.
				// Events with indices between NAME_PROBEMIN and NAME_PROBEMAX can be enabled/disabled.
				Disable( 'Touch' );
				ProcessBulletTouch(Other, HitLocation, HitNormal); //This makes the grenade do damage when it hits a zed.
				Velocity = Vect(0,0,0);
			}
		}
		else if ( !Other.bCanBeDamaged && Other.bBlockActors )
		{
			// Not a destructible... treat as if it's bWorldGeometry=TRUE
			// e.g. SkeletalMeshActor
			if ( !CheckRepeatingTouch(Other) )
			{
				HitWall(HitNormal, Other, LastTouchComponent);
			}
		}
		else
		{
			ProcessDestructibleTouchOnBounce( Other, HitLocation, HitNormal );
		}
	}
}

defaultproperties
{

	bCollideWithTeammates = false;

	Physics=PHYS_Falling
	Speed=4000
	MaxSpeed=4000
	TerminalVelocity=4000
	TossZ=150
	GravityScale=0.5
    MomentumTransfer=50000.0
    ArmDistSquared=280000 //273750 This does NOTHING since the grenade blows up once the trigger is released. Need to fix.
    LifeSpan=+1000.0f
    GrenadeWarningTemplate=ParticleSystem'M319.FX.FX_ControlledExplosive_Warning'

    //Settings for the grenade
    bIsTimedExplosive=true

    //Bounce Factors
    DampenFactor=0.21 //.18
    DampenFactorParallel=0.21 //.18
	WallHitDampenFactor=0.21 //.18
	WallHitDampenFactorParallel=0.21 //.18

	bWarnAIWhenFired=true

	ProjFlightTemplate=ParticleSystem'M319.FX.FX_M319_40mm_Projectile'
	ProjFlightTemplateZedTime=ParticleSystem'M319.FX.FX_M319_40mm_Projectile_ZEDTIME'
	ProjDudTemplate=ParticleSystem'M319.FX.FX_M319_40mm_Projectile_Dud'
	GrenadeBounceEffectInfo=KFImpactEffectInfo'FX_Impacts_ARCH.DefaultGrenadeImpacts'
    ProjDisintegrateTemplate=ParticleSystem'ZED_Siren_EMIT.FX_Siren_grenade_disable_01'
	AltExploEffects=KFImpactEffectInfo'M319.Archetypes.M319_EMP_Explosion_Zed_Time'

	// Grenade explosion light
	Begin Object Class=PointLightComponent Name=ExplosionPointLight
	    LightColor=(R=252,G=218,B=171,A=255)
		Brightness=4.f
		Radius=2000.f
		FalloffExponent=10.f
		CastShadows=False
		CastStaticShadows=FALSE
		CastDynamicShadows=False
		bCastPerObjectShadows=false
		bEnabled=FALSE
		LightingChannels=(Indoor=TRUE,Outdoor=TRUE,bInitialized=TRUE)
	End Object

	// explosion
	Begin Object Class=KFGameExplosion Name=ExploTemplate0
		Damage=300 //200 //600
		DamageRadius=650          //850
		DamageFalloffExponent=1.5    //2
		DamageDelay=0.f

		// Damage Effects
		MyDamageType=class'KFDT_Explosive_M319_EMP'
		KnockDownStrength=0
		FractureMeshRadius=200.0
		FracturePartVel=500.0
		ExplosionEffects=KFImpactEffectInfo'M319.Archetypes.M319_EMP_Explosion'
		ExplosionSound=AkEvent'M319.Audio.Play_M319_Explosion'

        // Dynamic Light
        ExploLight=ExplosionPointLight
        ExploLightStartFadeOutTime=0.0
        ExploLightFadeOutTime=0.2

		// Camera Shake
		CamShake=CameraShake'FX_CameraShake_Arch.Grenades.Default_Grenade'
		CamShakeInnerRadius=200
		CamShakeOuterRadius=900
		CamShakeFalloff=1.5f
		bOrientCameraShakeTowardsEpicenter=true
	End Object
	ExplosionTemplate=ExploTemplate0

	AmbientSoundPlayEvent=AkEvent'M319.Audio.Play_M319_Projectile_whistle'
    AmbientSoundStopEvent=AkEvent'M319.Audio.Stop_M319_Projectile_whistle'
}

