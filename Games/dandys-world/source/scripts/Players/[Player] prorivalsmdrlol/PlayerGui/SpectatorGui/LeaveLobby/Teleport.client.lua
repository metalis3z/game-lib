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
-- CQMUBHRhc2sEd2FpdAdWaXNpYmxlCkZpcmVTZXJ2ZXIFc3Bhd24EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUHTW9kdWxlcwJVSQ1HdWlBbmltYXRpb25zBkV2ZW50cwhUZWxlcG9ydAxXYWl0Rm9yQ2hpbGQGc2NyaXB0BlBhcmVudBtTZXR1cEJ1dHRvbkFuaW1hdGlvbnNTaW1wbGUJQWN0aXZhdGVkB0Nvbm5lY3QAAwIAAgAAABOkAAIAAAQAgG8BAwCfAAIB+wAAAKkBAAAwAQCABAAAAKQAAgAABACAjAEIAJ8AAgH7AAAAqQEBADABAIAEAAAAqQAAAN4AAQCCAAEABQMBAwIEAAQAgAIAAAAAAADgPwMDABMAARgAAAAAAQAAAAEAAAABAAAAAQABFAAAAAACAAMAAAAP+wAAACsADACpAAEA3gAAAPsAAQC8AABrAAAAAJ8AAgGkAAMAAAgQgNkBAAASAgIAEgIAAJ8AAgGCAAEABAMEAwEDBQQACBCAAQANAAEYAAABAAEAAAADAAAAAAAIDgAAAAAIAAABAgAqowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIA6AYAAABNAgJcBwAAAE0CApsIAAAAnwECAk0CAFoJAAAAbwQKALwCAtMLAAAAnwIDAqQDDQAAAMBATQMDJA4AAABNBAHvDwAAAFIFAwCfBAIBqQQAAE0FAx4QAAAA2QcAABIBBP8SAAIAEgADALwFBccRAAAAnwUDAcEEAACCAAEAEgMGBAAAAEADBwMIAwkEAABAQAMKAwsDDAMNAw4DDwMQBAAAwEADEQMSAxMDFAEBAQABGAAAAAAAAAACAAAAAAAAAAACAAAAAAABAAAAAgAAAAIDAAAAAAAAAAAPAAEAAAAAAhBBfoaSvRC2zBGCFK3P7JBgWWnyIoUUhw==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiAnimations = require(ReplicatedStorage.Modules.UI.GuiAnimations)
local Teleport = ReplicatedStorage.Events:WaitForChild("Teleport")
local v1 = script.Parent

GuiAnimations.SetupButtonAnimationsSimple(v1)

local v2 = false

v1.Activated:Connect(function() --[[ Line: 13 | Upvalues: v2 (ref), Teleport (copy), v1 (copy) ]]
	if v2 then
		return
	end

	v2 = true
	Teleport:FireServer()
	task.spawn(function() --[[ Line: 19 | Upvalues: v1 (ref), v2 (ref) ]]
		task.wait(0.5)
		v1.Visible = false
		task.wait(8)
		v1.Visible = true
		v2 = false
	end)
end)