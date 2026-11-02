-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: InstructionLabel, time of decompilation: Sun May  3 10:12:01 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)

return function(t1: {[any]: any}) -- line: 13
	-- upvalues: Vide (copy), AutoScaledFrame (copy), DropShadow (copy), TextLabel (copy)
	local v7 = Vide.source(1)
	local v8, v9 = Vide.spring(v7, 0.22, 0.55)
	local u10 = nil

	Vide.effect(function() -- line: 18
		-- upvalues: Vide (copy), t1 (copy), u10 (ref), v9 (copy)
		local v11 = Vide.read(t1.Text) or ""

		if not Vide.read(t1.Visible) then
			v11 = ""
		end

		if v11 == u10 then
			return
		end

		u10 = v11
		v9({
			position = 0
		})
	end)

	return AutoScaledFrame({
		Name = "TutorialInstruction",
		Size = UDim2.fromOffset(1000, 88),
		Position = UDim2.fromScale(0.5, 0.2),
		AnchorPoint = Vector2.new(0.5, 0),
		Visible = t1.Visible,
		ZIndex = 500,
		Vide.create("UIScale")({
			Scale = v8
		}),
		DropShadow({
			ZIndex = 499,
			ImageTransparency = 0.45,
			Size = UDim2.fromOffset(500, 100),
			Position = UDim2.fromScale(0.5, 0.55),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}),
		TextLabel({
			Name = "InstructionText",
			TextWrapped = true,
			TextSize = 50,
			ZIndex = 501,
			Text = t1.Text,
			Size = UDim2.new(1, -36, 1, -26),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			},
			DropShadow = {
				Offset = UDim2.fromOffset(0, 4)
			}
		})
	})
end
