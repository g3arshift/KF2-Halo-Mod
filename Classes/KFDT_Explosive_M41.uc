//=============================================================================
// Base File: KFDT_Explosive_RPG7
//=============================================================================
// Explosive damage type for the M41 rocket launcher rocket
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================

class KFDT_Explosive_M41 extends KFDT_Explosive
	abstract
	hidedropdown;

defaultproperties
{
	bShouldSpawnPersistentBlood=true

	// physics impact
	RadialDamageImpulse=3000//10000
	GibImpulseScale=0.15
	KDeathUpKick=5000//2000
	KDeathVel=1500

	KnockdownPower=225
	StumblePower=400

	//Perk
	ModifierPerkList(0)=class'KFPerk_Demolitionist'

	WeaponDef=class'KFWeapDef_M41'
}
