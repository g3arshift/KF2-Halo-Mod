//=============================================================================
// Base File: KFWeap_AssaultRifle_AR15
//=============================================================================
// Gear Shift Gaming 9/9/2019
//=============================================================================

class KFWeap_Rifle_BR55 extends KFWeap_RifleBase;

var KFPlayerController KFPC;
var float RefireDelayAmount;

var Standard_Ammo_Display BR55_Display;
var float AmmoYellow, AmmoRed;

var array<Texture2D> UIBackgrounds;
var CanvasIcon Reticle_Neutral, Reticle_Enemy, Reticle_Headshot, Reticle_Friendly;
var CanvasIcon RangeCanvasIcon, ZoomCanvasIcon;
var array<FlavorIcon> FlavorIcons;
var FlavorIcon RangeFlavorIcon;
var FlavorIcon ZoomFlavorIcon;

var Halo_Weapon_UI BR55_UI;

simulated function PlayWeaponEquip( float ModifiedEquipTime )
{
	Super.PlayWeaponEquip( ModifiedEquipTime );
	if(KFPC == None )
	{
		KFPC = KFPlayerController(Instigator.Controller);
	}

	if(BR55_Display == none)
	{
		BR55_Display = New class'Standard_Ammo_Display';
	}

	BR55_Display.InitializeDisplay(KFPC, 4, 3, AmmoYellow, AmmoRed);
	BR55_Display.RunDisplay(Mesh);

	if(BR55_UI == none)
	{
		BR55_UI = New class'Halo_Weapon_UI';
		RangeFlavorIcon = New class'FlavorIcon';
		RangeFlavorIcon.MakeFlavorIcon(RangeCanvasIcon, 673, 433, 922, 666, 1082, 602, 922, 362, 1448, 728, 1362, 362, 2202, 362, 0.2, 0.25, 0.25, 0.25, 0.33, 0.25, 0.25);
		ZoomFlavorIcon = New class'FlavorIcon';
		ZoomFlavorIcon.MakeFlavorIcon(ZoomCanvasIcon, 1281, 937, 1668, 1306, 1828, 1242, 1667, 1002, 2433, 1573, 2108, 1002, 2948, 1002, 0.45161, 0.45161, 0.45161, 0.45161, 0.593548, 0.45161, 0.45161);
		FlavorIcons.AddItem(RangeFlavorIcon);
		FlavorIcons.AddItem(ZoomFlavorIcon);
	}
}

simulated state WeaponBurstFiring
{
	simulated function EndState(Name NextStateName)
	{
		super.EndState(NextStateName);

		if(!IsTimerActive('RefireDelayTimer'))
		{
			RefireDelayAmount = FireInterval[CurrentFireMode] * 0.2 + (FireInterval[CurrentFireMode] * 2);
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

	if(!BR55_UI.isInitialized)
	{
		BR55_UI.InitializeWeaponUI(C, KFPC, UIBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, Reticle_Headshot, true, FlavorIcons);
	}

	if( bUsingSights )
	{
		BR55_UI.RunWeaponUI(C);
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
	}
	else
	{
		ZoomIn=AkEvent'BR55.Audio.Play_BR55_Zoom_In';
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

simulated function ConsumeAmmo( byte FireModeNum )
{
	super.ConsumeAmmo( FireModeNum );
	BR55_UpdateDisplay();
}

simulated state Reloading
{
	simulated function ReloadComplete() //Makes sure that when we finish reloading we reset the display to reflect a full magazine.
	{
		Super.ReloadComplete();

		BR55_UpdateDisplay();
	}

	simulated function AbortReload() //Makes sure that when a reload is cancelled for any reason before it fully completes, or right before it completes, the display updates properly.
	{
		Super.AbortReload();

		BR55_UpdateDisplay();
	}
}

reliable client function BR55_UpdateDisplay()
{
	BR55_Display.RunDisplay(Mesh);
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
	PackageKey="BR55"
	FirstPersonMeshName="BR55.Mesh.Wep_1stP_BR55_Rig"
	FirstPersonAnimSetNames(0)="BR55.1stp_anims.Wep_1st_BR55_Anim"
	PickupMeshName="BR55.Mesh.BR55_Static"
	AttachmentArchetypeName="BR55.Archetypes.Wep_BR55_3P"
	MuzzleFlashTemplateName="WEP_AK12_ARCH.Wep_AK12_MuzzleFlash"

	// Ammo
	MagazineCapacity[0]=36
	SpareAmmoCapacity[0]=252
	InitialSpareMags[0]=2
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=150 //225
	minRecoilPitch=100 //150
	maxRecoilYaw=75 //150
	minRecoilYaw=-75 //-150
	RecoilRate=0.085 //0.085
	RecoilMaxYawLimit=300 //500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=550 //900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=75 //75
	RecoilISMinYawLimit=65460
	RecoilISMaxPitchLimit=75 //195
	RecoilISMinPitchLimit=65460
	RecoilViewRotationScale=0.25
	IronSightMeshFOVCompensationScale=2.0

	// Inventory / Grouping
	InventorySize=7
	GroupPriority=76
	WeaponSelectTexture=Texture2D'BR55.UI.BR55_UI_v1'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletBurst'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponBurstFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_BR55'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_BR55'
	FireInterval(DEFAULT_FIREMODE)=+0.09
	InstantHitDamage(DEFAULT_FIREMODE)=35.0 //33
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	Spread(DEFAULT_FIREMODE)=0.01
	FireOffset=(X=30,Y=4.5,Z=-4)
	BurstAmount=3

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_None

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_BR55'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'BR55.Audio.Play_BR55_Fire_3P', FirstPersonCue=AkEvent'BR55.Audio.Play_BR55_Fire_1P')
	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'BR55.Audio.Play_BR55_Fire_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=true

	AssociatedPerkClasses(0)=class'KFPerk_Sharpshooter'
	AssociatedPerkClasses(1)=class'KFPerk_Commando'

	//Custom idle animations
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v2)

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.15f), (Stat=EWUS_Damage1, Scale=1.15f), (Stat=EWUS_Weight, Add=1)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=1.3f), (Stat=EWUS_Damage1, Scale=1.3f), (Stat=EWUS_Weight, Add=2)))

	AmmoYellow = 0.67
	AmmoRed = 0.34

	//Textures for the scope background. Needs to be changed to an enum.
	UIBackgrounds[0] = Texture2D'Shared.UI.Basic_Reticle_Background_4_3_v2'
	UIBackgrounds[1] = Texture2D'Shared.UI.Basic_Reticle_Background_5_4_v2'
	UIBackgrounds[2] = Texture2D'Shared.UI.Basic_Reticle_Background_3_2_v2'
	UIBackgrounds[3] = Texture2D'Shared.UI.Basic_Reticle_Background_v2'
	UIBackgrounds[4] = Texture2D'Shared.UI.Basic_Reticle_Background_16_10_v2'
	UIBackgrounds[5] = Texture2D'Shared.UI.Basic_Reticle_Background_21_9_v2'
	UIBackgrounds[6] = Texture2D'Shared.UI.Basic_Reticle_Background_32_9_v2'

	//Reticles
	Reticle_Neutral = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1113, V=0, UL=160, VL=160)
	Reticle_Friendly = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1274, V=0, UL=160, VL=160)
	Reticle_Enemy = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1436, V=0, UL=160, VL=160)
	Reticle_Headshot = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=1598, V=0, UL=160, VL=160)

	RangeCanvasIcon = (Texture=Texture2D'Shared.UI.BR_Rangefinder', U=0, V=0, UL=2864, VL=2864)
	ZoomCanvasIcon = (Texture=Texture2D'Shared.UI.UI_Texture_Atlas', U=319, V=129, UL=155, VL=130)
}

