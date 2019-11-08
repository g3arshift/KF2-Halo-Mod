//=============================================================================
// Base File: KFDT_Ballistic_AR15
//=============================================================================
// Gear Shift Gaming 9/9/2019
//=============================================================================

class KFDT_Ballistic_BR55 extends KFDT_Ballistic_Rifle
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
	StunPower=20
	StumblePower=0
	GunHitPower=60

	WeaponDef=class'KFWeapDef_BR55'

	//Perk
	ModifierPerkList(0)=class'KFPerk_Sharpshooter'
}
