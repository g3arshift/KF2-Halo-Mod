//Gear Shift Gaming Mods

class WeaponsActive extends KFMutator;

function InitMutator(string Options, out string ErrorMessage)
{
	super.InitMutator(Options, ErrorMessage);
	`log("Halo Weapons Loaded!");
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(1.0, true, 'UpdateTI');
}

simulated function UpdateTI()
{
	KFGameReplicationInfo(WorldInfo.GRI).TraderItems=KFGFxObject_TraderItems'Shared.Archetypes.HaloTraderItems';	
}

/* Deprecated as of 10/7/2019

//Below Code by InsertNameHere
//Retrieved from https://forums.tripwireinteractive.com/forum/killing-floor-2/technical-support-ae/the-bug-report-ae/2332347-v1080-beta-custom-weapons-no-longer-give-dosh-on-zed-kills
function NetDamage(int OriginalDamage, out int Damage, Pawn Injured, Controller InstigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType, Actor DamageCauser)
{
    local KFPawn_Monster KFPM;
    local DamageInfo Info;
    local Pawn BlockerPawn;
    local bool bChangedEnemies;
    local int HistoryIndex;
    local float DamageThreshold;
    local KFAIController KFAIC;

    // Call super first to ensure that
    // accurate damage is passed
    super.NetDamage(OriginalDamage, Damage, Injured, InstigatedBy, HitLocation, Momentum, DamageType, DamageCauser);
   
    KFPM = KFPawn_Monster(Injured);
    KFAIC = KFAIController(Injured.Controller);

    // Player-on-zed damage with custom weapon
    if (KFPM != None && KFAIC != None && KFPlayerController(InstigatedBy) != None && IsFromModWeapon(DamageType))
    {
        // Copy/paste modified from KFPawn.UpdateDamageHistory()
        if( !KFPM.GetDamageHistory( InstigatedBy, Info, HistoryIndex ) )
        {
            KFPM.DamageHistory.Insert(0, 1);
        }

        DamageThreshold = float(KFPM.HealthMax) * KFAIC.AggroPlayerHealthPercentage;

        KFPM.UpdateDamageHistoryValues( InstigatedBy, Damage, DamageCauser, KFAIC.AggroPlayerResetTime, Info, class<KFDamageType>(DamageType) );

        if( `TimeSince(KFPM.DamageHistory[KFAIC.CurrentEnemysHistoryIndex].LastTimeDamaged) > 10 )
        {
            KFPM.DamageHistory[KFAIC.CurrentEnemysHistoryIndex].Damage = 0;
        }

        if( KFAIC.IsAggroEnemySwitchAllowed()
            && InstigatedBy.Pawn != KFAIC.Enemy
            && Info.Damage >= DamageThreshold
            && Info.Damage > KFPM.DamageHistory[KFAIC.CurrentEnemysHistoryIndex].Damage )
        {
            BlockerPawn = KFAIC.GetPawnBlockingPathTo( InstigatedBy.Pawn, true );
            if( BlockerPawn == none )
            {
                bChangedEnemies = KFAIC.SetEnemy(InstigatedBy.Pawn);
            }
            else
            {
                bChangedEnemies = KFAIC.SetEnemy( BlockerPawn );
            }
        }

        KFPM.DamageHistory[HistoryIndex] = Info;
   
        if( bChangedEnemies )
        {
            KFAIC.CurrentEnemysHistoryIndex = HistoryIndex;
        }
    }
}

function bool IsFromModWeapon(class<DamageType> DmgType)
{
    return (DmgType != None && DmgType.GetPackageName() == 'HaloMod_Weapons');
}

*/