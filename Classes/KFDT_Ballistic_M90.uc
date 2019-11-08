//=============================================================================
// Base File: KFDT_Ballistic_MB500
//=============================================================================
// Ballistic damage with light impact energy, but stronger hit reactions
//=============================================================================
// Gear Shift Gaming Mods 6/13/2019
//=============================================================================

class KFDT_Ballistic_M90 extends KFDT_Ballistic_Shotgun
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
	BloodSpread=0.6
	BloodScale=0.8

	KDamageImpulse=900
	KDeathUpKick=-500
	KDeathVel=600 //600

	//Obliteration
	/*
	GoreDamageGroup=DGT_Shotgun
	RadialDamageImpulse=100.f // This controls how much impulse is applied to gibs when exploding
	bUseHitLocationForGibImpulses=true // This will make the impulse origin where the victim was hit for directional gibs
	bPointImpulseTowardsOrigin=true
	ImpulseOriginScale=10.f // Higher means more directional gibbing, lower means more outward (and upward) gibbing
	ImpulseOriginLift=15.f
	MaxObliterationGibs=20 // Maximum number of gibs that can be spawned by obliteration, 0=MAX
	bCanGib=true
	bCanObliterate=true
	ObliterationHealthThreshold=0
	ObliterationDamageThreshold=1000
	*/

    KnockdownPower=0
	StumblePower=15
	GunHitPower=0

	WeaponDef=class'KFWeapDef_M90'
}
