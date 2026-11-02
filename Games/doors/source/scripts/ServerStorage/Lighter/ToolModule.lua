-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = {
	anim = {}
};
local l__Parent__1 = script.Parent;
function v2.fire(p1)
	l__Parent__1:WaitForChild("Remote"):FireServer();
end;
return v2;
