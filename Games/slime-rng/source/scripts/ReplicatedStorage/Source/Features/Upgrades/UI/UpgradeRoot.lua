-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeRoot, time of decompilation: Sun May  3 10:11:36 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local ConsoleHint = require(ReplicatedStorage.Source.Core.UI.Components.ConsoleHint)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local preferredInputSource = require(ReplicatedStorage.Source.Core.UI.Sources.preferredInputSource)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local UpgradeCurrencyHeader = require(ReplicatedStorage.Source.Features.Upgrades.UI.Components.UpgradeCurrencyHeader)
local UpgradeTilesContainer = require(ReplicatedStorage.Source.Features.Upgrades.UI.Components.UpgradeTilesContainer)
local UpgradeUIUtils = require(ReplicatedStorage.Source.Features.Upgrades.UI.Components.UpgradeUIUtils)
local UpgradeCounterUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeCounterUtils)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)

require(ReplicatedStorage.Source.Features.Upgrades.UpgradeTree)

local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

local function UpgradeScreen() -- line: 19
	-- upvalues: Vide (copy), getDataSource (copy), UpgradeCounterUtils (copy), UpgradeUIUtils (copy), UpgradeSlice (copy), Frame (copy), AutoScaledFrame (copy), ImageIds (copy), UpgradeTilesContainer (copy), preferredInputSource (copy), SlideFrame (copy), ConsoleHint (copy), UpgradeCurrencyHeader (copy), StylizedButton (copy)
	local v17 = Vide.source(1)
	local v18 = Vide.spring(v17, 0.5, 1)
	local v19 = getDataSource("upgrades")
	local t1 = {}
	local v21 = Vide.source(nil)

	for _, v23 in UpgradeCounterUtils.getCurrencyPaths() do
		t1[v23] = getDataSource(v23)
	end

	Vide.effect(function() -- line: 47
		-- upvalues: v17 (copy), UpgradeSlice (copy)
		v17(not UpgradeSlice.shown() and 1 or 0)
	end)
	Vide.effect(function() -- line: 51
		-- upvalues: v21 (copy), UpgradeSlice (copy)
		local v26 = v21()
		local v27 = UpgradeSlice.tree()

		if not UpgradeSlice.shown() then
			if v26 ~= nil then
				task.defer(function() -- line: 35
					-- upvalues: v21 (copy), v26 (copy)
					local v29 = v21()

					if v26 ~= nil and v29 ~= v26 then
						return
					end

					if v29 ~= nil then
						v21(nil)
					end
				end)
			end

			return
		end

		if v26 and v27 ~= v26.parentTree then
			task.defer(function() -- line: 35
				-- upvalues: v21 (copy), v26 (copy)
				local v30 = v21()

				if v26 ~= nil and v30 ~= v26 then
					return
				end

				if v30 ~= nil then
					v21(nil)
				end
			end)
		end
	end)

	return Frame({
		Name = "UpgradeScreen",
		Size = UDim2.fromScale(1, 1),
		AutoScaledFrame({
			Name = "UpgradeContent",
			Size = UDim2.fromOffset(1500, 803),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Vide.create("ImageButton")({
				Name = "Background",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1.25, 1.25),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Image = ImageIds.upgradeBg,
				ImageTransparency = v18,
				Active = UpgradeSlice.shown
			}),
			UpgradeTilesContainer(v19, function(s1: string) --[[ getCurrencyAmount ]] -- line: 30
				-- upvalues: UpgradeUIUtils (copy), t1 (copy)
				return UpgradeUIUtils.resolveCurrencyAmount(t1, s1)
			end, v21, preferredInputSource)
		}),
		SlideFrame({
			Name = "ZoomOutHint",
			Shown = UpgradeSlice.shown,
			ShownPosition = UDim2.new(0.5, -120, 1, -20),
			HiddenPosition = UDim2.new(0.5, -120, 1, 80),
			AnchorPoint = Vector2.new(1, 1),
			Size = UDim2.fromOffset(130, 34),
			ConsoleHint({
				Text = "Zoom Out",
				ZIndex = 10,
				KeyCode = Enum.KeyCode.ButtonL2,
				Size = UDim2.fromScale(1, 1)
			})
		}),
		SlideFrame({
			Name = "ZoomInHint",
			Shown = UpgradeSlice.shown,
			ShownPosition = UDim2.new(0.5, 120, 1, -20),
			HiddenPosition = UDim2.new(0.5, 120, 1, 80),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromOffset(130, 34),
			ConsoleHint({
				Text = "Zoom In",
				ZIndex = 10,
				KeyCode = Enum.KeyCode.ButtonR2,
				Size = UDim2.fromScale(1, 1)
			})
		}),
		UpgradeCurrencyHeader(),
		SlideFrame({
			Name = "CloseButton",
			Shown = UpgradeSlice.shown,
			ShownPosition = UDim2.new(0.5, 0, 1, -20),
			HiddenPosition = UDim2.fromScale(0.5, 1.35),
			AnchorPoint = Vector2.new(0.5, 1),
			Size = UDim2.fromOffset(200, 80),
			StylizedButton({
				Theme = "Red",
				Text = "CLOSE",
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Activated = function() --[[ Activated ]] -- line: 140
					-- upvalues: UpgradeSlice (copy)
					UpgradeSlice.shown(false)
				end,
				ConsoleHint({
					ZIndex = 12,
					KeyCode = Enum.KeyCode.ButtonB,
					Position = UDim2.new(0, 10, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.fromOffset(28, 28)
				})
			})
		})
	})
end

return function() -- line: 156
	-- upvalues: Vide (copy), UpgradeSlice (copy), UpgradeScreen (copy)
	return Vide.show(UpgradeSlice.shown, function() -- line: 157
		-- upvalues: UpgradeScreen (copy)
		return UpgradeScreen(), 0.2
	end)
end
