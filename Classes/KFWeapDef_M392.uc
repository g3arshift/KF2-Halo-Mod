//=============================================================================
// Base File: KFWeapDef_Bullpup
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming 3/14/2020
//=============================================================================
class KFWeapDef_M392 extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_AssaultRifle_M392"

	BuyPrice=1500
	AmmoPricePerMag=50
	ImagePath="M392.UI.M392_UI_v1"

	EffectiveRange=80

	UpgradePrice[0]=1500

	UpgradeSellPrice[0]=1125
}
