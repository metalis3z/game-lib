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
-- CQMxCXdvcmtzcGFjZQRJbmZvDkZpbmRGaXJzdENoaWxkEkJhcm5hYnlGbG9wRW5hYmxlZAxHZXRBdHRyaWJ1dGUJaXNFbmFibGVkFUJhcm5hYnlGbG9wQWx3YXlzUGxheQZzaW5nbGUNb3ZlcmxhcFBvbGljeRRyZXNvbHZlT3ZlcmxhcFBvbGljeRJCYXJuYWJ5RmxvcEFuY2hvclkEdHlwZQZudW1iZXIGQ0ZyYW1lA25ldwZvZmZzZXQNcmVzb2x2ZU9mZnNldAtDdXJyZW50U2tpbgAHRGVmYXVsdAdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQtTaGFyZWRVdGlscwxXYWl0Rm9yQ2hpbGQIVG93ZXJMVVQERmlubgdHZXRTa2luBXBjYWxsBXRhYmxlDkJhcm5hYnlUZXh0dXJlC0Jhcm5hYnlfR2VvF3Jlc29sdmVUZXh0dXJlT3ZlcnJpZGVzDHRlbXBsYXRlUGF0aA5hdHRhY2hQYXJ0TmFtZRBIdW1hbm9pZFJvb3RQYXJ0CGNvb2xkb3duBXF1ZXVlEGhpZGVXaGlsZVBsYXlpbmcPaG9wQW5pbWF0aW9uSWRzBkFzc2V0cwRSaWdzCkJhcm5hYnlSaWcccmJ4YXNzZXRpZDovLzEyMDQzOTA2MTM5MTQyNRxyYnhhc3NldGlkOi8vMTM1ODg5MTQ4MzQxODAzHHJieGFzc2V0aWQ6Ly8xMjQzNjI1OTIyMjg3ODMccmJ4YXNzZXRpZDovLzEzMzAwMzMxNjkyMzI4NhtyYnhhc3NldGlkOi8vODE0ODQzNjczMDMwMjkABQQAAAAAABWkAAEAAAAAQG8CAgC8AAADAwAAAJ8AAwJSAQAADgEEAG8DBAC8AQASBQAAAJ8BAwJHAQMAAAAAgKkCAQCCAgIADgECAKkCAQCCAgIAqQIAAIICAgAGAwEEAAAAQAMCAwMDBAMFAD4GARgAAAAAAAABAAAAAAABAAAAAQAAAAA/AAAAAAQAAQAAABSkAAEAAAAAQG8CAgC8AAADAwAAAJ8AAwJSAQAADgEEAG8DBAC8AQASBQAAAJ8BAwIqAQMAAAAAgG8CBgCCAgIA+wIAAE0CAhgHAAAAggICAAgDAQQAAABAAwIDAwMHAwUDCAMJAEUKARgAAAAAAAABAAAAAAABAAAAAgAAAEYAAAAABgABAAAAHqQAAQAAAABAbwICALwAAAMDAAAAnwADAlIBAAAOAQQAbwMEALwBABIFAAAAnwEDArsoAQNSAwEApAIHAAAAYECfAgIC8AIIAAgAAICkAgsAACiQgIwDAABSBAEAjAUAAJ8CBACCAgAA+wIAAE0CAlAMAAAAggICAA0DAQQAAABAAwIDAwMLAwUDDAQAAGBAAw0DDgMPBAAokIADEABREQEYAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAACAAAAUgAAAAAIAQAAAABBKwACAMYBAACCAQIAbwMAALwBABIBAAAAnwEDAg4BBADwAQMAAgAAAPABAwADAACAxgIAAIICAgCkAgUAAABAQKQDBwAAAGBAbwUIALwDAxYJAAAAnwMDAm8FCgC8AwPTCwAAAJ8DAwJvBQwAvAMD0wsAAACfAwMAnwIAAm8FDQBSBgEAvAMCuw4AAACfAwQCKwMCAMYEAACCBAIApAQQAAAA8ECkBQUAAABAQFIGAwCfBAMDDgQKALsoBQNSBwUApAYSAAAAEEGfBgIC8AYEABMAAIBNBgWAFAAAACsGAgDGBgAAggYCAP8GAQAAAAAATQcFgBQAAAAwBwZFFQAAAIIGAgAWAxIDBQMTAxQDFQQAAEBAAxYEAABgQAMXAxgDGQMaAxsDHAMdAx4EAADwQAMMBAAAEEEDHwMgAyEAZCIBGAAAAAEAAAABAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAABAAAAAAEAAAIAAAAAAAEAAAAAAAAAAAAAAAACAAAAAAAAZQAAAAAHAAABAgA0owAAAOIACgD/AQAAAwAAAG8CCwBvAwwAbwQNAMUBAgQBAAAAMAEAowAAAACkARAAADzggIwCAACMAwIAjAQAAJ8BBAIwAQBQAwAAAP8BAAABAAAAbwIRAMUBAgIBAAAAMAEAIAgAAAD/AQAABQAAAG8CEgBvAxMAbwQUAG8FFQBvBhYAxQECBgEAAAAwAQDmCQAAAMABFwAwAQA8GAAAAMABGQASAAAAMAEAHhoAAADAARsAEgAAADABAEgcAAAAwAEdADABAPceAAAAggACAB8DIwMkAyUDEAMmAgAAAAAAANA/AwkDJwMoAykIBwD/////AQIAAAAD/////wQFAAAABgcAAAAI/////wn/////AyoDKwMsAw4DDwQAPOCAAyEDLQMuAy8DMAMxBgADBgYBAwoGAgMRBgMDIgQAAQIDAQABGAATAwAAAAAAAAAACgAAAAAAAAALAAAAAAAABgABAQEBAQAA+wAMAAAHAAAADAAAABMAAA8BAAAAAARRSZPEPVbYyYu8BN7AWp8wIVGEsGON+cU=

-- https://lua.expert/
local t = {
	attachPartName = "HumanoidRootPart",
	cooldown = 0.25,
	overlapPolicy = "queue",
	templatePath = { "Assets", "Rigs", "BarnabyRig" },
	offset = CFrame.new(0, 2, 0),
	hideWhilePlaying = { "Barnaby_Geo" },
	hopAnimationIds = { "rbxassetid://120439061391425", "rbxassetid://135889148341803", "rbxassetid://124362592228783", "rbxassetid://133003316923286", "rbxassetid://81484367303029" },
	isEnabled = function() --[[ isEnabled | Line: 62 ]]
		local Info = workspace:FindFirstChild("Info")
		local v1 = if Info then Info:GetAttribute("BarnabyFlopEnabled") else Info

		if v1 == nil then
			return true
		end

		return v1 and true or false
	end
}

function t.resolveOverlapPolicy() --[[ resolveOverlapPolicy | Line: 69 | Upvalues: t (copy) ]]
	local Info = workspace:FindFirstChild("Info")

	if (if Info then Info:GetAttribute("BarnabyFlopAlwaysPlay") else Info) == false then
		return "single"
	end

	return t.overlapPolicy
end
function t.resolveOffset() --[[ resolveOffset | Line: 81 | Upvalues: t (copy) ]]
	local Info = workspace:FindFirstChild("Info")
	local v1 = if Info then Info:GetAttribute("BarnabyFlopAnchorY") else Info

	if type(v1) == "number" then
		return CFrame.new(0, v1, 0)
	end

	return t.offset
end
function t.resolveTextureOverrides(p1) --[[ resolveTextureOverrides | Line: 100 ]]
	if not p1 then
		return nil
	end

	local v1 = p1:GetAttribute("CurrentSkin")

	if not v1 or (v1 == "" or v1 == "Default") then
		return nil
	end

	local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedUtils"):WaitForChild("TowerLUT")):GetSkin("Finn", v1)

	if not v2 then
		return nil
	end

	local ok, result = pcall(require, v2)

	if ok and (type(result) == "table" and result.BarnabyTexture) then
		return {
			Barnaby_Geo = result.BarnabyTexture
		}
	end

	return nil
end

return t