//=============================================================================
// Base File: KFWeap_Pistol_Deagle
//=============================================================================
// An M6D Magnum, from Halo Combat Evolved
//=============================================================================
// Gear Shift Gaming Mods 7/19/2019
//=============================================================================

class KFWeap_Pistol_M6D extends KFWeap_PistolBase;

var PlayerController KFPC;
var KFWeapon OwningWeapon;

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

simulated function GetActiveWeapon()
{
	if( KFPC != none )
	{
		OwningWeapon = KFWeapon(KFPC.Pawn.Weapon);
	}
	else
	{
		KFPC = GetALocalPlayerController();
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
	GetActiveWeapon();


	if( bUsingSights )
	{
		C.EnableStencilTest(true); //Makes the draw calls draw over the weapons

		//Sets the position and scaling variables for the textures for different resolutions. It checks for X Resolution first, then Y resolution.
		ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background'; //Default Background, using 16:9 Aspect Ratio.
		switch(C.SizeX)
		{
			case 2560:
				Xpos = 1250.0;
				YPos = 690.0;
				ReticleScale = 0.5;
				BackgroundScale = 1.0;
				ResolutionFound = true;
				break;
			case 1920:
				switch(C.SizeY)
				{
					case 1440:
						XPos = 930.0;
						YPos = 688.0;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_4_3_AR'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 929.5;
						YPos = 569.7;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1080:
						ReticleScale = 0.375;
						BackgroundScale = 0.75;
						XPos = 937.5;
						YPos = 517.5;
						ResolutionFound = true;
						break;
				}
				break;
			case 1680:
				XPos = 810.0;
				YPos = 490.0;
				ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
				ReticleScale = 0.5;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1600:
				XPos = 770.0;
				switch( C.SizeY )
				{
					case 1200:
						YPos = 569.7;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						YPos = 480.0;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_1600_1024'; //A one off background for this almost 16:10 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 900:
						YPos = 417.0;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background'; //Background using 16:9 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.625;
						ResolutionFound = true;
						break;
				}
				break;
			case 1440:
				XPos = 690.0;
				YPos = 417.0;
				ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_16_10_AR';
				ReticleScale = 0.5;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 670.0;
				YPos = 494.0;
				ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
				ReticleScale = 0.5;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1366:
				XPos = 649.0;
				YPos = 352.0;
				ReticleScale = 0.5;
				BackgroundScale = 0.533; 
				ResolutionFound = true;
				break;
			case 1360:
				XPos = 650.0;
				YPos = 350.0;
				ReticleScale = 0.5;
				BackgroundScale = 0.5335; 
				ResolutionFound = true;
				break;
			case 1280:
				XPos = 610.0;
				switch( C.SizeY )
				{
					case 1024:
						YPos = 480.0;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_5_4_AR'; //Background using 5:4 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						YPos = 450.0;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						YPos = 367.0;
						ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.66;
						ResolutionFound = true;
						break;
					case 720:
						YPos = 328.0;
						ReticleScale = 0.5;
						BackgroundScale = 0.5;
						ResolutionFound = true;
						break;
				} 
				break;
			case 1024:
				XPos = 482.0;
				YPos = 352.0;
				ReticleBackground = Texture2D'M6D.Textures.M6D_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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
			//Draws the reticle and accompanying elements at the set positions. It also uses the tracing system to detect enemies, headshot shots, and friendlies and change the reticle accordingly.
			C.SetPos(Xpos, Ypos);
			C.SetDrawColor( 255, 255, 255, 255);

			if (KFPC == none )
			{
				`log("No PC");
			}

			if (OwningWeapon == none )
			{
				OwningWeapon = KFWeapon(KFPC.Pawn.Weapon);
				`log( "New Weapon Found" );
			}

			TraceStart = OwningWeapon.Instigator.GetWeaponStartTraceLocation();
			TraceAimDir = Vector( OwningWeapon.Instigator.GetAdjustedAimFor( OwningWeapon, TraceStart ));
			TraceEnd = TraceStart + TraceAimDir * 20000; //200M
			HitActor = OwningWeapon.GetTraceOwner().Trace(InstantTraceHitLocation, InstantTraceHitNormal, TraceEnd, TraceStart, TRUE, vect(0,0,0), HitInfo, OwningWeapon.TRACEFLAG_Bullet);

			if( KFPawn_Monster(HitActor) != none && KFPawn_Monster(HitActor).IsAliveAndWell())
			{
				if(  HitInfo.BoneName == 'head')
				{
					C.DrawTexture(Texture2D'M6C-SOCOM.UI.M6S_Reticle_Enemy_Headshot_Highlight', ReticleScale ); //Base texture size is 128 x 128
				}
				else
				{
					C.DrawTexture(Texture2D'M6C-SOCOM.UI.M6S_Reticle_Enemy_Highlight', ReticleScale ); //Base texture size is 128 x 128
				}
			}
			else if( KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(Texture2D'M6C-SOCOM.UI.M6S_Reticle_Friendly_Highlight', ReticleScale ); //Base texture size is 128 x 128
			}
			else
			{
				C.DrawTexture(Texture2D'M6D.Textures.M6D_Reticle', ReticleScale ); //Base texture size is 128 x 128
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

/*
Deprecated. More costly than the other draw function.
event PostBeginPlay()
{
	PrepareDrawing();
}

function PrepareDrawing()
{
	local KFHUDBase KFHUD;

	if( GetALocalPlayerController() != none )
	{
		KFHUD = KFHUDBase(GetALocalPlayerController().myHud);
		KFHUD.SetShowOverlays( true );
		KFHUD.AddPostRenderedActor(self);
	}
	else
	{
		`log("Local Player Controller Not Found.");
	}
}

simulated event PostRenderFor( PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir )
{
	super.PostRenderFor( PC, Canvas, CameraPosition, CameraDir);
	if(bUsingSights)
	{
		Canvas.SetPos(1250.0, 690.0);
		Canvas.DrawTexture(Texture2D'M6D.Textures.M6D_Reticle', 0.5 ); //Base texture size is 128 x 128

		Canvas.SetPos(0.0, 0.0 ); //Sets the position to the top left of the screen.
		Canvas.DrawTexture(Texture2D'M6D.Textures.M6D_Reticle_Background', 1.0 ); //Base texture size is 2560 x 1440
	}
}
*/

//This is where we both create the zoom effects in canvas, and play the zoom sounds.
simulated function SetIronSights(bool bNewIronSights)
{
	local AkEvent ZoomIn;
	local AkEvent ZoomOut;

	super.SetIronSights(bNewIronSights);

	if(!bUsingSights)
	{
		ZoomOut=AkEvent'M6D.Audio.Play_M6D_zoom_out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
	}
	else
	{
		ZoomIn=AkEvent'M6D.Audio.Play_M6D_zoom_in';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
	}
}

defaultproperties
{
    // FOV
	MeshFOV=86
	MeshIronSightFOV=5
    PlayerIronSightFOV=50

	// Depth of field
	DOF_FG_FocalRadius=50 //38
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=14.0,Y=10,Z=-4)

	//Lower FOV and increase DOF for canvas iron sights.

	// Content
	PackageKey="M6D"
	FirstPersonMeshName="M6D.Mesh.Wep_1stP_M6D_Rig"
	FirstPersonAnimSetNames(0)="M6D.1stp_anims.Wep_1st_M6D_Anim"
	PickupMeshName="M6D.Mesh.M6D_Static"
	AttachmentArchetypeName="M6D.Archetype.Wep_M6D_3P"
	MuzzleFlashTemplateName="M6D.Archetype.Wep_M6D_MuzzleFlash"

   	// Zooming/Position
	IronSightPosition=(X=11,Y=10,Z=0) //(X=11,Y=0,Z=0)

	// Ammo
	MagazineCapacity[0]=12
	SpareAmmoCapacity[0]=120
	InitialSpareMags[0]=0
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=450 //650
	minRecoilPitch=350 //550
	maxRecoilYaw=75 //150
	minRecoilYaw=-75 //-150
	RecoilRate=0.07
	RecoilMaxYawLimit=350 //500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=1250
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=500
	RecoilISMinPitchLimit=65485

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M6D'
	FireInterval(DEFAULT_FIREMODE)=+0.305
	InstantHitDamage(DEFAULT_FIREMODE)=300
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M6D'
	PenetrationPower(DEFAULT_FIREMODE)=1.0
	Spread(DEFAULT_FIREMODE)=0.01 //0.08
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M6D'
	InstantHitDamage(BASH_FIREMODE)=30

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M6D.Audio.Play_Fire_M6D_3P', FirstPersonCue=AkEvent'M6D.Audio.Play_Fire_M6D_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M6C.Audio.Play_WEP_M6C_Handling_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	// Inventory
	InventorySize=6 //4
	GroupPriority=75
	InventoryGroup=IG_Primary
	bCanThrow=true
	bDropOnDeath=true
	WeaponSelectTexture=Texture2D'M6D.Textures.M6D_UI_v1'
	bIsBackupWeapon=false
	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'
	AssociatedPerkClasses(1)=class'KFPerk_Demolitionist'

	// Custom animations
	FireSightedAnims=(Shoot_Iron, Shoot_Iron2, Shoot_Iron3)
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2, Guncheck_v3, Guncheck_v4)

	bHasFireLastAnims=true

	BonesToLockOnEmpty=(RW_Slide, RW_Bullets1)

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Medium_Recoil'
}