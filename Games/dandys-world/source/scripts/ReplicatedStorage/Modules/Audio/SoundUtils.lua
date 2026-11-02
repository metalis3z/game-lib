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
-- CQMQBVNvdW5kA0lzQQpUaW1lTGVuZ3RoBkxvYWRlZARXYWl0BG1hdGgDbWF4B0FkZEl0ZW0LU2FmZUNsZWFudXAFQ2xvbmUGUGFyZW50BFBsYXkOUGxheUFuZENsZWFudXAEZ2FtZQZEZWJyaXMKR2V0U2VydmljZQADCQIBAAAAIQ4ABQBvBAAAvAIA/gEAAACfAgMCKwIBAIIAAQCQAQECTQIA1gMAAAANAgkABAAAgE0DAAQFAAAAvAMD9wYAAACfAwICDgMCAE0CANYDAAAA+wMAAFIFAACeEgIFAQAAAFIHAgBSCAEApAYJAAAgcICfBgMCvAMDeAoAAACfAwQBggABAAsDAQMCAgAAAAAAAPA/AwMCAAAAAAAAAAADBAMFAwYDBwQAIHCAAwgAFgkBGAAAAAAAAAACAgABAAIAAAAAAQEABQAAAAAAAAAAAAAAARcAAAAABwMBAAAAFw4ABQBvBQAAvAMA/gEAAACfAwMCKwMCAMYDAACCAwIAvAMAOgIAAACfAwICMAEDJAMAAAC8BAPuBAAAAJ8EAgH7BAAATQQEkAUAAABSBQMAUgYCAJ8EAwGCAwIABgMBAwIDCgMLAwwDCQA1DQEYAAAAAAAAAAACAAABAAEAAAEAAAAAAAI2AAAAAAMAAAECABKjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wECAAAAAADAAgQAEgAAADACAZAFAAAAwAIGABIAAQAwAgHIBwAAAIIBAgAIAw4EAAAAQAMPAxAGAAMJBgEDDQIAAQEAARgABAAAAAAAAgAPAAAAHwAAAAsBAAAAAAIzSv3gx7YD+Q/I0/vAaykmQ1LqlAGOl+E=

-- https://lua.expert/
local Debris = game:GetService("Debris")
local t = {
	SafeCleanup = function(p1, p2) --[[ SafeCleanup | Line: 22 | Upvalues: Debris (copy) ]]
		if not (p1 and p1:IsA("Sound")) then
			return
		end

		local TimeLength = p1.TimeLength

		if TimeLength == 0 and p1.Loaded:Wait() then
			TimeLength = p1.TimeLength
		end

		Debris:AddItem(p1, (math.max(TimeLength, p2 or 1)))
	end
}

function t.PlayAndCleanup(p1, p2, p3) --[[ PlayAndCleanup | Line: 53 | Upvalues: t (copy) ]]
	if p1 and p1:IsA("Sound") then
		local v1 = p1:Clone()

		v1.Parent = p2
		v1:Play()
		t.SafeCleanup(v1, p3)

		return v1
	end

	return nil
end

return t