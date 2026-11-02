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
-- CQMcCXdvcmtzcGFjZQRJbmZvDkZpbmRGaXJzdENoaWxkEkJhcm5hYnlGbG9wRW5hYmxlZAxHZXRBdHRyaWJ1dGUJaXNFbmFibGVkFUJhcm5hYnlGbG9wQWx3YXlzUGxheQZzaW5nbGUNb3ZlcmxhcFBvbGljeRRyZXNvbHZlT3ZlcmxhcFBvbGljeQx0ZW1wbGF0ZVBhdGgOYXR0YWNoUGFydE5hbWUESGVhZAZvZmZzZXQIY29vbGRvd24FcXVldWUQaGlkZVdoaWxlUGxheWluZw9ob3BBbmltYXRpb25JZHMGQXNzZXRzBFJpZ3MKQmFybmFieVJpZwZDRnJhbWUDbmV3C0Jhcm5hYnlfR2VvHHJieGFzc2V0aWQ6Ly8xMjQ4OTcyOTUxOTE4MDgccmJ4YXNzZXRpZDovLzEzNjI5ODM0NzkxMTEwMBxyYnhhc3NldGlkOi8vMTIzNTg3NDc1MDI1OTU2G3JieGFzc2V0aWQ6Ly83NjUwNzQ3NTQxNDEzMwADBAAAAAAAFaQAAQAAAABAbwICALwAAAMDAAAAnwADAlIBAAAOAQQAbwMEALwBABIFAAAAnwEDAkcBAwAAAACAqQIBAIICAgAOAQIAqQIBAIICAgCpAgAAggICAAYDAQQAAABAAwIDAwMEAwUAKgYBGAAAAAAAAAEAAAAAAAEAAAABAAAAACsAAAAABAABAAAAFKQAAQAAAABAbwICALwAAAMDAAAAnwADAlIBAAAOAQQAbwMEALwBABIFAAAAnwEDAioBAwAAAACAbwIGAIICAgD7AgAATQICGAcAAACCAgIACAMBBAAAAEADAgMDAwcDBQMIAwkAMQoBGAAAAAAAAAEAAAAAAAEAAAACAAAAMgAAAAAGAAABAgAsowAAAOIACgD/AQAAAwAAAG8CCwBvAwwAbwQNAMUBAgQBAAAAMAEAowAAAACkARAAADzggIwCAACMA/z/jAQAAJ8BBAIwAQBQAwAAAP8BAAABAAAAbwIRAMUBAgIBAAAAMAEAIAgAAAD/AQAABAAAAG8CEgBvAxMAbwQUAG8FFQDFAQIFAQAAADABAOYJAAAAwAEWADABADwXAAAAwAEYABIAAAAwAQAeGQAAAIIAAgAaAwsDDAMNAw4DDwIAAAAAAADQPwMJAxADEQMSCAcA/////wECAAAAA/////8EBQAAAAYHAAAACP////8J/////wMTAxQDFQMWAxcEADzggAMYAxkDGgMbAxwGAAMGBgEDCgIAAQEAARgABwMAAAAAAAAAAAYAAAAAAAAACwAAAAAAAAMAAQEBAQAA/AALAAAHAAAACAEAAAAAArDafm2keIIWS8NLXe2XpenAwmkZgh4UbA==

-- https://lua.expert/
local t = {
	attachPartName = "Head",
	cooldown = 0.25,
	overlapPolicy = "queue",
	templatePath = { "Assets", "Rigs", "BarnabyRig" },
	offset = CFrame.new(0, -4, 0),
	hideWhilePlaying = { "Barnaby_Geo" },
	hopAnimationIds = { "rbxassetid://124897295191808", "rbxassetid://136298347911100", "rbxassetid://123587475025956", "rbxassetid://76507475414133" },
	isEnabled = function() --[[ isEnabled | Line: 42 ]]
		local Info = workspace:FindFirstChild("Info")
		local v1 = if Info then Info:GetAttribute("BarnabyFlopEnabled") else Info

		if v1 == nil then
			return true
		end

		return v1 and true or false
	end
}

function t.resolveOverlapPolicy() --[[ resolveOverlapPolicy | Line: 49 | Upvalues: t (copy) ]]
	local Info = workspace:FindFirstChild("Info")

	if (if Info then Info:GetAttribute("BarnabyFlopAlwaysPlay") else Info) == false then
		return "single"
	end

	return t.overlapPolicy
end

return t