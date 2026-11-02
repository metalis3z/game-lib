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
-- CQMSB091dGNvbWUGUmVhc29uFkNvbGxlY3RlZCBhbiBvcm5hbWVudCEHVXNlSXRlbQhPcm5hbWVudAROYW1lCVBvaW50Q29zdA5EYW5keVN0b3JlSXRlbQlGbG9vckl0ZW0GQ29tbW9uBlJhcml0eRtyYnhhc3NldGlkOi8vODYwNjQ0OTkzMzk0MDUESWNvbjtBIGZlc3RpdmUgb3JuYW1lbnQgdGhhdCBnaXZlcyB5b3UgNSBiYXVibGVzIHdoZW4gY29sbGVjdGVkLgtEZXNjcmlwdGlvbgRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlAAIDAgAAAAAC4gIEAIICAgAFAwEBAQMCAwMIAgABAAAAAgMAAAAADQQBGAAHDgAAAAAEAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAjAEFADABAGMCAAAAqQEAADABAHgDAAAAqQEAADABAB8EAAAAbwEFADABAPIGAAAAbwEHADABAK4IAAAAbwEJADABAOIKAAAApAEMAAAAsEBvAw0AvAEBFg4AAACfAQMCwAIPADACAFkQAAAAggACABEDBQMGAwcDCAMJAwoDCwMMAw0DDgMPAxAEAACwQAMRAxIGAAMEAQABAAEYAAAAAgAAAQAAAQAAAQAAAQAAAQAAAQAAAgAAAAAAAgAACwEAAAAAAe53PRMIOgEwEdIF2uafsDuebypn3LNXEg==

-- https://lua.expert/
local t = {
	Name = "Ornament",
	PointCost = 5,
	DandyStoreItem = false,
	FloorItem = false,
	Rarity = "Common",
	Icon = "rbxassetid://86064499339405",
	Description = "A festive ornament that gives you 5 baubles when collected."
}

game:GetService("Debris")
function t.UseItem(p1, p2) --[[ UseItem | Line: 13 ]]
	return {
		Outcome = true,
		Reason = "Collected an ornament!"
	}
end

return t