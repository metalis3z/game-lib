local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local DataService = require(ReplicatedStorage.Packages.DataService).server
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)
local TutorialServiceUtils = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceUtils)

local ZonesService = {}

local function getZoneSpawnPosition(zoneId: number): Vector3?
	local zonesFolder = Workspace:FindFirstChild("Zones")
	if not zonesFolder then return nil end

	local zoneModel = zonesFolder:FindFirstChild(tostring(zoneId))
	if not zoneModel then return nil end

	local spawn = zoneModel:FindFirstChild("Spawn")
		or zoneModel:FindFirstChildWhichIsA("SpawnLocation")
	if spawn and spawn:IsA("BasePart") then
		return spawn.Position + Vector3.new(0, 5, 0)
	end

	local primary = zoneModel.PrimaryPart
	if primary then
		return primary.Position + Vector3.new(0, 5, 0)
	end

	local ok, cf = pcall(function() return zoneModel:GetPivot() end)
	if ok then
		return cf.Position + Vector3.new(0, 5, 0)
	end

	return nil
end

local function teleportPlayerToZone(player: Player, zoneId: number)
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp or not hrp:IsA("BasePart") then return end

	local pos = getZoneSpawnPosition(zoneId)
	if pos then
		hrp.CFrame = CFrame.new(pos)
	end
end

function ZonesService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[ZonesService] Could not find _remotes")
		return
	end

	local zonesRemotes = remotes:WaitForChild("ZonesService", 10)
	if not zonesRemotes then
		warn("[ZonesService] Could not find ZonesService remotes")
		return
	end

	local remoteFunction = zonesRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[ZonesService] Invoked - method:", method, "player:", player.Name)
			if method == "requestPurchaseZone" then
				return self:requestPurchaseZone(player)
			elseif method == "requestTeleportZone" then
				return self:requestTeleportZone(player, ...)
			end
			warn("[ZonesService] Unknown method:", method)
			return false, nil
		end
		print("[ZonesService] OnServerInvoke set successfully")
	else
		warn("[ZonesService] RemoteFunction not found")
	end

	local remoteEvent = zonesRemotes:FindFirstChild("RemoteEvent")
	if remoteEvent then
		remoteEvent.OnServerEvent:Connect(function(player: Player, method: string, ...)
			if method == "requestTeleportZone" then
				self:requestTeleportZone(player, ...)
			end
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			task.wait(1)
			local data = DataService:waitForData(player)
			if not data then return end
			local zoneId = math.max(data:get("zone") or 1, 1)
			if zonesRemotes and zonesRemotes:FindFirstChild("RemoteEvent") then
				zonesRemotes.RemoteEvent:FireClient(player, "zoneEntered", zoneId)
			end
		end)
	end)

	print("[ZonesService] Initialized")
end

function ZonesService:requestPurchaseZone(player: Player)
	local data = DataService:waitForData(player)
	if not data then
		return false, "No data"
	end

	local currentMax = math.max(data:get("maxZone") or 1, 1)
	local nextZoneId = currentMax + 1

	if not Zones.hasZone(nextZoneId) then
		return false, "Zone does not exist"
	end

	local tutorialData = data:get("tutorial")
	if not TutorialServiceUtils.canPurchaseZone(tutorialData, nextZoneId) then
		return false, "Zone locked during tutorial"
	end

	local zoneInfo = Zones.getZone(nextZoneId)
	local price = zoneInfo.price or 0

	local coins = data:get("coins") or 0
	if coins < price then
		return false, "Not enough coins"
	end

	if price > 0 then
		DataService:set(player, "coins", coins - price)
	end

	local newMax = nextZoneId
	DataService:set(player, "maxZone", newMax)
	DataService:set(player, "furthestZone", math.max(data:get("furthestZone") or 1, newMax))

	task.spawn(teleportPlayerToZone, player, nextZoneId)

	DataService:set(player, "zone", nextZoneId)

	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:FindFirstChild("_remotes")
	local zonesRemotes = remotes and remotes:FindFirstChild("ZonesService")
	if zonesRemotes and zonesRemotes:FindFirstChild("RemoteEvent") then
		zonesRemotes.RemoteEvent:FireClient(player, "zoneEntered", nextZoneId)
	end

	print("[ZonesService]", player.Name, "purchased zone", nextZoneId,
		"for", price, "coins | new balance:", coins - price)

	return true, nextZoneId
end

function ZonesService:requestTeleportZone(player: Player, targetZoneId: number)
	if type(targetZoneId) ~= "number" then
		return false, "Invalid zone"
	end

	targetZoneId = math.floor(targetZoneId)

	if not Zones.hasZone(targetZoneId) then
		return false, "Zone does not exist"
	end

	local data = DataService:waitForData(player)
	if not data then
		return false, "No data"
	end

	local maxZone = math.max(data:get("maxZone") or 1, 1)
	if targetZoneId > maxZone then
		return false, "Zone not unlocked"
	end

	DataService:set(player, "zone", targetZoneId)
	task.spawn(teleportPlayerToZone, player, targetZoneId)

	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:FindFirstChild("_remotes")
	local zonesRemotes = remotes and remotes:FindFirstChild("ZonesService")
	if zonesRemotes and zonesRemotes:FindFirstChild("RemoteEvent") then
		zonesRemotes.RemoteEvent:FireClient(player, "zoneEntered", targetZoneId)
	end

	print("[ZonesService]", player.Name, "teleported to zone", targetZoneId)

	return true, targetZoneId
end

return ZonesService