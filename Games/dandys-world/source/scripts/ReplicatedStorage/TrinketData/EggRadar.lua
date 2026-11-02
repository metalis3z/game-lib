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
-- CQMqBGdhbWUHUGxheWVycxZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyBVN0YXRzDFdhaXRGb3JDaGlsZApJbkVsZXZhdG9yBkV2ZW50cxJDbGllbnRBYmlsaXR5RXZlbnQKRmlyZUNsaWVudAxBcHBseVRyaW5rZXQIVHJpbmtldHMIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQRUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZRFDb2xsZWN0aW9uU2VydmljZQxUd2VlblNlcnZpY2UGRGVicmlzB01vZHVsZXMFWm9uZXMPRWdnUmFkYXJFZmZlY3RzCUVnZyBSYWRhchtyYnhhc3NldGlkOi8vODIzMzk0NjczNTA1MDEESWNvbgZDb21tb24GUmFyaXR5bkhpZ2hsaWdodHMgQmFza2V0cyBpbiB5b3VyIHZpY2luaXR5IGV2ZXJ5IDE1IHNlY29uZHMgZHVyaW5nIG1hdGNoZXMsIG1ha2luZyB0aGVtIGVhc2llciB0byBzcG90IGR1cmluZyBldmVudHMuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOSG9saWRheVRyaW5rZXQEQ29zdAxSZXF1aXJlbWVudDEAAwoCAgAAAB6kAgEAAAAAQE0CAlACAAAAUgQAALwCAokDAAAAnwIDAisCAQCCAAEAbwUEALwDANMFAAAAnwMDAm8GBgC8BAPTBQAAAJ8EAwL7BQAATQUFWgcAAABNBQWhCAAAAFIHAgD7CAEAUgkAALwFBQgJAAAAnwUFAYIAAQAKAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkAFgoBGAAAAAAAAAAAAQACAAAAAQAAAAMAAAAAAAAAAAAAARcAAAAABgEAAAAALG8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIBAwMAAACfAgMCbwUEALwDAQMDAAAAnwMDAg4CAQArAwIAbwQFAIIEAgBNBALsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBALsBgAAAG8ECwCCBAIATQQD7AYAAACkBQgAAABwQE0FBboJAAAAmgQGAAUAAABvBAoAMAQD7AYAAABvBAwAggQCAG8EBQCCBAIADQMLAwUDDAMNAw4DDwMQAxEEAABwQAMSAxMDFAMVACEWARgAAAAAAQAAAAEAAAABAAAAAgAAAAAAAAABAAABAAMAAAAAAAAAAQAAAQADACIAAAAACQAAAQIAR6MAAAD/AAUAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDAQAAAABAbwUFALwDAxYDAAAAnwMDAqQEAQAAAABAbwYGALwEBBYDAAAAnwQDAk0FAegHAAAATQUFUAgAAABNBQWXCQAAAG8GCgAwBgC6CwAAAG8GDAAwBgCuDQAAAG8GDgAwBgDyDwAAAG8GEAAwBgDiEQAAAG8GEgAwBgC/EwAAAKkGAQAwBgBvFAAAAIwGAAAwBgAjFQAAAP8GAAACAAAAbwcWAIwIAADFBgcDAQAAADAGAJ8XAAAAwAYYABIAAQASAAUAMAYAaxkAAADABhoAMAYArRsAAACCAAIAHAMBBAAAAEADFwMYAxkDGgMbAxwDHQMeAx8DEgMgAyEDIgMjAyQDJQMmAycDKAMpAxMDKgYAAwoGAQMWAgABAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAAAAAIAAAEAAAIAAAIAAAIAAAEAAAEAAAEAAAAAAAAAAgAAAAALAAATAQAAAAACZxYBVTdleLYLRWUYHxybIBcOFiFV0mtU

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("CollectionService")
game:GetService("TweenService")
game:GetService("Debris")

local EggRadarEffects = ReplicatedStorage.Modules.Zones.EggRadarEffects

t.Name = "Egg Radar"
t.Icon = "rbxassetid://82339467350501"
t.Rarity = "Common"
t.Description = "Highlights Baskets in your vicinity every 15 seconds during matches, making them easier to spot during events."
t.TrinketType = "Passive"
t.HolidayTrinket = true
t.Cost = 0
t.Requirement1 = { "None", 0 }
function t.ApplyTrinket(p1, p2) --[[ ApplyTrinket | Line: 22 | Upvalues: ReplicatedStorage (copy), EggRadarEffects (copy) ]]
	local v1 = game.Players:GetPlayerFromCharacter(p1)

	if v1 then
		p1:WaitForChild("Stats"):WaitForChild("InElevator")
		ReplicatedStorage.Events.ClientAbilityEvent:FireClient(v1, EggRadarEffects, p1)
	end
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 33 ]]
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