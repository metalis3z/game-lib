-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Notifications, time of decompilation: Sun May  3 10:11:58 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local create = Vide.create
local indexes = Vide.indexes
local n1 = 0
local v13 = Vide.source({})

local function NotificationCard(p1, s1: string, p2) -- line: 51
	-- upvalues: Vide (copy), v13 (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), Abbreviate (copy)
	local v25 = Vide.source(0)
	local v26 = Vide.spring(v25, 0.26, 0.76)
	local u27 = nil

	u27 = task.delay(5, function() -- line: 55
		-- upvalues: s1 (copy), v13 (copy), u27 (ref)
		local v29 = s1
		local v30 = v13()

		if v30[v29] ~= nil then
			local v31 = table.clone(v30)

			v31[v29] = nil
			v13(v31)
		end

		u27 = nil
	end)
	Vide.effect(function() -- line: 60
		-- upvalues: v25 (copy), p2 (copy)
		v25(not p2() and 0 or 1)
	end)
	Vide.cleanup(function() -- line: 64
		-- upvalues: u27 (ref)
		if u27 then
			task.cancel(u27)
			u27 = nil
		end
	end)

	return ImageLabel({
		Name = "Notification_" .. s1,
		Image = ImageIds.blackCheckeredButton,
		ScaleType = Enum.ScaleType.Fit,
		Size = function() --[[ Size ]] -- line: 75
			-- upvalues: v26 (copy)
			return UDim2.fromScale(v26(), v26())
		end,
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		LayoutOrder = tonumber(s1) or 0,
		ClipsDescendants = true,
		ImageLabel({
			Name = "ItemImage",
			Image = function() --[[ Image ]] -- line: 84
				-- upvalues: p1 (copy)
				return p1().Image
			end,
			Size = UDim2.fromScale(0.72, 0.72),
			Position = UDim2.fromScale(0.5, 0.42),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			Name = "Amount",
			Text = function() --[[ Text ]] -- line: 95
				-- upvalues: Abbreviate (copy), p1 (copy)
				return "x" .. Abbreviate(p1().Amount)
			end,
			Size = UDim2.fromScale(0.94, 0.26),
			Position = UDim2.fromScale(0.5, 0.7),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 2,
				Color = Color3.new(0, 0, 0)
			},
			DropShadow = {}
		})
	}), 0.35
end
local function Component() -- line: 111
	-- upvalues: indexes (copy), v13 (copy), NotificationCard (copy), AutoScaledFrame (copy), create (copy)
	local v28 = indexes(v13, NotificationCard)

	return AutoScaledFrame({
		Name = "Notifications",
		Size = UDim2.fromOffset(1000, 100),
		Position = UDim2.fromScale(0.5, 0.7),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 999999,
		BackgroundTransparency = 1,
		Visible = function() --[[ Visible ]] -- line: 121
			-- upvalues: v28 (copy)
			return next(v28()) ~= nil
		end,
		create("UIListLayout")({
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4)
		}),
		v28
	})
end

return {
	addNotification = function(t1: {[any]: any}) --[[ addNotification ]] -- line: 37
		-- upvalues: SoundController (copy), Sounds (copy), n1 (ref), v13 (copy)
		SoundController:Play(Sounds.ui.notification)
		n1 += 1

		local str = tostring(n1)
		local v21 = table.clone(v13())

		v21[str] = {
			Image = t1.Image,
			Amount = t1.Amount,
			id = str
		}
		v13(v21)
	end,
	Component = Component,
	Screen = Component
}
