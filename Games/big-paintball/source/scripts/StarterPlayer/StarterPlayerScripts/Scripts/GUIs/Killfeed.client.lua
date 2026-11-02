-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local u1 = v1.Player.Get("Camera");
local l__Killfeed__2 = v1.GUI.Killfeed;
local u3 = v1.Player.Get();
local v4
local u4 = {
	Blue = Color3.fromRGB(20, 232, 255), 
	Red = Color3.fromRGB(255, 0, 0)
};
local function u5(p1, p2)
	if not p2 or not p1 then
		v1.Print("Invalid parameters");
		return;
	end;
	if v1.Shared.isIntermission() then
		return;
	end;
	if u1.ViewportSize.X <= 580 then
		l__Killfeed__2.Gui.Enabled = false;
	elseif u3:FindFirstChild("__SPAWNED") then
		l__Killfeed__2.Gui.Enabled = true;
	end;
	if v1.GUI.Menu.Gui.Enabled and v1.Variables.Mobile then
		return;
	end;
	if not l__Killfeed__2.Gui.Enabled then
		return;
	end;
	if v1.UserInputService.TouchEnabled and not v1.UserInputService.KeyboardEnabled and not v1.UserInputService.MouseEnabled then
		l__Killfeed__2.Frame.Position = UDim2.new(0, 5, 0, 5);
		l__Killfeed__2.Frame.AnchorPoint = Vector2.new(0, 0);
		l__Killfeed__2.Frame.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
		l__Killfeed__2.Frame.UIScale.Scale = 0.75;
	end;
	local v3 = script:WaitForChild("KillfeedItem"):Clone();
	if v1.Variables.Mobile then
		v4 = 1;
	else
		v4 = 999;
	end;
	v3.LayoutOrder = v4;
	local v5 = v1.Shared.getRoundType();
	for v6, v7 in pairs(l__Killfeed__2.Frame:GetChildren()) do
		if v7.Name == "KillfeedItem" then
			if v1.Variables.Mobile then
				v7.LayoutOrder = v7.LayoutOrder + 1;
			else
				v7.LayoutOrder = v7.LayoutOrder - 1;
			end;
		end;
	end;
	local v8 = v1.TextService:GetTextSize(p1.DisplayName, v3.Victim.TextSize, v3.Victim.Font, Vector2.new(l__Killfeed__2.Frame.AbsoluteSize.X, v3.Size.Y.Offset));
	v3:WaitForChild("Victim").Text = p1.DisplayName;
	v3.Victim.Size = UDim2.new(0, v8.X, 0, v8.Y);
	local v9 = v1.TextService:GetTextSize(p2.DisplayName, v3.Killer.TextSize, v3.Killer.Font, Vector2.new(l__Killfeed__2.Frame.AbsoluteSize.X, v3.Size.Y.Offset));
	v3:WaitForChild("Killer").Text = p2.DisplayName;
	v3.Killer.Size = UDim2.new(0, v9.X, 0, v9.Y);
	v3.Arrow.Position = UDim2.new(0, v3.Killer.Size.X.Offset + 6, 0.5, 0);
	v3.Size = UDim2.new(0, v3.UIListLayout.AbsoluteContentSize.X + 6, 0, 24);
	if p1 == u3 or p2 == u3 then
		v3.ImageColor3 = Color3.fromRGB(255, 255, 255);
		v3.Arrow.ImageColor3 = Color3.new(0, 0, 0);
		v3.Victim.TextColor3 = Color3.new(0, 0, 0);
		v3.Killer.TextColor3 = Color3.new(0, 0, 0);
	end;
	if p1.Team and p2.Team and u4[p1.Team.Name] and u4[p2.Team.Name] then
		v3.Victim.TextColor3 = u4[p1.Team.Name];
		v3.Killer.TextColor3 = u4[p2.Team.Name];
	end;
	v3.Parent = l__Killfeed__2.Frame;
	delay(15, function()
		if not l__Killfeed__2.Gui.Enabled then
			v3:Destroy();
			return;
		end;
		for v10, v11 in pairs(v3:GetDescendants()) do
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
			elseif not v11:IsA("UIConstraint") and v11:IsA("GuiObject") then
				v1.Functions.FastTween(v11, {
					BackgroundTransparency = 1
				}, { 0.5, "Quad", "Out" });
			end;
		end;
		v1.Functions.FastTween(v3, {
			ImageTransparency = 1
		}, { 0.5, "Quad", "Out" });
		delay(1, function()
			v3:Destroy();
		end);
	end);
end;
v1.Network.Fired("Player Killed"):Connect(function(...)
	u5(...);
end);
