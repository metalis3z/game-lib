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
-- CQMlE0FwcGx5U3BlZWRNb2RpZmllcnMLU3BlZWR5U2hvZXMIY2F0ZWdvcnkHdHJpbmtldAxBcHBseVRyaW5rZXQIVHJpbmtldHMMV2FpdEZvckNoaWxkCFRyaW5rZXQxDkZpbmRGaXJzdENoaWxkCFRyaW5rZXQyCkNhbnRSZW1vdmUFVmFsdWUGc2NyaXB0BE5hbWUETm9uZRRSZW1vdmVTcGVlZE1vZGlmaWVycwVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQdNb2R1bGVzBERhdGETU3RhdE1vZGlmaWVyTWFuYWdlcgxTcGVlZHkgU2hvZXMYcmJ4YXNzZXRpZDovLzE3NjYwMDcxNDE4BEljb24GQ29tbW9uBlJhcml0eShJbmNyZWFzZXMgYm90aCBXYWxrIGFuZCBSdW4gU3BlZWQgYnkgNSUuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBwECAAAAC/sBAAD7AgEATQICKwAAAABSAwAAbwQBAG8FAgDiBgUAnwIFAmoCAQCCAAEABgMBAs3MzMzMzPA/AwIDAwMECAEDBAAAAAASBQEYAAAAAAAAAAAAAAEUAAAAAAgBAgAAAEZvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQTAAUAAABvBAoAMAQC7AYAAAD7BQAAhwQFAA4ECgD7BAEATQQEgAsAAABSBQAA+wcAAIcGBwCfBAMB+wQAAMYFAABqBQQAbwQMAIIEAgBNBAPsBgAAAKQFCAAAAHBATQUFugkAAACaBBMABQAAAG8ECgAwBAPsBgAAAPsFAACHBAUADgQKAPsEAQBNBASACwAAAFIFAAD7BwAAhwYHAJ8EAwH7BAAAxgUAAGoFBABvBA0AggQCAG8EBQCCBAIADgMGAwcDCAMJAwoDCwMMAw0EAABwQAMOAw8DEAMRAxIAFxMBGAAAAAACAAAAAQAAAAEAAAACAAAAAAAAAAEAAAIAAAEAAAAAAAABAAACAAMAAAAAAAAAAQAAAgAAAQAAAAAAAAEAAAIAAwAYAAAAAAYAAAECADejAAAApAABAAAAAECkAQMAAAAgQE0BAT8EAAAATQEB6AUAAABNAQHGBgAAAE0BAeEHAAAAnwACAv8BAAAAAAAA/wIFAAAAAABvAwgAMAMCugkAAABvAwoAMAMCrgsAAABvAwwAMAMC8g0AAABvAw4AMAMC4g8AAABvAxAAMAMCvxEAAACMA0UBMAMCIxIAAAD/AwAAAgAAAG8EEwCMBUUBxQMEAwEAAAAwAwKfFAAAAMADFQASAAEAEgAAADADAmsWAAAAwAMXABIAAQASAAAAMAMCrRgAAACCAgIAGQMUBAAAAEADFQQAACBAAxYDFwMYAxkDGgMOAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQYAAwUGAQMTAgABAQABGAAAAAAAAAAAAAAAAAAAAQACAAIAAAEAAAIAAAIAAAIAAAIAAAEAAAAAAAAAAgAAAAAFAAAAAB4BAAAAAALQw2KHK+wexe9Cmwxsmoa2oNt18+IHCIY=

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}

return {
	Name = "Speedy Shoes",
	Icon = "rbxassetid://17660071418",
	Rarity = "Common",
	Description = "Increases both Walk and Run Speed by 5%.",
	TrinketType = "Passive",
	Cost = 325,
	Requirement1 = { "Coin", 325 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 18 | Upvalues: t (copy), StatModifierManager (copy) ]]
		t[p1] = StatModifierManager.ApplySpeedModifiers(p1, 1.05, "SpeedyShoes", {
			category = "trinket"
		})
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 23 | Upvalues: t (copy), StatModifierManager (copy) ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if Trinket1.Value == script.Name then
			Trinket1.Value = "None"

			if not t[p1] then
				return "Slot1"
			end

			StatModifierManager.RemoveSpeedModifiers(p1, t[p1])
			t[p1] = nil

			return "Slot1"
		end

		if Trinket2.Value ~= script.Name then
			return "CantRemove"
		end

		Trinket2.Value = "None"

		if not t[p1] then
			return "Slot2"
		end

		StatModifierManager.RemoveSpeedModifiers(p1, t[p1])
		t[p1] = nil

		return "Slot2"
	end
}