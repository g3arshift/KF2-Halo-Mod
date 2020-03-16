//=============================================================================
// Base File: KFWeap_Bullpup
//=============================================================================
// An MA37 Assault Rifle
//=============================================================================
// Gear Shift Gaming Mods 8/6/2019
//=============================================================================

class KFWeap_AssaultRifle_MA37 extends KFWeap_RifleBase;

var array<MaterialInstanceConstant> AmmoNumbers_High;
var array<MaterialInstanceConstant> AmmoNumbers_Medium;
var array<MaterialInstanceConstant> AmmoNumbers_Low;
var array<MaterialInstanceConstant> DisplayPlateColors;
var array<MaterialInstanceConstant> BulletPlateColors;
var array<MaterialInstanceConstant> Compass_High;
var array<MaterialInstanceConstant> Compass_Medium;
var array<MaterialInstanceConstant> Compass_Low;

var PlayerController PC;
var KFGameReplicationInfo MyKFGRI;

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

    if ( AmmoCount[0] <= 10 && AmmoCount[0] > 0)
    {
    	//`log("You did a fast reload, good job!");
    	SpeedReloadRate = GetReloadRateScale() * 0.2; //The percentage to add to the rate the reload takes. If you set it to 0.15, it reloads 15% faster.
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
	if(PC == None )
	{
		PC = GetALocalPlayerController();
	}

	UpdateAmmoDisplay(); //Make sure the display shows the proper ammo when we equip it.
}

//Updates the display on the gun to show the correct ammunition, and also (later) change the color of the entire display to appropriately match the bullet display color.
simulated function UpdateAmmoDisplay()
{
	local int AmmoCountLeft_Digit;
	local int AmmoCountRight_Digit;

	if( Instigator.isFirstPerson() )
	{
		AmmoCountLeft_Digit = int(Left(AmmoCount[0], 1));
		AmmoCountRight_Digit = int(Right(AmmoCount[0], 1));

		if ( AmmoCount[0] >= 99 )
		{
			Mesh.SetMaterial( 2, AmmoNumbers_High[9]); //Left Display
			Mesh.SetMaterial( 6, AmmoNumbers_High[9]); //Right Display
			Mesh.SetMaterial( 4, DisplayPlateColors[0] ); //Display Plate Background Display
			Mesh.SetMaterial( 5, BulletPlateColors[0] ); //Bullet Plate Background Display
		}
		else if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
		{
			Mesh.SetMaterial( 2, AmmoNumbers_High[AmmoCountLeft_Digit]); //Left Display
			Mesh.SetMaterial( 6, AmmoNumbers_High[AmmoCountRight_Digit]); //Right Display
			Mesh.SetMaterial( 4, DisplayPlateColors[0] ); //Display Plate Background Display
			Mesh.SetMaterial( 5, BulletPlateColors[0] ); //Bullet Plate Background Display
		}
		else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
		{
			Mesh.SetMaterial( 2, AmmoNumbers_Medium[AmmoCountLeft_Digit]); //Left Display
			Mesh.SetMaterial( 6, AmmoNumbers_Medium[AmmoCountRight_Digit]); //Right Display
			Mesh.SetMaterial( 4, DisplayPlateColors[1] ); //Display Plate Background Display
			Mesh.SetMaterial( 5, BulletPlateColors[1] ); //Bullet Plate Background Display
		}
		else if ( AmmoCount[0] <= 10)
		{
			if( AmmoCount[0] == 10 )
			{
				AmmoCountLeft_Digit = 1;
			}
			else
			{
				AmmoCountLeft_Digit = 0;	
			}
			Mesh.SetMaterial( 2, AmmoNumbers_Low[AmmoCountLeft_Digit]); //Left Display
			Mesh.SetMaterial( 6, AmmoNumbers_Low[AmmoCountRight_Digit]); //Right Display
			Mesh.SetMaterial( 4, DisplayPlateColors[2] ); //Display Plate Background Display
			Mesh.SetMaterial( 5, BulletPlateColors[2] ); //Bullet Plate Background Display
		}
	}
}

simulated state Reloading
{
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		UpdateAmmoDisplay();
		UpdateCompass();
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		UpdateAmmoDisplay();
		UpdateCompass();
	}
}

simulated function ConsumeAmmo( byte FireModeNum )
{
	super.ConsumeAmmo( FireModeNum );
	UpdateAmmoDisplay();
}

//The four functions below this line are for the compass updating.
/*
function vector GetCurrentTraderLocation()
{
    local vector TraderLoc;

    if( PC == None )
    {
        return Vect(0,0,0);
    }

    if( MyKFGRI == None )
    {
        MyKFGRI = KFGameReplicationInfo( PC.WorldInfo.GRI );
    }

    if(MyKFGRI != None && (MyKFGRI.OpenedTrader != None || MyKFGRI.NextTrader != None))
    {
        TraderLoc = MyKFGRI.OpenedTrader != None ? MyKFGRI.OpenedTrader.Location : MyKFGRI.NextTrader.Location;
    }

    return TraderLoc;
}
*/

simulated function UpdateCompass()
{
	local int Angle;

	Angle = (Rotation.Yaw & 65535);

	//All angles point to the opposite direction so it rotates counter-clockwise
	if (Angle >= 12288 && Angle < 20480) //North East
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[0]); //1
    		//`log("North East");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[0]); //1
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[0]); //1
    	}
    }
    else if (Angle >= 20480 && Angle < 28672) //East
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[7]); //2
    		//`log("East");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[7]); //2
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[7]); //2
    	}
    }
    else if (Angle >= 28672 && Angle < 36864) //South East
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[6]); //3
    		//`log("South East");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[6]); //3
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[6]); //3
    	}
    }
    else if (Angle >= 36864 && Angle < 45056) //South
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[5]); //4
    		//`log("South");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[5]); //4
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[5]); //4
    	}
    }
    else if (Angle >= 45056 && Angle < 53248) //South West
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[4]); //5
    		//`log("South West");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[4]); //5
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[4]); //5
    	}
    }
    else if (Angle >= 53248 && Angle < 61140) //West
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[3]); //6
    		//`log("West");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[3]); //6
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[3]); //6
    	}
    }
    else if (Angle >= 61440 && Angle < 65535) //North West
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[2]); //7
    		//`log("North West");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[2]); //7
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[2]); //7
    	}
    }
    else //North
    {
    	if ( AmmoCount[0] >= MagazineCapacity[0] * 0.6 ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[1]); //0
    		//`log("North East");
    	}
    	else if ( AmmoCount[0] < MagazineCapacity[0] * 0.59 && AmmoCount[0] > 10 ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[1]); //0
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[1]); //0
    	}
    }
}

simulated event Tick( float DeltaTime ) //This might be a costly check. I think this is making the servers crash on map switch.
{

	if( PC != None )
	{
		super.Tick( DeltaTime );
		if( PC.Pawn != None && KFWeap_AssaultRifle_MA37(PC.Pawn.Weapon) != None )
		{
			UpdateCompass();
		} 	
	}
	else
	{
		PC = GetALocalPlayerController();
	}
}

/*
simulated function KFWeapon GetActiveWeapon()
{
	if( PC == None )
	{
		PC = GetALocalPlayerController();
	}

	if( PC != None )
	{
		return KFWeapon(PC.Pawn.Weapon);
	}
}
*/

//The below is for the custom scope.

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
		ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background'; //Default Background, using 16:9 Aspect Ratio.
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
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_4_3_AR'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 1.0;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 895.5;
						YPos = 535.7;
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						YPos = 480.0;
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_1600_1024'; //A one off background for this almost 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_16_10_AR';
				ReticleScale = 0.5;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 668.0;
				YPos = 493.0;
				ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_5_4_AR'; //Background using 5:4 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						XPos = 609.0;
						YPos = 449.0;
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						XPos = 605.0;
						YPos = 364.0;
						ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'MA37.UI.MA37_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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

			if (PC == None )
			{
				`log("No PC");
				PC = GetALocalPlayerController();
			}

			TraceStart = PC.Pawn.Weapon.Instigator.GetWeaponStartTraceLocation();
			TraceAimDir = Vector( PC.Pawn.Weapon.Instigator.GetAdjustedAimFor( PC.Pawn.Weapon, TraceStart ));
			TraceEnd = TraceStart + TraceAimDir * 20000; //200M
			HitActor = PC.Pawn.Weapon.GetTraceOwner().Trace(InstantTraceHitLocation, InstantTraceHitNormal, TraceEnd, TraceStart, TRUE, vect(0,0,0), HitInfo, PC.Pawn.Weapon.TRACEFLAG_Bullet);

			if( KFPawn_Monster(HitActor) != None && KFPawn_Monster(HitActor).IsAliveAndWell())
			{
					C.DrawTexture(Texture2D'MA37.UI.MA37_EnemyHighlight_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}
			else if( KFPawn_Human(HitActor) != None && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(Texture2D'MA37.UI.MA37_FriendlyHighlight_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}
			else
			{
				C.DrawTexture(Texture2D'MA37.UI.MA37_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}

			C.SetPos(0.0, 0.0 ); //Sets the position to the top left of the screen.
			C.DrawTexture(ReticleBackground, BackgroundScale ); //Base texture size is 2560 x 1440
		}
		else
		{
				C.SetPos( 100.0, 100.0 );
				C.SetDrawColor( 255, 0, 0, 255 );
				C.Font = Font'UI_Canvas_Fonts.Font_Main';
				C.DrawText("Fatal M6D Scope Error: Resolution Preset Not Found. Contact Mod Maker.", true, 1.0, 1.0 );
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
		ZoomOut=AkEvent'M6C-SOCOM.Audio.Play_M6S_zoom_out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
	}
	else
	{
		ZoomIn=AkEvent'M6C-SOCOM.Audio.Play_M6S_zoom_in';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
	}
}

defaultproperties
{
	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
    MeshFOV=57 //55
	MeshIronSightFOV=5
    PlayerIronSightFOV=65

	// Depth of field
	DOF_FG_FocalRadius=85
	DOF_FG_MaxNearBlurSize=2.5

	// Content
	PackageKey="MA37"
	FirstPersonMeshName="MA37.Mesh.Wep_1stP_MA37_Rig"
	FirstPersonAnimSetNames(0)="MA37.1stp_anims.Wep_1st_MA37_Anim"
	PickupMeshName="MA37.Mesh.MA37_Static"
	AttachmentArchetypeName="MA37.Archetypes.Wep_MA37_3P"
	MuzzleFlashTemplateName="WEP_L85A2_ARCH.Wep_L85A2_MuzzleFlash"

   	// Zooming/Position
	PlayerViewOffset=(X=1,Y=9,Z=-2) //x=3
	IronSightPosition=(X=0,Y=10,Z=0)

	// Ammo
	MagazineCapacity[0]=32
	SpareAmmoCapacity[0]=320
	InitialSpareMags[0]=3
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=130 //150
	minRecoilPitch=100 //110
	maxRecoilYaw=170 //160
	minRecoilYaw=-140 //-110
	RecoilRate=0.095 //.085
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=85 //THIS CONTROLS THE HORIZONTAL MOVEMENT OF THE BULLETS WHEN YOU'RE SHOOTING IRON SIGHT
	RecoilISMinYawLimit=65460
	RecoilISMaxPitchLimit=70 //75  THIS CONTROLS THE VERTICAL MOVEMENT OF THE BULLETS WHEN YOU'RE SHOOTING IRON SIGHT
	RecoilISMinPitchLimit=65460
	IronSightMeshFOVCompensationScale=1.5


    // Inventory / Grouping
	InventorySize=6
	GroupPriority=75
	WeaponSelectTexture=Texture2D'MA37.Textures.MA37_UI_v1'
   	AssociatedPerkClasses(0)=class'KFPerk_Commando'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_MA37'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_MA37'
	FireInterval(DEFAULT_FIREMODE)=+0.105 // 580 RPM
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=32.0 //33
	PenetrationPower(DEFAULT_FIREMODE)=1.0
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_MA37'
	InstantHitDamage(BASH_FIREMODE)=30

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'MA37.Audio.Play_MA37_Fire_3P', FirstPersonCue=AkEvent'MA37.Audio.Play_MA37_Fire_1P')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	//Ammo Counter Display Materials
	//Maybe in the future just use 1 array for each color, and change the glow parameter? Maybe? Not sure if it would color properly.
	AmmoNumbers_High[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_0';
	AmmoNumbers_High[1] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_1';
	AmmoNumbers_High[2] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_2';
	AmmoNumbers_High[3] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_3';
	AmmoNumbers_High[4] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_4';
	AmmoNumbers_High[5] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_5';
	AmmoNumbers_High[6] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_6';
	AmmoNumbers_High[7] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_7';
	AmmoNumbers_High[8] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_8';
	AmmoNumbers_High[9] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_9';

	AmmoNumbers_Medium[0] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_0';
	AmmoNumbers_Medium[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_1';
	AmmoNumbers_Medium[2] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_2';
	AmmoNumbers_Medium[3] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_3';
	AmmoNumbers_Medium[4] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_4';
	AmmoNumbers_Medium[5] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_5';
	AmmoNumbers_Medium[6] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_6';
	AmmoNumbers_Medium[7] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_7';
	AmmoNumbers_Medium[8] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_8';
	AmmoNumbers_Medium[9] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_9';

	AmmoNumbers_Low[0] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_0';
	AmmoNumbers_Low[1] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_1';
	AmmoNumbers_Low[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_2';
	AmmoNumbers_Low[3] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_3';
	AmmoNumbers_Low[4] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_4';
	AmmoNumbers_Low[5] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_5';
	AmmoNumbers_Low[6] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_6';
	AmmoNumbers_Low[7] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_7';
	AmmoNumbers_Low[8] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_8';
	AmmoNumbers_Low[9] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_9';

	DisplayPlateColors[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_DisplayPlate';
	DisplayPlateColors[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_DisplayPlate';
	DisplayPlateColors[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_DisplayPlate';

	BulletPlateColors[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_BulletPlate';
	BulletPlateColors[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_BulletPlate';
	BulletPlateColors[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_BulletPlate';

	Compass_High[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_North';
	Compass_High[1] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_NorthEast';
	Compass_High[2] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_East';
	Compass_High[3] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_SouthEast';
	Compass_High[4] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_South';
	Compass_High[5] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_SouthWest';
	Compass_High[6] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_West';
	Compass_High[7] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_NorthWest';

	Compass_Medium[0] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_North';
	Compass_Medium[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_NorthEast';
	Compass_Medium[2] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_East';
	Compass_Medium[3] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_SouthEast';
	Compass_Medium[4] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_South';
	Compass_Medium[5] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_SouthWest';
	Compass_Medium[6] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_West';
	Compass_Medium[7] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_NorthWest';

	Compass_Low[0] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_North';
	Compass_Low[1] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_NorthEast';
	Compass_Low[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_East';
	Compass_Low[3] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_SouthEast';
	Compass_Low[4] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_South';
	Compass_Low[5] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_SouthWest';
	Compass_Low[6] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_West';
	Compass_Low[7] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_NorthWest';

	//Custom Animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Damage1, Scale=1.10f), (Stat=EWUS_Weight, Add=1)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.3f), (Stat=EWUS_Damage1, Scale=1.25f), (Stat=EWUS_Weight, Add=2)))
}


