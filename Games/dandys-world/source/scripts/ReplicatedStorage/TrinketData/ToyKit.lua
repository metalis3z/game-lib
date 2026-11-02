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
-- CQMeC1JpbmdBYmlsaXR5DEdldEF0dHJpYnV0ZQ9BdXJhUmFkaXVzQm9vc3QMU2V0QXR0cmlidXRlDEFwcGx5VHJpbmtldAhUcmlua2V0cwxXYWl0Rm9yQ2hpbGQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQHVG95IEtpdBxyYnhhc3NldGlkOi8vMTAxNDMxNDgyNDg4OTU0BEljb24GQ29tbW9uBlJhcml0eURJZiB5b3VyIFRvb24gaGFzIGEgcmluZy1iYXNlZCBhdXJhIGFiaWxpdHksIGluY3JlYXNlcyByYWRpdXMgYnkgMjUlLgtEZXNjcmlwdGlvbgdQYXNzaXZlC1RyaW5rZXRUeXBlDk1vbnN0ZXJUcmlua2V0BENvc3QMUmVxdWlyZW1lbnQxAAMGAQAAAAAMbwMAALwBABIBAAAAnwEDAisBAQCCAAEAbwQCAG8FAwC8AgAuBAAAAJ8CBAGCAAEABQMBAwIDAwIAAAAAAAD0PwMEAA8FARgAAAAAAQEEAAAAAAERAAAAAAgBAAAAADZvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQLAAUAAABvBAoAMAQC7AYAAABvBgsAxgcAALwEAC4MAAAAnwQEAW8EDQCCBAIATQQD7AYAAACkBQgAAABwQE0FBboJAAAAmgQLAAUAAABvBAoAMAQD7AYAAABvBgsAxgcAALwEAC4MAAAAnwQEAW8EDgCCBAIAbwQFAIIEAgAPAwYDBwMIAwkDCgMLAwwDDQQAAHBAAw4DDwMDAwQDEAMRABoSARgAAAAAAQAAAAEAAAABAAAAAwAAAAAAAAABAAABAAAAAAEAAwAAAAAAAAABAAABAAAAAAEAAwAbAAAAAAQAAAECACejAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEArgMAAABvAQQAMAEA8gUAAABvAQYAMAEA4gcAAABvAQgAMAEAvwkAAACpAQEAMAEA5goAAACMAQAAMAEAIwsAAAD/AQAAAgAAAG8CDACMAwAAxQECAwEAAAAwAQCfDQAAAMABDgAwAQBrDwAAAMABEAAwAQCtEQAAAIIAAgASAxMDDgMUAxUDFgMXAxgDGQMaAxsDHAMdAw8DHgYAAwUGAQMSAgABAQABGAAAAAIAAAEAAAIAAAIAAAIAAAEAAAEAAAEAAAAAAAAAAgAACwAAFgEAAAAAAlNfx0aUt3AGK1wrNfSgNE8jR9AyYZutRw==

-- https://lua.expert/
return {
	Name = "Toy Kit",
	Icon = "rbxassetid://101431482488954",
	Rarity = "Common",
	Description = "If your Toon has a ring-based aura ability, increases radius by 25%.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 0,
	Requirement1 = { "None", 0 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 15 ]]
		if p1:GetAttribute("RingAbility") then
			p1:SetAttribute("AuraRadiusBoost", 1.25)
		end
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 26 ]]
		local Trinkets = p1:WaitForChild("Trinkets")
		local Trinket1 = Trinkets:FindFirstChild("Trinket1")
		local Trinket2 = Trinkets:FindFirstChild("Trinket2")

		if not (Trinket1 and Trinket2) then
			return "CantRemove"
		end

		if Trinket1.Value == script.Name then
			Trinket1.Value = "None"
			p1:SetAttribute("AuraRadiusBoost", nil)

			return "Slot1"
		end

		if Trinket2.Value == script.Name then
			Trinket2.Value = "None"
			p1:SetAttribute("AuraRadiusBoost", nil)

			return "Slot2"
		end

		return "CantRemove"
	end
}