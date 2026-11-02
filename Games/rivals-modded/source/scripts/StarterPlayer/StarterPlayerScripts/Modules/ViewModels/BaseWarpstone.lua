-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._PlayWarpstoneSounds(u4, ...) -- Line: 28
    -- upvalues: Utility (copy)
    local u5 = {};

    for _, v in pairs({ ... }) do
        u5[v] = v.Volume;
        v.Looped = true;
    end;

    Utility:RenderstepForLoop(0, 100, 2, function(p6) -- Line: 36
        -- upvalues: u4 (copy), u5 (copy)
        if u4._destroyed then
            return true;
        end;

        local v7 = p6 / 100;

        for i, v in pairs(u5) do
            i.Volume = v * v7;
        end;
    end);
end;

function u1._Init(p8) -- Line: 49
end;

return u1;