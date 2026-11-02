local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Data
local Datas = ReplicatedStorage:WaitForChild("Datas")
local CyberSpinWheelData = require(Datas.CyberSpinWheel)
local ShopData = require(Datas.Shop)

-- Utils
local Utils = ReplicatedStorage:WaitForChild("Utils")
local TimeUtils = require(Utils.TimeUtils)
local NumberUtils = require(Utils.NumberUtils)

-- Controllers
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
require(Controllers.ShopController)
local InterfaceController = require(Controllers.InterfaceController)

-- Shared
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Marketplace = require(Shared.Marketplace)

-- Packages
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Trove = require(Packages.Trove)
local Timer = require(Packages.Timer)
local Synchronizer = require(Packages.Synchronizer)

local LocalPlayer = Players.LocalPlayer

local CyberSpinWheel = {}
CyberSpinWheel.__index = CyberSpinWheel

function CyberSpinWheel.new(wheelInstance)
	local playerData = Synchronizer:Wait(LocalPlayer)

	local self = setmetatable({}, CyberSpinWheel)
	self.Instance = wheelInstance
	self.Collector = Trove.new()

	-- 🎨 Update visuals
	local function UpdateWheelVisuals()
		local wheelUI = wheelInstance:WaitForChild("Main"):WaitForChild("SurfaceGui").Wheel
		local items = wheelUI.Items
		local names = wheelUI.Names
		local odds = wheelUI.Odds

		for i = 1, #CyberSpinWheelData.Rewards do
			local reward = CyberSpinWheelData.Rewards[i]
			if reward then
				local itemImage = items:FindFirstChild(i)
				local nameLabel = names:FindFirstChild(i)
				local oddsLabel = odds:FindFirstChild(i)

				local text = reward.Display
				local icon = reward.Icon or ""

				if reward.Type == "Cash-Pack" then
					local shopItem = ShopData[reward.Index]
					if shopItem then
						local value = shopItem.Value or 0
						local rebirths = playerData:Get("Rebirth") or 0

						if rebirths > 0 then
							value = value * (rebirths <= 1 and 1.5 or rebirths)
						end

						text = "$" .. NumberUtils:ToString(value, 2)
						icon = Marketplace:GetProductInfo(reward.Index, "Product").Icon
					end
				end

				if itemImage then itemImage.Image = icon end
				if nameLabel then nameLabel.Text = text end
				if oddsLabel then oddsLabel.Text = ("%s%%"):format(reward.Weight) end
			end
		end
	end

	UpdateWheelVisuals()

	-- 🔄 Update if player gets item
	self.Collector:Add(playerData:OnDictionaryInserted("Items", function(_, itemName)
		for i = 1, #CyberSpinWheelData.Rewards do
			local reward = CyberSpinWheelData.Rewards[i]
			if reward.Type == "Item" and itemName == reward.Index then
				UpdateWheelVisuals()
				break
			end
		end
	end))

	-- 🎡 Rotate wheel
	self.Collector:Add(RunService.RenderStepped:Connect(function(dt)
		debug.profilebegin("CyberSpinWheel:Rotate3D")
		local main = self.Instance.Main
		main.CFrame *= CFrame.Angles(math.rad(dt * 45), 0, 0)
		debug.profileend()
	end))

	-- 🖱 Open UI
	self.Collector:Add(self.Instance.Root.ProximityPrompt.Triggered:Connect(function()
		InterfaceController:Toggle("CyberWheel", true)
	end))

	-- ⏱ Billboard timer
	local timer = Timer.new(1)
	self.Collector:Add(timer, "Destroy")

	self.Collector:Add(timer.Tick:Connect(function()
		local isActive = ReplicatedStorage:GetAttribute("CyberEvent")
		local nextTime = ReplicatedStorage:GetAttribute("NextCyberEvent") or 0
		local remaining = nextTime - workspace:GetServerTimeNow()

		local text

		if isActive then
			text = "SPIN NOW"
		else
			text = ("Free Spin in %s"):format(TimeUtils:D(remaining))
		end

		self.Instance.Overhead.BillboardGui.Countdown.Text = text
	end))

	timer:StartNow()

	return self
end

function CyberSpinWheel:Destroy()
	self.Collector:Destroy()
end

return CyberSpinWheel