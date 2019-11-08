//=============================================================================
// Base File: KFProj_Bullet_AssaultRifle
//=============================================================================
// Gear Shift Gaming Mods 8/6/2019
//=============================================================================

class KFProj_Bullet_MA37 extends KFProj_Bullet
	hidedropdown;

defaultproperties
{
	MaxSpeed=22500.0
	Speed=22500.0

	DamageRadius=0

	ProjFlightTemplate=ParticleSystem'WEP_1P_L85A2_EMIT.FX_L85A2_Tracer_ZEDTime'
	ImpactEffects=KFImpactEffectInfo'FX_Impacts_ARCH.Heavy_bullet_impact'
}

