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
-- CQM+BlBhcmVudBRSZW1vdmVTcGVlZE1vZGlmaWVycw5SZW1vdmVNb2RpZmllchNEZWNvZGVTcGVlZE1vZGlmaWVyB0VuYWJsZWQQSHVtYW5vaWRSb290UGFydAxXYWl0Rm9yQ2hpbGQHT3V0Y29tZQZSZWFzb24eQm9uIEJvbiBjb25zdW1lZCBzdWNjZXNzZnVsbHkhDkZpbmRGaXJzdENoaWxkBVBhcnRzCUF1ZGlvUGFydAhVc2VTb3VuZAVDbG9uZQRQbGF5C1NhZmVDbGVhbnVwDEl0ZW1EdXJhdGlvbhNBcHBseVNwZWVkTW9kaWZpZXJzBkJvbkJvbghjYXRlZ29yeQRpdGVtCWFudGlDaGVhdA1BcHBseU1vZGlmaWVyBHRhc2sFZGVsYXkISW5zdGFuY2UDbmV3CkF0dGFjaG1lbnQMQnVmZlBhcnRpY2xlBE5hbWUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ1CdWZmUGFydGljbGVzBVNwZWVkBEdsb3cLRGVjb2RlU3BlZWQHQWRkSXRlbQROb25lBVZhbHVlCXdvcmtzcGFjZQRJbmZvC1BsYXllclN0YXRzDlN1cnZpdmFsUG9pbnRzB1VzZUl0ZW0LU3BlY2lhbEl0ZW0PQWJpbGl0eU9ubHlJdGVtBFJhcmUGUmFyaXR5CVBvaW50Q29zdBxyYnhhc3NldGlkOi8vMTMwMzM1NTk3NjAyNjEwBEljb25XVXNlIHRoaXMgaXRlbSB0byBpbmNyZWFzZSBleHRyYWN0aW9uIHNwZWVkICs1MCUgYW5kIG1vdmVtZW50IHNwZWVkICsyNSUgZm9yIDEwIHNlY29uZHMuC0Rlc2NyaXB0aW9uBkRlYnJpcwpHZXRTZXJ2aWNlB3JlcXVpcmUHTW9kdWxlcwREYXRhE1N0YXRNb2RpZmllck1hbmFnZXIFQXVkaW8KU291bmRVdGlscwAEBAAEAAAAFfsAAAAOABIA+wAAAE0AACQAAAAARwAOAAAAAAD7AAEATQAAgAEAAAD7AQAA+wICAJ8AAwH7AAEATQAAlgIAAAD7AQAAbwIDAPsDAwCfAAQBggABAAQDAQMCAwMDBAAyAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAACMwAAAAACAAYAAAAa+wAAAA4AFwD7AAAATQAAJAAAAABHABMAAAAA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

-- https://lua.expert/
local t = {
	Name = "BonBon",
	SpecialItem = true,
	AbilityOnlyItem = true,
	Rarity = "Rare",
	PointCost = 0,
	Icon = "rbxassetid://130335597602610",
	Description = "Use this item to increase extraction speed +50% and movement speed +25% for 10 seconds.",
	ItemDuration = 10
}
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatModifierManager = require(ReplicatedStorage.Modules.Data.StatModifierManager)
local SoundUtils = require(ReplicatedStorage.Modules.Audio.SoundUtils)

function t.UseItem(p1, p2, p3) --[[ UseItem | Line: 18 | Upvalues: ReplicatedStorage (copy), SoundUtils (copy), t (copy), StatModifierManager (copy), Debris (copy) ]]
	local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
	local t2 = {
		Outcome = true,
		Reason = "Bon Bon consumed successfully!"
	}

	if p1:FindFirstChild("HumanoidRootPart") then
		local v1 = ReplicatedStorage.Parts.AudioPart.UseSound:Clone()

		v1.Parent = HumanoidRootPart
		v1:Play()
		SoundUtils.SafeCleanup(v1)
	end

	local ItemDuration = t.ItemDuration

	if p3 and p3 > 0 then
		ItemDuration = ItemDuration + p3
	end

	local v2 = StatModifierManager.ApplySpeedModifiers(p1, 1.25, "BonBon", {
		category = "item",
		antiCheat = true
	})
	local v3 = StatModifierManager.ApplyModifier(p1, "DecodeSpeedModifier", 1.5, "BonBon", {
		category = "item"
	})

	task.delay(ItemDuration, function() --[[ Line: 50 | Upvalues: p1 (copy), StatModifierManager (ref), v2 (copy), v3 (copy) ]]
		if not p1 or p1.Parent == nil then
			return
		end

		StatModifierManager.RemoveSpeedModifiers(p1, v2)
		StatModifierManager.RemoveModifier(p1, "DecodeSpeedModifier", v3)
	end)

	local BuffParticle = Instance.new("Attachment")

	BuffParticle.Name = "BuffParticle"
	BuffParticle.Parent = HumanoidRootPart

	local v4 = game.ReplicatedStorage.Parts.BuffParticles.Speed.BuffParticle:Clone()

	v4.Parent = BuffParticle
	v4.Enabled = true

	local v5 = game.ReplicatedStorage.Parts.BuffParticles.Speed.Glow:Clone()

	v5.Parent = BuffParticle
	v5.Enabled = true

	local v6 = game.ReplicatedStorage.Parts.BuffParticles.DecodeSpeed.BuffParticle:Clone()

	v6.Parent = BuffParticle
	v6.Enabled = true

	local v7 = game.ReplicatedStorage.Parts.BuffParticles.DecodeSpeed.Glow:Clone()

	v7.Parent = BuffParticle
	v7.Enabled = true
	Debris:AddItem(v4, ItemDuration + 1)
	Debris:AddItem(v5, ItemDuration + 1)
	Debris:AddItem(v6, ItemDuration + 1)
	Debris:AddItem(v7, ItemDuration + 1)
	Debris:AddItem(BuffParticle, ItemDuration + 1)
	task.delay(ItemDuration, function() --[[ Line: 86 | Upvalues: p1 (copy), BuffParticle (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy) ]]
		if not p1 or (p1.Parent == nil or not BuffParticle) then
			return
		end

		v4.Enabled = false
		v5.Enabled = false
		v6.Enabled = false
		v7.Enabled = false
	end)
	p2.Value = "None"

	local v8 = workspace.Info.PlayerStats:FindFirstChild(p1.Name)

	if not v8 then
		return t2
	end

	local SurvivalPoints = v8:WaitForChild("SurvivalPoints")

	SurvivalPoints.Value = SurvivalPoints.Value + 5

	return t2
end

return t