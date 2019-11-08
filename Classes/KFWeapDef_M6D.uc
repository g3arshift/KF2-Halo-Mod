//=============================================================================
// Base File: KFWeapDef_Deagle
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming Mods 7/19/2019
//=============================================================================
class KFWeapDef_M6D extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Pistol_M6D"

	BuyPrice=2500
	AmmoPricePerMag=48
	ImagePath="M6D.Textures.M6D_UI_v1"

	EffectiveRange=100
}
