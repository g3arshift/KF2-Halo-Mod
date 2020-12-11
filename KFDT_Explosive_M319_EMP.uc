//=============================================================================
// Base File: KFDT_Explosive_M79
//=============================================================================
// Explosive damage type for the M319 IGL Grenade launcher controlled explosive
//=============================================================================
// Gear Shift Gaming 6/28/2019
//=============================================================================

class KFDT_Explosive_M319_EMP extends KFDT_Explosive
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
	EMPPower=225 //150


	//Perk
	ModifierPerkList(0)=class'KFPerk_Demolitionist'
	
	WeaponDef=class'KFWeapDef_M319'
}
