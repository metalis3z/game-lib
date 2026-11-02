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
-- CQMlBGdhbWUHUGxheWVycxZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyBkV2ZW50cxJDbGllbnRBYmlsaXR5RXZlbnQKRmlyZUNsaWVudAxBcHBseVRyaW5rZXQIVHJpbmtldHMMV2FpdEZvckNoaWxkCFRyaW5rZXQxDkZpbmRGaXJzdENoaWxkCFRyaW5rZXQyCkNhbnRSZW1vdmUFVmFsdWUGc2NyaXB0BE5hbWUETm9uZQVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0EVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2USTW9vbiBQYWNrIEhlaXJsb29tHHJieGFzc2V0aWQ6Ly8xMDUxMzIxMTAyMDA3MDYESWNvbgZDb21tb24GUmFyaXR5aEhpZ2hsaWdodHMgYWxsIG90aGVyIHRlYW1tYXRlcycgbG9jYXRpb25zIGZvciAzIHNlY29uZHMgZm9yIHRoZSB1c2VyIGFmdGVyIGFueSB1c2VyIGNvbXBsZXRlcyBhIG1hY2hpbmUuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdAxSZXF1aXJlbWVudDEHTW9kdWxlcwVab25lcxdNb29uUGFja0hlaXJsb29tRWZmZWN0cwADBwECAAAAFqQBAQAAAABATQEBUAIAAABSAwAAvAEBiQMAAACfAQMCKwEBAIIAAQD7AgAATQICWgQAAABNAgKhBQAAAFIEAQD7BQEAUgYAALwCAggGAAAAnwIFAYIAAQAHAwEEAAAAQAMCAwMDBAMFAwYAEwcBGAAAAAAAAAAAAQACAAAAAAAAAAAAAAEUAAAAAAYBAAAAACxvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIATQQC7AYAAACkBQgAAABwQE0FBboJAAAAmgQGAAUAAABvBAoAMAQC7AYAAABvBAsAggQCAE0EA+wGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEA+wGAAAAbwQMAIIEAgBvBAUAggQCAA0DCAMJAwoDCwMMAw0DDgMPBAAAcEADEAMRAxIDEwAaFAEYAAAAAAEAAAABAAAAAQAAAAIAAAAAAAAAAQAAAQADAAAAAAAAAAEAAAEAAwAbAAAAAAUAAAECADWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEFAAAAAABvAgQAMAIBugUAAABvAgYAMAIBrgcAAABvAggAMAIB8gkAAABvAgoAMAIB4gsAAABvAgwAMAIBvw0AAACpAgEAMAIB5g4AAACMAgAAMAIBIw8AAAD/AgAAAgAAAG8DEACMBAAAxQIDAwEAAAAwAgGfEQAAAE0CAOgSAAAATQICUBMAAABNAgLDFAAAAMADFQASAAAAEgACADADAWsWAAAAwAMXADADAa0YAAAAggECABkDAQQAAABAAxUDFgMXAxADGAMZAxoDGwMcAx0DHgMfAyADIQMRAyIDIwMkAyUGAAMHBgEDFAIAAQEAARgAAAAAAAAAAQACAAABAAACAAACAAABAAACAAACAAABAAAAAAAAAAIAAAAAAAIAAAAABwAAEwEAAAAAAiuogNNjrwiKVH1WgS3Hay1bsJenGWzq0g==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	Name = "Moon Pack Heirloom",
	Icon = "rbxassetid://105132110200706",
	Rarity = "Common",
	Description = "Highlights all other teammates\' locations for 3 seconds for the user after any user completes a machine.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 0,
	Requirement1 = { "None", 0 }
}
local MoonPackHeirloomEffects = ReplicatedStorage.Modules.Zones.MoonPackHeirloomEffects

function t.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 19 | Upvalues: ReplicatedStorage (copy), MoonPackHeirloomEffects (copy) ]]
	local v1 = game.Players:GetPlayerFromCharacter(p1)

	if v1 then
		ReplicatedStorage.Events.ClientAbilityEvent:FireClient(v1, MoonPackHeirloomEffects, p1)
	end
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 26 ]]
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