-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Utility);
require(ReplicatedStorage.Modules.Spring);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local SmokeCloud = require(Players.LocalPlayer.PlayerScripts.Modules.SmokeCloud);
Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("SmokeClouds");
local SmokeClouds = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SmokeClouds");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._smoke_clouds = {};
    v2:_Init();

    return v2;
end;

function u1.Update(p3, p4) -- Line: 31
    -- upvalues: SpectateController (copy)
    local v5 = {};

    for i, v in pairs(p3._smoke_clouds) do
        if v:IsDestroyed() then
            v5[i] = true;
        elseif SpectateController:IsRendered(v.EnvironmentID) then
            v:Update(p4);
        end;
    end;

    for i in pairs(v5) do
        p3._smoke_clouds[i] = nil;
    end;
end;

function u1._ObjectRemoved(p6, p7) -- Line: 56
    local v8 = p6._smoke_clouds[p7];

    if not v8 then
        return;
    end;

    v8:Clear();
end;

function u1._ObjectAdded(p9, p10) -- Line: 66
    -- upvalues: SmokeClouds (copy), SmokeCloud (copy)
    if p9._smoke_clouds[p10] then
        p9._smoke_clouds[p10]:Destroy();
        p9._smoke_clouds[p10] = nil;
    end;

    p9._smoke_clouds[p10] = (SmokeClouds:FindFirstChild(p10.Name) and require(SmokeClouds[p10.Name]) or SmokeCloud).new(p10);
    p9._smoke_clouds[p10].Model.Parent = workspace;
    p9:Update(0);
end;

function u1._Init(u11) -- Line: 78
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("SmokeCloud"):Connect(function(p12) -- Line: 79
        -- upvalues: u11 (copy)
        u11:_ObjectRemoved(p12);
    end);
    CollectionService:GetInstanceAddedSignal("SmokeCloud"):Connect(function(p13) -- Line: 83
        -- upvalues: u11 (copy)
        u11:_ObjectAdded(p13);
    end);

    for _, v in pairs(CollectionService:GetTagged("SmokeCloud")) do
        task.spawn(u11._ObjectAdded, u11, v);
    end;
end;

return u1._new();