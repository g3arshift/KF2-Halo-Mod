// Created by Crowbar 0.56

$modelname "v_models\v_desert_eagle.mdl"

$bodygroup "v_pistol_magnum"
{
	studio "v_desert_eagle_h5_ce_magnum.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -2.02 -17.297 -32.156

$cdmaterials "models\weapons\halo\m6d\ce\"

$attachment "shell" "ValveBiped.weapon_bone" 0 3.7 1.1 rotate 0 150 110
$attachment "attach_muzzle" "ValveBiped.weapon_bone" 0 3.45 5.4 rotate -90 0 0
$attachment "muzzle_flash" "ValveBiped.attach_muzzle" -1.5 0.2 0 rotate 0 0 0
$attachment "flashlight" "ValveBiped.weapon_bone" 0 4.65 5.28 rotate -90 0 0
$attachment "attach_camera" "ValveBiped.attach_camera" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -8.219 -8.285 -64 42.813 4.245 -0.313

$definebone "ValveBiped.ValveBiped" "" 0 0 0 0 0 89.999976 0 0 0 0 0 0
$definebone "ValveBiped.Bip01" "ValveBiped.ValveBiped" 0 37.739231 -0.516773 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Camera" "ValveBiped.ValveBiped" 0 56.084805 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone" "ValveBiped.Bip01" 8.329032 7.655514 0 -89.99999 -89.745961 0 0 0 0 0 0 0
$definebone "ValveBiped.attach_muzzle" "ValveBiped.weapon_bone" 0 0.099715 8.360889 -89.99999 0 0 0 0 0 0 0 0
$definebone "ValveBiped.attach_shell_eject" "ValveBiped.weapon_bone" 0 3.003861 1.610714 0 90.00001 -90.00001 0 0 0 0 0 0
$definebone "ValveBiped.attach_camera" "ValveBiped.Camera" 0 0 0 -89.99999 0.000003 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01" 0 4.043964 -0.017929 4.766603 89.999983 89.999983 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 3.995838 0 0 0 -9.852983 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 3.698238 0 0 0 -0.906993 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine4" "ValveBiped.Bip01_Spine2" 5.700886 0 0 0 28.371672 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 4.065395 1.458945 1.5 -63.875288 -147.035792 50.277508 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.507359 0.000004 0.000001 -19.730431 -44.165479 -79.348289 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.907391 0 0.000004 -0.000009 -7.20248 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 10.424316 -0.000007 -0.000031 6.507305 7.12267 78.669799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.997272 0.005413 -1.477472 8.213351 -12.990153 11.742421 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.51038 -0.000002 0 0.955238 -34.374608 0.6534 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.808647 0.000001 0 -10.048539 -17.354266 -3.121074 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.305794 0.20311 -0.546729 5.954121 -16.778208 11.337857 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.807177 0 0 -5.06346 -30.512982 -2.977604 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.966141 -0.000001 0 0.559035 -13.904483 0.138369 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.571516 0.109303 0.40958 3.893592 -14.79107 10.730298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 2.150654 0 0 -3.092657 -37.967178 -2.410835 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.152744 0.000001 0 0.688637 -8.970351 0.10869 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.684093 -0.158703 1.419181 1.961119 -11.693717 10.352718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.70101 0 0 3.669051 -38.756246 2.94082 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.994709 0.000002 0 2.209325 -1.89655 0.073166 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 1.068075 -1.287205 0.981903 -19.741839 -7.111203 97.051422 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.836302 0.000003 -0.000002 -10.77842 -10.615982 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.223946 -0.000001 0 -2.32884 11.24906 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 4.065392 1.458947 -1.5 63.875294 -147.035778 -54.583283 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.507362 -0.000008 -0.000001 22.698469 -42.953708 82.694993 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.907394 0.000001 -0.000008 0.000012 -7.202481 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 10.424301 -0.000005 0.000015 -6.507533 7.122611 -78.876985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.997293 0.000065 1.477481 -8.213406 -12.989924 -11.535193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.51038 -0.000002 0 -0.955233 -34.374635 -0.6534 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.808651 0 0 10.048533 -17.354293 3.121074 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.305807 0.201134 0.547461 -5.954235 -16.777982 -11.130627 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.807178 -0.000002 0 5.063458 -30.512989 2.977605 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.966137 -0.000001 0 -0.559036 -13.904488 -0.138369 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.571524 0.110785 -0.409182 -3.893706 -14.790905 -10.523121 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 2.15066 0.000002 0 3.092654 -37.967191 2.410836 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.152756 0 0 -0.688638 -8.970363 -0.108691 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.684111 -0.153564 -1.419746 -1.961176 -11.693491 -10.145487 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.701017 0.000004 0 -3.669048 -38.756252 -2.940821 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.994705 0 0 -2.20932 -1.896556 -0.073165 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 1.068094 -1.283655 -0.986553 19.767271 -7.037118 -96.832918 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.836308 -0.000001 0.000002 10.778427 -10.615992 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.223946 -0.000001 0.000002 2.328847 11.249042 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_charger_slide" "ValveBiped.weapon_bone" 0 1.945634 -1.740829 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_stock_hammer" "ValveBiped.weapon_bone" 0 1.092286 -2.833118 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bolt" "ValveBiped.weapon_bone" 0 1.945635 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_safety" "ValveBiped.weapon_bone" 0 1.228824 1.706703 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_trigger" "ValveBiped.weapon_bone" 0 0.375472 1.570164 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_clip_realease" "ValveBiped.weapon_bone" 0 -0.000002 3.037922 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_clip" "ValveBiped.weapon_bone" 0 -0.000002 3.857136 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.weapon_clip_bullets" "ValveBiped.weapon_clip" 0 -0.876005 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm_driven" "ValveBiped.Bip01_R_Forearm" 3.201996 0 -0.000004 -5.999999 7.000002 -78.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Driven_ulna" "ValveBiped.Bip01_R_Forearm" 6.694 0 -0.000004 -6.014998 7.006003 -78.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_thumbroot" "ValveBiped.Bip01_R_Hand" 0.109995 -0.821001 -0.907 20.664997 -17.516001 -104.524011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm_driven" "ValveBiped.Bip01_L_Forearm" 3.257999 -0.031 0 5.999998 7.000002 78.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Driven_ulna" "ValveBiped.Bip01_L_Forearm" 6.867996 0 0 5.999998 7.000002 78.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_thumbroot" "ValveBiped.Bip01_L_Hand" 0.084999 -0.691999 1.011 26.039005 111.970004 -76.421 0 0 0 0 0 0

$bonemerge "ValveBiped.ValveBiped"
$bonemerge "ValveBiped.Bip01"
$bonemerge "ValveBiped.Camera"
$bonemerge "ValveBiped.weapon_bone"
$bonemerge "ValveBiped.attach_muzzle"
$bonemerge "ValveBiped.attach_shell_eject"
$bonemerge "ValveBiped.attach_camera"
$bonemerge "ValveBiped.Bip01_Spine"
$bonemerge "ValveBiped.Bip01_Spine1"
$bonemerge "ValveBiped.Bip01_Spine2"
$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Forearm_driven"
$bonemerge "ValveBiped.Bip01_R_Driven_ulna"
$bonemerge "ValveBiped.Bip01_R_thumbroot"
$bonemerge "ValveBiped.Bip01_L_Forearm_driven"
$bonemerge "ValveBiped.Bip01_L_Driven_ulna"
$bonemerge "ValveBiped.Bip01_L_thumbroot"


$poseparameter "move_x" -1 1 loop 0

$animation "a_idle_1" "v_desert_eagle_anims\a_idle_1.smd" {
	fps 30
	loop
}

$animation "a_run" "v_desert_eagle_anims\a_run.smd" {
	fps 30
	loop
}

$sequence "idle" {
	"a_run"
	"a_idle_1"
	"a_run"
	activity "ACT_VM_IDLE" 1
	blend "move_x" -1 1
	blendwidth 3
	fadein 0.2
	fadeout 0.2
}

$sequence "idle_layer" {
	"v_desert_eagle_anims\idle_layer.smd"
	activity "ACT_VM_IDLE_LAYER" 1
	delta
	// This subtract option added by Crowbar to prevent jigglebone problems when delta sequences are recompiled.
	subtract "idle_layer" 0
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "deploy" {
	"v_desert_eagle_anims\deploy.smd"
	activity "ACT_VM_DEPLOY" 1
	fadein 0.2
	fadeout 0.2
	fps 35
}

$sequence "deploy_layer" {
	"v_desert_eagle_anims\deploy_layer.smd"
	activity "ACT_VM_DEPLOY_LAYER" 1
	delta
	// This subtract option added by Crowbar to prevent jigglebone problems when delta sequences are recompiled.
	subtract "deploy_layer" 0
	{ event 5004 8 "Magnum.SlideBack" }
	{ event 5004 16 "Magnum.SlideForward" }
	fadein 0.2
	fadeout 0.2
	fps 35
}

$sequence "fire" {
	"v_desert_eagle_anims\fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event AE_MUZZLEFLASH 0 "1" }
	{ event AE_CL_CREATE_PARTICLE_BRASS 1 "weapon_shell_casing_9mm" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_smoke_sniper_extra follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_glow follow_attachment muzzle_flash" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire_layer" {
	"v_desert_eagle_anims\fire_layer.smd"
	activity "ACT_VM_PRIMARYATTACK_LAYER" 1
	delta
	// This subtract option added by Crowbar to prevent jigglebone problems when delta sequences are recompiled.
	subtract "fire_layer" 0
	{ event AE_MUZZLEFLASH 0 "1" }
	{ event AE_CL_CREATE_PARTICLE_BRASS 1 "weapon_shell_casing_9mm" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_smoke_sniper_extra follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_glow follow_attachment muzzle_flash" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload" {
	"v_desert_eagle_anims\reload.smd"
	activity "ACT_VM_RELOAD" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_layer" {
	"v_desert_eagle_anims\reload_layer.smd"
	activity "ACT_VM_RELOAD_LAYER" 1
	{ event 5004 18 "Magnum.ClipOut" }
	{ event 5004 36 "Magnum.ClipIn" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_empty" {
	"v_desert_eagle_anims\reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	fadein 0
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload_empty_layer" {
	"v_desert_eagle_anims\reload_empty_layer.smd"
	activity "ACT_VM_RELOAD_EMPTY_LAYER" 1
	{ event 5004 18 "Magnum.ClipOut" }
	{ event 5004 36 "Magnum.ClipIn" }
	{ event 5004 48 "Magnum.SlideForward" }
	fadein 0
	fadeout 0.2
	snap
	fps 30
}

$sequence "fire_last" {
	"v_desert_eagle_anims\fire_last.smd"
	{ event AE_MUZZLEFLASH 0 "1" }
	{ event AE_CL_CREATE_PARTICLE_BRASS 1 "weapon_shell_casing_9mm" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_smoke_sniper_extra follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_glow follow_attachment muzzle_flash" }
	fadein 0.2
	fadeout 0
	snap
	fps 30
}

$sequence "fire_last_layer" {
	"v_desert_eagle_anims\fire_last_layer.smd"
	activity "ACT_VM_DRYFIRE" 1
	delta
	// This subtract option added by Crowbar to prevent jigglebone problems when delta sequences are recompiled.
	subtract "fire_last_layer" 0
	{ event AE_MUZZLEFLASH 0 "1" }
	{ event AE_CL_CREATE_PARTICLE_BRASS 1 "weapon_shell_casing_9mm" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_sparks_pistol follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_smoke_sniper_extra follow_attachment muzzle_flash" }
	{ event AE_CL_CREATE_PARTICLE_EFFECT 0 "muzzle_glow follow_attachment muzzle_flash" }
	fadein 0.2
	fadeout 0
	snap
	fps 30
}

$sequence "melee" {
	"v_desert_eagle_anims\melee.smd"
	activity "ACT_VM_MELEE" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "melee_layer" {
	"v_desert_eagle_anims\melee_layer.smd"
	activity "ACT_VM_MELEE_LAYER" 1
	delta
	// This subtract option added by Crowbar to prevent jigglebone problems when delta sequences are recompiled.
	subtract "melee_layer" 0
	{ event 5004 19 "Magnum.deploy" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}
