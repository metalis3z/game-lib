--credit to prince games studio
--[[
	CrateShopService
	Server side for Props Shop crates, crate opening, prop tools, and prop restock.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local CrateData = require(ReplicatedStorage.SharedModules.CrateData)
local GameServerAPI = require(ServerScriptService.GameServerAPI)

local RESTOCK_INTERVAL = 60
local StockValues = ReplicatedStorage:WaitForChild("StockValues")
local CrateShopStock = StockValues:FindFirstChild("CrateShop")
local CrateItems = CrateShopStock and CrateShopStock:FindFirstChild("Items")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local PropsFolder = Assets:WaitForChild("Props")
local CratesFolder = Assets:FindFirstChild("Crates")

local crateCounts = {}
local propCounts = {}
local placedProps = {}

local function ensureCounts(t, uid)
	t[uid] = t[uid] or {}
	return t[uid]
end

local function waitApi(name, timeout)
	local started = os.clock()
	while GameServerAPI[name] == nil do
		if timeout and os.clock() - started > timeout then
			return nil
		end
		task.wait()
	end
	return GameServerAPI[name]
end

local function findTool(player, attrName, attrValue)
	for _, container in ipairs({ player:FindFirstChildOfClass("Backpack"), player.Character }) do
		if container then
			for _, item in ipairs(container:GetChildren()) do
				if item:IsA("Tool") and item:GetAttribute(attrName) == attrValue then
					return item
				end
			end
		end
	end
	return nil
end

local function prepPart(part)
	part.Anchored = false
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Massless = true
end

local function decorateToolWithHandle(tool, source)
	tool.RequiresHandle = false
	if not source then return end
	local clone = source:Clone()
	local handle
	if clone:IsA("BasePart") then
		handle = clone
	elseif clone:IsA("Model") then
		handle = clone.PrimaryPart or clone:FindFirstChild("Handle") or clone:FindFirstChildWhichIsA("BasePart", true)
	else
		handle = clone:FindFirstChild("Handle") or clone:FindFirstChildWhichIsA("BasePart", true)
	end
	if not handle then
		clone:Destroy()
		return
	end
	local parts = clone:IsA("BasePart") and { clone } or clone:GetDescendants()
	for _, d in ipairs(parts) do
		if d:IsA("BasePart") then
			prepPart(d)
			if d ~= handle then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = handle
				weld.Part1 = d
				weld.Parent = handle
			end
		end
	end
	handle.Name = "Handle"
	if clone:IsA("BasePart") then
		clone.Parent = tool
	else
		for _, child in ipairs(clone:GetChildren()) do
			child.Parent = tool
		end
		clone:Destroy()
	end
	tool.RequiresHandle = true
end

local function syncCrateTool(player, crateName)
	local count = (crateCounts[player.UserId] and crateCounts[player.UserId][crateName]) or 0
	local tool = findTool(player, "Crate", crateName)
	if count <= 0 then
		if tool then tool:Destroy() end
		return
	end
	if not tool then
		tool = Instance.new("Tool")
		tool:SetAttribute("Crate", crateName)
		tool:SetAttribute("CrateName", crateName)
		tool.CanBeDropped = false
		decorateToolWithHandle(tool, CratesFolder and CratesFolder:FindFirstChild(crateName))
		tool.Parent = player:WaitForChild("Backpack")
	end
	tool.Name = crateName .. " x" .. count
	tool:SetAttribute("Count", count)
	tool:SetAttribute("RemainingCount", count)
end

local function syncPropTool(player, propName)
	local count = (propCounts[player.UserId] and propCounts[player.UserId][propName]) or 0
	local tool = findTool(player, "PropName", propName) or findTool(player, "Build", propName)
	if count <= 0 then
		if tool then tool:Destroy() end
		return
	end
	if not tool then
		tool = Instance.new("Tool")
		tool:SetAttribute("Build", propName)
		tool:SetAttribute("PropName", propName)
		tool.CanBeDropped = false
		decorateToolWithHandle(tool, PropsFolder:FindFirstChild(propName))
		tool.Parent = player:WaitForChild("Backpack")
	end
	tool.Name = propName .. " x" .. count
	tool:SetAttribute("RemainingCount", count)
	tool:SetAttribute("Count", count)
end

local function giveCrate(player, crateName, amount)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then return false end
	if not CrateData.GetData(crateName) then return false end
	amount = math.clamp(math.floor(tonumber(amount) or 1), 1, 1000)
	local counts = ensureCounts(crateCounts, player.UserId)
	counts[crateName] = (counts[crateName] or 0) + amount
	syncCrateTool(player, crateName)
	return true
end

local function giveProp(player, propName, amount)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then return false end
	if not PropsFolder:FindFirstChild(propName) then return false end
	amount = math.clamp(math.floor(tonumber(amount) or 1), 1, 1000)
	local counts = ensureCounts(propCounts, player.UserId)
	counts[propName] = (counts[propName] or 0) + amount
	syncPropTool(player, propName)
	return true
end

local function removeCrate(player, crateName, amount)
	amount = math.max(1, math.floor(tonumber(amount) or 1))
	local counts = ensureCounts(crateCounts, player.UserId)
	if (counts[crateName] or 0) < amount then return false end
	counts[crateName] -= amount
	syncCrateTool(player, crateName)
	return true
end

local function removeProp(player, propName, amount)
	amount = math.max(1, math.floor(tonumber(amount) or 1))
	local counts = ensureCounts(propCounts, player.UserId)
	if (counts[propName] or 0) < amount then return false end
	counts[propName] -= amount
	syncPropTool(player, propName)
	return true
end

local function rollStockValue(data)
	local range = data and data.RestockValues
	if typeof(range) == "NumberRange" then
		return math.random(math.floor(range.Min), math.floor(range.Max))
	end
	return 1
end

local function restockCrateShop()
	if not CrateItems then return false end
	for _, crate in ipairs(CrateData.GetAllCrates()) do
		local nv = CrateItems:FindFirstChild(crate.Name)
		if not nv then
			nv = Instance.new("NumberValue")
			nv.Name = crate.Name
			nv.Parent = CrateItems
		end
		local chance = tonumber(crate.RestockChance) or 100
		nv.Value = (math.random() * 100 <= chance) and rollStockValue(crate) or 0
	end
	local now = os.time()
	local last = CrateShopStock and CrateShopStock:FindFirstChild("UnixLastRestock")
	local nextValue = CrateShopStock and CrateShopStock:FindFirstChild("UnixNextRestock")
	if last then last.Value = now end
	if nextValue then nextValue.Value = now + RESTOCK_INTERVAL end
	local reset = GameServerAPI.ResetPurchases
	if reset then
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(reset, player, "Crates")
		end
	end
	return true
end

local function purchaseCrate(player, crateName)
	local data = CrateData.GetData(crateName)
	if not data then return false, "no-entry" end
	local nv = CrateItems and CrateItems:FindFirstChild(crateName)
	local maxStock = (nv and nv:IsA("NumberValue")) and nv.Value or 0
	local getPurchaseCount = GameServerAPI.GetPurchaseCount
	local purchased = getPurchaseCount and getPurchaseCount(player, "Crates", crateName) or 0
	if maxStock - purchased <= 0 then return false, "no-stock" end
	local price = tonumber(data.Cost) or 0
	local getSheckles = waitApi("GetSheckles", 10)
	local addSheckles = waitApi("AddSheckles", 10)
	if not getSheckles or not addSheckles then return false, "economy-not-ready" end
	if getSheckles(player) < price then return false, "no-sheckles" end
	addSheckles(player, -price)
	local inc = GameServerAPI.IncrementPurchase
	if inc then inc(player, "Crates", crateName) end
	giveCrate(player, crateName, 1)
	local sfx = GameServerAPI.PlaySFX
	if sfx then sfx(player, "Purchase") end
	return true
end

local function firePacketAll(packet, ...)
	if not packet then return end
	if packet.FireAllClients then
		packet:FireAllClients(...)
	elseif packet.FireAll then
		packet:FireAll(...)
	elseif packet.FireClient then
		for _, plr in ipairs(Players:GetPlayers()) do
			packet:FireClient(plr, ...)
		end
	end
end

local function openCrate(player, crateName)
	local data = CrateData.GetData(crateName)
	if not data then return { Success = false, Error = "no-entry" } end
	if not removeCrate(player, crateName, 1) then return { Success = false, Error = "no-crate" } end
	local item = CrateData.GetRandomItem(crateName)
	if not item then return { Success = false, Error = "empty-crate" } end
	local won = table.clone(item)
	won.CrateName = crateName
	won.Image = won.Image or won.IMG or data.IMG
	won.IsBestItem = won.IsBestItem or false
	if data.CrateType == "Fence" then
		player:SetAttribute("UnlockedFence_" .. tostring(won.Name), true)
	else
		giveProp(player, won.Name, 1)
	end
	local result = { Success = true, WonItem = won }
	firePacketAll(Networking.Crate and Networking.Crate.ReplicateOpenCrate, player, result)
	return result
end

local function placeProp(player, worldPos, propName, tool, rotDeg)
	if typeof(worldPos) ~= "Vector3" or type(propName) ~= "string" then return false end
	if typeof(tool) ~= "Instance" or not tool:IsA("Tool") then return false end
	if tool:GetAttribute("PropName") ~= propName and tool:GetAttribute("Build") ~= propName then return false end
	if not removeProp(player, propName, 1) then return false end
	local uid = player.UserId
	local id = HttpService:GenerateGUID(false)
	local data = {
		PlacedAt = os.time(),
		V = 1,
		Positions = { PosX = worldPos.X, PosY = worldPos.Y, PosZ = worldPos.Z, Rotation = tonumber(rotDeg) or 0 },
		PropName = propName,
	}
	ensureCounts(placedProps, uid)[id] = data
	firePacketAll(Networking.Prop and Networking.Prop.PropPlaced, uid, id, data)
	return true
end

local function pickupProp(player, propId)
	local uid = player.UserId
	local props = placedProps[uid]
	local data = props and props[propId]
	if not data then return false end
	props[propId] = nil
	giveProp(player, data.PropName, 1)
	firePacketAll(Networking.Prop and Networking.Prop.PropRemoved, uid, propId)
	return true
end

-- Register APIs before touching packet hooks so store/product grants work even if a UI packet changes.
GameServerAPI.GiveCrate = giveCrate
GameServerAPI.GiveProp = giveProp
GameServerAPI.RemoveProp = removeProp
GameServerAPI.RestockCrateShop = restockCrateShop
GameServerAPI.PurchaseCrate = purchaseCrate
GameServerAPI.OpenCrate = openCrate
GameServerAPI.PlaceProp = placeProp
GameServerAPI.PickupProp = pickupProp

local function connectPacket(packet, callback)
	if packet and packet.OnServerEvent and packet.OnServerEvent.Connect then
		local ok, err = pcall(function()
			packet.OnServerEvent:Connect(callback)
		end)
		if not ok then warn("[CrateShopService] packet connect failed: " .. tostring(err)) end
	end
end

connectPacket(Networking.CrateShop and Networking.CrateShop.PurchaseCrate, purchaseCrate)
if Networking.Crate and Networking.Crate.OpenCrate then
	Networking.Crate.OpenCrate.OnServerInvoke = openCrate
end
connectPacket(Networking.Prop and Networking.Prop.PlaceProp, placeProp)
connectPacket(Networking.Prop and Networking.Prop.PickupProp, pickupProp)

Players.PlayerAdded:Connect(function(player)
	crateCounts[player.UserId] = crateCounts[player.UserId] or {}
	propCounts[player.UserId] = propCounts[player.UserId] or {}
	placedProps[player.UserId] = placedProps[player.UserId] or {}
end)
Players.PlayerRemoving:Connect(function(player)
	crateCounts[player.UserId] = nil
	propCounts[player.UserId] = nil
	placedProps[player.UserId] = nil
end)
for _, player in ipairs(Players:GetPlayers()) do
	crateCounts[player.UserId] = crateCounts[player.UserId] or {}
	propCounts[player.UserId] = propCounts[player.UserId] or {}
	placedProps[player.UserId] = placedProps[player.UserId] or {}
end

task.defer(function()
	if CrateItems then
		local any = false
		for _, child in ipairs(CrateItems:GetChildren()) do
			if child:IsA("NumberValue") and child.Value > 0 then any = true; break end
		end
		if not any then restockCrateShop() end
	end
end)

task.spawn(function()
	while task.wait(5) do
		local nextValue = CrateShopStock and CrateShopStock:FindFirstChild("UnixNextRestock")
		if nextValue and os.time() >= nextValue.Value then
			restockCrateShop()
		end
	end
end)

print("[CrateShopService] ready")
