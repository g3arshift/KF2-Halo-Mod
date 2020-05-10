//=============================================================================
// Base File: KFWeapDef_MB500
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming 6/13/2019
//=============================================================================
class KFWeapDef_M90 extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Shotgun_M90"

	BuyPrice=2500
	AmmoPricePerMag=93 //90 //54
	ImagePath="M90_CAWS.Textures.M90_CAWS_UI_v1"

	EffectiveRange=15

	/*
	UpgradePrice[0]=500
	UpgradePrice[1]=600
	UpgradePrice[2]=700
	UpgradePrice[3]=1500

	UpgradeSellPrice[0]=375
	UpgradeSellPrice[1]=825
	UpgradeSellPrice[2]=1350
	UpgradeSellPrice[3]=2475
	*/
}
