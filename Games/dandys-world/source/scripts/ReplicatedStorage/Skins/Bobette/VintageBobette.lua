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
-- CQMcB1ByZXNlbnQMV2FpdEZvckNoaWxkA0JveAx3YWl0Rm9yQ2hpbGQDQm93BkNvbG9yMwNuZXcFQ29sb3IKUmluZ1JhbmdlcgVwYWlycw5HZXREZXNjZW5kYW50cwhNZXNoUGFydANJc0EccmJ4YXNzZXRpZDovLzEyMDk3NzE1NDYxODA0NwlUZXh0dXJlSUQGQ29uZmlnDEJsaW5rVGV4dHVyZQtIdXJ0VGV4dHVyZQ1Ob3JtYWxUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NTQxNzg5NTcwNzI4NAdUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTc4MDAxODU2MDAxOTgJQXBwbHlTa2luD1ZpbnRhZ2UgQm9iZXR0ZQROYW1lBGdhbWURQ29sbGVjdGlvblNlcnZpY2UKR2V0U2VydmljZQACDQEAAAAAUW8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIB8wMAAACfAgMCbwUEALwDAfMDAAAAnwMDAqQEBwAAGFCAjAUAAIwGAACMBwAAnwQEAjAEA6QIAAAApAQHAAAYUICMBQEAjAYBAIwHAQCfBAQCMAQCpAgAAABvBgkAvAQA0wEAAACfBAMCpAULAAAAoEC8BgBHDAAAAJ8GAgCfBQAEFwUOAG8MDQC8Cgn+DgAAAJ8KAwIOCgkA8QkIAAIAAADxCQYAAwAAAPEJBAAEAAAAbwoPADAKCYQQAAAAbgXx/wIAAABvBxEAvAUA0wEAAACfBQMCbwgSALwGBdMBAAAAnwYDAm8JEwC8BwXTAQAAAJ8HAwJvChQAvAgF0wEAAACfCAMCbwkVADAJBk8WAAAAbwkXADAJB08WAAAAbwkPADAJCE8WAAAAggABABgDAQMCAwMDBAMFAwYDBwQAGFCAAwgDCQMKBAAAoEADCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYABxcBGAAAAAABAAAAAQAAAAIAAAAAAAAAAQAAAAAAAAABAAAAAgAAAAAAAAEAAAAAAAAAAAAAAQAA/gAGAAAAAgAAAAEAAAABAAAAAgAAAQAAAQAAAQkAAAAABAAAAQIAEKMAAAD/AAIAAAAAAG8BAAAwAQC6AQAAAKQBAwAAACBAbwMEALwBARYFAAAAnwEDAsACBgAwAgDpBwAAAIIAAgAIAxgDGQMaBAAAIEADGwMcBgADFwEAAQABGAAAAAIAAAIAAAAAAAIAABsBAAAAAAHimWxQ4NuypFy4BPgVNIE0koF7JNBdBlE=

-- https://lua.expert/
local t = {
	Name = "Vintage Bobette"
}

game:GetService("CollectionService")
function t.ApplySkin(p1) --[[ ApplySkin | Line: 7 ]]
	local Present = p1:WaitForChild("Present")
	local v1 = Present:waitForChild("Box")
	local v2 = Present:waitForChild("Bow")

	v2.Color = Color3.new(0/255, 0/255, 0/255)
	v1.Color = Color3.new(255/255, 255/255, 255/255)

	local RingRanger = p1:WaitForChild("RingRanger")

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") and (v ~= v1 and (v ~= v2 and v ~= RingRanger)) then
			v.TextureID = "rbxassetid://120977154618047"
		end
	end

	local Config = p1:WaitForChild("Config")
	local BlinkTexture = Config:WaitForChild("BlinkTexture")
	local HurtTexture = Config:WaitForChild("HurtTexture")
	local NormalTexture = Config:WaitForChild("NormalTexture")

	BlinkTexture.Texture = "rbxassetid://95417895707284"
	HurtTexture.Texture = "rbxassetid://117800185600198"
	NormalTexture.Texture = "rbxassetid://120977154618047"
end

return t