local v2 = require(script.Parent)
local v1 = script.Parent.Parent.Parent.ItemShop
--local v3 = game:GetService("Workspace").Game.Timer.Value
--v2.freemouse = true
local v4 = v1.Confirm
local v5 = v1.Items
local v6 = v5.Template
local player = game.Players.LocalPlayer

local l__Fire__1 = game.ReplicatedStorage.EntityInfo.PreRunShop

local l__GuiService__8 = game:GetService("GuiService");
local u5 = require(game:GetService("ReplicatedStorage"):WaitForChild("Products"));
local l__MarketplaceService__6 = game:GetService("MarketplaceService");
local l__TweenService__10 = game:GetService("TweenService");

local l__StarterElevator__4 = workspace:FindFirstChild("StarterElevator", true);
local l__Music__5 = l__StarterElevator__4:FindFirstChild("Music", true);
local l__BillboardGui__8 = l__StarterElevator__4:WaitForChild("DoorHitbox"):WaitForChild("BillboardGui");

v4.MouseButton1Down:Connect(function()
	script.PressDown:Play()
end)

local module_menu = require(game.ReplicatedStorage.Items)

local v9 = 1

local v10 = {};

--script.Music:Play()

v1:GetPropertyChangedSignal("Visible"):Connect(function()
	if v1.Visible == true then
		if v2.controller == "console" then
			l__GuiService__8.SelectedObject = v1.Confirm;
		else
			v2.freemouse = true
			l__GuiService__8.SelectedObject = nil;
		end;
	else
		v2.freemouse = false
		l__GuiService__8.SelectedObject = nil;
	end
end)

function create(p1)
	
	local Template = v6:Clone()
	
	Template.LayoutOrder = v9
	v9 = v9 - 1
	
	Template.Title.Text = module_menu[p1].Title
	Template.ImageLabel.Image = module_menu[p1].Image
	Template.Price.Text = module_menu[p1].Cost
	Template.Desc.Text = module_menu[p1].Desc
	Template.Name = module_menu[p1].Title
	
	Template:SetAttribute("Title", module_menu[p1].Title)
	Template:SetAttribute("Price", 0)
	
	if module_menu[p1].Stack then
		Template.Stack.Visible = true
		Template.Stack.Text = module_menu[p1].Stack
	end
	
	local function u2()
		local overprice = 0
		
		for v17, v18 in pairs(v10) do
			overprice = overprice + v1.Items:FindFirstChild(v18):GetAttribute("Price");
		end;
		
		v1.Confirm.Price.Text = tostring(overprice)
	end
	
	Template.Parent = v5
	Template.Visible = true
	
	Template.MouseButton1Down:Connect(function(player)
		local v20 = true;
		for v21, v22 in pairs(v10) do
			if v22 == Template.Name then
				v20 = false;
			end;
		end;
		
		if v20 then
			Template:SetAttribute("Price", module_menu[p1].Cost)
			script.PressDown:Play()
			Template.Transparency = 0.6
			table.insert(v10, Template.Name)
		else
			Template:SetAttribute("Price", 0)
			script.PressDown:Play()
			Template.Transparency = 0.9
			table.remove(v10, table.find(v10, Template.Name))
		end
		u2()
	end)
end

local u15 = l__BillboardGui__8:WaitForChild("Seconds").Changed:Connect(function()
	local v28 = tonumber(l__BillboardGui__8.Seconds.Text);
	v1.Timer.Text = l__BillboardGui__8.Seconds.Text;
	if v28 and v28 <= 10 then
		l__TweenService__10:Create(v1.Timer, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
			TextColor3 = Color3.fromRGB(255, 81, 69)
		}):Play();
	end;
end);

game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("ElevatorFinished").OnClientEvent:Connect(function()
	l__Fire__1:FireServer({});
	if v1.Visible then
		v1.Visible = false;
		game.ReplicatedStorage.EntityInfo.Caption:FireServer("The timer ran out.")
	end;
	pcall(function()
		game.ReplicatedStorage.GameData.GameStarted.Value = os.time();
	end);
	u15:Disconnect();
	v2.freemouse = false;
end);

v1.Confirm.MouseButton1Down:Connect(function()
	l__Fire__1:FireServer(v10);
	v2.freemouse = false;
	v1.Visible = false;
end);

v1.ConfirmDisabled.MouseButton1Down:Connect(function()
	local v23 = u5.Knobs250;
	l__MarketplaceService__6:PromptProductPurchase(player, v23);
end);

for Module, value in pairs(module_menu) do
	wait()
	create(Module)
end