//=============================================================================
// Base File: KFWeap_SMG_P90
//=============================================================================
// Class Description
//=============================================================================
// Killing Floor 2
// Gear Shift Gaming Mods
//  - Author 06/02/2019
//=============================================================================

class KFWeap_SMG_M7S extends KFWeap_SMGBase;

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
		ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background'; //Default Background, using 16:9 Aspect Ratio.
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
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_AR'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 1.0;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 895.5;
						YPos = 535.7;
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						YPos = 480.0;
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_1600_1024'; //A one off background for this almost 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_16_10_AR';
				ReticleScale = 0.5;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 668.0;
				YPos = 493.0;
				ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_5_4_AR'; //Background using 5:4 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						XPos = 609.0;
						YPos = 449.0;
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
						ReticleScale = 0.5;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						XPos = 605.0;
						YPos = 364.0;
						ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_16_10_AR'; //Background using 16:10 Aspect Ratio.
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
				ReticleBackground = Texture2D'M7S.UI.M7S_Reticle_Background_4_3_AR_Small_Circle'; //Background using 4:3 Aspect Ratio.
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
					C.DrawTexture(Texture2D'M7S.UI.M7S_Reticle_Enemy_Highlight_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}
			else if( KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(Texture2D'M7S.UI.M7S_Reticle_Friendly_Highlight_Reticle', ReticleScale ); //Base texture size is 128 x 128
			}
			else
			{
				C.DrawTexture(Texture2D'M7S.UI.M7S_Reticle', ReticleScale ); //Base texture size is 128 x 128
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
	// Inventory
	InventorySize=7
	GroupPriority=120
	WeaponSelectTexture=Texture2D'M7S.Textures.M7S_UI_v1'

	// FOV
	MeshFOV=75
	MeshIronSightFOV=5 //60
	PlayerIronSightFOV=65 //75

	// Zooming/Position
	IronSightPosition=(X=0,Y=10,Z=5.1)
	PlayerViewOffset=(X=19,Y=10,Z=-0.5)

	//Content
	PackageKey="M7S"
	FirstPersonMeshName="M7S.Mesh.Wep_1stP_M7S_Rig"
	FirstPersonAnimSetNames(0)="M7S.Anims.Wep_1stP_M7S_Anim"
	PickupMeshName="M7S.Mesh.Wep_3rdP_M7S_Pickup"
	AttachmentArchetypeName="M7S.Archetypes.Wep_M7S_3P"
	MuzzleFlashTemplateName="M7S.Archetypes.Wep_M7S_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=48
	SpareAmmoCapacity[0]=480 //432
	InitialSpareMags[0]=3
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=70
	minRecoilPitch=55
	maxRecoilYaw=55 //50
	minRecoilYaw=-55 //50
	RecoilRate=0.06
	RecoilMaxYawLimit=400
	RecoilMinYawLimit=65135
	RecoilMaxPitchLimit=800
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=130 //150
	RecoilISMinYawLimit=65385
	RecoilISMaxPitchLimit=150
	RecoilISMinPitchLimit=65435
	IronSightMeshFOVCompensationScale=2.0

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M7S'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M7S'
	FireInterval(DEFAULT_FIREMODE)=+.0666 // 900 RPM
	Spread(DEFAULT_FIREMODE)=0.012
	InstantHitDamage(DEFAULT_FIREMODE)=45 //43
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_M7S'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_M7S'
	FireInterval(ALTFIRE_FIREMODE)=+.0666
	InstantHitDamage(ALTFIRE_FIREMODE)=45 //43
	Spread(ALTFIRE_FIREMODE)=0.012

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M7S'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_Single', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_Single')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_Single', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_Single')

	//@todo: add akevents when we have them
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'M7S.Audio.Play_dryfire'

	/* 
	//Advanced (High RPM) Fire Effects
	bLoopingFireAnim(DEFAULT_FIREMODE)=true
	bLoopingFireSnd(DEFAULT_FIREMODE)=true
	WeaponFireLoopEndSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M7S.Audio.Play_Fire_3P_EndLoop', FirstPersonCue=AkEvent'M7S.Audio.Play_Fire_1P_EndLoop')
	SingleFireSoundIndex=ALTFIRE_FIREMODE
	*/

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false
	bHasLaserSight=true //true

	//Custom Animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	AssociatedPerkClasses(0)=class'KFPerk_Swat'

	// Weapon Upgrade stat boosts
	//WeaponUpgrades[1]=(IncrementDamage=1.14f,IncrementWeight=1)
	//WeaponUpgrades[2]=(IncrementDamage=1.28f,IncrementWeight=2)

	//WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.45f), (Stat=EWUS_Damage1, Scale=1.45f), (Stat=EWUS_Weight, Add=1)))
}
