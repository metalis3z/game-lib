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
-- CQMmDUFwcGx5TW9kaWZpZXITRGVjb2RlU3BlZWRNb2RpZmllcg1NYWNoaW5lTWFudWFsCGNhdGVnb3J5B3RyaW5rZXQMQXBwbHlUcmlua2V0CFRyaW5rZXRzDFdhaXRGb3JDaGlsZAhUcmlua2V0MQ5GaW5kRmlyc3RDaGlsZAhUcmlua2V0MgpDYW50UmVtb3ZlDlJlbW92ZU1vZGlmaWVyBVZhbHVlBnNjcmlwdAROYW1lBE5vbmUFU2xvdDEFU2xvdDINUmVtb3ZlVHJpbmtldAdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UHTW9kdWxlcwREYXRhE1N0YXRNb2RpZmllck1hbmFnZXIOTWFjaGluZSBNYW51YWwYcmJ4YXNzZXRpZDovLzE3NjYwMDMwMjkzBEljb24GQ29tbW9uBlJhcml0eSZJbmNyZWFzZXMgeW91ciBFeHRyYWN0aW9uIFNwZWVkIGJ5IDUlLgtEZXNjcmlwdGlvbgdQYXNzaXZlC1RyaW5rZXRUeXBlBENvc3QEQ29pbgxSZXF1aXJlbWVudDEAAwcBAgAAAAz7AQAATQEBowAAAABSAgAAbwMBAG8EAgBvBQMA4gYGAJ8BBgL7AgEAagECAIIAAQAHAwEDAgLNzMzMzMzwPwMDAwQDBQgBBAUAAAAAEgYBGAAAAAAAAAAAAAMAARMAAAAACQECAAAAOm8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIBAwMAAACfAgMCbwUEALwDAQMDAAAAnwMDAg4CAQArAwIAbwQFAIIEAgD7BQAAhwQFAA4ECwD7BAEATQQElgYAAABSBQAAbwYHAPsIAACHBwgAnwQEAfsEAADGBQAAagUEAE0EAuwIAAAApAUKAAAAkEBNBQW6CwAAAJoEBgAFAAAAbwQMADAEAuwIAAAAbwQNAIIEAgBNBAPsCAAAAKQFCgAAAJBATQUFugsAAACaBAYABQAAAG8EDAAwBAPsCAAAAG8EDgCCBAIAbwQFAIIEAgAPAwcDCAMJAwoDCwMMAw0DAgMOAw8EAACQQAMQAxEDEgMTABkUARgAAAAAAgAAAAEAAAABAAAAAgAAAQAAAAAAAAABAAADAAAAAAAAAAEAAAEAAwAAAAAAAAABAAABAAMAGgAAAAAGAAABAgA3owAAAKQAAQAAAABApAEDAAAAIEBNAQE/BAAAAE0BAegFAAAATQEBxgYAAABNAQHhBwAAAJ8AAgL/AQAAAAAAAP8CBQAAAAAAbwMIADADAroJAAAAbwMKADADAq4LAAAAbwMMADADAvINAAAAbwMOADADAuIPAAAAbwMQADADAr8RAAAAjAP6ADADAiMSAAAA/wMAAAIAAABvBBMAjAX6AMUDBAMBAAAAMAMCnxQAAADAAxUAEgAAABIAAQAwAwJrFgAAAMADFwASAAEAEgAAADADAq0YAAAAggICABkDFQQAAABAAxYEAAAgQAMXAxgDGQMaAxsDEAMcAx0DHgMfAyADIQMiAyMDJAMlAyYGAAMGBgEDFAIAAQEAARgAAAAAAAAAAAAAAAAAAAEAAgACAAABAAACAAACAAACAAACAAABAAAAAAAAAAIAAAAABwAAAAAZAQAAAAACk6mqGDF01NFo+nzcwXhiFeOxvWyhbcAZ

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}

return {
	Name = "Machine Manual",
	Icon = "rbxassetid://17660030293",
	Rarity = "Common",
	Description = "Increases your Extraction Speed by 5%.",
	TrinketType = "Passive",
	Cost = 250,
	Requirement1 = { "Coin", 250 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 18 | Upvalues: StatModifierManager (copy), t (copy) ]]
		t[p1] = StatModifierManager.ApplyModifier(p1, "DecodeSpeedModifier", 1.05, "MachineManual", {
			category = "trinket"
		})
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 25 | Upvalues: t (copy), StatModifierManager (copy) ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if t[p1] then
			StatModifierManager.RemoveModifier(p1, "DecodeSpeedModifier", t[p1])
			t[p1] = nil
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