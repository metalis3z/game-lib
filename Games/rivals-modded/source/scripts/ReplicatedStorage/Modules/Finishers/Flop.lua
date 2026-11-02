-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Modules.BetterDebris);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = { "rbxassetid://88375867455898", "rbxassetid://79484939092852", "rbxassetid://107671189154511" };
local u2 = setmetatable({}, Ragdoll);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: Ragdoll (copy), u2 (copy)
    local v3 = Ragdoll.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(u5, ...) -- Line: 25
    -- upvalues: Ragdoll (copy), Utility (copy), u1 (copy)
    Ragdoll.PlayServer(u5, ...);

    if not u5._is_humanoid then
        return;
    end;

    u5:_InternalThread(task.spawn, function() -- Line: 32
        -- upvalues: u5 (copy), Utility (ref), u1 (ref)
        while true do
            wait(0.25);

            if u5._destroyed then
                break;
            end;

            Utility:Knockback(u5._subject.RootPart, Vector3.new(0, 20, 0));
            u5:CreateSound(u1[math.random(#u1)], 1.25, 1 + 0.1 * math.random(), nil, true, 5);
            wait(0.5);

            if u5._destroyed then
                return;
            end;
        end;
    end);
end;

function u2._Init(p6) -- Line: 56
end;

return u2;