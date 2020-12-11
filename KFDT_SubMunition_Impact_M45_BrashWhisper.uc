//=============================================================================
// Base File: KFDT_Ballistic_M45
//=============================================================================
// Ballistic damage with light impact energy, but stronger hit reactions
//=============================================================================
// Gear Shift Gaming Mods 6/19/2019
//=============================================================================

class KFDT_SubMunition_Impact_M45_BrashWhisper extends KFDT_Ballistic_Shotgun
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
	BloodSpread=0.4
	BloodScale=0.6

	KDamageImpulse=900
	KDeathUpKick=-500
	KDeathVel=350

    KnockdownPower=0
	StumblePower=15
	GunHitPower=5

	WeaponDef=class'KFWeapDef_M45_BrashWhisper'
}
