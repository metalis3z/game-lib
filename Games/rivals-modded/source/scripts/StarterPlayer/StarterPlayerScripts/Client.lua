-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.EnumBuilder);
require(ReplicatedStorage.Modules.Utility);
local u1 = { "PlayerDataController", "ComplianceController", "FunctionsController", "UserInterfaceController", "MonetizationController", "EnemyController", "CameraController", "MechanicsController", "FighterController", "SpectateController", "TightropeController", "EntityController", "DuelController", "GameComponentsController", "ControlsController", "LeaderboardController", "LobbyController", "QueuePadController", "LightingController", "ShootingRangeController", "CoreGuiController", "MusicController", "MobileController", "ShopController", "ProximityPromptController", "PlayerInteractionController", "DebugController", "MatchmakingController", "ChattingController", "EventController", "PrivateServerController", "TestingController", "ShadyChickenController", "WrapController", "ScavengerHuntController", "SocialController", "FFlagController", "AudioController", "BirthdayController", "ArcadeController", "EmoteController", "SeasonController", "PartyController", "MiscellaneousController" };
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 29
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3:_Init();

    return v3;
end;

function u2.LoadModule(p4, p5) -- Line: 42
    -- upvalues: Players (copy)
    tick();
    p4[p5] = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild(p5));
end;

function u2._LoadModules(p6) -- Line: 54
    -- upvalues: u1 (copy)
    -- One controller that fails to load (several depend on modules that arrived obfuscated
    -- and broken) must not stop the ones after it, or the camera and the rest never start.
    for _, v in ipairs(u1) do
        local ok, err = pcall(p6.LoadModule, p6, v);

        if not ok then
            warn(string.format("[Client] %s failed to load: %s", v, tostring(err)));
        end;
    end;
end;

function u2._Init(p7) -- Line: 60
    p7:_LoadModules();
end;

return u2._new();