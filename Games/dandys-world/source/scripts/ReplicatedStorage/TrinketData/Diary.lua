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
-- CQMmDUFwcGx5TW9kaWZpZXIPU3RlYWx0aE1vZGlmaWVyBURpYXJ5CGNhdGVnb3J5B3RyaW5rZXQMQXBwbHlUcmlua2V0CFRyaW5rZXRzDFdhaXRGb3JDaGlsZAhUcmlua2V0MQ5GaW5kRmlyc3RDaGlsZAhUcmlua2V0MgpDYW50UmVtb3ZlDlJlbW92ZU1vZGlmaWVyBVZhbHVlBnNjcmlwdAROYW1lBE5vbmUFU2xvdDEFU2xvdDINUmVtb3ZlVHJpbmtldAdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UHTW9kdWxlcwREYXRhE1N0YXRNb2RpZmllck1hbmFnZXIYcmJ4YXNzZXRpZDovLzE4MjUwNjg0Mzk4BEljb24GQ29tbW9uBlJhcml0eRlJbmNyZWFzZXMgU3RlYWx0aCBieSAyNSUuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBwECAAAADPsBAABNAQGjAAAAAFICAABvAwEAbwQCAG8FAwDiBgYAnwEGAvsCAQBqAQIAggABAAcDAQMCAgAAAAAAAPQ/AwMDBAMFCAEEBQAAAAAUBgEYAAAAAAAAAAAAAwABFQAAAAAJAQIAAAA6bwMAALwBANMBAAAAnwEDAm8EAgC8AgEDAwAAAJ8CAwJvBQQAvAMBAwMAAACfAwMCDgIBACsDAgBvBAUAggQCAPsFAACHBAUADgQLAPsEAQBNBASWBgAAAFIFAABvBgcA+wgAAIcHCACfBAQB+wQAAMYFAABqBQQATQQC7AgAAACkBQoAAACQQE0FBboLAAAAmgQGAAUAAABvBAwAMAQC7AgAAABvBA0AggQCAE0EA+wIAAAApAUKAAAAkEBNBQW6CwAAAJoEBgAFAAAAbwQMADAEA+wIAAAAbwQOAIIEAgBvBAUAggQCAA8DBwMIAwkDCgMLAwwDDQMCAw4DDwQAAJBAAxADEQMSAxMAGxQBGAAAAAACAAAAAQAAAAEAAAACAAABAAAAAAAAAAEAAAMAAAAAAAAAAQAAAQADAAAAAAAAAAEAAAEAAwAcAAAAAAYAAAECADujAAAApAABAAAAAECkAQMAAAAgQE0BAT8EAAAATQEB6AUAAABNAQHGBgAAAE0BAeEHAAAAnwACAv8BAAAAAAAA/wIFAAAAAABvAwgAMAMCugkAAABvAwoAMAMCrgsAAABvAwwAMAMC8g0AAABvAw4AMAMC4g8AAABvAxAAMAMCvxEAAACpAwEAMAMC5hIAAACMA14BMAMCIxMAAAD/AwAAAgAAAG8EFABNBQIjEwAAAMUDBAMBAAAAMAMCnxUAAADAAxYAEgAAABIAAQAwAwJrFwAAAMADGAASAAEAEgAAADADAq0ZAAAAggICABoDFQQAAABAAxYEAAAgQAMXAxgDGQMaAwMDEAMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgYAAwYGAQMUAgABAQABGAAAAAAAAAAAAAAAAAAAAQACAAIAAAEAAAIAAAIAAAIAAAIAAAIAAAEAAAAAAAAAAAIAAAAABwAAAAAZAQAAAAACqXj9R6nNuwmQLSl49kqJJdlg6jObvJdG

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}
local t2 = {
	Name = "Diary",
	Icon = "rbxassetid://18250684398",
	Rarity = "Common",
	Description = "Increases Stealth by 25%.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 350
}

t2.Requirement1 = { "Coin", t2.Cost }
function t2.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 20 | Upvalues: StatModifierManager (copy), t (copy) ]]
	t[p1] = StatModifierManager.ApplyModifier(p1, "StealthModifier", 1.25, "Diary", {
		category = "trinket"
	})
end
function t2.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 27 | Upvalues: t (copy), StatModifierManager (copy) ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	if t[p1] then
		StatModifierManager.RemoveModifier(p1, "StealthModifier", t[p1])
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

return t2