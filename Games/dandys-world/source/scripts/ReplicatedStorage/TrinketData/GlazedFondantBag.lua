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
-- CQMgBGdhbWUHUGxheWVycxZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyFEl0ZW1EdXJhdGlvbkluY3JlYXNlDUR1cmF0aW9uQm9udXMMU2V0QXR0cmlidXRlDEFwcGx5VHJpbmtldAhUcmlua2V0cwxXYWl0Rm9yQ2hpbGQIVHJpbmtldDEORmluZEZpcnN0Q2hpbGQIVHJpbmtldDIKQ2FudFJlbW92ZQVWYWx1ZQZzY3JpcHQETmFtZQROb25lBVNsb3QxBVNsb3QyDVJlbW92ZVRyaW5rZXQSR2xhemVkIEZvbmRhbnQgQmFnHHJieGFzc2V0aWQ6Ly8xMDUxMzkxMjYwNjY2MTgESWNvbgRSYXJlBlJhcml0eXNDYW5keSBpdGVtcyB0aGF0IHByb3ZpZGUgYSBib29zdCBnYWluIDQgc2Vjb25kcyB0byB0aGVpciBkdXJhdGlvbiB3aGlsZSB0aGlzIFRyaW5rZXQgaXMgZXF1aXBwZWQgKEJvbkJvbiBpbmNsdWRlZCkuC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUEQ29zdARDb2luDFJlcXVpcmVtZW50MQADBwIBAAAAGaQCAQAAAABATQICUAIAAABSBAAAvAICiQMAAACfAgMCKwIBAIIAAQBvBQQA+wYAAE0GBuEFAAAAvAMALgYAAACfAwQBbwUEAPsGAABNBgbhBQAAALwDAi4GAAAAnwMEAYIAAQAHAwEEAAAAQAMCAwMDBAMFAwYAEgcBGAAAAAAAAAAAAQADAAAAAAAAAQAAAAAAAAEUAAAAAAkBAAAAAEpvAwAAvAEA0wEAAACfAQMCbwQCALwCAQMDAAAAnwIDAm8FBAC8AwEDAwAAAJ8DAwIOAgEAKwMCAG8EBQCCBAIApAQHAAAAYEBNBARQCAAAAFIGAAC8BASJCQAAAJ8EAwJNBQLsCgAAAKQGDAAAALBATQYGug0AAACaBREABgAAAG8FDgAwBQLsCgAAAG8HDwDGCAAAvAUALhAAAACfBQQBDgQFAG8HDwDGCAAAvAUELhAAAACfBQQBbwURAIIFAgBNBQPsCgAAAKQGDAAAALBATQYGug0AAACaBREABgAAAG8FDgAwBQPsCgAAAG8HDwDGCAAAvAUALhAAAACfBQQBDgQFAG8HDwDGCAAAvAUELhAAAACfBQQBbwUSAIIFAgBvBQUAggUCABMDCAMJAwoDCwMMAw0DAQQAAGBAAwIDAwMOAw8EAACwQAMQAxEDBAMGAxIDEwAcFAEYAAAAAAEAAAABAAAAAQAAAAMAAAAAAAAAAgAAAAAAAAABAAACAAAAAAEBAAAAAAIAAwAAAAAAAAABAAACAAAAAAEBAAAAAAIAAwAdAAAAAAQAAAECACijAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEArgMAAABvAQQAMAEA8gUAAABvAQYAMAEA4gcAAABvAQgAMAEAvwkAAACMAV4BMAEAIwoAAAD/AQAAAgAAAG8CCwCMA14BxQECAwEAAAAwAQCfDAAAAIwBBAAwAQDhDQAAAMABDgASAAAAMAEAaw8AAADAARAAMAEArREAAACCAAIAEgMVAxADFgMXAxgDGQMaAxsDHAMdAx4DHwMgAwUGAAMHBgEDFAIAAQEAARgAAAACAAABAAACAAACAAACAAACAAABAAAAAAAAAAMAAAIAAAAKAAAgAQAAAAACEG1VWR+dqQfRborF53h+H2B1Qi0iqT9Y

-- https://lua.expert/
local t = {
	Name = "Glazed Fondant Bag",
	Icon = "rbxassetid://105139126066618",
	Rarity = "Rare",
	Description = "Candy items that provide a boost gain 4 seconds to their duration while this Trinket is equipped (BonBon included).",
	TrinketType = "Passive",
	Cost = 350,
	Requirement1 = { "Coin", 350 },
	DurationBonus = 4
}

function t.ApplyTrinket(p1, p2) --[[ ApplyTrinket | Line: 18 | Upvalues: t (copy) ]]
	local v1 = game.Players:GetPlayerFromCharacter(p1)

	if v1 then
		p1:SetAttribute("ItemDurationIncrease", t.DurationBonus)
		v1:SetAttribute("ItemDurationIncrease", t.DurationBonus)
	end
end
function t.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 28 ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	local v1 = game.Players:GetPlayerFromCharacter(p1)

	if Trinket1.Value == script.Name then
		Trinket1.Value = "None"
		p1:SetAttribute("ItemDurationIncrease", nil)

		if not v1 then
			return "Slot1"
		end

		v1:SetAttribute("ItemDurationIncrease", nil)

		return "Slot1"
	end

	if Trinket2.Value ~= script.Name then
		return "CantRemove"
	end

	Trinket2.Value = "None"
	p1:SetAttribute("ItemDurationIncrease", nil)

	if not v1 then
		return "Slot2"
	end

	v1:SetAttribute("ItemDurationIncrease", nil)

	return "Slot2"
end

return t