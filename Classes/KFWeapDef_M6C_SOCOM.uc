class KFWeapDef_M6C_SOCOM extends KFWeaponDefinition
	abstract;

	static function string GetItemName()
{
    return "M6C/SOCOM";
}

    static function string GetItemCategory()
{
        return "Pistol";
}

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Pistol_M6C_SOCOM"

	BuyPrice=650
	AmmoPricePerMag=20
	ImagePath="M6C-SOCOM.Textures.M6S_UI_v1"

	EffectiveRange=75

	UpgradePrice[0]=600
	UpgradePrice[1]=700
	UpgradePrice[2]=1500

	UpgradeSellPrice[0]=450
	UpgradeSellPrice[1]=975
	UpgradeSellPrice[2]=2100
}