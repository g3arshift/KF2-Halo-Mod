//=============================================================================
// Base File: KFProj_HighExplosive_M79
//=============================================================================
// High explosive grenade launcher grenade for the M319 IGL
//=============================================================================
// Gear Shift Gaming 6/28/2019
//=============================================================================

class KFProj_HighExplosive_M319 extends KFProj_BallisticExplosive
	hidedropdown;

	var float FuseTime;
	var bool bNeedsArming;


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


/**
 * Give a little bounce
 */

 simulated event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local StaticMeshComponent HitStaticMesh;

	// Catch CanBecomeDynamic actors with BlockActors=FALSE and process as a wall hit

	if( Role == Role_Authority )
	{
		if(KFPawn_Monster(Other) != None && !IsTimerActive('ExplodeTimer'))
		{
			//`log("M319 hit Zed. Fuse Started.");
			 SetTimer(0.01, false, 'ExplodeTimer');
		}
	}
	else
	{
		`log("M319 Timed Explosive Role Check Failure.");
	}

	if ( Other.bStatic && Other.bWorldGeometry )
	{
		HitStaticMesh = StaticMeshComponent(OtherComp);
		if ( (HitStaticMesh != None) && HitStaticMesh.CanBecomeDynamic() )
		{
			HitWall(HitNormal, Other, OtherComp);
		}
		return;
	}

	LastTouchComponent = OtherComp;
	Super.Touch(Other, OtherComp, HitLocation, HitNormal);
}


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

	if( Role == ROLE_Authority )
	{
		//Makes sure that out timer isn't already active so we don't reset it when the grenade bounces.
		if(!IsTimerActive('ExplodeTimer'))
		{
			//`log("M319 Hit wall/floor. Fuse started");
			SetTimer(FuseTime, false, 'ExplodeTimer');
			bNeedsArming = false;
		}
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

	SetPhysics(PHYS_None);
}

function ExplodeTimer()
{
    local Actor HitActor;
    local vector HitLocation, HitNormal;

    GetExplodeEffectLocation(HitLocation, HitNormal, HitActor);

    TriggerExplosion(HitLocation, HitNormal, HitActor);
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
	Physics=PHYS_Falling
	Speed=6000 //4000
	MaxSpeed=6000 //4000
	TerminalVelocity=6000 //4000
	TossZ=150
	GravityScale=.5
    MomentumTransfer=50000.0
    ArmDistSquared=150000 // 4.0 meters
    LifeSpan=+1000.0f

    bCollideWithTeammates = false;

    //Settings for the grenade
    bIsTimedExplosive=true

    //Bounce Factors
    DampenFactor=0.21 //.1
    DampenFactorParallel=0.21 //.15
	WallHitDampenFactor=0.21 //.1
	WallHitDampenFactorParallel=0.21 //.15

	FuseTime=2.5 //2.0


	bWarnAIWhenFired=true

	ProjFlightTemplate=ParticleSystem'M319.FX.FX_M319_40mm_Projectile'
	ProjFlightTemplateZedTime=ParticleSystem'M319.FX.FX_M319_40mm_Projectile_ZEDTIME'
	ProjDudTemplate=ParticleSystem'M319.FX.FX_M319_40mm_Projectile_Dud'
	GrenadeBounceEffectInfo=KFImpactEffectInfo'FX_Impacts_ARCH.DefaultGrenadeImpacts'
    ProjDisintegrateTemplate=ParticleSystem'ZED_Siren_EMIT.FX_Siren_grenade_disable_01'
	AltExploEffects=KFImpactEffectInfo'WEP_M79_ARCH.M79Grenade_Explosion_Concussive_Force'

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
		Damage=800 //800
		DamageRadius=650          //850
		DamageFalloffExponent=2   //2
		DamageDelay=0.f

		// Damage Effects
		MyDamageType=class'KFDT_Explosive_M319'
		KnockDownStrength=0
		FractureMeshRadius=200.0
		FracturePartVel=500.0
		ExplosionEffects=KFImpactEffectInfo'WEP_M79_ARCH.M79Grenade_Explosion'
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

