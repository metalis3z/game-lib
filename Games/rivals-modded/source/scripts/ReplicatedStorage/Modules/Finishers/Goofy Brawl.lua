-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 20
    -- upvalues: Ragdoll (copy)
    Ragdoll.PlayClient(u4, ...);
    local v5 = u4._is_humanoid and u4._subject.RootPart or u4._subject;
    local u6 = script.Particles:Clone();
    u6.CFrame = v5.CFrame;
    u6.Parent = workspace;
    table.insert(u4._destroy_these, u6);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v5;
    WeldConstraint.Part1 = u6;
    WeldConstraint.Parent = u6;
    u4:CreateSound("rbxassetid://110334213997451", 0.75, 0.95 + 0.1 * math.random(), nil, true, 10);
    u4:CreateSound("rbxassetid://85939220046386", 1, 0.95 + 0.1 * math.random(), nil, true, 10);
    local u7 = true;
    u4:_InternalThread(task.spawn, function() -- Line: 40
        -- upvalues: u7 (ref), u6 (copy), u4 (copy)
        while u7 do
            local v8 = script.Props:GetChildren()[math.random(#script.Props:GetChildren())]:Clone();
            v8:PivotTo(u6.CFrame * CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2));
            v8:ScaleTo(v8:GetScale() * (1 + 2 * math.random()));

            for _, child in pairs(v8:GetChildren()) do
                if child ~= v8.Primary then
                    local WeldConstraint2 = Instance.new("WeldConstraint");
                    WeldConstraint2.Part0 = child;
                    WeldConstraint2.Part1 = v8.Primary;
                    WeldConstraint2.Parent = v8.Primary;
                end;
            end;

            v8.Primary.Velocity = (Random.new():NextUnitVector() + Vector3.new(0, 2, 0)).Unit * (40 + 60 * math.random());
            v8.Primary.RotVelocity = Random.new():NextUnitVector() * (5 + 20 * math.random());
            v8.Parent = u6;
            table.insert(u4._destroy_these, v8);
            wait(0.1 + 0.6 * math.random());
        end;
    end);
    wait(7.5);
    u7 = false;

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;
end;

function u1._Init(p9) -- Line: 80
end;

return u1;