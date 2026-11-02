-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NotificationBadge, time of decompilation: Sun May  3 10:11:13 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local useSetting = require(ReplicatedStorage.Source.Features.Settings.UI.Hooks.useSetting)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)

return function(t1: {[any]: any}) -- line: 23
	-- upvalues: Vide (copy), useSetting (copy), Frame (copy), ImageLabel (copy), ImageIds (copy), UIGradient (copy), UICorner (copy), UIStroke (copy), TextLabel (copy)
	local v12 = useSetting("showNotificationDots")
	local v13 = Vide.source(UDim2.fromScale(1, 1))
	local v14, v15 = Vide.spring(v13, 0.2, 0.8)
	local v16 = Vide.source(UDim2.fromScale(5, 5))
	local v17, v18 = Vide.spring(v16, 0.2, 0.8)
	local v19 = Vide.source(1)
	local v20, v21 = Vide.spring(v19, 0.2, 0.8)

	local function pulse() -- line: 36
		-- upvalues: v15 (copy), v18 (copy), v21 (copy)
		v15({
			impulse = UDim2.fromScale(70, 70)
		})
		v18({
			position = UDim2.fromScale(0, 0)
		})
		v21({
			position = 0.55
		})
		task.wait(0.3)
		v15({
			impulse = UDim2.fromScale(50, 50)
		})
		v18({
			position = UDim2.fromScale(0, 0)
		})
		v21({
			position = 0.55
		})
	end

	local thread = task.spawn(function() -- line: 46
		-- upvalues: pulse (copy)
		while true do
			task.wait(math.random(30, 70) / 10)
			pulse()
		end
	end)

	Vide.cleanup(function() -- line: 53
		-- upvalues: thread (copy)
		task.cancel(thread)
	end)

	return Frame({
		Name = "NotificationBadge",
		Size = t1.Size or UDim2.fromOffset(34, 34),
		Position = t1.Position or UDim2.fromScale(1, 0.05),
		AnchorPoint = t1.AnchorPoint or Vector2.new(1, 0),
		ZIndex = t1.ZIndex or 5,
		Visible = function() --[[ Visible ]] -- line: 63
			-- upvalues: Vide (copy), t1 (copy), v12 (copy)
			return math.max(0, Vide.read(t1.Count)) > 0 and v12()
		end,
		Frame({
			Size = v14,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ImageLabel({
				Name = "Pulse",
				BackgroundTransparency = 1,
				ZIndex = 0,
				ImageColor3 = Color3.fromRGB(255, 56, 89),
				Image = ImageIds.ringBlur,
				ScaleType = Enum.ScaleType.Fit,
				Size = v17,
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ImageTransparency = v20
			}),
			Frame({
				BackgroundTransparency = 0,
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				UIGradient({
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(228, 71, 118)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(206, 0, 34))
					})
				}),
				UICorner({
					CornerRadius = UDim.new(1, 0)
				}),
				UIStroke({
					Thickness = 3,
					Color = Color3.fromRGB(56, 0, 14)
				})
			}),
			TextLabel({
				Size = UDim2.fromScale(1, 1),
				Text = function() --[[ Text ]] -- line: 107
					-- upvalues: t1 (copy), Vide (copy)
					if t1.Text ~= nil then
						return Vide.read(t1.Text)
					end

					local v24 = math.max(0, Vide.read(t1.Count))

					if v24 > 99 then
						return "99+"
					end

					return (tostring(v24))
				end,
				Stroke = {
					Thickness = 2
				}
			})
		})
	})
end
