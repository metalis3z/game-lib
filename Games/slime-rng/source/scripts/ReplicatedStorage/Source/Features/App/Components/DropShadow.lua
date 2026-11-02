-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DropShadow, time of decompilation: Sun May  3 10:11:12 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

return function(p1) -- line: 7
	-- upvalues: ImageIds (copy), ImageLabel (copy)
	p1.Image = ImageIds.dropShadow
	p1.ImageColor3 = p1.ImageColor3 or Color3.fromRGB(0, 0, 0)

	return ImageLabel(p1)
end
