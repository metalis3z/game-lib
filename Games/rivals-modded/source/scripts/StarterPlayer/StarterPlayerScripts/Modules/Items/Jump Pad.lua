-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local JumpPads = require(Players.LocalPlayer.PlayerScripts.Modules.GameComponents.JumpPads);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Custom (copy), u1 (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3._use_cooldown = 0;
    v3._preview_connection = nil;
    v3._preview_model = nil;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 30
    return nil;
end;

function u1.CanQuickAttack(p5) -- Line: 34
    local v6;

    if tick() > p5._use_cooldown and (p5:Get("Ammo") or (1 / 0)) > 0 then
        v6 = not p5:IsEquipping() and p5:_CanPlace();
    else
        v6 = false;
    end;

    return v6;
end;

function u1.StartShooting(p7, p8) -- Line: 38
    if not (p8 or tick() >= p7._use_cooldown and ((p7:Get("Ammo") or (1 / 0)) > 0 and (not p7:IsEquipping() and p7:_CanPlace()))) then
        return false;
    end;

    p7._use_cooldown = tick() + p7.Info.Cooldown;
    p7:CooldownEffect("rbxassetid://17156089790", p7.Info.Cooldown, "Use");
    p7.ViewModel:StopAnimation("Inspect");
    p7.ViewModel:PlayAnimation("Use", 0.5);

    return true, "StartShooting", p7.ClientFighter:GetCameraData();
end;

function u1.Equip(p9, ...) -- Line: 53
    -- upvalues: Custom (copy)
    Custom.Equip(p9, ...);
    p9:_StartPlacementPreview();
end;

function u1.Unequip(p10, ...) -- Line: 58
    -- upvalues: Custom (copy)
    p10:_StopPlacementPreview();
    Custom.Unequip(p10, ...);
end;

function u1.Destroy(p11) -- Line: 63
    -- upvalues: Custom (copy)
    p11:_StopPlacementPreview();
    Custom.Destroy(p11);
end;

function u1._GetPlacementData(p12) -- Line: 72
    -- upvalues: GameplayUtility (copy)
    local CameraData = p12.ClientFighter:GetCameraData(nil, nil, true);
    local JumpPadPlacement, v13 = GameplayUtility:GetJumpPadPlacement(p12.ClientFighter:Get("EnvironmentID"), p12.Info.MaxReach, CameraData[utf8.char(0)], CameraData[utf8.char(1)], CameraData[utf8.char(2)], CameraData[utf8.char(3)]);

    return JumpPadPlacement, v13;
end;

function u1._CanPlace(p14) -- Line: 79
    local v15, v16 = p14:_GetPlacementData();

    return v15.Instance and v16, v15, v16;
end;

function u1._StopPlacementPreview(p17) -- Line: 86
    if p17._preview_connection then
        p17._preview_connection:Disconnect();
        p17._preview_connection = nil;
    end;

    if p17._preview_model then
        p17._preview_model:Destroy();
        p17._preview_model = nil;
    end;
end;

function u1._StartPlacementPreview(u18) -- Line: 98
    -- upvalues: JumpPads (copy), RunService (copy)
    u18:_StopPlacementPreview();

    if not (u18.ClientFighter.IsLocalPlayer and u18.ClientFighter:Get("IsSpectating")) then
        return;
    end;

    local u19 = JumpPads:CreateJumpPadVisual(u18.ViewModel.Name, u18.Info.HitboxSize);

    for _, descendant in pairs(u19:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Material = Enum.Material.ForceField;
            descendant.Color = Color3.fromRGB(0, 200, 255);
            descendant.CastShadow = false;
        end;
    end;

    local function update() -- Line: 120
        -- upvalues: u18 (copy), u19 (copy)
        if tick() <= u18._use_cooldown or (u18:Get("Ammo") or (1 / 0)) <= 0 then
            u19.Parent = nil;

            return;
        end;

        local _, _, v20 = u18:_CanPlace();

        if not u18:_CanPlace() then
            u19.Parent = nil;

            return;
        end;

        u19.Parent = workspace;
        u19:PivotTo(v20);
    end;

    u18._preview_connection = RunService.RenderStepped:Connect(update);
    update();
    u18._preview_model = u19;
end;

function u1._Init(u21) -- Line: 143
    local _connections = u21._connections;
    local DataChangedSignal = u21.ClientFighter:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 144
        -- upvalues: u21 (copy)
        if u21.ClientFighter:Get("IsSpectating") then
            if u21.IsEquipped then
                u21:_StartPlacementPreview();
            end;
        else
            u21:_StopPlacementPreview();
        end;
    end));
end;

return u1;