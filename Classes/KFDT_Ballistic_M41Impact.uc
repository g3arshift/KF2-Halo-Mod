//=============================================================================
// Base File: KFDT_Ballistic_RPG7Impact
//=============================================================================
// Rocket impact damage type for the M41 rocket launcher
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================

class KFDT_Ballistic_M41Impact extends KFDT_Ballistic_Shell
	abstract
	hidedropdown;

defaultproperties
{
	KDamageImpulse=3000
	KDeathUpKick=1000
	KDeathVel=500

	KnockdownPower=200
	StumblePower=340
	GunHitPower=275

	ModifierPerkList(0)=class'KFPerk_Demolitionist'

	WeaponDef=class'KFWeapDef_M41'
}
