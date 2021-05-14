//=============================================================================
// Base File: KFWeapDef_Bullpup
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming 8/6/2019
//=============================================================================
class KFWeapDef_MA37 extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_AssaultRifle_MA37"

	BuyPrice=1200
	AmmoPricePerMag=36 //42
	ImagePath="MA37.Textures.MA37_UI_v1"

	EffectiveRange=60

	UpgradePrice[0]=700
	UpgradePrice[1]=1500

	UpgradeSellPrice[0]=525
	UpgradeSellPrice[1]=1650
}
