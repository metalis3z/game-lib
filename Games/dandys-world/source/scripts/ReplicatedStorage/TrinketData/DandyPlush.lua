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
-- CQMhCFRyaW5rZXRzDFdhaXRGb3JDaGlsZAVTdGF0cwlXYWxrU3BlZWQIUnVuU3BlZWQNU3BlZWRNb2RpZmllcghIdW1hbm9pZAlTcHJpbnRpbmcMQXBwbHlUcmlua2V0CFRyaW5rZXQxDkZpbmRGaXJzdENoaWxkCFRyaW5rZXQyCkNhbnRSZW1vdmUFVmFsdWUGc2NyaXB0BE5hbWUETm9uZQVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0C0RhbmR5IFBsdXNoGHJieGFzc2V0aWQ6Ly8xNzY1MzgxMDQ5MQRJY29uBkNvbW1vbgZSYXJpdHk5R3JhbnRzIHRoZSB1c2VyIGEgNTAlIGRpc2NvdW50IG9uIGFsbCBEYW5keSdzIFNob3AgaXRlbXMuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdARDb2luDFJlcXVpcmVtZW50MQADCgEAAAAAHW8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIA0wEAAACfAgMCbwUDALwDAtMBAAAAnwMDAm8GBAC8BALTAQAAAJ8EAwJvBwUAvAUC0wEAAACfBQMCbwgGALwGANMBAAAAnwYDAm8JBwC8BwLTAQAAAJ8HAwKCAAEACAMBAwIDAwMEAwUDBgMHAwgAEQkBGAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABEgAAAAAGAQAAAAAsbwMAALwBANMBAAAAnwEDAm8EAgC8AgEDAwAAAJ8CAwJvBQQAvAMBAwMAAACfAwMCDgIBACsDAgBvBAUAggQCAE0EAuwGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEAuwGAAAAbwQLAIIEAgBNBAPsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBAPsBgAAAG8EDACCBAIAbwQFAIIEAgANAwEDAgMKAwsDDAMNAw4DDwQAAHBAAxADEQMSAxMAGxQBGAAAAAABAAAAAQAAAAEAAAADAAAAAAAAAAEAAAEAAwAAAAAAAAABAAABAAMAHAAAAAAEAAABAgAoowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAK4DAAAAbwEEADABAPIFAAAAbwEGADABAOIHAAAAbwEIADABAL8JAAAAqQEBADABAOYKAAAAjAFeATABACMLAAAA/wEAAAIAAABvAgwATQMAIwsAAADFAQIDAQAAADABAJ8NAAAAwAEOADABAGsPAAAAwAEQADABAK0RAAAAggACABIDFQMQAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhBgADCQYBAxQCAAEBAAEYAAAAAgAAAQAAAgAAAgAAAgAAAgAAAgAAAQAAAAAAAAAAAgAACgAAFAEAAAAAAtAq6e1pE+tNSdy5NenObK2gMv6Z4u6D7A==

-- https://lua.expert/
local t = {
	Name = "Dandy Plush",
	Icon = "rbxassetid://17653810491",
	Rarity = "Common",
	Description = "Grants the user a 50% discount on all Dandy\'s Shop items.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 350
}

t.Requirement1 = { "Coin", t.Cost }
function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 17 ]]
	p1:WaitForChild("Trinkets")

	local Stats = p1:WaitForChild("Stats")

	Stats:WaitForChild("WalkSpeed")
	Stats:WaitForChild("RunSpeed")
	Stats:WaitForChild("SpeedModifier")
	p1:WaitForChild("Humanoid")
	Stats:WaitForChild("Sprinting")
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 27 ]]
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

return t