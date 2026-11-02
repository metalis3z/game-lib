-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 27
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(nil, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3._illuminas = {};
    v3._illumina_anchor = v3._humanoid.RootPart;
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 42
    -- upvalues: Emote (copy), RunService (copy)
    Emote.PlayClient(u4, ...);
    u4:_PlayAnimation("rbxassetid://77038993402535", nil, nil, 0.5);

    if not u4._illumina_anchor then
        return;
    end;

    local u5 = u4:_IsWorkspaceEmote() and 0.5 or 0.125;

    for _, v in pairs({ "RightHand", "LeftHand" }) do
        local v6 = u4._humanoid.Parent and u4._humanoid.Parent:FindFirstChild(v);

        if v6 then
            local v7 = script.IlluminaHand:Clone();
            v7:PivotTo(v6.CFrame);
            v7.Parent = v6;
            table.insert(u4._destroy_these, v7);
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v6;
            WeldConstraint.Part1 = v7;
            WeldConstraint.Parent = v7;
        end;
    end;

    local v8 = script.IlluminaLight:Clone();
    v8.Parent = u4._illumina_anchor;
    table.insert(u4._destroy_these, v8);
    local v9 = script.IlluminaSparkles:Clone();
    v9.Parent = u4._illumina_anchor;
    table.insert(u4._destroy_these, v9);

    local function new_illumina() -- Line: 79
        -- upvalues: u4 (copy)
        local v10 = script.Illumina:Clone();
        v10.Name = "_Illumina";
        v10.Parent = u4._illumina_anchor.Parent;
        local v11 = -2 + 12 * math.random();
        local _illuminas = u4._illuminas;
        local v12 = {
            Object = v10,
            Start = tick(),
            Rad = math.random() * 3.141592653589793 * 2,
            Lifetime = 2 + 4 * math.random(),
            Speed = (1 + 6 * math.random()) * 2,
            Spin = Random.new():NextUnitVector() * (1 + 9 * math.random()),
            Height = v11,
            Spacing = 4 + 2 * math.random() + v11 / 2
        };
        table.insert(_illuminas, v12);
    end;

    for i = 1, u5 * 20 do
        new_illumina();
        local _ = i;
    end;

    local u13 = tick();
    local u14 = 0;
    local u15 = 0;
    table.insert(u4._connections, RunService.RenderStepped:Connect(function(p16) -- Line: 106
        -- upvalues: u14 (ref), u5 (copy), new_illumina (copy), u15 (ref), u13 (copy), u4 (copy)
        if u14 <= tick() then
            u14 = tick() + 0.1 / u5;
            new_illumina();
        end;

        if u15 <= tick() then
            u15 = tick() + 0.05 + 0.15 * math.random();
            local v17 = 1 + (tick() - u13) * 0.1;
            u4:CreateSound("rbxassetid://114436319908436", (0.25 + 0.5 * math.random()) / v17, 0.875 + 0.25 * math.random(), nil, true, 5);
        end;

        for i = #u4._illuminas, 1, -1 do
            local v18 = u4._illuminas[i];

            if tick() > v18.Start + v18.Lifetime then
                v18.Object:Destroy();
                table.remove(u4._illuminas, i);
            end;

            v18.Rad = v18.Rad - p16 * v18.Speed;
            local Object = v18.Object;
            local v19;

            if tick() - v18.Start < 0.5 then
                local v20 = (tick() - v18.Start) / 0.5;
                v19 = 1 - math.clamp(v20, 0, 1);
            elseif tick() > v18.Start + v18.Lifetime - 0.5 then
                local v21 = (tick() - (v18.Start + v18.Lifetime - 0.5)) / 0.5;
                v19 = math.clamp(v21, 0, 1);
            else
                v19 = 0;
            end;

            Object.Transparency = v19;
            v18.Object.CFrame = CFrame.new(u4._illumina_anchor.Position) * CFrame.new(math.sin(v18.Rad) * v18.Spacing, v18.Height, math.cos(v18.Rad) * v18.Spacing) * v18.Object.CFrame.Rotation * CFrame.Angles(v18.Spin.X * p16, v18.Spin.Y * p16, v18.Spin.Z * p16);
            local _ = i;
        end;
    end));
end;

function u1.Destroy(p22) -- Line: 138
    -- upvalues: BetterDebris (copy), Emote (copy)
    for _, v in pairs(p22._illuminas) do
        v.Object.Anchored = false;
        v.Object.Velocity = (v.Object.Position - p22._illumina_anchor.Position).Unit * (10 + 30 * math.random());
        v.Object.RotVelocity = Random.new():NextUnitVector() * (5 + 20 * math.random());
        BetterDebris:AddItem(v.Object, 3);
    end;

    Emote.Destroy(p22);
end;

function u1._Init(p23) -- Line: 153
end;

return u1;