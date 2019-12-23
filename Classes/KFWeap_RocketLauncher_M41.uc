//=============================================================================
// Base File: KFWeap_RocketLauncher_RPG7
//=============================================================================
// A rocket launcher that can fire two big rockets back to back
//=============================================================================
// Gear Shift Gaming Mods 9/6/2019
//=============================================================================
class KFWeap_RocketLauncher_M41 extends KFWeap_GrenadeLauncher_Base;

var array<Texture2D> Scope_Backgrounds;
var PlayerController KFPC;
var KFGameReplicationInfo MyKFGRI;

var Texture2D ScopeReticle_Default;
var Texture2D ScopeReticle_Enemy;
var Texture2D ScopeReticle_Friendly;

var ChangeBySine RocketUI_Sine;
var float Xpos, Ypos, Rocket_Xpos, Rocket_Ypos, Rocket_Scale, RocketText_Xpos, RocketText_Ypos, RocketText_Scaling, ReticleScale, BackgroundScale;
var int Rocket_Distance;
var int SineChangeRate;

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
	local bool ResolutionFound;
	local Texture2D ReticleBackground;

	//These are the variables for the tracing system.
	local vector TraceStart, TraceEnd;
	local vector InstantTraceHitLocation, InstantTraceHitNormal;
	local vector TraceAimDir;
	local Actor	HitActor;
	local TraceHitInfo HitInfo;
	local int ALPHACOLOR;

	super.DrawHUD(H, C);

	if( bUsingSights )
	{
		C.EnableStencilTest(true); //Makes the draw calls draw over the weapons

		//Sets the position and scaling variables for the textures for different resolutions. It checks for X Resolution first, then Y resolution.
		ReticleBackground = Scope_Backgrounds[0]; //Default background with a 16:9 Aspect Ratio
		switch(C.SizeX)
		{
			case 2560:
				Rocket_Xpos = 984.0;
				Rocket_Ypos = 855.0;

				RocketText_Xpos = 974.0;
				RocketText_Ypos = 899.0;

				RocketText_Scaling = 1.0;
				Rocket_Distance = 42;
				Rocket_Scale = 1.0;

				Xpos = 1208.0;
				YPos = 648.0;
				ReticleScale = 1.125;
				BackgroundScale = 1.0;
				ResolutionFound = true;
				break;
			case 1920:
				switch(C.SizeY)
				{
					case 1440:
						XPos = 881.0;
						YPos = 638.0;
						ReticleBackground = Scope_Backgrounds[1]; //Background with a 4:3 Aspect Ratio
						ReticleScale = 1.25;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1200:
						XPos = 879.5;
						YPos = 519.7;
						ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
						ReticleScale = 1.25;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1080:
						ReticleScale = 0.875;
						BackgroundScale = 0.75;
						XPos = 904.0;
						YPos = 484.0;
						ResolutionFound = true;
						break;
				}
				break;
			case 1680:
				XPos = 782.0;
				YPos = 464.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
				ReticleScale = 0.925;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1600:
				XPos = 754.0;
				switch( C.SizeY )
				{
					case 1200:
						XPos = 752.0;
						YPos = 552.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
						ReticleScale = 0.75;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 1024:
						YPos = 464.0;
						ReticleBackground = Scope_Backgrounds[5]; //A one off background for this almost 16:10 Aspect Ratio
						ReticleScale = 0.75;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 900:
						XPos = 768.5;
						YPos = 417.0;
						ReticleScale = 0.75;
						BackgroundScale = 0.625;
						ResolutionFound = true;
						break;
				}
				break;
			case 1440:
				XPos = 652.0;
				YPos = 401.0;
				ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
				ReticleScale = 0.75;
				BackgroundScale = 0.75;
				ResolutionFound = true;
				break;
			case 1400:
				XPos = 652.0;
				YPos = 477.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
				ReticleScale = 0.75;
				BackgroundScale = 0.875;
				ResolutionFound = true;
				break;
			case 1366:
				XPos = 634.0;
				YPos = 335.0;
				ReticleScale = 0.75;
				BackgroundScale = 0.533; 
				ResolutionFound = true;
				break;
			case 1360:
				XPos = 634.0;
				YPos = 337.0;
				ReticleScale = 0.75;
				BackgroundScale = 0.5335; 
				ResolutionFound = true;
				break;
			case 1280:
				XPos = 594.0;
				switch( C.SizeY )
				{
					case 1024:
						XPos = 592.0;
						YPos = 464.0;
						ReticleBackground = Scope_Backgrounds[4]; //Background with a 5:4 Aspect Ratio
						ReticleScale = 0.75;
						BackgroundScale = 1.0;
						ResolutionFound = true;
						break;
					case 960:
						XPos = 593.0;
						YPos = 433.0;
						ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
						ReticleScale = 0.75;
						BackgroundScale = 0.8;
						ResolutionFound = true;
						break;
					case 800:
						XPos = 6589.0;
						YPos = 348.0;
						ReticleBackground = Scope_Backgrounds[3]; //Background with a 16:10 Aspect Ratio
						ReticleScale = 0.75;
						BackgroundScale = 0.66;
						ResolutionFound = true;
						break;
					case 720:
						YPos = 312.0;
						XPos = 592.0;
						ReticleScale = 0.75;
						BackgroundScale = 0.5;
						ResolutionFound = true;
						break;
				} 
				break;
			case 1024:
				XPos = 466.0;
				YPos = 336.0;
				ReticleBackground = Scope_Backgrounds[2]; //Background with a 4:3 Aspect Ratio, but with a smaller inner circle
				ReticleScale = 0.75;
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
				KFPC = GetALocalPlayerController();
			}

			TraceStart = KFPC.Pawn.Weapon.Instigator.GetWeaponStartTraceLocation();
			TraceAimDir = Vector( KFPC.Pawn.Weapon.Instigator.GetAdjustedAimFor( KFPC.Pawn.Weapon, TraceStart ));
			TraceEnd = TraceStart + TraceAimDir * 20000; //200M
			HitActor = KFPC.Pawn.Weapon.GetTraceOwner().Trace(InstantTraceHitLocation, InstantTraceHitNormal, TraceEnd, TraceStart, TRUE, vect(0,0,0), HitInfo, KFPC.Pawn.Weapon.TRACEFLAG_Bullet);

			if( KFPawn_Monster(HitActor) != none && KFPawn_Monster(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(ScopeReticle_Enemy, ReticleScale );
			}
			else if( KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
			{
				C.DrawTexture(ScopeReticle_Friendly, ReticleScale );
			}
			else
			{
				C.DrawTexture(ScopeReticle_Default, ReticleScale );
			}
			C.SetPos(0.0, 0.0 ); //Sets the position to the top left of the screen.
			C.DrawTexture(ReticleBackground, BackgroundScale );

			//Rocket HUD Drawing
			if( AmmoCount[0] > 2)  //Any amount of rockets greater than 2 left
			{
				//Draw the number of rockets left as text.
				C.SetDrawColor(9, 145, 243, 255);
				C.SetPos(RocketText_Xpos, RocketText_Ypos);
				C.Font = Font'Shared.UI.Halo_UI_Font';
				C.DrawText(AmmoCount[0]$" rockets", false, RocketText_Scaling, RocketText_Scaling);
				C.SetDrawColor( 255, 255, 255, 255); //Reset Draw Color
			}
			else if( AmmoCount[0] == 2 ) //2 Rockets left
			{
				//Drawing for the rocket icons.
				C.SetPos(Rocket_Xpos , Rocket_Ypos);
				C.SetDrawColor(9, 145, 243, 255); //Set to blue
				C.DrawTexture( Texture2D'M41.UI.M41_UI_White_Rocket', Rocket_Scale);
				C.SetPos(Rocket_Xpos, Rocket_Ypos + Rocket_Distance);
				C.DrawTexture( Texture2D'M41.UI.M41_UI_White_Rocket', Rocket_Scale);
				C.SetDrawColor( 255, 255, 255, 255); //Reset Draw Color
			}
			else // Less than or equal to 1 Rocket left
			{
				// loop shit
				if(IsTimerActive('RocketUI_Loop')) {
					if(GetRemainingTimeForTimer('RocketUI_Loop') <= 1.0 && GetRemainingTimeForTimer('RocketUI_Loop') > 0) {
						ALPHACOLOR = RocketUI_Sine.SinChange(SineChangeRate);
					}
				}
				else {
					if(RocketUI_Sine.ColorChangeAmount_A > 0) {
						ALPHACOLOR = RocketUI_Sine.SinChange(SineChangeRate);
					}
					else {
						SetTimer(1.8, false, 'RocketUI_Loop');
						RocketUI_Sine.ColorChangeAmount_A = RocketUI_Sine.Default.ColorChangeAmount_A; //0
						if(RocketUI_Sine.IsMinMaxSet) {
							RocketUI_Sine.UITime = RocketUI_Sine.MinTime;
						}
					}
				}
				C.SetPos(Rocket_Xpos , Rocket_Ypos);
				RocketUI_Sine.ColorChangeAmount_A = ALPHACOLOR;
				if( AmmoCount[0] == 1 ) {
					C.SetDrawColor(237, 53, 56, RocketUI_Sine.ColorChangeAmount_A);
					C.DrawTexture( Texture2D'M41.UI.M41_UI_White_Rocket', Rocket_Scale);
					C.SetPos(Rocket_Xpos, Rocket_Ypos + Rocket_Distance);
					C.SetDrawColor(9, 145, 243, 255); //Set to blue
					C.DrawTexture( Texture2D'M41.UI.M41_UI_White_Rocket', Rocket_Scale);
				}
				else {
					C.SetDrawColor(237, 53, 56, RocketUI_Sine.ColorChangeAmount_A);
					C.DrawTexture( Texture2D'M41.UI.M41_UI_White_Rocket', Rocket_Scale);
					C.SetPos(Rocket_Xpos, Rocket_Ypos + Rocket_Distance);
					C.SetDrawColor(237, 53, 56, RocketUI_Sine.ColorChangeAmount_A);
					C.DrawTexture( Texture2D'M41.UI.M41_UI_White_Rocket', Rocket_Scale);
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
		if(RocketUI_Sine == none)
		{
			RocketUI_Sine = New class'ChangeBySine';
		}
		RocketUI_Sine.ColorChangeAmount_A = RocketUI_Sine.Default.ColorChangeAmount_A; //0
		if(RocketUI_Sine.IsMinMaxSet)
		{
			RocketUI_Sine.UITime = RocketUI_Sine.MinTime;
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
		ZoomOut=AkEvent'M41.Audio.Play_M41_Zoom_Out';
		if(IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomOut);
			Cleartimer('ZoomTimer');
		}
	}
	else
	{
		ZoomIn=AkEvent'M41.Audio.Play_M41_Zoom_In';
		if(!IsTimerActive('ZoomTimer'))
		{
			WeaponZoomSound(ZoomIn);
			SetTimer(300.0, false, 'ZoomTimer');
		}
	}
}

defaultproperties
{
	ForceReloadTime=0.4f

	// Inventory
	InventoryGroup=IG_Primary
	GroupPriority=100
	InventorySize=9 //10
	WeaponSelectTexture=Texture2D'M41.UI.M41_UI_v1'

    // FOV
	MeshFOV=70
	MeshIronSightFOV=5
    PlayerIronSightFOV=50

	// Depth of field
	DOF_FG_FocalRadius=50
	DOF_FG_MaxNearBlurSize=2.5

	// Zooming/Position
	PlayerViewOffset=(X=22.0,Y=7.8,Z=7.5) //X is the back and forth positioning, Y is the side to side positioning, Z is the up and down positioning.
	IronSightPosition=(X=0,Y=10,Z=0)
	FastZoomOutTime=0.2

	// Content
	PackageKey="M41"
	FirstPersonMeshName="M41.Mesh.Wep_1stP_M41_Rig"
	FirstPersonAnimSetNames(0)="M41.1stp_anims.Wep_1stP_M41_Anim"
	PickupMeshName="M41.Mesh.Wep_M41_Pickup"
	AttachmentArchetypeName="M41.Archetypes.Wep_M41_3P"
	MuzzleFlashTemplateName="M41.Archetypes.Wep_M41_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=3
	SpareAmmoCapacity[0]=15
	InitialSpareMags[0]=4
	AmmoPickupScale[0]=1.0
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=900
	minRecoilPitch=775
	maxRecoilYaw=500
	minRecoilYaw=-500
	RecoilRate=0.085
	RecoilBlendOutRatio=0.35
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=1500
	RecoilMinPitchLimit=64785
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=500
	RecoilISMinPitchLimit=65485
	RecoilViewRotationScale=0.8
	FallingRecoilModifier=1.5
	HippedRecoilModifier=1.25

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'UI_FireModes_TEX.UI_FireModeSelect_Rocket'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSinglefiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Rocket_M41'
	FireInterval(DEFAULT_FIREMODE)=+1.2
	InstantHitDamage(DEFAULT_FIREMODE)=150.0
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M41Impact'
	Spread(DEFAULT_FIREMODE)=0.025
	FireOffset=(X=20,Y=4.0,Z=-3)

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M41'
	InstantHitDamage(BASH_FIREMODE)=29

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'M41.Audio.Play_M41_Fire_3P', FirstPersonCue=AkEvent'M41.Audio.Play_M41_Fire_1P')

	//@todo: add akevent when we have it
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_RPG7.Play_WEP_SA_RPG7_DryFire'

	// Animation
	bHasFireLastAnims=true
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	BonesToLockOnEmpty=(RW_Grenade1)
	MeleeAttackAnims=(Bash, Bash_2)

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

	AssociatedPerkClasses(0)=class'KFPerk_Demolitionist'

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'

	//Textures for the scope background
	Scope_Backgrounds[0] = Texture2D'M41.UI.M41_Reticle_Background' //Default background with a 16:9 Aspect Ratio
	Scope_Backgrounds[1] = Texture2D'M41.UI.M41_Reticle_Background_4_3_AR' //Background with a 4:3 Aspect Ratio
	Scope_Backgrounds[2] = Texture2D'M41.UI.M41_Reticle_Background_4_3_AR_Small_Circle' //Background with a 4:3 Aspect Ratio, but a smaller inner circle
	Scope_Backgrounds[3] = Texture2D'M41.UI.M41_Reticle_Background_16_10_AR' //Background with a 16:10 Aspect Ratio
	Scope_Backgrounds[4] = Texture2D'M41.UI.M41_Reticle_Background_5_4_AR' //Background with a 5:4 Aspect Ratio
	Scope_Backgrounds[5] = Texture2D'M41.UI.M41_Reticle_Background_1600_1024' //A one off background for this almost 16:10 Aspect Ratio

	ScopeReticle_Default = Texture2D'M41.UI.M41_Reticle' //Base texture size is 128 x 128
	ScopeReticle_Enemy = Texture2D'M41.UI.M41_Reticle_Enemy_Highlight_Reticle' //Base texture size is 128 x 128
	ScopeReticle_Friendly = Texture2D'M41.UI.M41_Reticle_Friendly_Highlight_Reticle' //Base texture size is 128 x 128

	SineChangeRate = 40
}
