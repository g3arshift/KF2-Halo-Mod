//=============================================================================
// Base File: KFDT_Explosive_M16M203
//=============================================================================
// Explosive damage type for the explosive effect on the M6D Magnum
//=============================================================================
// Gear Shift Gaming Mods 7/19/2019
//=============================================================================

class KFDT_Explosive_M6D extends KFDT_Explosive
	abstract
	hidedropdown;

defaultproperties
{
	bShouldSpawnPersistentBlood=true

	// physics impact
	RadialDamageImpulse=2000//3000
	GibImpulseScale=0.15
	KDeathUpKick=1000
	KDeathVel=300

	KnockdownPower=150
	StumblePower=400


	//Perk
	ModifierPerkList(0)=class'KFPerk_Sharpshooter'
	
	WeaponDef=class'KFWeapDef_M6D'
}
