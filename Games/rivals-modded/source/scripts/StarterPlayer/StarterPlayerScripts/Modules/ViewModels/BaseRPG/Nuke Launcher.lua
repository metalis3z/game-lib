-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FunctionsController = require(Players.LocalPlayer.PlayerScripts.Controllers.FunctionsController);
local BaseRPG = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRPG);
local u1 = setmetatable({}, BaseRPG);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: BaseRPG (copy), u1 (copy)
    local v2 = BaseRPG.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ExplosionEffect(p4, p5, p6) -- Line: 21
    -- upvalues: FunctionsController (copy)
    FunctionsController:FireAsync(p4:ToEnum("NukeEffect"), p5, p6, nil, true);
end;

function u1._Init(p7) -- Line: 29
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("Rocket"):WaitForChild("Head"));
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("Rocket"):WaitForChild("Neck"));
end;

return u1;