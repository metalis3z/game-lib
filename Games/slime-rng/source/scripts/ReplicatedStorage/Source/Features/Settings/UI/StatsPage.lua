-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: StatsPage, time of decompilation: Sun May  3 10:11:57 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local FormatCurrency = require(ReplicatedStorage.Source.Core.UI.FormatCurrency)
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local rect = Rect.new(22, 52, 112, 52)

local function formatCount(n1: number?) -- line: 26
	-- upvalues: Abbreviate (copy)
	return Abbreviate((math.max(0, (math.round(n1 or 0)))))
end
local function formatOdds(n2: number?) -- line: 43
	-- upvalues: Abbreviate (copy)
	if type(n2) ~= "number" or n2 <= 0 then
		return "-"
	end

	return Abbreviate(n2, 4)
end
local function StatRow(t1: {[any]: any}) -- line: 51
	-- upvalues: ImageLabel (copy), ImageIds (copy), rect (copy), TextLabel (copy)
	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.new(1, -10, 0, 75),
		LayoutOrder = t1.LayoutOrder,
		TextLabel({
			Text = t1.Label,
			Size = UDim2.fromScale(0.42, 0.6),
			Position = UDim2.new(0, 16, 0.45, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			Stroke = {}
		}),
		TextLabel({
			Text = t1.Value,
			Size = UDim2.fromScale(0.58, 0.6),
			Position = UDim2.new(1, -16, 0.45, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Center,
			Stroke = {}
		})
	})
end

return function() -- line: 81
	-- upvalues: getDataSource (copy), Frame (copy), ScrollingFrame (copy), UIPadding (copy), UIListLayout (copy), StatRow (copy), serverTimeSource (copy), FormatTime (copy), formatCount (copy), formatOdds (copy), FormatCurrency (copy)
	local v24 = getDataSource({
		"stats",
		"timePlayed"
	})
	local v25 = getDataSource({
		"stats",
		"totalCoins"
	})
	local v26 = getDataSource({
		"stats",
		"kills"
	})
	local v27 = getDataSource({
		"stats",
		"rolls"
	})
	local v28 = getDataSource({
		"stats",
		"rarestRoll"
	})
	local v29 = getDataSource({
		"stats",
		"dailyRarestRoll"
	})
	local v30 = getDataSource("sessionStart")
	local v31 = getDataSource("furthestZone")

	return Frame({
		Size = UDim2.fromScale(1, 1),
		ScrollingFrame({
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, -8),
			Position = UDim2.fromOffset(0, 8),
			CanvasSize = UDim2.fromOffset(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 6,
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			UIPadding({
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4)
			}),
			UIListLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				Padding = UDim.new(0, 0)
			}),
			StatRow({
				Label = "Time Played",
				LayoutOrder = 1,
				Value = function() --[[ Value ]] -- line: 120
					-- upvalues: v24 (copy), v30 (copy), serverTimeSource (copy), FormatTime (copy)
					local v32 = v24() or 0
					local v33 = v30()
					local n3 = 0

					if type(v33) == "number" and v33 > 0 then
						n3 = math.max(serverTimeSource() - v33, 0)
					end

					local v35 = v32 + n3
					local v36 = FormatTime((math.max(0, (math.floor(v35)))))

					if v36 == "" then
						return "0s"
					end

					return v36
				end
			}),
			StatRow({
				Label = "Number of Rolls",
				LayoutOrder = 2,
				Value = function() --[[ Value ]] -- line: 135
					-- upvalues: formatCount (copy), v27 (copy)
					return formatCount(v27())
				end
			}),
			StatRow({
				Label = "Rarest Roll",
				LayoutOrder = 3,
				Value = function() --[[ Value ]] -- line: 143
					-- upvalues: formatOdds (copy), v28 (copy)
					local v37 = formatOdds
					local v38 = v28()

					return v37(if v38 ~= nil then v38.odds else nil)
				end
			}),
			StatRow({
				Label = "Daily Rarest Roll",
				LayoutOrder = 3,
				Value = function() --[[ Value ]] -- line: 151
					-- upvalues: formatOdds (copy), v29 (copy)
					local v39 = formatOdds
					local v40 = v29()

					return v39(if v40 ~= nil then v40.odds else nil)
				end
			}),
			StatRow({
				Label = "Total Coins Earned",
				LayoutOrder = 4,
				Value = function() --[[ Value ]] -- line: 159
					-- upvalues: FormatCurrency (copy), v25 (copy)
					return FormatCurrency(v25() or 0, true)
				end
			}),
			StatRow({
				Label = "Enemies Killed",
				LayoutOrder = 5,
				Value = function() --[[ Value ]] -- line: 167
					-- upvalues: formatCount (copy), v26 (copy)
					return formatCount(v26())
				end
			}),
			StatRow({
				Label = "Highest Zone",
				LayoutOrder = 6,
				Value = function() --[[ Value ]] -- line: 175
					-- upvalues: v31 (copy)
					return (tostring(v31() or 1))
				end
			})
		})
	})
end
