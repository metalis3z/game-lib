-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local UserInterfaceController = require(Players.LocalPlayer.PlayerScripts.Controllers.UserInterfaceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local EmoteRenderLogic = require(script:WaitForChild("EmoteRenderLogic"));
local EmoteSoundLogic = require(script:WaitForChild("EmoteSoundLogic"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy), Signal (copy), EmoteRenderLogic (copy), EmoteSoundLogic (copy)
    local v2 = setmetatable({}, u1);
    v2.CanEmoteChanged = Signal.new();
    v2.EmoteRenderLogic = EmoteRenderLogic.new(v2);
    v2.EmoteSoundLogic = EmoteSoundLogic.new(v2);
    v2._emoting_cooldown = 0;
    v2._equipping_items_cooldown = 0;
    v2:_Init();

    return v2;
end;

function u1.IsEquippingItemsDisabled(p3) -- Line: 38
    return tick() < p3._equipping_items_cooldown;
end;

function u1.CanEmote(p4, p5) -- Line: 42
    -- upvalues: UserInterfaceController (copy), FighterController (copy), Players (copy), CameraController (copy), SpectateController (copy), PlayerDataController (copy)
    if UserInterfaceController:IsEquipmentOpen() or not p5 and UserInterfaceController:IsPageOpen() or tick() < p4._emoting_cooldown then
        return false;
    end;

    local Fighter = FighterController:GetFighter(Players.LocalPlayer);
    local v6;

    if Fighter then
        v6 = Fighter:Get("IsSpectating");
    else
        v6 = Fighter;
    end;

    local v7;

    if CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam then
        v7 = not SpectateController.CurrentDuelSubject or SpectateController.CurrentDuelSubject.LocalDueler;
    else
        v7 = false;
    end;

    if not (v6 or v7) then
        return false;
    end;

    local v8 = Fighter.IsLocalPlayer and (Fighter:IsAlive() and not Fighter.Entity:Get("IsFrozen")) and next(PlayerDataController:Get("EquippedEmotes")) ~= nil;

    return v8;
end;

function u1.UseEmote(p9, p10) -- Line: 58
    -- upvalues: PlayerDataController (copy)
    local v11 = PlayerDataController:Get("EquippedEmotes")[p10];

    if not v11 then
        return;
    end;

    p9:UseEmoteByName(v11.Name);
end;

function u1.UseEmoteByName(p12, p13) -- Line: 68
    -- upvalues: ReplicatedStorage (copy)
    p12._equipping_items_cooldown = tick() + 0.5;
    ReplicatedStorage.Remotes.Replication.Fighter.UseEmoteByName:FireServer(p13);
end;

function u1.EquipEmote(p14, p15, p16) -- Line: 73
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Data.EquipEmote:FireServer(p15, p16);
end;

function u1._FighterAdded(u17, p18) -- Line: 81
    if not p18.IsLocalPlayer then
        return;
    end;

    local function changed() -- Line: 86
        -- upvalues: u17 (copy)
        u17.CanEmoteChanged:Fire();
    end;

    p18:GetDataChangedSignal("IsSpectating"):Connect(changed);
    p18.HealthChanged:Connect(changed);
    u17.CanEmoteChanged:Fire();

    local function entity_added(p19) -- Line: 94
        -- upvalues: changed (copy), u17 (copy)
        p19:GetDataChangedSignal("IsFrozen"):Connect(changed);
        u17.CanEmoteChanged:Fire();
    end;

    p18.EntityAdded:Connect(entity_added);

    if p18.Entity then
        task.spawn(entity_added, p18.Entity);
    end;

    p18.EquippedItemChanged:Connect(function() -- Line: 105
        -- upvalues: u17 (copy), changed (copy)
        u17._emoting_cooldown = tick() + 0.5;
        u17.CanEmoteChanged:Fire();
        task.delay(0.5, changed);
    end);
end;

function u1._Init(u20) -- Line: 112
    -- upvalues: PlayerDataController (copy), CameraController (copy), SpectateController (copy), UserInterfaceController (copy), FighterController (copy)
    PlayerDataController:GetDataChangedSignal("EquippedEmotes"):Connect(function() -- Line: 113
        -- upvalues: u20 (copy)
        u20.CanEmoteChanged:Fire();
    end);
    CameraController.StateChanged:Connect(function() -- Line: 117
        -- upvalues: u20 (copy)
        u20.CanEmoteChanged:Fire();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 121
        -- upvalues: u20 (copy)
        u20.CanEmoteChanged:Fire();
    end);
    UserInterfaceController.PageSystemPagesActivity:Connect(function() -- Line: 125
        -- upvalues: u20 (copy)
        u20.CanEmoteChanged:Fire();
    end);
    UserInterfaceController.EquipmentOpened:Connect(function() -- Line: 129
        -- upvalues: u20 (copy)
        u20.CanEmoteChanged:Fire();
    end);
    FighterController.ObjectAdded:Connect(function(p21) -- Line: 133
        -- upvalues: u20 (copy)
        u20:_FighterAdded(p21);
    end);

    for _, v in pairs(FighterController.Objects) do
        task.spawn(u20._FighterAdded, u20, v);
    end;
end;

return u1._new();