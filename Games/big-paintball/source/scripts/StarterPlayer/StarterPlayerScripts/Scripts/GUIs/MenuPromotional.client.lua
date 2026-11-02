-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = { {
	image = "rbxassetid://10075239905", 
	productId = 0, 
	isLimitedTime = true, 
	isLikes = true
}, {
	image = "rbxassetid://6243109201", 
	gamepassId = 11339726, 
	isLimitedTime = false, 
	isLikes = false
}
}
local v2 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v2.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Promotional__1 = v2.GUI.Menu.Side.Promotional;
local u2 = false;
local v15
local v20
function CreateSlides()
	local l__Slides__3 = l__Promotional__1:FindFirstChild("Center").Slides;
	l__Slides__3:ClearAllChildren();
	for v4, v5 in ipairs(v1) do
		local v7 = script.Slide:Clone();
		v7.Image = v5.image;
		v7.Position = UDim2.new(1 * (v4 - 1), 0, 0, 0);
		v7.Name = "Slide" .. v4;
		v7.Parent = l__Slides__3;
		local v8 = script.Tab:Clone();
		v8.Name = "Tab" .. v4;
		v8.LayoutOrder = v4;
		v8.Parent = l__Promotional__1.Tabs;
		v8.MouseButton1Click:Connect(function()
			if not u2 then
				u2 = true;
				ChangeSlide(v4);
				u2 = false;
			end;
		end);	
	end;
end;
local u3 = #v1;
local u4 = nil;
function ChangeSlide(p1)
	if p1 == u3 then
		return;
	end;
	u4 = tick();
	u3 = p1;
	local v9 = v1[p1];
	local v10 = l__Promotional__1.Tabs:FindFirstChild("Tab" .. p1);
	v2.Functions.FastTween(l__Promotional__1:FindFirstChild("Center").Slides, {
		Position = UDim2.new(-l__Promotional__1:FindFirstChild("Center").Slides:FindFirstChild("Slide" .. p1).Position.X.Scale, 0, 0, 0)
	}, { 0.5, "Sine", "Out" });
	for v11, v12 in	ipairs(l__Promotional__1.Tabs:GetChildren()) do
		if v12.ClassName == "TextButton" then
			local v14 = {};
			if v12.Name == "Tab" .. p1 then
				v15 = 0;
			else
				v15 = 0.6;
			end;
			v14.BackgroundTransparency = v15;
			v2.Functions.FastTween(v12, v14, { 0.25, "Expo", "Out" });
		end;	
	end;
	l__Promotional__1.LimitedTime.Visible = v9.isLimitedTime;
	l__Promotional__1.LikeBar.Visible = v9.isLikes;
	l__Promotional__1.Redeem.Visible = false;
	if v2.GunCmds.DoesOwnGun(game.Players.LocalPlayer, "73") then
		l__Promotional__1.Redeem.TextLabel.Text = "REEDEMED!";
	end;
	if v9.isLikes then
		l__Promotional__1.LikeBar.Position = UDim2.new(0.5, 0, 0.865, 0);
		v2.Functions.FastTween(l__Promotional__1.LikeBar, {
			Position = UDim2.new(0.5, 0, 0.825, 0)
		}, { 0.5, "Expo", "Out" });
	end;
end;
coroutine.wrap(function()
	CreateSlides();
	while true do
		if not u4 or tick() - u4 >= 10 then
			if #v1 <= u3 then
				ChangeSlide(1);
			else
				ChangeSlide(u3 + 1);
			end;
		end;
		v2.Heartbeat(30);	
	end;
end)();
local l__Processing__5 = v2.GUI.Processing;
l__Promotional__1.Center.MouseButton1Click:Connect(function()
	if not u2 then
		u2 = true;
		local v16 = v1[u3];
		if v16.gamepassId and v16.gamepassId ~= 0 then
			v2.MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, v16.gamepassId);
			l__Processing__5.Frame.Size = l__Processing__5.Frame.Size + UDim2.new(-0.05, 0, -0.05, 0);
			l__Processing__5.Gui.Enabled = true;
			v2.Functions.FastTween(l__Processing__5.Frame, {
				Size = l__Processing__5.Frame.Size
			}, { 0.35, "Expo", "Out" });
			v2.MarketplaceService.PromptGamePassPurchaseFinished:Wait();
			l__Processing__5.Gui.Enabled = false;
		elseif v16.productId and v16.productId ~= 0 then
			v2.MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, v16.productId);
			l__Processing__5.Frame.Size = l__Processing__5.Frame.Size + UDim2.new(-0.05, 0, -0.05, 0);
			l__Processing__5.Gui.Enabled = true;
			v2.Functions.FastTween(l__Processing__5.Frame, {
				Size = l__Processing__5.Frame.Size
			}, { 0.35, "Expo", "Out" });
			v2.MarketplaceService.PromptProductPurchaseFinished:Wait();
			l__Processing__5.Gui.Enabled = false;
		end;
		u2 = false;
	end;
end);
v2.GUIFX.HyperInput(l__Promotional__1.Redeem);
function UpdateLikeGoal()
	local v17, v18, v19 = v2.Network.Invoke("Get Game Statistics");
	if not v17 then
		l__Promotional__1.LikeBar.Likes.Text = "Error";
		l__Promotional__1.LikeBar.Percent.Text = "";
		l__Promotional__1.LikeBar.Bar.Size = UDim2.new(0, 0, 1, 0);
		return;
	end;
	if v19 == true then
		v20 = "Reached!";
	elseif v19 == false then
		v20 = v2.Functions.Commas(v17);
	elseif v19 == nil then
		v2.Print("Invalid parameters", true)
	end;
	l__Promotional__1.LikeBar.Likes.Text = v20;
	l__Promotional__1.LikeBar.Percent.Text = v18 .. "%";
	l__Promotional__1.LikeBar.Bar.Size = UDim2.new(v18 / 100, 0, 1, 0);
end;
coroutine.wrap(function()
	while true do
		UpdateLikeGoal();
		wait(15);	
	end;
end)();
local u6 = false;
local function u7(p2)
	if p2 and not u6 then
		u6 = true;
		v2.Functions.FastTween(l__Promotional__1.Center, {
			Size = UDim2.new(1.06, 0, 1.06, 0)
		}, { 0.15, "Expo", "Out" });
		v2.Functions.FastTween(l__Promotional__1.Center.white, {
			BackgroundTransparency = 0.85
		}, { 0.075, "Expo", "Out" });
		return;
	end;
	if not p2 and u6 then
		u6 = false;
		v2.Functions.FastTween(l__Promotional__1.Center, {
			Size = UDim2.new(1, 0, 1, 0)
		}, { 0.075, "Linear" });
		v2.Functions.FastTween(l__Promotional__1.Center.white, {
			BackgroundTransparency = 1
		}, { 0.05, "Linear" });
	end;
end;
l__Promotional__1.Center.MouseEnter:Connect(function()
	u7(true);
end);
l__Promotional__1.Center.MouseLeave:Connect(function()
	u7(false);
end);
