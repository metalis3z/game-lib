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
-- CQNABlBhcmVudAdFbmFibGVkCEluc3RhbmNlA25ldwpBdHRhY2htZW50DEJ1ZmZQYXJ0aWNsZQROYW1lBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UFUGFydHMNQnVmZlBhcnRpY2xlcwdTdGFtaW5hBUNsb25lBEdsb3cHQWRkSXRlbQR0YXNrBWRlbGF5BVNwZWVkBVZhbHVlDUFwcGx5TW9kaWZpZXINU3BlZWRNb2RpZmllcglDaG9jb2xhdGUIY2F0ZWdvcnkEaXRlbQR3YWl0DlJlbW92ZU1vZGlmaWVyBVN0YXRzDFdhaXRGb3JDaGlsZA5DdXJyZW50U3RhbWluYQ9PcmlnaW5hbFN0YW1pbmEMSXRlbUR1cmF0aW9uB091dGNvbWUGUmVhc29uJENhbid0IHVzZSB0aGF0IGl0ZW0gYXQgZnVsbCBTdGFtaW5hIRBIdW1hbm9pZFJvb3RQYXJ0DkZpbmRGaXJzdENoaWxkBnNjcmlwdAhVc2VTb3VuZARQbGF5C1NhZmVDbGVhbnVwBXNwYXduBE5vbmUJd29ya3NwYWNlBEluZm8LUGxheWVyU3RhdHMOU3Vydml2YWxQb2ludHMHVXNlSXRlbQlQb2ludENvc3QORGFuZHlTdG9yZUl0ZW0JRmxvb3JJdGVtBkNvbW1vbgZSYXJpdHkYcmJ4YXNzZXRpZDovLzE3NzI3ODQwMTM5BEljb25RVXNlIHRoaXMgaXRlbSB0byBpbmNyZWFzZSBNYXggU3RhbWluYSBieSAyNSBhbmQgV2FsayBTcGVlZCBieSAxMCUgZm9yIDEwIHNlY29uZHMuC0Rlc2NyaXB0aW9uBkRlYnJpcwpHZXRTZXJ2aWNlB3JlcXVpcmUHTW9kdWxlcwREYXRhE1N0YXRNb2RpZmllck1hbmFnZXIFQXVkaW8KU291bmRVdGlscwAGAgAEAAAAEvsAAAAOAA8A+wAAAE0AACQAAAAARwALAAAAAAD7AAEADgAIAPsAAgCpAQAAMAEA8AEAAAD7AAMAqQEAADABAPABAAAAggABAAIDAQMCADQAARgAAAAAAAAAAAABAAAAAQAAAAI1AAAAAAIABAAAABL7AAAADgAPAPsAAABNAAAkAAAAAEcACwAAAAAA+wABAA4ACAD7AAIAqQEAADABAPABAAAA+wADAKkBAAAwAQDw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

-- https://lua.expert/
local t = {
	Name = "Chocolate",
	PointCost = 22,
	DandyStoreItem = true,
	FloorItem = true,
	Rarity = "Common",
	Icon = "rbxassetid://17727840139",
	Description = "Use this item to increase Max Stamina by 25 and Walk Speed by 10% for 10 seconds.",
	ItemDuration = 10
}
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatModifierManager = require(ReplicatedStorage.Modules.Data.StatModifierManager)
local SoundUtils = require(ReplicatedStorage.Modules.Audio.SoundUtils)

function t.UseItem(p1, p2, p3) --[[ UseItem | Line: 18 | Upvalues: t (copy), SoundUtils (copy), Debris (copy), StatModifierManager (copy) ]]
	local Stats = p1:WaitForChild("Stats")
	local CurrentStamina = Stats:WaitForChild("CurrentStamina")
	local OriginalStamina = Stats:WaitForChild("OriginalStamina")
	local ItemDuration = t.ItemDuration

	if p3 and p3 > 0 then
		ItemDuration = ItemDuration + p3
	end

	local t2 = {
		Outcome = true,
		Reason = "Can\'t use that item at full Stamina!"
	}

	if p1:FindFirstChild("HumanoidRootPart") then
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
		local v1 = script.UseSound:Clone()

		v1.Parent = HumanoidRootPart
		v1:Play()
		SoundUtils.SafeCleanup(v1)
		task.spawn(function() --[[ Line: 39 | Upvalues: HumanoidRootPart (copy), Debris (ref), ItemDuration (ref), p1 (copy) ]]
			local BuffParticle = Instance.new("Attachment")

			BuffParticle.Name = "BuffParticle"
			BuffParticle.Parent = HumanoidRootPart

			local v1 = game.ReplicatedStorage.Parts.BuffParticles.Stamina.BuffParticle:Clone()

			v1.Parent = BuffParticle
			v1.Enabled = true

			local v2 = game.ReplicatedStorage.Parts.BuffParticles.Stamina.Glow:Clone()

			v2.Parent = BuffParticle
			v2.Enabled = true
			Debris:AddItem(v1, ItemDuration + 1)
			Debris:AddItem(v2, ItemDuration + 1)
			Debris:AddItem(BuffParticle, ItemDuration + 1)
			task.delay(ItemDuration, function() --[[ Line: 52 | Upvalues: p1 (ref), BuffParticle (copy), v1 (copy), v2 (copy) ]]
				if not p1 or (p1.Parent == nil or not BuffParticle) then
					return
				end

				v1.Enabled = false
				v2.Enabled = false
			end)

			local BuffParticle2 = Instance.new("Attachment")

			BuffParticle2.Name = "BuffParticle"
			BuffParticle2.Parent = HumanoidRootPart

			local v3 = game.ReplicatedStorage.Parts.BuffParticles.Speed.BuffParticle:Clone()

			v3.Parent = BuffParticle2
			v3.Enabled = true

			local v4 = game.ReplicatedStorage.Parts.BuffParticles.Speed.Glow:Clone()

			v4.Parent = BuffParticle2
			v4.Enabled = true
			Debris:AddItem(v3, ItemDuration + 1)
			Debris:AddItem(v4, ItemDuration + 1)
			Debris:AddItem(BuffParticle2, ItemDuration + 1)
			task.delay(ItemDuration, function() --[[ Line: 70 | Upvalues: p1 (ref), BuffParticle2 (copy), v3 (copy), v4 (copy) ]]
				if not p1 or (p1.Parent == nil or not BuffParticle2) then
					return
				end

				v3.Enabled = false
				v4.Enabled = false
			end)
		end)
	end

	task.spawn(function() --[[ Line: 80 | Upvalues: OriginalStamina (copy), CurrentStamina (copy), StatModifierManager (ref), p1 (copy), ItemDuration (ref) ]]
		local v1 = OriginalStamina

		v1.Value = v1.Value + 25

		local v2 = CurrentStamina

		v2.Value = v2.Value + 25

		local v3 = StatModifierManager.ApplyModifier(p1, "SpeedModifier", 1.1, "Chocolate", {
			category = "item"
		})

		task.wait(ItemDuration)

		if not p1 or p1.Parent == nil then
			return
		end

		local v4 = OriginalStamina

		v4.Value = v4.Value - 25
		StatModifierManager.RemoveModifier(p1, "SpeedModifier", v3)
	end)
	p2.Value = "None"

	local v2 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v2 then
		return t2
	end

	local SurvivalPoints = v2:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 2

	return t2
end

return t