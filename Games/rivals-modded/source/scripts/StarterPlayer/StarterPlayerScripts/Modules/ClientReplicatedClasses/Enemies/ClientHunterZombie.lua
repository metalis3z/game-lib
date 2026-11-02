-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExplosiveZombieExplosionEffect");
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientEnemy (copy), u1 (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 25
    -- upvalues: Utility (copy), ClientEnemy (copy)
    if p5 ~= "HunterLeapEffect" then
        ClientEnemy.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    p4:_PlayAnimation("rbxassetid://89570876299263", 0, nil, 3);
    Utility:CreateSound("rbxassetid://118467983008802", 1, 1 + 0.25 * math.random(), p4.RootPart, true, 10);
end;

function u1._Init(p6) -- Line: 42
end;

return u1;