-- Rebirth progress: % above the Rebirth button + pulsing "You can Rebirth!"
-- notify. Requirement comes from GameConfig.Rebirth.GetRequiredLevel
-- (LINEAR: 25 + 25 * rebirths -> 25, 50, ..., 250), same as RebirthService.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local function requiredLevelFor(rebirths)
	local getRequired = GameConfig.Rebirth and GameConfig.Rebirth.GetRequiredLevel
	if getRequired then
		return getRequired(rebirths)
	end
	return 25 + 25 * rebirths
end

local plr = Players.LocalPlayer
local hud = script.Parent
local notify = hud:WaitForChild("RebirthNotify")
local nscale = notify:WaitForChild("PulseScale")
local pctLabel = hud:WaitForChild("LeftSide"):WaitForChild("Left"):WaitForChild("Rebirth"):WaitForChild("Percent")

local pulseTween = TweenService:Create(nscale,
	TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	{ Scale = 1.1 })

local function rebirthCount()
	local ls = plr:FindFirstChild("leaderstats")
	-- the leaderstats stat is "Rebirths" (plural, see PlayerDataService)
	local rb = ls and (ls:FindFirstChild("Rebirths") or ls:FindFirstChild("Rebirth"))
	if rb then return rb.Value end
	return plr:GetAttribute("Rebirths") or plr:GetAttribute("Rebirth") or 0
end

local function refresh()
	local level = plr:GetAttribute("Level") or 1
	local reqLevel = requiredLevelFor(rebirthCount())
	local pct = math.clamp(level / reqLevel, 0, 1)
	pctLabel.Text = math.floor(pct * 100 + 0.5) .. "%"
	pctLabel.TextColor3 = pct >= 1 and Color3.fromRGB(126, 255, 70) or Color3.new(1, 1, 1)

	local can = level >= reqLevel
	if can and not notify.Visible then
		notify.Visible = true
		pulseTween:Play()
	elseif not can and notify.Visible then
		notify.Visible = false
		pulseTween:Cancel()
		nscale.Scale = 1
	end
end

plr:GetAttributeChangedSignal("Level"):Connect(refresh)

-- follow rebirth-count changes too (stat object or attribute)
local function hookRebirth()
	local ls = plr:FindFirstChild("leaderstats")
	local rb = ls and (ls:FindFirstChild("Rebirths") or ls:FindFirstChild("Rebirth"))
	if rb then rb.Changed:Connect(refresh) end
end
plr:GetAttributeChangedSignal("Rebirths"):Connect(refresh)
plr:GetAttributeChangedSignal("Rebirth"):Connect(refresh)
if plr:FindFirstChild("leaderstats") then hookRebirth() else
	plr.ChildAdded:Connect(function(c) if c.Name == "leaderstats" then task.wait(0.1); hookRebirth(); refresh() end end)
end

refresh()
