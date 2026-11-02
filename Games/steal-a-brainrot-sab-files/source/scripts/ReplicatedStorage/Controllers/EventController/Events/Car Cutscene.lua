

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
v7.OnStart = function(_)

end;
v7.OnStop = function(_)
	v10:Destroy();
end;
v7.OnLoad = function(_)

end;
return v7;