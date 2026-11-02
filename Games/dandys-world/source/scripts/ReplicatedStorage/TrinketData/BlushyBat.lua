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
-- CQMbCFRyaW5rZXRzDFdhaXRGb3JDaGlsZAVTdGF0cwxBcHBseVRyaW5rZXQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQKQmx1c2h5IEJhdBhyYnhhc3NldGlkOi8vMTc4MjY2MjQ2NjAESWNvbgZDb21tb24GUmFyaXR5iAFJbmNyZWFzZXMgdGhlIEF0dGFjayBDb29sZG93biBvZiBhbnkgVHdpc3RlZCB0aGF0IGF0dGFja3MgdGhlIHVzZXIgYnkgMyBzZWNvbmRzLiBFYXJuZWQgYnkgam9pbmluZyB0aGUgQmx1c2ggQ3J1bmNoIFN0dWRpbyBST0JMT1ggR3JvdXAuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBQEAAAAACW8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIA0wEAAACfAgMCggABAAMDAQMCAwMADwQBGAAAAAABAAAAARAAAAAABgEAAAAALG8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIBAwMAAACfAgMCbwUEALwDAQMDAAAAnwMDAg4CAQArAwIAbwQFAIIEAgBNBALsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBALsBgAAAG8ECwCCBAIATQQD7AYAAACkBQgAAABwQE0FBboJAAAAmgQGAAUAAABvBAoAMAQD7AYAAABvBAwAggQCAG8EBQCCBAIADQMBAwIDBQMGAwcDCAMJAwoEAABwQAMLAwwDDQMOABQPARgAAAAAAQAAAAEAAAABAAAAAwAAAAAAAAABAAABAAMAAAAAAAAAAQAAAQADABUAAAAABAAAAQIAJKMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCuAwAAAG8BBAAwAQDyBQAAAG8BBgAwAQDiBwAAAG8BCAAwAQC/CQAAAIwB+gAwAQAjCgAAAP8BAAACAAAAbwILAIwD+gDFAQIDAQAAADABAJ8MAAAAwAENADABAGsOAAAAwAEPADABAK0QAAAAggACABEDEAMLAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwYAAwQGAQMPAgABAQABGAAAAAIAAAEAAAIAAAIAAAIAAAIAAAEAAAAAAAAAAgAABQAAFAEAAAAAAnR3P5AV96NF8EYCTMvyrMYEbyjkRrNVkQ==

-- https://lua.expert/
return {
	Name = "Blushy Bat",
	Icon = "rbxassetid://17826624660",
	Rarity = "Common",
	Description = "Increases the Attack Cooldown of any Twisted that attacks the user by 3 seconds. Earned by joining the Blush Crunch Studio ROBLOX Group.",
	TrinketType = "Passive",
	Cost = 250,
	Requirement1 = { "Coin", 250 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 15 ]]
		p1:WaitForChild("Trinkets")
		p1:WaitForChild("Stats")
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 20 ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if Trinket1.Value == script.Name then
			Trinket1.Value = "None"

			return "Slot1"
		end

		if Trinket2.Value == script.Name then
			Trinket2.Value = "None"

			return "Slot2"
		end

		return "CantRemove"
	end
}