-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ZonesRoot, time of decompilation: Sun May  3 10:11:53 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local ZoneHudState = require(ReplicatedStorage.Source.Features.Zones.ZoneHudState)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

return function() -- line: 14
	-- upvalues: Vide (copy), ZoneHudState (copy), SlideFrame (copy), Frame (copy), UIListLayout (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy)
	local v10 = Vide.source(false)
	local u11 = ZoneHudState.enterBurst()
	local u12 = nil

	Vide.effect(function() -- line: 19
		-- upvalues: ZoneHudState (copy), u11 (ref), v10 (copy), u12 (ref)
		local v13 = ZoneHudState.enterBurst()
		local v14 = ZoneHudState.enteredZoneName()

		if v13 == u11 or v14 == "" then
			return
		end

		u11 = v13
		v10(true)

		if u12 then
			task.cancel(u12)
			u12 = nil
		end

		u12 = task.delay(2.4, function() -- line: 34
			-- upvalues: u12 (ref), v10 (copy)
			u12 = nil
			v10(false)
		end)
	end)
	Vide.cleanup(function() -- line: 40
		-- upvalues: u12 (ref)
		if u12 then
			task.cancel(u12)
			u12 = nil
		end
	end)

	return SlideFrame({
		Name = "ZonesRoot",
		Shown = v10,
		CanStartShown = false,
		Size = UDim2.fromOffset(520, 54),
		ShownPosition = UDim2.fromScale(0.5, 0.045),
		HiddenPosition = UDim2.fromScale(0.5, -0.18),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		ZIndex = 10,
		Frame({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 18)
			}),
			ImageLabel({
				Name = "RollDividerLeft",
				LayoutOrder = 1,
				ZIndex = 10,
				Image = ImageIds.rollDivider,
				Size = UDim2.fromOffset(126, 31)
			}),
			TextLabel({
				Name = "ZoneName",
				LayoutOrder = 2,
				TextSize = 32,
				ZIndex = 10,
				Text = function() --[[ Text ]] -- line: 81
					-- upvalues: ZoneHudState (copy)
					return ZoneHudState.enteredZoneName()
				end,
				Size = UDim2.fromOffset(220, 40),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Font = Enum.Font.BuilderSansExtraBold,
				Stroke = {
					Thickness = 2.5
				},
				DropShadow = {
					Transparency = 0.15,
					Offset = UDim2.fromOffset(0, 4)
				}
			}),
			Frame({
				Size = UDim2.fromOffset(126, 31),
				LayoutOrder = 3,
				ZIndex = 10,
				ImageLabel({
					Name = "RollDividerRight",
					Rotation = 180,
					Image = ImageIds.rollDivider,
					Size = UDim2.fromScale(1, 1)
				})
			})
		})
	})
end
