-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Bubble = game:GetService("ReplicatedStorage").Assets.Models.Effects.Bubble

return {
	CreateBubble = function(p1, p2, p3, p4, p5) --[[ CreateBubble | Line: 10 | Upvalues: Bubble (copy), Debris (copy), TweenService (copy) ]]
		local v1 = Bubble:Clone()

		v1.CFrame = p1
		v1.Anchored = true
		v1.CanCollide = false
		v1.Massless = true
		v1.Material = Enum.Material.Glass
		v1.Size = p2
		v1.Transparency = p3
		v1.Parent = workspace.__DEBRIS
		Debris:AddItem(v1, p5)
		TweenService:Create(v1, TweenInfo.new(p5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			Transparency = 1,
			Size = p4
		}):Play()

		return v1
	end
}