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
-- CQMZCk1hdGNoRm91bmQPSm9pblJlcXVlc3RTZW50EExlYXZlUmVxdWVzdFNlbnQMSW52b2tlU2VydmVyBEpvaW4EdGFzawR3YWl0BUxlYXZlB29uUHJlc3MEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlCUZvcmJpZGRlbgxXYWl0Rm9yQ2hpbGQLTXVsdGlwbGF5ZXIFUXVldWUHc2lnbmFscwRqb2luBWxlYXZlEXRvQ2xpZW50TWF0Y2hJbmZvBnNjcmlwdAZQYXJlbnQOTW91c2VCdXR0b24xVXAHQ29ubmVjdA1PbkNsaWVudEV2ZW50AAcBAQAAAAABggABAAAAKAEBGAAsAAAAAAAAAAAAAAGCAAEAAAAuAgEYADAAAAAAAAAAAAAAAYIAAQAAADIDARgANQAAAAACAAIAAAAM+wAAAA4AAQCCAAEAqQABAN4AAAD7AAEAvAAAOQAAAACfAAIBqQAAAN4AAACCAAEAAQMEAE4FARgAAAADAAEAAAACAAFQAAAAAAIAAgAAABD7AAAADgABAIIAAQCpAAEA3gAAAKQAAgAABACAjAEAAJ8AAgH7AAEAvAAAOQMAAACfAAIBqQAAAN4AAACCAAEABAMGAwcEAAQAgAMEAFkIARgAAAACAAEAAAABAAAAAgABWwAAAAACAAUAAAAq+wAAAA4AEwCpAAAA3gAAAKkAAQDeAAEA+wACAA4AAQBlAAwAqQABAN4AAgCkAAIAAAQAgIwBAACfAAIB+wADALwAADkDAAAAnwACAakAAADeAAIA+wABAA4AAwCpAAAA3gABAIIAAQD7AAAAKwANAKkAAQDeAAAA+wACAA4AAQCCAAEAqQABAN4AAgD7AAQAvAAAOQMAAACfAAIBqQAAAN4AAgCCAAEABAMGAwcEAAQAgAMEAGQJARgWAAIAAQDyAAACAAEAAAABAAAAAgAMAAAAAAIAAgDfAAADAAEAAAACAB5QAAAAABUAAAECAEejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCbwMEALwBANMFAAAAnwEDAm8EBgC8AgHTBQAAAJ8CAwJvBQcAvAMC0wUAAACfAwMCbwYIALwEA9MFAAAAnwQDAm8HCQC8BQTTBQAAAJ8FAwJvCAoAvAYE0wUAAACfBgMCbwkLALwHBNMFAAAAnwcDAqQIDQAAAMBATQgIJA4AAACpCQAAqQoAAKkLAADADA8AwA0QAMAOEQDZDwMAEgEL/xIABQDZEAQAEgEL/xIABgDZEQUAEgEJ/xIBCv8SAQv/EgAGABIABQBNEggyEgAAAFIUEQC8EhLHEwAAAJ8SAwFNEgeMFAAAAFIUDAC8EhLHEwAAAJ8SAwHBCQAAggABABUDCgQAAABAAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQQAAMBAAxYGAAYBBgIDFwMYAxkGAAECAwQFAQABGAABAAAAAAADAAAAAQAAAAEAAAACAAAAAQAAAAEAAAABAAAAEAAAAAUBAQUGBBwAAAsAAAsAAAAAABIAAAAAAAEAAAAAAAAAAQAAAAAGYuOm+1g+RzhiQx9MLNg/GBL7sY9QJ8z6

-- https://lua.expert/
local signals = game:GetService("ReplicatedStorage"):WaitForChild("Forbidden"):WaitForChild("Multiplayer"):WaitForChild("Queue"):WaitForChild("signals")
local join = signals:WaitForChild("join")
local leave = signals:WaitForChild("leave")
local toClientMatchInfo = signals:WaitForChild("toClientMatchInfo")
local v1 = script.Parent
local v2 = false
local v3 = false
local v4 = false

local function MatchFound(p1) --[[ MatchFound | Line: 40 ]] end

local function JoinRequestSent() --[[ JoinRequestSent | Line: 46 ]] end

local function LeaveRequestSent() --[[ LeaveRequestSent | Line: 50 ]] end

local function Join() --[[ Join | Line: 78 | Upvalues: v4 (ref), join (copy) ]]
	if not v4 then
		v4 = true
		join:InvokeServer()
		v4 = false
	end
end

local function Leave() --[[ Leave | Line: 89 | Upvalues: v4 (ref), leave (copy) ]]
	if not v4 then
		v4 = true
		task.wait(0)
		leave:InvokeServer()
		v4 = false
	end
end

local function onPress() --[[ onPress | Line: 100 | Upvalues: v2 (ref), v3 (ref), v4 (ref), leave (copy), join (copy) ]]
	if v2 then
		v2 = false
		v3 = true

		if not v4 then
			v4 = true
			task.wait(0)
			leave:InvokeServer()
			v4 = false
		end
	end

	if v3 then
		v3 = false

		return
	end

	if v2 then
		return
	end

	v2 = true

	if v4 then
		return
	end

	v4 = true
	join:InvokeServer()
	v4 = false
end

v1.MouseButton1Up:Connect(onPress)
toClientMatchInfo.OnClientEvent:Connect(MatchFound)