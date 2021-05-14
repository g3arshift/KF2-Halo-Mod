//=============================================================================
// Base File: KFDT_Explosive_M79
//=============================================================================
// Explosive damage type for the M319 IGL Grenade launcher grenade
//=============================================================================
// Gear Shift Gaming 6/28/2019
//=============================================================================

class KFDT_Explosive_M319 extends KFDT_Explosive
	abstract
	hidedropdown;

defaultproperties
{
	bShouldSpawnPersistentBlood=true

	// physics impact
	RadialDamageImpulse=1000//3000
	GibImpulseScale=0.15
	KDeathUpKick=500
	KDeathVel=300

	KnockdownPower=200 //150
	StumblePower=600 //400


	//Perk
	ModifierPerkList(0)=class'KFPerk_Demolitionist'
	
	WeaponDef=class'KFWeapDef_M319'
}
