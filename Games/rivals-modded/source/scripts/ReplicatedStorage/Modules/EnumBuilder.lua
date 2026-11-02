-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {
    "ReplicationAdded",
    "ReplicationChanged",
    "ReplicationRemoved",
    "ReplicationRequest",
    "Ammo",
    "BulkDataValueChanged",
    "DataValueChanged",
    "ItemChanged",
    "EntityChanged",
    "ItemRemoved",
    "ItemAdded",
    "EntityAdded",
    "SafeUpdateLocalEquippedItemID",
    "UserID",
    "ShootEffect",
    "ProjectileEffect",
    "ServerInputWorkDone",
    "Died",
    "BurnEffect",
    "ExplosionEffect",
    "MolotovExplode",
    "HealEffect",
    "HurtEffect",
    "Skin",
    "DeflectHit",
    "PlayAnimation",
    "StartShooting",
    "StartReloading",
    "StartAiming",
    "StartInspecting",
    "EliminationFeed",
    "StartSprinting",
    "FinishShooting",
    "FinishReloading",
    "FinishAiming",
    "FinishInspecting",
    "FinishSprinting",
    "HitEffect",
    "SwitchItemsCount",
    "SwitchItemsMax",
    "EliminationEffect",
    "ViewModelChanged",
    "DuelerAdded",
    "DuelerChanged",
    "DuelerRemoved",
    "CameraMimicRotation",
    "RoundStart",
    "RoundFinish",
    "BatchUpdateWeaponXP",
    "CameraLean",
    "IsCrouching",
    "IsSprinting",
    "IsSliding",
    "ExtinguishEffect",
    "SplatEffect",
    "IsAirborne",
    "PlayMechanicsSound",
    "Slide",
    "DoubleJump",
    "BlindedEffect",
    "BackstabEffect",
    "EliminatedEffect",
    "RoundStarting",
    "MouseKeyboard",
    "Gamepad",
    "Touch",
    "VR",
    "HardenEffect",
    "NumReloadsSoFar",
    "ThrowEffect",
    "MineExplosion",
    "MapAdded",
    "KnockbackEffect",
    "CanTrackStatistics",
    "PlaySourceName",
    "ClientFighterCharacter",
    "ClientBaseGame",
    "ClientDuel",
    "ClientDueler",
    "ClientDestructable",
    "LogID",
    "ClientEnemy",
    "ClientEntity",
    "ClientFighter",
    "ClientPlayerData",
    "CameraRotation",
    "DecodedNetworkID",
    "IsSpectating",
    "LocalEquippedItemID",
    "IsInDuel",
    "FOVOffset",
    "ItemIndex",
    "Controls",
    "NetworkID",
    "EnvironmentID",
    "TeamID",
    "TeamkillEnabled",
    "ItemsLocked",
    "CanPickWeapons",
    "LastPickedWeapons",
    "EquippedItemID",
    "OctoCount",
    "InfiniteAmmo",
    "Name",
    "Scale",
    "ShowWhileAiming",
    "ClearQuickAttackState",
    "Level",
    "QuickAttackQueued",
    "SkipEquipAnimation",
    "Charm",
    "AmmoReserve",
    "IdleAnimation",
    "ThawFreezeEffect",
    "RunAnimation",
    "Damage",
    "DamageTaken",
    "Status",
    "ClientCustomEntity",
    "StatisticsBatchUpdate",
    "ShowWhileInspecting",
    "Timer",
    "Wave",
    "EnemyCount",
    "EnemiesByID",
    "MapName",
    "MapFolder",
    "VoteOptions",
    "Scores",
    "NumTeams",
    "LastVote",
    "AssistEffect",
    "PingEffect",
    "Eliminations",
    "Deaths",
    "Assists",
    "MatchPoint",
    "SuddenDeath",
    "ClientHumanoidEntity",
    "NumSpectators",
    "CanSwitchItems",
    "RoundNum",
    "IsInShootingRange",
    "RegisterDPS",
    "IsDisabled",
    "IsStatic",
    "BarsDisabled",
    "BarsSpacing",
    "BarsLength",
    "BarsThickness",
    "BarsTransparency",
    "DotDisabled",
    "DotThickness",
    "DotTransparency",
    "OutlineDisabled",
    "OutlineThickness",
    "OutlineTransparency",
    "DotColor",
    "BarsColor",
    "OutlineColor",
    "Rotation",
    "Override",
    "CompressedCrosshairAppearance",
    "OutlineType",
    "CircleDisabled",
    "CircleColor",
    "CircleSize",
    "CircleThickness",
    "CircleTransparency",
    "CircleShape",
    "WarpTo",
    "OnyxLavaSplash",
    "MapChanged",
    "CreateSound",
    "SendChat",
    "Shutdown",
    "BarsTopDisabled",
    "BarsBottomDisabled",
    "BarsRightDisabled",
    "BarsLeftDisabled",
    "WeaponDataChanged",
    "ConnectionLevel",
    "NukeEffect",
    "SpectatingDuelObjectID",
    "ClientReplicatedClassType",
    "Data",
    "ViewModel",
    "Player",
    "Model",
    "RootPart",
    "Humanoid",
    "Duelers",
    "Map",
    "ObjectID",
    "Items",
    "Entity",
    "Wrap",
    "EntityRemoved",
    "FinalResults",
    "LootboxEffect",
    "DEBUG_OCTO_MODE",
    "ChallengeRequest",
    "ClientDPSDummy",
    "DotShape",
    "BarsShape",
    "DamageNumberEffect",
    "FreezeEffect",
    "ScoresBehavior",
    "DuelerID",
    "IsFrozen",
    "IsMatchmaking",
    "PartyRequest",
    "MatchmadeCountdown",
    "FinisherEffect",
    "IsInvincible",
    "ArcadeMode",
    "CancelUse",
    "RematchAvailable",
    "RematchCount",
    "RematchGoal",
    "ConsecutiveRematches",
    "QueueName",
    "SetBoost",
    "NumSatchels",
    "SatchelAttached",
    "AbsorbedHit",
    "TransformProjectile",
    "MiniExplosionEffect",
    "ExtinguishEffect",
    "Countdown",
    "Mode",
    "BlindEffect",
    "WeaponPool",
    "WeaponPoolFilterType",
    "CanUseLockedWeapons",
    "IsCurrentArcadeDuel",
    "RematchSuccess",
    "IsGrabbingSnowball",
    "ThrowSnowball",
    "StopHolding",
    "StopUsing",
    "WasSelfQueued",
    "PauseTimer",
    "DuelResultsRunnerUpsEnabled",
    "MaxMapBansPerTeam",
    "VoteBansRemaining",
    "NoRandomMap",
    "MaxMapOptions",
    "MaxWeaponBansPerTeam",
    "VoteOptionsType",
    "AutoShootRestriction",
    "AimAssistRestriction",
    "ThirdPersonOverride",
    "ChosenMapEffect",
    "SetCooldown",
    "SummaryDetails",
    "ExternalDuelTimer",
    "ExternalDuelWinningScore",
    "ExternalKeepDuelGoing",
    "ExternalDrawsAreLosses",
    "PlayPreloadedAnimation",
    "TracerEffect",
    "FlashbangEffect",
    "Interrupted",
    "CheaterMode",
    "IsAprilFools",
    "AprilFoolsCharkAttack",
    "BladeCriticalHit",
    "WeaponClassRestrictionDisabled",
    "KeepDuelAliveTimeout",
    "DontDisableRematchingOnLeave",
    "VoteSelectionMode",
    "ScoreNeededToWin",
    "ClientQueuePad",
    "PlayersWaiting",
    "IsLocked",
    "IsStarting",
    "InfinitePlayersPerTeam",
    "PlayersPerTeam",
    "NumTeams",
    "CanSelfQueue",
    "RefillAmmoEffect",
    "CollectEffect",
    "RespawnDelay",
    "JustSwitchedTeam",
    "SetupDrop",
    "OverrideQuickAttacks",
    "RespawnNowAnimation",
    "UnlimitedTime",
    "ExternalCanPlayAllMaps",
    "BaseHealth",
    "Gravity",
    "DisableSprinting",
    "DisableSliding",
    "DashOnAim",
    "StaggeredSpawns",
    "StaggeredSpawnsOrder",
    "ExternalEndDuelNow",
    "ChickenGamesRedLight",
    "ChickenGamesGreenLight",
    "ChickenGamesElimination",
    "ChickenGamesStop",
    "EventEndTime",
    "SpecialChallengesEnabled",
    "RollResult",
    "IsHeadHoncho",
    "InvincibilityDurationOnSpawn",
    "ExternalDisableTimerAliveCheck",
    "IsTranslucent",
    "ClaimCheckpoint",
    "ObbyStartPosition",
    "ObbyFinishPosition",
    "TimerStopwatchStarted",
    "TimerStopwatchFinished",
    "FreeToUseStandardWeapons",
    "FreeToUsePrimeWeapons",
    "EmotePlayed",
    "EmoteStopped",
    "ExternalRematchProperties",
    "IsGunGame",
    "DisableAnticheatPositionVerificationLoop",
    "BlipEffect",
    "Warp",
    "MatchPointVisualDisabled",
    "InfiniteAmmoReserve",
    "ClientHelmetZombie",
    "DinkEffect",
    "DropFlagEffect",
    "ClientFlagZombie",
    "ZombieExplosionEffect",
    "ClientExplosiveZombie",
    "HideMostDuelInterfaceElements",
    "DisableDoubleJumping",
    "SprintingSpeedBoost",
    "SlidingSpeedMax",
    "EmpowerOtherEntityEffect",
    "ExternalMaxEquippableWeapons",
    "DuelSeed",
    "ChickenTrojanEffect",
    "GiantChombieCutscene",
    "FinishGiantChombieCutscene",
    "ExternalIsHidden",
    "BackToNormal",
    "ClientGiantChombie",
    "SlamEffect",
    "HunterLeapEffect",
    "ClientHunterZombie",
    "CameraFlashlightEnabled",
    "ZombieSpawn",
    "JoinCooldown",
    "SeasonEndTime",
    "SettingChanged",
    "HitmarkerDisabled",
    "HitmarkerColor",
    "HitmarkerColorCrit",
    "ResetReloadState",
    "ReplicatedExternalGameplayData",
    "SlamAttack",
    "FreeToUseContrabandWeapons",
    "CancelSlam",
    "ScopedRedDotDisabled",
    "HitmarkerTransparencyCrit",
    "HitmarkerScale",
    "HitmarkerRotation",
    "HitmarkerTransparency",
    "SpectateThisPlayer",
    "MapPool",
    "OriginalQueueName",
    "ExternalMapPoolPlaySourceName",
    "ClientSpleefTile",
    "SpleefTileShake",
    "ImmuneDamageEffect",
    "ClientRubble",
    "DisableOOB",
    "ExternalDisableOOB",
    "AddReceipt",
    "GrapplerPull",
    "ClientSatchelEntity",
    "ScopedDisabled",
    "ScopedBarsDisabled",
    "ScopedRedDotColor",
    "Throw",
    "ThrowFinal",
    "GrapplerMiss",
    "GrapplerTrackPart",
    "GrapplerCooldown",
    "CancelKnockbackEffect",
    "PaintballSplatter",
    "FreeWeaponTrials",
    "QuickAttackSystemOnReEquip",
    "SlowEffect",
    "Seed",
    "MapPoolGamemode",
    "MapPoolSpecific",
    "ExternalMapPoolSpecificMap"
};
local u2 = { "DuelerAdded", "EntityAdded", "MapAdded", "ItemRemoved", "DuelerRemoved", "DataValueChanged", "SafeUpdateLocalEquippedItemID", "Died" };

local function add_dump() -- Line: 83
    -- upvalues: u1 (copy), EnumLibrary (copy)
    for _, v in pairs(u1) do
        EnumLibrary:AddEnum(v);
    end;
end;

local function add_statistics() -- Line: 116
    -- upvalues: StatisticsLibrary (copy), EnumLibrary (copy)
    for _, v in pairs(StatisticsLibrary.Order) do
        EnumLibrary:AddEnum(v);
    end;
end;

local function add_maps() -- Line: 142
    -- upvalues: DuelLibrary (copy), EnumLibrary (copy)
    for _, v in pairs(DuelLibrary.HiddenMapOrder) do
        EnumLibrary:AddEnum(v);
    end;
end;

local function add_viewmodels() -- Line: 89
    -- upvalues: ItemLibrary (copy), EnumLibrary (copy), Utility (copy)
    for _, v in pairs(ItemLibrary.ViewModelOrder) do
        EnumLibrary:AddEnum(v);
    end;

    for _, v in pairs(ItemLibrary.ViewModels) do
        local v3 = v;
        local v4 = {};

        for i in pairs(v.Animations) do
            table.insert(v4, i);
        end;

        table.sort(v4, function(p5, p6) -- Line: 104
            -- upvalues: Utility (ref)
            return Utility:StringLessThan(p5, p6);
        end);

        for _, v2 in pairs(v4) do
            EnumLibrary:AddEnum(v2);
            EnumLibrary:AddEnum(v3.Animations[v2]);
        end;
    end;
end;

local function add_cosmetics() -- Line: 123
    -- upvalues: CosmeticLibrary (copy), Utility (copy), EnumLibrary (copy)
    local v7 = {};

    for i, v in pairs(CosmeticLibrary.Cosmetics) do
        if v.Type == "Finisher" then
            table.insert(v7, i);
        end;
    end;

    table.sort(v7, function(p8, p9) -- Line: 132
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p8, p9);
    end);

    for _, v in pairs(v7) do
        EnumLibrary:AddEnum(v);
    end;
end;

local function finish() -- Line: 148
    -- upvalues: u2 (copy), EnumLibrary (copy)
    for _, v in pairs(u2) do
        EnumLibrary.AlwaysReplicateToEveryone[v] = true;
        EnumLibrary.AlwaysReplicateToEveryone[EnumLibrary:ToEnum(v)] = true;
    end;

    EnumLibrary:EnumBuilderCompleted();
end;

for _, v in pairs(u1) do
    EnumLibrary:AddEnum(v);
end;

add_viewmodels();

for _, v in pairs(StatisticsLibrary.Order) do
    EnumLibrary:AddEnum(v);
end;

add_cosmetics();

for _, v in pairs(DuelLibrary.HiddenMapOrder) do
    EnumLibrary:AddEnum(v);
end;

finish();

return {};