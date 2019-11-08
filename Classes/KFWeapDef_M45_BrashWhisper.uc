//=============================================================================
// Base File: KFWeapDef_M45
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Gear Shift Gaming 6/16/2019
//=============================================================================
class KFWeapDef_M45_BrashWhisper extends KFWeaponDefinition
	abstract;

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Shotgun_M45_BrashWhisper"

	BuyPrice=12000
	AmmoPricePerMag=70
	ImagePath="M45_BrashWhisper.Textures.M45_BrashWhisper_UI_v1"

	EffectiveRange=5
}
