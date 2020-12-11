//=============================================================================
// Base File: KFDT_Ballistic_Kriss
//=============================================================================
// Class Description
//=============================================================================
// Gear Shift Gaming Mods
//=============================================================================

class KFDT_Ballistic_M7S extends KFDT_Ballistic_Submachinegun
	abstract
	hidedropdown;

defaultproperties
{
	KDamageImpulse=900
	KDeathUpKick=-400
	KDeathVel=250

	KnockdownPower=15
	StumblePower=15
	GunHitPower=30 //35

	WeaponDef=class'KFWeapDef_M7S'
	ModifierPerkList(0)=class'KFPerk_SWAT'
}
