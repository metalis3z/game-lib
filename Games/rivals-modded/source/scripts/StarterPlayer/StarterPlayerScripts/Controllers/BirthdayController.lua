-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BirthdayLibrary = require(ReplicatedStorage.Modules.BirthdayLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1._ObjectAdded(p3, p4) -- Line: 29
    -- upvalues: PlayerDataController (copy), BirthdayLibrary (copy), ReplicatedStorage (copy)
    p4.Triggered:Connect(function() -- Line: 30
        -- upvalues: PlayerDataController (ref), BirthdayLibrary (ref), ReplicatedStorage (ref)
        if not PlayerDataController:Get("BirthdaysWitnessed")[BirthdayLibrary.CURRENT_BIRTHDAY_STRING] then
            ReplicatedStorage.Remotes.Data.TakeCake:FireServer();
        end;
    end);
end;

function u1._Init(u5) -- Line: 37
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("BirthdayCakePrompt"):Connect(function(p6) -- Line: 38
        -- upvalues: u5 (copy)
        u5:_ObjectAdded(p6);
    end);

    for _, v in pairs(CollectionService:GetTagged("BirthdayCakePrompt")) do
        task.defer(u5._ObjectAdded, u5, v);
    end;
end;

return u1._new();