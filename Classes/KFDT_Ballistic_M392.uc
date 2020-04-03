//=============================================================================
// Base File: KFDT_Ballistic_Bullpup
//=============================================================================
// Class Description
//=============================================================================
// Gear Shift Gaming 3/14/2020
//=============================================================================

class KFDT_Ballistic_M392 extends KFDT_Ballistic_AssaultRifle
	abstract
	hidedropdown;

defaultproperties
{
    KDamageImpulse=900
	KDeathUpKick=-300
	KDeathVel=100
	
    KnockdownPower=5
	StunPower=20
	StumblePower=10
	GunHitPower=90
	MeleeHitPower=0

	WeaponDef=class'KFWeapDef_M392'

	//Perk
	ModifierPerkList(0)=class'KFPerk_Commando'
	ModifierPerkList(1)=class'KFPerk_Sharpshooter'
}
