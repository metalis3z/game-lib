-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Sniper = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels:WaitForChild("Sniper"));
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(198, 99, 255));
local u1 = setmetatable({}, Sniper);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Sniper (copy), u1 (copy)
    local v2 = Sniper.new(...);
    local v3 = setmetatable(v2, u1);
    v3._reload_start_attachment = v3.ItemModel:WaitForChild("Body"):WaitForChild("Black"):WaitForChild("Start");
    v3._reload_finish_attachment = v3.ItemModel:WaitForChild("Body"):WaitForChild("Black"):WaitForChild("Finish");
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 27
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.PlayReloadStartParticles(p5) -- Line: 31
    -- upvalues: Utility (copy)
    Utility:PlayParticles(p5._reload_start_attachment);
end;

function u1.PlayReloadFinishParticles(p6) -- Line: 35
    -- upvalues: Utility (copy)
    Utility:PlayParticles(p6._reload_finish_attachment);
end;

function u1._Init(p7) -- Line: 43
end;

return u1;