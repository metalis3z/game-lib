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
-- CQMlE0FwcGx5U3BlZWRNb2RpZmllcnMFQnJpY2sIY2F0ZWdvcnkHdHJpbmtldAxBcHBseVRyaW5rZXQIVHJpbmtldHMMV2FpdEZvckNoaWxkCFRyaW5rZXQxDkZpbmRGaXJzdENoaWxkCFRyaW5rZXQyCkNhbnRSZW1vdmUFVmFsdWUGc2NyaXB0BE5hbWUETm9uZRRSZW1vdmVTcGVlZE1vZGlmaWVycwVTbG90MQVTbG90Mg1SZW1vdmVUcmlua2V0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQdNb2R1bGVzBERhdGETU3RhdE1vZGlmaWVyTWFuYWdlchhyYnhhc3NldGlkOi8vMTc2NTM4MDk5NDkESWNvbgZDb21tb24GUmFyaXR5SUxvd2VycyBib3RoIFdhbGsgYW5kIFJ1biBTcGVlZCBieSAxMCUuIEl0J3MgYSBicmljaywgd2hhdCBkaWQgeW91IGV4cGVjdD8LRGVzY3JpcHRpb24HUGFzc2l2ZQtUcmlua2V0VHlwZQ5Nb25zdGVyVHJpbmtldARDb3N0BENvaW4MUmVxdWlyZW1lbnQxAAMHAQIAAAAL+wEAAPsCAQBNAgIrAAAAAFIDAABvBAEAbwUCAOIGBQCfAgUCagIBAIIAAQAGAwECzczMzMzM7D8DAgMDAwQIAQMEAAAAABQFARgAAAAAAAAAAAAAARYAAAAACAECAAAARm8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIBAwMAAACfAgMCbwUEALwDAQMDAAAAnwMDAg4CAQArAwIAbwQFAIIEAgBNBALsBgAAAKQFCAAAAHBATQUFugkAAACaBBMABQAAAG8ECgAwBALsBgAAAPsFAACHBAUADgQKAPsEAQBNBASACwAAAFIFAAD7BwAAhwYHAJ8EAwH7BAAAxgUAAGoFBABvBAwAggQCAE0EA+wGAAAApAUIAAAAcEBNBQW6CQAAAJoEEwAFAAAAbwQKADAEA+wGAAAA+wUAAIcEBQAOBAoA+wQBAE0EBIALAAAAUgUAAPsHAACHBgcAnwQDAfsEAADGBQAAagUEAG8EDQCCBAIAbwQFAIIEAgAOAwYDBwMIAwkDCgMLAwwDDQQAAHBAAw4DDwMQAxEDEgAZEwEYAAAAAAIAAAABAAAAAQAAAAIAAAAAAAAAAQAAAgAAAQAAAAAAAAEAAAIAAwAAAAAAAAABAAACAAABAAAAAAAAAQAAAgADABoAAAAABgAAAQIAO6MAAACkAAEAAAAAQKQBAwAAACBATQEBPwQAAABNAQHoBQAAAE0BAcYGAAAATQEB4QcAAACfAAIC/wEAAAAAAAD/AgUAAAAAAG8DCAAwAwK6CQAAAG8DCgAwAwKuCwAAAG8DDAAwAwLyDQAAAG8DDgAwAwLiDwAAAG8DEAAwAwK/EQAAAKkDAQAwAwLmEgAAAIwDXgEwAwIjEwAAAP8DAAACAAAAbwQUAE0FAiMTAAAAxQMEAwEAAAAwAwKfFQAAAMADFgASAAEAEgAAADADAmsXAAAAwAMYABIAAQASAAAAMAMCrRkAAACCAgIAGgMUBAAAAEADFQQAACBAAxYDFwMYAxkDAgMOAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlBgADBQYBAxMCAAEBAAEYAAAAAAAAAAAAAAAAAAABAAIAAgAAAQAAAgAAAgAAAgAAAgAAAgAAAQAAAAAAAAAAAgAAAAAFAAAAAB4BAAAAAAI9xmwjfwKoeuOENZ/Xu8mETd57Vw8CBiI=

-- https://lua.expert/
local StatModifierManager = require(game.ReplicatedStorage.Modules.Data.StatModifierManager)
local t = {}
local t2 = {
	Name = "Brick",
	Icon = "rbxassetid://17653809949",
	Rarity = "Common",
	Description = "Lowers both Walk and Run Speed by 10%. It\'s a brick, what did you expect?",
	TrinketType = "Passive",
	MonsterTrinket = true,
	Cost = 350
}

t2.Requirement1 = { "Coin", t2.Cost }
function t2.ApplyTrinket(p1) --[[ ApplyTrinket | Line: 20 | Upvalues: t (copy), StatModifierManager (copy) ]]
	t[p1] = StatModifierManager.ApplySpeedModifiers(p1, 0.9, "Brick", {
		category = "trinket"
	})
end
function t2.RemoveTrinket(p1) --[[ RemoveTrinket | Line: 25 | Upvalues: t (copy), StatModifierManager (copy) ]]
	local Trinkets = p1:WaitForChild("Trinkets")
	local Trinket1 = Trinkets:FindFirstChild("Trinket1")
	local Trinket2 = Trinkets:FindFirstChild("Trinket2")

	if not (Trinket1 and Trinket2) then
		return "CantRemove"
	end

	if Trinket1.Value == script.Name then
		Trinket1.Value = "None"

		if not t[p1] then
			return "Slot1"
		end

		StatModifierManager.RemoveSpeedModifiers(p1, t[p1])
		t[p1] = nil

		return "Slot1"
	end

	if Trinket2.Value ~= script.Name then
		return "CantRemove"
	end

	Trinket2.Value = "None"

	if not t[p1] then
		return "Slot2"
	end

	StatModifierManager.RemoveSpeedModifiers(p1, t[p1])
	t[p1] = nil

	return "Slot2"
end

return t2