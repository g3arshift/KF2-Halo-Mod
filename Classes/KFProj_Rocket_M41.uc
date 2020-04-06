//=============================================================================
// Base File: KFProj_Rocket_RPG7
//=============================================================================
// High explosive rocket launcher rocket for the M41 Spanker.
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================

class KFProj_Rocket_M41 extends KFProj_BallisticExplosive
	hidedropdown;

defaultproperties
{
	Physics=PHYS_Projectile
	Speed=3500
	MaxSpeed=3500
	TossZ=0
	GravityScale=1.0
    MomentumTransfer=50000.0
    ArmDistSquared=112500 // 4 meters

	bWarnAIWhenFired=true

	ProjFlightTemplate=ParticleSystem'M41.Emitters.FX_M41_Projectile'
	ProjFlightTemplateZedTime=ParticleSystem'M41.Emitters.FX_M41_Projectile_ZED_TIME'
	ProjDudTemplate=ParticleSystem'M41.Emitters.FX_M41_Projectile_Dud'
	GrenadeBounceEffectInfo=KFImpactEffectInfo'WEP_RPG7_ARCH.RPG7_Projectile_Impacts'
    ProjDisintegrateTemplate=ParticleSystem'ZED_Siren_EMIT.FX_Siren_grenade_disable_01'

	AmbientSoundPlayEvent=AkEvent'M41.Audio.Play_M41_Projectile_Hiss'
  	AmbientSoundStopEvent=AkEvent'M41.Audio.Stop_M41_Projectile_Hiss'

  	AltExploEffects=KFImpactEffectInfo'WEP_RPG7_ARCH.RPG7_Explosion_Concussive_Force'

	// Grenade explosion light
	Begin Object Class=PointLightComponent Name=ExplosionPointLight
	    LightColor=(R=252,G=218,B=171,A=255)
		Brightness=5.f
		Radius=3000.f
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
		Damage=1100 //900
		DamageRadius=400
		DamageFalloffExponent=2
		DamageDelay=0.f

		// Damage Effects
		MyDamageType=class'KFDT_Explosive_M41'
		KnockDownStrength=0
		FractureMeshRadius=200.0
		FracturePartVel=500.0
		ExplosionEffects=KFImpactEffectInfo'WEP_RPG7_ARCH.RPG7_Explosion'
		ExplosionSound=AkEvent'M41.Audio.Play_M41_Rocket_Explosion'

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
}
