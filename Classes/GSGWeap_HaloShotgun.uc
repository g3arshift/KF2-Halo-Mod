//=============================================================================
// GSWeap_HaloShotgun
//=============================================================================
// A custom weapon class that is functionally identical to the shotgun base
// except that is has special handling for the "Twin Load" elite reload.
//=============================================================================
// Gear Shift Gaming
// 5/4/2020
//=============================================================================

class GSGWeap_HaloShotgun extends KFWeap_ShotgunBase;

`define USE_RELOAD_SYNC		1

var float LastShot_SpeedBoost_Rate;

/** Returns animation to play based on reload type and status */
simulated function name GetReloadAnimName( bool bTacticalReload )
{
	if ( !bReloadFromMagazine )
	{
		switch ( ReloadStatus )
		{
			case RS_OpeningBolt:
				if ( AmmoCount[0] == 0 )
				{
					// immediately skip reload status so that we start getting ammo
					ReloadStatus = GetNextReloadStatus();
					return bTacticalReload ? ReloadOpenInsertEliteAnim : ReloadOpenInsertAnim;
				}
				return (bTacticalReload) ? ReloadOpenEliteAnim : ReloadOpenAnim;
			case RS_ClosingBolt:
				return (bTacticalReload) ? ReloadCloseEliteAnim : ReloadCloseAnim;
		}
		if (AmmoCount[0] == MagazineCapacity[0] - 1)
		{
			return ReloadSingleAnim;
		}
		else
		{
			return (bTacticalReload) ? ReloadSingleEliteAnim : ReloadSingleAnim;
		}
	}

	// magazine relaod
	if ( AmmoCount[0] > 0 )
	{
		return (bTacticalReload) ? ReloadNonEmptyMagEliteAnim : ReloadNonEmptyMagAnim;
	}
	else
	{
		return (bTacticalReload) ? ReloadEmptyMagEliteAnim : ReloadEmptyMagAnim;
	}
}

simulated state Reloading
{
	simulated function byte GetWeaponStateId()
	{
		local KFPerk Perk;
		local bool bTacticalReload;

		Perk = GetPerk();
		bTacticalReload = (Perk != None && Perk.GetUsingTactialReload(self));

		if ( !bReloadFromMagazine )
		{
			if ( bTacticalReload )
			{ //If we only have one shell left for spare ammo, use the normal reload animation.
				if (GetMaxAmmoAmount(GetAmmoType(CurrentFireMode)) <= 1 || AmmoCount[0] == MagazineCapacity[0] - 1)
				{
					return AmmoCount[0] > 0 ? WEP_ReloadSingle : WEP_ReloadSingleEmpty;
				}
				else
				{
					return AmmoCount[0] > 0 ? WEP_ReloadSingle_Elite : WEP_ReloadSingleEmpty_Elite;
				}
			}
			return AmmoCount[0] > 0 ? WEP_ReloadSingle : WEP_ReloadSingleEmpty;
		}
		else
		{
			if ( bTacticalReload )
			{
				return AmmoCount[0] > 0 ? WEP_Reload_Elite : WEP_ReloadEmpty_Elite;
			}
			return AmmoCount[0] > 0 ? WEP_Reload : WEP_ReloadEmpty;
		}
	}
}

/** Performs actual ammo reloading */
simulated function PerformReload(optional byte FireModeNum)
{
	local int ReloadAmount;
	local int AmmoType;

	local KFPerk Perk;
	local bool bTacticalReload;

	Perk = GetPerk();
	bTacticalReload = (Perk != None && Perk.GetUsingTactialReload(self));

	AmmoType = GetAmmoType(FireModeNum);

	if ( bInfiniteSpareAmmo )
	{
		AmmoCount[AmmoType] = MagazineCapacity[AmmoType];
		ReloadAmountLeft = 0;
		return;
	}

	// Server only unless bAllowClientAmmoTracking
`if(`USE_RELOAD_SYNC)
	if ( (Role == ROLE_Authority && !bAllowClientAmmoTracking) || (Instigator.IsLocallyControlled() && bAllowClientAmmoTracking) )
`else
	if ( Role == ROLE_Authority || bAllowClientAmmoTracking )
`endif
	{
		if( GetMaxAmmoAmount(AmmoType) > 0 && SpareAmmoCount[AmmoType] > 0 )
		{
			if ( bReloadFromMagazine )
			{
				// clamp reload amount to spare ammo size
				ReloadAmount = Min(ReloadAmountLeft, SpareAmmoCount[AmmoType]);
			}
			else
			{
				if (bTacticalReload && GetMaxAmmoAmount(AmmoType) >= 2  && AmmoCount[0] != MagazineCapacity[0] - 1 && AmmoCount[0] != 0)
				{
					ReloadAmount = 2;
				}
				else
				{
					ReloadAmount = 1;
				}
			}

			// increment and clamp magazine ammo
			AmmoCount[AmmoType] = Min(AmmoCount[AmmoType] + ReloadAmount, MagazineCapacity[AmmoType]);

`if(`USE_RELOAD_SYNC)
			// Update SpareAmmo, even if this is the client (for immediate feedback).  This is safe as long as
			// the server doesn't consume SpareAmmo first which is enforced by ServerSyncReload
			SpareAmmoCount[AmmoType] -= ReloadAmount;
`else
			if ( Role == ROLE_Authority )
			{
				// Only update SpareAmmo on the server and make the client wait, so if the
				// server executes this code early the client won't consume ammo twice
				SpareAmmoCount[AmmoType] -= ReloadAmount;
			}
`endif
		}
	}

	// decrement ReloadAmountLeft
	if ( bReloadFromMagazine )
	{
		ReloadAmountLeft = 0;
	}
	else if ( ReloadAmountLeft > 0 )
	{
		if (ReloadAmount == 2)
		{
			ReloadAmountLeft--;
		}

		ReloadAmountLeft--;
	}

	ShotsHit = 0;
}

simulated function TimeWeaponReloading()
{
	local name AnimName;
	local float AnimLength, AnimRate;
	local float AmmoTimer, StatusTimer;

	local KFPerk Perk;
	local bool bTacticalReload;

	Perk = GetPerk();
	bTacticalReload = (Perk != None && Perk.GetUsingTactialReload(self));

	ReloadStatus = GetNextReloadStatus();

	// If we're finished exit reload
	if ( ReloadStatus == RS_Complete || MySkelMesh == None )
	{
		ReloadComplete();
		return;
	}

    // get desired animation and play-rate
    AnimName = GetReloadAnimName( UseTacticalReload() );

    if (AmmoCount[0] == MagazineCapacity[0] - 1 && bTacticalReload)
    {
    	AnimRate = GetReloadRateScale() * LastShot_SpeedBoost_Rate;
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

DefaultProperties
{
	DOF_bOverrideEnvironmentDOF=true
	DOF_SharpRadius=0
	DOF_FocalRadius=0
	DOF_MinBlurSize=0.0
	DOF_MaxNearBlurSize=0
	DOF_MaxFarBlurSize=0.0
	DOF_ExpFalloff=0
	DOF_MaxFocalDistance=0

	DOF_BlendInSpeed=0
	DOF_BlendOutSpeed=0

	DOF_FG_FocalRadius=0
	DOF_FG_SharpRadius=0
	DOF_FG_ExpFalloff=0

	LastShot_SpeedBoost_Rate = 0.65 //Make the reload animation take this percentage of time. 0.65 = 65% of the original time, or a 35% speed boost.
	IdleFidgetAnims=(Guncheck_v1, Guncheck_v3)
}