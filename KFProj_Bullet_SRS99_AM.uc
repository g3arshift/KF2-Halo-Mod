//=============================================================================
// Base File: KFProj_Bullet_M99
//=============================================================================
// Class Description
//=============================================================================
// Gear Shift Gaming 3/6/2020
//=============================================================================

class KFProj_Bullet_SRS99_AM extends KFProj_Bullet
	hidedropdown;

defaultproperties
{
	MaxSpeed=35000.0 //30000.0
	Speed=35000.0 //30000.0

	DamageRadius=0

	ProjFlightTemplate=ParticleSystem'SRS99_AM.Emitters.FX_SRS99_AM_Projectile_01'
	ImpactEffects=KFImpactEffectInfo'FX_Impacts_ARCH.Heavy_bullet_impact'
}