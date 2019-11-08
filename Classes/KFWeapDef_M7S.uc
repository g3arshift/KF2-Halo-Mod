//=============================================================================
// KFWeaponDefintion
//=============================================================================
// A lightweight container for basic weapon properties that can be safely
// accessed without a weapon actor (UI, remote clients). 
//=============================================================================
// Killing Floor 2
// Copyright (C) 2016 Tripwire Interactive LLC
//=============================================================================
class KFWeapDef_M7S extends KFWeaponDefinition
	abstract;

	static function string GetItemName()
{
    return "M7S SMG";
}

    static function string GetItemCategory()
{
        return "Sub Machine Gun";
}

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_SMG_M7S"

	BuyPrice=2500
	AmmoPricePerMag=50
	ImagePath="M7S.Textures.M7S_UI_v1"

	EffectiveRange=70

    //UpgradePrice[0]=1750

	//UpgradeSellPrice[0]=2100
}