-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthProgressBar, time of decompilation: Sun May  3 10:11:41 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)

return function(t1: {[any]: any}) -- line: 21
	-- upvalues: Vide (copy), Frame (copy), TextLabel (copy), Abbreviate (copy), ImageLabel (copy), ImageIds (copy), UICorner (copy), UIGradient (copy), UIStroke (copy)
	local v12 = Vide.derive(function() -- line: 22
		-- upvalues: Vide (copy), t1 (copy)
		return (math.clamp(Vide.read(t1.Current) / Vide.read(t1.Required), 0, 1))
	end)

	return Frame({
		Name = "RebirthProgressBar",
		Size = UDim2.fromOffset(330, 40),
		Position = UDim2.fromScale(0.09, 0.8),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		TextLabel({
			Text = "Goop Needed:",
			ZIndex = 2,
			Size = UDim2.new(1, 0, 0, 20),
			Position = UDim2.fromScale(0.07, -0.12),
			AnchorPoint = Vector2.new(0, 1),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Stroke = {}
		}),
		TextLabel({
			ZIndex = 9,
			Text = function() --[[ Text ]] -- line: 45
				-- upvalues: Abbreviate (copy), Vide (copy), t1 (copy)
				return Abbreviate(Vide.read(t1.Current)) .. "/" .. Abbreviate(Vide.read(t1.Required))
			end,
			Size = UDim2.fromScale(0.8, 0.9),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		}),
		ImageLabel({
			ZIndex = 2,
			Image = ImageIds.goop,
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
						ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 0, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 217, 255))
					}),
					Transparency = function() --[[ Transparency ]] -- line: 128
						-- upvalues: v12 (copy)
						local v13 = v12()

						if v13 == 0 then
							return NumberSequence.new(1)
						end

						if v13 >= 0.99 then
							return NumberSequence.new(0)
						end

						return NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(v13, 0),
							NumberSequenceKeypoint.new(v13 + 0.001, 1),
							NumberSequenceKeypoint.new(1, 1)
						})
					end
				})
			})
		})
	})
end
