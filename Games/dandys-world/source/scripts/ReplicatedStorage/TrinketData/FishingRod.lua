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
-- CQMmFkdldFBsYXllckZyb21DaGFyYWN0ZXIGRXZlbnRzEkNsaWVudEFiaWxpdHlFdmVudApGaXJlQ2xpZW50DEFwcGx5VHJpbmtldAhUcmlua2V0cwxXYWl0Rm9yQ2hpbGQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQLRmlzaGluZyBSb2QYcmJ4YXNzZXRpZDovLzE4NzI3Mjk5NjEwBEljb24GQ29tbW9uBlJhcml0eVVIaWdobGlnaHRzIGFsbCBNYWNoaW5lIGxvY2F0aW9ucyBmb3IgdGhlIHVzZXIgd2hlbiBhIG5ldyBGbG9vciBhcnJpdmVzIGZvciA1IHNlY29uZHMuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUOTW9uc3RlclRyaW5rZXQEQ29zdARDb2luDFJlcXVpcmVtZW50MQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHUGxheWVycwdNb2R1bGVzBVpvbmVzEUZpc2hpbmdSb2RFZmZlY3RzAAMIAgMAAAAT+wIAAFIEAAC8AgKJAAAAAJ8CAwIrAgEAggABAPsDAQBNAwNaAQAAAE0DA6ECAAAAUgUCAPsGAgBSBwAAvAMDCAMAAACfAwUBggABAAQDAQMCAwMDBAAYBQEYAAAAAAABAAIAAAAAAAAAAAAAARkAAAAABgEAAAAALG8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIBAwMAAACfAgMCbwUEALwDAQMDAAAAnwMDAg4CAQArAwIAbwQFAIIEAgBNBALsBgAAAKQFCAAAAHBATQUFugkAAACaBAYABQAAAG8ECgAwBALsBgAAAG8ECwCCBAIATQQD7AYAAACkBQgAAABwQE0FBboJAAAAmgQGAAUAAABvBAoAMAQD7AYAAABvBAwAggQCAG8EBQCCBAIADQMGAwcDCAMJAwoDCwMMAw0EAABwQAMOAw8DEAMRAB8SARgAAAAAAQAAAAEAAAABAAAAAgAAAAAAAAABAAABAAMAAAAAAAAAAQAAAQADACAAAAAABQAAAQIAPaMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCuAwAAAG8BBAAwAQDyBQAAAG8BBgAwAQDiBwAAAG8BCAAwAQC/CQAAAKkBAQAwAQDmCgAAAIwBXgEwAQAjCwAAAP8BAAACAAAAbwIMAE0DACMLAAAAxQECAwEAAAAwAQCfDQAAAKQBDwAAAOBAbwMQALwBARYRAAAAnwEDAqQCDwAAAOBAbwQSALwCAhYRAAAAnwIDAk0DAegTAAAATQMDUBQAAABNAwNpFQAAAMAEFgASAAIAEgABABIAAwAwBABrFwAAAMAEGAAwBACtGQAAAIIAAgAaAxMDDgMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgBAAA4EADIQMiAyMDJAMlAyYGAAMFBgEDEgIAAQEAARgAAAACAAABAAACAAACAAACAAACAAACAAABAAAAAAAAAAACAAAAAAABAAAAAAAEAAAAAAACAAAAAAAHAAATAQAAAAAC1jhvdfie6zR4BJuR+4eanaYgeAHk/AV0

-- https://lua.expert/
local t = {
	Name = "Fishing Rod",
	Icon = "rbxassetid://18727299610",
	Rarity = "Common",
	Description = "Highlights all Machine locations for the user when a new Floor arrives for 5 seconds.",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 350
}

t.Requirement1 = { "Coin", t.Cost }

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local FishingRodEffects = ReplicatedStorage.Modules.Zones.FishingRodEffects

function t.ApplyTrinket(p1, p2) --[[ ApplyTrinket | Line: 24 | Upvalues: Players (copy), ReplicatedStorage (copy), FishingRodEffects (copy) ]]
	local v1 = Players:GetPlayerFromCharacter(p1)

	if v1 then
		ReplicatedStorage.Events.ClientAbilityEvent:FireClient(v1, FishingRodEffects, p1)
	end
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 31 ]]
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