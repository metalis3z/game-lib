-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.GameplayUtility);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local EnemyController = require(Players.LocalPlayer.PlayerScripts.Controllers.EnemyController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 14
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._hurt_effect_enabled = false;
    v2._hurt_effect_outline_only = false;
    v2._hurt_effect_color_fill = Color3.fromRGB(255, 50, 50);
    v2._hurt_effect_color_outline = Color3.fromRGB(255, 255, 255);
    v2:_Init();

    return v2;
end;

function u1.GetScreenPoints(p3, p4, p5) -- Line: 31
    -- upvalues: EnemyController (copy), FighterController (copy), CONSTANTS (copy)
    local v6 = {};

    for _, v in pairs({ EnemyController.Objects, FighterController:GetEntities() }) do
        for _, v2 in pairs(v) do
            if not (p5 and v2.AimAssistBlacklist) and p4:IsValidTarget(v2) then
                local ScreenPoint, v7 = v2:GetScreenPoint();

                if v7 and ScreenPoint.Z < CONSTANTS.RENDER_DISTANCE then
                    v6[v2] = ScreenPoint;
                end;
            end;
        end;
    end;

    return v6;
end;

function u1._UpdateSettings(p8) -- Line: 55
    -- upvalues: PlayerDataController (copy), Utility (copy)
    local Setting = PlayerDataController:GetSetting("Damage Flashing");
    p8._hurt_effect_enabled = Setting ~= "Disabled";
    p8._hurt_effect_outline_only = Setting == "Outline";
    p8._hurt_effect_color_fill = Utility:Color3FromHex(PlayerDataController:GetSetting("Damage Flashing Color Base"));
    p8._hurt_effect_color_outline = Utility:Color3FromHex(PlayerDataController:GetSetting("Damage Flashing Color Flash"));
end;

function u1._SetupHurtEffect(u9, u10) -- Line: 65
    -- upvalues: Utility (copy)
    local v11;

    if typeof(u10) == "Instance" then
        v11 = u10:IsA("Model");
    else
        v11 = false;
    end;

    assert(v11, "Argument 1 invalid, expected a Model");
    u10:SetAttribute("PlayHurtEffect", 0);
    local u12 = nil;
    u10:GetAttributeChangedSignal("PlayHurtEffect"):Connect(function() -- Line: 72
        -- upvalues: u9 (copy), u12 (ref), u10 (copy), Utility (ref)
        if not u9._hurt_effect_enabled then
            return;
        end;

        if u12 then
            u12:Destroy();
            u12 = nil;
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.Name = "HurtEffect";
        Highlight.Adornee = u10;
        Highlight.Parent = u10;
        u12 = Highlight;
        Utility:RenderstepForLoop(0, 100, 1, function(p13) -- Line: 90
            -- upvalues: Highlight (copy), u12 (ref), u9 (ref)
            if Highlight ~= u12 then
                return true;
            end;

            local v14 = 1 - (1 - p13 / 100) ^ 5;
            local v15 = u9._hurt_effect_color_outline:Lerp(u9._hurt_effect_color_fill, (math.min(1, p13 / 5)));
            Highlight.FillColor = v15;
            Highlight.FillTransparency = u9._hurt_effect_outline_only and 1 or v14;
            Highlight.OutlineTransparency = v14;

            if not u9._hurt_effect_outline_only then
                v15 = u9._hurt_effect_color_fill;
            end;

            Highlight.OutlineColor = v15;
        end);
        Highlight:Destroy();
    end);
end;

function u1._SetupHurtEffects(p16) -- Line: 108
    local Model = Instance.new("Model");
    Model.Name = "HurtEffect";
    Model.Parent = workspace;
    p16:_SetupHurtEffect(Model);
    p16:_SetupHurtEffect(workspace:WaitForChild("ViewModels"):WaitForChild("FirstPerson"));
end;

function u1._Init(u17) -- Line: 117
    -- upvalues: PlayerDataController (copy)
    PlayerDataController:GetSettingChangedSignal("Damage Flashing"):Connect(function() -- Line: 118
        -- upvalues: u17 (copy)
        u17:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Damage Flashing Color Base"):Connect(function() -- Line: 122
        -- upvalues: u17 (copy)
        u17:_UpdateSettings();
    end);
    PlayerDataController:GetSettingChangedSignal("Damage Flashing Color Flash"):Connect(function() -- Line: 126
        -- upvalues: u17 (copy)
        u17:_UpdateSettings();
    end);
    task.spawn(u17._SetupHurtEffects, u17);
    u17:_UpdateSettings();
end;

return u1._new();