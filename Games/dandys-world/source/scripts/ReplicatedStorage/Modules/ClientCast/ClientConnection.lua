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
-- CQMfCEluc3RhbmNlA25ldwtDbGllbnRDYXN0LQROYW1lBlBhcmVudApJbml0UmVtb3RlBUNsb25lBlNpZ25hbAxDbG9uZUhhbmRsZXIJU2NyZWVuR3VpD0NsaWVudENhc3QtVGVtcAxSZXNldE9uU3Bhd24JUGxheWVyR3VpDFdhaXRGb3JDaGlsZARnYW1lDVN0YXJ0ZXJQbGF5ZXIKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQdQbGF5ZXJzC1JlbW90ZUV2ZW50FkNsaWVudENhc3QtUmVwbGljYXRpb24OUmVtb3RlRnVuY3Rpb24PQ2xpZW50Q2FzdC1QaW5nBnNjcmlwdA1DbGllbnRIYW5kbGVyFFN0YXJ0ZXJQbGF5ZXJTY3JpcHRzFUZpbmRGaXJzdENoaWxkT2ZDbGFzcwRuZXh0CkdldFBsYXllcnMEdGFzawVzcGF3bgAFBgIBAAAADaQCAgAABACAUgMAAJ8CAgJvBAMAUgUBAHMDBAUwAwK6BAAAAPsDAAAwAwIkBQAAAIIAAQAGAwEDAgQABACAAwMDBAMFAAYGARgAAAAAAQAAAAABAAABBwAAAAAEAQIAAAAP+wEAALwBAToAAAAAnwECAvsCAQBNAgIfAQAAALwCAjoAAAAAnwICAjABAiQCAAAAMAABJAIAAACCAAEAAwMHAwgDBQARCQEYAAAAAAEAAAAAAAAAAgABEgAAAAAEAAMAAAAgpAACAAAEAIBvAQMAnwACAm8BBAAwAQC6BQAAAKkBAAAwAQCkBgAAAPsBAAC8AQE6BwAAAJ8BAgL7AgEATQICHwgAAAC8AgI6BwAAAJ8CAgIwAQIkCQAAADAAASQJAAAA+wECAG8DCgC8AQHTCwAAAJ8BAwIwAQAkCQAAAIIAAQAMAwEDAgQABACAAwoDCwMEAwwDBwMIAwUDDQMOABoAARgJAAAAAQAAAQAA9QAAAAEAAAAAAAAAAgALAAAAAAAAARIAAAAADgAAAAAAT6QAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCAQAAAABAbwQFALwCAhYDAAAAnwIDAtkDAAASAAEApAQIAAAcYIBvBQkAnwQCAm8FCgAwBQS6CwAAADABBCQMAAAApAQIAAAcYIBvBQ0AnwQCAm8FDgAwBQS6CwAAADABBCQMAAAApAQQAAAA8EBNBAQkDAAAAE0FBB0RAAAA2QYBABIABQASAAQAbwkSALwHALgTAAAAnwcDArwIBToUAAAAnwgCAk0JBB8VAAAAvAkJOhQAAACfCQICMAgJJAwAAAAwBwgkDAAAAKQHFwAAAGBBvAgCqxgAAACfCAIDFwcHAKQMGwAAaJCB2Q0CABIABQASAAQAEgALAJ8MAgFuB/j/AgAAAIIAAQAcAw8EAAAAQAMQAxEDEgMTAwEDAgQAHGCAAxQDFQMEAwUDFgMXAxgEAADwQAMZAxoDGwMHAwgDHAQAAGBBAx0DHgMfBABokIEDAAECAQABGAAAAAAAAAEAAAAAAAEAAAAAAAIAAQAAAAEAAAEA/gAAAAEAAAEABQAAAAEAAgAABgAAAPsAAAEAAAAAAAACAAQAAAAAAAEAAAAAAAD/AAoCAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgMBAwEAARgAAAABAAAAAASNW6oOoKaKPoJgOqWzD+lW/UO9er+fwA8=

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local StarterPlayer = game:GetService("StarterPlayer")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")

	local function InitRemote(p1, p2) --[[ InitRemote | Line: 6 | Upvalues: ReplicatedStorage (copy) ]]
		local v1 = Instance.new(p1)

		v1.Name = "ClientCast-" .. p2
		v1.Parent = ReplicatedStorage
	end

	local v1 = Instance.new("RemoteEvent")

	v1.Name = "ClientCast-Replication"
	v1.Parent = ReplicatedStorage

	local v2 = Instance.new("RemoteFunction")

	v2.Name = "ClientCast-Ping"
	v2.Parent = ReplicatedStorage

	local v3 = script.Parent
	local ClientHandler = v3.ClientHandler

	local function CloneHandler(p1) --[[ CloneHandler | Line: 17 | Upvalues: ClientHandler (copy), v3 (copy) ]]
		local v1 = ClientHandler:Clone()

		v3.Signal:Clone().Parent = v1
		v1.Parent = p1
	end

	local StarterPlayerScripts = StarterPlayer:FindFirstChildOfClass("StarterPlayerScripts")
	local v4 = ClientHandler:Clone()

	v3.Signal:Clone().Parent = v4
	v4.Parent = StarterPlayerScripts

	local v5 = next
	local v6, v7 = Players:GetPlayers()

	for v8, v9 in v5, v6, v7 do
		task.spawn(function() --[[ Line: 26 | Upvalues: ClientHandler (copy), v3 (copy), v9 (copy) ]]
			local ScreenGui = Instance.new("ScreenGui")

			ScreenGui.Name = "ClientCast-Temp"
			ScreenGui.ResetOnSpawn = false

			local v1 = ClientHandler:Clone()

			v3.Signal:Clone().Parent = v1
			v1.Parent = ScreenGui
			ScreenGui.Parent = v9:WaitForChild("PlayerGui")
		end)
	end
end