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
-- CQM5BFRhcGUIT3JuYW1lbnQFcGFpcnMFdGFibGUGaW5zZXJ0FmdldG51bWJlcm9maXRlbXNpbnRpZXIJd29ya3NwYWNlBEluZm8NQ2FyZE1vZGlmaWVycwpJdGVtUmFyaXR5DkZpbmRGaXJzdENoaWxkC0l0ZW1SYXJpdHkyBkNvbW1vbghVbmNvbW1vbgRSYXJlCFZlcnlSYXJlCVVsdHJhUmFyZQRtYXRoBnJhbmRvbQpSYW5kb21JdGVtBnNjcmlwdAROYW1lCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQNSW5HYW1lUGxheWVycwtHZXRDaGlsZHJlbghIdW1hbm9pZAZIZWFsdGgJSW52ZW50b3J5DFdhaXRGb3JDaGlsZAVTbG90MQVTbG90MgVTbG90MwVTbG90NAR3YXJuDk5vIGl0ZW0gZm91bmQuA1BvcAROb25lCHRvc3RyaW5nEEFwcGx5Q2FyZEVmZmVjdHMEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlDVNlcnZlclN0b3JhZ2ULUGxheWVyU3RhdHMHcmVxdWlyZQdNb2R1bGVzDUZsb29ySXRlbVBvb2wFQnVpbGQOTG9zdCBhbmQgRm91bmQYcmJ4YXNzZXRpZDovLzE3NzAyMzYzMzk0BEljb25MRXZlcnkgVG9vbiB3aWxsIHJlY2lldmUgb25lIHJhbmRvbSBJdGVtIGlmIHRoZXkgaGF2ZSBhbiBpbnZlbnRvcnkgc2xvdCBvcGVuLgtEZXNjcmlwdGlvbgAFAwIAAAAACKkCAADwAAUAAAAAAPAAAgABAACAqQIAAakCAQCCAgIAAgMBAwIACwABGAAAAAAAAAAADAAAAAALAgEAAAAT/wIAAAAAAACkAwEAAAAAQPsGAACHBAYAnwMCBBcDBwCeNAIFBwAAAFIJAgBSCgcApAgEAAAMIICfCAMBbgP4/wIAAAAcAwIAggMCAAUDAwQAAABAAwQDBQQADCCAABIGARgAAAEAAAAAAAEAAAAAAAD/AAMAEwAAAAASAQEAAABv/wEAAAAAAACkAgEAAAAAQE0CAnoCAAAATQICpAMAAABvBAQAvAICAwUAAACfAgMCDgIOAKQCAQAAAABATQICegIAAABNAgKkAwAAAG8EBgC8AgIDBQAAAJ8CAwIOAgMA4gIRAFIBAgBlAB4ApAIBAAAAAEBNAgJ6AgAAAE0CAqQDAAAAbwQEALwCAgMFAAAAnwIDAg4CAwDiAhUAUgECAGUAEACkAgEAAAAAQE0CAnoCAAAATQICpAMAAABvBAYAvAICAwUAAACfAgMCDgIDAOICFQBSAQIAZQACAOICGQBSAQIA/wIAAAAAAACkAxsAAACgQVIEAQCfAwIEFwMMAIwIAACeNAIFBgAAAFIKAgBSCwYApAkeAAB0wIGfCQMBlQgIGPEIAgAHAAAASAD1/24D8/8CAAAApAQhAACA8IGMBQEAHAYCAJ8EAwKHAwIExgQAAPsGAACHBQYDpAYhAACA8IGMBwEA/wkAAAAAAACkChsAAACgQfsNAACHCw0DnwoCBBcKBwCeNAkFDgAAAFIQCQBSEQ4ApA8eAAB0wIGfDwMBbgr4/wIAAAAcCAkAnwYDAocEBQaCBAIAIgMHBAAAAEADCAMJAwoDCwMMAw0CAAAAAAAASUADDgIAAAAAAIBBQAMPAgAAAAAAADNAAxACAAAAAAAAHEADEQIAAAAAAAAIQAgFBwgAAAAJCgAAAAsMAAAADQ4AAAAPEAAAAAIAAAAAAAAxQAIAAAAAAAAYQAIAAAAAAAAAQAgFBwgAAAAJCgAAAAsSAAAADRMAAAAPFAAAAAIAAAAAAAAuQAIAAAAAAAAUQAIAAAAAAADwPwgFBwgAAAAJCgAAAAsWAAAADRcAAAAPGAAAAAMDBAAAoEEDBAMFBAB0wIEDEgMTBACA8IEAGhQBGAgAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAcAAAAAAAAAAAAAAQAABwAAAAAAAAAAAAABAAAIAAkAAQAAAAACAgAAAAAAAAEBAAD6AAkAAAAAAAIEAAAAAMQAAQAAAAAAAQAAAAAAAP8AAzgAARMAAAAADwABAAAAiQH7AAAApAIBAAAAAEBNAgK6AgAAALwAAAMDAAAAnwADAisAfwCkAAYAABRAgG8BBwCfAAICpAEBAAAAAEBNAQG6AgAAADABALoCAAAAjAEKADABAOwIAAAA+wEAADABACQJAAAApAELAAAAoECkAg0AAADAQE0CAkoOAAAAvAICaA8AAACfAgIAnwEABBcBYgBvCBAAvAYFAwMAAACfBgMCDgZdAE0GBQEQAAAATQYGWhEAAACMBwAAYAdXAAYAAABvCBIAvAYF0xMAAACfBgMCbwkUALwHBtMTAAAAnwcDAm8KFQC8CAbTEwAAAJ8IAwJvCxYAvAkG0xMAAACfCQMCbwwXALwKBgMDAAAAnwoDAqkLAAA1DAAsGAAAAJ8MAQIrDAYApA0aAAAAkEFvDhsAnw0CAW8MHABlAAIATQwMugIAAABNDQfsCAAAAPANCgAdAACAKwsIAKkLAQC7PwwDUg4MAKQNHwAAAOBBnw0CAjANB+wIAAAATQ0I7AgAAADwDQoAHQAAgCsLCACpCwEAuz8MA1IODACkDR8AAADgQZ8NAgIwDQjsCAAAAE0NCewIAAAA8A0KAB0AAIArCwgAqQsBALs/DANSDgwApA0fAAAA4EGfDQICMA0J7AgAAAAOCg0ATQ0K7AgAAADwDQoAHQAAgCsLCACpCwEAuz8MA1IODACkDR8AAADgQZ8NAgIwDQrsCAAAAG4Bnf8CAAAAggABACADFQQAAABAAxYDCwMXAxgEABRAgAMZAxoDGwMDBAAAoEADBwQAAMBAAxwDHQMeAx8DIAMhAyIDIwMkAyUDFAMmBAAAkEEDJwMoAykDKgQAAOBBAFgrARgAAAAAAAAAAAABAAAAAQAAAAAAAQAAAQAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAICAAACAQAAAAEAAgADAAAAAAEBAAAAAAAAAgAAAAABAQAAAAAAAAIAAAAAAQEAAAAAAAACAQAAAAABAQAAAAAAAN4AKFkAAAAACgAAAQIAPKMAAAD/AAMAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDBgAAAFBATQMDegcAAABNAwOkCAAAAKQEBgAAAFBATQQEegcAAABNBAQBCQAAAKQFCwAAAKBATQYB6AwAAABNBgZgDQAAAJ8FAgJNBgVPDgAAAMAHDwCfBgIC/wcAAAAAAADACBAAEgAGAMAJEQASAAYAGAkALBIAAABvCRMAMAkAuhQAAABvCRUAMAkArhYAAABvCRcAMAkA4hgAAADACRkAEgADADAJAIMaAAAAggACABsDLAQAAABAAy0DLgMvAwcEAABQQAMIAwkDMAMxBAAAoEADMgMzAzQGAAYBBgIDFAM1AxYDNgM3AzgDOQYDAysEAAECAwEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAADAAAAAAAAAgAAAAQAAwAIAAAAOgAAAQAAAQAAAgAAADABAAAAAARUJSlCeTXP6qKVXXdZp8JkJD0+NmbhQ0M=

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats
local v1 = require(ReplicatedStorage.Modules.FloorItemPool).Build(function(p1, p2) --[[ Line: 11 ]]
	return if p1 == "Tape" then false else p1 ~= "Ornament"
end)

local function getnumberofitemsintier(p1, p2) --[[ getnumberofitemsintier | Line: 18 | Upvalues: v1 (copy) ]]
	local t = {}

	for k, v in pairs(v1[p1]) do
		table.insert(t, v)
	end

	return #t
end

function RandomItem(p1) --[[ RandomItem | Line: 26 | Upvalues: v1 (copy) ]]
	local t = {}

	for k, v in pairs(if workspace.Info.CardModifiers:FindFirstChild("ItemRarity") and workspace.Info.CardModifiers:FindFirstChild("ItemRarity2") then {
	Common = 50,
	Uncommon = 35,
	Rare = 19,
	VeryRare = 7,
	UltraRare = 3
} elseif workspace.Info.CardModifiers:FindFirstChild("ItemRarity") then {
	Common = 50,
	Uncommon = 35,
	Rare = 17,
	VeryRare = 6,
	UltraRare = 2
} elseif workspace.Info.CardModifiers:FindFirstChild("ItemRarity2") then {
	Common = 50,
	Uncommon = 35,
	Rare = 17,
	VeryRare = 6,
	UltraRare = 2
} else {
	Common = 50,
	Uncommon = 35,
	Rare = 15,
	VeryRare = 5,
	UltraRare = 1
}) do
		local count = 0

		repeat
			table.insert(t, k)
			count = count + 1
		until count == v
	end

	local v2 = t[math.random(1, #t)]
	local random = math.random
	local t2 = {}

	for k, v in pairs(v1[v2]) do
		table.insert(t2, v)
	end

	return v1[v2][random(1, #t2)]
end
t.Name = "Lost and Found"
t.Icon = "rbxassetid://17702363394"
t.Description = "Every Toon will recieve one random Item if they have an inventory slot open."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 88 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 10
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		local v2

		if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
			local Inventory = v:WaitForChild("Inventory")
			local Slot1 = Inventory:WaitForChild("Slot1")
			local Slot2 = Inventory:WaitForChild("Slot2")
			local Slot3 = Inventory:WaitForChild("Slot3")
			local Slot4 = Inventory:FindFirstChild("Slot4")
			local v3 = false
			local v4 = RandomItem()

			if v4 then
				v2 = v4.Name
			else
				warn("No item found.")
				v2 = "Pop"
			end

			if Slot1.Value == "None" and not v3 then
				Slot1.Value = tostring(v2)
				v3 = true
			end

			if Slot2.Value == "None" and not v3 then
				Slot2.Value = tostring(v2)
				v3 = true
			end

			if Slot3.Value == "None" and not v3 then
				Slot3.Value = tostring(v2)
				v3 = true
			end

			if Slot4 and (Slot4.Value == "None" and not v3) then
				Slot4.Value = tostring(v2)
			end
		end
	end
end

return t