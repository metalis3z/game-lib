-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Pointer, time of decompilation: Sun May  3 10:12:01 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

return function(p1) -- line: 7
	-- upvalues: Frame (copy), ImageLabel (copy)
	return Frame({
		Name = p1.Name or "Pointer",
		Size = UDim2.fromOffset(160, 160),
		Position = p1.Position,
		Visible = p1.Visible,
		ZIndex = 2147483647,
		AnchorPoint = p1.AnchorPoint or Vector2.new(0.5, 0.5),
		Rotation = p1.Rotation,
		ImageLabel({
			Name = "Sprite",
			Image = "rbxassetid://12638631531",
			Size = UDim2.fromScale(1, 1),
			ImageRectSize = Vector2.new(128, 128),
			ImageRectOffset = Vector2.zero
		})
	})
end
