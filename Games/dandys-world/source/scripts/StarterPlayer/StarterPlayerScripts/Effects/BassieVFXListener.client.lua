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
-- CQMcBHR5cGUFdGFibGUGYWN0aW9uBXBjYWxsC0hhbmRsZUV2ZW50BHdhcm4hQmFzc2llVkZYTGlzdGVuZXI6IEVycm9yIGhhbmRsaW5nA+KAlA1PbkNsaWVudEV2ZW50B0Nvbm5lY3QFcHJpbnQvQmFzc2llVkZYTGlzdGVuZXI6IENvbm5lY3RlZCB0byBCYXNzaWVWRlggZXZlbnQOY29ubmVjdFRvRXZlbnQETmFtZQlCYXNzaWVWRlgLUmVtb3RlRXZlbnQDSXNBCkRpc2Nvbm5lY3QEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB01vZHVsZXMORmluZEZpcnN0Q2hpbGQPQmFzc2llVkZYQ2xpZW50B3JlcXVpcmU1QmFzc2llVkZYTGlzdGVuZXI6IEZhaWxlZCB0byByZXF1aXJlIEJhc3NpZVZGWENsaWVudDoGRXZlbnRzCkNoaWxkQWRkZWQABAgBAQAAABy7KAADUgIAAKQBAQAAAABAnwECAvABBAACAACATQEAYgMAAAArAQEAggABAKQBBQAAAEBA+wIAAE0CApQGAAAAUgMAAJ8BAwMrAQgApAMIAAAAcEBvBAkATQUAYgMAAABvBgoAUgcCAJ8DBQGCAAEACwMBBAAAAEADAgMDAwQEAABAQAMFAwYEAABwQAMHAwgAFQABGAAAAAAAAAAAAAAAAQAAAAAAAAEBAAAAAAAAAAIWAAAAAAQBAQAAAAxNAQCMAAAAAMADAQASAgAAvAEBxwIAAACfAQMBpAEEAAAAMEBvAgUAnwECAYIAAQAGAwkGAAMKAwsEAAAwQAMMAQAUDQEYAAAAAAAAAAcAAAABFQAAAAAEAQIAAAAZTQEAugAAAADwARUAAQAAgG8DAgC8AQD+AwAAAJ8BAwIOAQ8A+wEAALwBARoEAAAAnwECAU0BAIwFAAAAwAMGABICAQC8AQHHBwAAAJ8BAwGkAQkAAACAQG8CCgCfAQIBggABAAsDDgMPAxADEQMSAwkGAAMKAwsEAACAQAMMAQApAAEYFQAAAAAAAAAAAQAAAOoAAAAAAAAHAAAAEhUAAAAADAAAAQIARaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwJvAwQAvAEAAwUAAACfAQMCUgIBAA4CBABvBAYAvAIBAwUAAACfAgMCKwIBAIIAAQCkAwgAAABwQKQECgAAAJBAUgUCAJ8DAwMrAwYApAUMAAAAsEBvBg0AUgcEAJ8FAwGCAAEAwAUOABIABABvCA8AvAYAAwUAAACfBgMCKwYBAIIAAQBvCRAAvAcGAwUAAACfBwMCDgcMAE0IB4wRAAAAwAoSABIABAC8CAjHEwAAAJ8IAwGkCBUAAABAQW8JFgCfCAIBggABAMYIAABNCQZrFwAAANkLAgASAQj/EgAEALwJCccTAAAAnwkDAlIICQDBCAAAggABABgDEwQAAABAAxQDFQMWAxcDGAMEBAAAcEADGQQAAJBAAwYEAACwQAMaBgEDGwMPAwkGAAMKAwsEAABAQQMMAxwDAQACAQABGAAEAAAAAAADAAAAAQAAAAAAAQEDAAAAAAABAQAAAAABAwAMAAAAAQACAAAAAfEAAAAAAAAHAAAAAAwBAAAAAAAAAAAABwEAAAAAA2A2eqAlk2TJzbGjep6u+W4QLm3UUvIQoQ==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local v1 = if Modules then Modules:FindFirstChild("BassieVFXClient") else Modules

if not v1 then
	return
end

local ok, result = pcall(require, v1)

if not ok then
	warn("BassieVFXListener: Failed to require BassieVFXClient:", result)

	return
end

local function connectToEvent(p1) --[[ connectToEvent | Line: 20 | Upvalues: result (copy) ]]
	p1.OnClientEvent:Connect(function(p1) --[[ Line: 21 | Upvalues: result (ref) ]]
		if type(p1) ~= "table" or not p1.action then
			return
		end

		local ok, result2 = pcall(result.HandleEvent, p1)

		if ok then
			return
		end

		warn("BassieVFXListener: Error handling", p1.action, "\226\128\148", result2)
	end)
	print("BassieVFXListener: Connected to BassieVFX event")
end

local Events = ReplicatedStorage:FindFirstChild("Events")

if not Events then
	return
end

local BassieVFX = Events:FindFirstChild("BassieVFX")

if BassieVFX then
	BassieVFX.OnClientEvent:Connect(function(p1) --[[ Line: 21 | Upvalues: result (copy) ]]
		if type(p1) ~= "table" or not p1.action then
			return
		end

		local ok, result2 = pcall(result.HandleEvent, p1)

		if ok then
			return
		end

		warn("BassieVFXListener: Error handling", p1.action, "\226\128\148", result2)
	end)
	print("BassieVFXListener: Connected to BassieVFX event")
else
	local v2 = nil

	v2 = Events.ChildAdded:Connect(function(p1) --[[ Line: 41 | Upvalues: v2 (ref), result (copy) ]]
		if p1.Name ~= "BassieVFX" or not p1:IsA("RemoteEvent") then
			return
		end

		v2:Disconnect()
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 21 | Upvalues: result (ref) ]]
			if type(p1) ~= "table" or not p1.action then
				return
			end

			local ok, result2 = pcall(result.HandleEvent, p1)

			if ok then
				return
			end

			warn("BassieVFXListener: Error handling", p1.action, "\226\128\148", result2)
		end)
		print("BassieVFXListener: Connected to BassieVFX event")
	end)
end