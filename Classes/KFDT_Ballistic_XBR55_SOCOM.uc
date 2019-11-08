//=============================================================================
// Base File: KFDT_Ballistic_AR15
//=============================================================================
// Gear Shift Gaming 9/9/2019
//=============================================================================

class KFDT_Ballistic_XBR55_SOCOM extends KFDT_Ballistic_AssaultRifle
	abstract
	hidedropdown;

static simulated function bool CanDismemberHitZone( name InHitZoneName )
{
	if( super.CanDismemberHitZone( InHitZoneName ) )
	{
		return true;
	}

    switch ( InHitZoneName )
	{
		case 'lupperarm':
		case 'rupperarm':
		case 'chest':
		case 'heart':
	 		return true;
	}

	return false;
}

defaultproperties
{
	KDamageImpulse=2250
	KDeathUpKick=-400
	KDeathVel=250

    KnockdownPower=5
	StunPower=5
	StumblePower=35
	GunHitPower=30
	LegStumblePower=25

	WeaponDef=class'KFWeapDef_XBR55_SOCOM'

	//Perk
	ModifierPerkList(0)=class'KFPerk_SWAT'
}
