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
-- CQMTBnR5cGVvZgV0YWJsZQdVSUVycm9yDlByZWZlcnJlZElucHV0BE5hbWUEUGxheQRTdG9wBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZRBVc2VySW5wdXRTZXJ2aWNlB3JlcXVpcmULU2hhcmVkVXRpbHMMV2FpdEZvckNoaWxkF0hhcHRpY0VmZmVjdHNDb250cm9sbGVyB05ldHdvcmsKUGxheUhhcHRpYwlBZGRBY3Rpb24KU3RvcEhhcHRpYwADBQEDAQAAGaMBAAC7LAADUgIAAKQBAQAAAABAnwECAvABCAACAACA+wIAAE0CAvAEAAAATQICugUAAACHAQACkAABA/sBAQBSAwAA3QQAALwBAe4GAAAAnwEAAg4BAgD7AgIAagECAIIAAQAHAwEEAAAAQAMCAwMDBAMFAwYACwABGAAEAAAAAAAAAQAAAAAAAAUAAAAAAAEBAAILAAAAAAQBAQEAAAujAQAA+wIAAIcBAgAOAQYAvAIB+gAAAACfAgIB+wIAAMYDAABqAwIAggABAAEDBwAbAAEYAAEAAQEAAAEAAAIbAAAAAAkAAAECADKjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBvBQcAvAMA0wgAAACfAwMCbwUJALwDA9MIAAAAnwMDAJ8CAAKkAwYAAABQQE0EAKAHAAAAbwYKALwEBNMIAAAAnwQDAJ8DAAL/BAAAAAAAAG8HCwDACAwAEgABABIAAgASAAQAvAUDDg0AAACfBQQBbwcOAMAIDwASAAQAvAUDDg0AAACfBQQBggABABADCAQAAABAAwkDCgMLAwwEAABQQAMNAw4DDwMQAxEGAAMSAxMGAQIAAQEAARgAAQAAAAAAAQAAAAAAAgAAAAAAAAAAAAABAAAAAAAAAAADAAIAAAAAAAAAEAAAAAAACAEAAAAAAsZuSjmAzJwQL9RKVfC6c3K2dl1N9KogOA==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local HapticEffectsController = require(ReplicatedStorage:WaitForChild("SharedUtils"):WaitForChild("HapticEffectsController"))
local Network = require(ReplicatedStorage.SharedUtils:WaitForChild("Network"))
local t = {}

Network:AddAction("PlayHaptic", function(p1, ...) --[[ Line: 11 | Upvalues: UserInputService (copy), HapticEffectsController (copy), t (copy) ]]
	if typeof(p1) == "table" then
		p1 = p1[UserInputService.PreferredInput.Name] or "UIError"
	end

	local v1 = HapticEffectsController:Play(p1, ...)

	if not v1 then
		return
	end

	t[p1] = v1
end)
Network:AddAction("StopHaptic", function(p1, ...) --[[ Line: 27 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	v1:Stop()
	t[p1] = nil
end)