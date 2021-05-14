//=============================================================================
// Base File: KFWeapDef_MB500
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming 6/16/2019
//=============================================================================
class KFWeapDef_M45 extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Shotgun_M45"

	BuyPrice=1100
	AmmoPricePerMag=25 //30
	ImagePath="M45.Textures.M45_UI_v1"

	EffectiveRange=35

	UpgradePrice[0]=700
	UpgradePrice[1]=1500

	UpgradeSellPrice[0]=525
	UpgradeSellPrice[1]=1650
}
