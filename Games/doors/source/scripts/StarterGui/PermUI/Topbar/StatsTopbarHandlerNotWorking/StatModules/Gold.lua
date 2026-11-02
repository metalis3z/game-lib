-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = {
	value = 0
};
local v3 = Instance.new("BindableEvent");
v3.Name = script.Name;
v3.Parent = script;
v2.event = v3;
if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("InGame").Value == true then
	game.Players.LocalPlayer:WaitForChild("Gold").Changed:connect(function(p1)
		v2.value = p1;
		v3:Fire(p1);
	end);
end;
return v2;
