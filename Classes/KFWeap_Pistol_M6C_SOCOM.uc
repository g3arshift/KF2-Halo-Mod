//=============================================================================
// Base File: KFWeap_Revolver_SW500
//=============================================================================
// A Silenced M6C Pistol
//=============================================================================
// Gear Shift Gaming Mods 6/8/2019
//=============================================================================

class KFWeap_Pistol_M6C_SOCOM extends KFWeap_PistolBase;

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
		ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background'; //Default Background, using 16:9 Aspect Ratio.
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
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_4_3_AR'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 929.5;
						YPos = 569.7;
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						YPos = 480.0;
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_1600_1024'; //A one off background for this almost 16:10 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 900:
						YPos = 417.0;
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background'; //Background using 16:9 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.625;
						ResolutionFound = true;
						break;
				}
				break;
			case 1440:
				XPos = 690.0;
				YPos = 417.0;
				ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_16_10_AR';
				ReticleScale = 0.5;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 670.0;
				YPos = 494.0;
				ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_5_4_AR'; //Background using 5:4 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						YPos = 450.0;
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						YPos = 367.0;
						ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'M6C-SOCOM.UI.M6S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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
				C.DrawTexture(Texture2D'M6C-SOCOM.UI.M6S_Reticle', ReticleScale ); //Base texture size is 128 x 128
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
		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}
	else
	{
		ZoomIn=AkEvent'M6C-SOCOM.Audio.Play_M6S_zoom_in';
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
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		LaserSight.LaserSightMeshComp.SetSkeletalMesh(SkeletalMesh'FX_Wep_Laser_MESH.WEP_Laser_1P_SK');
		LaserSight.LaserDotMeshComp.SetStaticMesh(StaticMesh'FX_Wep_Laser_MESH.laser_dot_SM');
	}
}

defaultproperties
{
    // FOV
	MeshFOV=86 //86
	MeshIronSightFOV=5 //77
    PlayerIronSightFOV=30

	// Depth of field
	DOF_FG_FocalRadius=38
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=20.0,Y=12,Z=-4) //-6 //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	IronSightPosition=(X=10,Y=10,Z=2.57) //(X=10,Y=0,Z=2.57)

	// Content
	PackageKey="M6C_SOCOM"
	FirstPersonMeshName="M6C-SOCOM.Meshes.Wep_1stP_M6C-SOCOM_Rig"
	FirstPersonAnimSetNames(0)="M6C-SOCOM.1stP_Anims.Wep_1stP_M6C-SOCOM_Anim"
	PickupMeshName="M6C-SOCOM.Meshes.M6C_SOCOM_Pickup"
	AttachmentArchetypeName="M6C-SOCOM.Archetypes.Wep_M6C_SOCOM_3P"
	MuzzleFlashTemplateName="M7S.Archetypes.Wep_M7S_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=12
	SpareAmmoCapacity[0]=180 //168
	InitialSpareMags[0]=4 //3
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=185 //200
	minRecoilPitch=185 //200
	maxRecoilYaw=50 //60
	minRecoilYaw=-45 //-55
	RecoilRate=0.07
	RecoilMaxYawLimit=460
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=700 //900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=100
	RecoilISMinPitchLimit=65485
	IronSightMeshFOVCompensationScale=4.0

	// DEFAULT_FIREMODE
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M6C_SOCOM'
	FireInterval(DEFAULT_FIREMODE)=+0.12 //0.14
	InstantHitDamage(DEFAULT_FIREMODE)=50 //42
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M6C_SOCOM'
	Spread(DEFAULT_FIREMODE)=0.01 //0.012
	PenetrationPower(DEFAULT_FIREMODE)=0.0 //2.0
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None


	// BASH_FIREMODE
	InstantHitDamage(BASH_FIREMODE)=23
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M6C_SOCOM'

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M6C-SOCOM.Audio.Play_Fire_3P', FirstPersonCue=AkEvent'M6C-SOCOM.Audio.Play_Fire_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M6C.Audio.Play_WEP_M6C_Handling_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false
	bHasLaserSight=true //true

	// Inventory
	InventorySize=3 //3
	GroupPriority=59
	InventoryGroup=IG_Primary
	bCanThrow=true
	bDropOnDeath=true
	WeaponSelectTexture=Texture2D'M6C-SOCOM.Textures.M6S_UI_v1'
	bIsBackupWeapon=false
	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'
	AssociatedPerkClasses(1)=class'KFPerk_SWAT'

	// Custom animations
	FireSightedAnims=(Shoot_Iron, Shoot_Iron2, Shoot_Iron3)
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2, Guncheck_v3, Guncheck_v4)

	bHasFireLastAnims=true
	BonesToLockOnEmpty=(RW_Bolt, RW_Bullets1)

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Medium_Recoil'

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.1f)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.25f), (Stat=EWUS_Weight, Add=1)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=1.4f), (Stat=EWUS_Weight, Add=2)))
}