-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = game:GetService("ServerScriptService");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = script.Name;
local v10 = v8.new();
v7.OnStart = function(_) --[[ Line: 18 ]] --[[ Name: OnStart ]]

end;
v7.OnStop = function(_) --[[ Line: 22 ]] --[[ Name: OnStop ]]
    -- upvalues: v10 (copy)
    v10:Destroy();
end;
v7.OnLoad = function(_) --[[ Line: 26 ]] --[[ Name: OnLoad ]]

end;
return v7;