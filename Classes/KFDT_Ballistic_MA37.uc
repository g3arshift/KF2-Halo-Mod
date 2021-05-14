//=============================================================================
// Base File: KFDT_Ballistic_AssaultRifle
//=============================================================================
// Gear Shift Gaming Mods 8/6/2019
//=============================================================================

class KFDT_Ballistic_MA37 extends KFDT_Ballistic_AssaultRifle
	abstract
	hidedropdown;

	/** Allows the damage type to customize exactly which hit zones it can dismember */
static simulated function bool CanDismemberHitZone( name InHitZoneName )
{
	if( super.CanDismemberHitZone( InHitZoneName ) )
	{
		return true;
	}

	switch ( InHitZoneName )
	{
		case 'heart':
		case 'lupperarm':
		case 'rupperarm':
	 		return true;
	}

	return false;
}

defaultproperties
{
	GoreDamageGroup=DGT_AssaultRifle

	KDamageImpulse=800
	KDeathUpKick=-180
	KDeathVel=110

	StumblePower=10
	LegStumblePower=20
	GunHitPower=15

	WeaponDef=class'KFWeapDef_MA37'

	//Perk
	ModifierPerkList(0)=class'KFPerk_Commando'
}