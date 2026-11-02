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
-- CQMmBGdhbWUHUGxheWVycxZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyB01vZHVsZXMaQm9uZU5lZWRsZUFuZFRocmVhZEVmZmVjdHMORmluZEZpcnN0Q2hpbGQFU3RhdHMMV2FpdEZvckNoaWxkCkluRWxldmF0b3IGRXZlbnRzEkNsaWVudEFiaWxpdHlFdmVudApGaXJlQ2xpZW50DEFwcGx5VHJpbmtldAhUcmlua2V0cwhUcmlua2V0MQhUcmlua2V0MgpDYW50UmVtb3ZlBVZhbHVlBnNjcmlwdAROYW1lBE5vbmUFU2xvdDEFU2xvdDINUmVtb3ZlVHJpbmtldBFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlFkJvbmUgTmVlZGxlIGFuZCBUaHJlYWQccmJ4YXNzZXRpZDovLzEyNzI4MzQ2NTgwODMyNwRJY29uBkNvbW1vbgZSYXJpdHlvSGlnaGxpZ2h0cyBQdW1wa2lucyBpbiB5b3VyIHZpY2luaXR5IGV2ZXJ5IDEwIHNlY29uZHMgZHVyaW5nIG1hdGNoZXMsIG1ha2luZyB0aGVtIGVhc2llciB0byBzcG90IGR1cmluZyBldmVudHMuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdAxSZXF1aXJlbWVudDEAAwoBAQAAACakAQEAAAAAQE0BAVACAAAAUgMAALwBAYkDAAAAnwEDAvsCAABNAgLoBAAAAG8EBQC8AgIDBgAAAJ8CAwIOAQEAKwIBAIIAAQBvBQcAvAMA0wgAAACfAwMCbwYJALwEA9MIAAAAnwQDAvsFAABNBQVaCgAAAE0FBaELAAAAUgcBAFIIAgBSCQAAvAUFCAwAAACfBQUBggABAA0DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAARDQEYAAAAAAAAAAABAAAAAAAAAQAAAgAAAAEAAAADAAAAAAAAAAAAAAESAAAAAAYBAAAAACxvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQGAAUAAABvBAoAMAQC7AYAAABvBAsAggQCAE0EA+wGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEA+wGAAAAbwQMAIIEAgBvBAUAggQCAA0DDgMIAw8DBgMQAxEDEgMTBAAAcEADFAMVAxYDFwAdGAEYAAAAAAEAAAABAAAAAQAAAAIAAAAAAAAAAQAAAQADAAAAAAAAAAEAAAEAAwAeAAAAAAUAAAECAC6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEFAAAAAABvAgQAMAIBugUAAABvAgYAMAIBrgcAAABvAggAMAIB8gkAAABvAgoAMAIB4gsAAABvAgwAMAIBvw0AAACpAgEAMAIB5g4AAACMAgAAMAIBIw8AAAD/AgAAAgAAAG8DEACMBAAAxQIDAwEAAAAwAgGfEQAAAMACEgASAAAAMAIBaxMAAADAAhQAMAIBrRUAAACCAQIAFgMBBAAAAEADGQMaAxsDFAMcAx0DHgMfAyADIQMiAyMDJAMlAxUDJgYAAw0GAQMYAgABAQABGAAAAAAAAAABAAIAAAEAAAIAAAIAAAEAAAIAAAIAAAEAAAAAAAAAAgAAAAwAABMBAAAAAAICai9skBTIlR35iqlDmAHlcnI4GDCuRW0=

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "Bone Needle and Thread",
	Icon = "rbxassetid://127283465808327",
	Rarity = "Common",
	Description = "Highlights Pumpkins in your vicinity every 10 seconds during matches, making them easier to spot during events.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 0,
	Requirement1 = { "None", 0 },
	ApplyTrinket = function(p1) --[[ ApplyTrinket | Line: 17 | Upvalues: ReplicatedStorage (copy) ]]
		local v1 = game.Players:GetPlayerFromCharacter(p1)
		local BoneNeedleAndThreadEffects = ReplicatedStorage.Modules:FindFirstChild("BoneNeedleAndThreadEffects")

		if v1 and BoneNeedleAndThreadEffects then
			p1:WaitForChild("Stats"):WaitForChild("InElevator")
			ReplicatedStorage.Events.ClientAbilityEvent:FireClient(v1, BoneNeedleAndThreadEffects, p1)
		end
	end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 29 ]]
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