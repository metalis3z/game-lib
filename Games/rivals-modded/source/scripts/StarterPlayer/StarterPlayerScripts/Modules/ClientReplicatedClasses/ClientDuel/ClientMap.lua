-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local Utility = require(ReplicatedStorage.Modules.Utility);
require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {
    Docks = { "rbxassetid://17813065011", 0.25, 0 },
    Station = { "rbxassetid://17813065464", 0.25, 13 },
    ["Big Station"] = { "rbxassetid://17813065464", 0.25, 13 },
    Backrooms = { "rbxassetid://17813170797", 1, 0 },
    Construction = { "rbxassetid://93752516938586", 1, 0 },
    ["Big Backrooms"] = { "rbxassetid://17813170797", 1, 0 },
    Onyx = { "rbxassetid://12099785239", 0.375, 0 },
    ["Big Onyx"] = { "rbxassetid://12099785239", 0.375, 0 },
    Splash = { "rbxassetid://18963688210", 0.75, 0 },
    ["Big Splash"] = { "rbxassetid://18963688210", 0.75, 0 },
    ["Zombie Tower"] = { "rbxassetid://90122406367653", 0.25, 0 },
    Iceberg = { "rbxassetid://103004663415392", 0.25, 0 },
    Village = { "rbxassetid://103004663415392", 0.25, 0 },
    Studio = { "rbxassetid://90866007129930", 1, 0 },
    Westown = { "rbxassetid://116999944271223", 1, 0 }
};
local u2 = setmetatable({}, ReplicatedClass);
u2.__index = u2;

function u2.new(p3, p4) -- Line: 30
    -- upvalues: ReplicatedClass (copy), u2 (copy)
    local v5 = ReplicatedClass.new(p3);
    local v6 = setmetatable(v5, u2);
    v6.Name = p3.Name;
    v6.Model = p3.Model;
    v6.ClientDuel = p4;
    v6.Data.IsHidden = nil;
    v6.Data.LightingProfileOverride = nil;
    v6._destroyed = false;
    v6._connections = {};
    v6._active_connections = {};
    v6._seed = p3.Seed;
    v6._on_hidden_update_callback = nil;
    v6._textures_deleted = false;
    v6._shadows_deleted = false;
    v6._ambience_sound = nil;
    v6._spectate_part = nil;
    v6._lighting_objects_folder = v6.Model:FindFirstChild("LightingObjects");
    v6._lighting_objects_folders = v6._lighting_objects_folder and (v6._lighting_objects_folder:GetChildren() or {}) or {};
    v6:_Init();

    return v6;
end;

function u2.IsRendered(p7) -- Line: 61
    return p7.ClientDuel:IsRendered();
end;

function u2.GetSpectatePart(p8) -- Line: 65
    if not p8._spectate_part then
        p8._spectate_part = p8.Model:FindFirstChild("Spectate");
    end;

    return p8._spectate_part;
end;

function u2.GetScoreboardDisplay(p9) -- Line: 73
    return nil;
end;

function u2.SetHidden(u10, p11) -- Line: 77
    -- upvalues: PlayerDataController (copy)
    if p11 == u10:Get("IsHidden") then
        return;
    end;

    for _, v in pairs(u10._active_connections) do
        v:Disconnect();
    end;

    u10._active_connections = {};
    u10:SetReplicate("IsHidden", p11);
    local v12;

    if p11 then
        v12 = nil;
    else
        v12 = workspace or nil;
    end;

    u10.Model.Parent = v12;
    u10:_UpdateAmbience();

    if p11 then
        return;
    end;

    local _active_connections = u10._active_connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("Textures Disabled");
    table.insert(_active_connections, SettingChangedSignal:Connect(function() -- Line: 96
        -- upvalues: u10 (copy)
        u10:_UpdateTextures();
    end));
    local _active_connections2 = u10._active_connections;
    local SettingChangedSignal2 = PlayerDataController:GetSettingChangedSignal("Shadows Disabled");
    table.insert(_active_connections2, SettingChangedSignal2:Connect(function() -- Line: 100
        -- upvalues: u10 (copy)
        u10:_UpdateShadows();
    end));
    u10:_UpdateTextures();
    u10:_UpdateShadows();
end;

function u2.CreateSound(p13, ...) -- Line: 108
    -- upvalues: Utility (copy)
    if not p13:Get("IsHidden") then
        return Utility:CreateSound(...);
    end;
end;

function u2.Destroy(p14) -- Line: 116
    -- upvalues: ReplicatedClass (copy)
    p14._destroyed = true;

    for _, v in pairs(p14._active_connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p14._connections) do
        v:Disconnect();
    end;

    if p14._ambience_sound then
        p14._ambience_sound:Destroy();
    end;

    ReplicatedClass.Destroy(p14);
end;

function u2._UpdateLightingObjects(p15) -- Line: 138
    local v16 = p15:Get("LightingProfileOverride") or p15.Name;

    for _, v in pairs(p15._lighting_objects_folders) do
        local v17;

        if v.Name == v16 then
            v17 = p15._lighting_objects_folder or nil;
        else
            v17 = nil;
        end;

        v.Parent = v17;
    end;
end;

function u2._UpdateHidden(u18) -- Line: 146
    local success, result = pcall(function() -- Line: 147
        -- upvalues: u18 (copy)
        u18:SetHidden(not u18.ClientDuel:Get("IsSpectating"));
    end);

    if not success then
        warn("Failed to hide/unhide map, error:", result);
    end;
end;

function u2._UpdateAmbience(p19) -- Line: 156
    -- upvalues: u1 (copy), Utility (copy)
    if p19:Get("IsHidden") and p19._ambience_sound then
        p19._ambience_sound:Destroy();
        p19._ambience_sound = nil;

        return;
    end;

    local v20 = not p19:Get("IsHidden") and (not p19._ambience_sound and u1[p19.Name]);

    if v20 then
        p19._ambience_sound = Utility:CreateSound(v20[1], v20[2], 1, script, true);
        p19._ambience_sound.Looped = true;
        p19._ambience_sound.TimePosition = v20[3];
    end;
end;

function u2._UpdateShadows(p21) -- Line: 171
    -- upvalues: PlayerDataController (copy), Utility (copy)
    if p21._shadows_deleted or (p21:Get("IsHidden") or not PlayerDataController:GetSetting("Shadows Disabled")) then
        return;
    end;

    p21._shadows_deleted = true;
    Utility:DisableShadows(p21.Model);
end;

function u2._UpdateTextures(p22) -- Line: 180
    -- upvalues: PlayerDataController (copy), Utility (copy)
    if p22._textures_deleted or (p22:Get("IsHidden") or not PlayerDataController:GetSetting("Textures Disabled")) then
        return;
    end;

    p22._textures_deleted = true;
    Utility:DisableTextures(p22.Model);
end;

function u2._Init(u23) -- Line: 189
    local _connections = u23._connections;
    local DataChangedSignal = u23.ClientDuel:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 190
        -- upvalues: u23 (copy)
        u23:_UpdateHidden();
    end));
    u23:GetDataChangedSignal("LightingProfileOverride"):Connect(function() -- Line: 194
        -- upvalues: u23 (copy)
        u23:_UpdateLightingObjects();
    end);
    u23:_UpdateHidden();
    task.defer(u23._UpdateLightingObjects, u23);
end;

return u2;