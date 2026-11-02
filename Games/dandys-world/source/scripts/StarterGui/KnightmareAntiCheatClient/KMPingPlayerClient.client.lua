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
-- CQMRCkZpcmVTZXJ2ZXIEdGFzawR3YWl0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZRtLTV9QSU5HX1BMQVlFUl9FVkVOVF9DTElFTlQORmluZEZpcnN0Q2hpbGQbS01fUElOR19QTEFZRVJfRVZFTlRfU0VSVkVSDU9uQ2xpZW50RXZlbnQHQ29ubmVjdAl3b3Jrc3BhY2UeS01fREVCVUdfU0VSVkVSX1NDQU5OSU5HX1NQRUVEDEdldEF0dHJpYnV0ZQZzY3JpcHQGUGFyZW50B0Rlc3Ryb3kAAgIAAQAAAAX7AAAAvAAAawAAAACfAAIBggABAAEDAQANAAEYAAAAAAEPAAAAAAYAAAEAAFajAAAApAACAAAEAICMAQIAnwACAaQABAAAADBAbwIFALwAABYGAAAAnwADAm8CBwC8AAADCAAAAJ8AAwKkAQQAAAAwQG8DBQC8AQEWBgAAAJ8BAwJvAwkAvAEBAwgAAACfAQMCjAJjAIwDAABgAygAAgAAAA4AAQArARcApAMEAAAAMEBvBQUAvAMDFgYAAACfAwMCbwUHALwDAwMIAAAAnwMDAlIAAwCkAwQAAAAwQG8FBQC8AwMWBgAAAJ8DAwJvBQkAvAMDAwgAAACfAwMCUgEDAGUACABNAwCMCgAAANkFAAASAQH/vAMDxwsAAACfAwMBZQAGAHgCAgykAwIAAAQAgIwEAQCfAwIBSADW/6QDDgAAANBAbwUPALwDAxIQAAAAnwMDAisDCQArAAgAKwEHAKQDEgAAABBBTQMDJBMAAAC8AwNQFAAAAJ8DAgHBAQAAggABABUDAgMDBAAEAIADBAQAADBAAwUDBgMHAwgDCQMKAwsCAAAAAAAA8D8DDAQAANBAAw0DDgMPBAAAEEEDEAMRAQABAAEYAAEAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAECAAABAAIAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAgAAAAAAAAYEAQAAAO8UAAAAAAAAAQACAAAAAAAAAwABAAAAAAHIidR3nRbZDm9O+XM5stspuJHDA/pNvnY=

-- https://lua.expert/
task.wait(2)

local KM_PING_PLAYER_EVENT_CLIENT = game:GetService("ReplicatedStorage"):FindFirstChild("KM_PING_PLAYER_EVENT_CLIENT")
local KM_PING_PLAYER_EVENT_SERVER = game:GetService("ReplicatedStorage"):FindFirstChild("KM_PING_PLAYER_EVENT_SERVER")
local count = 99

while count > 0 do
	if KM_PING_PLAYER_EVENT_CLIENT and KM_PING_PLAYER_EVENT_SERVER then
		KM_PING_PLAYER_EVENT_CLIENT.OnClientEvent:Connect(function() --[[ Line: 13 | Upvalues: KM_PING_PLAYER_EVENT_SERVER (ref) ]]
			KM_PING_PLAYER_EVENT_SERVER:FireServer()
		end)

		break
	end

	local KM_PING_PLAYER_EVENT_CLIENT2 = game:GetService("ReplicatedStorage"):FindFirstChild("KM_PING_PLAYER_EVENT_CLIENT")

	KM_PING_PLAYER_EVENT_SERVER = game:GetService("ReplicatedStorage"):FindFirstChild("KM_PING_PLAYER_EVENT_SERVER")
	task.wait(1)
	count, KM_PING_PLAYER_EVENT_CLIENT = count - 1, KM_PING_PLAYER_EVENT_CLIENT2
end

if workspace:GetAttribute("KM_DEBUG_SERVER_SCANNING_SPEED") or (KM_PING_PLAYER_EVENT_CLIENT or KM_PING_PLAYER_EVENT_SERVER) then
	return
end

script.Parent:Destroy()