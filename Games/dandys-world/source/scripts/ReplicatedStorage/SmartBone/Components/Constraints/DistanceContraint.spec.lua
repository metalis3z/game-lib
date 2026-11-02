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
-- CQMWCFBvc2l0aW9uCkZyZWVMZW5ndGgLUGFyZW50SW5kZXgKQ3JlYXRlQm9uZQZleHBlY3QJTWFnbml0dWRlAnRvBWVxdWFsCENhbGxiYWNrBUJvbmVzAml0HFNob3VsZCBsaW1pdCB0byAlKiBzdHVkcyAjJSoGZm9ybWF0BG1hdGgGcmFuZG9tCGRlc2NyaWJlE0Rpc3RhbmNlIENvbnN0cmFpbnQHcmVxdWlyZQZzY3JpcHQGUGFyZW50EkRpc3RhbmNlQ29uc3RyYWludAxXYWl0Rm9yQ2hpbGQABQQDAAAAAAjiAwMAMAADOwAAAAAwAQN+AQAAADACA80CAAAAggMCAAQDAQMCAwMFAwABAgADBAEYAAEAAQABAAAEAAAAAAQAAwAAABj7AAAA+wEBAPsCAQBNAgI7AAAAAPsDAgCfAAQCpAECAAAAEEBNAgCqAwAAAJ8BAgJNAQGSBAAAAE0BAXsFAAAA+wIBAE0CAn4GAAAAnwECAfsBAQAwAAE7AAAAAIIAAQAHAwEDBQQAABBAAwYDBwMIAwIAFgkBGAAAAAAAAAACAAAAAAAAAAAAAAAAAgAAARcAAAAACgACAAAAIPsBAABNAQF4AAAAABMAAQHZAQAAEgIBABIAAAASAgAAjAQBAIwCCgCMAwEAqAITAKQFAgAAABBAbwYDAE0IAH4EAAAAUgkEALwGBo0FAAAAnwYEAlIHAQCfBQMBpAUIAAAcYICMBgEAjAcUAJ8FAwIwBQB+BAAAAIsC7f+CAAEACQMKAwsEAAAQQAMMAwIDDQMOAw8EABxggAEBEwABGAAAAAACAAAACAAAAAEAAAAAAAAAAAAAAQAAAAAAAP4EFAAAAAAEAAEAAAAR4gABAP8BAAACAAAA4gIIAOIDCwDFAQIDAQAAADABAHgAAAAApAENAAAAwEBvAg4A2QMAABIAAAASAgAAnwEDAYIAAQAPAwoFAQADAQcAAAAAAAAAAAAAAAAAAAAAAwICAAAAAAAACEADAwIAAAAAAAAAAAgDAgMAAAAEBQAAAAYHAAAABwAAAAAAAIA/AAAAAAAAAAACAAAAAAAA8D8IAwIJAAAABAUAAAAGCgAAAAMQBAAAwEADEQECCwABGAgBAPcAAAAJAAYAAAAAAAAQBAAAAAAEAAABAgAQowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAG8DBQC8AQHTBgAAAJ8BAwCfAAACwAEHAMACCAASAAAAggICAAkDEgQAAABAAxMEAAAgQAMUAxUDFgYABgMCAAMBAAEYAAAAAAAAAAAAAAAAAggAAAEAAAAABCtNTx+vQGPG0SpmDNIJDuNbVVhrGYklHg==

-- https://lua.expert/
local DistanceConstraint = require(script.Parent:WaitForChild("DistanceConstraint"))

local function CreateBone(p1, p2, p3) --[[ CreateBone | Line: 3 ]]
	return {
		Position = p1,
		FreeLength = p2,
		ParentIndex = p3
	}
end

return function() --[[ Line: 11 | Upvalues: DistanceConstraint (copy) ]]
	local t = {
		Bones = {
			{
				Position = Vector3.new(0, 0, 0),
				FreeLength = 3,
				ParentIndex = 0
			},
			{
				Position = Vector3.new(0, 1, 0),
				FreeLength = 3,
				ParentIndex = 1
			}
		}
	}

	describe("Distance Constraint", function() --[[ Line: 19 | Upvalues: t (copy), DistanceConstraint (ref) ]]
		local v1 = t.Bones[2]

		local function Callback() --[[ Callback | Line: 22 | Upvalues: DistanceConstraint (ref), v1 (copy), t (ref) ]]
			local v12 = DistanceConstraint(v1, v1.Position, t)

			expect(v12.Magnitude).to.equal(v1.FreeLength)
			v1.Position = v12
		end

		for i = 1, 10 do
			it(("Should limit to %* studs #%*"):format(v1.FreeLength, i), Callback)
			v1.FreeLength = math.random(1, 20)
		end
	end)
end