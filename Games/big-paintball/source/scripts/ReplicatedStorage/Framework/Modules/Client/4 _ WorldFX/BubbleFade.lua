-- OneX Was Here

local v1 = BrickColor.White();
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
return function(p1, p2, p3, p4)
	local u2 = p2;
	local u3 = p4;
	local u4 = p3;
	coroutine.wrap(function()
		u2 = u2 and u2 or v1;
		u3 = u3 and u3 or 0.35;
		u4 = u4 and u4 or 4;
		if not p1 then
			u1.Print("Unable to do BubbleFade. Invalid position.");
			return;
		end;
		local v3 = Instance.new("Part");
		v3.Anchored = true;
		v3.CanCollide = false;
		v3.Transparency = 0;
		v3.CFrame = CFrame.new(p1);
		v3.Shape = Enum.PartType.Ball;
		v3.Size = Vector3.new(u4, u4, u4) / 1.25;
		v3.TopSurface = Enum.SurfaceType.Smooth;
		v3.BottomSurface = Enum.SurfaceType.Smooth;
		v3.Material = Enum.Material.SmoothPlastic;
		if typeof(u2) == "BrickColor" then
			v3.BrickColor = u2;
		elseif typeof(u2) == "Color3" then
			v3.Color = u2;
		end;
		v3.Parent = game.Workspace.__DEBRIS;
		u1.Functions.FastTween(v3, {
			Size = Vector3.new(u4, u4, u4)
		}, { u3 / 4, "Linear", "Out" });
		wait(u3 / 4);
		u1.Functions.FastTween(v3, {
			Size = Vector3.new(u4, u4, u4) / 1.25, 
			Transparency = 1
		}, { u3, "Linear", "Out" });
		wait(u3);
		v3:Destroy();
	end)();
end;
