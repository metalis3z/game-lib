-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local FreezeRayExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("FreezeRayExplosionEffect");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(30, 225, 255));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._gauge_tickers = {};
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 28
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 32
    -- upvalues: FreezeRayExplosionEffect (copy), BetterDebris (copy), Utility (copy)
    local v8 = FreezeRayExplosionEffect:Clone();
    v8.CFrame = CFrame.new(p6);
    v8.Parent = workspace;
    BetterDebris:AddItem(v8, 5);
    Utility:CreateSound("rbxassetid://18429092842", 0.4, 1 + 0.2 * math.random(), v8, true, 10);

    for _, child in pairs(v8.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p7 / 4);
        end;
    end;

    Utility:PlayParticles(v8.Attachment);
end;

function u1._UpdateGaugeTickers(p9) -- Line: 53
    local v10 = -45 - 270 * (1 - p9.ClientItem:Get("Ammo") / p9.ClientItem.Info.MaxAmmo);

    for _, v in pairs(p9._gauge_tickers) do
        v.Rotation = v10;
    end;
end;

function u1._Setup(p11) -- Line: 61
    for _, descendant in pairs(p11.ItemModel:GetDescendants()) do
        if descendant:HasTag("PermafrostGaugeTicker") then
            table.insert(p11._gauge_tickers, descendant);
        end;
    end;
end;

function u1._Init(u12) -- Line: 69
    u12.ClientItem:GetDataChangedSignal("MaxAmmo"):Connect(function() -- Line: 70
        -- upvalues: u12 (copy)
        u12:_UpdateGaugeTickers();
    end);
    u12.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 74
        -- upvalues: u12 (copy)
        u12:_UpdateGaugeTickers();
    end);
    u12:_Setup();
    u12:_UpdateGaugeTickers();
end;

return u1;