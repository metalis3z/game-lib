--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Logging = require(ReplicatedStorage.UserGenerated.Logging)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = table.freeze({
	__index = table.freeze({
		Disconnect = function(p1) --[[ Disconnect | Line: 53 ]]
			p1.Connection:Disconnect()
			p1:OnDisconnected()
		end,
		OnDisconnected = function(p1) --[[ OnDisconnected | Line: 58 ]]
			if p1.Vars.Disconnected then
				return
			end

			p1.Vars.Disconnected = true

			for i, v in ipairs(p1.Callbacks) do
				task.spawn(v)
			end

			table.clear(p1.Callbacks)
		end,
		Then = function(p1, p2) --[[ Then | Line: 69 | Upvalues: Asserts (copy) ]]
			Asserts.Function(p2)

			if p1.Vars.Disconnected then
				task.spawn(p2)
			else
				table.insert(p1.Callbacks, p2)
			end
		end
	})
})

function new(p1, p2) --[[ new | Line: 81 | Upvalues: Asserts (copy), v1 (copy), RunService (copy), Logging (copy) ]]
	Asserts.FiniteNonNegative(p1)
	Asserts.Function(p2)

	local v2 = setmetatable({
		Connection = nil,
		Callbacks = {},
		Vars = {
			Disconnected = false
		}
	}, v1)
	local v3 = 0
	local v4 = nil

	v4 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 99 | Upvalues: v3 (ref), p1 (copy), v4 (ref), p2 (copy), Logging (ref), v2 (copy) ]]
		local v1 = false
		local v22 = v3

		v3 = v3 + p12

		if p1 <= v3 then
			v3 = p1
			v4:Disconnect()
			v1 = true
		end

		local ok, result = pcall(p2, if p1 <= v3 then 1 else v3 / p1, v3, v3 - v22)

		if not ok then
			Logging.Warn("RenderError", result)
		end

		if not ok or result ~= nil then
			v4:Disconnect()
			v1 = true
		end

		if not v1 then
			return
		end

		v2:OnDisconnected()
	end)
	v2.Connection = v4
	table.freeze(v2)

	return v2
end

return new