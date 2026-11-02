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
-- CQM2BXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRFEb250Q2hhbmdlVGV4dHVyZQZIYXNUYWcccmJ4YXNzZXRpZDovLzEyMDA3ODYzNDAyMjUwOAlUZXh0dXJlSUQGQ29uZmlnDFdhaXRGb3JDaGlsZAtIdXJ0VGV4dHVyZRxyYnhhc3NldGlkOi8vMTE2MTMwMTYwNzU2MDIyB1RleHR1cmUNTm9ybWFsVGV4dHVyZQxCbGlua1RleHR1cmUccmJ4YXNzZXRpZDovLzEyNDQ0MDkzOTY5NDM1MAlBcHBseVNraW4IUG9zaXRpb24IcGFyYWJvbGEFY2hhc2UHcmVxdWlyZQVQYXJ0cw1SZW5kZXJNb2R1bGVzC0Nvc21vQ29va2llCE1vdmVtZW50BkNvb2tpZQVDbG9uZQdBZGRJdGVtCXdvcmtzcGFjZQZQYXJlbnQIQmFzZVBhcnQGQ29sb3IzB2Zyb21SR0IFQ29sb3IFVHJhaWwORmluZEZpcnN0Q2hpbGQHRW5hYmxlZA1Db2xvclNlcXVlbmNlA25ldxVDb2xvclNlcXVlbmNlS2V5cG9pbnQJU21va2VQYXJ0CUhlYXJ0UGFydAxUcmFuc3BhcmVuY3kERW1pdANFYXQEUGxheQpVc2VBYmlsaXR5DVZpbnRhZ2UgQ29zbW8ETmFtZQdNYXN0ZXJ5BGdhbWUGRGVicmlzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UABAkBAAAAADCkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQ0AbwgDALwGBf4EAAAAnwYDAg4GCABvCAUAvAYF3gYAAACfBgMCKwYDAG8GBwAwBgWECAAAAG4B8v8CAAAAbwMJALwBANMKAAAAnwEDAm8ECwC8AgHTCgAAAJ8CAwJvAwwAMAMCTw0AAABvBQ4AvAMB0woAAACfAwMCbwYPALwEAdMKAAAAnwQDAm8FBwAwBQNPDQAAAG8FEAAwBQRPDQAAAIIAAQARAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAAJEQEYAAAAAAAAAAEAAAAAAAAAAAABAAD+AAYAAAABAAAAAgAAAwAAAAEAAAACAAABAAABCgAAAAAJAAMAAAAP+wAAAE0AADsAAAAA+wEBAPsCAgBNAgJIAQAAAPsDAABSBAAAUgUBAIwGFACMBxkAbwgCAJ8CBwGCAAEAAwMSAxMCAAAAAAAA4D8ASRQBGAAAAAEFAAAAAAAAAAAAAUoAAAAAEAQCAAAA0gGkBAEAAAAAQPsFAABNBQUvAgAAAE0FBbgDAAAATQUF7gQAAABNBQVaBQAAAJ8EAgL7BQAATQUFLwIAAABNBQW4AwAAAE0FBe4EAAAATQUFlgYAAAC8BQU6BwAAAJ8FAgL7BgEAUggFAIwJAgC8BgZ4CAAAAJ8GBAGkBgoAAACQQDAGBSQLAAAATQYCOwwAAAAwBgU7DAAAAG8IDQC8BgX+DgAAAJ8GAwIOBggApAYRAABA8ICMB4AAjAiAAIwJgACfBgQCMAYFpBIAAABvCBMAvAYFAxQAAACfBgMCDgYkAE0GBbkTAAAAqQcBADAHBvAVAAAATQYFuRMAAACkBxgAAFxggf8IAAACAAAApAkaAABckIGMCgAApAsRAABA8ICMDGQAjA1kAIwOZACfCwQAnwkAAqQKGgAAXJCBjAsBAKQMEQAAQPCAjA0yAIwOMgCMDzIAnwwEAJ8KAADFCAkAAQAAAJ8HAgIwBwakEgAAAG8IGwC8BgUDFAAAAJ8GAwIOBiQATQYFyxsAAACpBwEAMAcG8BUAAABNBgXLGwAAAKQHGAAAXGCB/wgAAAIAAACkCRoAAFyQgYwKAACkCxEAAEDwgIwMUACMDVAAjA5QAJ8LBACfCQACpAoaAABckIGMCwEApAwRAABA8ICMDTwAjA48AIwPPACfDAQAnwoAAMUICQABAAAAnwcCAjAHBqQSAAAAbwgcALwGBQMUAAAAnwYDAg4GHwBNBgWjHAAAAKQHGAAAXGCB/wgAAAIAAACkCRoAAFyQgYwKAACkCxEAAEDwgIwM/wCMDf8AjA7/AJ8LBACfCQACpAoaAABckIGMCwEApAwRAABA8ICMDcgAjA7IAIwPyACfDAQAnwoAAMUICQABAAAAnwcCAjAHBqQSAAAA2QYAABIABQASAAMAEgAEAE0HBTsMAAAATQgESB0AAABSCQUAUgoHAFILAwCMDBQAjA0ZAG8OHgCfCAcBDgUYAE0HBcsbAAAAqQgAADAIB/AVAAAAjAcBADAHBdkfAAAATQcFoxwAAACMCQoAvAcHViAAAACfBwMBbwkhALwHBQMUAAAAnwcDAg4HBQBNBwXsIQAAALwHB+4iAAAAnwcCAYIAAQAjAxUEAAAAQAMWAxcDGAMZAxoDGwMcAx0EAACQQAMeAxIDHwMEAyADIQQAQPCAAyIDIwMkAyUDJgMnBABcYIEDKAQAXJCBAykDKgMTAgAAAAAAAOA/AysDLAMtAy4BAR0vARgAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAEAAAAAAACAAAAAQAAAAMAAAAAAQAAAAAAAAAEAAAAAAEAAAAAAQAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAAAAAP4AAAcAAAAAAQAAAAABAAAAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAA/gAABwAAAAABAAAAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAA/gAABgAAAAEABgAAAAAAAAAABQEAAAAAAQAAAQAAAAAAAQAAAAABAAAAAAMeAAAAAAUAAAECAB6jAAAA/wADAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAACkAQQAAAAwQG8DBQC8AQEWBgAAAJ8BAwKkAgQAAAAwQG8EBwC8AgIWBgAAAJ8CAwLAAwgAMAMA6QkAAADAAwoAEgACABIAAQAwAwCyCwAAAIIAAgAMAzADMQMyAzMEAAAwQAM0AzUDNgYAAxEGAgMvAgACAQABGAAAAAIAAAEAAAIAAAAAAAEAAAAAAAIAABQAAAAAQwEAAAAAA1AyPonBFU2+ZP498D5FlWkgKin9YvZUiA==

-- https://lua.expert/
local t = {
	Name = "Vintage Cosmo",
	Mastery = true
}
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function t.ApplySkin(p1) --[[ ApplySkin | Line: 9 ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") and not v:HasTag("DontChangeTexture") then
			v.TextureID = "rbxassetid://120078634022508"
		end
	end

	local Config = p1:WaitForChild("Config")

	Config:WaitForChild("HurtTexture").Texture = "rbxassetid://116130160756022"

	local NormalTexture = Config:WaitForChild("NormalTexture")
	local BlinkTexture = Config:WaitForChild("BlinkTexture")

	NormalTexture.Texture = "rbxassetid://120078634022508"
	BlinkTexture.Texture = "rbxassetid://124440939694350"
end
function t.UseAbility(p1, p2, p3, p4) --[[ UseAbility | Line: 29 | Upvalues: ReplicatedStorage (copy), Debris (copy) ]]
	local Movement = require(ReplicatedStorage.Parts.RenderModules.CosmoCookie.Movement)
	local v1 = ReplicatedStorage.Parts.RenderModules.CosmoCookie.Cookie:Clone()

	Debris:AddItem(v1, 2)
	v1.Parent = workspace
	v1.Position = p3.Position

	if v1:IsA("BasePart") then
		v1.Color = Color3.fromRGB(128, 128, 128)
	end

	if v1:FindFirstChild("Trail") then
		v1.Trail.Enabled = true
		v1.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)) })
	end

	if v1:FindFirstChild("SmokePart") then
		v1.SmokePart.Enabled = true
		v1.SmokePart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60)) })
	end

	if v1:FindFirstChild("HeartPart") then
		v1.HeartPart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)) })
	end

	local function chase() --[[ chase | Line: 73 | Upvalues: v1 (copy), p4 (copy), Movement (copy) ]]
		Movement.parabola(v1, v1.Position, p4, 20, 25, 0.5)
	end

	Movement.parabola(v1, v1.Position, p4, 20, 25, 0.5)

	if not v1 then
		return
	end

	v1.SmokePart.Enabled = false
	v1.Transparency = 1
	v1.HeartPart:Emit(10)

	if not v1:FindFirstChild("Eat") then
		return
	end

	v1.Eat:Play()
end

return t