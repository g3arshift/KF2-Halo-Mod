// Created by Crowbar 0.34.0.0

$ModelName "w_models/weapons/w_desert_rifle.mdl"

$BodyGroup "rig_sg552"
{
	studio "w_desert_rifle_reference.smd"
}


$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\h2_battlerifle\"

$Attachment "flashlight" "ValveBiped.weapon_bone" 0.1 2.5 19.8 rotate 0 0 0
$Attachment "shell" "ValveBiped.weapon_bone" -0.3 4.2 -0.2 rotate 0 159 90
$Attachment "muzzle_flash" "ValveBiped.weapon_bone" 0.1 3.6 19.9 rotate -90 -90 0

$CBox 0 0 0 0 0 0

$BBox -10.096 -1.216 -4.255 27.058 2.219 7.675


$Sequence "idle" {
	"w_desert_rifle_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "w_desert_rifle_physics.smd"
{
	$mass 6
	$inertia 1
	$damping 0
	$rotdamping 0

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Small"
	}
}
