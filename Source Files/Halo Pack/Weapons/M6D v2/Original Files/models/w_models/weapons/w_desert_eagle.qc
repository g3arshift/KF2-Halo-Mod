// Created by Crowbar 0.56

$modelname "w_models\Weapons\w_desert_eagle.mdl"

$bodygroup "HCE M6D"
{
	studio "w_desert_eagle_ce_magnum_w.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0.113 -4.025 1.187

$cdmaterials "models\weapons\halo\m6d\ce\"

$attachment "shell_eject" "ValveBiped.weapon_bone" 0.1 2.7 0.7 rotate -5 165 145
$attachment "flashlight" "ValveBiped.weapon_bone" 0.1 3.4 5.45 rotate 0 0 0
$attachment "muzzle_flash" "ValveBiped.weapon_bone" 0.1 2.2 5.6 rotate -90 0 0

$cbox 0 0 0 0 0 0

$bbox 0 -0.868 -2.345 10.692 0.87 4.081

$definebone "ValveBiped.weapon_bone" "" 0 1.3912 2.368618 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.pasted__pistol_R" "ValveBiped.weapon_bone" 0 -1.391199 -2.368619 0 0 0 0 0 0 0 0 0


$sequence "idle" {
	"w_desert_eagle_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "w_desert_eagle_physics.smd"
{
	$mass 5
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Small"
	}
}
