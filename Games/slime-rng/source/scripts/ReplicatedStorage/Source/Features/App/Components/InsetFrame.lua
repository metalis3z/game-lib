-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: InsetFrame, time of decompilation: Sun May  3 10:11:15 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

return function(p1) -- line: 7
	-- upvalues: ImageIds (copy), ImageLabel (copy)
	p1.Image = ImageIds.insetFrame
	p1.ScaleType = Enum.ScaleType.Slice
	p1.SliceCenter = Rect.new(31, 33, 109, 99)
	p1.BackgroundTransparency = 1

	return ImageLabel(p1)
end
