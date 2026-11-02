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
-- CQMnDUFwcGx5TW9kaWZpZXIQUnVuU3BlZWRNb2RpZmllcgdQaW5rQm93CGNhdGVnb3J5B3RyaW5rZXQMQXBwbHlUcmlua2V0CFRyaW5rZXRzDFdhaXRGb3JDaGlsZAhUcmlua2V0MQ5GaW5kRmlyc3RDaGlsZAhUcmlua2V0MgpDYW50UmVtb3ZlDlJlbW92ZU1vZGlmaWVyBVZhbHVlBnNjcmlwdAROYW1lBE5vbmUFU2xvdDEFU2xvdDINUmVtb3ZlVHJpbmtldAdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UHTW9kdWxlcwREYXRhE1N0YXRNb2RpZmllck1hbmFnZXIIUGluayBCb3cYcmJ4YXNzZXRpZDovLzE3NjUxODQ4NDYzBEljb24GQ29tbW9uBlJhcml0eRxJbmNyZWFzZXMgUnVuIFNwZWVkIGJ5IDcuNSUuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBwECAAAADPsBAABNAQGjAAAAAFICAABvAwEAbwQCAG8FAwDiBgYAnwEGAvsCAQBqAQIAggABAAcDAQMCAjMzMzMzM/E/AwMDBAMFCAEEBQAAAAAUBgEYAAAAAAAAAAAAAwABFQAAAAAJAQIAAAA6bwMAALwBANMBAAAAnwEDAm8EAgC8AgEDAwAAAJ8CAwJvBQQAvAMBAwMAAACfAwMCDgIBACsDAgBvBAUAggQCAPsFAACHBAUADgQLAPsEAQBNBASWBgAAAFIFAABvBgcA+wgAAIcHCACfBAQB+wQAAMYFAABqBQQATQQC7AgAAACkBQoAAACQQE0FBboLAAAAmgQGAAUAAABvBAwAMAQC7AgAAABvBA0AggQCAE0EA+wIAAAApAUKAAAAkEBNBQW6CwAAAJoEBgAFAAAAbwQMADAEA+wIAAAAbwQOAIIEAgBvBAUAggQCAA8DBwMIAwkDCgMLAwwDDQMCAw4DDwQAAJBAAxADEQMSAxMAGxQBGAAAAAACAAAAAQAAAAEAAAACAAABAAAAAAAAAAEAAAMAAAAAAAAAAQAAAQADAAAAAAAAAAEAAAEAAwAcAAAAAAYAAAECADqjAAAApAABAAAAAECkAQMAAAAgQE0BAT8EAAAATQEB6AUAAABNAQHGBgAAAE0BAeEHAAAAnwACAv8BAAAAAAAA/wIFAAAAAABvAwgAMAMCugkAAABvAwoAMAMCrgsAAABvAwwAMAMC8g0AAABvAw4AMAMC4g8AAABvAxAAMAMCvxEAAACpAwEAMAMC5hIAAACMA0UBMAMCIxMAAAD/AwAAAgAAAG8EFACMBUUBxQMEAwEAAAAwAwKfFQAAAMADFgASAAAAEgABADADAmsXAAAAwAMYABIAAQASAAAAMAMCrRkAAACCAgIAGgMVBAAAAEADFgQAACBAAxcDGAMZAxoDGwMQAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnBgADBgYBAxQCAAEBAAEYAAAAAAAAAAAAAAAAAAABAAIAAgAAAQAAAgAAAgAAAgAAAgAAAgAAAQAAAAAAAAACAAAAAAcAAAAAGQEAAAAAAm8FiUgJ7tcgPFrtDWtKpHMfHZ48XcHjSQ==

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}

return {
	Name = "Pink Bow",
	Icon = "rbxassetid://17651848463",
	Rarity = "Common",
	Description = "Increases Run Speed by 7.5%.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 325,
	Requirement1 = { "Coin", 325 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 20 | Upvalues: StatModifierManager (copy), t (copy) ]]
		t[p1] = StatModifierManager.ApplyModifier(p1, "RunSpeedModifier", 1.075, "PinkBow", {
			category = "trinket"
		})
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 27 | Upvalues: t (copy), StatModifierManager (copy) ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if t[p1] then
			StatModifierManager.RemoveModifier(p1, "RunSpeedModifier", t[p1])
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