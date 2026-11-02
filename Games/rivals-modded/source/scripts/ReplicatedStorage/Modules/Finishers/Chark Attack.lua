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

function u1.PlayServer(p4) -- Line: 21
    p4:_AnchorModel(0);
end;

function u1.PlayClient(u5, ...) -- Line: 25
    -- upvalues: Utility (copy)
    local u6 = u5._is_humanoid and u5._subject.RootPart or u5._subject;
    local u7 = script.Model:Clone();
    u7.Parent = workspace;
    table.insert(u5._destroy_these, u7);
    u5:CreateSound("rbxassetid://91581971640099", 1.5, 1, nil, true, 5);
    u5:CreateSound("rbxassetid://17812496122", 0.5, 1.25 + 0.25 * math.random(), nil, true, 5);
    u5:CreateSound("rbxassetid://17812566721", 2, 1 + 0.2 * math.random(), nil, true, 5);
    u5:_InternalThread(task.spawn, function() -- Line: 36
        -- upvalues: u5 (copy)
        wait(0.25);
        u5:CreateSound("rbxassetid://18128895977", 2, 1, nil, true, 5);
        wait(0.25);

        for _, descendant in pairs((u5._is_humanoid and u5._subject.Parent or u5._subject):GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("Decal"))) then
                descendant:Destroy();
            end;
        end;
    end);
    local u8 = (Random.new():NextUnitVector() * Vector3.new(1, 0, 1)).Unit * 30;
    local u9 = nil;
    Utility:RenderstepForLoop(0, 100, 2, function(p10) -- Line: 59
        -- upvalues: u8 (copy), u6 (copy), u9 (ref), u7 (copy)
        local v11 = p10 / 100;
        local math_sin_ret = math.sin(3.141592653589793 * v11);
        local v12;

        if v11 < 0.5 then
            v12 = u8:Lerp(Vector3.new(0, 0, 0), v11 * 2);
        else
            v12 = (Vector3.new(0, 0, 0)):Lerp(-u8, v11 * 2 - 1);
        end;

        local v13 = CFrame.new(u6.Position) + (Vector3.new(0, -30, 0)):Lerp(Vector3.new(0, 0, 0), math_sin_ret) + v12;

        if u9 and not u9:FuzzyEq(v13.Position) then
            v13 = CFrame.new(v13.Position, u9) * CFrame.Angles(1.5707963267948966, 0, 0);
        end;

        u7:PivotTo(v13);
        u9 = v13.Position;
    end);
    u7:Destroy();
end;

function u1._Init(p14) -- Line: 81
end;

return u1;