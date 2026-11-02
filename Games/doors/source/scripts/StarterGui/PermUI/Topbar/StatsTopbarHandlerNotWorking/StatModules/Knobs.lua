-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = {};
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local v4 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
v2.value = 0;
v2.event = v4.event.Knobs;
v4.event.Knobs.Event:connect(function(p1)
	if type(p1) == "number" then
		v2.value = p1;
		return;
	end;
	v2.value = 0;
end);
v2.value = v4.data.Knobs;
return v2;
