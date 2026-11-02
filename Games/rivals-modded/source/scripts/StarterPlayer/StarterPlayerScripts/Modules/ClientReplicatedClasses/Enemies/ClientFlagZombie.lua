-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local FlagZombieEmpoweredEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc.FlagZombieEmpoweredEffect;
local ZombieFlag = Players.LocalPlayer.PlayerScripts.Assets.Misc.ZombieFlag;
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientEnemy (copy), u1 (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3._dropped_flags = {};
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 28
    -- upvalues: ZombieFlag (copy), BetterDebris (copy), Utility (copy), FlagZombieEmpoweredEffect (copy), ClientEnemy (copy)
    if p5 == "DropFlagEffect" then
        if not p4:IsRendered() then
            return;
        end;

        local v6, v7 = ...;
        local u8 = ZombieFlag:Clone();
        u8:PivotTo(CFrame.new(v6) * CFrame.Angles(0, 6.283185307179586 * math.random(), 0));
        u8.Parent = workspace;
        BetterDebris:AddItem(u8, 30);

        for _, descendant in pairs(u8.Effect:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                Utility:ScaleParticleEmitter(descendant, v7 / 25);
            end;
        end;

        task.spawn(function() -- Line: 47
            -- upvalues: Utility (ref), u8 (copy)
            for i = 1, 3 do
                Utility:PlayParticles(u8);
                wait(0.25);
                local _ = i;
            end;
        end);
        Utility:CreateSound("rbxassetid://98975031346830", 1, 0.9 + 0.2 * math.random(), u8.PrimaryPart, true, 10);
        local Pivot = u8:GetPivot();
        local CFrame_Angles_ret = CFrame.Angles(6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random());
        local Scale = u8:GetScale();
        local u9 = Scale * 0.5;
        local Effect = u8.Effect;
        Utility:RenderstepForLoop(0, 100, 2, function(p10) -- Line: 64
            -- upvalues: u8 (copy), u9 (copy), Scale (copy), Pivot (copy), CFrame_Angles_ret (copy), Effect (copy)
            local v11 = 1 - (1 - p10 / 100) ^ 3;
            u8:ScaleTo(u9 + (Scale - u9) * v11);
            u8:PivotTo(Pivot * CFrame.Angles(0, 0 + 9.42477796076938 * v11, 0) * CFrame_Angles_ret:Lerp(CFrame.identity, v11));
            Effect.CFrame = CFrame.new(Effect.Position);
        end);
        wait(15);
        Utility:RenderstepForLoop(0, 100, 1, function(p12) -- Line: 74
            -- upvalues: u8 (copy)
            local v13 = (p12 / 100) ^ 3;

            for _, descendant in pairs(u8:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.LocalTransparencyModifier = v13;
                end;
            end;
        end);
        u8:Destroy();

        return;
    end;

    if p5 ~= "EmpowerOtherEntityEffect" then
        ClientEnemy.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    local v14, v15 = ...;

    if not v14 then
        return;
    end;

    wait(1 * math.random());
    Utility:CreateSound("rbxassetid://104302486797762", 0.5 + 0.5 * math.random(), 0.75 + 0.5 * math.random(), v14, true, 10);
    local v16 = FlagZombieEmpoweredEffect:Clone();
    v16.CFrame = v14.CFrame * CFrame.new(0, -2, 0);
    v16.Parent = v14;
    BetterDebris:AddItem(v16, v15 + 10);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v14;
    WeldConstraint.Part1 = v16;
    WeldConstraint.Parent = v16;
    wait(v15);

    for _, descendant in pairs(v16:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    wait(3);
    v16:Destroy();
end;

function u1.Destroy(p17) -- Line: 126
    -- upvalues: ClientEnemy (copy)
    for _, v in pairs(p17._dropped_flags) do
        v:Destroy();
    end;

    ClientEnemy.Destroy(p17);
end;

function u1._Init(p18) -- Line: 138
end;

return u1;