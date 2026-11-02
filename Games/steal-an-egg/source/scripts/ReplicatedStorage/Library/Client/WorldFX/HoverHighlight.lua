-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)

return {
	FadeIn = function(p1, p2, p3) --[[ FadeIn | Line: 20 | Upvalues: Asserts (copy), Tween (copy) ]]
		Asserts.Model(p1)
		Asserts.string(p2)
		Asserts.optional.number(p3)

		local Highlight = Instance.new("Highlight")

		Highlight.Name = p2
		Highlight.Adornee = p1
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
		Highlight.FillTransparency = 1
		Highlight.OutlineColor = Color3.new(255/255, 255/255, 255/255)
		Highlight.OutlineTransparency = 1
		Highlight.Parent = p1
		Tween(Highlight, {
			OutlineTransparency = 0
		}, { p3 or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

		return Highlight
	end,
	FadeOut = function(p1, p2) --[[ FadeOut | Line: 44 | Upvalues: Asserts (copy), Tween (copy) ]]
		assert(p1:IsA("Highlight"), "Expected Highlight")
		Asserts.optional.number(p2)
		Tween(p1, {
			OutlineTransparency = 1
		}, { p2 or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }).Completed:Once(function(p12) --[[ Line: 52 | Upvalues: p1 (copy) ]]
			if p12 ~= Enum.PlaybackState.Completed then
				return
			end

			p1:Destroy()
		end)
	end
}