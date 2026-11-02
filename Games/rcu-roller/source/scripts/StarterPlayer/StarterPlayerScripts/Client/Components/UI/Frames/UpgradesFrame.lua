--[[ UpgradesFrame — UI component for the gem-purchasable upgrades machine ]]
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local Component = require(Knit.Util.Component)

local UpgradesFrame = Component.new({
	Tag = "UpgradesFrame",
})

local DataController
local UIController
local SoundController
local UpgradeService
local Button
local Functions
local UpgradesList

local function getLevel(data, name)
	local v = data.upgrades and data.upgrades[name]
	if type(v) == "boolean" then return v and 1 or 0 end
	return tonumber(v) or 0
end

local Holder = game:GetService("Players").LocalPlayer
	:WaitForChild("PlayerGui")
	:WaitForChild("MainUI")
	:WaitForChild("Menus")
	:WaitForChild("UpgradesFrame")
	:WaitForChild("Main")
	:WaitForChild("List")
	:WaitForChild("Holder")

function UpgradesFrame.setupFrames(self)
	for upgradeName, upgradeData in UpgradesList do
		local frameName = Functions.toPascal(upgradeName)
		local frame = Holder:FindFirstChild(frameName)
		if not frame then continue end

		local main = frame:FindFirstChild("Main")
		if not main then continue end

		local upgradeBtn = main:FindFirstChild("Upgrade")
		if not upgradeBtn then continue end

		Button.new(upgradeBtn):buttonUp(function()
			local data = DataController.data
			if not data then return end

			local level = getLevel(data, upgradeName)
			local nextUpgrade = upgradeData.upgrades[level + 1]
			if not nextUpgrade then return end

			if (data.gems or 0) < nextUpgrade.cost then
				UIController:createMessagePopup({
					message = `You need {Functions.suffixes(nextUpgrade.cost - (data.gems or 0))} more gems to buy this upgrade!`,
					reOpen = "UpgradesFrame",
				})
				return
			end

			if UpgradeService:upgrade(upgradeName) == "success" then
				SoundController:play("Upgrade")
			end
		end)
	end
end

function UpgradesFrame.update(self)
	local data = DataController.data
	if not data then return end

	for upgradeName, upgradeData in UpgradesList do
		local frameName = Functions.toPascal(upgradeName)
		local frame = Holder:FindFirstChild(frameName)
		if not frame then continue end

		local main = frame:FindFirstChild("Main")
		if not main then continue end

		local level = getLevel(data, upgradeName)
		local maxLevel = #upgradeData.upgrades

		main.UpgradeAmount.Text = `({level}/{maxLevel})`

		local nextUpgrade = upgradeData.upgrades[level + 1]

		local gems = main:FindFirstChild("Gems")
		if gems then
			gems.Visible = nextUpgrade ~= nil
		end

		local upgradeBtn = main:FindFirstChild("Upgrade")
		if upgradeBtn then
			upgradeBtn.Visible = nextUpgrade ~= nil
		end

		local maxed = main:FindFirstChild("Maxed")
		if maxed then
			maxed.Visible = nextUpgrade == nil
		end

		if nextUpgrade and gems then
			local label = gems:FindFirstChild("Label")
			if label then
				label.Text = Functions.suffixes(nextUpgrade.cost)
			end
		end

		if upgradeData.requiredMap then
			local locked = main:FindFirstChild("Locked")
			if locked then
				locked.Visible = not (data.maps and data.maps[upgradeData.requiredMap])
			end
		end
	end
end

function UpgradesFrame.onSet(self)
	DataController.replica:OnSet({"upgrades"}, function()
		self:update()
	end)
end

function UpgradesFrame.opened(self)
	self:update()
end

function UpgradesFrame.Start(self)
	self:setupFrames()
	self:onSet()
	self:opened()
	UIController:listenToOpen("UpgradesFrame"):Connect(function()
		self:opened()
	end)
end

function UpgradesFrame.Construct(self)
	UpgradeService = Knit.GetService("UpgradeService")
	DataController = Knit.GetController("DataController")
	UIController = Knit.GetController("UIController")
	SoundController = Knit.GetController("SoundController")
	Button = require(Knit.Modules.Button)
	Functions = require(game:GetService("ReplicatedStorage").Shared.Functions)
	UpgradesList = require(game:GetService("ReplicatedStorage").Shared.List.Upgrades)
end

return UpgradesFrame