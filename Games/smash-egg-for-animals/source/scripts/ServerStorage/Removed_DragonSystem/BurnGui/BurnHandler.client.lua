-- Puissance de brûlure du joueur, affichée en haut de l'écran (s'améliore au stand Upgrades)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UpgradeConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("DragonSystem"):WaitForChild("UpgradeConfig"))
local player = Players.LocalPlayer
local holder = script.Parent:WaitForChild("Holder")
local value, flame = holder:WaitForChild("Value"), holder:WaitForChild("Flame")
local bump = Instance.new("UIScale")
bump.Parent = flame
local first = true
local function refresh()
	value.Text = UpgradeConfig.Value(player, "Burn") .. "%"
	if not first then -- la flamme grossit un instant quand la puissance augmente
		bump.Scale = 1.4
		TweenService:Create(bump, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end
	first = false
end
player:GetAttributeChangedSignal("Up_Burn"):Connect(refresh)
refresh()
-- la flamme danse doucement
game:GetService("RunService").RenderStepped:Connect(function()
	flame.Rotation = math.sin(os.clock() * 3) * 6
end)

-- toujours juste sous le compte à rebours du haut (ou sous la barre Roblox s'il n'y en a pas)
script.Parent.IgnoreGuiInset = true
task.spawn(function()
	local container = player:WaitForChild("PlayerGui"):WaitForChild("Countdown"):WaitForChild("Container")
	local title, time = container:WaitForChild("Title"), container:WaitForChild("Time")
	while true do
		local y = 62
		if container.Visible then y = 14 + time.AbsoluteSize.Y + (title.Visible and title.AbsoluteSize.Y or 0) + 6 end
		holder.Position = UDim2.new(0.5, 0, 0, y)
		task.wait(0.25)
	end
end)
