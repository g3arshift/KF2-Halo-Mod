// Created by Crowbar 0.56

$modelname "w_models\Weapons\w_shotgun.mdl"

$bodygroup "main"
{
	studio "w_shotgun_m90.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0.564 -9.598 1.201

$cdmaterials "models\halo\Weapons\m90\"
$cdmaterials "models\w_models\tac_light\"

$attachment "muzzle_flash" "ValveBiped.weapon_bone" 0.5 3 27.2 rotate -90 0 0
$attachment "flashlight" "ValveBiped.weapon_bone" 0.5 1 21.6 rotate 0 0 0
$attachment "shell" "ValveBiped.weapon_bone" -0.67 1.8 10.5 rotate 0 -180 45

$cbox 0 0 0 0 0 0

$bbox -11.278 -0.522 -3.04 33.578 2.747 5.152

$definebone "ValveBiped.w_pump_shotgun" "" 0 0 0 0 0 90.000003 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone" "ValveBiped.w_pump_shotgun" 0.012708 0.802704 2.049373 0 -0.906992 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_pump" "ValveBiped.weapon_bone" 0.010717 1.703425 19.538542 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.polySurface167" "ValveBiped.weapon_bone_pump" -0.010717 -2.50623 -21.587915 0 0.906992 0 0 0 0 0 0 0
$definebone "ValveBiped.polySurface168" "ValveBiped.weapon_bone" 0 -0.802805 -2.049373 0 0.906992 0 0 0 0 0 0 0


$sequence "idle" {
	"w_shotgun_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$collisionmodel "w_shotgun_physics.smd"
{
	$mass 10
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Medium"
	}
}
