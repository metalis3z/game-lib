-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Throwable = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Throwable);
local u1 = setmetatable({}, Throwable);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Throwable (copy), u1 (copy)
    local v2 = Throwable.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 22
    -- upvalues: Throwable (copy)
    if p5 ~= "MolotovExplode" then
        Throwable.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    p4.ViewModel:ExplosionEffect(..., p4.Info.FireRadius);
end;

function u1._Init(p6) -- Line: 40
    -- upvalues: Utility (copy)
    p6.ProjectileThrown:Connect(function(p7, p8) -- Line: 41
        -- upvalues: Utility (ref)
        Utility:CreateSound("rbxassetid://14812827928", 1, 1, p7, true, 10);
    end);
end;

return u1;