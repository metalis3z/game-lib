-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TextNotifications, time of decompilation: Sun May  3 10:11:59 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ConfettiSequence = require(ReplicatedStorage.Source.Core.UI.Components.ConfettiSequence)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local indexes = Vide.indexes
local color3 = Color3.fromRGB(255, 255, 255)
local color3_2 = Color3.fromRGB(0, 0, 0)
local v12 = Vide.source({})
local v13 = Vide.source(0)
local n1 = 0

local function TextNotification(p1, n2: number, p2) -- line: 47
	-- upvalues: Vide (copy), v12 (copy), Frame (copy), UICorner (copy), UIGradient (copy), TextLabel (copy)
	local v22 = Vide.source(0)
	local v23 = Vide.spring(v22, 0.24, 0.8)
	local u24 = nil

	u24 = task.delay(p1().duration, function() -- line: 55
		-- upvalues: n2 (copy), v12 (copy), u24 (ref)
		local v29 = n2
		local v30 = v12()

		if v30[v29] ~= nil then
			local v31 = table.clone(v30)

			v31[v29] = nil
			v12(v31)
		end

		u24 = nil
	end)
	Vide.effect(function() -- line: 60
		-- upvalues: v22 (copy), p2 (copy)
		v22(not p2() and 0 or 1)
	end)
	Vide.cleanup(function() -- line: 64
		-- upvalues: u24 (ref)
		if u24 then
			task.cancel(u24)
			u24 = nil
		end
	end)

	return Frame({
		Name = "TextNotification",
		LayoutOrder = n2,
		Size = function() --[[ Size ]] -- line: 74
			-- upvalues: v23 (copy)
			return UDim2.fromScale(v23(), v23())
		end,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 2147483647,
		UICorner({
			CornerRadius = UDim.new(0, 12)
		}),
		UIGradient({
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.2, 0.45),
				NumberSequenceKeypoint.new(0.8, 0.45),
				NumberSequenceKeypoint.new(1, 1)
			})
		}),
		TextLabel({
			TextWrapped = true,
			ZIndex = 2147483648,
			Text = function() --[[ Text ]] -- line: 97
				-- upvalues: p1 (copy)
				return p1().message
			end,
			Size = UDim2.fromScale(1, 1),
			TextColor3 = function() --[[ TextColor3 ]] -- line: 101
				-- upvalues: p1 (copy)
				return p1().color
			end,
			Stroke = {
				Thickness = 2,
				Color = function() --[[ Color ]] -- line: 106
					-- upvalues: p1 (copy)
					return p1().strokeColor
				end
			},
			DropShadow = {}
		})
	}), 0.35
end

return {
	Component = function() --[[ Component ]] -- line: 118
		-- upvalues: indexes (copy), v12 (copy), TextNotification (copy), Frame (copy), ConfettiSequence (copy), v13 (copy), UIListLayout (copy)
		local v25 = indexes(v12, TextNotification)

		return Frame({
			Name = "TextNotifications",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Visible = function() --[[ Visible ]] -- line: 125
				-- upvalues: v25 (copy)
				return next(v25()) ~= nil
			end,
			ZIndex = 2147483647,
			ConfettiSequence({
				Name = "TextNotificationConfetti",
				ZIndex = 2147483647,
				Trigger = v13
			}),
			Frame({
				Name = "TextNotificationList",
				Size = UDim2.new(0.62, 0, 0, 36),
				Position = UDim2.fromScale(0.5, 0.3),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ZIndex = 2147483647,
				v25,
				UIListLayout({
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0.18, 0)
				})
			})
		})
	end,
	add = function(s1: string, t1: {[any]: any}?) --[[ add ]] -- line: 156
		-- upvalues: n1 (ref), v12 (copy), color3 (copy), color3_2 (copy), v13 (copy)
		n1 += 1

		local v28 = table.clone(v12())

		v28[n1] = {
			message = s1,
			color = if not t1 or not t1.Color then color3 else t1.Color,
			strokeColor = if not t1 or not t1.StrokeColor then color3_2 else t1.StrokeColor,
			duration = (not t1 or not t1.Duration) and 3 or t1.Duration
		}
		v12(v28)

		if t1 and t1.Confetti then
			v13(v13() + 1)
		end
	end
}
