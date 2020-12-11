//=============================================================================
// Base File: KFWeapDef_M79
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shfit Gaming 6/28/2019
//=============================================================================
class KFWeapDef_M319 extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_GrenadeLauncher_M319"

	BuyPrice=1500
	AmmoPricePerMag=28
	ImagePath="M319.Textures.M319_UI_v1"

	EffectiveRange=100

	UpgradePrice[0]=1500

	UpgradeSellPrice[0]=1125
}
