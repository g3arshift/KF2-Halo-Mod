// Created by Crowbar 0.34.0.0

$ModelName "v_models\v_desert_rifle.mdl"

$BodyGroup "v_BR"
{
	studio "battle_rifle.smd"
}

$include "QCIs\definebones.qci"
$include "QCIs\bonemerge.qci"

//game told me to do this:
$bonemerge "ValveBiped.weapon_bone" 

$origin 0 0 0

$SurfaceProp "default"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\h2_battlerifle\"

$attachment "attach_muzzle" "tag_weapon" 18.00 -0.03 1.90 rotate -0 0 0
$attachment "muzzle_flash" "tag_weapon" 18.00 -0.03 1.90 rotate -0 0 0
$attachment "shell" "tag_weapon" -0.51 -0.70 2.70 rotate -41 179 -1
$attachment "flashlight" "tag_weapon" 15.60 1.40 1.15 rotate -0 0 0

$CBox 0 0 0 0 0 0

$BBox -18.341 -29.447 -65.5 27.397 24.345 70.628

// $HBoxSet "default"

$PoseParameter "ver_aims" -1 1 0
$PoseParameter "move_x" -1 1 0

$Animation "idle_delta" "battlerifle_anims\a_sniper_pose_neutral.smd" {
	fps 30
}

$Animation "look_down" "battlerifle_anims\a_sniper_arms_trans_down.smd" {
	fps 30
}

$Animation "look_mid" "battlerifle_anims\a_sniper_arms_trans.smd" {
	fps 30
}

$Animation "look_up" "battlerifle_anims\a_sniper_arms_trans_up.smd" {
	fps 30
}

$Animation "a_idle_1" "battlerifle_anims\ta_sniper_idle.smd" {
	fps 30
}

$Animation "a_run" "battlerifle_anims\ta_sniper_run_trans_run.smd" {
	fps 30
	loop
}

$Sequence "look_poses" {
	"look_down"
	"look_mid"
	"look_up"
	blend "ver_aims" -1 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "idle_raw" {
	"battlerifle_anims\ta_sniper_run_trans_idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "idle" {
	"a_run"
	"a_idle_1"
	"a_run"
	activity "ACT_VM_IDLE" 1
	blend "move_x" -1 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$Sequence "deploy" {
	"battlerifle_anims\sniper_pickup_partial3.smd"
	activity "ACT_VM_DEPLOY" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "deploy_layer" {
	"battlerifle_anims\sniper_pickup_partial3.smd"
	activity "ACT_VM_DEPLOY_LAYER" 1
	{ event 5004 1.99999982118607 "Rifle_Desert.Deploy" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "fire" {
	"battlerifle_anims\sniper_shoot1.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event AE_MUZZLEFLASH 0 "1" }
	fadein 0.2
	fadeout 0.2
	fps 20
}

$Sequence "fire_layer" {
	"battlerifle_anims\sniper_shoot1.smd"
	activity "ACT_VM_PRIMARYATTACK_LAYER" 1
	{ event AE_MUZZLEFLASH 0 "1" }
	{ event AE_CL_CREATE_PARTICLE_BRASS 1 "weapon_shell_casing_9mm shell" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_rifle follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "weapon_muzzle_flash_huntingrifle_FP follow_attachment attach_muz" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "weapon_muzzle_flash_smg_silenced follow_attachment muzzle_flash" }
	fadein 0.2
	fadeout 0.2
	fps 20
}

$Sequence "reload" {
	"battlerifle_anims\sniper_reload1.smd"
	activity "ACT_VM_RELOAD" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "reload_layer" {
	"battlerifle_anims\sniper_reload1.smd"
	activity "ACT_VM_RELOAD_LAYER" 1
	{ event 5004 26.0000006258488 "Rifle_Desert.ClipOut" }
	{ event 5004 77.9999976754189 "Rifle_Desert.ClipIn" }
	fadein 0
	fadeout 0.2
	fps 30
}

$Sequence "melee" {
	"battlerifle_anims\sniper_melee.smd"
	activity "ACT_VM_MELEE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "melee_layer" {
	"battlerifle_anims\sniper_melee.smd"
	activity "ACT_VM_MELEE_LAYER" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}
