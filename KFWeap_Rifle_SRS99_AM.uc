//=============================================================================
// Base File: KFWeap_AssaultRifle_FNFal
//=============================================================================
// A high powered, four shot sniper rifle.
//=============================================================================
// Gear Shift Gaming 3/6/2020
//=============================================================================

class KFWeap_Rifle_SRS99_AM extends KFWeap_RifleBase;

var AkEvent NVG_On;
var AkEvent NVG_Off;

var KFPlayerController KFPC;
var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Friendly;
var CanvasIcon LeftNeedleCanvas, RightNeedleCanvas, RangeFinderCanvas, LeftElevCanvas, RightElevCanvas;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon LeftNeedleFlavor, RightNeedleFlavor, RangeFinderFlavor, LeftElevFlavor, RightElevFlavor;

var TextureMovie BulletMovie;

var CanvasIcon BulletCanvas, BulletMovieCanvas;
var FlavorIcon BulletFlavor, BulletMovieFlavor;
var array<int> BulletDistanceCollection;

var Halo_Weapon_UI SRS99_UI;

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	super.PlayWeaponEquip(ModifiedEquipTime);

	if(SRS99_UI == none)
	{
		SRS99_UI = New class'Halo_Weapon_UI';

		LeftNeedleFlavor = New class'FlavorIcon';
		RightNeedleFlavor = New class'FlavorIcon';
		RangeFinderFlavor = New class'FlavorIcon';
		LeftElevFlavor = New class'FlavorIcon';
		RightElevFlavor = New class'FlavorIcon';

		BulletFlavor = New class'FlavorIcon';
		BulletMovieFlavor = New class'FlavorIcon';

		LeftNeedleFlavor.MakeFlavorIcon(LeftNeedleCanvas, 483, 710, 602, 1010, 958, 950, 805, 710, 966, 1180, 1243, 710, 2083, 710, 0.25, 0.352, 0.25, 0.25, 0.494, 0.25, 0.25);
		RightNeedleFlavor.MakeFlavorIcon(RightNeedleCanvas, 1038, 710, 1389, 1010, 1516, 950, 1359, 710, 2088, 1180, 1799, 710, 2639, 710, 0.25, 0.352, 0.25, 0.25, 0.494, 0.25, 0.25);
		RangeFinderFlavor.MakeFlavorIcon(RangeFinderCanvas, 796, 771, 1044, 1090, 1277, 1011, 1117, 771, 1591 , 1301, 1556, 771, 2397, 771, 0.15269, 0.2211, 0.15269, 0.15269, 0.30718, 0.15269, 0.15269);
		LeftElevFlavor.MakeFlavorIcon(LeftElevCanvas, 388, 481, 466, 684, 868, 708, 708, 478, 776, 722, 1148, 468, 1988, 468, 0.212, 0.2857, 0.212, 0.2105, 0.40462, 0.2105, 0.2105);
		RightElevFlavor.MakeFlavorIcon(RightElevCanvas, 1505, 481, 2057, 684, 1984, 708, 1824, 478, 3011, 722, 2264, 468, 3104, 468, 0.212, 0.2857, 0.212, 0.2105, 0.40462, 0.2105, 0.2105);

		//Do not add the below to the FlavorIcon array. Each position marker is the first (top-most) bullet in the display.
		BulletFlavor.MakeFlavorIcon(BulletCanvas, 470, 793, 584, 1127, 950, 1032, 790, 792, 940, 1345, 1230, 793, 2070, 793, 0.02, 0.02972, 0.02, 0.02, 0.0405, 0.02, 0.02);
		BulletMovieFlavor.MakeFlavorIcon(BulletMovieCanvas, 470, 793, 584, 1127, 950, 1032, 790, 792, 940, 1345, 1230, 793, 2070, 793, 0.02, 0.02972, 0.02, 0.02, 0.0405, 0.02, 0.02);

		FlavorIcons.AddItem(LeftNeedleFlavor);
		FlavorIcons.AddItem(RightNeedleFlavor);
		FlavorIcons.AddItem(RangeFinderFlavor);
		FlavorIcons.AddItem(LeftElevFlavor);
		FlavorIcons.AddItem(RightElevFlavor);

		BulletMovie = TextureMovie(BulletMovieCanvas.Texture);

		KFPC = KFPlayerController(Instigator.Controller);
	}
}

//This function allows us to play a sound.
simulated function PlayWeaponSound(AkEvent Sound)
{
	if( Instigator != None && !bSuppressSounds )
	{
		if ( Sound != None && Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() )
		{
            Instigator.PlaySoundBase( Sound, true, false, false );
		}
	}
}

simulated state Reloading
{
	simulated function BeginState(name PreviousStateName)
	{
		Super.BeginState(PreviousStateName);
		KFPC.SetNightVision(false);
	}
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();
	}
}

//This is where we both create the zoom effects in canvas, and play the zoom sounds.
simulated function SetIronSights(bool bNewIronSights)
{
	local AkEvent ZoomIn;
	local AkEvent ZoomOut;

	super.SetIronSights(bNewIronSights);

	if(!bUsingSights)
	{
		ZoomOut=AkEvent'M392.Audio.Play_DMR_Zoom_Out';
		if(IsTimerActive('ZoomTimer'))
		{
			PlayWeaponSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
		KFPC.SetNightVision(false);
		Cleartimer('InitialZoom');
	}
	else
	{
		ZoomIn=AkEvent'M392.Audio.Play_DMR_Zoom_In';
		if(!IsTimerActive('ZoomTimer'))
		{
			PlayWeaponSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
		SetTimer(0.2 ,false ,'InitialZoom');
		BulletMovie.Stop();
	}
}

//This function runs continuously, and when iron sights are being used it does the drawing.
simulated function DrawHUD( HUD H, Canvas C )
{
	super.DrawHUD(H, C);

	if(KFPawn_Human(KFPC.Pawn).bFlashlightOn)
	{
		Mesh.SetMaterial(2, MaterialInstanceConstant'SRS99_AM.Materials.SRS99_AM_Screen');
	}
	else
	{
		Mesh.SetMaterial(2, MaterialInstanceConstant'SRS99_AM.Materials.SRS99_AM_Screen_NoNVG');
	}

	if(KFPawn_Human(KFPC.Pawn).bFlashlightOn)
	{
		KFPC.SetNightVision(true); //Maybe try using the Effect_NightVision Material. It's defined in FX_Mat_Lib.KF_PP_Master
		KFPC.bGamePlayDOFActive = false;

		if(!IsTimerActive('NVGOnTimer'))
		{
			SetTimer(300, false, 'NVGOnTimer');
			PlayWeaponSound(NVG_On);
			ClearTimer('NVGOffTimer');
		}
	}
	else
	{
		KFPC.SetNightVision(false);
		ClearTimer('NVGOnTimer');
		if (!IsTimerActive('NVGOffTimer') && !IsTimerActive('InitialZoom'))
		{
			PlayWeaponSound(NVG_Off);
			SetTimer(300, false, 'NVGOffTimer');
		}
	}

	if(!SRS99_UI.isInitialized)
	{
		KFPC = KFPlayerController(Instigator.Controller);
		SRS99_UI.InitializeWeaponUI_NoHeadshot(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		SRS99_UI.RunWeaponUI(C);
		SRS99_UI.DrawAmmoUI(C, 4, BulletDistanceCollection, BulletFlavor, BulletMovieFlavor, BulletMovie);
	}
}

function ZoomTimer()
{
	return;
	//This is only here to stop logging errors.
}

function InitialZoom()
{
	return;
	//This is only here to stop logging errors.
}

function NVGOnTimer()
{
	return;
	//This is only here to stop logging errors.
}

function NVGOffTimer()
{
	return;
	//This is only here to stop logging errors.
}

defaultproperties
{
	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
	MeshFOV=75
	MeshIronSightFOV=5
    PlayerIronSightFOV=20

	// Depth of field
	DOF_BlendInSpeed=3.0	
	DOF_FG_FocalRadius=0//70
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	IronSightPosition=(X=15,Y=15,Z=0) //(X=15,Y=0,Z=0)
	PlayerViewOffset=(X=-2.0,Y=11,Z=-6.0) //(X=22.0,Y=11,Z=-3.0) //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	//Test
 
	// Content
	PackageKey="SRS99-AM"
	FirstPersonMeshName="SRS99_AM.Mesh.WEP_1stP_SRS99_AM_Rig"
	FirstPersonAnimSetNames(0)="SRS99_AM.1stp_anims.Wep_1stP_SRS99_AM_Anim"
	PickupMeshName="SRS99_AM.Mesh.SRS99_AM_Static"
	AttachmentArchetypeName="SRS99_AM.Arch.Wep_SRS99_AM_3P"
	MuzzleFlashTemplateName="WEP_M99_ARCH.Wep_M99_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=4
	SpareAmmoCapacity[0]=32 //24
	InitialSpareMags[0]=2
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=765 //900 //1200
	minRecoilPitch=440 //500 //775
	maxRecoilYaw=400 //800
	minRecoilYaw=-200 //500
	RecoilRate=0.085
	RecoilMaxYawLimit=500 //500
	RecoilMaxPitchLimit=600 //900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=150 //150
	RecoilISMinYawLimit=65385
	RecoilISMaxPitchLimit=275 //375
	RecoilISMinPitchLimit=65460
	RecoilViewRotationScale=0.8
	FallingRecoilModifier=1.0
	HippedRecoilModifier=3.0
	IronSightMeshFOVCompensationScale=5.0

	NVG_On = AkEvent'SRS99_AM.Audio.Play_SRS99_NVG_On'
	NVG_Off = AkEvent'SRS99_AM.Audio.Play_SRS99_NVG_Off'

	// Inventory
	InventorySize=10
	GroupPriority=150
	WeaponSelectTexture=Texture2D'SRS99_AM.UI.SRS99_AM_UI_v1'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_SRS99_AM'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_SRS99_AM'
	FireInterval(DEFAULT_FIREMODE)=0.69 //0.66
	PenetrationPower(DEFAULT_FIREMODE)=10 //5.0
	Spread(DEFAULT_FIREMODE)=0.0
	InstantHitDamage(DEFAULT_FIREMODE)=575.0 //500 //475 //550.0 //950

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	FireOffset=(X=30,Y=4.5,Z=-5)

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_SRS99_AM'
	InstantHitDamage(BASH_FIREMODE)=33

	//Custom Animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v3)

	// AI warning system
	bWarnAIWhenAiming=true
	AimWarningDelay=(X=0.4f, Y=0.8f)
	AimWarningCooldown=0.0f

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'SRS99_AM.Audio.Play_SRS99_AM_Fire_3P', FirstPersonCue=AkEvent'SRS99_AM.Audio.Play_SRS99_AM_Fire_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'BR55.Audio.Play_BR55_Fire_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'

	UIBackgrounds[0] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_16_9_v2'
	UIBackgrounds[4] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_32_9_v2'

	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=638, V=161, UL=64, VL=64)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=703, V=161, UL=64, VL=64)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=768, V=161, UL=64, VL=64)

	BulletCanvas = (Texture=Texture2D'SRS99_AM.UI.SRS99_AM_New_Bullet', U=0, V=125, UL=3600, VL=950)
	BulletMovieCanvas = (Texture=TextureMovie'SRS99_AM.UI.SRS99_AM_New_Bullet', U=0, V=125, UL=3600, VL=950)

	LeftNeedleCanvas = (Texture=Texture2D'SRS99_AM.UI.SRS99_AM_Sight_HD_v2', U=244, V=3281, UL=1595, VL=76)
	RightNeedleCanvas = (Texture=Texture2D'SRS99_AM.UI.SRS99_AM_Sight_HD_v2', U=244, V=3002, UL=1595, VL=76)
	RangeFinderCanvas = (Texture=Texture2D'SRS99_AM.UI.SRS99_AM_Sight_HD_v2', U=30, V=7, UL=2004, VL=2116)
	LeftElevCanvas = (Texture=Texture2D'SRS99_AM.UI.SRS99_AM_Sight_HD_v2', U=2205, V=108, UL=137, VL=2380)
	RightElevCanvas = (Texture=Texture2D'SRS99_AM.UI.SRS99_AM_Sight_HD_v2', U=2397, V=108, UL=137, VL=2380)

	BulletDistanceCollection[0] = 24 //12 //4_3
	BulletDistanceCollection[1] = 40 //20 //5_4
	BulletDistanceCollection[2] = 32 //16 //3_2
	BulletDistanceCollection[3] = 24 //12 //16_9
	BulletDistanceCollection[4] = 60 //40 //20 //16_10
	BulletDistanceCollection[5] = 24 //12 //21_9
	BulletDistanceCollection[6] = 24 //12 //32_9
}
