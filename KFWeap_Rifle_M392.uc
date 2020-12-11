//=============================================================================
// Base File: KFWeap_Bullpup
//=============================================================================
// An M392 DMR
//=============================================================================
// Gear Shift Gaming 3/14/2020
//=============================================================================

class KFWeap_Rifle_M392 extends KFWeap_RifleBase;

//3 is right display
//4 is left display

var KFPlayerController KFPC;

var Standard_Ammo_Display M392_Display;
var float AmmoRed, AmmoYellow;

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

function ZoomTimer()
{
	return;
	//This is only here to stop logging errors.
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

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Weight, Add=1)))

	
}


