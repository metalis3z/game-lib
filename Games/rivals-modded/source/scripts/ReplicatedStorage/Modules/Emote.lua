-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);

if CONSTANTS.IS_CLIENT then
    require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
end;

local u1 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local TestAttribute = TestLibrary:GetTestAttribute("StudioPing");
local IS_STUDIO = CONSTANTS.IS_STUDIO;
local u2 = {};
u2.__index = u2;
u2._id_counter = 0;

function u2.new(p3, p4, p5) -- Line: 23
    -- upvalues: CosmeticLibrary (copy), u2 (copy), Signal (copy)
    assert(CosmeticLibrary.Cosmetics[p4] and CosmeticLibrary.Cosmetics[p4].Type == "Emote", p4);
    local v6;

    if typeof(p5) == "Instance" then
        v6 = p5:IsA("Humanoid");
    else
        v6 = false;
    end;

    assert(v6, "Argument 1 invalid, expected a Humanoid");
    local v7 = setmetatable({}, u2);
    v7.Destroying = Signal.new();
    v7.ObjectID = v7:_NewObjectID();
    v7.Name = p4;
    v7.Info = CosmeticLibrary.Cosmetics[p4];
    v7.Lifetime = p3;
    v7._humanoid = p5;
    v7._destroyed = false;
    v7._destroy_these = {};
    v7._connections = {};
    v7._threads = {};
    v7._animation_tracks = {};
    v7._serial = nil;
    v7._seed = math.random(1, 1000000);
    v7._sounds = {};
    v7._are_sounds_hidden = false;
    v7:_Init();

    return v7;
end;

function u2.IsDestroyed(p8) -- Line: 56
    return p8._destroyed;
end;

function u2.CreateSound(p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19) -- Line: 60
    -- upvalues: Utility (copy)
    local v20;

    if p9._destroyed or (not p9._humanoid:IsDescendantOf(workspace) or p9._are_sounds_hidden) then
        v20 = nil;
    else
        v20 = p13 or p9._humanoid.RootPart;
    end;

    local v21 = Utility:CreateSound(p10, p11, p12, v20, p14, p15, p16, p17, p9:_GetSoundGroup(), p19);
    table.insert(p9._destroy_these, v21);
    p9._sounds[v21] = v21.Parent;

    return v21;
end;

function u2.HideSounds(u22, p23) -- Line: 70
    if p23 == u22._are_sounds_hidden then
        return;
    end;

    u22._are_sounds_hidden = p23;

    for i, v in pairs(u22._sounds) do
        pcall(function() -- Line: 79
            -- upvalues: i (copy), u22 (copy), v (copy)
            local v24;

            if u22._are_sounds_hidden then
                v24 = nil;
            else
                v24 = v;
            end;

            i.Parent = v24;
        end);
    end;
end;

function u2.Simulate(u25, u26) -- Line: 85
    -- upvalues: IS_STUDIO (copy), TestAttribute (copy)
    local BindableEvent = Instance.new("BindableEvent");
    table.insert(u25._destroy_these, BindableEvent);
    local u27 = 0;
    task.spawn(function() -- Line: 91
        -- upvalues: u25 (copy), u26 (copy), IS_STUDIO (ref), u27 (ref), BindableEvent (copy)
        local success, result = pcall(u25.PlayServer, u25, true);

        if not success and u26 then
            u26(result);
        end;

        if not success and IS_STUDIO then
            error(result);
        end;

        u27 = u27 + 1;
        BindableEvent:Fire();
    end);
    task.spawn(function() -- Line: 106
        -- upvalues: TestAttribute (ref), u25 (copy), u26 (copy), IS_STUDIO (ref), u27 (ref), BindableEvent (copy)
        if TestAttribute and TestAttribute > 0 then
            wait(TestAttribute / 1000);
        end;

        local success, result = pcall(u25.PlayClient, u25, true);

        if not success and u26 then
            u26(result);
        end;

        if not success and IS_STUDIO then
            error(result);
        end;

        u27 = u27 + 1;
        BindableEvent:Fire();
    end);

    while u27 < 2 do
        BindableEvent.Event:Wait();
    end;
end;

function u2.PlayServer(p28, p29) -- Line: 130
    if p28.Lifetime then
        task.delay(p28.Lifetime, p28.Destroy, p28);
    end;
end;

function u2.PlayClient(p30, p31) -- Line: 136
end;

function u2.SetSerial(p32, p33) -- Line: 140
    p32._serial = p33;
    p32._seed = p33.Seed;
    p32.ObjectID = p33.ObjectID;
end;

function u2.Serialize(p34) -- Line: 146
    return {
        ObjectID = p34.ObjectID,
        Name = p34.Name,
        Seed = p34._seed
    };
end;

function u2.Destroy(p35) -- Line: 156
    if p35._destroyed then
        return;
    end;

    p35._destroyed = true;
    p35.Destroying:Fire();
    task.defer(p35.Destroying.Destroy, p35.Destroying);

    for _, v in pairs(p35._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p35._destroy_these) do
        v:Destroy();
    end;

    for _, v in pairs(p35._threads) do
        pcall(task.cancel, v);
    end;

    for _, v in pairs(p35._animation_tracks) do
        v:Stop();
        v:Destroy();
    end;
end;

function u2._GetSoundGroup(p36) -- Line: 188
    -- upvalues: Players (copy), u1 (copy)
    local v37 = p36:_IsWorkspaceEmote() and p36._humanoid.Parent and Players:GetPlayerFromCharacter(p36._humanoid.Parent);

    return v37 and v37 ~= (u1 and u1.CurrentSubject and u1.CurrentSubject.Player) and "EmoteFromOthers" or "Emote";
end;

function u2._IsWorkspaceEmote(p38) -- Line: 195
    local _humanoid = p38._humanoid;

    while _humanoid do
        if _humanoid:IsA("WorldModel") then
            return false;
        end;

        if _humanoid == workspace then
            return true;
        end;

        _humanoid = _humanoid.Parent;
    end;

    return false;
end;

function u2._CanPlayAnimation(p39) -- Line: 211
    -- upvalues: Players (copy)
    local v40 = p39._humanoid.Parent and Players:GetPlayerFromCharacter(p39._humanoid.Parent);

    return not v40 or v40 == Players.LocalPlayer;
end;

function u2._NewObjectID(p41) -- Line: 217
    -- upvalues: u2 (copy)
    local v42 = u2;
    v42._id_counter = v42._id_counter + 1;

    return utf8.char(u2._id_counter - 1);
end;

function u2._GetGroundPosition(p43, p44, p45) -- Line: 222
    -- upvalues: Utility (copy)
    return Utility:Raycast(p44, p44 + Vector3.new(0, -100, 0), 100, p45, Enum.RaycastFilterType.Exclude).Position;
end;

function u2._SetupProp(p46, p47) -- Line: 226
    local v48 = {};

    for _, child in pairs(p47:GetChildren()) do
        if child:IsA("BasePart") then
            local v49 = child:Clone();
            table.insert(p46._destroy_these, v49);
            local v50 = p47:WaitForChild(v49.Name):Clone();
            table.insert(p46._destroy_these, v50);
            v50.Part1 = v49;
            v50.Part0 = p46._humanoid.RootPart;
            v50.Parent = p46._humanoid.RootPart;

            local function format(p51) -- Line: 244
                if not p51:IsA("BasePart") then
                    return;
                end;

                p51.CanCollide = false;
                p51.CanTouch = false;
                p51.CanQuery = false;
                p51.Massless = true;
            end;

            for _, descendant in pairs(v49:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                    descendant.Massless = true;
                end;
            end;

            if v49:IsA("BasePart") then
                v49.CanCollide = false;
                v49.CanTouch = false;
                v49.CanQuery = false;
                v49.Massless = true;
            end;

            v49:PivotTo(p46._humanoid.RootPart.CFrame);
            v49.Parent = p46._humanoid.Parent;

            for _, descendant in pairs(v49:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:SetAttribute("IgnoreVisibilityCheck", true);
                end;
            end;

            table.insert(v48, v49);
        end;
    end;

    return table.unpack(v48);
end;

function u2._SetupMultipleProps(p52, ...) -- Line: 276
    local v53 = { p52:_SetupProp(...) };
    local v54 = {};

    for _, v in pairs(v53) do
        assert(not v54[v.Name], v.Name);
        v54[v.Name] = v;
    end;

    return v54;
end;

function u2._PlayAnimation(u55, u56, u57, u58, p59, u60) -- Line: 288
    -- upvalues: ContentProvider (copy), RunService (copy)
    if not u55:_CanPlayAnimation() then
        return;
    end;

    local u61 = p59 or 1;
    u55:_InternalThread(task.spawn, function() -- Line: 295
        -- upvalues: u56 (copy), u55 (copy), u57 (copy), ContentProvider (ref), u61 (copy), u58 (copy), u60 (copy), RunService (ref)
        local Animation = Instance.new("Animation");
        Animation.AnimationId = u56;
        table.insert(u55._destroy_these, Animation);

        if u57 then
            task.spawn(pcall, ContentProvider.PreloadAsync, ContentProvider, { Animation });
            local Animation2 = Instance.new("Animation");
            Animation2.AnimationId = u57;
            table.insert(u55._destroy_these, Animation2);
            local success, result = pcall(u55._humanoid.LoadAnimation, u55._humanoid, Animation2);

            if success then
                table.insert(u55._animation_tracks, result);
                result:Play();
                result:AdjustSpeed(u61);
            end;

            wait(u58 - 0.04);

            if u55._destroyed then
                return;
            end;
        end;

        local success, result = pcall(u55._humanoid.LoadAnimation, u55._humanoid, Animation);

        if success then
            table.insert(u55._animation_tracks, result);
            result:Play(u57 and 0 or 0.1);
            result:AdjustSpeed(u61);

            if u60 then
                while true do
                    result:AdjustSpeed(u61 * ((not u55:_IsWorkspaceEmote() or u55._humanoid:GetAttribute("SimulateMoving")) and 1 or (u55._humanoid.RootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude / u60));
                    RunService.Heartbeat:Wait();
                end;
            end;
        end;
    end);
end;

function u2._InternalThread(p62, u63, ...) -- Line: 343
    -- upvalues: IS_STUDIO (copy)
    local u64 = nil;

    if IS_STUDIO then
        u64 = u63(...);
    else
        pcall(function(...) -- Line: 349
            -- upvalues: u64 (ref), u63 (copy)
            u64 = u63(...);
        end, ...);
    end;

    table.insert(p62._threads, u64);

    return u64;
end;

function u2._Init(u65) -- Line: 359
    table.insert(u65._connections, u65._humanoid.Destroying:Connect(function() -- Line: 360
        -- upvalues: u65 (copy)
        u65:Destroy();
    end));
end;

return u2;