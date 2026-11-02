local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CodesService = require(ServerScriptService.Services.CodesService)
local Gears = require(ReplicatedStorage.Shared.Gears)

local module = function(Conch, Config)
	Conch.register("globalgearcreatecode", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind = "argument", type = "string", name = "CodeName" },
				{ kind = "argument", type = "string", name = "GearName" },
				{ kind = "argument", type = "number", name = "Limit", optional = true }
		end,
		callback = function(codeName, gearName, limit)
			if not codeName or codeName == "" then
				return "Code name must not be empty!"
			end

			if not gearName or gearName == "" then
				return "Gear name must not be empty!"
			end

			if not Gears.IsTradable(gearName) then
				return string.format("Gear '%s' not found or not tradable!", tostring(gearName))
			end

			local ok, reason = CodesService.CreateGlobalGearCode(codeName, gearName, limit)
			if not ok then
				return "Failed: " .. tostring(reason or "unknown error")
			end

			local limitStr = limit and tostring(limit) or "unlimited"
			return string.format("Global gear code '%s' created! Gear: %s | Limit: %s ✅", string.upper(codeName), gearName, limitStr)
		end,
	})
end

return module