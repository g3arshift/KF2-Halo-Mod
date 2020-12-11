class KFDT_Ballistic_M6C extends KFDT_Ballistic_Handgun
	abstract
	hidedropdown;

defaultproperties
{
	KDamageImpulse=1500
	KDeathUpKick=-450
	KDeathVel=200

	KnockdownPower=15
	StumblePower=10
	GunHitPower=50

	WeaponDef=class'KFWeapDef_M6C'
}
