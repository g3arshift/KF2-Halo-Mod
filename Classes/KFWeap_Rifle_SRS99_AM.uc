//=============================================================================
// Base File: KFWeap_AssaultRifle_FNFal
//=============================================================================
// A high powered, four shot sniper rifle.
//=============================================================================
// Gear Shift Gaming 3/6/2020
//=============================================================================

class KFWeap_Rifle_SRS99_AM extends KFWeap_RifleBase;

var KFPlayerController KFPC;

var array<Texture2D> Scope_Backgrounds;
var Texture2D ScopeReticle_Default;
var Texture2D ScopeReticle_Enemy;
var Texture2D ScopeReticle_Friendly;

//var ChangeBySine SniperUI_Sine;
var float Xpos, Ypos, SniperRound_Xpos, SniperRound_Ypos, SniperRound_Scale, SniperText_Xpos, SniperText_Ypos, SniperText_Scaling, ReticleScale, BackgroundScale;
var int SniperRound_Distance;
//var int SineChangeRate;
var TextureMovie Scope_RocketAmmo_Movie;
var Texture2D Scope_RocketAmmo;


simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	super.PlayWeaponEquip(ModifiedEquipTime);
	if(KFPC == none)
	{
		KFPC = KFPlayerController(Instigator.Controller);
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
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
		KFPC.SetNightVision(false);
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

//This function runs continuously, and when iron sights are being used it does the drawing.
simulated function DrawHUD( HUD H, Canvas C )
{
	local bool ResolutionFound;
	local Texture2D ReticleBackground;

	//These are the variables for the tracing system.
	local vector TraceStart, TraceEnd;
	local vector InstantTraceHitLocation, InstantTraceHitNormal;
	local vector TraceAimDir;
	local Actor	HitActor;
	local Texture2D HitActorTex;
	local TraceHitInfo HitInfo;
	//local int ALPHACOLOR;

	super.DrawHUD(H, C);

	if(KFPawn_Human(KFPC.Pawn).bFlashlightOn)
	{
		Mesh.SetMaterial(2, MaterialInstanceConstant'SRS99_AM.Materials.SRS99_AM_Screen');
	}
	else
	{
		Mesh.SetMaterial(2, MaterialInstanceConstant'SRS99_AM.Materials.SRS99_AM_Screen_NoNVG');
	}

	if( bUsingSights )
	{
		C.EnableStencilTest(true); //Makes the draw calls draw over the weapons

		//Sets the position and scaling variables for the textures for different resolutions. It checks for X Resolution first, then Y resolution.
		ReticleBackground = Scope_Backgrounds[0]; //Default background with a 16:9 Aspect Ratio
		switch(C.SizeX)
		{
			case 2560:
				SniperRound_Xpos = 790.0;
				SniperRound_Ypos = 790.0;

				SniperText_Xpos = 790.0;
				SniperText_Ypos = 800.0;

				SniperText_Scaling = 1.1;
				SniperRound_Distance = 25;
				SniperRound_Scale = 0.02; //0.02 by default for new icon

				Xpos = 1268.0;
				YPos = 708.0;
				ReticleScale = 0.1875;
				BackgroundScale = 1.0;
				ResolutionFound = true;
				break;
			case 1920:
				switch(C.SizeY)
				{
					case 1440:

						SniperRound_Xpos = 470.0;
						SniperRound_Ypos = 790.0;

						SniperText_Xpos = 470.0;
						SniperText_Ypos = 800.0;

						SniperText_Scaling = 1.1;
						SniperRound_Distance = 25;
						SniperRound_Scale = 0.02;

						XPos = 948.0;
						YPos = 708.0;
						ReticleBackground = Scope_Backgrounds[1]; //Background with a 4:3 Aspect Ratio
						ReticleScale = 0.1875;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:

						SniperRound_Xpos = 470.0;
						SniperRound_Ypos = 670.0;

						SniperText_Xpos = 470.0;
						SniperText_Ypos = 680.0;

						SniperText_Scaling = 1.35;
						SniperRound_Distance = 25;
						SniperRound_Scale = 0.02;

						XPos = 948.0;
						YPos = 588.0;
						ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
						ReticleScale = 0.1875;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1080:

						SniperRound_Xpos = 590.0;
						SniperRound_Ypos = 590.0;

						SniperText_Xpos = 590.0;
						SniperText_Ypos = 600.0;

						SniperText_Scaling = 1.1;
						SniperRound_Distance = 18;
						SniperRound_Scale = 0.015;

						XPos = 951.0;
						YPos = 531.0;
						ReticleBackground = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_1920_1080'; //A one off for the 1080p resolution because the downscaled 1440p one had white artifacting
						ReticleScale = 0.140625;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
				}
				break;
			case 1680:

				SniperRound_Xpos = 411.0;
				SniperRound_Ypos = 586.0;

				SniperText_Xpos = 411.0;
				SniperText_Ypos = 596.0;

				SniperText_Scaling = 1.3;
				SniperRound_Distance = 20;				
				SniperRound_Scale = 0.01776;

				XPos = 829.0;
				YPos = 514.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
				ReticleScale = 0.171875;
				BackgroundScale = 0.888;
				ResolutionFound = true;
				break;
			case 1600:
				switch( C.SizeY )
				{
					case 1200:

						SniperRound_Xpos = 391.0;
						SniperRound_Ypos = 658.0;

						SniperText_Xpos = 391.0;
						SniperText_Ypos = 668.0;

						SniperText_Scaling = BackgroundScale;
						SniperRound_Distance = 22; //18;				
						SniperRound_Scale = 0.01695;

						XPos = 790.0;
						YPos = 590.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
						ReticleScale = 0.15625;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:

						SniperRound_Xpos = 391.0;
						SniperRound_Ypos = 570.0;

						SniperText_Xpos = 391.0;
						SniperText_Ypos = 580.0;

						SniperText_Scaling = 0.9;
						SniperRound_Distance = 22; //18;				
						SniperRound_Scale = 0.01776;

						XPos = 790.0;
						YPos = 502.0;
						ReticleBackground = Scope_Backgrounds[5]; //A one off background for this almost 16:10 Aspect Ratio
						ReticleScale = 0.15625;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 900:

						SniperRound_Xpos = 493.0;
						SniperRound_Ypos = 493.0;

						SniperText_Xpos = 493.0;
						SniperText_Ypos = 503.0;

						SniperText_Scaling = 0.85;
						SniperRound_Distance = 15;				
						SniperRound_Scale = 0.01276;

						XPos = 792.0;
						YPos = 442.0;
						ReticleScale = 0.117185;
						BackgroundScale = 0.625;
						ResolutionFound = true;
						break;
				}
				break;
			case 1440:

				SniperRound_Xpos = 352.0;
				SniperRound_Ypos = 502.0;

				SniperText_Xpos = 352.0;
				SniperText_Ypos = 512.0;

				SniperText_Scaling = 1.1;
				SniperRound_Distance = 18;				
				SniperRound_Scale = 0.015276;

				XPos = 711.0;
				YPos = 440.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
				ReticleScale = 0.140625;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:

				SniperRound_Xpos = 341.0;
				SniperRound_Ypos = 575.0;

				SniperText_Xpos = 341.0;
				SniperText_Ypos = 585.0;

				SniperText_Scaling = 1.0;
				SniperRound_Distance = 22; //18;			
				SniperRound_Scale = 0.016944;

				XPos = 691.0;
				YPos = 516.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
				ReticleScale = 0.15625;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1366:

				SniperRound_Xpos = 420.0;
				SniperRound_Ypos = 420.0;

				SniperText_Xpos = 420.0;
				SniperText_Ypos = 430.0;

				SniperText_Scaling = 0.8;
				SniperRound_Distance = 14;			
				SniperRound_Scale = 0.010832;

				XPos = 676.0;
				YPos = 377.0;
				ReticleScale = 0.1015625;
				BackgroundScale = 0.533; 
				ResolutionFound = true;
				break;
			case 1360:

				SniperRound_Xpos = 420.0;
				SniperRound_Ypos = 414.0;

				SniperText_Xpos = 420.0;
				SniperText_Ypos = 424.0;

				SniperText_Scaling = 0.8;
				SniperRound_Distance = 14;			
				SniperRound_Scale = 0.010832;

				XPos = 676.0;
				YPos = 371.0;
				ReticleScale = 0.1015625;
				BackgroundScale = 0.533; 
				ResolutionFound = true;
				break;
			case 1280:
				XPos = 594.0;
				switch( C.SizeY )
				{
					case 1024:

						SniperRound_Xpos = 292.0;
						SniperRound_Ypos = 561.0;

						SniperText_Xpos = 292.0;
						SniperText_Ypos = 571.0;

						SniperText_Scaling = 1.0;
						SniperRound_Distance = 18; //14;			
						SniperRound_Scale = 0.0144444;

						XPos = 631.0;
						YPos = 503.0;
						ReticleBackground = Scope_Backgrounds[4]; //Background with a 5:4 Aspect Ratio
						ReticleScale = 0.140625;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:

						SniperRound_Xpos = 312.0;
						SniperRound_Ypos = 526.0;

						SniperText_Xpos = 312.0;
						SniperText_Ypos = 536.0;

						SniperText_Scaling = 0.9;
						SniperRound_Distance = 18;		
						SniperRound_Scale = 0.016;

						XPos = 632.0;
						YPos = 472.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
						ReticleScale = 0.125;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:

						SniperRound_Xpos = 313.0;
						SniperRound_Ypos = 446.0;

						SniperText_Xpos = 313.0;
						SniperText_Ypos = 456.0;

						SniperText_Scaling = 1.0;
						SniperRound_Distance = 18; //14;			
						SniperRound_Scale = 0.0132;

						XPos = 632.0;
						YPos = 392.0;
						ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
						ReticleScale = 0.125;
						BackgroundScale = 0.66;
						ResolutionFound = true;
						break;
					case 720:

						SniperRound_Xpos = 395.0;
						SniperRound_Ypos = 395.0;

						SniperText_Xpos = 395.0;
						SniperText_Ypos = 405.0;

						SniperText_Scaling = 0.75;
						SniperRound_Distance = 13;		
						SniperRound_Scale = 0.01;

						XPos = 634.0;
						YPos = 354.0;
						ReticleScale = 0.09375;
						BackgroundScale = 0.5;
						ResolutionFound = true;
						break;
				} 
				break;
			case 1024:

				SniperRound_Xpos = 250.0;
				SniperRound_Ypos = 421.0;

				SniperText_Xpos = 250.0;
				SniperText_Ypos = 431.0;

				SniperText_Scaling = 0.7;
				SniperRound_Distance = 14; //10;			
				SniperRound_Scale = 0.0111;

				XPos = 505.0;
				YPos = 377.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
				ReticleScale = 0.1015625;
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
				HitActorTex = ScopeReticle_Enemy;
			}
			else if( KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				HitActorTex = ScopeReticle_Friendly;
			}
			else
			{
				HitActorTex = ScopeReticle_Default;
			}
			C.DrawTexture(HitActorTex, ReticleScale);
			C.SetPos(0.0, 0.0); //Sets the position to the top left of the screen.
			C.DrawTexture(ReticleBackground, BackgroundScale );

			if(KFPawn_Human(KFPC.Pawn).bFlashlightOn)
			{
				KFPC.SetNightVision(true); //Maybe try using the Effect_NightVision Material. It's defined in FX_Mat_Lib.KF_PP_Master
				KFPC.bGamePlayDOFActive = false;
			}
			else
			{
				KFPC.SetNightVision(false);
			}

			//Round HUD Drawing
			if( AmmoCount[0] > 4 )  //Any amount of rounds greater than 2 left
			{
				//Draw the number of rounds left as text.
				C.SetDrawColor(9, 145, 243, 255);
				C.SetPos(SniperText_Xpos, SniperText_Ypos);
				C.Font = Font'Shared.UI.Halo_UI_Font';
				C.DrawText(AmmoCount[0]$" rounds", false, SniperText_Scaling, SniperText_Scaling);
			}
			else if( AmmoCount[0] == 4 ) //4 Rounds Left
			{
				//Drawing for the round icons.
				C.SetPos(SniperRound_Xpos , SniperRound_Ypos);
				C.SetDrawColor(9, 145, 243, 255); //Set to blue
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale);
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + SniperRound_Distance);
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale);
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 2));
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale);
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 3));
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale);
			}
			else if( AmmoCount[0] == 3 ) //3 Rounds Left
			{
				//Drawing for the round icons.
				/* Deprecated. Alphacolor was changing based on framerate as DrawHUD gets called every frame.
				//If timer active, change the alpha on the color to fade the image.
				if(IsTimerActive('SniperUI_Loop')) {
					if(GetRemainingTimeForTimer('SniperUI_Loop') <= 1.0 && GetRemainingTimeForTimer('SniperUI_Loop') > 0) {
						ALPHACOLOR = SniperUI_Sine.SinChange(SineChangeRate);
					}
				}
				else { //This is the check to let any fade in or out complete.
					if(SniperUI_Sine.ColorChangeAmount_A > 0) {
						ALPHACOLOR = SniperUI_Sine.SinChange(SineChangeRate);
					}
					else { //Loop restart
						SetTimer(1.8, false, 'SniperUI_Loop');
						SniperUI_Sine.ColorChangeAmount_A = SniperUI_Sine.Default.ColorChangeAmount_A; //0
						if(SniperUI_Sine.IsMinMaxSet) {
							SniperUI_Sine.UITime = SniperUI_Sine.MinTime;
						}
					}
				}
				*/
				C.SetPos(SniperRound_Xpos , SniperRound_Ypos);
				Scope_RocketAmmo_Movie.Play();

				C.SetDrawColor(237, 53, 56, 255); //Set to red
				C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 1
				C.SetDrawColor(9, 145, 243, 255); //Set to blue
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + SniperRound_Distance);
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale); //Blue 1
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 2));
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale); //Blue 2
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 3));
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale); //Blue 3
				C.SetDrawColor( 255, 255, 255, 255); //Reset Draw Color
			}
			else if( AmmoCount[0] == 2 ) //2 Rounds Left
			{
				//Drawing for the round icons.

				C.SetPos(SniperRound_Xpos , SniperRound_Ypos);
				Scope_RocketAmmo_Movie.Play();

				C.SetDrawColor(237, 53, 56, 255); //Set to red
				C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 1
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + SniperRound_Distance);
				C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 2
				C.SetDrawColor(9, 145, 243, 255); //Set to blue
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 2));
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale); //Blue 1
				C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 3));
				C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale); //Blue 2
				C.SetDrawColor( 255, 255, 255, 255); //Reset Draw Color
			}
			else // Less than or equal to 1 round left
			{
				C.SetPos(SniperRound_Xpos , SniperRound_Ypos);
				Scope_RocketAmmo_Movie.Play();

				if( AmmoCount[0] == 1 ) {
					C.SetDrawColor(237, 53, 56, 255); //Set to red
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 1
					C.SetPos(SniperRound_Xpos, SniperRound_Ypos + SniperRound_Distance);
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 2
					C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 2));
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 3
					C.SetDrawColor(9, 145, 243, 255); //Set to blue
					C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 3));
					C.DrawTexture( Scope_RocketAmmo, SniperRound_Scale); //Blue 1
				}
				else {
					C.SetDrawColor(237, 53, 56, 255); //Set to red
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 1
					C.SetPos(SniperRound_Xpos, SniperRound_Ypos + SniperRound_Distance);
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 2
					C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 2));
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 3
					C.SetPos(SniperRound_Xpos, SniperRound_Ypos + (SniperRound_Distance * 3));
					C.DrawTexture( Scope_RocketAmmo_Movie, SniperRound_Scale); //Red 4
				}
				C.SetDrawColor( 255, 255, 255, 255); //Reset Draw Color
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
		/*
		if(SniperUI_Sine == none)
		{
			SniperUI_Sine = New class'ChangeBySine';
		}
		SniperUI_Sine.ColorChangeAmount_A = SniperUI_Sine.Default.ColorChangeAmount_A; //0
		if(SniperUI_Sine.IsMinMaxSet)
		{
			SniperUI_Sine.UITime = SniperUI_Sine.MinTime;
		}
		*/
	}
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
	maxRecoilPitch=900 //1200
	minRecoilPitch=500 //775
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

	// Inventory
	InventorySize=10
	GroupPriority=150
	WeaponSelectTexture=Texture2D'SRS99_AM.UI.SRS99_AM_UI_v1'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_SRS99_AM'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_SRS99_AM'
	FireInterval(DEFAULT_FIREMODE)=0.69 //0.66
	PenetrationPower(DEFAULT_FIREMODE)=10 //5.0
	Spread(DEFAULT_FIREMODE)=0.0
	InstantHitDamage(DEFAULT_FIREMODE)=475 //550.0 //950

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

		//Textures for the scope background
	Scope_Backgrounds[0] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background' //Default background with a 16:9 Aspect Ratio
	Scope_Backgrounds[1] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_4_3_AR' //Background with a 4:3 Aspect Ratio
	Scope_Backgrounds[2] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_4_3_AR_Small_Box' //Background with a 4:3 Aspect Ratio, but a smaller inner circle
	Scope_Backgrounds[3] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_16_10_AR' //Background with a 16:10 Aspect Ratio
	Scope_Backgrounds[4] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_5_4_AR' //Background with a 5:4 Aspect Ratio
	Scope_Backgrounds[5] = Texture2D'SRS99_AM.UI.SRS99_Scope_Background_1600_1024' //A one off background for this almost 16:10 Aspect Ratio

	ScopeReticle_Default = Texture2D'SRS99_AM.UI.SRS99_AM_Reticle' //Base texture size is 128 x 128
	ScopeReticle_Enemy = Texture2D'SRS99_AM.UI.SRS99_AM_Reticle_Enemy_Highlight' //Base texture size is 128 x 128
	ScopeReticle_Friendly = Texture2D'SRS99_AM.UI.SRS99_AM_Reticle_Friendly_Highlight' //Base texture size is 128 x 128

	//SineChangeRate = 110 //60 //38
	Scope_RocketAmmo_Movie = TextureMovie'SRS99_AM.UI.SRS99_AM_New_Bullet'
	Scope_RocketAmmo = Texture2D'SRS99_AM.UI.SRS99_AM_New_Bullet'
}
