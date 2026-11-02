-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Finisher);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Finisher (copy), u1 (copy)
    local v2 = Finisher.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4) -- Line: 21
    -- upvalues: Utility (copy)
    p4:_HideBody();
    local v5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;

    if not v5 then
        return;
    end;

    local v6 = script.Particles.Attachment:Clone();
    v6.Parent = v5;
    table.insert(p4._destroy_these, v6);
    Utility:PlayParticles(v6);
    p4:CreateSound("rbxassetid://130069209812509", 1, 1 + 0.1 * math.random(), nil, true, 5);
    p4:CreateSound("rbxassetid://82341777410026", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
    p4:CreateSound("rbxassetid://74282442822962", 1, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p7) -- Line: 44
end;

return u1;