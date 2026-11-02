-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: StylizedFrame, time of decompilation: Sun May  3 10:11:15 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local t1 = {
	"Theme",
	"Text"
}
local t2 = {
	Grey = {
		image = "rbxassetid://127446443729865",
		stroke = Color3.fromRGB(27, 27, 27)
	},
	Red = {
		image = "rbxassetid://117084978551905",
		stroke = Color3.fromRGB(49, 0, 0)
	},
	Purple = {
		image = "rbxassetid://75346135535600",
		stroke = Color3.fromRGB(49, 0, 49)
	},
	Pink = {
		image = "rbxassetid://130986441300365",
		stroke = Color3.fromRGB(49, 0, 49)
	},
	Green = {
		image = "rbxassetid://109899764114277",
		stroke = Color3.fromRGB(0, 49, 0)
	},
	DarkBlue = {
		image = "rbxassetid://105970898742441",
		stroke = Color3.fromRGB(0, 0, 49)
	},
	Blue = {
		image = "rbxassetid://82138502446542",
		stroke = Color3.fromRGB(0, 0, 49)
	},
	Black = {
		image = ImageIds.blackFrame
	},
	Yellow = {
		image = "rbxassetid://96110572215658",
		stroke = Color3.fromRGB(49, 49, 0)
	},
	DarkGreen = {
		image = "rbxassetid://74894191305747",
		stroke = Color3.fromRGB(0, 49, 0)
	},
	Orange = {
		image = "rbxassetid://87837059786121",
		stroke = Color3.fromRGB(49, 27, 0)
	}
}

return function(p1) -- line: 60
	-- upvalues: RemoveKeys (copy), t1 (copy), t2 (copy), Vide (copy), ImageLabel (copy)
	local v9 = RemoveKeys(p1, t1)

	v9.ScaleType = Enum.ScaleType.Slice
	v9.SliceCenter = Rect.new(22, 52, 112, 52)

	function v9.Image() -- line: 64
		-- upvalues: t2 (copy), Vide (copy), p1 (copy)
		return t2[Vide.read(p1.Theme)].image
	end

	return ImageLabel(v9)
end
