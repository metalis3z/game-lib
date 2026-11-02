--[[
	FFlagService — Feature flag management
	Loads flag defaults from ReplicatedStorage.Shared.List.FFlags
	and exposes them via GetFFlag(name) for server-side consumers.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

------------------------------------------------------------------------
-- FFlagService
------------------------------------------------------------------------
local FFlagService = Knit.CreateService({
	Name = "FFlagService",
	Client = {
		fFlagChanged = Knit.CreateSignal(),
	},

	_fFlags = {},
})

------------------------------------------------------------------------
-- Server-side API
------------------------------------------------------------------------

-- Returns the current value for a named feature flag.
-- Returns nil if the flag does not exist.
function FFlagService:GetFFlag(name)
	return self._fFlags[name]
end

-- Alias for shared modules (Values.Luck) that use camelCase
FFlagService.getFFlag = FFlagService.GetFFlag

------------------------------------------------------------------------
-- Knit lifecycle
------------------------------------------------------------------------
function FFlagService:KnitInit()
	local flagsConfig = require(ReplicatedStorage.Shared.List.FFlags)

	-- flagsConfig is a dictionary: { [id] = { name = "...", default = bool } }
	for id, entry in pairs(flagsConfig) do
		self._fFlags[id] = entry.default
	end

	print("[FFlagService] Loaded", (function()
		local n = 0
		for _ in pairs(self._fFlags) do n += 1 end
		return n
	end)(), "feature flags")
end

function FFlagService:KnitStart()
	print("[FFlagService] Started")
end

return FFlagService
