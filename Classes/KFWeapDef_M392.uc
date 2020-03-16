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
	WeaponClassPath="HaloPack_Weapons.KFWeap_AssaultRifle_M392"

	BuyPrice=650
	AmmoPricePerMag=30
	ImagePath="ui_weaponselect_tex.UI_WeaponSelect_Bullpup"

	EffectiveRange=68

	UpgradePrice[0]=600
	UpgradePrice[1]=700
	UpgradePrice[2]=1500

	UpgradeSellPrice[0]=450
	UpgradeSellPrice[1]=975
	UpgradeSellPrice[2]=2100
}
