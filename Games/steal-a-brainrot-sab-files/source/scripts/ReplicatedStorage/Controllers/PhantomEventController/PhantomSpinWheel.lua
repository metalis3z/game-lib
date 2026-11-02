

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Datas = ReplicatedStorage:WaitForChild("Datas")
local PhantomSpinWheel = require(Datas.PhantomSpinWheel)
local Shop = require(Datas.Shop)
local Utils = ReplicatedStorage:WaitForChild("Utils")
local TimeUtils = require(Utils.TimeUtils)
local NumberUtils = require(Utils.NumberUtils)
local Controllers = ReplicatedStorage:WaitForChild("Controllers")

require(Controllers.ShopController)

local InterfaceController = require(Controllers.InterfaceController)
local CustomRichTextController = require(Controllers.CustomRichTextController)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Marketplace = require(Shared.Marketplace)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Trove = require(Packages.Trove)
local Timer = require(Packages.Timer)
local Synchronizer = require(Packages.Synchronizer)
local LocalPlayer = Players.LocalPlayer
local t1 = {}

t1.__index = t1

local function IsEnabled()
	return ReplicatedStorage:GetAttribute("PhantomEvent")
end

function t1.new(p1)
	local v23 = Synchronizer:Wait(LocalPlayer)
	local self = setmetatable({}, t1)

	self.Instance = p1
	self.Collector = Trove.new()

	local function setup()
		local Wheel = p1:WaitForChild("Main"):WaitForChild("SurfaceGui").Wheel
		local Items = Wheel.Items
		local Names = Wheel.Names
		local Odds = Wheel.Odds

		for i = 1, #PhantomSpinWheel.Rewards do
			local v33 = PhantomSpinWheel.Rewards[i]

			if v33 then
				if v33.Type == "Item" and v23:Get(`Items.{ v33.Index }`) and PhantomSpinWheel.AltRewards[i] then
					v33 = PhantomSpinWheel.AltRewards[i]
				end

				local i2 = Items:FindFirstChild(i)
				local i3 = Names:FindFirstChild(i)
				local i4 = Odds:FindFirstChild(i)
				local s1 = ""
				local Icon

				if v33.Type == "Cash-Pack" then
					local Value = Shop[v33.Index].Value
					local v39 = v23:Get("Rebirth") or 0

					if v39 > 0 then
						Value *= if not (v39 <= 1) then v39 else 1.5
					end

					s1 = `${ NumberUtils:ToString(Value, 2) }`

					local Index = v33.Index

					Icon = Marketplace:GetProductInfo(Index, "Product").Icon
				else
					Icon = v33.Icon
				end

				local Display = v33.Display
				local v43 = s1 == "" and Display or s1
				local v44 = `{ v33.Weight }%`

				i2.Image = Icon or ""
				CustomRichTextController.apply(i3, v43, {
					attachToInstance = true
				})
				i4.Text = v44
			end
		end
	end

	setup()
	self.Collector:Add(v23:OnDictionaryInserted("Items", function(_: boolean, s2: string)
		local v47 = false

		for i = 1, #PhantomSpinWheel.Rewards do
			local v49 = PhantomSpinWheel.Rewards[i]

			if v49.Type == "Item" and s2 == v49.Index then
				v47 = true

				break
			end
		end

		if v47 then
			setup()
		end
	end))
	self.Collector:Add(RunService.RenderStepped:Connect(function(dt: number)
		debug.profilebegin("PhantomSpinWheel:Rotate3D")

		local Main = self.Instance.Main

		Main.CFrame = Main.CFrame * CFrame.Angles(0, 0, (math.rad(dt * 45)))
		debug.profileend()
	end))
	self.Collector:Add(self.Instance.Root.ProximityPrompt.Triggered:Connect(function()
		InterfaceController:Toggle("PhantomWheel", true)
	end))

	local v26 = Timer.new(1)

	self.Collector:Add(v26, "Destroy")
	self.Collector:Add(v26.Tick:Connect(function()
		if ReplicatedStorage:GetAttribute("PhantomEvent") then
			if v23:Get("PhantomSpinWheel.LastFreeClaimed") ~= ReplicatedStorage:GetAttribute("PhantomEventLastTime") then
				self.Instance.Overhead.BillboardGui.Countdown.Text = "SPIN NOW"

				return
			end

			self.Instance.Overhead.BillboardGui.Countdown.Text = `Free Spin in { TimeUtils:D((ReplicatedStorage:GetAttribute("NextPhantomEvent") or 0) - workspace:GetServerTimeNow()) }`

			return
		end

		self.Instance.Overhead.BillboardGui.Countdown.Text = `Free Spin in { TimeUtils:D((ReplicatedStorage:GetAttribute("NextPhantomEvent") or 0) - workspace:GetServerTimeNow()) }`
	end))
	v26:StartNow()

	return self
end
function t1.Destroy(t2: {[any]: any})
	t2.Collector:Destroy()
end

return t1
