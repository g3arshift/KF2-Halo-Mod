//=============================================================================
// Base File: KFDT_Ballistic_MP5RAS
//=============================================================================
// Gear Shift Gaming 9/17/2019
//=============================================================================

class KFDT_Ballistic_M7 extends KFDT_Ballistic_Submachinegun
	abstract
	hidedropdown;

defaultproperties
{
	KDamageImpulse=900
	KDeathUpKick=-300
	KDeathVel=100

	StumblePower=10 //12
	GunHitPower=10 //12

	WeaponDef=class'KFWeapDef_M7'
	ModifierPerkList(0)=class'KFPerk_SWAT'
}
