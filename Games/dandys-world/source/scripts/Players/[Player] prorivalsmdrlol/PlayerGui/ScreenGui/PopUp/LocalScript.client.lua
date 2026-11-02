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
-- CQMlBFBsYXkLVUlDbGlja1NvZnQHRGVzdHJveQZzY3JpcHQGUGFyZW50BUNsaWNrBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQxUd2VlblNlcnZpY2UGRGVicmlzB3JlcXVpcmULU2hhcmVkVXRpbHMMV2FpdEZvckNoaWxkF0hhcHRpY0VmZmVjdHNDb250cm9sbGVyB0FkZEl0ZW0HVmlzaWJsZQVQb3BVcARTaXplBVVEaW0yA25ldwRtYXRoBnJhbmRvbQhQb3NpdGlvbglUd2VlbkluZm8ERW51bQtFYXNpbmdTdHlsZQZCb3VuY2UPRWFzaW5nRGlyZWN0aW9uA091dAFYBVNjYWxlAVkGQ3JlYXRlCkV4aXRCdXR0b24JQWN0aXZhdGVkB0Nvbm5lY3QAAgMAAwAAAA77AAAAvAAA7gAAAACfAAIB+wABAG8CAQC8AADuAAAAAJ8AAwH7AAIAvAAAUAIAAACfAAIBggABAAMDAQMCAwMAIQABGAAAAAABAAAAAAEAAAABIgAAAAASAAABAgCRAaMAAACkAAEAAAAAQE0AACQCAAAApAEBAAAAAEBNAQEkAgAAAE0BASQCAAAATQEBTwMAAACkAgUAAABAQG8EBgC8AgIWBwAAAJ8CAwKkAwUAAABAQG8FCAC8AwMWBwAAAJ8DAwKkBAUAAABAQG8GCQC8BAQWBwAAAJ8EAwKkBQsAAACgQG8IDAC8BgLTDQAAAJ8GAwJvCA4AvAYG0w0AAACfBgMAnwUAAlIIAACMCR4AvAYEeA8AAACfBgQBqQYBADAGAIAQAAAATQYA0xEAAAC8BgbuEgAAAJ8GAgGkBgEAAAAAQE0GBiQCAAAATQYGLxMAAACkBxYAAFRAgaQJGgAAZICBjAoZAIwLSwCfCQMCPggJF4wJAACkCxoAAGSAgYwMIwCMDUYAnwsDAj4KCxeMCwAAnwcFAjAHADsbAAAApAcdAABUwIFvCB4ApAkiACGA8MGkCiUAJIzwwZ8HBAKkCAEAAAAAQE0ICCQCAAAApAkWAABUQIFNCwZ5JwAAAE0LC4QoAAAAWwoLJowLAABNDQZ4KQAAAE0NDYQoAAAAWwwNJowNAACfCQUCMAkILxMAAABSCgAAUgsHAOIMKgCkDRYAAFRAgU0OBnknAAAATQ4OhCgAAACMDwAATRAGeCkAAABNEBCEKAAAAIwRAACfDQUCMA0MLxMAAAC8CAOWKwAAAJ8IBQK8CQjuEgAAAJ8JAgFNCQAnLAAAAE0JCR4tAAAAwAsuABIAAQASAAUAEgAAALwJCccvAAAAnwkDAYIAAQAwAwQEAAAAQAMFAwYDBwQAAEBAAwgDCQMKAwsDDAQAAKBAAw0DDgMPAxADEQMSAwEDEwMUAxUEAFRAgQIAAAAAAABZQAMWAxcEAGSAgQMYAxkEAFTAgQIAAAAAAADgPwMaAxsDHAQhgPDBAx0DHgQkjPDBAs3MzMzMzOw/Ax8DIAMhBQETAyIDIwMkBgADJQEAAQABGAAAAAAAAQAAAAAAAAACAAAAAAABAAAAAAACAAAAAAACAAAAAAAAAAAAAAIAAAAAAgAAAgAAAAADAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAgABAQABAP0GAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAABAAACAAAAAAAAAAAAAAQBAAAAAAF2NA3O6C3nLp8mPkybF3dVBiwaukTwZ88=

-- https://lua.expert/
local v1 = script.Parent
local Click = script.Parent.Parent.Click
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HapticEffectsController = require(ReplicatedStorage:WaitForChild("SharedUtils"):WaitForChild("HapticEffectsController"))

Debris:AddItem(v1, 30)
v1.Visible = true
v1.PopUp:Play()

local Size = script.Parent.Size

v1.Position = UDim2.new(math.random(25, 75) / 100, 0, math.random(35, 70) / 100, 0)

local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)

script.Parent.Size = UDim2.new(Size.X.Scale * 0.9, 0, Size.Y.Scale * 0.9, 0)
TweenService:Create(v1, v2, {
	Size = UDim2.new(Size.X.Scale, 0, Size.Y.Scale, 0)
}):Play()
v1.ExitButton.Activated:Connect(function() --[[ Line: 33 | Upvalues: Click (copy), HapticEffectsController (copy), v1 (copy) ]]
	Click:Play()
	HapticEffectsController:Play("UIClickSoft")
	v1:Destroy()
end)