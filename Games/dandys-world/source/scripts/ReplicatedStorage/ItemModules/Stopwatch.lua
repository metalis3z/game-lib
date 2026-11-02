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
-- CQNEBlBhcmVudAdFbmFibGVkCEluc3RhbmNlA25ldwpBdHRhY2htZW50DEJ1ZmZQYXJ0aWNsZQROYW1lBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UFUGFydHMNQnVmZlBhcnRpY2xlcwpTa2lsbENoZWNrBUNsb25lBEdsb3cMSXRlbUR1cmF0aW9uB0FkZEl0ZW0EdGFzawVkZWxheRlBcHBseUFkZGl0aXZlQm91bmRhcnlTaXplCVN0b3B3YXRjaAR3YWl0GlJlbW92ZUFkZGl0aXZlQm91bmRhcnlTaXplBVN0YXRzDFdhaXRGb3JDaGlsZA5DdXJyZW50U3RhbWluYQdTdGFtaW5hCEh1bWFub2lkCVNwcmludGluZw1TcGVlZE1vZGlmaWVyDEJvdW5kYXJ5U2l6ZQhSdW5TcGVlZAlXYWxrU3BlZWQIRGVjb2RpbmcFVmFsdWUHT3V0Y29tZQZSZWFzb24xSXRlbSBjYW4gb25seSBiZSB1c2VkIHdoaWxlIGV4dHJhY3RpbmcgYSBNYWNoaW5lISRDYW4ndCB1c2UgdGhhdCBpdGVtIGF0IGZ1bGwgU3RhbWluYSEQSHVtYW5vaWRSb290UGFydA5GaW5kRmlyc3RDaGlsZAZzY3JpcHQIVXNlU291bmQEUGxheQtTYWZlQ2xlYW51cAVzcGF3bgROb25lCXdvcmtzcGFjZQRJbmZvC1BsYXllclN0YXRzDlN1cnZpdmFsUG9pbnRzB1VzZUl0ZW0JUG9pbnRDb3N0DkRhbmR5U3RvcmVJdGVtCUZsb29ySXRlbQZDb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzcyODY3MDIwMgRJY29uR1VzZSB0aGlzIGl0ZW0gdG8gaW5jcmVhc2UgU2tpbGwgQ2hlY2sgd2luZG93IHNpemUgYnkgNTAgZm9yIDE1IHNlY29uZHMuC0Rlc2NyaXB0aW9uBkRlYnJpcwpHZXRTZXJ2aWNlB3JlcXVpcmUHTW9kdWxlcwREYXRhE1N0YXRNb2RpZmllck1hbmFnZXIFQXVkaW8KU291bmRVdGlscwAFAgAEAAAAEvsAAAAOAA8A+wAAAE0AACQAAAAARwALAAAAAAD7AAEADgAIAPsAAgCpAQAAMAEA8AEAAAD7AAMAqQEAADABAPABAAAAggABAAIDAQMC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

-- https://lua.expert/
local t = {
	Name = "Stopwatch",
	PointCost = 18,
	DandyStoreItem = true,
	FloorItem = false,
	Rarity = "Common",
	Icon = "rbxassetid://17728670202",
	Description = "Use this item to increase Skill Check window size by 50 for 15 seconds.",
	ItemDuration = 15
}
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatModifierManager = require(ReplicatedStorage.Modules.Data.StatModifierManager)
local SoundUtils = require(ReplicatedStorage.Modules.Audio.SoundUtils)

function t.UseItem(p1, p2) --[[ UseItem | Line: 18 | Upvalues: SoundUtils (copy), Debris (copy), t (copy), StatModifierManager (copy) ]]
	local Stats = p1:WaitForChild("Stats")

	Stats:WaitForChild("CurrentStamina")
	Stats:WaitForChild("Stamina")
	p1:WaitForChild("Humanoid")
	Stats:WaitForChild("Sprinting")
	Stats:WaitForChild("SpeedModifier")
	Stats:WaitForChild("BoundarySize")
	Stats:WaitForChild("RunSpeed")
	Stats:WaitForChild("WalkSpeed")

	if p1:WaitForChild("Decoding").Value == nil then
		return {
			Outcome = false,
			Reason = "Item can only be used while extracting a Machine!"
		}
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
		task.spawn(function() --[[ Line: 48 | Upvalues: HumanoidRootPart (copy), Debris (ref), t (ref), p1 (copy) ]]
			local BuffParticle = Instance.new("Attachment")

			BuffParticle.Name = "BuffParticle"
			BuffParticle.Parent = HumanoidRootPart

			local v1 = game.ReplicatedStorage.Parts.BuffParticles.SkillCheck.BuffParticle:Clone()

			v1.Parent = BuffParticle
			v1.Enabled = true

			local v2 = game.ReplicatedStorage.Parts.BuffParticles.SkillCheck.Glow:Clone()

			v2.Parent = BuffParticle
			v2.Enabled = true
			Debris:AddItem(v1, t.ItemDuration + 1)
			Debris:AddItem(v2, t.ItemDuration + 1)
			Debris:AddItem(BuffParticle, t.ItemDuration + 1)
			task.delay(t.ItemDuration, function() --[[ Line: 61 | Upvalues: p1 (ref), BuffParticle (copy), v1 (copy), v2 (copy) ]]
				if not p1 or (p1.Parent == nil or not BuffParticle) then
					return
				end

				v1.Enabled = false
				v2.Enabled = false
			end)
		end)
	end

	task.spawn(function() --[[ Line: 69 | Upvalues: StatModifierManager (ref), p1 (copy), t (ref) ]]
		local v1 = StatModifierManager.ApplyAdditiveBoundarySize(p1, 50, "Stopwatch")

		task.wait(t.ItemDuration)
		StatModifierManager.RemoveAdditiveBoundarySize(p1, v1)
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