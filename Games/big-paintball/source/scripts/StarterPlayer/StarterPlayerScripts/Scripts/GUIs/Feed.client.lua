-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get();
local v4 = v1.Player.Get("Camera");
local function u1(p1)
	if not script:FindFirstChild(p1) then
		v1.Print(string.format("Failed to get ItemType '%s' for Feed"));
		return nil;
	end;
	return script:FindFirstChild(p1):Clone();
end;
local l__Feed__2 = v1.GUI.Feed;
local function u3(p2, ...)
	local v5 = { ... };
	local v6 = u1(p2);
	for v7, v8 in pairs(l__Feed__2.Frame:GetChildren()) do
		if v8:IsA("ImageLabel") then
			v8.LayoutOrder = v8.LayoutOrder + 1;
		end;
	end;
	if p2 == "Killstreak" then
		wait(0.25);
	end;
	if v5[1] then
		v6:WaitForChild("Desc").Text = v5[1];
	end;
	if v5[2] and type(v5[2]) == "number" then
		v6:WaitForChild("Credits"):WaitForChild("Amount").Text = v1.Functions.Commas(v5[2]);
	end;
	local v9 = v1.Functions.ResolutionScale();
	v6.Size = UDim2.new(v6.Size.X.Scale, v6.Size.X.Offset, v6.Size.Y.Scale * v9, v6.Size.Y.Offset * v9);
	v6.Parent = l__Feed__2.Frame;
	coroutine.wrap(function()
		v6.Desc.TextColor3 = Color3.new(1, 1, 1);
		v1.Functions.Wait(0.1);
		v6.Desc.TextColor3 = v6.Desc.TextColor3;
		wait(2);
		for v10, v11 in pairs(v6:GetDescendants()) do
			if v11:IsA("ImageLabel") then
				v1.Functions.FastTween(v11, {
					ImageTransparency = 1
				}, { 0.5, "Quad", "Out" });
				v1.Functions.FastTween(v11, {
					BackgroundTransparency = 1
				}, { 0.5, "Quad", "Out" });
			elseif v11:IsA("TextLabel") then
				v1.Functions.FastTween(v11, {
					TextTransparency = 1
				}, { 0.5, "Quad", "Out" });
				v1.Functions.FastTween(v11, {
					BackgroundTransparency = 1
				}, { 0.5, "Quad", "Out" });
			else
				v1.Functions.FastTween(v11, {
					BackgroundTransparency = 1
				}, { 0.5, "Quad", "Out" });
			end;
		end;
		v1.Functions.FastTween(v6, {
			ImageTransparency = 1
		}, { 0.5, "Quad", "Out" });
		wait(0.5);
		v6:Destroy();
	end)();
end;
v1.Network.Fired("New Feed Item"):Connect(function(...)
	u3(unpack({ ... }));
end);
v1.Signal.Fired("New Item"):Connect(function(...)
	u3(...);
end);
