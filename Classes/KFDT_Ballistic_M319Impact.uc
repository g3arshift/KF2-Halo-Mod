//=============================================================================
// Base File: KFDT_Ballistic_M79Impact
//=============================================================================
// Shell impact damage type for the M319 IGL Grenade launcher
//=============================================================================
// Gear Shift Gaming Mods 6/28/2019
//=============================================================================

class KFDT_Ballistic_M319Impact extends KFDT_Ballistic_Shell
	abstract
	hidedropdown;

defaultproperties
{
	KDamageImpulse=2000
	KDeathUpKick=750
	KDeathVel=350

	KnockdownPower=0
	StumblePower=340
	GunHitPower=275

	WeaponDef=class'KFWeapDef_M319'

	ModifierPerkList(0)=class'KFPerk_Demolitionist'
}
