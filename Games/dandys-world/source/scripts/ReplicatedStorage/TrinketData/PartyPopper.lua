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
-- CQMqBGdhbWUHUGxheWVycxZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyBVN0YXRzDFdhaXRGb3JDaGlsZApJbkVsZXZhdG9yBkV2ZW50cxJDbGllbnRBYmlsaXR5RXZlbnQKRmlyZUNsaWVudAxBcHBseVRyaW5rZXQIVHJpbmtldHMIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQRUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZRFDb2xsZWN0aW9uU2VydmljZQxUd2VlblNlcnZpY2UGRGVicmlzB01vZHVsZXMFWm9uZXMSUGFydHlQb3BwZXJFZmZlY3RzDFBhcnR5IFBvcHBlchtyYnhhc3NldGlkOi8vNzg5NTY0OTA4MjgwMjEESWNvbghVbmNvbW1vbgZSYXJpdHloV2hlbiBzdGFydGluZyB0byB3b3JrIG9uIGEgbWFjaGluZSwgVHdpc3RlZHMgaW4gdGhlIGluaXRpYWwgbmVhcmJ5IHJhZGl1cyBhcmUgaGlnaGxpZ2h0ZWQgZm9yIDUgc2Vjb25kcy4LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQ5Nb25zdGVyVHJpbmtldARDb3N0DFJlcXVpcmVtZW50MQADCgICAAAAHqQCAQAAAABATQICUAIAAABSBAAAvAICiQMAAACfAgMCKwIBAIIAAQBvBQQAvAMA0wUAAACfAwMCbwYGALwEA9MFAAAAnwQDAvsFAABNBQVaBwAAAE0FBaEIAAAAUgcCAPsIAQBSCQAAvAUFCAkAAACfBQUBggABAAoDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQAWCgEYAAAAAAAAAAABAAIAAAABAAAAAwAAAAAAAAAAAAABFwAAAAAGAQAAAAAsbwMAALwBANMBAAAAnwEDAm8EAgC8AgEDAwAAAJ8CAwJvBQQAvAMBAwMAAACfAwMCDgIBACsDAgBvBAUAggQCAE0EAuwGAAAApAUIAAAAcEBNBQW6CQAAAJoEBgAFAAAAbwQKADAEAuwGAAAAbwQLAIIEAgBNBAPsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBAPsBgAAAG8EDACCBAIAbwQFAIIEAgANAwsDBQMMAw0DDgMPAxADEQQAAHBAAxIDEwMUAxUAIRYBGAAAAAABAAAAAQAAAAEAAAACAAAAAAAAAAEAAAEAAwAAAAAAAAABAAABAAMAIgAAAAAJAAABAgBHowAAAP8ABQAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMBAAAAAEBvBQUAvAMDFgMAAACfAwMCpAQBAAAAAEBvBgYAvAQEFgMAAACfBAMCTQUB6AcAAABNBQVQCAAAAE0FBXcJAAAAbwYKADAGALoLAAAAbwYMADAGAK4NAAAAbwYOADAGAPIPAAAAbwYQADAGAOIRAAAAbwYSADAGAL8TAAAAqQYBADAGAOYUAAAAjAbcBTAGACMVAAAA/wYAAAIAAABvBxYAjAgAAMUGBwMBAAAAMAYAnxcAAADABhgAEgABABIABQAwBgBrGQAAAMAGGgAwBgCtGwAAAIIAAgAcAwEEAAAAQAMXAxgDGQMaAxsDHAMdAx4DHwMSAyADIQMiAyMDJAMlAyYDJwMoAykDEwMqBgADCgYBAxYCAAEBAAEYAAAAAgAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgAAAAAAAgAAAQAAAgAAAgAAAgAAAQAAAQAAAQAAAAAAAAACAAAAAAsAABMBAAAAAAKzGZTdyQDycEBC1tXpAsFRwwGDqYHd/tw=

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("CollectionService")
game:GetService("TweenService")
game:GetService("Debris")

local PartyPopperEffects = ReplicatedStorage.Modules.Zones.PartyPopperEffects

t.Name = "Party Popper"
t.Icon = "rbxassetid://78956490828021"
t.Rarity = "Uncommon"
t.Description = "When starting to work on a machine, Twisteds in the initial nearby radius are highlighted for 5 seconds."
t.TrinketType = "Passive"
t.MonsterTrinket = true
t.Cost = 1500
t.Requirement1 = { "None", 0 }
function t.ApplyTrinket(p1, p2) --[[ ApplyTrinket | Line: 22 | Upvalues: ReplicatedStorage (copy), PartyPopperEffects (copy) ]]
	local v1 = game.Players:GetPlayerFromCharacter(p1)

	if v1 then
		p1:WaitForChild("Stats"):WaitForChild("InElevator")
		ReplicatedStorage.Events.ClientAbilityEvent:FireClient(v1, PartyPopperEffects, p1)
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