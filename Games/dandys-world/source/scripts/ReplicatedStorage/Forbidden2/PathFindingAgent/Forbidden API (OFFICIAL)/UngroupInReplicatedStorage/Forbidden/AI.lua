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
-- CQMaDERlZmF1bHRTdGFydBZJbml0aWFsaXplU3RhdGVNYWNoaW5lEFNlbmRTdGFydE1lc3NhZ2UFRXZlbnQEV2FpdAtEZWZhdWx0U3RvcA9TZW5kU3RvcE1lc3NhZ2UJR2V0Q29uZmlnBWVycm9yLk5QQyBpcyBuaWwhIENhbm5vdCBpbnNlcnQgdGhlIGFudGktbGFnIHNjcmlwdC4ISHVtYW5vaWQVRmluZEZpcnN0Q2hpbGRPZkNsYXNzSENhbm5vdCBmaW5kIHRoZSBodW1hbm9pZCBpbiB0aGlzIE5QQy4gQ2Fubm90IGluc2VydCB0aGUgYW50aS1sYWcgc2NyaXB0LgVDbG9uZQZQYXJlbnQHRW5hYmxlZAdyZXF1aXJlBnNjcmlwdAVUeXBlcwxNZXNzYWdlUXVldWUUUGF0aGZpbmRpbmdQcm9jZXNzb3INQ29uZmlnSGFuZGxlcgdhbnRpbGFnDVNtYXJ0UGF0aGZpbmQEU3RvcA1JbnNlcnRBbnRpTGFnAAUJBAIAAAkGAAAFBAcPgQ8XkAICAJADAwH7BAAATQQEoQIAAABSBQAAnwQCAfsEAQBNBAS6AwAAAFIFAABSBgEAUgcCAFIIAwCfBAUCDgIGAA4EBQBNBQQ2BAAAALwFBfcFAAAAnwUCAYIAAQAGAQADAQMCAwMDBAMFACAAARgAAQEAAAAAAQAAAAAAAAABAAEAAAAAAiEAAAAABwMBAAAIBQAABQMHgQ8RkAEBAJACAgH7AwAATQMD4wIAAABSBAAAUgUBAFIGAgCfAwQCDgEGAA4DBQBNBAM2AwAAALwEBPcEAAAAnwQCAYIAAQAFAQADBgMHAwQDBQBJAAEYAAEBAAAAAAAAAQABAAAAAAJKAAAAAAMBAQAABgMAAAUBBwb7AQAATQEBsQAAAABSAgAAnwECAIIBAAABAwgAcAABGAAAAAAAAHEAAAAABgMBAAAIBQAABQMHgYEoRwAFAAAAAICkAwEAAAAAQG8EAgCfAwIBbwUDALwDALgEAAAAnwMDAkcDBgAAAACAKwIEAKQDAQAAAABAbwQFAJ8DAgErAQoA+wMAALwDAzoGAAAAnwMCAjAAAyQHAAAA+wMAAKkEAQAwBAPwCAAAAA4BCgD7AwAAvAMDOgYAAACfAwICMAADJAcAAAD7AwAAqQQBADAEA/AIAAAAggABAAkDCQQAAABAAwoDCwMMAw0DDgMPAxAAjgEAARgAAAAAAAABAAAAAAAAAAAAAAMBAAAAAAABAAAABgEAAAAAAAEAAAACkQAAAAAHAAABAgA1owAAAKQAAQAAAABApAEDAAAAIEBNAQHvBAAAAJ8AAgKkAQEAAAAAQKQCAwAAACBATQIC1wUAAACfAQICpAIBAAAAAECkAwMAAAAgQE0DA+kGAAAAnwICAqQDAQAAAABApAQDAAAAIEBNBATiBwAAAJ8DAgKkBAMAAAAgQE0EBL8IAAAA/wUDAAAAAADABgkAEgACABIAAQAwBgWDCgAAAMAGCwASAAEAMAYF+gwAAADABg0AEgADADAGBbEOAAAAwAYPABIABAAwBgUXEAAAAIIFAgARAxEEAAAAQAMSBAAAIEADEwMUAxUDFgMXBgADGAYBAxkGAgMIBgMDGgQAAQIDAQABGAAQAAAAAAAABgAAAAAAAAEAAAAAAAABAAAAAAAAAwAAAAIAAgAAAAApAAAAJwAAAB4AAAAVAQAAAAAEl2HaQc216FuVBWdjpO9sMud5zTWlpbBA

-- https://lua.expert/
require(script.Types)

local MessageQueue = require(script.MessageQueue)
local PathfindingProcessor = require(script.PathfindingProcessor)
local ConfigHandler = require(script.ConfigHandler)
local antilag = script.antilag

return {
	SmartPathfind = function(p1, p2, p3, p4) --[[ Line: 32 | Upvalues: PathfindingProcessor (copy), MessageQueue (copy) ]]
		local v1 = p3 or false

		PathfindingProcessor.InitializeStateMachine(p1)

		local v2 = MessageQueue.SendStartMessage(p1, p2, v1, p4 or "DefaultStart")

		if not (v1 and v2) then
			return
		end

		v2.Event:Wait()
	end,
	Stop = function(p1, p2, p3) --[[ Line: 73 | Upvalues: MessageQueue (copy) ]]
		local v1 = p2 or false
		local v2 = MessageQueue.SendStopMessage(p1, v1, p3 or "DefaultStop")

		if not (v1 and v2) then
			return
		end

		v2.Event:Wait()
	end,
	GetConfig = function(p1) --[[ Line: 112 | Upvalues: ConfigHandler (copy) ]]
		return ConfigHandler.GetConfig(p1)
	end,
	InsertAntiLag = function(p1, p2, p3) --[[ Line: 142 | Upvalues: antilag (copy) ]]
		if p1 == nil then
			error("NPC is nil! Cannot insert the anti-lag script.")
		end

		if p1:FindFirstChildOfClass("Humanoid") == nil and not p3 then
			error("Cannot find the humanoid in this NPC. Cannot insert the anti-lag script.")
		end

		if not p2 then
			antilag:Clone().Parent = p1
			antilag.Enabled = true
		end

		if not p2 then
			return
		end

		antilag:Clone().Parent = p1
		antilag.Enabled = true
	end
}