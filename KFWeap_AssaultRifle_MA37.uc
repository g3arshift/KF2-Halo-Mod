//=============================================================================
// Base File: KFWeap_Bullpup
//=============================================================================
// An MA37 Assault Rifle
//=============================================================================
// Gear Shift Gaming Mods 8/6/2019
//=============================================================================

class KFWeap_AssaultRifle_MA37 extends KFWeap_RifleBase;

var array<MaterialInstanceConstant> DisplayPlateColors;
var array<MaterialInstanceConstant> BulletPlateColors;
var array<MaterialInstanceConstant> Compass_High;
var array<MaterialInstanceConstant> Compass_Medium;
var array<MaterialInstanceConstant> Compass_Low;

var KFPlayerController KFPC;
var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Headshot, Reticle_Friendly;

var Halo_Weapon_UI MA37_UI;

var Standard_Ammo_Display MA37_Display;
var float AmmoYellow, AmmoRed;

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
    	SpeedReloadRate = GetReloadRateScale() * 0.25; //The percentage to add to the rate the reload takes. If you set it to 0.15, it reloads 15% faster.
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

	if(MA37_Display == none)
	{
		MA37_Display = New class'Standard_Ammo_Display';
	}

	if(MA37_UI == none)
	{
		MA37_UI = New class'Halo_Weapon_UI';
	}


	MA37_Display.InitializeDisplay(KFPC, 2, 6, AmmoYellow, AmmoRed);
	MA37_UpdateDisplay();
}

//Updates the display on the gun to show the correct ammunition, and also (later) change the color of the entire display to appropriately match the bullet display color.
simulated function MA37_UpdateDisplay()
{

	MA37_Display.RunDisplay(Mesh);

	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
	{
		Mesh.SetMaterial( 4, DisplayPlateColors[0] ); //Display Plate Background Display
		Mesh.SetMaterial( 5, BulletPlateColors[0] ); //Bullet Plate Background Display
	}
	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
	{
		Mesh.SetMaterial( 4, DisplayPlateColors[1] ); //Display Plate Background Display
		Mesh.SetMaterial( 5, BulletPlateColors[1] ); //Bullet Plate Background Display
	}
	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoRed)
	{
		Mesh.SetMaterial( 4, DisplayPlateColors[2] ); //Display Plate Background Display
		Mesh.SetMaterial( 5, BulletPlateColors[2] ); //Bullet Plate Background Display
	}
}

simulated state Reloading
{
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		MA37_UpdateDisplay();
		UpdateCompass();
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		MA37_UpdateDisplay();
		UpdateCompass();
	}
}

simulated function ConsumeAmmo( byte FireModeNum )
{
	super.ConsumeAmmo( FireModeNum );
	MA37_UpdateDisplay();
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

	//TODO: Change to an enum.
	//All angles point to the opposite direction so it rotates counter-clockwise
	if (Angle >= 12288 && Angle < 20480) //North East
    {
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[0]); //1
    		//`log("North East");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[7]); //2
    		//`log("East");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[6]); //3
    		//`log("South East");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[5]); //4
    		//`log("South");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[4]); //5
    		//`log("South West");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[3]); //6
    		//`log("West");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[2]); //7
    		//`log("North West");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
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
    	if ( AmmoCount[0] > MagazineCapacity[0] * AmmoYellow ) //Previously was 0.75
    	{
    		Mesh.SetMaterial( 3, Compass_High[1]); //0
    		//`log("North East");
    	}
    	else if ( AmmoCount[0] <= MagazineCapacity[0] * AmmoYellow && AmmoCount[0] > MagazineCapacity[0] * AmmoRed ) //Previously was 0.74
    	{
    		Mesh.SetMaterial( 3, Compass_Medium[1]); //0
    	}
    	else    	
    	{
    		Mesh.SetMaterial( 3, Compass_Low[1]); //0
    	}
    }
}

simulated event Tick( float DeltaTime )
{
	super.Tick(DeltaTime);
	UpdateCompass();
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

//This function runs continuously, and when iron sights are being used it does the drawing.
simulated function DrawHUD( HUD H, Canvas C )
{
	super.DrawHUD(H, C);

	if(!MA37_UI.isInitialized)
	{
		MA37_UI.InitializeWeaponUI(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy);
	}

	if( bUsingSights )
	{
		MA37_UI.RunWeaponUI(C);
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

function ZoomTimer()
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
	IronSightMeshFOVCompensationScale=1.8 //1.5


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
	PenetrationPower(DEFAULT_FIREMODE)=1.5 //1.0
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

	AmmoYellow = 0.5
	AmmoRed = 0.31

	//TODO: Change to an enum.
	DisplayPlateColors[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_DisplayPlate';
	DisplayPlateColors[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_DisplayPlate';
	DisplayPlateColors[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_DisplayPlate';

	//TODO: Change to an enum.
	BulletPlateColors[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_BulletPlate';
	BulletPlateColors[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_BulletPlate';
	BulletPlateColors[2] = MaterialInstanceConstant'MA37.AmmoCounter_30Below.Low_BulletPlate';

	//TODO: Change to an enum.
	Compass_High[0] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_North';
	Compass_High[1] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_NorthEast';
	Compass_High[2] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_East';
	Compass_High[3] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_SouthEast';
	Compass_High[4] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_South';
	Compass_High[5] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_SouthWest';
	Compass_High[6] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_West';
	Compass_High[7] = MaterialInstanceConstant'MA37.AmmoCounter_75Up.High_NorthWest';

	//TODO: Change to an enum.
	Compass_Medium[0] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_North';
	Compass_Medium[1] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_NorthEast';
	Compass_Medium[2] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_East';
	Compass_Medium[3] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_SouthEast';
	Compass_Medium[4] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_South';
	Compass_Medium[5] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_SouthWest';
	Compass_Medium[6] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_West';
	Compass_Medium[7] = MaterialInstanceConstant'MA37.AmmoCounter_31_To_74.Medium_NorthWest';

	//TODO: Change to an enum.
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

	UIBackgrounds[0] = Texture2D'Shared.UI.Basic_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'Shared.UI.Basic_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'Shared.UI.Basic_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'Shared.UI.Basic_Reticle_Background_v2'
	UIBackgrounds[4] = Texture2D'Shared.UI.Basic_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'Shared.UI.Basic_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'Shared.UI.Basic_Reticle_Background_32_9_v2'

	//Reticles
	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=516, V=0, UL=144, VL=144)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=661, V=0, UL=144, VL=144)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=806, V=0, UL=144, VL=144)
}