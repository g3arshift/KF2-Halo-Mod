class KFWeapDef_M6CDual extends KFWeaponDefinition
	abstract;

	static function string GetItemName()
{
    return "Dual M6C's";
}

    static function string GetItemCategory()
{
        return "Pistol";
}

DefaultProperties
{
	WeaponClassPath="HaloMod_Weapons.KFWeap_Pistol_M6CDual"

	BuyPrice=400
	AmmoPricePerMag=20
	ImagePath="M6C.Textures.Dual_M6C_UI_v1"

	EffectiveRange=50

	UpgradePrice[0]=600
	UpgradePrice[1]=900
	UpgradePrice[2]=1100

	UpgradeSellPrice[0]=450
	UpgradeSellPrice[1]=600
	UpgradeSellPrice[2]=700
}