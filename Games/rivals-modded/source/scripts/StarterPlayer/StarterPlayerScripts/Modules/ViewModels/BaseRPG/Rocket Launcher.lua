-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local BaseRPG = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRPG);
local u1 = setmetatable({}, BaseRPG);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: BaseRPG (copy), u1 (copy)
    local v2 = BaseRPG.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 23
    -- upvalues: BetterDebris (copy), Utility (copy)
    local Explosion = Instance.new("Explosion");
    Explosion.BlastRadius = p6;
    Explosion.BlastPressure = 0;
    Explosion.ExplosionType = Enum.ExplosionType.NoCraters;
    Explosion.Position = p5;
    Explosion.Parent = workspace;
    BetterDebris:AddItem(Explosion, 5);
    Utility:CreateSound("rbxasset://sounds/collide.wav", 0.5, 0.9 + 0.2 * math.random(), p5, true, 10);
end;

function u1._Init(u7) -- Line: 39
    -- upvalues: Utility (copy)
    task.defer(function() -- Line: 40
        -- upvalues: u7 (copy), Utility (ref)
        u7.ClientItem.ProjectileShot:Connect(function(p8, p9) -- Line: 41
            -- upvalues: Utility (ref)
            local v10 = Utility:CreateSound("rbxasset://sounds/Rocket whoosh 01.wav", 0.5, 1, p9.Part, true);
            p9:GetAttributeChangedSignal("Destroying"):Wait();
            v10:Destroy();
        end);
    end);
    u7:_RegisterAmmoVisual(u7.ItemModel:WaitForChild("Rocket"):WaitForChild("Part"));
end;

return u1;