-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexProgressBar, time of decompilation: Sun May  3 10:12:34 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)
local IndexRewardUtils = require(ReplicatedStorage.Source.Features.Index.IndexRewardUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function(t1: {[any]: any}) -- line: 18
	-- upvalues: Vide (copy), IndexServiceUtils (copy), IndexRewardUtils (copy), Frame (copy), TextLabel (copy), Abbreviate (copy), ImageLabel (copy), ImageIds (copy), UICorner (copy), UIGradient (copy), UIStroke (copy)
	local v14 = Vide.derive(function() -- line: 22
		-- upvalues: IndexServiceUtils (copy), t1 (copy)
		return IndexServiceUtils.getUnlockedCountFromData(t1.IndexData(), t1.CategoryId())
	end)
	local v15 = Vide.derive(function() -- line: 26
		-- upvalues: IndexRewardUtils (copy), t1 (copy)
		return (math.max(IndexRewardUtils.getRewardGoalFromData(t1.IndexData(), t1.CategoryId()), 1))
	end)
	local v16 = Vide.derive(function() -- line: 30
		-- upvalues: Vide (copy), v14 (copy), v15 (copy)
		return (math.clamp(Vide.read(v14) / Vide.read(v15), 0, 1))
	end)

	return Frame({
		Name = "RebirthProgressBar",
		Size = UDim2.fromOffset(544, 45),
		Position = UDim2.fromScale(0.06, 0.93),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		TextLabel({
			Text = "Unlocks Needed:",
			ZIndex = 2,
			Size = UDim2.new(1, 0, 0, 20),
			Position = UDim2.fromScale(0.04, -0.12),
			AnchorPoint = Vector2.new(0, 1),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Stroke = {}
		}),
		TextLabel({
			ZIndex = 9,
			Text = function() --[[ Text ]] -- line: 53
				-- upvalues: Abbreviate (copy), Vide (copy), v14 (copy), v15 (copy)
				return Abbreviate(Vide.read(v14)) .. "/" .. Abbreviate(Vide.read(v15))
			end,
			Size = UDim2.fromScale(0.8, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		}),
		ImageLabel({
			ZIndex = 2,
			Image = ImageIds.index,
			Size = UDim2.fromScale(2, 2),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Position = UDim2.fromScale(0, 0.475),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		Frame({
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0.5, 0.7),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 0,
			ZIndex = 0,
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			UICorner({
				CornerRadius = UDim.new(1, 0)
			}),
			UIGradient({
				Rotation = 90,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.7, 1),
					NumberSequenceKeypoint.new(0.85, 0),
					NumberSequenceKeypoint.new(1, 0)
				})
			})
		}),
		Frame({
			BackgroundTransparency = 0.5,
			BackgroundColor3 = Color3.fromRGB(27, 27, 27),
			Size = UDim2.fromScale(1, 1),
			UICorner({
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke({
				Thickness = 4,
				Color = Color3.fromRGB(0, 0, 0)
			}),
			UIGradient({
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(27, 27, 27)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
				})
			}),
			Frame({
				Name = "Fill",
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				UICorner({
					CornerRadius = UDim.new(1, 0)
				}),
				UIGradient({
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 191)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 102, 255))
					}),
					Transparency = function() --[[ Transparency ]] -- line: 136
						-- upvalues: v16 (copy)
						local v17 = v16()

						if v17 == 0 then
							return NumberSequence.new(1)
						end

						if v17 >= 0.99 then
							return NumberSequence.new(0)
						end

						return NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(v17, 0),
							NumberSequenceKeypoint.new(v17 + 0.001, 1),
							NumberSequenceKeypoint.new(1, 1)
						})
					end
				})
			})
		})
	})
end
