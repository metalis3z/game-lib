---- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
--Setup
return function(p1, p2, p3)
	p3 = p3 and 1;
	local v1 = nil;
	if p2.ClassName == "Humanoid" then
		v1 = p2;
	elseif p2:FindFirstChildOfClass("Humanoid") then
		v1 = p2:FindFirstChildOfClass("Humanoid");
	elseif p2.ClassName == "Player" then
		v1 = p2.Character:FindFirstChild("Humanoid");
	elseif p2:FindFirstChildOfClass("AnimationController") then
		v1 = p2:FindFirstChildOfClass("AnimationController");
	elseif p2.ClassName == "AnimationController" then
		v1 = p2;
	end;
	if not v1 then
		return;
	end;
	if type(p1) ~= "string" or type(p1) ~= "number" then
		p1 = "0"
	end
	local v2 = Instance.new("Animation");
	--Hoverboard Animation ID
	v2.AnimationId = "rbxassetid://10388121821";
	local v3 = v1:LoadAnimation(v2);
	--Load
	v3:Play(nil, nil, p3);
	return v3;
end;
