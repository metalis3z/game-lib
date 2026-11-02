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
-- CQMWCEh1bWFub2lkDFdhaXRGb3JDaGlsZAZIZWFsdGgJTWF4SGVhbHRoB091dGNvbWUGUmVhc29uI0Nhbid0IHVzZSB0aGF0IGl0ZW0gYXQgZnVsbCBIZWFsdGghB1VzZUl0ZW0EVGFwZQROYW1lCVBvaW50Q29zdA5EYW5keVN0b3JlSXRlbQlGbG9vckl0ZW0GQ29tbW9uBlJhcml0eRtyYnhhc3NldGlkOi8vODk3MjgyMTE4Mjg1OTUESWNvbhhUaGlzIGdpdmVzIHlvdSAxMCBUYXBlcy4LRGVzY3JpcHRpb24EZ2FtZQZEZWJyaXMKR2V0U2VydmljZQACBQIAAAAADm8EAAC8AgDTAQAAAJ8CAwJNAwJaAgAAAE0EAp4DAAAAfQQDAAMAAADiAwgAggMCAOIDCgCCAwIACwMBAwIDAwMEAwUBAAMGAwcIAgQFAAAABgcAAAABAQgCBAkAAAAGBwAAAAANCAEYAAAAAAEAAAAAAAEEAgUOAAAAAAQAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACMAQUAMAEAYwIAAACpAQAAMAEAeAMAAACpAQEAMAEAHwQAAABvAQUAMAEA8gYAAABvAQcAMAEArggAAABvAQkAMAEA4goAAACkAQwAAACwQG8DDQC8AQEWDgAAAJ8BAwLAAg8AMAIAWRAAAACCAAIAEQMJAwoDCwMMAw0DDgMPAxADEQMSAxMDFAQAALBAAxUDFgYAAwgBAAEAARgAAAACAAABAAABAAABAAABAAABAAABAAACAAAAAAACAAASAQAAAAABFpKLSOzoEbBYPKZP34y+cGaKnDwkVuFJ

-- https://lua.expert/
local t = {
	Name = "Tape",
	PointCost = 5,
	DandyStoreItem = false,
	FloorItem = true,
	Rarity = "Common",
	Icon = "rbxassetid://89728211828595",
	Description = "This gives you 10 Tapes."
}

game:GetService("Debris")
function t.UseItem(p1, p2) --[[ UseItem | Line: 13 ]]
	local Humanoid = p1:WaitForChild("Humanoid")

	if Humanoid.Health >= Humanoid.MaxHealth then
		return {
			Outcome = false,
			Reason = "Can\'t use that item at full Health!"
		}
	end

	return {
		Outcome = true,
		Reason = "Can\'t use that item at full Health!"
	}
end

return t