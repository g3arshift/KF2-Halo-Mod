//=============================================================================
// Base File: KFDT_Ballistic_FNFal
//=============================================================================
//
//=============================================================================
// Gear Shift Gaming 3/6/2020
//=============================================================================

class KFDT_Ballistic_SRS99_AM extends KFDT_Ballistic_Rifle
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

    KnockdownPower=20
	StunPower=10 //40 //8
	StumblePower=18
	GunHitPower=50 //50
	MeleeHitPower=0

	WeaponDef=class'KFWeapDef_SRS99_AM'

	//Perk
	ModifierPerkList(0)=class'KFPerk_Sharpshooter'
}
