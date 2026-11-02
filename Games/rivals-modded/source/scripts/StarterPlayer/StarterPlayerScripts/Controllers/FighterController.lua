-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local ReplicatedController = require(Players.LocalPlayer.PlayerScripts.Modules.ReplicatedController);
local DefaultCharacter = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("DefaultCharacter");
local u1 = setmetatable({}, ReplicatedController);
u1.__index = u1;

function u1._new() -- Line: 20
    -- upvalues: ReplicatedController (copy), u1 (copy)
    local Fighter = ReplicatedController.new("Fighter");
    local v2 = setmetatable(Fighter, u1);
    v2.LocalFighter = nil;
    v2._network_id_map = {};
    v2._last_connection_level = nil;
    v2._player_to_fighter = {};
    v2._model_to_fighter = {};
    v2._last_controls_replicated_time = 0;
    v2._character_model_cache = {};
    v2:_Init();

    return v2;
end;

function u1.GetFighter(p3, p4) -- Line: 42
    -- upvalues: Players (copy)
    local v5 = p3._player_to_fighter[p4] or p3._model_to_fighter[p4];

    if v5 then
        return v5;
    end;

    if not p4 then
        return;
    end;

    if typeof(p4) == "Instance" then
        if not p4:IsA("Player") then
            return p3:GetFighter(Players:GetPlayerFromCharacter(p4));
        end;

        for i, v in pairs(p3.Objects) do
            if v.Player == p4 then
                return v, i;
            end;
        end;

        return nil;
    end;

    if typeof(p4) == "number" then
        return p3:GetFighter(Players:GetPlayerByUserId(p4));
    end;

    local v6 = tostring(p4);
    local v7 = typeof(p4) == "Instance" and p4.ClassName or typeof(p4);
    assert(false, "Argument 1 invalid, expected a Player or a Model or nil, got " .. v6 .. " (type: " .. v7 .. ")");
end;

function u1.GetFighterFromNetworkID(p8, p9) -- Line: 72
    return p8._network_id_map[p9];
end;

function u1.GetFightersNotInDuel(p10) -- Line: 76
    local v11 = {};

    for _, v in pairs(p10.Objects) do
        if not v:Get("IsInDuel") then
            table.insert(v11, v);
        end;
    end;

    return v11;
end;

function u1.GetEntities(p12) -- Line: 88
    local v13 = {};

    for _, v in pairs(p12.Objects) do
        if v.Entity then
            table.insert(v13, v.Entity);
        end;
    end;

    return v13;
end;

function u1.GetFighterModels(p14, p15) -- Line: 102
    local v16 = {};

    for _, v in pairs(p14.Objects) do
        if v.Entity and not (p15 and v.IsLocalPlayer) then
            table.insert(v16, v.Entity.Model);
        end;
    end;

    return v16;
end;

function u1.GetWrap(p17, p18) -- Line: 116
    for _, v in pairs(p17.Objects) do
        local Item = v:GetItem(p18);

        if Item then
            return Item:GetWrap();
        end;
    end;
end;

function u1.WaitForFighter(p19, ...) -- Line: 127
    local v20;

    while true do
        v20 = p19:GetFighter(...);

        if v20 then
            break;
        end;

        p19.ObjectAdded:Wait();
    end;

    return v20;
end;

function u1.WaitForLocalFighter(p21) -- Line: 139
    -- upvalues: Players (copy)
    return p21:WaitForFighter(Players.LocalPlayer);
end;

function u1.GenerateCharacterModel(u22, u23, p24) -- Line: 143
    -- upvalues: Players (copy), DefaultCharacter (copy)
    if u22._character_model_cache[tostring(u23)] then
        return u22._character_model_cache[tostring(u23)];
    end;

    local function generate() -- Line: 148
        -- upvalues: Players (ref), u23 (copy), u22 (copy)
        local success, result = pcall(Players.GetHumanoidDescriptionFromUserIdAsync, Players, u23);

        if not success then
            warn("Failed to fetch humanoid description:", result);

            return;
        end;

        result.Torso = 15365012259;
        result.LeftArm = 15365010034;
        result.RightArm = 15365012263;
        result.LeftLeg = 15365010038;
        result.RightLeg = 15365010030;
        local success2, result2 = pcall(Players.CreateHumanoidModelFromDescriptionAsync, Players, result, Enum.HumanoidRigType.R15);

        if success2 then
            u22._preloaded_character_model = result2;
            local v25 = {
                Template = result2
            };
            u22._character_model_cache[tostring(u23)] = v25;

            return v25;
        end;

        warn("Failed to create humanoid model:", result2);
    end;

    if p24 then
        return generate();
    end;

    task.spawn(generate);

    return u22._character_model_cache[tostring(u23)] or {
        Template = DefaultCharacter
    };
end;

function u1._VerifyEntityLoop(u26) -- Line: 197
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    local function is_inaccurate() -- Line: 198
        -- upvalues: u26 (copy), Players (ref)
        local v27 = not u26.LocalFighter:Get("IsInDuel") and (not u26.LocalFighter:Get("IsInShootingRange") and Players.LocalPlayer.Character) and (not u26.LocalFighter.Entity or u26.LocalFighter.Entity.Model ~= Players.LocalPlayer.Character);

        return v27;
    end;

    while wait(1) do
        if is_inaccurate() then
            wait(2);

            if is_inaccurate() then
                ReplicatedStorage.Remotes.Replication.Fighter.VerifyClientEntity:FireServer();
                wait(10);
            end;
        end;
    end;
end;

function u1._ConnectionLevelReplicationLoop(p28) -- Line: 214
    -- upvalues: Utility (copy), ReplicatedStorage (copy)
    while true do
        repeat
            wait(1);
        until p28.LocalFighter and p28.LocalFighter:Get("IsInDuel");

        local ConnectionLevel = Utility:GetConnectionLevel((Utility:GetLocalConnectionPing()));

        if ConnectionLevel ~= p28._last_connection_level then
            p28._last_connection_level = ConnectionLevel;
            ReplicatedStorage.Remotes.Replication.Fighter.UpdateConnectionLevel:FireServer(ConnectionLevel);
        end;
    end;
end;

function u1._UpdateNetworkIDMap(p29) -- Line: 234
    p29._network_id_map = {};

    for _, v in pairs(p29.Objects) do
        local v30 = v:Get("DecodedNetworkID");

        if v30 then
            p29._network_id_map[v30] = v;
        end;
    end;
end;

function u1._FighterAdded(u31, u32) -- Line: 246
    u32:GetDataChangedSignal("DecodedNetworkID"):Connect(function() -- Line: 247
        -- upvalues: u31 (copy)
        u31:_UpdateNetworkIDMap();
    end);
    u32.EntityAdded:Connect(function(p33) -- Line: 251
        -- upvalues: u31 (copy), u32 (copy)
        u31._model_to_fighter[p33.Model] = u32;
    end);
    u32.EntityRemoved:Connect(function(p34) -- Line: 255
        -- upvalues: u31 (copy), u32 (copy)
        for i, v in pairs(u31._model_to_fighter) do
            if v == u32 then
                u31._model_to_fighter[i] = nil;
            end;
        end;
    end);

    if u32.Entity and u32.Entity.Model then
        u31._model_to_fighter[u32.Entity.Model] = u32;
    end;

    u31._player_to_fighter[u32.Player] = u32;
    u31:_UpdateNetworkIDMap();
end;

function u1._ReplicateControls(p35) -- Line: 271
    -- upvalues: ControlsController (copy), ReplicatedStorage (copy)
    if not p35.LocalFighter then
        return;
    end;

    local v36 = 0.2 - (tick() - p35._last_controls_replicated_time);
    local math_max_ret = math.max(v36, 0.2);
    task.delay(math_max_ret, function() -- Line: 279
        -- upvalues: ControlsController (ref), ReplicatedStorage (ref)
        if typeof(ControlsController.CurrentControls) == "string" then
            ReplicatedStorage.Remotes.Replication.Fighter.SetControls:FireServer(ControlsController.CurrentControls);
        end;
    end);
end;

function u1._CameraReplicationLoop(p37) -- Line: 286
    -- upvalues: ReplicatedStorage (copy), CameraController (copy), Utility (copy)
    local function send(p38) -- Line: 287
        -- upvalues: ReplicatedStorage (ref)
        if p38 and not utf8.len(p38) then
            return;
        end;

        ReplicatedStorage.Remotes.Replication.Fighter.UpdateCameraRotation:FireServer(p38, nil);
    end;

    local v39 = false;
    local v40 = nil;

    while true do
        while true do
            wait(0.1);

            if p37.LocalFighter and (p37.LocalFighter:Get("IsSpectating") and CameraController:GetPublicState()) then
                break;
            end;

            if not v39 then
                task.defer(send, Utility:EncodeCameraRotation(Vector2.zero));
                v39 = true;
            end;
        end;

        local v41 = Utility:EncodeCameraRotation(CameraController.Rotation);

        if v39 or v41 ~= v40 then
            task.defer(send, v41);
            v40 = v41;
            v39 = false;
        else
            v40 = v41;
            v39 = false;
        end;
    end;
end;

function u1._HookLocalFighter(u42) -- Line: 317
    -- upvalues: CameraController (copy), ReplicatedStorage (copy), StarterGui (copy)
    u42.LocalFighter = u42:WaitForLocalFighter();

    local function update_third_person_overide() -- Line: 320
        -- upvalues: CameraController (ref), u42 (copy)
        CameraController:SetThirdPersonOverride(u42.LocalFighter:Get("ThirdPersonOverride"));
    end;

    u42.LocalFighter:GetDataChangedSignal("ThirdPersonOverride"):Connect(update_third_person_overide);
    task.defer(update_third_person_overide);
    local u43 = 0;
    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Event:Connect(function() -- Line: 330
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Replication.Fighter.ResetCharacter:FireServer();
    end);

    local function update_reset_button() -- Line: 334
        -- upvalues: u43 (ref), StarterGui (ref), u42 (copy), BindableEvent (copy)
        u43 = u43 + 1;
        -- The decompile compared u43 with itself, so an older call never stopped. Each call
        -- keeps retrying (the CoreScripts register the callback late, or never in Studio when
        -- their chat fails to load) until a newer call replaces it; it warns once.
        local hash = u43;
        local warned = false;
        local delay = 0.1;

        while hash == u43 do
            local v44 = pcall;
            local SetCore = StarterGui.SetCore;
            local v45 = not u42.LocalFighter:Get("IsInDuel") and BindableEvent;
            local v46, v47 = v44(SetCore, StarterGui, "ResetButtonCallback", v45);

            if v46 then
                break;
            end;

            if not warned then
                warned = true;
                warn("Failed to set reset button callback", v47);
            end;
            wait(delay);
            delay = math.min(delay * 2, 5);
        end;
    end;

    u42.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(update_reset_button);
    task.defer(update_reset_button);
    u42:_ReplicateControls();
    task.defer(u42._CameraReplicationLoop, u42);
    task.defer(u42._ConnectionLevelReplicationLoop, u42);
    task.defer(u42._VerifyEntityLoop, u42);
end;

function u1._Setup(p48) -- Line: 360
    -- upvalues: EnumLibrary (copy), Players (copy)
    function p48._reject_object_added_serial_callback(p49) -- Line: 361
        -- upvalues: EnumLibrary (ref), Players (ref)
        local v50 = not p49[EnumLibrary:ToEnum("Player")] and not Players:GetPlayerByUserId(p49[EnumLibrary:ToEnum("UserID")]);

        return v50;
    end;
end;

function u1._Init(u51) -- Line: 366
    -- upvalues: ControlsController (copy), ReplicatedStorage (copy), Utility (copy)
    u51.ObjectAdded:Connect(function(p52) -- Line: 367
        -- upvalues: u51 (copy)
        u51:_FighterAdded(p52);
    end);
    u51.ObjectRemoved:Connect(function(p53) -- Line: 371
        -- upvalues: u51 (copy)
        for i, v in pairs(u51._player_to_fighter) do
            if v == p53 then
                u51._model_to_fighter[i] = nil;
            end;
        end;

        for i, v in pairs(u51._model_to_fighter) do
            if v == p53 then
                u51._model_to_fighter[i] = nil;
            end;
        end;
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 385
        -- upvalues: u51 (copy)
        u51:_ReplicateControls();
    end);
    ReplicatedStorage.Remotes.Replication.Fighter.UpdateCameraRotations.OnClientEvent:Connect(function(p54) -- Line: 389
        -- upvalues: Utility (ref), u51 (copy)
        local v55 = Utility:DecodeCameraRotationBulk(p54);

        for _, v in pairs(v55) do
            local table_unpack_ret, v56, v57 = table.unpack(v);
            local FighterFromNetworkID = u51:GetFighterFromNetworkID(table_unpack_ret);

            if FighterFromNetworkID then
                FighterFromNetworkID:SetReplicate("CameraRotation", Utility:FromXYToCameraRotation(v56, v57));
            end;
        end;
    end);

    for _, v in pairs(u51.Objects) do
        task.spawn(u51._FighterAdded, u51, v);
    end;

    u51:_Setup();
    task.defer(u51._HookLocalFighter, u51);
end;

return u1._new();