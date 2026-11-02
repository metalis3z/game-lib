-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BonusRollIcon, time of decompilation: Sun May  3 10:11:48 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

return function(p1, p2) -- line: 7
	-- upvalues: ImageLabel (copy), ImageIds (copy)
	return ImageLabel({
		Image = ImageIds.bonusRoll,
		ScaleType = Enum.ScaleType.Fit,
		ImageTransparency = p1,
		Visible = p2,
		Size = UDim2.fromScale(1.5, 1.5),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
end
