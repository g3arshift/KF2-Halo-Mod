//=============================================================================
// A class that uses provided textures and icons to draw a UI for a weapon using
// the canvas UI system.
//=============================================================================
// To use the class, call the InitializeWeaponUI function to prepare the variables
// for use. Pass it a Canvas object from a weapon as this is designed to be used
// from a weapon class, pass it an array of textures to be used for the background
// image for the reticles, pass it CanvasIcons for each state of aiming which are
// aiming at enemy, at friend, at enemy head, and at nothing. Finally, you can
// toggle whether the UI has "Flavor" objects or not, that is, objects that
// have no functional purpose in the UI but look nice and add feeling, such
// as a "Zoom Level" for the scope, or rangefinder elements.
//=============================================================================
// The reticle code was built with a large 128 x 128 texture in mind, the first 4 
// textures from the top left of the texture atlas. You may need to increase/decrease 
// texture size depending on how you have it built. The scope background images NEED
// to be setup in the following order in the array in regards to aspect ratio: 4:3 AR, 
// 5:4 AR, 3:2 AR, 16:9 AR, 16:10 AR, 21:9 AR, 32:9 AR
//=============================================================================
// In hindsight I probably should have given this class an optional variable to be passed
// to assist in solving the current issues that require reticle textures to be sized massively
// in certain cases. IE, the issue is that you will always have your reticle scale set to 0.5
// in 16:9, for example, so if you want a larger or smaller reticle the base texture size has
// to change.
//=============================================================================
// Gear Shift Gaming 9/8/2020
//=============================================================================

//TODO: Try maybe multiplying the pos by the aspect ratio based on a default of 1440p maybe? Could help remove some AR positioning requirements

class Halo_Weapon_UI extends Object;

var float Reticle_Xpos, Reticle_Ypos;
var float ReticleScale, BackgroundScale;
var Texture2D UIBackground; //This needs to be setup in this order: 4:3 AR, 5:4 AR, 3:2 AR, 16:9 AR, 16:10 AR, 21:9 AR, 32:9 AR
var array<Texture2D> StoredBackgrounds;
var float AspectRatio;

var CanvasIcon Reticle_Neutral;
var CanvasIcon Reticle_Friendly;
var CanvasIcon Reticle_Enemy;
var CanvasIcon Reticle_Headshot;
var bool isFlavored;
var array<FlavorIcon> FlavorIcons;

var KFPlayerController KFPC;
var KFWeapon KFWeap;

var bool isInitialized;
var int LastSizeX;

function InitializeWeaponUI(Canvas PlayerUI, KFPlayerController tempKFPC, array<Texture2D> ReticleBackground, CanvasIcon Reticle_N, CanvasIcon Reticle_F, CanvasIcon Reticle_E, optional CanvasIcon Reticle_H, optional bool HasFlavor = false, optional array<FlavorIcon> tempFlavorIcons)
{
	local FlavorIcon CurrentIcon;
	local Texture2D BackgroundStore;
	local int FlavorIndex, BackgroundStoreIndex;

	KFPC = tempKFPC;

	if(KFPC == none)
	{
		PlayerUI.SetPos( 300.0, 300.0 );
		PlayerUI.SetDrawColor( 255, 0, 0, 255 );
		PlayerUI.Font = Font'UI_Canvas_Fonts.Font_Main';
		PlayerUI.DrawText("Fatal Scope Error: No KFPC.", true, 1.0, 1.0 );
		return;
	}

	KFWeap = KFWeapon(KFPC.Pawn.Weapon);

	if(HasFlavor)
	{
		isFlavored = true;
		foreach tempFlavorIcons(CurrentIcon, FlavorIndex)
		{
			FlavorIcons[FlavorIndex] = CurrentIcon;
		}
	}

	foreach ReticleBackground(BackgroundStore, BackgroundStoreIndex)
	{
		StoredBackgrounds[BackgroundStoreIndex] = BackgroundStore;
	}

	AspectRatio = GetAspectRatio(PlayerUI);

	switch(AspectRatio)
	{
		case 1.33: //4:3 Aspect Ratio
			UIBackground = ReticleBackground[0];
			BackgroundScale = float(PlayerUI.SizeX) / 1920; //This is using a baseline BG scale of 1 @ 1920 x 1440
			ReticleScale = float(PlayerUI.SizeX) / 4388; //This is using a baseline reticle scale of 0.4375 @ 1920 x 1440
			break;
		case 1.25: //5:4 Aspect Ratio
			UIBackground = ReticleBackground[1];
			BackgroundScale = float(PlayerUI.SizeX) / 2560; //This is using a baseline BG scale of 1 @ 2560 x 2048
			ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.5 @ 2560 x 2048
			break;
		case 1.5: //3:2 Aspect Ratio
			UIBackground = ReticleBackground[2];
			BackgroundScale = float(PlayerUI.SizeX) / 2880; //This is using a baseline BG scale of 1 @ 2880 x 1920
			ReticleScale = float(PlayerUI.SizeX) / 5760; //This is using a baseline reticle scale of 0.55 @ 2880 x 1920
			break;
		case 1.77: //16:9 Aspect Ratio
			UIBackground = ReticleBackground[3];
			BackgroundScale = float(PlayerUI.SizeX) / 2560; //This is using a baseline BG scale of 1 @ 2560 x 1440
			ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.5 @ 2560 x 1440
			break;
		case 1.6: //16:10 Aspect Ratio
			UIBackground = ReticleBackground[4];
			BackgroundScale = float(PlayerUI.SizeX) / 3840; //This is using a baseline BG scale of 1 @ 3840 x 2400
			ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.75 @ 3840 x 2400
			break;
		case 3.55: //32:9 Aspect Ratio
			UIBackground = ReticleBackground[6];
			BackgroundScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline BG scale of 1 @ 5120 x 1440
			ReticleScale = float(PlayerUI.SizeX) / 10240; //This is using a baseline reticle scale of 0.5 @ 5120 x 1440
			break;
		default: //This is a really terrible way to do this, but 21:9 is a fucking mess and isn't really 21:9, so this is a hack.
			if(AspectRatio > 2.3 && AspectRatio <= 2.4) //21:9 Aspect Ratio
			{
				UIBackground = ReticleBackground[5];
				BackgroundScale = float(PlayerUI.SizeX) / 3440; //This is using a baseline BG scale of 1 @ 3440 x 1440
				ReticleScale = float(PlayerUI.SizeX) / 6880; //This is using a baseline reticle scale of 0.5 @ 3440 x 1440
			}
			else
			{
				UIBackground = ReticleBackground[3];
				BackgroundScale = float(PlayerUI.SizeX) / 2560; //This is using a baseline BG scale of 1 @ 2560 x 1440
				ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.5 @ 2560 x 1440
				`log("Aspect Ratio not found. Current aspect ratio is: " $ AspectRatio);
			}
			break;
	}

	Reticle_Neutral = Reticle_N;
	Reticle_Friendly = Reticle_F;
	Reticle_Enemy = Reticle_E;
	Reticle_Headshot = Reticle_H;

	Reticle_Xpos = (PlayerUI.SizeX / 2) - ((Reticle_Neutral.UL * ReticleScale) / 2);
	Reticle_YPos = (PlayerUI.SizeY / 2) - ((Reticle_Neutral.VL * ReticleScale) / 2);

	isInitialized = true;
}

function InitializeWeaponUI_NoHeadshot(Canvas PlayerUI, KFPlayerController tempKFPC, array<Texture2D> ReticleBackground, CanvasIcon Reticle_N, CanvasIcon Reticle_F, CanvasIcon Reticle_E, optional bool HasFlavor = false, optional array<FlavorIcon> tempFlavorIcons)
{
	local FlavorIcon CurrentIcon;
	local Texture2D BackgroundStore;
	local int FlavorIndex, BackgroundStoreIndex;

	KFPC = tempKFPC;

	if(KFPC == none)
	{
		PlayerUI.SetPos( 300.0, 300.0 );
		PlayerUI.SetDrawColor( 255, 0, 0, 255 );
		PlayerUI.Font = Font'UI_Canvas_Fonts.Font_Main';
		PlayerUI.DrawText("Fatal Scope Error: No KFPC.", true, 1.0, 1.0 );
		return;
	}

	KFWeap = KFWeapon(KFPC.Pawn.Weapon);

	if(HasFlavor)
	{
		isFlavored = true;
		foreach tempFlavorIcons(CurrentIcon, FlavorIndex)
		{
			FlavorIcons[FlavorIndex] = CurrentIcon;
		}
	}

	foreach ReticleBackground(BackgroundStore, BackgroundStoreIndex)
	{
		StoredBackgrounds[BackgroundStoreIndex] = BackgroundStore;
	}

	AspectRatio = GetAspectRatio(PlayerUI);

	switch(AspectRatio)
	{
		case 1.33: //4:3 Aspect Ratio
			UIBackground = ReticleBackground[0];
			BackgroundScale = float(PlayerUI.SizeX) / 1920; //This is using a baseline BG scale of 1 @ 1920 x 1440
			ReticleScale = float(PlayerUI.SizeX) / 4388; //This is using a baseline reticle scale of 0.4375 @ 1920 x 1440
			break;
		case 1.25: //5:4 Aspect Ratio
			UIBackground = ReticleBackground[1];
			BackgroundScale = float(PlayerUI.SizeX) / 2560; //This is using a baseline BG scale of 1 @ 2560 x 2048
			ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.5 @ 2560 x 2048
			break;
		case 1.5: //3:2 Aspect Ratio
			UIBackground = ReticleBackground[2];
			BackgroundScale = float(PlayerUI.SizeX) / 2880; //This is using a baseline BG scale of 1 @ 2880 x 1920
			ReticleScale = float(PlayerUI.SizeX) / 5760; //This is using a baseline reticle scale of 0.55 @ 2880 x 1920
			break;
		case 1.77: //16:9 Aspect Ratio
			UIBackground = ReticleBackground[3];
			BackgroundScale = float(PlayerUI.SizeX) / 2560; //This is using a baseline BG scale of 1 @ 2560 x 1440
			ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.5 @ 2560 x 1440
			break;
		case 1.6: //16:10 Aspect Ratio
			UIBackground = ReticleBackground[4];
			BackgroundScale = float(PlayerUI.SizeX) / 3840; //This is using a baseline BG scale of 1 @ 3840 x 2400
			ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.75 @ 3840 x 2400
			break;
		case 3.55: //32:9 Aspect Ratio
			UIBackground = ReticleBackground[6];
			BackgroundScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline BG scale of 1 @ 5120 x 1440
			ReticleScale = float(PlayerUI.SizeX) / 10240; //This is using a baseline reticle scale of 0.5 @ 5120 x 1440
			break;
		default: //This is a really terrible way to do this, but 21:9 is a fucking mess and isn't really 21:9, so this is a hack.
			if(AspectRatio > 2.3 && AspectRatio <= 2.4) //21:9 Aspect Ratio
			{
				UIBackground = ReticleBackground[5];
				BackgroundScale = float(PlayerUI.SizeX) / 3440; //This is using a baseline BG scale of 1 @ 3440 x 1440
				ReticleScale = float(PlayerUI.SizeX) / 6880; //This is using a baseline reticle scale of 0.5 @ 3440 x 1440
			}
			else
			{
				UIBackground = ReticleBackground[3];
				BackgroundScale = float(PlayerUI.SizeX) / 2560; //This is using a baseline BG scale of 1 @ 2560 x 1440
				ReticleScale = float(PlayerUI.SizeX) / 5120; //This is using a baseline reticle scale of 0.5 @ 2560 x 1440
				`log("Aspect Ratio not found. Current aspect ratio is: " $ AspectRatio);
			}
			break;
	}

	Reticle_Neutral = Reticle_N;
	Reticle_Friendly = Reticle_F;
	Reticle_Enemy = Reticle_E;

	Reticle_Xpos = (PlayerUI.SizeX / 2) - ((Reticle_Neutral.UL * ReticleScale) / 2);
	Reticle_YPos = (PlayerUI.SizeY / 2) - ((Reticle_Neutral.VL * ReticleScale) / 2);

	isInitialized = true;
}

function float GetAspectRatio(Canvas PlayerUI)
{
	return float(left(string(float(PlayerUI.SizeX) / float(PlayerUI.SizeY)), 4));
}

function RunWeaponUI(out Canvas PlayerUI)
{
	PlayerUI.SetDrawColor(255, 255, 255, 255);

	if(LastSizeX == -1)
	{
		LastSizeX = PlayerUI.SizeX;
	}
	else if(LastSizeX != PlayerUI.SizeX)
	{
		if(isFlavored)
		{
			InitializeWeaponUI(PlayerUI, KFPC, StoredBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, Reticle_Headshot, true, FlavorIcons);
		}
		else
		{
			InitializeWeaponUI(PlayerUI, KFPC, StoredBackgrounds, Reticle_Neutral, Reticle_Friendly, Reticle_Enemy, Reticle_Headshot);
		}
	}

	UpdateWeaponUI(PlayerUI);
}

function UpdateWeaponUI(out Canvas PlayerUI)
{
	PlayerUI.DrawTexture(UIBackground, BackgroundScale);
	UpdateReticle(PlayerUI);

	if(isFlavored)
	{
		UpdateWeaponUI_Flavor(PlayerUI);
	}
}

// We have a new object type just for the icons here because it is impossible to know, programmatically, where to place and how to scale
// the icons without a reference point, a point which is contained within the FlavorIcon variable type.
function UpdateWeaponUI_Flavor(out Canvas PlayerUI)
{
	local FlavorIcon CurrentIcon;
	local int i;

	PlayerUI.SetDrawColor(255, 255, 255, 255);
	//For each icon we have supplied draw it with the correct Aspect Ratio, X/Y position, and scaling. 
	//We do it this way because when there are multiple icons drawn they will all have different scaling.
	foreach FlavorIcons(CurrentIcon, i)
	{
		if(CurrentIcon.IconColor.A != 1)
		{
			PlayerUI.SetDrawColor(CurrentIcon.IconColor.R, CurrentIcon.IconColor.G, CurrentIcon.IconColor.B, CurrentIcon.IconColor.A);
		}

		switch(AspectRatio)
		{
			case 1.33: //4:3 Aspect Ratio
				PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_4_3.X * BackgroundScale, CurrentIcon.AR_4_3.Y * BackgroundScale, CurrentIcon.AR_4_3_Scaling * BackgroundScale);
				break;
			case 1.25: //5:4 Aspect Ratio
				PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_5_4.X* BackgroundScale, CurrentIcon.AR_5_4.Y * BackgroundScale, CurrentIcon.AR_5_4_Scaling * BackgroundScale);
				break;
			case 1.5: //3:2 Aspect Ratio
				PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_3_2.X * BackgroundScale, CurrentIcon.AR_3_2.Y * BackgroundScale, CurrentIcon.AR_3_2_Scaling * BackgroundScale);
				break;
			case 1.77: //16:9 Aspect Ratio
				PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_16_9.X * BackgroundScale, CurrentIcon.AR_16_9.Y * BackgroundScale, CurrentIcon.AR_16_9_Scaling * BackgroundScale);
				break;
			case 1.6: //16:10 Aspect Ratio
				PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_16_10.X * BackgroundScale, CurrentIcon.AR_16_10.Y * BackgroundScale, CurrentIcon.AR_16_10_Scaling * BackgroundScale);
				break;
			case 3.55: //32:9 Aspect Ratio
				PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_32_9.X * BackgroundScale, CurrentIcon.AR_32_9.Y * BackgroundScale, CurrentIcon.AR_32_9_Scaling * BackgroundScale);
				break;
			default: //This is a really terrible way to do this, but 21:9 is a fucking mess and isn't really 21:9, so this is a hack.
				if(AspectRatio > 2.3 && AspectRatio <= 2.4) //21:9 Aspect Ratio
				{
					PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_21_9.X * BackgroundScale, CurrentIcon.AR_21_9.Y * BackgroundScale, CurrentIcon.AR_21_9_Scaling * BackgroundScale);
				}
				else
				{
					PlayerUI.DrawIcon(CurrentIcon.Icon, CurrentIcon.AR_16_9.X, CurrentIcon.AR_16_9.Y, CurrentIcon.AR_16_9_Scaling);
				}
			break;
		}
	}
	PlayerUI.SetDrawColor(255, 255, 255, 255);
}

function UpdateReticle(Canvas PlayerUI)
{
	local vector TraceStart, TraceEnd;
	local vector InstantTraceHitLocation, InstantTraceHitNormal;
	local vector TraceAimDir;
	local Actor	HitActor;
	local TraceHitInfo HitInfo;

	TraceStart = KFPC.Pawn.Weapon.Instigator.GetWeaponStartTraceLocation();
	TraceAimDir = Vector(KFPC.Pawn.Weapon.Instigator.GetAdjustedAimFor(KFPC.Pawn.Weapon, TraceStart));
	TraceEnd = TraceStart + TraceAimDir * 20000; //200 meters
	HitActor = KFPC.Pawn.Weapon.GetTraceOwner().Trace(InstantTraceHitLocation, InstantTraceHitNormal, TraceEnd, TraceStart, TRUE, vect(0,0,0), HitInfo, KFPC.Pawn.Weapon.TRACEFLAG_Bullet);

	if(KFPawn_Monster(HitActor) !=none && KFPawn_Monster(HitActor).IsAliveAndWell())
	{
		if(HitInfo.BoneName == 'head' && Reticle_Headshot.Texture != none)
		{
			PlayerUI.DrawIcon(Reticle_Headshot, Reticle_Xpos, Reticle_Ypos, ReticleScale);
		}
		else
		{
			PlayerUI.DrawIcon(Reticle_Enemy, Reticle_Xpos, Reticle_Ypos, ReticleScale);
		}
	}
	else if(KFPawn_Human(HitActor) != none && KFPawn_Human(HitActor).IsAliveAndWell())
	{
		PlayerUI.DrawIcon(Reticle_Friendly, Reticle_Xpos, Reticle_Ypos, ReticleScale);
	}
	else
	{
		PlayerUI.DrawIcon(Reticle_Neutral, Reticle_Xpos, Reticle_Ypos, ReticleScale);
	}
}

//TODO: Clean this absolute shitshow of code up. It suffers horrendously from code repetition and is hellishly difficult to make adjustments in as a result, but
// it's four in the morning and I'm just not going to deal with this right now. It's uglier than sin but it works. Sidenote, fuck 21:9. You're not a real aspect ratio.
function DrawAmmoUI(out Canvas PlayerUI, int AmmoMax, array<int> BulletDistanceCollection, FlavorIcon RegularAmmo, FlavorIcon FlashingAmmo, TextureMovie BulletMovie, String AmmoText)
{
	local int NumFlashing_ToDraw;
	local int NumRegular_ToDraw;
	local int BulletDistance;
	local int NextBulletDistance;
	local bool bDrawAsText;
	local int i;
	local int AmmoTextScaling_X, AmmoTextScaling_Y;

	if(KFWeap.AmmoCount[KFWeap.CurrentFireMode] > AmmoMax)
	{
		bDrawAsText = true;
	}
	else
	{
		bDrawAsText = false;
		NumFlashing_ToDraw = AmmoMax - KFWeap.AmmoCount[KFWeap.CurrentFireMode];
		NumRegular_ToDraw = AmmoMax - NumFlashing_ToDraw;
		NextBulletDistance = 0;
	}

	switch(AspectRatio)
	{
		case 1.33: //4:3 Aspect Ratio
			BulletDistance = BulletDistanceCollection[0];
			AmmoTextScaling_X = 1.0;
			AmmoTextScaling_Y = 1.0;
			break;
		case 1.25: //5:4 Aspect Ratio
			BulletDistance = BulletDistanceCollection[1];
			AmmoTextScaling_X = 2.5;
			AmmoTextScaling_Y = 2.5;
			break;
		case 1.5: //3:2 Aspect Ratio
			BulletDistance = BulletDistanceCollection[2];
			AmmoTextScaling_X = 1.0;
			AmmoTextScaling_Y = 1.0;
			break;
		case 1.77: //16:9 Aspect Ratio
			BulletDistance = BulletDistanceCollection[3];
			AmmoTextScaling_X = 1.1;
			AmmoTextScaling_Y = 1.1;
			break;
		case 1.6: //16:10 Aspect Ratio
			BulletDistance = BulletDistanceCollection[4];
			AmmoTextScaling_X = 2.5;
			AmmoTextScaling_Y = 2.5;
			break;
		case 3.55: //32:9 Aspect Ratio
			BulletDistance = BulletDistanceCollection[6];
			AmmoTextScaling_X = 1.0;
			AmmoTextScaling_Y = 1.0;
			break;
		default: //This is a really terrible way to do this, but 21:9 is a fucking mess and isn't really 21:9, so this is a hack.
			if(AspectRatio > 2.3 && AspectRatio <= 2.4) //21:9 Aspect Ratio
			{
				BulletDistance = BulletDistanceCollection[5];
				AmmoTextScaling_X = 1.0;
				AmmoTextScaling_Y = 1.0;
			}
			else
			{
				BulletDistance = BulletDistanceCollection[3];
				AmmoTextScaling_X = 1.0;
				AmmoTextScaling_Y = 1.0;
			}
		break;
	}

	switch(AspectRatio)
	{
		case 1.33: //4:3 Aspect Ratio
			if(bDrawAsText)
			{
				PlayerUI.SetDrawColor(9, 145, 243, 255);
				PlayerUI.SetPos(RegularAmmo.AR_4_3.X * BackgroundScale, RegularAmmo.AR_4_3.Y * BackgroundScale);
				PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
				PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
			}
			else
			{
				PlayerUI.SetDrawColor(237, 53, 56, 255);
				BulletMovie.Play();
				for(i = 0; i < NumFlashing_ToDraw; i++)
				{
					PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_4_3.X * BackgroundScale, (FlashingAmmo.AR_4_3.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_4_3_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}

				PlayerUI.SetDrawColor(9, 145, 243, 255);
				for(i = 0; i< NumRegular_ToDraw; i++)
				{
					PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_4_3.X * BackgroundScale, (RegularAmmo.AR_4_3.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_4_3_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}
			}
			break;
		case 1.25: //5:4 Aspect Ratio
			if(bDrawAsText)
			{
				PlayerUI.SetDrawColor(9, 145, 243, 255);
				PlayerUI.SetPos(RegularAmmo.AR_5_4.X * BackgroundScale, RegularAmmo.AR_5_4.Y * BackgroundScale);
				PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
				PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
			}
			else
			{
				PlayerUI.SetDrawColor(237, 53, 56, 255);
				BulletMovie.Play();
				for(i = 0; i < NumFlashing_ToDraw; i++)
				{
					PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_5_4.X * BackgroundScale, (FlashingAmmo.AR_5_4.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_5_4_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}

				PlayerUI.SetDrawColor(9, 145, 243, 255);
				for(i = 0; i< NumRegular_ToDraw; i++)
				{
					PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_5_4.X * BackgroundScale, (RegularAmmo.AR_5_4.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_5_4_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}
			}
			break;
		case 1.5: //3:2 Aspect Ratio
			if(bDrawAsText)
			{
				PlayerUI.SetDrawColor(9, 145, 243, 255);
				PlayerUI.SetPos(RegularAmmo.AR_3_2.X * BackgroundScale, RegularAmmo.AR_3_2.Y * BackgroundScale);
				PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
				PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
			}
			else
			{
				PlayerUI.SetDrawColor(237, 53, 56, 255);
				BulletMovie.Play();
				for(i = 0; i < NumFlashing_ToDraw; i++)
				{
					PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_3_2.X * BackgroundScale, (FlashingAmmo.AR_3_2.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_3_2_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}

				PlayerUI.SetDrawColor(9, 145, 243, 255);
				for(i = 0; i< NumRegular_ToDraw; i++)
				{
					PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_3_2.X * BackgroundScale, (RegularAmmo.AR_3_2.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_3_2_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}
			}
			break;
		case 1.77: //16:9 Aspect Ratio
			if(bDrawAsText)
			{
				PlayerUI.SetDrawColor(9, 145, 243, 255);
				PlayerUI.SetPos(RegularAmmo.AR_16_9.X * BackgroundScale, RegularAmmo.AR_16_9.Y * BackgroundScale);
				PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
				PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
			}
			else
			{
				PlayerUI.SetDrawColor(237, 53, 56, 255);
				BulletMovie.Play();
				for(i = 0; i < NumFlashing_ToDraw; i++)
				{
					PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_16_9.X * BackgroundScale, (FlashingAmmo.AR_16_9.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_16_9_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}

				PlayerUI.SetDrawColor(9, 145, 243, 255);
				for(i = 0; i< NumRegular_ToDraw; i++)
				{
					PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_16_9.X * BackgroundScale, (RegularAmmo.AR_16_9.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_16_9_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}
			}
			break;
		case 1.6: //16:10 Aspect Ratio
			if(bDrawAsText)
			{
				PlayerUI.SetDrawColor(9, 145, 243, 255);
				PlayerUI.SetPos(RegularAmmo.AR_16_10.X * BackgroundScale, RegularAmmo.AR_16_10.Y * BackgroundScale);
				PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
				PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
			}
			else
			{
				PlayerUI.SetDrawColor(237, 53, 56, 255);
				BulletMovie.Play();
				for(i = 0; i < NumFlashing_ToDraw; i++)
				{
					PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_16_10.X * BackgroundScale, (FlashingAmmo.AR_16_10.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_16_10_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}

				PlayerUI.SetDrawColor(9, 145, 243, 255);
				for(i = 0; i< NumRegular_ToDraw; i++)
				{
					PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_16_10.X * BackgroundScale, (RegularAmmo.AR_16_10.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_16_10_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}
			}
			break;
		case 3.55: //32:9 Aspect Ratio
			if(bDrawAsText)
			{
				PlayerUI.SetDrawColor(9, 145, 243, 255);
				PlayerUI.SetPos(RegularAmmo.AR_32_9.X * BackgroundScale, RegularAmmo.AR_32_9.Y * BackgroundScale);
				PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
				PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
			}
			else
			{
				PlayerUI.SetDrawColor(237, 53, 56, 255);
				BulletMovie.Play();
				for(i = 0; i < NumFlashing_ToDraw; i++)
				{
					PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_32_9.X * BackgroundScale, (FlashingAmmo.AR_32_9.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_32_9_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}

				PlayerUI.SetDrawColor(9, 145, 243, 255);
				for(i = 0; i< NumRegular_ToDraw; i++)
				{
					PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_32_9.X * BackgroundScale, (RegularAmmo.AR_32_9.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_32_9_Scaling * BackgroundScale);
					NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
				}
			}
			break;
		default: //This is a really terrible way to do this, but 21:9 is a fucking mess and isn't really 21:9, so this is a hack.
			if(AspectRatio > 2.3 && AspectRatio <= 2.4) //21:9 Aspect Ratio
			{
				if(bDrawAsText)
				{
					PlayerUI.SetDrawColor(9, 145, 243, 255);
					PlayerUI.SetPos(RegularAmmo.AR_21_9.X * BackgroundScale, RegularAmmo.AR_21_9.Y * BackgroundScale);
					PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
					PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
				}
				else
				{
					PlayerUI.SetDrawColor(237, 53, 56, 255);
					BulletMovie.Play();
					for(i = 0; i < NumFlashing_ToDraw; i++)
					{
						PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_21_9.X * BackgroundScale, (FlashingAmmo.AR_21_9.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_21_9_Scaling * BackgroundScale);
						NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
					}

					PlayerUI.SetDrawColor(9, 145, 243, 255);
					for(i = 0; i< NumRegular_ToDraw; i++)
					{
						PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_21_9.X * BackgroundScale, (RegularAmmo.AR_21_9.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_21_9_Scaling * BackgroundScale);
						NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
					}
				}
			}
			else
			{
				if(bDrawAsText)
				{
					PlayerUI.SetDrawColor(9, 145, 243, 255);
					PlayerUI.SetPos(RegularAmmo.AR_16_9.X * BackgroundScale, RegularAmmo.AR_16_9.Y * BackgroundScale);
					PlayerUI.Font = Font'Shared.UI.Halo_UI_Font';
					PlayerUI.DrawText(KFWeap.AmmoCount[KFWeap.CurrentFireMode]@AmmoText, false, AmmoTextScaling_X * BackgroundScale, AmmoTextScaling_Y * BackgroundScale);
				}
				else
				{
					PlayerUI.SetDrawColor(237, 53, 56, 255);
					BulletMovie.Play();
					for(i = 0; i < NumFlashing_ToDraw; i++)
					{
						PlayerUI.DrawIcon(FlashingAmmo.Icon, FlashingAmmo.AR_16_9.X * BackgroundScale, (FlashingAmmo.AR_16_9.Y * BackgroundScale) + NextBulletDistance, FlashingAmmo.AR_16_9_Scaling * BackgroundScale);
						NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
					}

					PlayerUI.SetDrawColor(9, 145, 243, 255);
					for(i = 0; i< NumRegular_ToDraw; i++)
					{
						PlayerUI.DrawIcon(RegularAmmo.Icon, RegularAmmo.AR_16_9.X * BackgroundScale, (RegularAmmo.AR_16_9.Y * BackgroundScale) + NextBulletDistance, RegularAmmo.AR_16_9_Scaling * BackgroundScale);
						NextBulletDistance = NextBulletDistance + (BulletDistance * BackgroundScale);
					}
				}
			}
		break;
	}
	PlayerUI.SetDrawColor(255, 255, 255, 255);
}

defaultproperties
{
	isFlavored = false
	isInitialized = false
	LastSizeX = -1
}