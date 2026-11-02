local player = game.Players.LocalPlayer

local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,2,0)
local debounce = false

script.Parent.Activated:Connect(function()
	local skips = game:GetService("ReplicatedStorage").RemoteFunctions.fetchSkips:InvokeServer(player)
	if skips >= 1 and not debounce then
		debounce = true
		game:GetService("ReplicatedStorage").RemoteEvents.skipStage:FireServer()
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent, ti, {Position = downPos}):Play()
		script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:SetAttribute("Up", false)
		wait(1)
		debounce = false
	elseif not debounce then
		script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Menu.Shop.Back.Button.OpenShop:Fire("Skips")
	end
end)