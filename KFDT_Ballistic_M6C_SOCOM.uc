class KFDT_Ballistic_M6C_SOCOM extends KFDT_Ballistic_Handgun
	abstract
	hidedropdown;

defaultproperties
{
	KDamageImpulse=1500
	KDeathUpKick=-450
	KDeathVel=200

	KnockdownPower=30 //20
	StumblePower=50 //30
	GunHitPower=40 //30

	WeaponDef=class'KFWeapDef_M6C_SOCOM'
	ModifierPerkList(0)=class'KFPerk_SWAT'
	ModifierPerkList(1)=class'KFPerk_Sharpshooter'
}
