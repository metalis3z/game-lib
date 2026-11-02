-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LuckHoverInfo, time of decompilation: Sun May  3 10:11:26 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)
local BoostServiceUtils = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceUtils)
local AdminLuckServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceClient)
local FriendsServiceUtils = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local LikeGroupServiceUtils = require(ReplicatedStorage.Source.Features.LikeGroup.LikeGroupServiceUtils)
local LuckLadderServiceClient = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceClient)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local rect = Rect.new(28, 22, 107, 100)

local function useOwnedGamepass(p1) -- line: 47
	-- upvalues: Vide (copy), MonetizationServiceClient (copy), client (copy)
	local v32 = Vide.source(MonetizationServiceClient:ownsGamepass(p1))
	local connection = client:getChangedSignal({
		"__gamepasses",
		(tostring(p1.id))
	}):Connect(function() -- line: 49
		-- upvalues: v32 (copy), MonetizationServiceClient (copy), p1 (copy)
		v32(MonetizationServiceClient:ownsGamepass(p1))
	end)

	Vide.cleanup(function() -- line: 53
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return v32
end
local function formatLuck(n1: number) -- line: 60
	-- upvalues: Abbreviate (copy)
	local v35 = math.round(n1 * 100) / 100

	if math.abs(v35) >= 1000 then
		return Abbreviate(v35, 4)
	end

	if v35 % 1 == 0 then
		return (tostring(v35))
	end

	return string.gsub(string.format("%.2f", v35), "%.?0+$", "")
end
local function Padding(n2: number, n3: number) -- line: 81
	-- upvalues: Frame (copy)
	return Frame({
		Name = "Padding",
		Size = UDim2.new(1, 0, 0, n2),
		LayoutOrder = n3
	})
end
local function Divider(n4: number) -- line: 89
	-- upvalues: Frame (copy), UIGradient (copy)
	return Frame({
		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		LayoutOrder = n4,
		BorderSizePixel = 0,
		Size = UDim2.new(0.7, 0, 0, 5),
		UIGradient({
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.4, 0),
				NumberSequenceKeypoint.new(0.6, 0),
				NumberSequenceKeypoint.new(1, 1)
			})
		})
	})
end
local function LuckBreakdownRow(t1: {[any]: any}) -- line: 108
	-- upvalues: Frame (copy), TextLabel (copy)
	return Frame({
		Name = t1.Name,
		Visible = t1.Visible,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.8, 0, 0, 28),
		LayoutOrder = t1.LayoutOrder,
		TextLabel({
			Name = "Label",
			Text = t1.Name,
			Size = UDim2.fromScale(1, 1),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {}
		}),
		TextLabel({
			Name = "Value",
			Text = t1.Value,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			TextXAlignment = Enum.TextXAlignment.Right,
			Stroke = {}
		})
	})
end
local function getBoostLuckAddition(p2) -- line: 141
	-- upvalues: BoostServiceUtils (copy), serverTimeSource (copy)
	local n5 = 0

	for _, v47 in BoostServiceUtils.getRollStatModifiers(p2, serverTimeSource()) do
		if v47.stat == "luck" then
			n5 = if v47.mode ~= "multiply" then n5 + v47.value else n5 + (v47.value - 1)
		end
	end

	return (math.max(n5, 0))
end
local function OverrideLuckHoverInfo(p3) -- line: 177
	-- upvalues: AutoScaledFrame (copy), ImageLabel (copy), ImageIds (copy), rect (copy), TextLabel (copy)
	return AutoScaledFrame({
		Name = "LuckHoverInfo",
		Visible = p3,
		Size = UDim2.fromOffset(250, 90),
		Position = UDim2.fromOffset(0, 0),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		ZIndex = 10,
		ImageLabel({
			Name = "Background",
			Image = ImageIds.blackFrame,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = rect,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			Position = UDim2.fromScale(0.5, 1),
			AnchorPoint = Vector2.new(0.5, 1),
			TextLabel({
				Text = "Luck overridden in settings",
				TextWrapped = true,
				ZIndex = 11,
				Size = UDim2.fromScale(0.9, 0.6),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.45),
				TextColor3 = Color3.fromRGB(255, 92, 92),
				Stroke = {
					Thickness = 2,
					Color = Color3.fromRGB(80, 0, 0)
				},
				DropShadow = {}
			})
		})
	})
end

return function(t2: {[any]: any}) -- line: 215
	-- upvalues: Vide (copy), OverrideLuckHoverInfo (copy), useOwnedGamepass (copy), Products (copy), AutoScaledFrame (copy), ImageLabel (copy), ImageIds (copy), rect (copy), UIListLayout (copy), Frame (copy), LuckBreakdownRow (copy), formatLuck (copy), UpgradeServiceUtils (copy), FriendsServiceUtils (copy), LikeGroupServiceUtils (copy), getBoostLuckAddition (copy), IndexServiceUtils (copy), Divider (copy), LuckLadderServiceClient (copy), AdminLuckServiceClient (copy), RebirthServiceUtils (copy), Padding (copy)
	return Vide.show(function() --[[ isOverrideActive ]] -- line: 216
		-- upvalues: t2 (copy)
		return t2.OverrideEnabled ~= nil and t2.OverrideEnabled() == true
	end, function() -- line: 220
		-- upvalues: OverrideLuckHoverInfo (copy), t2 (copy)
		return OverrideLuckHoverInfo(t2.Visible)
	end, function() -- line: 222
		-- upvalues: useOwnedGamepass (copy), Products (copy), AutoScaledFrame (copy), t2 (copy), ImageLabel (copy), ImageIds (copy), rect (copy), UIListLayout (copy), Frame (copy), LuckBreakdownRow (copy), formatLuck (copy), UpgradeServiceUtils (copy), FriendsServiceUtils (copy), LikeGroupServiceUtils (copy), getBoostLuckAddition (copy), IndexServiceUtils (copy), Divider (copy), LuckLadderServiceClient (copy), AdminLuckServiceClient (copy), RebirthServiceUtils (copy), Padding (copy)
		local v55 = useOwnedGamepass(Products.luckyRolls)
		local v56 = useOwnedGamepass(Products.vip)

		return AutoScaledFrame({
			Name = "LuckHoverInfo",
			Visible = t2.Visible,
			Size = UDim2.fromOffset(250, 252),
			Position = UDim2.fromOffset(0, 0),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = 1,
			ZIndex = 10,
			ImageLabel({
				Name = "Background",
				Image = ImageIds.blackFrame,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = rect,
				Size = UDim2.fromScale(1, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 10,
				Position = UDim2.fromScale(0.5, 1),
				AnchorPoint = Vector2.new(0.5, 1),
				UIListLayout({
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 4)
				}),
				Frame({
					Name = "Padding",
					LayoutOrder = 0,
					Size = UDim2.new(1, 0, 0, 10)
				}),
				LuckBreakdownRow({
					Name = "Zone Luck",
					LayoutOrder = 3,
					Value = function() --[[ Value ]] -- line: 257
						-- upvalues: t2 (copy), formatLuck (copy)
						local v57 = math.max(t2.furthestZone() or 1, 0)

						return "+" .. formatLuck(v57)
					end
				}),
				LuckBreakdownRow({
					Name = "Upgrades",
					LayoutOrder = 4,
					Value = function() --[[ Value ]] -- line: 265
						-- upvalues: t2 (copy), UpgradeServiceUtils (copy), formatLuck (copy)
						local v58 = t2.upgradesOwned() or {}
						local v59 = UpgradeServiceUtils.getUpgradeLevel("luck", v58 or {})
						local v60 = math.max(UpgradeServiceUtils.getUpgradeValue("luck", v59) - 1, 0)

						return "+" .. formatLuck(v60)
					end
				}),
				LuckBreakdownRow({
					Name = "Lucky Rolls",
					LayoutOrder = 5,
					Value = function() --[[ Value ]] -- line: 273
						return "+" .. tostring(1)
					end,
					Visible = v55
				}),
				LuckBreakdownRow({
					Name = "VIP",
					LayoutOrder = 6,
					Value = function() --[[ Value ]] -- line: 282
						return "+" .. string.gsub(string.format("%.2f", 0.5), "%.?0+$", "")
					end,
					Visible = v56
				}),
				LuckBreakdownRow({
					Name = "Friends",
					LayoutOrder = 7,
					Value = function() --[[ Value ]] -- line: 291
						-- upvalues: t2 (copy), FriendsServiceUtils (copy), formatLuck (copy)
						local v61 = t2.friendCount() or 0
						local v62 = t2.upgradesOwned() or {}
						local v63 = FriendsServiceUtils.getFriendLuckBonus(v61, v62)

						return "+" .. formatLuck(v63)
					end
				}),
				LuckBreakdownRow({
					Name = "Like/Group",
					LayoutOrder = 8,
					Value = function() --[[ Value ]] -- line: 301
						-- upvalues: t2 (copy), LikeGroupServiceUtils (copy), formatLuck (copy)
						local v64 = t2.likeGroupLuckActive()
						local v65 = LikeGroupServiceUtils.getLuckBonus(v64)

						return "+" .. formatLuck(v65)
					end
				}),
				LuckBreakdownRow({
					Name = "Boosts",
					LayoutOrder = 9,
					Value = function() --[[ Value ]] -- line: 309
						-- upvalues: getBoostLuckAddition (copy), t2 (copy), formatLuck (copy)
						local v66 = getBoostLuckAddition(t2.boosts())

						return "+" .. formatLuck(v66)
					end
				}),
				LuckBreakdownRow({
					Name = "Index",
					LayoutOrder = 10,
					Value = function() --[[ Value ]] -- line: 317
						-- upvalues: t2 (copy), IndexServiceUtils (copy), formatLuck (copy)
						local v67 = t2.indexData()
						local v68 = math.max(IndexServiceUtils.getPermanentBonuses(v67).flatLuck, 0)

						return "+" .. formatLuck(v68)
					end,
					Visible = function() --[[ Visible ]] -- line: 321
						-- upvalues: t2 (copy), IndexServiceUtils (copy)
						local v69 = t2.indexData()

						return math.max(IndexServiceUtils.getPermanentBonuses(v69).flatLuck, 0) > 0
					end
				}),
				Divider(11),
				LuckBreakdownRow({
					Name = "Server Luck",
					LayoutOrder = 12,
					Value = function() --[[ Value ]] -- line: 330
						-- upvalues: LuckLadderServiceClient (copy), formatLuck (copy)
						local v70 = LuckLadderServiceClient:getCurrentMultiplier()

						return "x" .. formatLuck(v70)
					end
				}),
				LuckBreakdownRow({
					Name = "Admin Luck",
					LayoutOrder = 13,
					Value = function() --[[ Value ]] -- line: 338
						-- upvalues: AdminLuckServiceClient (copy), formatLuck (copy)
						local v71 = AdminLuckServiceClient:getCurrentMultiplier()

						return "x" .. formatLuck(v71)
					end,
					Visible = function() --[[ Visible ]] -- line: 342
						-- upvalues: AdminLuckServiceClient (copy)
						return AdminLuckServiceClient:isActive()
					end
				}),
				LuckBreakdownRow({
					Name = "Rebirths",
					LayoutOrder = 14,
					Value = function() --[[ Value ]] -- line: 349
						-- upvalues: RebirthServiceUtils (copy), t2 (copy), formatLuck (copy)
						local v72 = RebirthServiceUtils.getLuckMultiplier(t2.rebirths() or 0)

						return "x" .. formatLuck(v72)
					end
				}),
				LuckBreakdownRow({
					Name = "Index %",
					LayoutOrder = 15,
					Value = function() --[[ Value ]] -- line: 357
						-- upvalues: t2 (copy), IndexServiceUtils (copy), formatLuck (copy)
						local v73 = t2.indexData()
						local v74 = math.max(IndexServiceUtils.getPermanentBonuses(v73).luckMultiplier, 0) + 1

						return "x" .. formatLuck(v74)
					end,
					Visible = function() --[[ Visible ]] -- line: 361
						-- upvalues: t2 (copy), IndexServiceUtils (copy)
						local v75 = t2.indexData()

						return math.max(IndexServiceUtils.getPermanentBonuses(v75).luckMultiplier, 0) + 1 > 1
					end
				}),
				Padding(25, 999)
			})
		})
	end)
end
