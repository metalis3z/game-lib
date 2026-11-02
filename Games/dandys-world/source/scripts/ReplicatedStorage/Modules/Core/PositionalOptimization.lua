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
-- CQMMCEJhc2VQYXJ0A0lzQQhQb3NpdGlvbhZBc3NlbWJseUxpbmVhclZlbG9jaXR5AVgBWgdWZWN0b3IzA25ldwlNYWduaXR1ZGUEVW5pdA9QcmVkaWN0TW92ZW1lbnQgR2V0Q29sbGluZWFyVGFyZ2V0UG9zaXRpb25PZmZzZXQAAwgCAAAAACAOAAUAbwQAALwCAP4BAAAAnwIDAisCAgBvAgIAggICAE0CADsDAAAATQMAFwQAAABNBQN5BQAAAIwGAABNBwN7BgAAAEw2AAKkBAkAACBwgJ8EBAJNBQSqCgAAAG8GCwBgBQIABgAAAIICAgBNBQQHDAAAAAkGBQFDBwIGggcCAA0DAQMCBwAAAAAAAAAAAAAAAAAAAAADAwMEAwUDBgMHAwgEACBwgAMJAgAAAAAAAOA/AwoACwsBGAAAAAAAAAEAAwABAAMAAAAAAAAAAAMAAAAAAQQAAQIADAAAAAAHAwAAAAAUDQICAAAAAICCAAIAJgMBAE0EA6oBAAAAbwUCAGAEAgAFAAAAggACAE0EA6oBAAAAYAQCAAIAAACCAQIATQYDBwMAAAAJBQYCQwQABYIEAgAEAgAAAAAAAAAAAwkCmpmZmZmZuT8DCgAnDAEYAAABAwMAAAAAAQQAAAABBAAAAAAoAAAAAAIAAAECAAqjAAAA/wACAAAAAADAAQAAMAEABwEAAADAAQIAMAEA0AMAAACCAAIABAYAAwsGAQMMAgABAQABGAAEAAYAABwAABUBAAAAAALkUnmg83Bm69WwnB1T13tjlEpu1NaWE6E=

-- https://lua.expert/
return {
	PredictMovement = function(p1, p2) --[[ PredictMovement | Line: 11 ]]
		if not (p1 and p1:IsA("BasePart")) then
			return Vector3.new(0, 0, 0)
		end

		local Position = p1.Position
		local AssemblyLinearVelocity = p1.AssemblyLinearVelocity
		local v1 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)

		if v1.Magnitude < 0.5 then
			return Position
		end

		return Position + v1.Unit * p2
	end,
	GetCollinearTargetPositionOffset = function(p1, p2, p3) --[[ GetCollinearTargetPositionOffset | Line: 39 ]]
		if p3 == 0 then
			return p1
		end

		local v1 = p2 - p1

		if v1.Magnitude < 0.1 then
			return p1
		end

		if v1.Magnitude < p3 then
			return p2
		end

		return p1 + v1.Unit * p3
	end
}