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

	BuyPrice=2500
	AmmoPricePerMag=60
	ImagePath="M41.UI.M41_UI_v1"

	EffectiveRange=100
}
