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
-- CQMRBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlC0xvY2FsUGxheWVyBnNjcmlwdAZQYXJlbnQRUmVwbGljYXRlZFN0b3JhZ2UKUGxheWVyRGF0YQZVc2VySWQIdG9zdHJpbmcORmluZEZpcnN0Q2hpbGQEdGFzawR3YWl0D0hpZ2hsaWdodFRvZ2dsZQxXYWl0Rm9yQ2hpbGQFVmFsdWUHRW5hYmxlZAABCAAAAQAAP6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwJNAQAxBAAAAKQCBgAAAFBATQICJAcAAACkAwEAAAAAQE0DAz8IAAAATQMD9gkAAABNBgHmCgAAALs/BgKkBQwAAACwQJ8FAgK8AwMDDQAAAJ8DAwKkBBAAADzggIwFAQCfBAIBpAQBAAAAAEBNBAQ/CAAAAE0EBPYJAAAATQcB5goAAAC7PwcCpAYMAAAAsECfBgICvAQEAw0AAACfBAMCUgMEACsDAQBIAOr/DgMLAG8GEQC8BAPTEgAAAJ8EAwJNBQTsEwAAACoFBAABAACAqQUBADAFAvAUAAAAggABABUDAQQAAABAAwIDAwMEAwUEAABQQAMGAwcDCAMJAwoEAACwQAMLAwwDDQQAPOCAAw4DDwMQAxEAAQABGAAAAAAAAAABAAEAAAABAAAAAAAAAAAAAAAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAEAAgEAAAACAAAAAQAAAgEAAAAAAAt9MkNm8zgUYH9EG3abNb57ZSU3OblYQg==

-- https://lua.expert/
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = script.Parent
local PlayerData = game.ReplicatedStorage.PlayerData

PlayerData:FindFirstChild((tostring(LocalPlayer.UserId)))

local v2

repeat
	task.wait(1)

	local PlayerData2 = game.ReplicatedStorage.PlayerData

	v2 = PlayerData2:FindFirstChild((tostring(LocalPlayer.UserId)))
until v2

if not v2 or v2:WaitForChild("HighlightToggle").Value ~= true then
	return
end

v1.Enabled = true