-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("ContentProvider");
local Players = game:GetService("Players");
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ReplicatedController = require(Players.LocalPlayer.PlayerScripts.Modules.ReplicatedController);
local u1 = setmetatable({}, ReplicatedController);
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: ReplicatedController (copy), u1 (copy), Signal (copy)
    local Duel = ReplicatedController.new("Duel");
    local v2 = setmetatable(Duel, u1);
    v2.LocalPlayerJoinedOrLeftDuel = Signal.new();
    v2.LocalPlayerJoinedDuel = Signal.new();
    v2.LocalPlayerLeftDuel = Signal.new();
    v2:_Init();

    return v2;
end;

function u1.GetDuelByID(p3, p4) -- Line: 29
    for i, v in pairs(p3.Objects) do
        if v:Get("ObjectID") == p4 then
            return v, i;
        end;
    end;
end;

function u1.GetDuel(p5, p6) -- Line: 37
    for i, v in pairs(p5.Objects) do
        if v:GetDueler(p6) then
            return v, i;
        end;
    end;
end;

function u1._SetupInputs(u7) -- Line: 49
    -- upvalues: Players (copy), UserInputService (copy), InputLibrary (copy)
    local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController);
    local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
    UserInputService.InputBegan:Connect(function(p8, p9) -- Line: 53
        -- upvalues: u7 (copy), Players (ref), InputLibrary (ref), FighterController (copy), ShootingRangeController (copy)
        if p9 then
            return;
        end;

        local Duel = u7:GetDuel(Players.LocalPlayer);

        if Duel and (Duel.DuelInterface.Buttons:IsSwitchItemsVisible() and InputLibrary:InputIs(p8, "SwitchItems")) then
            Duel.DuelInterface.Buttons:SwitchItemsRequest();

            return;
        end;

        if Duel and (Duel.DuelInterface.Buttons:IsRespawnNowVisible() and InputLibrary:InputIs(p8, "Jump")) then
            Duel.DuelInterface.Buttons:RespawnNowRequest();

            return;
        end;

        if InputLibrary:InputIs(p8, "LeaveDuel") then
            if Duel then
                Duel:LeaveDuelRequest();

                return;
            end;

            if FighterController.LocalFighter and FighterController.LocalFighter:Get("IsInShootingRange") then
                ShootingRangeController:Leave();
            end;
        end;
    end);
end;

function u1._Init(u10) -- Line: 74
    -- upvalues: Players (copy)
    u10.ObjectAdded:Connect(function(u11) -- Line: 75
        -- upvalues: u10 (copy), Players (ref)
        local function check_local_dueler(u12) -- Line: 76
            -- upvalues: u11 (copy), u10 (ref)
            if not (u12 and u12.IsLocalPlayer) then
                return;
            end;

            u11.DuelerRemoved:Connect(function(p13) -- Line: 81
                -- upvalues: u12 (copy), u10 (ref), u11 (ref)
                if p13 == u12 then
                    u10.LocalPlayerLeftDuel:Fire(u11, p13);
                    u10.LocalPlayerJoinedOrLeftDuel:Fire(u11, p13);
                end;
            end);
            u10.LocalPlayerJoinedDuel:Fire(u11, u12);
            u10.LocalPlayerJoinedOrLeftDuel:Fire(u11, u12);
        end;

        u11.DuelerAdded:Connect(check_local_dueler);
        check_local_dueler(u11:GetDueler(Players.LocalPlayer));
    end);
    u10.ObjectRemoved:Connect(function(p14) -- Line: 96
        -- upvalues: Players (ref), u10 (copy)
        local Dueler = p14:GetDueler(Players.LocalPlayer);

        if not Dueler then
            return;
        end;

        u10.LocalPlayerLeftDuel:Fire(p14, Dueler);
        u10.LocalPlayerJoinedOrLeftDuel:Fire(p14, Dueler);
    end);
    task.defer(u10._SetupInputs, u10);
end;

return u1._new();