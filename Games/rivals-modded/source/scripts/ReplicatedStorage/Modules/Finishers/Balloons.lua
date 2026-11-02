-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Finisher = require(ReplicatedStorage.Modules.Finisher);
require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayServer(p4) -- Line: 24
    -- upvalues: CONSTANTS (copy)
    p4:_AnchorModel(0, false);
    p4:_Ragdoll();
    local v5 = {};

    for _, v in pairs(p4:_GetObjects()) do
        if v:IsA("BasePart") and (v.Name ~= "Head" and v.Name ~= "UpperTorso") then
            table.insert(v5, v);
        end;
    end;

    local v6 = v5[math.random(#v5)];

    if not v6 then
        return;
    end;

    p4:CreateSound("rbxassetid://130365736768706", 1.25, 1, nil, true, 5);
    p4:CreateSound("rbxassetid://95957584341529", 1.25, 2 + 0.25 * math.random(), nil, true, 5);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v6;
    table.insert(p4._destroy_these, Attachment);

    for i = 1, 3 do
        local v7 = Random.new():NextUnitVector() * Vector3.new(1, 0, 1);
        local v8 = script.Balloon:Clone();
        v8.Color = Color3.fromHSV(math.random(), 1, 1);
        v8.CFrame = v6.CFrame + Vector3.new(0, 4, 0) + v7 * 2;
        v8.RopeConstraint.Attachment1 = Attachment;
        v8.Parent = v6;
        table.insert(p4._destroy_these, v8);

        if CONSTANTS.IS_SERVER then
            v8:SetNetworkOwner(nil);
        end;

        wait(0.1);
        local _ = i;
    end;
end;

function u1._Init(p9) -- Line: 71
end;

return u1;