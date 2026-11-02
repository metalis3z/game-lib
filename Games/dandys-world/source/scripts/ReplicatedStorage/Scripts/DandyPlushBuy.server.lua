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
-- CQMUBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlC0xvY2FsUGxheWVyCXdvcmtzcGFjZQ1JbkdhbWVQbGF5ZXJzBE5hbWUORmluZEZpcnN0Q2hpbGQIVHJpbmtldHMMV2FpdEZvckNoaWxkCFRyaW5rZXQxCFRyaW5rZXQyBVZhbHVlCkRhbmR5UGx1c2gGc2NyaXB0BlBhcmVudARtYXRoBXJvdW5kBiBUYXBlcwpPYmplY3RUZXh0AAEOAAABAgBEowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAk0BADEEAAAApAIGAAAAUEBNAgJKBwAAAE0EAboIAAAAvAICAwkAAACfAgMCqQMAAA4CLwBvBgoAvAQC0wsAAACfBAMCbwcMALwFBNMLAAAAnwUDAm8IDQC8BgTTCwAAAJ8GAwJNBwXsDgAAAPAHBAAPAACAKwMBAIwDAQBbAwMQTQcG7A4AAADwBwQADwAAgCsDAQCMAwEAWwMDEA4DFACkBxIAAAAQQU0HByQTAAAApA0SAAAAEEFNDQ3sDgAAAE0NDewOAAAACQwNA7swDAKkCxYAAFRAgZ8LAgJSCQsAbwoXAHMICQowCAcHGAAAAIIAAQAZAwEEAAAAQAMCAwMDBAMFBAAAUEADBgMHAwgDCQMKAwsDDAMNAw4CAAAAAAAA4D8DDwQAABBBAxADEQMSBABUQIEDEwMUAAEAARgAAAAAAAAAAQACAAAAAAAAAAACAgEAAAABAAAAAQAAAAIAAAABAQICAAAAAQECAwEAAAAAAAAAAAAAAAAAAAAAAAAAAgEAAAAAAP0XoHsy8qV8hTwH7ZWk1tyND7cPz9PKeg==

-- https://lua.expert/
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = workspace.InGamePlayers:FindFirstChild(LocalPlayer.Name)
local v2 = false

if not v1 then
	return
end

local Trinkets = v1:WaitForChild("Trinkets")
local Trinket1 = Trinkets:WaitForChild("Trinket1")
local Trinket2 = Trinkets:WaitForChild("Trinket2")

if Trinket1.Value == "DandyPlush" then
	if not v2 then
		v2 = 1
	end

	v2 = v2 * 0.5
end

if Trinket2.Value == "DandyPlush" then
	if not v2 then
		v2 = 1
	end

	v2 = v2 * 0.5
end

if not v2 then
	return
end

local v3 = script.Parent

v3.ObjectText = math.round(script.Value.Value * v2) .. " Tapes"