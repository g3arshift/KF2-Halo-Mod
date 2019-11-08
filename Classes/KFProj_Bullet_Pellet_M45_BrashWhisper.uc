//=============================================================================
// Base File: KFProj_Bullet_Pellet
//=============================================================================
// Explosive Shotgun Submunition
//=============================================================================
// Gear Shift Gaming Mods
// 6/19/2019
//=============================================================================

class KFProj_Bullet_Pellet_M45_BrashWhisper extends KFProj_BallisticExplosive
	hidedropdown;

/** Cached reference to owner weapon */
var protected KFWeapon OwnerWeapon;

/** Initialize the projectile */
function Init( vector Direction )
{
	super.Init( Direction );

	OwnerWeapon = KFWeapon( Owner );
	if( OwnerWeapon != none )
	{
		OwnerWeapon.LastPelletFireTime = WorldInfo.TimeSeconds;
	}
}

simulated protected function PrepareExplosionTemplate()
{
	local KFPawn KFP;
	local KFPerk CurrentPerk;
	
	ExplosionTemplate.bIgnoreInstigator = true;

    super.PrepareExplosionTemplate();

    if( ExplosionActorClass == class'KFPerk_Demolitionist'.static.GetNukeExplosionActorClass() )
    {
		KFP = KFPawn( Instigator );
		if( KFP != none )
		{
			CurrentPerk = KFP.GetPerk();
			if( CurrentPerk != none )
			{
				CurrentPerk.SetLastHX25NukeTime( WorldInfo.TimeSeconds );
			}
		}
	}
}

simulated event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
    // For some reason on clients up close shots with this projectile
    // get HitWall calls instead of Touch calls. This little hack fixes
    // the problem. TODO: Investigate why this happens - Ramm
    // If we hit a pawn with a HitWall call on a client, do touch instead
    if( WorldInfo.NetMode == NM_Client && Pawn(Wall) != none )
    {
        Touch( Wall, WallComp, Location, HitNormal );
        return;
    }

    Super.HitWall(HitNormal, Wall, WallComp);
}

/** Don't allow more than one pellet projectile to perform this check in a single frame */
function bool ShouldWarnAIWhenFired()
{
	return super.ShouldWarnAIWhenFired() && OwnerWeapon != none && OwnerWeapon.LastPelletFireTime < WorldInfo.TimeSeconds;
}

defaultproperties
{
	Physics=PHYS_Projectile
	MaxSpeed=7000.0
	Speed=7000.0
	ArmDistSquared=0 // Arm instantly

	bWarnAIWhenFired=true

	DamageRadius=0

	ProjFlightTemplate=ParticleSystem'WEP_1P_MB500_EMIT.FX_MB500_Tracer'
	ProjFlightTemplateZedTime=ParticleSystem'WEP_1P_MB500_EMIT.FX_MB500_Tracer_ZEDTime'
	AltExploEffects=KFImpactEffectInfo'WEP_HX25_Pistol_ARCH.HX25_Pistol_Submunition_Explosion_Concussive_Force'
	ProjDisintegrateTemplate=ParticleSystem'ZED_Siren_EMIT.FX_Siren_grenade_disable_01'

	// Grenade explosion light
	Begin Object Class=PointLightComponent Name=ExplosionPointLight
	    LightColor=(R=251,G=167,B=166,A=255)
		Brightness=4.f
		Radius=250.f
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
		Damage=75
		DamageRadius=400 //300
		DamageFalloffExponent=1.0f
		DamageDelay=0.f

		MomentumTransferScale=1.f

		// Damage Effects
		MyDamageType=class'KFDT_ExplosiveSubmunition_M45_BrashWhisper'
		KnockDownStrength=30
		FractureMeshRadius=300.0
		FracturePartVel=600.0
		ExplosionEffects=KFImpactEffectInfo'FX_Impacts_ARCH.Explosions.HuskProjectile_Explosion'
		ExplosionSound=AkEvent'WW_WEP_Seeker_6.Play_WEP_Seeker_6_Explosion'
		bIgnoreInstigator=true
		ActorClassToIgnoreForDamage=class'KFProj_Bullet_Pellet_M45_BrashWhisper'

        // Dynamic Light
        ExploLight=ExplosionPointLight
        ExploLightStartFadeOutTime=0.0
        ExploLightFadeOutTime=0.3

		// Camera Shake
		CamShake=KFCameraShake'FX_CameraShake_Arch.Guns.HX25_Submunition_CameraShake'
		CamShakeInnerRadius=150
		CamShakeOuterRadius=300
		CamShakeFalloff=1.f
		bOrientCameraShakeTowardsEpicenter=true
	End Object
	ExplosionTemplate=ExploTemplate0
}