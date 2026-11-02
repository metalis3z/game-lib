-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SpecialRollStatusIcon, time of decompilation: Sun May  3 10:11:51 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)

local function getFillTransparency(n1: number) -- line: 23
	local v10 = math.clamp(n1, 0, 1)

	if v10 <= 0 then
		return NumberSequence.new(1)
	end

	if v10 >= 1 then
		return NumberSequence.new(0)
	end

	local v11 = 1 - v10

	return NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(v11, 1),
		NumberSequenceKeypoint.new(math.min(v11 + 0.001, 1), 0),
		NumberSequenceKeypoint.new(1, 0)
	})
end

return function(t1: {[any]: any}) -- line: 41
	-- upvalues: Button (copy), Frame (copy), ImageLabel (copy), Vide (copy), UIGradient (copy), getFillTransparency (copy), TextLabel (copy)
	return Button({
		Name = t1.Name or "SpecialRollStatusIcon",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = t1.Position,
		Size = UDim2.fromOffset(42, 46),
		Visible = t1.Visible,
		ZIndex = 7,
		Activated = t1.Activated,
		HoverScale = 1,
		Frame({
			Name = "IconFrame",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageLabel({
				Name = "Base",
				Image = t1.Image,
				Size = UDim2.fromScale(1, 1),
				ImageColor3 = function() --[[ ImageColor3 ]] -- line: 62
					-- upvalues: Vide (copy), t1 (copy)
					if Vide.read(t1.Paused) then
						return (Color3.fromRGB(120, 120, 120))
					end

					return (Color3.fromRGB(90, 90, 90))
				end
			}),
			ImageLabel({
				Name = "Fill",
				Image = t1.Image,
				Size = UDim2.fromScale(1, 1),
				ImageTransparency = function() --[[ ImageTransparency ]] -- line: 71
					-- upvalues: Vide (copy), t1 (copy)
					if Vide.read(t1.Paused) and not Vide.read(t1.Active) then
						return 0.45
					end

					return 0
				end,
				UIGradient({
					Rotation = 90,
					Transparency = function() --[[ Transparency ]] -- line: 76
						-- upvalues: Vide (copy), t1 (copy), getFillTransparency (copy)
						if Vide.read(t1.Active) then
							return NumberSequence.new(0)
						end

						return getFillTransparency(Vide.read(t1.Progress))
					end
				})
			}),
			TextLabel({
				Name = "Counter",
				TextSize = 16,
				ZIndex = 9,
				Visible = function() --[[ Visible ]] -- line: 87
					-- upvalues: Vide (copy), t1 (copy)
					return Vide.read(t1.ShowCounter)
				end,
				Size = UDim2.fromScale(0.9, 0.46),
				Position = UDim2.fromScale(0.5, 0.72),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = function() --[[ Text ]] -- line: 93
					-- upvalues: Vide (copy), t1 (copy)
					return (tostring(Vide.read(t1.RollsUntilNext)))
				end,
				TextColor3 = function() --[[ TextColor3 ]] -- line: 96
					-- upvalues: Vide (copy), t1 (copy)
					if Vide.read(t1.Paused) then
						return (Color3.fromRGB(255, 146, 146))
					end

					return (Color3.fromRGB(255, 255, 255))
				end,
				Stroke = {
					Thickness = 2
				}
			}),
			TextLabel({
				Name = "PauseBadge",
				Text = "||",
				TextSize = 14,
				ZIndex = 10,
				Visible = function() --[[ Visible ]] -- line: 110
					-- upvalues: Vide (copy), t1 (copy)
					return Vide.read(t1.Paused) and not Vide.read(t1.Active)
				end,
				Size = UDim2.fromOffset(18, 12),
				Position = UDim2.fromScale(0.8, 0.18),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextColor3 = Color3.fromRGB(255, 130, 130),
				Stroke = {
					Thickness = 2
				}
			})
		})
	})
end
