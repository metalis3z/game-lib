-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeHoverInfo, time of decompilation: Sun May  3 10:11:37 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local UpgradeCounterUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeCounterUtils)
local UpgradeServiceClient = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceClient)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UpgradeUIUtils = require(script.Parent.UpgradeUIUtils)

return function(p1, p2, p3, p4) -- line: 17
	-- upvalues: Vide (copy), UpgradeUIUtils (copy), UpgradeCounterUtils (copy), Frame (copy), UpgradeSlice (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), CurrencyLabel (copy), StylizedButton (copy), UpgradeServiceClient (copy)
	local v17 = Vide.derive(function() -- line: 18
		-- upvalues: UpgradeUIUtils (copy), p4 (copy)
		return UpgradeUIUtils.isTouchPreferred(p4())
	end)
	local v18 = Vide.derive(function() -- line: 21
		-- upvalues: p1 (copy), p2 (copy)
		local v20 = p1()

		return v20 ~= nil and p2()[v20.id]
	end)
	local v19 = Vide.derive(function() -- line: 25
		-- upvalues: p1 (copy), UpgradeCounterUtils (copy), p2 (copy), p3 (copy)
		local v21 = p1()

		if not v21 then
			return false
		end

		return UpgradeCounterUtils.canPurchase(v21, p2() or {}, p3)
	end)

	return Frame({
		Name = "UpgradeHoverInfo",
		Visible = function() --[[ Visible ]] -- line: 36
			-- upvalues: p1 (copy), UpgradeSlice (copy)
			local v22 = p1()

			return v22 ~= nil and (not v22.tree and (UpgradeSlice.shown() and not UpgradeSlice.moving()))
		end,
		Size = function() --[[ Size ]] -- line: 40
			-- upvalues: v17 (copy), v18 (copy), UpgradeUIUtils (copy)
			if v17() and not v18() then
				return (UDim2.fromOffset(UpgradeUIUtils.HOVER_INFO_WIDTH, UpgradeUIUtils.HOVER_INFO_MOBILE_HEIGHT))
			end

			return (UDim2.fromOffset(UpgradeUIUtils.HOVER_INFO_WIDTH, UpgradeUIUtils.HOVER_INFO_HEIGHT))
		end,
		Position = function() --[[ Position ]] -- line: 45
			-- upvalues: p1 (copy), UpgradeUIUtils (copy)
			local v23 = p1()

			if not v23 then
				return UDim2.fromScale(0.5, 0.5)
			end

			return UpgradeUIUtils.getHoverPanelPosition(v23)
		end,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 20,
		ImageLabel({
			Name = "Background",
			Image = ImageIds.blackFrame,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = UpgradeUIUtils.HOVER_FRAME_SLICE,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 20,
			Frame({
				Name = "Content",
				Size = UDim2.new(1, -24, 1, -24),
				Position = UDim2.new(0.5, 0, 0, 12),
				AnchorPoint = Vector2.new(0.5, 0),
				ZIndex = 21,
				TextLabel({
					Name = "UpgradeName",
					TextSize = 28,
					TextWrapped = true,
					ZIndex = 21,
					Text = function() --[[ Text ]] -- line: 74
						-- upvalues: p1 (copy)
						local v24 = p1()

						if v24 then
							return (string.upper(v24.name))
						end

						return ""
					end,
					Size = UDim2.new(1, -20, 0, 34),
					Position = UDim2.fromOffset(10, 4),
					Stroke = {},
					DropShadow = {}
				}),
				TextLabel({
					Name = "UpgradeDescription",
					TextSize = 24,
					TextWrapped = true,
					ZIndex = 21,
					Text = function() --[[ Text ]] -- line: 89
						-- upvalues: p1 (copy), UpgradeUIUtils (copy)
						local v25 = p1()

						if v25 then
							return (UpgradeUIUtils.getUpgradeDescription(v25))
						end

						return ""
					end,
					Size = UDim2.new(1, -20, 0, 48),
					Position = UDim2.fromOffset(10, 38),
					Stroke = {}
				}),
				CurrencyLabel({
					Name = "UpgradeCost",
					RedIfInsufficient = true,
					TextSize = 24,
					ZIndex = 21,
					Visible = function() --[[ Visible ]] -- line: 103
						-- upvalues: p1 (copy), UpgradeUIUtils (copy), p2 (copy)
						local v26 = p1()

						return v26 ~= nil and (v26.cost ~= nil and (not UpgradeUIUtils.isFreeUpgrade(v26) and not p2()[v26.id]))
					end,
					Currency = function() --[[ Currency ]] -- line: 110
						-- upvalues: p1 (copy)
						local v27 = p1()

						if v27 and v27.cost then
							return v27.cost.currency
						end

						return "coins"
					end,
					Amount = function() --[[ Amount ]] -- line: 114
						-- upvalues: UpgradeUIUtils (copy), p1 (copy)
						return UpgradeUIUtils.getActiveUpgradeCostAmount(p1)
					end,
					Position = function() --[[ Position ]] -- line: 118
						-- upvalues: v17 (copy)
						if v17() then
							return (UDim2.new(0.5, 0, 1, -90))
						end

						return (UDim2.new(0.5, 0, 1, -36))
					end,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(180, 34)
				}),
				TextLabel({
					Name = "UpgradeCostFree",
					Text = "Free",
					TextSize = 24,
					ZIndex = 21,
					Visible = function() --[[ Visible ]] -- line: 129
						-- upvalues: p1 (copy), UpgradeUIUtils (copy), p2 (copy)
						local v28 = p1()

						return v28 ~= nil and (UpgradeUIUtils.isFreeUpgrade(v28) and not p2()[v28.id])
					end,
					TextColor3 = Color3.fromRGB(165, 255, 165),
					Position = function() --[[ Position ]] -- line: 137
						-- upvalues: v17 (copy)
						if v17() then
							return (UDim2.new(0.5, 0, 1, -90))
						end

						return (UDim2.new(0.5, 0, 1, -36))
					end,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(180, 34),
					Stroke = {},
					DropShadow = {}
				}),
				TextLabel({
					Name = "UpgradeStatus",
					TextSize = 24,
					ZIndex = 21,
					Visible = v18,
					Text = function() --[[ Text ]] -- line: 151
						-- upvalues: v18 (copy)
						if v18() then
							return "OWNED"
						end

						return ""
					end,
					TextColor3 = Color3.fromRGB(165, 255, 165),
					Position = UDim2.new(0.5, 0, 1, -36),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(180, 30),
					Stroke = {},
					DropShadow = {}
				}),
				StylizedButton({
					Text = "BUY",
					ZIndex = 21,
					Visible = function() --[[ Visible ]] -- line: 165
						-- upvalues: v17 (copy), v18 (copy)
						return v17() and not v18()
					end,
					Theme = function() --[[ Theme ]] -- line: 168
						-- upvalues: v19 (copy)
						if v19() then
							return "Green"
						end

						return "Red"
					end,
					Size = UDim2.fromOffset(150, 54),
					Position = UDim2.new(0.5, 0, 1, -18),
					AnchorPoint = Vector2.new(0.5, 1),
					Activated = function() --[[ Activated ]] -- line: 176
						-- upvalues: p1 (copy), v18 (copy), UpgradeServiceClient (copy)
						local v29 = p1()

						if not v29 or v18() then
							return
						end

						UpgradeServiceClient:unlockUpgrade(v29.id)
					end
				})
			})
		})
	})
end
