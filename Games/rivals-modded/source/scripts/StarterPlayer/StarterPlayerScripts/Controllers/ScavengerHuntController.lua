-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ScavengerHuntLibrary = require(ReplicatedStorage.Modules.ScavengerHuntLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local CollectEffect = require(Players.LocalPlayer.PlayerScripts.Modules.Functions.CollectEffect);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 14
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._collected = {};
    v2:_Init();

    return v2;
end;

function u1._UpdateObject(p3, p4, p5) -- Line: 34
    -- upvalues: ScavengerHuntLibrary (copy), PlayerDataController (copy), CollectEffect (copy), CameraController (copy), CONSTANTS (copy)
    if p3._collected[p4] then
        return;
    end;

    local Attribute = p4:GetAttribute("ScavengerHuntName");
    local v6 = ScavengerHuntLibrary.Info[Attribute];
    local v7 = PlayerDataController:Get("ScavengerHunts")[Attribute];

    if v7 and table.find(v7, p4:GetAttribute("ObjectName")) then
        p3._collected[p4] = true;
        task.defer(p4.Destroy, p4);

        if not p5 then
            CollectEffect(p4:GetPivot().Position, v6.Color, "rbxassetid://129198689909472");
        end;

        return;
    end;

    local v8;

    if CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam then
        v8 = true;
    else
        v8 = CONSTANTS.IS_PRIVATE_HUB_SERVER and not v6.AllowedInPrivateServers;
    end;

    local v9 = v8 and 1 or 0;

    for _, descendant in pairs(p4:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("ParticleEmitter") then
            descendant.LocalTransparencyModifier = v9;
        end;
    end;
end;

function u1._UpdateAllObjects(p10, p11) -- Line: 66
    -- upvalues: CollectionService (copy)
    for _, v in pairs(CollectionService:GetTagged("ScavengerHunt")) do
        task.defer(p10._UpdateObject, p10, v, p11);
    end;
end;

function u1._Init(u12) -- Line: 72
    -- upvalues: PlayerDataController (copy), CollectionService (copy), CameraController (copy)
    PlayerDataController:GetDataChangedSignal("ScavengerHunts"):Connect(function() -- Line: 73
        -- upvalues: u12 (copy)
        u12:_UpdateAllObjects();
    end);
    CollectionService:GetInstanceAddedSignal("ScavengerHunt"):Connect(function(p13) -- Line: 77
        -- upvalues: u12 (copy)
        u12:_UpdateObject(p13, true);
    end);
    CameraController.CustomFreecamStateChanged:Connect(function() -- Line: 81
        -- upvalues: u12 (copy)
        u12:_UpdateAllObjects();
    end);
    u12:_UpdateAllObjects(true);
end;

return u1._new();