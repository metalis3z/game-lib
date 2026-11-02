-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local RotatingQueueLibrary = require(ReplicatedStorage.Modules.RotatingQueueLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local SendChat = require(Players.LocalPlayer.PlayerScripts.Modules.Functions.SendChat);
local RotatingQueueHolograms = Players.LocalPlayer.PlayerScripts.Assets.RotatingQueueHolograms;
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 20
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.DuelSet = Signal.new();
    v2.UpdateJoinCooldown = Signal.new();
    v2.CurrentDuel = nil;
    v2._local_fighter = nil;
    v2._has_joined_arcade_duel = false;
    v2._hologram_loop_thread = nil;
    v2._rotating_queue_hologram = nil;
    v2._join_cooldown_hash = 0;
    v2:_Init();

    return v2;
end;

function u1.GetJoinCooldown(p3) -- Line: 43
    local v4 = p3._local_fighter and p3._local_fighter:GetJoinCooldown() or 0;

    return math.ceil(v4);
end;

function u1.CanJoin(p5) -- Line: 47
    local CurrentDuel = p5.CurrentDuel;

    if CurrentDuel then
        if p5.CurrentDuel:Get("Status") == "GameOver" then
            CurrentDuel = false;
        else
            CurrentDuel = p5:GetJoinCooldown() <= 0;
        end;
    end;

    return CurrentDuel;
end;

function u1.ToArcadeServer(p6, p7) -- Line: 51
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage.Remotes.Arcade.TeleportToArcadeServer:InvokeServer(p7);
end;

function u1.Join(p8) -- Line: 55
    -- upvalues: ReplicatedStorage (copy)
    p8._has_joined_arcade_duel = true;
    ReplicatedStorage.Remotes.Arcade.Join:FireServer();
end;

function u1._UpdateHologram(p9, p10) -- Line: 64
    -- upvalues: CollectionService (copy), RotatingQueueHolograms (copy), RotatingQueueLibrary (copy), SendChat (copy), Utility (copy)
    if p9._rotating_queue_hologram then
        p9._rotating_queue_hologram:Destroy();
        p9._rotating_queue_hologram = nil;
    end;

    local u11 = CollectionService:GetTagged("LobbyRotatingQueueHologram")[1];

    if not u11 then
        return;
    end;

    task.defer(function() -- Line: 76
        -- upvalues: u11 (copy)
        local DELETE_AT_RUNTIME = u11:WaitForChild("DELETE_AT_RUNTIME", 2);

        if DELETE_AT_RUNTIME then
            task.defer(DELETE_AT_RUNTIME.Destroy, DELETE_AT_RUNTIME);
        end;
    end);
    local Primary = u11:WaitForChild("Primary");
    local Particles = u11:WaitForChild("Particles");
    local Emit = Particles:WaitForChild("Emit");
    local Attachment = Particles:WaitForChild("Attachment");
    u11:WaitForChild("Prompt"):WaitForChild("ProximityPrompt").ObjectText = "Limited Time";
    p9._rotating_queue_hologram = (RotatingQueueHolograms:FindFirstChild(RotatingQueueLibrary:GetCurrent().Name) or RotatingQueueHolograms.Default):Clone();
    p9._rotating_queue_hologram:PivotTo(Primary.CFrame);
    p9._rotating_queue_hologram.Name = "_hologram";
    p9._rotating_queue_hologram.Parent = u11;

    if p10 then
        SendChat({
            Text = "[SERVER] New gamemodes are here! Open the PLAY page now! 🎉",
            Color = Color3.fromRGB(100, 255, 50)
        });
        Utility:PlayParticles(Emit);
        Utility:CreateSound("rbxassetid://120776960987657", 0.75, 1, Particles, true, 15);
        Utility:CreateSound("rbxassetid://75616400922980", 1, 1, Particles, true, 15);

        for _, child in pairs(Attachment:GetChildren()) do
            child.Enabled = true;
        end;

        task.delay(10, function() -- Line: 110
            -- upvalues: Attachment (copy)
            for _, child in pairs(Attachment:GetChildren()) do
                child.Enabled = false;
            end;
        end);
    end;
end;

function u1._UpdateHologramLoop(u12) -- Line: 118
    -- upvalues: RotatingQueueLibrary (copy)
    local v13 = u12._local_fighter and not u12._local_fighter:Get("IsInDuel") and not u12._local_fighter:Get("IsInShootingRange");

    if v13 then
        if not u12._hologram_loop_thread then
            u12._hologram_loop_thread = task.spawn(function() -- Line: 128
                -- upvalues: u12 (copy), RotatingQueueLibrary (ref)
                u12:_UpdateHologram();

                while true do
                    wait(RotatingQueueLibrary:GetTimeUntilNext() + 1);
                    u12:_UpdateHologram(true);
                end;
            end);
        end;
    elseif u12._hologram_loop_thread then
        task.cancel(u12._hologram_loop_thread);
        u12._hologram_loop_thread = nil;
    end;
end;

function u1._UpdateJoinCooldown(p14) -- Line: 140
    p14._join_cooldown_hash = p14._join_cooldown_hash + 1;
    local _join_cooldown_hash = p14._join_cooldown_hash;
    local JoinCooldown = p14._local_fighter:GetJoinCooldown();
    local v15 = tick() + JoinCooldown;
    p14.UpdateJoinCooldown:Fire();

    for i = 1, JoinCooldown do
        wait(1);
        p14.UpdateJoinCooldown:Fire();

        if p14._join_cooldown_hash ~= _join_cooldown_hash then
            return;
        end;

        local _ = i;
    end;

    wait(v15 - tick());

    if p14._join_cooldown_hash ~= _join_cooldown_hash then
        return;
    end;

    p14.UpdateJoinCooldown:Fire();
end;

function u1._HookLocalFighter(u16) -- Line: 167
    -- upvalues: FighterController (copy)
    u16._local_fighter = FighterController:WaitForLocalFighter();
    u16._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 170
        -- upvalues: u16 (copy)
        u16:_UpdateHologramLoop();
    end);
    u16._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 174
        -- upvalues: u16 (copy)
        u16:_UpdateHologramLoop();
    end);
    u16._local_fighter:GetDataChangedSignal("JoinCooldown"):Connect(function() -- Line: 178
        -- upvalues: u16 (copy)
        u16:_UpdateJoinCooldown();
    end);
    task.defer(u16._UpdateHologramLoop, u16);
    task.defer(u16._UpdateJoinCooldown, u16);
end;

function u1._DuelRemoved(p17, p18) -- Line: 186
    if p17.CurrentDuel == p18 then
        p17.CurrentDuel = nil;
        p17.DuelSet:Fire(p18);
    end;
end;

function u1._DuelAdded(u19, u20) -- Line: 193
    u20:GetDataChangedSignal("IsCurrentArcadeDuel"):Connect(function() -- Line: 194, Name: check_is_arcade_duel
        -- upvalues: u20 (copy), u19 (copy)
        if u20:Get("IsCurrentArcadeDuel") then
            u19.CurrentDuel = u20;
            u19.DuelSet:Fire(u20);
        end;
    end);

    if u20:Get("IsCurrentArcadeDuel") then
        u19.CurrentDuel = u20;
        u19.DuelSet:Fire(u20);
    end;
end;

function u1._PromptAdded(p21, p22) -- Line: 205
    -- upvalues: CONSTANTS (copy), ReplicatedStorage (copy), DuelLibrary (copy)
    if not CONSTANTS.IS_ARCADE_SERVER then
        return;
    end;

    p22:RemoveTag("LobbyOpenPagePrompt");
    p22.Triggered:Connect(function() -- Line: 212
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Matchmaking.BackToHub:FireServer();
    end);
    p22.ObjectText = DuelLibrary.ArcadeModeByPlaceID[tostring(CONSTANTS.PLACE_ID)].DisplayName;
    p22.ActionText = "Leave";
end;

function u1._Init(u23) -- Line: 220
    -- upvalues: FighterController (copy), CONSTANTS (copy), SpectateController (copy), DuelController (copy), CollectionService (copy)
    u23.DuelSet:Connect(function(p24) -- Line: 221
        -- upvalues: u23 (copy), FighterController (ref), CONSTANTS (ref), SpectateController (ref)
        p24:GetDataChangedSignal("Status"):Connect(function() -- Line: 222
            -- upvalues: u23 (ref)
            u23.UpdateJoinCooldown:Fire();
        end);
        u23.UpdateJoinCooldown:Fire();

        if not FighterController.LocalFighter or (FighterController.LocalFighter:Get("IsInDuel") or FighterController.LocalFighter:Get("IsInShootingRange")) then
            return;
        end;

        if CONSTANTS.IS_ARCADE_SERVER and not (u23._has_joined_arcade_duel or (#p24.Duelers < 3 or p24:Get("Status") == "Voting")) then
            SpectateController:SpectateDuelRequest(p24);

            return;
        end;

        u23:Join();
    end);
    DuelController.ObjectAdded:Connect(function(p25) -- Line: 239
        -- upvalues: u23 (copy)
        u23:_DuelAdded(p25);
    end);
    DuelController.ObjectRemoved:Connect(function(p26) -- Line: 243
        -- upvalues: u23 (copy)
        u23:_DuelRemoved(p26);
    end);
    CollectionService:GetInstanceAddedSignal("LobbyRotatingQueueHologram"):Connect(function(p27) -- Line: 247
        -- upvalues: u23 (copy)
        u23:_UpdateHologram(p27);
    end);
    CollectionService:GetInstanceAddedSignal("LobbyArcadePrompt"):Connect(function(p28) -- Line: 251
        -- upvalues: u23 (copy)
        u23:_PromptAdded(p28);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyArcadePrompt")) do
        task.defer(u23._PromptAdded, u23, v);
    end;

    for _, v in pairs(DuelController.Objects) do
        task.defer(u23._DuelAdded, u23, v);
    end;

    task.defer(u23._HookLocalFighter, u23);
end;

return u1._new();