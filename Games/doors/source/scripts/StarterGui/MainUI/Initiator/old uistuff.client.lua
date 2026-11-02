--!nolint
local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v3 = require(script.Parent);
local v4 = game["Run Service"];
local l__TweenService__5 = game:GetService("TweenService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__MarketplaceService__7 = game:GetService("MarketplaceService");
local l__Parent__8 = script.Parent.Parent.Parent;
local l__SideButtons__9 = l__Parent__8:WaitForChild("LobbyFrame"):WaitForChild("SideButtons");
local v10 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local v11 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetProductPrice"));
local v12 = require(game:GetService("ReplicatedStorage"):WaitForChild("Products"));
while true do
	wait(0.5);
	if l__Parent__8.LobbyFrame.WarningScreen.Visible == false then
		break;
	end;
end;
l__SideButtons__9.Visible = true;
local u1 = l__UserInputService__6.GamepadEnabled;
local l__Shop__2 = l__Parent__8:WaitForChild("LobbyFrame"):WaitForChild("Shop");
local l__GuiService__3 = game:GetService("GuiService");
local l__Achievements__4 = l__Parent__8:WaitForChild("LobbyFrame"):WaitForChild("Achievements");
local u5 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
function update()
	if u1 then
		if l__Shop__2.Visible then
			if l__Shop__2.Frame.Visible then
				l__GuiService__3.SelectedObject = l__Shop__2.Frame.Products.Boost;
			else
				l__GuiService__3.SelectedObject = l__Shop__2.UGC:FindFirstChild("Asset", true);
			end;
		elseif l__Achievements__4.Visible then
			l__GuiService__3.SelectedObject = l__Achievements__4.Frame;
		else
			l__GuiService__3.SelectedObject = nil;
		end;
	else
		l__GuiService__3.SelectedObject = nil;
	end;
	if l__Achievements__4.Visible then
		return;
	end;
	if l__Shop__2.Visible then
		if u5.data then
			if u5.data.PaidInKnobs then
				if 2400 <= u5.data.PaidInKnobs then
					l__Shop__2.Frame.Products.Frame[1].Visible = false;
					l__Shop__2.Frame.Products.Frame[2].Visible = false;
					l__Shop__2.Frame.Products.Frame[3].Visible = false;
					l__Shop__2.Frame.Products.Frame[4].Visible = false;
					l__Shop__2.Frame.Products.Frame[5].Visible = true;
					l__Shop__2.Frame.Products.Frame[6].Visible = true;
					l__Shop__2.Frame.Products.Frame[7].Visible = true;
					l__Shop__2.Frame.Products.Frame.Back.Visible = true;
				end;
			end;
		end;
	end;
end;
l__SideButtons__9.ButtonShop.MouseButton1Down:Connect(function()
	l__Shop__2.Visible = not l__Shop__2.Visible;
	l__Achievements__4.Visible = false;
	update();
end);
l__SideButtons__9.ButtonAchievements.MouseButton1Down:Connect(function()
	l__Achievements__4.Visible = not l__Achievements__4.Visible;
	l__Shop__2.Visible = false;
	update();
end);
l__Shop__2.CloseButton.MouseButton1Down:Connect(function()
	l__Shop__2.Visible = false;
	update();
end);
l__Shop__2.UGCButton.MouseButton1Down:Connect(function()
	l__Shop__2.Frame.Visible = not l__Shop__2.Frame.Visible;
	l__Shop__2.UGC.Visible = not l__Shop__2.Frame.Visible;
	if not l__Shop__2.Frame.Visible then
		local v13 = "SHOP";
	else
		v13 = "UGC";
	end;
	l__Shop__2.UGCButton.Text = v13;
	update();
end);
l__Shop__2:WaitForChild("Code").Confirm.MouseButton1Down:Connect(function()
	game.ReplicatedStorage.EntityInfo.ShopCode:FireServer(l__Shop__2.Code.Text);
end);
l__Shop__2:WaitForChild("Code").ReturnPressedFromOnScreenKeyboard:Connect(function()
	game.ReplicatedStorage.EntityInfo.ShopCode:FireServer(l__Shop__2.Code.Text);
end);
l__Shop__2:WaitForChild("Code").FocusLost:Connect(function()
	game.ReplicatedStorage.EntityInfo.ShopCode:FireServer(l__Shop__2.Code.Text);
end);
l__Achievements__4.CloseButton.MouseButton1Down:Connect(function()
	l__Achievements__4.Visible = false;
	update();
end);
for v14, v15 in l__Shop__2.UGC() do
	if v15:IsA("TextButton") and v15:GetAttribute("ProductID") ~= nil and (v15.Visible or v15:GetAttribute("DoAnyway")) then
		v15.ImageLabel.Image = "rbxthumb://type=Asset&id=" .. v15:GetAttribute("ProductID") .. "&w=420&h=420";
		v15.MouseButton1Down:Connect(function()
			print("erm");
			l__MarketplaceService__7:PromptPurchase(l__LocalPlayer__2, v15:GetAttribute("ProductID"));
		end);
	end;
end;
for v16, v17 in l__Shop__2.Frame() do
	if v17:IsA("TextButton") then
		if v17:GetAttribute("ProductID") ~= nil and (v17.Visible or v17:GetAttribute("DoAnyway")) then
			v17.Price.Text = v11(v17:GetAttribute("ProductID"));
			v17.MouseButton1Down:Connect(function()
				l__MarketplaceService__7:PromptProductPurchase(l__LocalPlayer__2, v17:GetAttribute("ProductID"));
			end);
		elseif v17:GetAttribute("BuyPremium") then
			v17.MouseButton1Down:Connect(function()
				l__MarketplaceService__7:PromptPremiumPurchase(l__LocalPlayer__2);
			end);
			pcall(function()
				if l__LocalPlayer__2.MembershipType == Enum.MembershipType.Premium then
					v17.Visible = false;
				end;
			end);
		elseif v17:GetAttribute("GoBack") then
			l__Shop__2.Frame.Products.Frame[1].Visible = true;
			l__Shop__2.Frame.Products.Frame[2].Visible = true;
			l__Shop__2.Frame.Products.Frame[3].Visible = true;
			l__Shop__2.Frame.Products.Frame[4].Visible = true;
			l__Shop__2.Frame.Products.Frame[5].Visible = false;
			l__Shop__2.Frame.Products.Frame[6].Visible = false;
			l__Shop__2.Frame.Products.Frame[7].Visible = false;
			l__Shop__2.Frame.Products.Frame.Back.Visible = false;
		end;
	end;
end;
l__UserInputService__6.InputBegan:Connect(function(p1, p2)
	if p2 then
		return;
	end;
	if p1.KeyCode == Enum.KeyCode.ButtonB then
		l__Shop__2.Visible = false;
		l__Achievements__4.Visible = false;
		update();
		return;
	end;
	if p1.KeyCode == Enum.KeyCode.ButtonX then
		if not l__GuiService__3.SelectedObject then
			l__GuiService__3.SelectedObject = l__SideButtons__9.ButtonShop;
			return;
		end;
	else
		return;
	end;
	l__Shop__2.Visible = false;
	l__Achievements__4.Visible = false;
	l__GuiService__3.SelectedObject = nil;
end);
local function v18()
	u1 = l__UserInputService__6.GamepadEnabled;
	for v19, v20 in pairs(game:GetService("CollectionService"):GetTagged("XBox")) do
		v20.Visible = u1;
	end;
end;
l__UserInputService__6.GamepadConnected:Connect(v18);
l__UserInputService__6.GamepadDisconnected:Connect(v18);
u1 = l__UserInputService__6.GamepadEnabled;
for v21, v22 in pairs(game:GetService("CollectionService"):GetTagged("XBox")) do
	v22.Visible = u1;
end;
while true do
	wait(1);
	if u5.data then
		break;
	end;
end;
for v23, v24 in pairs(l__Achievements__4.List:GetChildren()) do
	if v24:IsA("ImageButton") and v24.Visible then
		v24:Destroy();
	end;
end;
if u5.data then
	local v25, v26, v27 = pairs(v10);
	while true do
		local v28, v29 = v25(v26, v27);
		if not v28 then
			break;
		end;
		local v30 = v29:GetInfo();
		local v31 = l__Achievements__4.List.Badge:Clone();
		for v32, v33 in pairs(v30) do
			v31:SetAttribute(v32, v33);
		end;
		v31.Image = v30.Image;
		v31.Name = "Achievement" .. v30.Name;
		v31.Parent = l__Achievements__4.List;
		v31.LayoutOrder = 1000 + v30.Category;
		v31.Visible = true;
		if table.find(u5.data.Achievements, v30.Name) then
			v31.ImageColor3 = Color3.new(1, 1, 1);
			v31.ImageTransparency = 0;
			v31.LayoutOrder = v31.LayoutOrder - 1000;
			v31.UIStroke.Enabled = false;
			v30.Hidden = -1;
		end;
		local function v34()
			l__Achievements__4.Frame.Title.Text = v30.Hidden < 3 and v30.Title or "Locked Achievement";
			l__Achievements__4.Frame.Desc.Text = v30.Hidden < 2 and v30.Desc or "Unlock this achievement to view its description!";
			l__Achievements__4.Frame.Reason.Text = v30.Hidden < 1 and v30.Reason or "";
			l__Achievements__4.Frame.ImageLabel.Image = v30.Image;
			l__Achievements__4.Frame.Visible = true;
		end;
		v31.MouseButton1Down:Connect(v34);
		v31.SelectionGained:Connect(v34);	
	end;
end;
