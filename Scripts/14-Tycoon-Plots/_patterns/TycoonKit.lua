--!strict
-- TycoonKit (pattern module)
-- A modern, data-driven version of the classic "buttons + droppers + conveyor + collector" tycoon.
--
-- Ideas taken from: advanced-warfare-tycoon (berezaa's kit: buttons that clone a stored purchase in,
-- dependencies that reveal the next button, collector + giver pad, upgrader adding value) and
-- scp-tycoon (droppers with a cooldown, upgrader that only boosts each drop once, owner-only laser).
-- Fixes the classic kit's problems: no wait() loops per dropper script, no money in ServerStorage
-- values, purchases are saved/loaded as a list of names, and every check runs on the server.
--
-- Expected tycoon model layout (all names configurable below):
--   MyTycoon (Model)
--     Buttons (Folder)
--       BuyDropper1 (Model)  attributes: Price = 100, Item = "Dropper1", Dependency = "" (optional)
--         Head (BasePart)    -- touched by the owner to buy
--     Items (Folder)         -- every purchasable Model, named like the button's Item attribute.
--       Dropper1 (Model)     attributes: DropValue = 5, DropInterval = 2
--         DropPoint (BasePart)
--       Upgrader1 (Model)    attributes: UpgradeAdd = 3   (or UpgradeMultiply = 2)
--         UpgradePart (BasePart)
--       Conveyor1 (Model)
--         Belt (BasePart)    attribute: ConveyorSpeed = 12  (pushes along the part's LookVector)
--     Collector (BasePart)   -- drops that touch it are turned into stored cash
--     Giver (BasePart)       -- owner touches it to receive stored cash
--
-- Usage (server):
--   local TycoonKit = require(path.to.TycoonKit)
--   local tycoon = TycoonKit.new(workspace.Tycoons.Red, {
--       GetCash = function(player) return Data.Get(player).Cash end,
--       SpendCash = function(player, amount) ... return true/false end,
--       AddCash = function(player, amount) ... end,
--   })
--   tycoon:SetOwner(player)                       -- e.g. from PlotManager.PlotAssigned
--   tycoon:LoadPurchased(savedData.Purchased or {}) -- restore saved buildings
--   ... on leave: savedData.Purchased = tycoon:GetPurchased(); tycoon:SetOwner(nil)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

export type Economy = {
	GetCash: (player: Player) -> number,
	SpendCash: (player: Player, amount: number) -> boolean,
	AddCash: (player: Player, amount: number) -> (),
}

local MAX_DROPS_PER_TYCOON = 120 -- safety cap so an AFK tycoon can't flood the server
local DROP_LIFETIME = 30
local BUTTON_DEBOUNCE = 0.5

local TycoonKit = {}
TycoonKit.__index = TycoonKit

local function setVisible(model: Instance, visible: boolean)
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Transparency = if visible then (d:GetAttribute("BaseTransparency") or 0) else 1
			d.CanCollide = visible and (d:GetAttribute("BaseCanCollide") ~= false)
			d.CanTouch = visible
		elseif d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
			d.Enabled = visible
		end
	end
end

local function rememberLook(model: Instance)
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") and d:GetAttribute("BaseTransparency") == nil then
			d:SetAttribute("BaseTransparency", d.Transparency)
			d:SetAttribute("BaseCanCollide", d.CanCollide)
		end
	end
end

function TycoonKit.new(model: Model, economy: Economy)
	local self = setmetatable({}, TycoonKit)
	self.Model = model
	self.Economy = economy
	self.Owner = nil :: Player?
	self.Purchased = {} :: { [string]: boolean }
	self.Stored = 0
	self.Drops = {} :: { BasePart }
	self.Connections = {} :: { RBXScriptConnection }
	self.Templates = {} :: { [string]: Model }
	self.ButtonByItem = {} :: { [string]: Model }
	self.DropperTimers = {} :: { [Model]: number }

	local items = model:FindFirstChild("Items")
	assert(items, "Tycoon needs an Items folder")
	-- Keep a template of every purchasable and remove it from the world.
	for _, item in ipairs(items:GetChildren()) do
		if item:IsA("Model") then
			self.Templates[item.Name] = item:Clone()
			item:Destroy()
		end
	end
	self.Built = Instance.new("Folder")
	self.Built.Name = "Built"
	self.Built.Parent = model

	self.DropFolder = Instance.new("Folder")
	self.DropFolder.Name = "Drops"
	self.DropFolder.Parent = model

	local buttons = model:FindFirstChild("Buttons")
	assert(buttons, "Tycoon needs a Buttons folder")
	for _, button in ipairs(buttons:GetChildren()) do
		if button:IsA("Model") then
			self:_setupButton(button)
		end
	end

	self:_setupCollector()
	table.insert(self.Connections, RunService.Heartbeat:Connect(function(dt)
		self:_step(dt)
	end))
	self:_refreshButtons()
	return self
end

-- Buttons ---------------------------------------------------------------

function TycoonKit:_setupButton(button: Model)
	local itemName = button:GetAttribute("Item")
	local head = button:FindFirstChild("Head")
	if typeof(itemName) ~= "string" or not head or not head:IsA("BasePart") then
		warn("[TycoonKit] Button missing Item attribute or Head:", button:GetFullName())
		return
	end
	if not self.Templates[itemName] then
		warn("[TycoonKit] Button points at a missing item:", itemName)
		return
	end
	rememberLook(button)
	self.ButtonByItem[itemName] = button
	local lastTouch = 0
	table.insert(self.Connections, head.Touched:Connect(function(hit)
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		if not player or player ~= self.Owner then
			return
		end
		local humanoid = hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return
		end
		local now = os.clock()
		if now - lastTouch < BUTTON_DEBOUNCE then
			return
		end
		lastTouch = now
		self:Buy(player, itemName)
	end))
end

function TycoonKit:_isUnlocked(itemName: string): boolean
	local button = self.ButtonByItem[itemName]
	if not button then
		return false
	end
	local dep = button:GetAttribute("Dependency")
	return dep == nil or dep == "" or self.Purchased[dep] == true
end

function TycoonKit:_refreshButtons()
	for itemName, button in pairs(self.ButtonByItem) do
		local show = self.Owner ~= nil and not self.Purchased[itemName] and self:_isUnlocked(itemName)
		setVisible(button, show)
	end
end

-- Returns true if bought. Every check happens here on the server.
function TycoonKit:Buy(player: Player, itemName: string): boolean
	if player ~= self.Owner or self.Purchased[itemName] or not self:_isUnlocked(itemName) then
		return false
	end
	local button = self.ButtonByItem[itemName]
	local price = button and button:GetAttribute("Price")
	if typeof(price) ~= "number" or price < 0 then
		return false
	end
	if not self.Economy.SpendCash(player, price) then
		return false
	end
	self:_build(itemName)
	self:_refreshButtons()
	return true
end

function TycoonKit:_build(itemName: string)
	if self.Purchased[itemName] then
		return
	end
	local template = self.Templates[itemName]
	if not template then
		return
	end
	self.Purchased[itemName] = true
	local item = template:Clone()
	item.Parent = self.Built
	-- Conveyors: push anything resting on the belt along its LookVector.
	for _, part in ipairs(item:GetDescendants()) do
		if part:IsA("BasePart") then
			local speed = part:GetAttribute("ConveyorSpeed")
			if typeof(speed) == "number" then
				part.Anchored = true
				part.AssemblyLinearVelocity = part.CFrame.LookVector * speed
			end
		end
	end
	-- Upgraders
	local upgradePart = item:FindFirstChild("UpgradePart")
	if upgradePart and upgradePart:IsA("BasePart") then
		local key = "Upgraded_" .. item.Name
		table.insert(self.Connections, upgradePart.Touched:Connect(function(hit)
			if hit.Parent ~= self.DropFolder or hit:GetAttribute(key) then
				return
			end
			hit:SetAttribute(key, true) -- each upgrader boosts a drop only once
			local value = hit:GetAttribute("Value") or 0
			local add = item:GetAttribute("UpgradeAdd")
			local mult = item:GetAttribute("UpgradeMultiply")
			if typeof(add) == "number" then
				value += add
			end
			if typeof(mult) == "number" then
				value *= mult
			end
			hit:SetAttribute("Value", value)
		end))
	end
	-- Droppers are driven by the shared Heartbeat in _step (no loop per dropper).
	if item:GetAttribute("DropValue") then
		self.DropperTimers[item] = 0
	end
end

-- Droppers + collector ---------------------------------------------------

function TycoonKit:_spawnDrop(dropper: Model)
	if #self.DropFolder:GetChildren() >= MAX_DROPS_PER_TYCOON then
		return
	end
	local point = dropper:FindFirstChild("DropPoint")
	if not point or not point:IsA("BasePart") then
		return
	end
	local drop = Instance.new("Part")
	drop.Name = "Drop"
	drop.Size = Vector3.new(1, 1, 1)
	drop.Material = Enum.Material.SmoothPlastic
	drop.Color = point.Color
	drop.CFrame = point.CFrame * CFrame.new(0, -1, 0)
	drop.CanQuery = false
	drop:SetAttribute("Value", dropper:GetAttribute("DropValue") or 1)
	drop.Parent = self.DropFolder
	-- Let the server simulate drops so collection can't be faked by the owner's client.
	pcall(drop.SetNetworkOwner, drop, nil)
	task.delay(DROP_LIFETIME, function()
		if drop.Parent then
			drop:Destroy()
		end
	end)
end

function TycoonKit:_step(dt: number)
	if not self.Owner then
		return
	end
	for dropper, elapsed in pairs(self.DropperTimers) do
		if not dropper.Parent then
			self.DropperTimers[dropper] = nil
			continue
		end
		elapsed += dt
		local interval = dropper:GetAttribute("DropInterval") or 2
		if elapsed >= interval then
			elapsed -= interval
			self:_spawnDrop(dropper)
		end
		self.DropperTimers[dropper] = elapsed
	end
end

function TycoonKit:_setupCollector()
	local collector = self.Model:FindFirstChild("Collector")
	if collector and collector:IsA("BasePart") then
		table.insert(self.Connections, collector.Touched:Connect(function(hit)
			if hit.Parent == self.DropFolder and not hit:GetAttribute("Collected") then
				hit:SetAttribute("Collected", true)
				self.Stored += hit:GetAttribute("Value") or 0
				self.Model:SetAttribute("StoredCash", self.Stored) -- for a billboard on the client
				hit:Destroy()
			end
		end))
	end
	local giver = self.Model:FindFirstChild("Giver")
	if giver and giver:IsA("BasePart") then
		local lastPay = 0
		table.insert(self.Connections, giver.Touched:Connect(function(hit)
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if not player or player ~= self.Owner or self.Stored <= 0 then
				return
			end
			if os.clock() - lastPay < 0.25 then
				return
			end
			lastPay = os.clock()
			local amount = self.Stored
			self.Stored = 0
			self.Model:SetAttribute("StoredCash", 0)
			self.Economy.AddCash(player, amount)
		end))
	end
end

-- Ownership + saving ------------------------------------------------------

function TycoonKit:SetOwner(player: Player?)
	if player == nil then
		-- Reset: remove buildings, drops and stored cash.
		self.Built:ClearAllChildren()
		self.DropFolder:ClearAllChildren()
		table.clear(self.Purchased)
		table.clear(self.DropperTimers)
		self.Stored = 0
	end
	self.Owner = player
	self.Model:SetAttribute("OwnerUserId", if player then player.UserId else 0)
	self.Model:SetAttribute("StoredCash", self.Stored)
	self:_refreshButtons()
end

function TycoonKit:GetPurchased(): { string }
	local list = {}
	for name in pairs(self.Purchased) do
		table.insert(list, name)
	end
	return list
end

function TycoonKit:LoadPurchased(list: { string })
	for _, name in ipairs(list) do
		if typeof(name) == "string" then
			self:_build(name)
		end
	end
	self:_refreshButtons()
end

function TycoonKit:Destroy()
	for _, c in ipairs(self.Connections) do
		c:Disconnect()
	end
	table.clear(self.Connections)
end

return TycoonKit
