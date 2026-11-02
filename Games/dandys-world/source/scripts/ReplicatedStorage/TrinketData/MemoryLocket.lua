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
-- CQMlBGdhbWUHUGxheWVycxZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyBkV2ZW50cxJDbGllbnRBYmlsaXR5RXZlbnQKRmlyZUNsaWVudAxBcHBseVRyaW5rZXQIVHJpbmtldHMMV2FpdEZvckNoaWxkCFRyaW5rZXQxDkZpbmRGaXJzdENoaWxkCFRyaW5rZXQyCkNhbnRSZW1vdmUFVmFsdWUGc2NyaXB0BE5hbWUETm9uZQVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0EVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNTWVtb3J5IExvY2tldBtyYnhhc3NldGlkOi8vOTA1ODcxOTEzNzcxNTQESWNvbgZDb21tb24GUmFyaXR5eElmIHVzZXIgaXMgbm90IGF0IGZ1bGwgaGVhbHRoLCBoaWdobGlnaHRzIGFsbCBoZWFsaW5nIGl0ZW1zIGN1cnJlbnRseSBvbiB0aGUgRmxvb3IgdG8gdGhlIHVzZXIgdW50aWwgdGhlIHVzZXIgaXMgaGVhbGVkLgtEZXNjcmlwdGlvbgZUb2dnbGULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdAxSZXF1aXJlbWVudDEHTW9kdWxlcwVab25lcxNNZW1vcnlMb2NrZXRFZmZlY3RzAAMJAgIAAAAXpAIBAAAAAEBNAgJQAgAAAFIEAAC8AgKJAwAAAJ8CAwIrAgEAggABAPsDAABNAwNaBAAAAE0DA6EFAAAAUgUCAPsGAQBSBwAAUggBALwDAwgGAAAAnwMGAYIAAQAHAwEEAAAAQAMCAwMDBAMFAwYAFAcBGAAAAAAAAAAAAQACAAAAAAAAAAAAAAABFQAAAAAGAQAAAAAsbwMAALwBANMBAAAAnwEDAm8EAgC8AgEDAwAAAJ8CAwJvBQQAvAMBAwMAAACfAwMCDgIBACsDAgBvBAUAggQCAE0EAuwGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEAuwGAAAAbwQLAIIEAgBNBAPsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBAPsBgAAAG8EDACCBAIAbwQFAIIEAgANAwgDCQMKAwsDDAMNAw4DDwQAAHBAAxADEQMSAxMAGxQBGAAAAAABAAAAAQAAAAEAAAACAAAAAAAAAAEAAAEAAwAAAAAAAAABAAABAAMAHAAAAAAFAAABAgA1owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BBQAAAAAAbwIEADACAboFAAAAbwIGADACAa4HAAAAbwIIADACAfIJAAAAbwIKADACAeILAAAAbwIMADACAb8NAAAAqQIBADACAeYOAAAAjAIAADACASMPAAAA/wIAAAIAAABvAxAAjAQAAMUCAwMBAAAAMAIBnxEAAABNAgDoEgAAAE0CAlATAAAATQICqhQAAADAAxUAEgAAABIAAgAwAwFrFgAAAMADFwAwAwGtGAAAAIIBAgAZAwEEAAAAQAMVAxYDFwMQAxgDGQMaAxsDHAMdAx4DHwMgAyEDEQMiAyMDJAMlBgADBwYBAxQCAAEBAAEYAAAAAAAAAAEAAgAAAQAAAgAAAgAAAgAAAgAAAgAAAQAAAAAAAAACAAAAAAACAAAAAAcAABMBAAAAAAL4lt9uKWNf90cIZcr1eAxZiI7IGspStW8=

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	Name = "Memory Locket",
	Icon = "rbxassetid://90587191377154",
	Rarity = "Common",
	Description = "If user is not at full health, highlights all healing items currently on the Floor to the user until the user is healed.",
	TrinketType = "Toggle",
	MonsterTrinket = true,
	Cost = 0,
	Requirement1 = { "None", 0 }
}
local MemoryLocketEffects = ReplicatedStorage.Modules.Zones.MemoryLocketEffects

function t.ApplyTrinket(p1, p2) --[[ ApplyTrinket | Line: 20 | Upvalues: ReplicatedStorage (copy), MemoryLocketEffects (copy) ]]
	local v1 = game.Players:GetPlayerFromCharacter(p1)

	if v1 then
		ReplicatedStorage.Events.ClientAbilityEvent:FireClient(v1, MemoryLocketEffects, p1, p2)
	end
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