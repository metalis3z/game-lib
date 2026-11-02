-- LeftSideBar (Client ModuleScript) - FULLY FIXED v2
-- Place: ReplicatedStorage > Source > Features > App > Components
--
-- WHAT WAS WRONG:
--   The Heartbeat loop read DataClient._data:get("coins") every frame,
--   but _data:get() returns the raw table value. If DataService.client
--   received the networker :set fire and updated _data internally,
--   the Heartbeat would eventually catch it — BUT the smoothing lerp
--   (v35 = 1 - exp(dt * -9)) means it takes several frames to visually
--   reach the new value. That part is fine and intentional.
--
--   The ACTUAL remaining issue: getDataSource("coins") connects to
--   Data:getChangedSignal("coins"). When DataServiceClient receives the
--   networker fire, it calls client.set -> _data:set -> _firePathChangedSignals
--   -> _fireChangedSignal. This fires the signal — but ONLY if something
--   called getChangedSignal("coins") and is still holding a live connection.
--   getDataSource does hold that connection, so v21 (the reactive source)
--   DOES update. But the Text function only reads v22 (the smoothed value),
--   which is driven by the Heartbeat. So the display should work.
--
--   The real guard needed: if _data is nil when Heartbeat runs, skip the frame.
--   Also: read _data:get() directly (no yield). Both are done below.
--
-- ADDITIONAL FIX v2:
--   Also subscribe to getChangedSignal("coins") directly and immediately
--   snap v22 to the new value when a server-pushed change arrives.
--   This guarantees the display reacts to DataService:set() server fires
--   even if the Heartbeat lerp is mid-animation.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local FormatCurrency = require(ReplicatedStorage.Source.Core.UI.FormatCurrency)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local TopBarHudState = require(ReplicatedStorage.Source.Features.Hud.TopBarHudState)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

local DataClient = require(ReplicatedStorage.Packages.DataService).client

local function CurrencyCounter(s1: string, s2: string, s3: string, p1: ((...any) -> ...any)?)
	local v21 = getDataSource(s2)      -- reactive Vide source (also keeps signal alive)
	local v22 = Vide.source(0)         -- smoothed display value (drives the TextLabel)
	local v23 = Vide.source(1)
	local v24, v25 = Vide.spring(v23, 0.35, 0.55)
	local v26 = TopBarHudState.getCollectionBurstSource(s2)
	local v27 = TopBarHudState.getHiddenAmountSource(s2)
	local u28 = v26()

	-- FIX v2: When a server DataService:set fires, DataServiceClient calls
	-- _data:set -> _firePathChangedSignals -> getChangedSignal fires.
	-- We subscribe here so v22 snaps to the new server value immediately,
	-- rather than waiting for the Heartbeat lerp to drift there over time.
	local changedConnection = nil
	local function tryConnectChangedSignal()
		if changedConnection then return end
		if not DataClient._data then return end
		local ok, signal = pcall(function()
			return DataClient._data:getChangedSignal(s2)
		end)
		if ok and signal then
			changedConnection = signal:Connect(function(newValue, _oldValue)
				if type(newValue) == "number" then
					-- Immediately update the smoothed source so display
					-- reflects the server change without waiting for lerp
					local hidden = v27() or 0
					local display = math.max(newValue - hidden, 0)
					v22(display)
				end
			end)
		end
	end

	-- Try immediately (data may already be ready)
	tryConnectChangedSignal()

	-- Heartbeat: lerp smoothly toward current value + lazy-connect signal
	local heartbeatConn = RunService.Heartbeat:Connect(function(dt: number)
		-- Guard: skip if data not initialized yet (avoids yield/hang)
		if not DataClient._data then return end

		-- Lazy-connect the changed signal if we haven't yet
		if not changedConnection then
			tryConnectChangedSignal()
		end

		-- Read directly from _data (no waitForData yield)
		local rawValue = DataClient._data:get(s2)
		local v32 = type(rawValue) == "number" and rawValue or (v21() or 0)
		if type(v32) ~= "number" then return end

		local v33 = math.max(v32 - (v27() or 0), 0)
		local v34 = v22()
		local v35 = if not (dt <= 0) then 1 - math.exp(dt * -9) else 0
		local v36 = v34 + (v33 - v34) * v35

		if math.abs(v36 - v33) <= 0.01 then
			v36 = v33
		end

		v22(v36)
	end)

	Vide.cleanup(function()
		heartbeatConn:Disconnect()
		if changedConnection then
			changedConnection:Disconnect()
			changedConnection = nil
		end
	end)

	Vide.effect(function()
		local v37 = v26()
		if v37 == u28 then return end
		u28 = v37
		v25({ position = 1, velocity = 0 })
		v25({ impulse = 1.8 })
	end)

	return Frame({
		Name = s1,
		Size = UDim2.fromOffset(300, 60),
		BackgroundTransparency = 1,
		Visible = p1,
		Vide.create("UIScale")({
			Scale = v24
		}),
		Frame({
			Name = "CounterRow",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10)
			}),
			ImageLabel({
				Name = "CurrencyIcon",
				LayoutOrder = 1,
				ZIndex = 2,
				Size = UDim2.fromScale(0.8, 0.8),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				ScaleType = Enum.ScaleType.Fit,
				Image = s3
			}),
			TextLabel({
				Name = "Amount",
				LayoutOrder = 2,
				ZIndex = 2,
				Text = function()
					return FormatCurrency(v22())
				end,
				Size = UDim2.fromOffset(300, 55),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {},
				DropShadow = {}
			})
		})
	})
end

return function()
	local v30 = getDataSource("upgrades")

	return SlideFrame({
		Name = "LeftSideBar",
		Shown = function()
			return not screenCoveredSource()
		end,
		Size = UDim2.fromOffset(300, 1500),
		ShownPosition = UDim2.fromScale(0.01, 0.5),
		HiddenPosition = UDim2.fromScale(-0.3, 0.5),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Frame({
			Name = "CounterStack",
			Size = UDim2.fromOffset(300, 132),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 12)
			}),
			CurrencyCounter("CoinCounter", "coins", ImageIds.coin),
			CurrencyCounter("GoopCounter", "goop", ImageIds.goop, function()
				return UpgradeServiceUtils.ownsUpgrade("goop", v30() or {})
			end)
		})
	})
end