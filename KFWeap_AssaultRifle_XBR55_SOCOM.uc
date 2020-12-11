//=============================================================================
// Base File: KFWeap_AssaultRifle_AR15
//=============================================================================
// Gear Shift Gaming 9/9/2019
//=============================================================================

class KFWeap_AssaultRifle_XBR55_SOCOM extends KFWeap_RifleBase;

var KFPlayerController KFPC;
var float RefireDelayAmount;

//1 is the left display
//0 is the right display.
var float AmmoRed, AmmoYellow;
var Standard_Ammo_Display XBR55_Display;

var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Headshot, Reticle_Friendly;
var CanvasIcon RangeCanvasIcon, ZoomCanvasIcon;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon RangeFlavorIcon;
var FlavorIcon ZoomFlavorIcon;

var Halo_Weapon_UI XBR55_UI;

var AkEvent NVG_On;
var AkEvent NVG_Off;

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

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	Super.PlayWeaponEquip( ModifiedEquipTime );
	if(KFPC == None )
	{
		KFPC = KFPlayerController(Instigator.Controller);
	}

	if(XBR55_Display == none)
	{
		XBR55_Display = New class'Standard_Ammo_Display';
	}

	XBR55_Display.InitializeDisplay(KFPC, 1, 0, AmmoYellow, AmmoRed);
	XBR55_Display.RunDisplay(Mesh);

	if(XBR55_UI == none)
	{
		XBR55_UI = New class'Halo_Weapon_UI';
		RangeFlavorIcon = New class'FlavorIcon';
		RangeFlavorIcon.MakeFlavorIcon(RangeCanvasIcon, 673, 433, 922, 666, 1082, 602, 922, 362, 1448, 728, 1362, 362, 2202, 362, 0.2, 0.25, 0.25, 0.25, 0.33, 0.25, 0.25);
		ZoomFlavorIcon = New class'FlavorIcon';
		ZoomFlavorIcon.MakeFlavorIcon(ZoomCanvasIcon, 1281, 937, 1668, 1306, 1828, 1242, 1667, 1002, 2433, 1573, 2108, 1002, 2948, 1002, 0.45161, 0.45161, 0.45161, 0.45161, 0.593548, 0.45161, 0.45161);
		FlavorIcons.AddItem(RangeFlavorIcon);
		FlavorIcons.AddItem(ZoomFlavorIcon);
	}

}

simulated state WeaponBurstFiring
{
	//This allows us to manually control the delay between bursts.
	simulated function EndState(Name NextStateName)
	{
		super.EndState(NextStateName);
		if(!IsTimerActive('RefireDelayTimer'))
		{
			RefireDelayAmount = FireInterval[CurrentFireMode] * 0.6 + (FireInterval[CurrentFireMode] * 3.0); //+ (FireInterval[CurrentFireMode] * 2.5);
			SetTimer(RefireDelayAmount, false, 'RefireDelayTimer');
		}
	}

	simulated function FireAmmunition()
	{
		if(!IsTimerActive('RefireDelayTimer'))
		{
			super.FireAmmunition();
		}

		if( AmmoCount[0] == 0 )
		{
			CurrentFireMode = RELOAD_FIREMODE;
		}
	}
}

//This function is almost identical to the original in KFWeapon, but we're overriding it to enable fast reloading at or below 10 bullets.
simulated function TimeWeaponReloading()
{

	local name AnimName;
	local float AnimLength, AnimRate;
	local float AmmoTimer, StatusTimer;
	local float SpeedReloadRate;

	ReloadStatus = GetNextReloadStatus();

	// If we're finished exit reload
	if ( ReloadStatus == RS_Complete || MySkelMesh == None )
	{
		ReloadComplete();
		return;
	}

    // get desired animation and play-rate
    AnimName = GetReloadAnimName( UseTacticalReload() );

    if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoRed && AmmoCount[0] > 0)
    {
    	//`log("You did a fast reload, good job!");
    	SpeedReloadRate = GetReloadRateScale() * 0.15; //The percentage to add to the rate the reload takes. If you set it to 0.15, it reloads 15% faster.
    	AnimRate = GetReloadRateScale() - SpeedReloadRate;
    }
    else
    {
    	AnimRate = GetReloadRateScale();
    }
	AnimLength = AnimRate * MySkelMesh.GetAnimLength(AnimName);

	if ( AnimLength > 0.f )
	{
		MakeNoise(0.5f,'PlayerReload'); // AI

		if ( Instigator.IsFirstPerson() )
		{
			PlayAnimation(AnimName, AnimLength);
		}

		// Start timer for when to give ammo (aka 'PerformReload')
		if ( ReloadStatus == RS_Reloading )
		{
			AmmoTimer = AnimRate * MySkelMesh.GetReloadAmmoTime(AnimName);
			SetTimer(AmmoTimer, FALSE, nameof(ReloadAmmoTimer));
		}

		// Start timer for when to continue (e.g. ReloadComplete, TimeWeaponReloading)
		if ( bReloadFromMagazine || ReloadStatus == RS_ClosingBolt )
		{
			StatusTimer = AnimRate * MySkelMesh.GetAnimInterruptTime(AnimName);
		}
		else
		{
			StatusTimer = AnimLength;
		}

		SetTimer(StatusTimer, FALSE, nameof(ReloadStatusTimer));
	}
	else
	{
		`warn("Reload duration is zero! Anim="$AnimName@"Rate:"$AnimRate);
		ReloadComplete();
	}
}

//This function allows us to play a sound, in this case, the zoom sounds for the different weapons.
simulated function WeaponZoomSound(AkEvent ZoomSound)
{
	if( Instigator != None && !bSuppressSounds )
	{
		if ( ZoomSound != None && Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() )
		{
            Instigator.PlaySoundBase( ZoomSound, true, false, false );
		}
	}
}

simulated function ConsumeAmmo( byte FireModeNum )
{
	super.ConsumeAmmo( FireModeNum );
	XBR55_UpdateDisplay();
}

//This function runs continuously, and when iron sights are being used it does the drawing.
simulated function DrawHUD( HUD H, Canvas C )
{
	super.DrawHUD(H, C);

	if(!XBR55_UI.isInitialized)
	{
		XBR55_UI.InitializeWeaponUI(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, Reticle_Headshot, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		XBR55_UI.RunWeaponUI(C);

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
		ZoomOut=AkEvent'BR55.Audio.Play_BR55_Zoom_Out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
		KFPC.SetNightVision(false);
	}
	else
	{
		ZoomIn=AkEvent'BR55.Audio.Play_BR55_Zoom_In';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(None);
		LaserSight.LaserDotMeshComp.SetStaticMesh(None);
	}
}

function ZoomTimer()
{
	return;
	//This is only here to stop logging errors.
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

		XBR55_UpdateDisplay();
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		XBR55_UpdateDisplay();
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}
}

reliable client function XBR55_UpdateDisplay()
{
	XBR55_Display.RunDisplay(Mesh);
}

defaultproperties
{
	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
	MeshFOV=70
	MeshIronSightFOV=5
    PlayerIronSightFOV=50

	// Depth of field
	DOF_FG_FocalRadius=75
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=0,Y=9,Z=-3) //x=3 //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	IronSightPosition=(X=0,Y=10,Z=0)

	// Content
	PackageKey="XBR55_SOCOM"
	FirstPersonMeshName="XBR55_SOCOM.Mesh.Wep_1stP_XBR55_SOCOM_Rig"
	FirstPersonAnimSetNames(0)="BR55.1stp_anims.Wep_1st_BR55_Anim"
	PickupMeshName="XBR55_SOCOM.Mesh.XBR55__SOCOM_Static"
	AttachmentArchetypeName="XBR55_SOCOM.Archetypes.Wep_XBR55_SOCOM_3P"
	MuzzleFlashTemplateName="M7S.Archetypes.Wep_M7S_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=30
	SpareAmmoCapacity[0]=270 //360
	InitialSpareMags[0]=4
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	// Recoil
	maxRecoilPitch=180 //200 //190 //90
	minRecoilPitch=110 //100 //60
	maxRecoilYaw=90 //100 //65 //50
	minRecoilYaw=-85 //-100 //-65 //50
	RecoilRate=0.065 //0.07 //0.057
	RecoilMaxYawLimit=325 //400
	RecoilMinYawLimit=65135
	RecoilMaxPitchLimit=800
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=300 //90 //150
	RecoilISMinYawLimit=65385
	RecoilISMaxPitchLimit=210 //90 //130
	RecoilISMinPitchLimit=65435
	RecoilViewRotationScale=0.25
	IronSightMeshFOVCompensationScale=3.8 //3.5

	// Inventory / Grouping
	InventorySize=6 //6
	GroupPriority=101
	WeaponSelectTexture=Texture2D'XBR55_SOCOM.UI.XBR55_SOCOM_UI_v1'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'HaloPack_FireModeIcons.UI_FireModeSelect_2RoundBurst'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponBurstFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_XBR55_SOCOM'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_XBR55_SOCOM'
	FireInterval(DEFAULT_FIREMODE)=0.05 //+0.057
	InstantHitDamage(DEFAULT_FIREMODE)=38.0 //37 //40.0
	PenetrationPower(DEFAULT_FIREMODE)=0.0
	Spread(DEFAULT_FIREMODE)=0.01
	FireOffset=(X=30,Y=4.5,Z=-4)
	BurstAmount=2

	// ALTFIRE_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_XBR55_SOCOM'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_XBR55_SOCOM'
	FireInterval(ALTFIRE_FIREMODE)=0.1
	PenetrationPower(ALTFIRE_FIREMODE)=0
	InstantHitDamage(ALTFIRE_FIREMODE)=37 //40
	Spread(ALTFIRE_FIREMODE)=0.04

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_XBR55_SOCOM'
	InstantHitDamage(BASH_FIREMODE)=24

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_Single', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_Single')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_Single', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_Single')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=true
	bHasLaserSight=true

	bWarnAIWhenAiming = false

	AssociatedPerkClasses(0)=class'KFPerk_SWAT'

	//Custom idle animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Damage1, Scale=1.15f), (Stat=EWUS_Weight, Add=1))))

	AmmoRed = 0.3
	AmmoYellow = 0.5

	//Textures for the scope background. Needs to be changed to an enum.
	UIBackgrounds[0] = Texture2D'Shared.UI.Basic_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'Shared.UI.Basic_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'Shared.UI.Basic_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'Shared.UI.Basic_Reticle_Background_v2'
	UIBackgrounds[4] = Texture2D'Shared.UI.Basic_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'Shared.UI.Basic_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'Shared.UI.Basic_Reticle_Background_32_9_v2'

	//Reticles
	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=951, V=0, UL=160, VL=160)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1274, V=0, UL=160, VL=160)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1436, V=0, UL=160, VL=160)
	Reticle_Headshot = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1598, V=0, UL=160, VL=160)

	RangeCanvasIcon = (Texture=Texture2D'Shared.UI.BR_Rangefinder', U=0, V=0, UL=2864, VL=2864)
	ZoomCanvasIcon = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=163, V=129, UL=155, VL=130)

	NVG_On = AkEvent'SRS99_AM.Audio.Play_SRS99_NVG_On'
	NVG_Off = AkEvent'SRS99_AM.Audio.Play_SRS99_NVG_Off'
}

