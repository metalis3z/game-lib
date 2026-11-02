-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LuckRollIcon, time of decompilation: Sun May  3 10:11:48 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	[1] = Color3.fromRGB(0, 255, 55),
	[2] = Color3.fromRGB(0, 217, 255),
	[3] = Color3.fromRGB(195, 0, 255),
	[4] = Color3.fromRGB(255, 123, 0),
	[5] = Color3.fromRGB(255, 0, 0)
}

return function(p1, p2) -- line: 18
	-- upvalues: Vide (copy), ImageIds (copy), t1 (copy), Frame (copy), ImageLabel (copy), TextLabel (copy)
	local v10 = Vide.source(1)
	local v11 = Vide.source(ImageIds.luckIcons[1])
	local v12 = Vide.source(t1[1])

	Vide.effect(function() -- line: 23
		-- upvalues: p1 (copy), v10 (copy), v11 (copy), ImageIds (copy), v12 (copy), t1 (copy)
		local v13 = p1()

		if type(v13) == "table" and v13.kind == "LUCK" then
			v10(v13.multiplier)

			local v14 = math.log(v13.multiplier, 2)

			v11(ImageIds.luckIcons[v14] or ImageIds.luckIcons[#ImageIds.luckIcons])
			v12(t1[v14] or t1[#t1])
		end
	end)

	return Frame({
		Size = UDim2.fromScale(1, 1),
		ImageLabel({
			Image = v11,
			ImageTransparency = p2,
			Size = UDim2.fromScale(1, 1)
		}),
		ImageLabel({
			ZIndex = 0,
			Image = v11,
			ImageTransparency = function() --[[ ImageTransparency ]] -- line: 44
				-- upvalues: p2 (copy)
				return 0.5 + 0.5 * p2()
			end,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0, 0.1),
			ImageColor3 = Color3.fromRGB(0, 0, 0)
		}),
		TextLabel({
			ZIndex = 2,
			Text = function() --[[ Text ]] -- line: 55
				-- upvalues: v10 (copy)
				return v10() .. "X"
			end,
			TextTransparency = p2,
			Size = UDim2.fromScale(1, 0.4),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3,
				Transparency = p2
			},
			DropShadow = {
				Transparency = function() --[[ Transparency ]] -- line: 65
					-- upvalues: p2 (copy)
					return 1 - 0.5 * (1 - p2())
				end
			},
			Gradient = {
				Rotation = 90,
				Color = function() --[[ Color ]] -- line: 71
					-- upvalues: v12 (copy)
					return ColorSequence.new(Color3.fromRGB(255, 255, 255), v12())
				end
			}
		})
	})
end
