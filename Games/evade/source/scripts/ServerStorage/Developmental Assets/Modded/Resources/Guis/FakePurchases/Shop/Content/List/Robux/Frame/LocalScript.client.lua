local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PurchaseEvent = ReplicatedStorage:WaitForChild("Purchase") :: RemoteFunction
local FakePurchase = require(ReplicatedStorage:WaitForChild("ㅤ"))
local Set = ReplicatedStorage:WaitForChild("Set") :: RemoteEvent
local ClientSet = ReplicatedStorage:WaitForChild("ClientSet") :: BindableEvent

PurchaseEvent.OnClientInvoke = function(...)
	local args = { ... }

	local success, result = pcall(function()
		return FakePurchase:Create(table.unpack(args))
	end)

	if success then
		return result
	end
	
	return nil
end

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

InterfaceController:Register("FakePurchases", script.Parent.Parent.Parent.Parent.Parent, "TopQuint")

local Data = Synchronizer:Wait(game.Players.LocalPlayer)
assert(Data)

local toggled = true
local toggled2 = false

local function Toggle(on, which)
	if which == "" then
		toggled = on
	else
		toggled2 = on
	end

	if on then
		script.Parent["Toggle" .. which].Price.Text = "ON"
		script.Parent["Toggle" .. which].ImageColor3 = Color3.fromRGB(255, 255, 255)
	else
		script.Parent["Toggle" .. which].Price.Text = "OFF"
		script.Parent["Toggle" .. which].ImageColor3 = Color3.fromRGB(255, 0, 0)
	end
end

local initialToggleState = Data:Get("FakeRobuxToggled")
if initialToggleState == nil then
	initialToggleState = true
	Set:FireServer("Toggle", true)
end

Toggle(initialToggleState, "")

local NewPurchaseToggled = Data:Get("NewPurchaseToggled")

Toggle(NewPurchaseToggled, "2")

script.Parent.Input.Input:GetPropertyChangedSignal("Text"):Connect(function()
	if script.Parent.Input.Input.Text ~= "" and tonumber(script.Parent.Input.Input.Text) then
		Set:FireServer("Set", tonumber(script.Parent.Input.Input.Text))
		FakePurchase:SetRobux(tonumber(script.Parent.Input.Input.Text))
	end
end)

ClientSet.Event:Connect(function(newRobux: number)
	ClientSet.Parent = nil
	script.Parent.Input.Input.Text = tostring(newRobux)
end)

task.delay(1, function()
	ClientSet.Parent = nil
end)

if Data:Get("FakeRobux") then
	local data = Data:Get("FakeRobux")

	FakePurchase:SetRobux(data)
else
	script.Parent.Input.Input.Text = FakePurchase:GetRobux()
end

local giftPlayerSelect = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Shop.Shop.GiftPlayerSelect
local robuxButton = script.RobuxButton

robuxButton.Parent = giftPlayerSelect
giftPlayerSelect.PlayerSelected.Size = UDim2.new(0.344, 0, 1, 0)


local toggleButton = AnimatedButton.new(script.Parent.Toggle)
toggleButton:Animate()
toggleButton.OnActivated:Connect(function()
	Set:FireServer("Toggle", not toggled)
	Toggle(not toggled, "")
end)

local toggleButton2 = AnimatedButton.new(script.Parent.Toggle2)
toggleButton2:Animate()
toggleButton2.OnActivated:Connect(function()
	Set:FireServer("Toggle2", not toggled2)
	Toggle(not toggled2, "2")
end)


local Close = AnimatedButton.new(script.Parent.Parent.Parent.Parent.Parent.Header.Close)
Close:Animate()
Close.OnActivated:Connect(function()
	InterfaceController:Toggle("FakePurchases", false)
end)

local RobuxButton = AnimatedButton.new(script.Parent.Parent.Parent.Parent.Parent.GiftPlayerSelect.RobuxButton)
RobuxButton:Animate()
RobuxButton.OnActivated:Connect(function()
	InterfaceController:Toggle("Shop", true)
end)

local RobuxButton2 = AnimatedButton.new(robuxButton)
RobuxButton2:Animate()
RobuxButton2.OnActivated:Connect(function()
	InterfaceController:Toggle("FakePurchases", true)
end)