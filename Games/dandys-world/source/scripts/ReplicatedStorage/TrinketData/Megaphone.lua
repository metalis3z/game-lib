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
-- 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

-- https://lua.expert/
return {
	Name = "Megaphone",
	Icon = "rbxassetid://88197656841954",
	Rarity = "Common",
	Description = "Grants the \'Air Horn\' Item every other Floor (If user\'s Inventory has a slot open).",
	TrinketType = "Passive",
	Cost = 250,
	Requirement1 = { "Coin", 250 },
	ApplyTrinket = function(p1, p2) --[[ ApplyTrinket | Line: 15 ]]
		p1:WaitForChild("Trinkets")
		p1:WaitForChild("Stats"):WaitForChild("StaminaRegenModifier")
		workspace.Info.Floor.Changed:Connect(function() --[[ Line: 22 | Upvalues: p1 (copy), p2 (copy) ]]
			if workspace.Info.Floor.Value % 2 == 0 then
				return
			end

			local Inventory = p1:WaitForChild("Inventory")
			local Slot1 = Inventory:WaitForChild("Slot1")
			local Slot2 = Inventory:WaitForChild("Slot2")
			local Slot3 = Inventory:WaitForChild("Slot3")
			local Slot4 = Inventory:FindFirstChild("Slot4")
			local v1 = false

			if p2.Name == "Trinket2" then
				task.wait()
			end

			if Slot1.Value == "None" and not v1 then
				Slot1.Value = "AirHorn"
				v1 = true
			end

			if Slot2.Value == "None" and not v1 then
				Slot2.Value = "AirHorn"
				v1 = true
			end

			if Slot3.Value == "None" and not v1 then
				Slot3.Value = "AirHorn"
				v1 = true
			end

			if not Slot4 or (Slot4.Value ~= "None" or v1) then
				return
			end

			Slot4.Value = "AirHorn"
		end)
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 57 ]]
		local Trinkets = p1:WaitForChild("Trinkets")

		p1:WaitForChild("Stats"):WaitForChild("DecodeSpeed")

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