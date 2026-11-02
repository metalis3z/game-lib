-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("StarterGui");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Teleporting);
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Queue);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 22
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.SubjectChanged = Signal.new();
    v2.SubjectEmoteStatusChanged = Signal.new();
    v2.DuelSubjectChanged = Signal.new();
    v2.DuelSubjectEnvironmentIDChanged = Signal.new();
    v2.DuelSubjectStatusChanged = Signal.new();
    v2.Subjects = {};
    v2.CurrentSubject = nil;
    v2.CurrentDuelSubject = nil;
    v2._duel_connections = {};
    v2._subject_connections = {};
    v2._last_spectating_user_id = nil;
    v2._spectate_duel_request_queue = {};
    v2._spectate_duel_request_queue_active = false;
    v2._duel_just_spectated = {};
    v2._firing_subject_changed = nil;
    v2._process_mb2_on_input_ended_delta = nil;
    v2:_Init();

    return v2;
end;

function u1.IsRendered(p3, p4) -- Line: 54
    -- upvalues: CONSTANTS (copy), Players (copy)
    local IS_ARCADE_SERVER = CONSTANTS.IS_ARCADE_SERVER;

    if not IS_ARCADE_SERVER then
        if Players.LocalPlayer:GetAttribute("EnvironmentID") == p4 then
            IS_ARCADE_SERVER = true;
        else
            IS_ARCADE_SERVER = p3.CurrentDuelSubject and p3.CurrentDuelSubject:Get("EnvironmentID") == p4;
        end;
    end;

    return IS_ARCADE_SERVER;
end;

function u1.IsSubjectEmoting(p5) -- Line: 58
    local v6 = p5.CurrentSubject and p5.CurrentSubject.Entity and p5.CurrentSubject.Entity:IsEmoting();

    return v6;
end;

function u1.IsThereValidSubject(p7, p8) -- Line: 62
    for _, v in pairs(p7.Subjects) do
        if v ~= p8 and p7:_IsValidSubject(v) then
            return true;
        end;
    end;

    return false;
end;

function u1.Increment(p9, p10) -- Line: 72
    if not p9.CurrentDuelSubject or p9.CurrentSubject and p9.CurrentSubject.IsLocalPlayer then
        return;
    end;

    if not p9:IsThereValidSubject(p9.CurrentSubject) then
        return;
    end;

    local v11 = p9.CurrentSubject and (table.find(p9.Subjects, p9.CurrentSubject) or 0) or 0;
    local v12;

    if v11 or p10 ~= 1 then
        if v11 or p10 ~= -1 then
            if p10 == 1 and v11 == #p9.Subjects then
                v12 = 1;
            elseif p10 == -1 and v11 == 1 then
                v12 = #p9.Subjects;
            else
                v12 = v11 + p10;
            end;
        else
            v12 = #p9.Subjects;
        end;
    else
        v12 = 1;
    end;

    p9:_RawSetCurrentSubject(p9.Subjects[v12]);
    p9:_VerifySubject(p10 == -1);
end;

function u1.Next(p13) -- Line: 94
    p13._duel_just_spectated = {};
    p13:Increment(1);
end;

function u1.Last(p14) -- Line: 99
    p14._duel_just_spectated = {};
    p14:Increment(-1);
end;

function u1.Exit(p15) -- Line: 104
    if not p15.CurrentDuelSubject or p15.CurrentDuelSubject.LocalDueler then
        return;
    end;

    p15:SpectateDuelRequest(nil);
end;

function u1.SpectateDuelRequest(u16, p17) -- Line: 113
    -- upvalues: Queue (copy), DuelController (copy), Players (copy), ReplicatedStorage (copy)
    if p17 and not (p17.LocalDueler or not Queue:IsVisible() and p17:Get("Status") ~= "GameOver") then
        return;
    end;

    local v18 = { DuelController:GetDuel(Players.LocalPlayer) or p17 };
    table.insert(u16._spectate_duel_request_queue, v18);
    task.spawn(function() -- Line: 125
        -- upvalues: u16 (copy), ReplicatedStorage (ref)
        if u16._spectate_duel_request_queue_active then
            return;
        end;

        u16._spectate_duel_request_queue_active = true;

        while #u16._spectate_duel_request_queue > 0 do
            local table_remove_ret = table.remove(u16._spectate_duel_request_queue, 1);
            local v19 = u16.CurrentDuelSubject and u16.CurrentDuelSubject:Get("ObjectID") or nil;
            local v20 = table_remove_ret[1] and table_remove_ret[1]:Get("ObjectID") or nil;

            if v20 ~= v19 then
                ReplicatedStorage.Remotes.Replication.Fighter.SpectateDuel:FireServer(v20);
                wait(1);
            end;
        end;

        u16._spectate_duel_request_queue = {};
        u16._spectate_duel_request_queue_active = false;
    end);
end;

function u1.Update(p21, p22) -- Line: 149
    -- upvalues: FighterController (copy), CONSTANTS (copy)
    local v23 = p21.CurrentDuelSubject and p21.CurrentDuelSubject:GetFighters() or FighterController:GetFightersNotInDuel();

    if FighterController.LocalFighter and not table.find(v23, FighterController.LocalFighter) then
        table.insert(v23, FighterController.LocalFighter);
    end;

    local v24 = {};

    for _, v in pairs(v23) do
        if not v24[v.Player] then
            v24[v.Player] = true;

            if CONSTANTS.IS_TESTING_SERVER then
                v:Update(p22);
            else
                local success, result = pcall(v.Update, v, p22);

                if not success then
                    warn("ClientFighter::Update errored:", result);
                end;
            end;
        end;
    end;
end;

function u1._IsValidSubject(p25, p26) -- Line: 181
    -- upvalues: CameraController (copy)
    if CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam then
        return false;
    end;

    if not (p26 and p26:IsAlive()) then
        return false;
    end;

    if p25.CurrentDuelSubject and not table.find(p25.CurrentDuelSubject:GetFighters(), p26) then
        return false;
    end;

    if not (p25.CurrentDuelSubject and p25.CurrentDuelSubject.LocalDueler) then
        return true;
    end;

    if p25.CurrentDuelSubject and (p25.CurrentDuelSubject.LocalDueler and p25.CurrentDuelSubject.LocalDueler:IsAlive()) then
        return p26 == p25.CurrentDuelSubject.LocalDueler.ClientFighter;
    end;

    local v27 = p25.CurrentDuelSubject.LocalDueler:Get("TeamID");

    if not v27 then
        return true;
    end;

    if p25.CurrentDuelSubject:Get("IsCurrentArcadeDuel") then
        return true;
    end;

    local v28 = false;

    for _, v in pairs(p25.CurrentDuelSubject.Duelers) do
        if v:Get("TeamID") == v27 and v:IsAlive() then
            v28 = true;
            break;
        end;
    end;

    return not (p25.CurrentDuelSubject:Get("StaggeredSpawns") and p25.CurrentDuelSubject:Get("Status") ~= "RoundFinished" or v28) and true or p26:Get("TeamID") == v27;
end;

function u1._RawSetCurrentSubject(p29, p30) -- Line: 243
    if p30 == p29.CurrentSubject then
        return;
    end;

    for _, v in pairs(p29._subject_connections) do
        v:Disconnect();
    end;

    p29._subject_connections = {};

    if p29.CurrentSubject then
        p29.CurrentSubject:SetReplicate("IsSpectating", false);

        if p29.CurrentDuelSubject and p29.CurrentSubject.Player then
            p29._duel_just_spectated[p29.CurrentSubject.Player] = tick();
        end;
    end;

    p29.CurrentSubject = p30;
    p29.SubjectChanged:FireDeferred();

    if p29.CurrentSubject then
        p29.CurrentSubject:SetReplicate("IsSpectating", true);
    end;
end;

function u1._VerifySubject(u31, p32) -- Line: 270
    local v33 = u31.CurrentSubject and (table.find(u31.Subjects, u31.CurrentSubject) or 1) or 1;
    local v34 = p32 and -1 or 1;
    local v35 = nil;

    for i = 1, #u31.Subjects do
        local v36 = u31.Subjects[(v33 + (i - 1) * v34 - 1) % #u31.Subjects + 1];

        if u31:_IsValidSubject(v36) then
            v35 = v36;
            break;
        end;

        local _ = i;
    end;

    if v35 == u31.CurrentSubject then
        return;
    end;

    u31:_RawSetCurrentSubject(v35);

    if not u31.CurrentSubject then
        return;
    end;

    local function verify_subject() -- Line: 301
        -- upvalues: u31 (copy)
        u31:_VerifySubject();
    end;

    table.insert(u31._subject_connections, u31.CurrentSubject.EntityRemoved:Connect(verify_subject));
    table.insert(u31._subject_connections, u31.CurrentSubject.EntityAdded:Connect(verify_subject));
    table.insert(u31._subject_connections, u31.CurrentSubject.Died:Connect(verify_subject));
    table.insert(u31._subject_connections, u31.CurrentSubject.EntityAdded:Connect(function(p37) -- Line: 310, Name: entity_added
        -- upvalues: u31 (copy)
        table.insert(u31._subject_connections, p37.EmoteStatusChanged:Connect(function() -- Line: 311
            -- upvalues: u31 (ref)
            u31.SubjectEmoteStatusChanged:Fire();
        end));
    end));

    if u31.CurrentSubject.Entity then
        table.insert(u31._subject_connections, u31.CurrentSubject.Entity.EmoteStatusChanged:Connect(function() -- Line: 311
            -- upvalues: u31 (copy)
            u31.SubjectEmoteStatusChanged:Fire();
        end));
    end;
end;

function u1._CleanupCurrentDuelSubject(p38, p39) -- Line: 323
    for _, v in pairs(p38._duel_connections) do
        v:Disconnect();
    end;

    p38._duel_connections = {};
    p38._duel_just_spectated = {};

    for i = #p38.Subjects, 1, -1 do
        p38:_RemoveSubject(p38.Subjects[i], true);
        local _ = i;
    end;

    p38:_VerifySubject();

    if p38.CurrentDuelSubject and p38.CurrentDuelSubject ~= p39 then
        p38.CurrentDuelSubject:SetReplicate("IsSpectating", false);

        for _, v in pairs(p38.CurrentDuelSubject.Duelers) do
            if v.ClientFighter then
                v.ClientFighter:ClearInterface();
                v.ClientFighter:ClearSounds(true);
            end;
        end;
    end;
end;

function u1._SpectateDuel(u40, p41) -- Line: 349
    -- upvalues: DuelController (copy), Players (copy)
    local Duel = DuelController:GetDuel(Players.LocalPlayer);

    if Duel and p41 ~= Duel then
        return;
    end;

    u40:_CleanupCurrentDuelSubject(p41);
    u40.CurrentDuelSubject = p41;
    u40.DuelSubjectChanged:Fire();

    if not u40.CurrentDuelSubject then
        return;
    end;

    u40.CurrentDuelSubject:SetReplicate("IsSpectating", true);
    local _duel_connections = u40._duel_connections;
    local DataChangedSignal = u40.CurrentDuelSubject:GetDataChangedSignal("EnvironmentID");
    table.insert(_duel_connections, DataChangedSignal:Connect(function() -- Line: 371
        -- upvalues: u40 (copy)
        u40.DuelSubjectEnvironmentIDChanged:Fire();
    end));
    local _duel_connections2 = u40._duel_connections;
    local DataChangedSignal2 = u40.CurrentDuelSubject:GetDataChangedSignal("Status");
    table.insert(_duel_connections2, DataChangedSignal2:Connect(function() -- Line: 375
        -- upvalues: u40 (copy)
        u40.DuelSubjectStatusChanged:Fire();
    end));

    local function u42() -- Line: 380
        -- upvalues: u40 (copy)
        u40:_VerifySubject();
    end;

    local _duel_connections3 = u40._duel_connections;
    local DataChangedSignal3 = u40.CurrentDuelSubject:GetDataChangedSignal("IsCurrentArcadeDuel");
    table.insert(_duel_connections3, DataChangedSignal3:Connect(u42));
    local _duel_connections4 = u40._duel_connections;
    local DataChangedSignal4 = u40.CurrentDuelSubject:GetDataChangedSignal("Status");
    table.insert(_duel_connections4, DataChangedSignal4:Connect(u42));
    task.defer(u42);
    table.insert(u40._duel_connections, u40.CurrentDuelSubject.DuelerRemoved:Connect(function(p43) -- Line: 388, Name: dueler_removed
        -- upvalues: u40 (copy)
        if p43.IsLocalPlayer then
            u40:SpectateDuelRequest(nil);

            return;
        end;

        u40:_RemoveSubject(p43.ClientFighter);
    end));

    local function dueler_added(p44, p45) -- Line: 398
        -- upvalues: u40 (copy), u42 (copy)
        local _duel_connections5 = u40._duel_connections;
        local DataChangedSignal5 = p44:GetDataChangedSignal("TeamID");
        table.insert(_duel_connections5, DataChangedSignal5:Connect(u42));
        table.insert(u40._duel_connections, p44.EntityAdded:Connect(u42));
        table.insert(u40._duel_connections, p44.Eliminated:Connect(u42));
        table.insert(u40._duel_connections, p44.Died:Connect(u42));
        u40:_AddSubject(p44.ClientFighter, p45);
    end;

    table.insert(u40._duel_connections, u40.CurrentDuelSubject.DuelerAdded:Connect(dueler_added));

    for _, v in pairs(u40.CurrentDuelSubject.Duelers) do
        task.spawn(dueler_added, v, true);
    end;

    table.insert(u40._duel_connections, u40.CurrentDuelSubject.SpectateThisPlayer:Connect(function(p46, p47) -- Line: 413
        -- upvalues: u40 (copy)
        if tick() > (u40._duel_just_spectated[p46] or 0) + 0.3 then
            return;
        end;

        local v48 = nil;

        for _, v in pairs(u40.Subjects) do
            if v.Player == p47 then
                v48 = v;
                break;
            end;
        end;

        u40:_RawSetCurrentSubject(v48);
        u40:_VerifySubject();
    end));
end;

function u1._AddSubject(p49, p50, p51) -- Line: 432
    if table.find(p49.Subjects, p50) then
        return;
    end;

    table.insert(p49.Subjects, p50);

    if not p51 then
        p49:_VerifySubject();
    end;
end;

function u1._RemoveSubject(p52, p53, p54) -- Line: 445
    if p53.IsLocalPlayer then
        return;
    end;

    local table_find_ret = table.find(p52.Subjects, p53);

    if not table_find_ret then
        return;
    end;

    if p53 == p52.CurrentSubject then
        p52:Increment(-1);
    end;

    table.remove(p52.Subjects, table_find_ret);

    if not p54 then
        p52:_VerifySubject();
    end;
end;

function u1._SpectatingReplicationLoop(p55) -- Line: 469
    -- upvalues: ReplicatedStorage (copy)
    while true do
        wait(1);
        local v56 = p55.CurrentSubject and p55.CurrentSubject.Player.UserId;

        if v56 ~= p55._last_spectating_user_id then
            p55._last_spectating_user_id = v56;
            ReplicatedStorage.Remotes.Replication.Fighter.Spectating:FireServer(p55._last_spectating_user_id);
        end;
    end;
end;

function u1._ProcessInput(p57, p58) -- Line: 482
    -- upvalues: CameraController (copy), InputLibrary (copy)
    local v59 = CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam;

    if InputLibrary:InputIs(p58, "SpectateNext") and not v59 then
        p57:Next();

        return;
    end;

    if InputLibrary:InputIs(p58, "SpectateLast") and not v59 then
        p57:Last();

        return;
    end;

    if InputLibrary:InputIs(p58, "SpectateExit") then
        p57:Exit();
    end;
end;

function u1._HookLocalFighter(u60) -- Line: 494
    -- upvalues: FighterController (copy), DuelController (copy)
    local u61 = FighterController:WaitForLocalFighter();

    local function update_duel_subject() -- Line: 497
        -- upvalues: u61 (copy), DuelController (ref), u60 (copy)
        local v62 = u61:Get("SpectatingDuelObjectID");
        u60:_SpectateDuel(v62 and DuelController:GetDuelByID(v62) or nil);
    end;

    u61:GetDataChangedSignal("SpectatingDuelObjectID"):Connect(update_duel_subject);
    local v63 = u61:Get("SpectatingDuelObjectID");
    u60:_SpectateDuel(v63 and DuelController:GetDuelByID(v63) or nil);
end;

function u1._Init(u64) -- Line: 508
    -- upvalues: CameraController (copy), RunService (copy), UserInputService (copy), FighterController (copy), DuelController (copy), Teleporting (copy), Queue (copy)
    u64.SubjectChanged:Connect(function() -- Line: 509
        -- upvalues: u64 (copy), CameraController (ref)
        u64.SubjectEmoteStatusChanged:Fire();
        CameraController:SetSubject(u64.CurrentSubject);
    end);
    u64.DuelSubjectChanged:Connect(function() -- Line: 514
        -- upvalues: u64 (copy), CameraController (ref)
        u64:_VerifySubject();
        CameraController.CameraState:SetCustomFreecamEnabled(false);
        CameraController:SetDuelSubject(u64.CurrentDuelSubject);
    end);
    RunService:BindToRenderStep("SpectateController", Enum.RenderPriority.Camera.Value + 1, function(p65) -- Line: 520
        -- upvalues: u64 (copy)
        u64:Update(p65);
    end);
    UserInputService.InputBegan:Connect(function(p66, p67) -- Line: 524
        -- upvalues: CameraController (ref), u64 (copy)
        if p67 then
            return;
        end;

        if CameraController:GetPublicState() == CameraController.CameraState.States.ThirdPersonUnlockedMouse and p66.UserInputType == Enum.UserInputType.MouseButton2 then
            u64._process_mb2_on_input_ended_delta = 0;

            return;
        end;

        u64:_ProcessInput(p66);
    end);
    UserInputService.InputChanged:Connect(function(p68, p69) -- Line: 537
        -- upvalues: u64 (copy)
        if not u64._process_mb2_on_input_ended_delta or p68.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        local v70 = u64;
        v70._process_mb2_on_input_ended_delta = v70._process_mb2_on_input_ended_delta + Vector2.new(p68.Delta.X, p68.Delta.Y).Magnitude;
    end);
    UserInputService.InputEnded:Connect(function(p71, p72) -- Line: 545
        -- upvalues: u64 (copy)
        local _process_mb2_on_input_ended_delta = u64._process_mb2_on_input_ended_delta;

        if not _process_mb2_on_input_ended_delta or p71.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return;
        end;

        u64._process_mb2_on_input_ended_delta = nil;

        if _process_mb2_on_input_ended_delta > 5 then
            return;
        end;

        u64:_ProcessInput(p71);
    end);
    local function fighter_added(p73)
        if not p73.IsLocalPlayer then
            return;
        end;

        p73.EntityAdded:Connect(function()
            u64:_VerifySubject();
        end);
        p73.EntityRemoved:Connect(function()
            u64:_VerifySubject();
        end);
        p73.Died:Connect(function()
            u64:_VerifySubject();
        end);
        u64:_AddSubject(p73);
    end;

    FighterController.ObjectAdded:Connect(fighter_added);
    -- The local fighter may have been replicated before this controller started.
    for _, v in pairs(FighterController.Objects) do
        fighter_added(v);
    end;
    FighterController.ObjectRemoved:Connect(function(p74) -- Line: 581
        -- upvalues: u64 (copy)
        u64:_RemoveSubject(p74);
    end);
    DuelController.LocalPlayerJoinedDuel:Connect(function(p75, p76) -- Line: 585
        -- upvalues: u64 (copy)
        u64:SpectateDuelRequest(p75);
    end);
    DuelController.LocalPlayerLeftDuel:Connect(function(p77, p78) -- Line: 589
        -- upvalues: u64 (copy)
        u64:SpectateDuelRequest(nil);
    end);
    DuelController.ObjectRemoved:Connect(function(p79) -- Line: 593
        -- upvalues: u64 (copy)
        if u64.CurrentDuelSubject == p79 then
            u64:SpectateDuelRequest(nil);
        end;
    end);
    CameraController.CustomFreecamStateChanged:Connect(function() -- Line: 599
        -- upvalues: u64 (copy)
        u64:_VerifySubject();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 603
        -- upvalues: Teleporting (ref), u64 (copy)
        if Teleporting.Enabled then
            u64:SpectateDuelRequest(nil);
        end;
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 609
        -- upvalues: Queue (ref), u64 (copy)
        if Queue:IsVisible() then
            u64:SpectateDuelRequest(nil);
        end;
    end);
    u64:_VerifySubject();
    task.spawn(u64._HookLocalFighter, u64);
    task.spawn(u64._SpectatingReplicationLoop, u64);
end;

return u1._new();