local v2 = require(script.Parent)
local v1 = script.Parent.Parent.Parent.ItemShop
--local v3 = game:GetService("Workspace").Game.Timer.Value
--v2.freemouse = true
local v4 = v1.Confirm
local v5 = v1.Items
local v6 = v5.Template
local player = game.Players.LocalPlayer

local l__GuiService__8 = game:GetService("GuiService");

local l__StarterElevator__4 = workspace:FindFirstChild("StarterElevator", true);
local l__Music__5 = l__StarterElevator__4:FindFirstChild("Music", true);
local l__BillboardGui__8 = l__StarterElevator__4:WaitForChild("DoorHitbox"):WaitForChild("BillboardGui");

v4.MouseButton1Down:Connect(function()
	script.PressDown:Play()
end)

local module_menu = require(game.ReplicatedStorage.Items)

local v9 = 1

local v10 = {};

function create(p1)
	
	if v2.controller == "console" then
		l__GuiService__8.SelectedObject = v1.Confirm;
	else
		l__GuiService__8.SelectedObject = nil;
	end;
	
	game.Workspace.GameSettings.ItemsStock:WaitForChild(module_menu[p1].Title)
	
	local Template = v6:Clone()
	
	Template.LayoutOrder = v9
	v9 = v9 - 1
	
	Template.Title.Text = module_menu[p1].Title
	Template.ImageLabel.Image = module_menu[p1].Image
	Template.Price.Text = module_menu[p1].Cost
	Template.Desc.Text = module_menu[p1].Desc
	Template.Name = module_menu[p1].Title
	
	if module_menu[p1].Stack then
		Template.Stack.Visible = true
		Template.Stack.Text = module_menu[p1].Stack
	end
	
	local selectedItem = false
	
	Template.Parent = v5
	Template.Visible = true
	
	Template.MouseButton1Down:Connect(function(player)
		if Template.StockV.Value == 0 or Template.StockV.Value < 1 then
			Template.Stock.TextColor3 = Color3.fromRGB(255, 89, 89)
			script.PressError:Play()
		else
			if selectedItem == false then
				script.PressDown:Play()
				selectedItem = true
				Template.Transparency = 0.6
				v1.HowMuch.Value += module_menu[p1].Cost
				v1.ToSellHowMuch.Value += module_menu[p1].Cost - 1
				game.ReplicatedStorage.PreShop:FindFirstChild(module_menu[p1].Title):FireServer(player)
			elseif selectedItem == true then
				script.PressDown:Play()
				selectedItem = false
				Template.Transparency = 0.9
				v1.HowMuch.Value -= module_menu[p1].Cost
				v1.ToSellHowMuch.Value -= module_menu[p1].Cost - 1
				game.ReplicatedStorage.PreShop:FindFirstChild(module_menu[p1].Title.."Un"):FireServer(player)
			end
		end
	end)
	
	for i = 1, 1 do
		Template.Stock.Text = "Stock: "..game.Workspace.GameSettings.ItemsStock:FindFirstChild(module_menu[p1].Title).Value
		Template.StockV.Value = game.Workspace.GameSettings.ItemsStock:FindFirstChild(module_menu[p1].Title).Value
	end
	
	game.Workspace.GameSettings.ItemsStock:FindFirstChild(module_menu[p1].Title).Changed:Connect(function()
		Template.Stock.Text = "Stock: "..game.Workspace.GameSettings.ItemsStock:FindFirstChild(module_menu[p1].Title).Value
		Template.StockV.Value = game.Workspace.GameSettings.ItemsStock:FindFirstChild(module_menu[p1].Title).Value
	
		if Template.StockV.Value == 0 then
			if selectedItem == true then
				selectedItem = false
				Template.Transparency = 0.9
				v1.HowMuch.Value -= module_menu[p1].Cost
				v1.ToSellHowMuch.Value -= module_menu[p1].Cost - 1
				game.ReplicatedStorage.PreShop:FindFirstChild(module_menu[p1].Title.."Un"):FireServer(player)
			end
		end
	end)
end

game.Workspace.GameSettings.Server.TimeElevator.Changed:Connect(function()
	v1.Timer.Text = game.Workspace.GameSettings.Server.TimeElevator.Value
end)

for Module, value in pairs(module_menu) do
	wait()
	create(Module)
end