-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 17
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3.IsChargingMinigun = false;
    v3.IsWindingMinigun = false;
    v3._active_shooting_finish = 0;
    v3._last_winding_sounds = nil;
    v3._last_shooting_sounds = nil;
    v3._last_ammo_belt_count = 20;
    v3._ammo_belt_models = {};
    v3:_Init();

    return v3;
end;

function u1.StartChargingMinigun(p4) -- Line: 38
    -- upvalues: CameraController (copy)
    local v5 = tick();
    local v6 = CameraController:GetLastHeartbeatDeltaTime() * 3;
    p4._active_shooting_finish = v5 + math.max(0.1, v6);
    p4:_ChargeLoop(true);
end;

function u1.Unequip(p7, ...) -- Line: 43
    -- upvalues: ClientViewModel (copy)
    p7:StopAnimation("ChargeStart");
    p7:StopAnimation("ChargeLoop");
    p7:StopAnimation("ChargeFinish", nil, 0);
    ClientViewModel.Unequip(p7, ...);
end;

function u1._CreateMinigunShootingSounds(p8) -- Line: 54
    local v9 = p8:CreateSound("rbxassetid://17246880027", 8.75, 1, true);
    v9.TimePosition = 0.25 + 0.25 * math.random();
    v9.Looped = true;

    return { v9 };
end;

function u1._CreateMinigunWindingSounds(p10) -- Line: 62
    local v11 = p10:CreateSound("rbxassetid://17251084003", 0.5, 1, true);
    v11.TimePosition = 2;
    v11.Looped = true;

    return { v11 };
end;

function u1._UpdateAmmoBelt(p12) -- Line: 70
    local v13 = p12.ClientItem:Get("Ammo");

    if p12._last_ammo_belt_count == v13 then
        return;
    end;

    p12._last_ammo_belt_count = v13;

    for i, v in pairs(p12._ammo_belt_models) do
        local v14 = i;

        for _, v2 in pairs(v) do
            p12:_LocalTransparencyModifier(v2, "AmmoVisual", p12._last_ammo_belt_count < v14 and 1 or 0);
        end;
    end;
end;

function u1._ChargeLoop(p15, p16) -- Line: 86
    -- upvalues: AnimationLibrary (copy), RunService (copy), Utility (copy)
    if p15.IsChargingMinigun then
        return;
    end;

    p15.IsChargingMinigun = true;
    p15:StopAnimation("ChargeFinish");
    local u17 = p15:_CreateMinigunWindingSounds();
    local v18 = {};

    for _, v in pairs(u17) do
        v18[v] = {
            Volume = v.Volume,
            PlaybackSpeed = v.PlaybackSpeed
        };
        v.Volume = 0;
    end;

    if p15._last_winding_sounds then
        for _, v in pairs(p15._last_winding_sounds) do
            v:Destroy();
        end;
    end;

    p15._last_winding_sounds = u17;

    if p16 then
        local ChargingWindUpLength = p15.ClientItem.Info.ChargingWindUpLength;
        local v19 = tick() + ChargingWindUpLength;
        p15:PlayAnimation("ChargeStart", AnimationLibrary.Info[p15.Info.Animations.ChargeStart].Length);
        p15.IsWindingMinigun = true;

        while not p15._destroyed and (p15._is_equipped and (tick() < v19 and (tick() < p15._active_shooting_finish or p15.ClientItem:Get("IsAiming")))) do
            local v20 = (ChargingWindUpLength - (v19 - tick())) / ChargingWindUpLength;
            local math_clamp_ret = math.clamp(v20, 0, 1);

            for _, v in pairs(u17) do
                v.Volume = v18[v].Volume * math_clamp_ret;
                v.PlaybackSpeed = v18[v].PlaybackSpeed * (math_clamp_ret * 1.5 + 1);
            end;

            RunService.RenderStepped:Wait();
        end;

        p15.IsWindingMinigun = false;
    end;

    for i = 1, (1 / 0) do
        if p15._destroyed or not (p15._is_equipped and (tick() <= p15._active_shooting_finish or p15.ClientItem:Get("IsAiming"))) then
            break;
        end;

        local v21;

        if i == 1 then
            p15:PlayAnimation("ChargeLoop", (1 / 0));
            v21 = i;

            for _, v in pairs(u17) do
                v.Volume = v18[v].Volume;
                v.PlaybackSpeed = v18[v].PlaybackSpeed * 2.5;
            end;
        else
            v21 = i;
        end;

        RunService.RenderStepped:Wait();
    end;

    p15.IsChargingMinigun = false;
    p15:StopAnimation("ChargeStart");
    p15:StopAnimation("ChargeLoop");

    if p15._is_equipped then
        p15:PlayAnimation("ChargeFinish", AnimationLibrary.Info[p15.Info.Animations.ChargeFinish].Length);
    end;

    local u22 = {};

    for _, v in pairs(u17) do
        u22[v] = {
            Volume = v.Volume,
            PlaybackSpeed = v.PlaybackSpeed
        };
    end;

    Utility:RenderstepForLoop(0, 100, 1.5, function(p23) -- Line: 170
        -- upvalues: u17 (copy), u22 (copy)
        local v24 = p23 / 100;

        for _, v in pairs(u17) do
            v.Volume = u22[v].Volume + (0 - u22[v].Volume) * (1 - (1 - v24) ^ 4);
            v.PlaybackSpeed = u22[v].PlaybackSpeed + (1 - u22[v].PlaybackSpeed) * v24;
        end;
    end);

    for _, v in pairs(u17) do
        v:Destroy();
    end;
end;

function u1._Setup(u25) -- Line: 184
    -- upvalues: RunService (copy)
    local _ammo_belt = u25.ItemModel:FindFirstChild("_ammo_belt", true);

    if _ammo_belt then
        for i = 1, 20 do
            local v26 = _ammo_belt:WaitForChild(i);
            u25._ammo_belt_models[i] = { v26:FindFirstChild("Shell"), v26:FindFirstChild("Strap") };
            local _ = i;
        end;
    end;

    task.defer(function() -- Line: 196
        -- upvalues: u25 (copy), RunService (ref)
        u25.ClientItem.Shot:Connect(function() -- Line: 197
            -- upvalues: u25 (ref), RunService (ref)
            u25._active_shooting_finish = tick() + 0.1;

            if not u25._last_shooting_sounds then
                u25._last_shooting_sounds = u25:_CreateMinigunShootingSounds();
                task.spawn(function() -- Line: 203
                    -- upvalues: u25 (ref), RunService (ref)
                    while not u25._destroyed and tick() < u25._active_shooting_finish do
                        RunService.RenderStepped:Wait();
                    end;

                    for _, v in pairs(u25._last_shooting_sounds) do
                        v:Destroy();
                    end;

                    u25._last_shooting_sounds = nil;
                end);
            end;

            u25:_ChargeLoop();
        end);
    end);
end;

function u1._Init(u27) -- Line: 221
    u27.ClientItem:GetDataChangedSignal("IsAiming"):Connect(function(p28) -- Line: 222
        -- upvalues: u27 (copy)
        if p28 then
            u27:_ChargeLoop(true);
        end;
    end);
    u27.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 228
        -- upvalues: u27 (copy)
        u27:_UpdateAmmoBelt();
    end);
    u27:_Setup();
    u27:_UpdateAmmoBelt();
end;

return u1;