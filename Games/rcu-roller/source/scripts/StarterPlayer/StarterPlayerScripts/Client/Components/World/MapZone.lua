--[[ MapZone Component
     Detects which map zone the local player is currently in and
     notifies MapController via setCurrentMap(mapId).

     Original decompiled version was disabled because:
     - Zone package's onItemEnter/onItemExit callbacks are broken (CF ANALYSIS FAILED)
       throughout _onItemCallback — they silently do nothing.

     FIX: Use a Heartbeat poll calling zone:findLocalPlayer() instead of the broken
     callback system. findLocalPlayer() uses a spatial overlap query that DOES work.
     Poll every POLL_INTERVAL seconds across all 3 zone instances.
     When local player is found inside a zone, call MapController:setCurrentMap(mapId).
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Knit = require(ReplicatedStorage.Packages.Knit)

local MapZone = require(Knit.Util.Component).new({
	Tag = "MapZone";
})

local POLL_INTERVAL = 0.5 -- seconds between zone checks

local DataController
local MapController
local Zone

function MapZone.Start(self)
	local mapId = self.Instance:GetAttribute("mapId")
	if not mapId then
		warn("[MapZone] Instance has no mapId attribute:", self.Instance:GetFullName())
		return
	end

	-- Create the Zone object from this Part
	local ok, zoneOrErr = pcall(Zone.new, self.Instance)
	if not ok then
		warn("[MapZone] Zone.new failed for", self.Instance:GetFullName(), ":", zoneOrErr)
		return
	end
	self._zone = zoneOrErr

	-- Poll on heartbeat with a timer to avoid per-frame overhead
	local elapsed = 0
	self._heartbeatConn = RunService.Heartbeat:Connect(function(dt)
		elapsed += dt
		if elapsed < POLL_INTERVAL then return end
		elapsed = 0

		-- Safely check if local player is inside this zone
		local ok2, found = pcall(function()
			return self._zone:findLocalPlayer()
		end)
		if not ok2 then return end

		if found then
			-- Player is inside this zone — update current map if not already set
			local currentId = MapController:getCurrentMap(true) -- true = return numeric id
			if currentId ~= mapId then
				MapController:setCurrentMap(mapId)
			end
		end
	end)
end

function MapZone.Stop(self)
	if self._heartbeatConn then
		self._heartbeatConn:Disconnect()
		self._heartbeatConn = nil
	end
	if self._zone then
		pcall(function() self._zone:destroy() end)
		self._zone = nil
	end
end

function MapZone.Construct(self)
	DataController = Knit.GetController("DataController")
	MapController = Knit.GetController("MapController")
	Zone = require(ReplicatedStorage.Packages.Zone)
end

return MapZone
