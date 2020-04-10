//=============================================================================
// Base File: KFWeap_Bullpup
//=============================================================================
// An M392 DMR
//=============================================================================
// Gear Shift Gaming 3/14/2020
//=============================================================================

class KFWeap_AssaultRifle_M392 extends KFWeap_RifleBase;

//3 is right display
//4 is left display

var KFPlayerController KFPC;
var Standard_Ammo_Display M392_Display;
var float AmmoRed, AmmoYellow;
var array<Texture2D> Scope_Backgrounds;
var array<Texture2D> Reticles;

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

//This function is almost identical to the original in KFWeapon, but we're overriding it to enable fast reloading at or below a certain threshhold.
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
    	SpeedReloadRate = GetReloadRateScale() * 0.10; //The percentage to add to the rate the reload takes. If you set it to 0.15, it reloads 15% faster.
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
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
	}
	else
	{
		ZoomIn=AkEvent'M392.Audio.Play_DMR_Zoom_In';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
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

	if(M392_Display == none)
	{
		M392_Display = New class'Standard_Ammo_Display';
	}

	M392_Display.InitializeDisplay(KFPC, 4, 3, AmmoYellow, AmmoRed);
	M392_Display.RunDisplay(Mesh);
}

simulated function ConsumeAmmo( byte FireModeNum )
{
	super.ConsumeAmmo( FireModeNum );
	M392_UpdateDisplay();
}

simulated state Reloading
{
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		M392_UpdateDisplay();
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		M392_UpdateDisplay();
	}
}

reliable client function M392_UpdateDisplay()
{
	M392_Display.RunDisplay(Mesh);
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
	local TraceHitInfo HitInfo;

	super.DrawHUD(H, C);

	if( bUsingSights )
	{
		C.EnableStencilTest(true); //Makes the draw calls draw over the weapons

		//Sets the position and scaling variables for the textures for different resolutions. It checks for X Resolution first, then Y resolution.
		ReticleBackground = Scope_Backgrounds[0]; //Default Background, using 16:9 Aspect Ratio.
		switch(C.SizeX)
		{
			case 2560:
				Xpos = 1248.0;
				YPos = 688.0;
				ReticleScale = 0.5;
				BackgroundScale = 1.0;
				ResolutionFound = true;
				break;
			case 1920:
				switch(C.SizeY)
				{
					case 1440:
						XPos = 928.0;
						YPos = 688.0;
						ReticleBackground = Scope_Backgrounds[1]; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 928.0;
						YPos = 568.0;
						ReticleBackground = Scope_Backgrounds[3]; //Background using 16:10 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1080:
						ReticleScale = 0.375;
						BackgroundScale = 0.75;
						XPos = 936.0;
						YPos = 516.0;
						ResolutionFound = true;
						break;
				}
				break;
			case 1680:
				XPos = 812.0;
				YPos = 497.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background using 16:10 Aspect Ratio.
				ReticleScale = 0.4375;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1600:
				switch( C.SizeY )
				{
					case 1200:
						XPos = 773.0;
						YPos = 573.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background using 4:3 Aspect Ratio. Small Circle
						ReticleScale = 0.421875;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						XPos = 781.0;
						YPos = 492.0;
						ReticleBackground = Scope_Backgrounds[5]; //A one off background for this almost 16:10 Aspect Ratio.
						ReticleScale = 0.296875;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 900:
						XPos = 780.0;
						YPos = 430.0;
						ReticleScale = 0.3125;
						BackgroundScale = 0.625;
						ResolutionFound = true;
						break;
				}
				break;
			case 1440:
				XPos = 696.0;
				YPos = 426.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background using 16:10 Aspect Ratio.
				ReticleScale = 0.375;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 676.0;
				YPos = 501.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background using 4:3 Aspect Ratio. Small Circle
				ReticleScale = 0.375;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1366:
				XPos = 665.0;
				YPos = 366.0;
				ReticleScale = 0.28125;
				BackgroundScale = 0.533; 
				ResolutionFound = true;
				break;
			case 1360:
				XPos = 663.0;
				YPos = 365.0;
				ReticleScale = 0.265625;
				BackgroundScale = 0.5335; 
				ResolutionFound = true;
				break;
			case 1280:
				switch( C.SizeY )
				{
					case 1024:
						XPos = 617.0;
						YPos = 488.0;
						ReticleBackground = Scope_Backgrounds[4]; //Background using 5:4 Aspect Ratio.
						ReticleScale = 0.3671875;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						XPos = 618.0;
						YPos = 458.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background using 4:3 Aspect Ratio. Small Circle
						ReticleScale = 0.34375;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						XPos = 618.0;
						YPos = 378.0;
						ReticleBackground = Scope_Backgrounds[3]; //Background using 16:10 Aspect Ratio.
						ReticleScale = 0.34375;
						BackgroundScale = 0.66;
						ResolutionFound = true;
						break;
					case 720:
						XPos = 624.0;
						YPos = 344.0;
						ReticleScale = 0.25;
						BackgroundScale = 0.5;
						ResolutionFound = true;
						break;
				} 
				break;
			case 1024:
				XPos = 494.0;
				YPos = 366.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background using 4:3 Aspect Ratio. Small Circle
				ReticleScale = 0.28125;
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
					C.DrawTexture(Texture2D'M392.UI.M392_Reticle_Enemy_Highlight_Headshot', ReticleScale ); //Base texture size is 128 x 128
				}
				else
				{
					C.DrawTexture(Texture2D'M392.UI.M392_Reticle_Enemy_Highlight', ReticleScale ); //Base texture size is 128 x 128
				}
			}
			else if( KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(Texture2D'M392.UI.M392_Reticle_Friendly_Highlight', ReticleScale ); //Base texture size is 128 x 128
			}
			else
			{
				C.DrawTexture(Texture2D'M392.UI.M392_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}

			C.SetPos(0.0, 0.0 ); //Sets the position to the top left of the screen.
			C.DrawTexture(ReticleBackground, BackgroundScale ); //Base texture size is 2560 x 1440
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

defaultproperties
{
	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
    MeshFOV=60
	MeshIronSightFOV=5
    PlayerIronSightFOV=40

	// Depth of field
	DOF_FG_FocalRadius=85
	DOF_FG_MaxNearBlurSize=2.5

	// Content
	PackageKey="M392"
	FirstPersonMeshName="M392.Mesh.Wep_1stP_M392_Rig"
	FirstPersonAnimSetNames(0)="M392.1stp_anims.Wep_1st_M392_Anim" //"WEP_1P_L85A2_ANIM.Wep_1st_L85A2_Anim"
	PickupMeshName="M392.Mesh.M392_Static"
	AttachmentArchetypeName="M392.Arch.Wep_M392_3P"
	MuzzleFlashTemplateName="WEP_FNFAL_ARCH.Wep_FNFAL_MuzzleFlash"

   	// Zooming/Position
	PlayerViewOffset=(X=6.5,Y=8.7,Z=-1.5) //(X=3.0,Y=9,Z=-3)
	IronSightPosition=(X=0,Y=10,Z=0)

	// Ammo
	MagazineCapacity[0]=15
	SpareAmmoCapacity[0]=120 //105
	InitialSpareMags[0]=1
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=450 //325 //225
	minRecoilPitch=275 //1250 //200
	maxRecoilYaw=200
	minRecoilYaw=-200
	RecoilRate=0.08
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=1100 //900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=200 //150
	RecoilISMinYawLimit=65385
	RecoilISMaxPitchLimit=675 //475 //375
	RecoilISMinPitchLimit=65460
	IronSightMeshFOVCompensationScale=3.0
    HippedRecoilModifier=1.1

    // Inventory / Grouping
	InventorySize=8
	GroupPriority=101
	WeaponSelectTexture=Texture2D'M392.UI.M392_UI_v1'
   	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M392'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M392'
	FireInterval(DEFAULT_FIREMODE)=+0.425
	Spread(DEFAULT_FIREMODE)=0.00085
	PenetrationPower(DEFAULT_FIREMODE)=0.0
	InstantHitDamage(DEFAULT_FIREMODE)=135 //145 //175.0 //120
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M392'
	InstantHitDamage(BASH_FIREMODE)=29

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M392.Audio.Play_M392_Fire_3P', FirstPersonCue=AkEvent'M392.Audio.Play_M392_Fire_1P')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M392.Audio.Play_M392_Dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	//Custom Animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	//Threshhold percentages for "Red" and "Yellow" ammo states
	AmmoRed = 0.334
	AmmoYellow = 0.67

	//Textures for the scope background
	Scope_Backgrounds[0] = Texture2D'M392.UI.M392_Reticle_Background' //Default background with a 16:9 Aspect Ratio
	Scope_Backgrounds[1] = Texture2D'M392.UI.M392_Reticle_Background_4_3_AR' //Background with a 4:3 Aspect Ratio
	Scope_Backgrounds[2] = Texture2D'M392.UI.M392_Reticle_Background_4_3_AR_Small_Circle' //Background with a 4:3 Aspect Ratio, but a smaller inner circle
	Scope_Backgrounds[3] = Texture2D'M392.UI.M392_Reticle_Background_16_10_AR' //Background with a 16:10 Aspect Ratio
	Scope_Backgrounds[4] = Texture2D'M392.UI.M392_Reticle_Background_5_4_AR' //Background with a 5:4 Aspect Ratio
	Scope_Backgrounds[5] = Texture2D'M392.UI.M392_Reticle_Background_1600_1024' //A one off background for this almost 16:10 Aspect Ratio

	Reticles[0] = Texture2D'M392.UI.M392_Reticle' //Default Reticle
	Reticles[1] = Texture2D'M392.UI.M392_Reticle_Enemy_Highlight' //Enemy Highlight Reticle
	Reticles[2] = Texture2D'M392.UI.M392_Reticle_Friendly_Highlight' //Friendly Highlight Reticle
	Reticles[3] = Texture2D'M392.UI.M392_Reticle_Enemy_Highlight_Headshot' //Enemy Highlight Headshot Reticle

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Weight, Add=1)))
}


