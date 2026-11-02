-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Equipment);
local LightingProfiles = Players.LocalPlayer.PlayerScripts.Modules.LightingProfiles;
local LightingProfiles2 = Players.LocalPlayer.PlayerScripts.Assets.LightingProfiles;
local u1 = EventLibrary.IS_ACTIVE and (EventLibrary.EVENT_DETAILS.LOBBY_LIGHTING_PROFILE or "Lobby") or "Lobby";
local u2 = EventLibrary.IS_ACTIVE and EventLibrary.EVENT_DETAILS.EQUIPMENT_LIGHTING_PROFILE or "Lobby";
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 19
    -- upvalues: u3 (copy)
    local v4 = setmetatable({}, u3);
    v4.LocalFighter = nil;
    v4._connections = {};
    v4._assets = {};
    v4._current_lighting_name = nil;
    v4:_Init();

    return v4;
end;

function u3.SetLighting(p5, p6) -- Line: 37
    if p6 == p5._current_lighting_name then
        return;
    end;

    p5:_LoadMapLightingAssets("Default");
    p5:_LoadMapLightingModule("Default");

    if p6 == "Default" then
        return;
    end;

    p5:_LoadMapLightingAssets(p6);
    p5:_LoadMapLightingModule(p6);
end;

function u3._LoadMapLightingAssets(p7, p8) -- Line: 57
    -- upvalues: LightingProfiles2 (copy), Lighting (copy)
    local v9 = LightingProfiles2:FindFirstChild(p8);

    if not v9 then
        return;
    end;

    for _, v in pairs(p7._assets) do
        v:Destroy();
    end;

    p7._assets = {};

    for _, child in pairs(v9:GetChildren()) do
        local v10 = child:Clone();
        v10.Name = "LightingController";
        v10.Parent = child:IsA("Clouds") and workspace.Terrain or Lighting;
        table.insert(p7._assets, v10);
    end;
end;

function u3._LoadMapLightingModule(p11, p12) -- Line: 78
    -- upvalues: LightingProfiles (copy), Lighting (copy), SoundService (copy)
    local v13 = LightingProfiles:FindFirstChild(p12) and require(LightingProfiles[p12]);

    if not v13 then
        return;
    end;

    for i, v in pairs(v13.TerrainMaterials or {}) do
        workspace.Terrain:SetMaterialColor(i, v);
    end;

    for i, v in pairs(v13.TerrainProperties or {}) do
        workspace.Terrain[i] = v;
    end;

    for i, v in pairs(v13.LightingProperties or {}) do
        Lighting[i] = v;
    end;

    for i, v in pairs(v13.SoundServiceProperties or {}) do
        SoundService[i] = v;
    end;
end;

function u3._UpdateLighting(u14) -- Line: 102
    -- upvalues: Equipment (copy), u2 (copy), SpectateController (copy), u1 (copy)
    for _, v in pairs(u14._connections) do
        v:Disconnect();
    end;

    u14._connections = {};

    if Equipment.IsOpen then
        u14:SetLighting(u2);

        return;
    end;

    if not SpectateController.CurrentDuelSubject then
        if u14.LocalFighter and u14.LocalFighter:Get("IsInShootingRange") then
            u14:SetLighting("Shooting Range");

            return;
        end;

        u14:SetLighting(u1);

        return;
    end;

    local function update() -- Line: 112
        -- upvalues: SpectateController (ref), u14 (copy)
        local v15 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.Map;
        u14:SetLighting(v15 and (v15:Get("LightingProfileOverride") or (v15.Name or "Default")) or "Default");
    end;

    table.insert(u14._connections, SpectateController.CurrentDuelSubject.MapAdded:Connect(function(p16) -- Line: 118, Name: map_added
        -- upvalues: u14 (copy), update (copy), SpectateController (ref)
        local _connections = u14._connections;
        local DataChangedSignal = p16:GetDataChangedSignal("LightingProfileOverride");
        table.insert(_connections, DataChangedSignal:Connect(update));
        local v17 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.Map;
        u14:SetLighting(v17 and (v17:Get("LightingProfileOverride") or (v17.Name or "Default")) or "Default");
    end));

    if SpectateController.CurrentDuelSubject.Map then
        local _connections = u14._connections;
        local DataChangedSignal = SpectateController.CurrentDuelSubject.Map:GetDataChangedSignal("LightingProfileOverride");
        table.insert(_connections, DataChangedSignal:Connect(update));
        local v18 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.Map;
        u14:SetLighting(v18 and (v18:Get("LightingProfileOverride") or (v18.Name or "Default")) or "Default");
    end;

    local v19 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.Map;
    u14:SetLighting(v19 and (v19:Get("LightingProfileOverride") or (v19.Name or "Default")) or "Default");
end;

function u3._HookLocalFighter(u20) -- Line: 137
    -- upvalues: FighterController (copy)
    u20.LocalFighter = FighterController:WaitForLocalFighter();
    u20.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 140
        -- upvalues: u20 (copy)
        u20:_UpdateLighting();
    end);
    u20:_UpdateLighting();
end;

function u3._Setup(p21) -- Line: 147
    -- upvalues: Lighting (copy)
    workspace.Terrain:ClearAllChildren();

    for _, child in pairs(Lighting:GetChildren()) do
        if child.Name == "REMOVE_AT_RUNTIME" then
            child:Destroy();
        end;
    end;
end;

function u3._Init(u22) -- Line: 157
    -- upvalues: SpectateController (copy), Equipment (copy)
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 158
        -- upvalues: u22 (copy)
        u22:_UpdateLighting();
    end);
    Equipment.Opened:Connect(function() -- Line: 162
        -- upvalues: u22 (copy)
        u22:_UpdateLighting();
    end);
    u22:_Setup();
    u22:_UpdateLighting();
    task.spawn(u22._HookLocalFighter, u22);
end;

return u3._new();