-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v4 = nil;
local v5 = {
    States = {}
};
v5.Update = function(_)
    if v4 then
        v4:SetBackpackEnabled(next(v5.States) == nil);
    end;
end;
v5.SetEnabled = function(_, v8, v9)
    v5.States[v8] = not v9 or nil;
    v5:Update();
end;
v5.Start = function(_)
    pcall(function()
        l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    end);
    v3:Wait(l_Players_0.LocalPlayer);
    v4 = require(script.Utils.Satchel);
    v5:Update();
end;
return v5;