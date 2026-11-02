--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMgDVJheWNhc3RQYXJhbXMDbmV3GkZpbHRlckRlc2NlbmRhbnRzSW5zdGFuY2VzBEVudW0RUmF5Y2FzdEZpbHRlclR5cGUHRXhjbHVkZQpGaWx0ZXJUeXBlEVJlc3BlY3RDYW5Db2xsaWRlCXdvcmtzcGFjZQdSYXljYXN0CEluc3RhbmNlCFBvc2l0aW9uCU1hZ25pdHVkZQRVbml0BkNGcmFtZRZBc3NlbWJseUxpbmVhclZlbG9jaXR5AVgBWgdWZWN0b3IzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCUZvcmJpZGRlbghQYWNrYWdlcxJyb2Jsb3hzdGF0ZW1hY2hpbmUGc2NyaXB0BlBhcmVudA1Db25maWdIYW5kbGVyE0dldEdyb3VuZGVkUG9zaXRpb24gR2V0Q29sbGluZWFyVGFyZ2V0UG9zaXRpb25PZmZzZXQPUHJlZGljdE1vdmVtZW50AAQLAwAAABAFAAIFAwgEgggKGAEICScBKqQDAgAABACAnwMBAv8EAAABAAAAUgUBAMUEBQIBAAAAMAQDfQMAAACkBQcABhRAwDAFA1cIAAAAqQUBADAFA1IJAAAAjAUDAA4CAQBSBQIApAYLAAAAoEBSCAAAbwoMAAkJCgVSCgMAvAYGwg0AAACfBgUCRwYDAAAAAIDGBwAAggcCAE0HBvQOAAAADgcFAE0IBjsPAAAAbwkQAEMHCAmCBwIAggACABEDAQMCBAAEAIADAwMEAwUDBgQGFEDAAwcDCAMJBAAAoEAHAAAAAAAAgL8AAAAAAAAAAAMKAwsDDAcAAAAAAAAAQAAAAAAAAAAAACIAARgAAAABAAAAAAIAAQAAAAEAAAMBAAIAAAAAAAAAAAIAAAABAAACAAAAAAMlAAAAAAcDAAAACAUAAAUDCAgCEyYDAQANAgIAAAAAgIIAAgBNBAOqAQAAAA0EAgAAAACAggACAE0EA6oBAAAAYAQCAAIAAACCAQIATQYDBwIAAAAJBQYCQwQABYIEAgADAgAAAAAAAAAAAw0DDgBGAAEYAAEAAAIAAAABAwAAAAEDAAAAAEcAAAAABwIAAAALBAABBQIHAggDHQIpTQIAhQAAAABNAgI7AQAAAIwDAAB9AQIAAwAAAIICAgBNAwAXAgAAAE0DA6oDAAAAbwQEAGADAgAEAAAAggICAE0EABcCAAAATQQEeQUAAACMBQAATQYAFwIAAABNBgZ7BgAAAEw2AAKkAwkAACBwgJ8DBAJNAwMHCgAAAE0EA3kFAAAATQUDeQUAAADxBAIABQAAAIICAgAJBAMBQwICBIICAgALAw8DDAMQAw0CmpmZmZmZuT8DEQMSAxMDAgQAIHCAAw4AVQABGAAAAAABAAAAAgAAAAAAAAIDAAAAAAAAAAAAAAAAAAAEAAAAAAABAwACVwAAAAAFAAABAgAlowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAyQYAAABNAgLmBwAAAE0CAngIAAAAnwECAqQCBQAAAEBApAMKAAAAkEBNAwMkCwAAAE0DA+IMAAAAnwICAv8DAwAAAAAAwAQNADAEA6EOAAAAwAQPADAEA9AQAAAAwAQRADAEAwcSAAAAggMCABMDFAQAAABAAxUDFgMXBAAAQEADGAMZAxoDGwQAAJBAAxwDHQYAAx4GAQMfBgIDIAMAAQIBAAEYAAgAAAAAAAMAAAAAAAAAAAQAAAAAAAAAAAYADAAAJAAADwAAFwEAAAAAAzTpvS/n/esFKtTPUh0wJLFE8apbBi3XLg==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Forbidden.Packages.robloxstatemachine)
require(script.Parent.ConfigHandler)

return {
	GetGroundedPosition = function(p1, p2, p3) --[[ Line: 34 ]]
		local v1 = RaycastParams.new()

		v1.FilterDescendantsInstances = { p2 }
		v1.FilterType = Enum.RaycastFilterType.Exclude
		v1.RespectCanCollide = true

		local v3 = workspace:Raycast(p1, Vector3.new(0, -1, 0) * (if p3 then p3 else 3), v1)

		if v3 == nil then
			return nil
		end

		if v3.Instance then
			return v3.Position + Vector3.new(0, 2, 0)
		end

		return p1
	end,
	GetCollinearTargetPositionOffset = function(p1, p2, p3) --[[ Line: 70 ]]
		local v1 = p2 - p1

		if p3 == 0 then
			return p1
		end

		if v1.Magnitude == 0 then
			return p1
		end

		if v1.Magnitude < p3 then
			return p2
		end

		return p1 + v1.Unit * p3
	end,
	PredictMovement = function(p1, p2) --[[ Line: 85 ]]
		local Position = p1.CFrame.Position

		if p2 <= 0 then
			return Position
		end

		if p1.AssemblyLinearVelocity.Magnitude < 0.1 then
			return Position
		end

		local Unit = Vector3.new(p1.AssemblyLinearVelocity.X, 0, p1.AssemblyLinearVelocity.Z).Unit

		if Unit.X == Unit.X then
			return Position + Unit * p2
		end

		return Position
	end
}