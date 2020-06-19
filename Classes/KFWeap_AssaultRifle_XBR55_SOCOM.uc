//=============================================================================
// Base File: KFWeap_AssaultRifle_AR15
//=============================================================================
// Gear Shift Gaming 9/9/2019
//=============================================================================

class KFWeap_AssaultRifle_XBR55_SOCOM extends KFWeap_RifleBase;

var array<Texture2D> Scope_Backgrounds;
var KFPlayerController KFPC;
var KFGameReplicationInfo MyKFGRI;
var float RefireDelayAmount;

//1 is the left display
//0 is the right display.
var float AmmoRed, AmmoYellow;
var Standard_Ammo_Display XBR55_Display;

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

	local float Xpos;
	local float Ypos;
	local float ReticleScale;
	local float BackgroundScale;
	local bool ResolutionFound;
	local Texture2D ReticleBackground;

	//These are the variables for the tracing system.
	local vector TraceStart, TraceEnd;
	local vector InstantTraceHitLocation, InstantTraceHitNormal;
	local vector TraceAimDir;
	local Actor	HitActor;
	local TraceHitInfo		HitInfo;

	super.DrawHUD(H, C);

	if( bUsingSights )
	{
		C.EnableStencilTest(true); //Makes the draw calls draw over the weapons

		//Sets the position and scaling variables for the textures for different resolutions. It checks for X Resolution first, then Y resolution.
		ReticleBackground = Scope_Backgrounds[0]; //Default background with a 16:9 Aspect Ratio
		switch(C.SizeX)
		{
			case 2560:
				Xpos = 1224.0;
				YPos = 664.0;
				ReticleScale = 0.875;
				BackgroundScale = 1.0;
				ResolutionFound = true;
				break;
			case 1920:
				switch(C.SizeY)
				{
					case 1440:
						XPos = 897.0; //-34
						YPos = 654.0;
						ReticleBackground = Scope_Backgrounds[1]; //Background with a 4:3 Aspect Ratio
						ReticleScale = 1.0;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 895.5;
						YPos = 535.7;
						ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
						ReticleScale = 1.0;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1080:
						ReticleScale = 0.625;
						BackgroundScale = 0.75;
						XPos = 920.0;
						YPos = 500.0;
						ResolutionFound = true;
						break;
				}
				break;
			case 1680:
				XPos = 798.0;
				YPos = 480.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
				ReticleScale = 0.675;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1600:
				XPos = 770.0;
				switch( C.SizeY )
				{
					case 1200:
						XPos = 768.0;
						YPos = 568.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						YPos = 480.0;
						ReticleBackground = Scope_Backgrounds[5]; //A one off background for this almost 16:10 Aspect Ratio
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 900:
						XPos = 768.5;
						YPos = 417.0;
						ReticleScale = 0.5;
						BackgroundScale = 0.625;
						ResolutionFound = true;
						break;
				}
				break;
			case 1440:
				XPos = 689.0;
				YPos = 417.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
				ReticleScale = 0.5;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 668.0;
				YPos = 493.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
				ReticleScale = 0.5;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1366:
				XPos = 650.0;
				YPos = 351.0;
				ReticleScale = 0.5;
				BackgroundScale = 0.533; 
				ResolutionFound = true;
				break;
			case 1360:
				XPos = 650.0;
				YPos = 353.0;
				ReticleScale = 0.5;
				BackgroundScale = 0.5335; 
				ResolutionFound = true;
				break;
			case 1280:
				XPos = 610.0;
				switch( C.SizeY )
				{
					case 1024:
						XPos = 608.0;
						YPos = 480.0;
						ReticleBackground = Scope_Backgrounds[4]; //Background with a 5:4 Aspect Ratio
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						XPos = 609.0;
						YPos = 449.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
						ReticleScale = 0.5;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						XPos = 605.0;
						YPos = 364.0;
						ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
						ReticleScale = 0.5;
						BackgroundScale = 0.66;
						ResolutionFound = true;
						break;
					case 720:
						YPos = 328.0;
						XPos = 608.0;
						ReticleScale = 0.5;
						BackgroundScale = 0.5;
						ResolutionFound = true;
						break;
				} 
				break;
			case 1024:
				XPos = 482.0;
				YPos = 352.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
				ReticleScale = 0.5;
				BackgroundScale = 0.649;
				ResolutionFound = true;
				break;
			default:
				ResolutionFound = false;
				break;
		}

		if( ResolutionFound == true )
		{
			//Draws the reticle and accompanying elements at the set positions.
			C.SetPos(Xpos, Ypos);
			C.SetDrawColor( 255, 255, 255, 255);

			if (KFPC == None )
			{
				`log("No PC");
				KFPC = KFPlayerController(Instigator.Controller);
			}

			TraceStart = KFPC.Pawn.Weapon.Instigator.GetWeaponStartTraceLocation();
			TraceAimDir = Vector( KFPC.Pawn.Weapon.Instigator.GetAdjustedAimFor( KFPC.Pawn.Weapon, TraceStart ));
			TraceEnd = TraceStart + TraceAimDir * 20000; //200M
			HitActor = KFPC.Pawn.Weapon.GetTraceOwner().Trace(InstantTraceHitLocation, InstantTraceHitNormal, TraceEnd, TraceStart, TRUE, vect(0,0,0), HitInfo, KFPC.Pawn.Weapon.TRACEFLAG_Bullet);


			if( KFPawn_Monster(HitActor) != none && KFPawn_Monster(HitActor).IsAliveAndWell())
			{
				if(  HitInfo.BoneName == 'head')
				{
					C.DrawTexture(Texture2D'BR55.UI.BR55_EnemyHighlight_Headshot_Reticle', ReticleScale ); //Base texture size is 128 x 128
				}
				else
				{
					C.DrawTexture(Texture2D'BR55.UI.BR55_EnemyHighlight_Reticle', ReticleScale ); //Base texture size is 128 x 128
				}
			}
			else if( KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(Texture2D'BR55.UI.BR55_FriendlyHighlight_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}
			else
			{
				C.DrawTexture(Texture2D'XBR55_SOCOM.UI.XBR55_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}

			C.SetPos(0.0, 0.0 ); //Sets the position to the top left of the screen.
			C.DrawTexture(ReticleBackground, BackgroundScale ); //Base texture size is 2560 x 1440

			if(KFPawn_Human(KFPC.Pawn).bFlashlightOn)
			{
				KFPC.SetNightVision(true); //Maybe try using the Effect_NightVision Material. It's defined in FX_Mat_Lib.KF_PP_Master
				KFPC.bGamePlayDOFActive = false;
			}
			else
			{
				KFPC.SetNightVision(false);
			}
		}
		else
		{
				C.SetPos( 100.0, 100.0 );
				C.SetDrawColor( 255, 0, 0, 255 );
				C.Font = Font'UI_Canvas_Fonts.Font_Main';
				C.DrawText("Fatal Scope Error: Resolution Preset Not Found. Contact Mod Maker.", true, 1.0, 1.0 );
		}
	}
	else
	{
		C.EnableStencilTest(false); //Reverts to default state
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
	maxRecoilPitch=200 //190 //90
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

	//@todo: add akevents when we have them
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
	Scope_Backgrounds[0] = Texture2D'XBR55_SOCOM.UI.XBR55_Reticle_Background' //Default background with a 16:9 Aspect Ratio
	Scope_Backgrounds[1] = Texture2D'XBR55_SOCOM.UI.XBR55_Reticle_Background_4_3_AR' //Background with a 4:3 Aspect Ratio
	Scope_Backgrounds[2] = Texture2D'XBR55_SOCOM.UI.XBR55_Reticle_Background_4_3_AR_Small_Circle' //Background with a 4:3 Aspect Ratio, but a smaller inner circle
	Scope_Backgrounds[3] = Texture2D'XBR55_SOCOM.UI.XBR55_Reticle_Background_16_10_AR' //Background with a 16:10 Aspect Ratio
	Scope_Backgrounds[4] = Texture2D'XBR55_SOCOM.UI.XBR55_Reticle_Background_5_4_AR' //Background with a 5:4 Aspect Ratio
	Scope_Backgrounds[5] = Texture2D'XBR55_SOCOM.UI.XBR55_Reticle_Background_1600_1024' //A one off background for this almost 16:10 Aspect Ratio
}

