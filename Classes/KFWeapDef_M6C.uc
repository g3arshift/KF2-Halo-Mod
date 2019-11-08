class KFWeapDef_M6C extends KFWeaponDefinition
	abstract;

	static function string GetItemName()
{
    return "M6C";
}

    static function string GetItemCategory()
{
        return "Pistol";
}

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Pistol_M6C"

	BuyPrice=200
	AmmoPricePerMag=10
	ImagePath="M6C.Textures.M6C_UI_v1"

	EffectiveRange=50

	UpgradePrice[0]=600
	UpgradePrice[1]=700
	UpgradePrice[2]=1100

	UpgradeSellPrice[0]=450
	UpgradeSellPrice[1]=600
	UpgradeSellPrice[2]=700
}