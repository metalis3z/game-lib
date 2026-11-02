-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Private = script.Private
local ServiceToBatchMethod = require(Private.ServiceToBatchMethod)
local TypeInterfaces = require(Private.TypeInterfaces)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local t = {}

t.__index = t
function t.Hook(p1, p2) --[[ Hook | Line: 22 | Upvalues: TypeInterfaces (copy), v1 (copy), ServiceToBatchMethod (copy) ]]
	assert(TypeInterfaces(p1, p2))

	local v2 = if typeof(p1._script) == "Instance" then p1._script else false

	local function Compile(p12, ...) --[[ Compile | Line: 27 | Upvalues: p1 (copy) ]]
		if typeof(p12) ~= "table" then
			return
		end

		for v1, v2 in p12 do
			local t = { v2:gsub("__sync_service", "") }
			local v3 = p1[t[1]]
			local t2 = { v3, p1, ... }

			if t[2] == 0 then
				table.remove(t2, 2)
			end

			if typeof(v3) == "function" then
				task.spawn(unpack(t2))
			end
		end
	end

	return function(...) --[[ Line: 48 | Upvalues: v2 (copy), v1 (ref), p1 (copy), p2 (copy), ServiceToBatchMethod (ref), Compile (copy) ]]
		if v2 then
			if v2:GetAttribute("__services_locked") then
				return "__locked"
			end

			v2:SetAttribute("__services_locked", true)
		else
			v1:AtWarning():Log("Instance not found during services initialization. (could cause duplication):", p1, "(Compiler):", p2)
		end

		if typeof(p1.__intercept_services) == "function" then
			p1:__intercept_services(...)
		end

		for v12, v22 in p2 do
			local v3 = if typeof(v12) == "string" then game:GetService(v12) else false

			if v3 and typeof(v22) == "table" then
				local v4 = ServiceToBatchMethod[v12]

				if typeof(v22.__deploy) == "table" and v4 then
					for v5, v6 in v3[v4](v3) do
						Compile(v22.__deploy, v6)
					end
				end

				for v7, v8 in v22 do
					local v9 = not v7:match("__") and v3[v7]

					if v9 then
						v9:Connect(function(...) --[[ Line: 86 | Upvalues: Compile (ref), v8 (copy) ]]
							Compile(v8, ...)
						end)
					end
				end
			end
		end
	end
end

return t