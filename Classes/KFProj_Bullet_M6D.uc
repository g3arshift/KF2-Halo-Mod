//=============================================================================
// Base File: KFProj_Bullet_Pistol50AE
//=============================================================================
// Bullet class for the M6D Magnum
//=============================================================================
// Gear Shift Gaming Mods 7/19/2019
//=============================================================================

class KFProj_Bullet_M6D extends KFProj_Bullet
	hidedropdown;

defaultproperties
{
	Speed=18000
	MaxSpeed=18000

	DamageRadius = 0;

	ProjFlightTemplate=ParticleSystem'FX_Projectile_EMIT.FX_Tracer_9MM_ZEDTime'

	ImpactEffects = KFImpactEffectInfo'M6D.Archetype.M6D_Pistol_Explosion';
}

