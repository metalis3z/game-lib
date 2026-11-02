-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: StylizedButton, time of decompilation: Sun May  3 10:11:11 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
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
	}
}

return function(p1) -- line: 45
	-- upvalues: RemoveKeys (copy), t1 (copy), Vide (copy), t2 (copy), TextLabel (copy), Button (copy)
	local v9 = RemoveKeys(p1, t1)

	v9.ScaleType = Enum.ScaleType.Slice
	v9.SliceCenter = Rect.new(22, 52, 112, 52)
	v9.Image = if type(p1.Theme) ~= "function" then t2[p1.Theme].image else Vide.derive(function() -- line: 51
		-- upvalues: t2 (copy), p1 (copy)
		return t2[p1.Theme()].image
	end)

	if p1.Text then
		table.insert(v9, (TextLabel({
			Text = p1.Text,
			Size = UDim2.fromScale(0.85, 0.6),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.425),
			Stroke = {},
			DropShadow = {}
		})))
	end

	return Button(v9)
end
