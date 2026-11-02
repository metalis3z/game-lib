-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ArcadeController);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 13
    -- upvalues: LobbyElement (copy), u1 (copy), Signal (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._update_garage_doors_internal = Signal.new();
    v3:_Init();

    return v3;
end;

function u1._DoorAdded(u4, u5) -- Line: 33
    -- upvalues: CONSTANTS (copy), ArcadeController (copy), Players (copy)
    local Door = u5:WaitForChild("Door");
    local ArcadePortal = u5:WaitForChild("ArcadePortal");

    if CONSTANTS.QUEUES_ACTIVE then
        task.defer(ArcadePortal.Destroy, ArcadePortal);

        return;
    end;

    local Portal = ArcadePortal:WaitForChild("Portal");
    local Hitbox = Portal:WaitForChild("Hitbox");
    Portal:PivotTo(ArcadePortal:WaitForChild("Anchor").CFrame);
    local UnanchorMe = Portal:WaitForChild("Model"):WaitForChild("UnanchorMe");
    local v6 = UnanchorMe:Clone();
    v6:PivotTo(UnanchorMe:GetPivot());
    v6.Parent = UnanchorMe.Parent;
    UnanchorMe.Parent = nil;

    for _, descendant in pairs(v6:GetDescendants()) do
        if descendant:IsA("BasePart") and not descendant:HasTag("DontUnanchorMe") then
            descendant.Anchored = false;
        end;
    end;

    u4._update_garage_doors_internal:Connect(function() -- Line: 59, Name: update
        -- upvalues: ArcadeController (ref), Door (copy), u4 (copy), ArcadePortal (copy), u5 (copy)
        local v7 = ArcadeController.CurrentDuel and ArcadeController.CurrentDuel:Get("Status") ~= "GameOver";
        Door:PivotTo(u4:_GetOriginalPivot(Door) + (v7 and Vector3.new(0, 0, 0) or Vector3.new(0, -21.75, 0)));
        ArcadePortal.Parent = v7 and u5 or nil;
    end);
    local v8 = ArcadeController.CurrentDuel and ArcadeController.CurrentDuel:Get("Status") ~= "GameOver";
    Door:PivotTo(u4:_GetOriginalPivot(Door) + (v8 and Vector3.new(0, 0, 0) or Vector3.new(0, -21.75, 0)));
    ArcadePortal.Parent = v8 and u5 and u5 or nil;
    Hitbox.Touched:Connect(function(p9) -- Line: 70
        -- upvalues: Players (ref), ArcadeController (ref)
        if Players:GetPlayerFromCharacter(p9.Parent) == Players.LocalPlayer then
            ArcadeController:Join();
        end;
    end);
end;

function u1._ClientDuelAdded(u10, p11) -- Line: 77
    p11:GetDataChangedSignal("Status"):Connect(function() -- Line: 78
        -- upvalues: u10 (copy)
        u10._update_garage_doors_internal:Fire();
    end);
    u10._update_garage_doors_internal:Fire();
end;

function u1._Init(u12) -- Line: 85
    -- upvalues: CollectionService (copy), ArcadeController (copy)
    CollectionService:GetInstanceAddedSignal("LobbyDuelsGarageDoor"):Connect(function(p13) -- Line: 86
        -- upvalues: u12 (copy)
        u12:_DoorAdded(p13);
    end);
    ArcadeController.DuelSet:Connect(function(p14) -- Line: 90
        -- upvalues: ArcadeController (ref), u12 (copy)
        if ArcadeController.CurrentDuel then
            u12:_ClientDuelAdded(p14);

            return;
        end;

        u12._update_garage_doors_internal:Fire();
    end);

    if ArcadeController.CurrentDuel then
        task.defer(u12._ClientDuelAdded, u12, ArcadeController.CurrentDuel);
    end;

    for _, v in pairs(CollectionService:GetTagged("LobbyDuelsGarageDoor")) do
        task.defer(u12._DoorAdded, u12, v);
    end;
end;

return u1._new();