//=============================================================================
// Base File: KFDT_ExplosiveSubmunition_HX25
//=============================================================================
// Explosive damage type for grenade submunitions
//=============================================================================
// Gear Shift Gaming Mods
// 6/19/2019
//=============================================================================

class KFDT_ExplosiveSubmunition_M45_BrashWhisper extends KFDT_Ballistic_Shotgun
	abstract
	hidedropdown;

defaultproperties
{
	bShouldSpawnPersistentBlood=true

	// physics impact
	RadialDamageImpulse=3000
	KDeathUpKick=400
	KDeathVel=300

	KnockdownPower=15
	StumblePower=10

	//Perk
	ModifierPerkList(0)=class'KFPerk_Support'
	ModifierPerkList(1)=class'KFPerk_Demolitionist'

	WeaponDef=class'KFWeapDef_M45_BrashWhisper'
}

