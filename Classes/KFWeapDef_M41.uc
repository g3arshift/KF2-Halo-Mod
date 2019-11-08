//=============================================================================
// Base File: KFWeapDef_RPG7
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================
class KFWeapDef_M41 extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_RocketLauncher_M41"

	BuyPrice=1500
	AmmoPricePerMag=30
	ImagePath="WEP_UI_RPG7_TEX.UI_WeaponSelect_RPG7"

	EffectiveRange=100

	UpgradePrice[0]=1500

	UpgradeSellPrice[0]=1125
}
