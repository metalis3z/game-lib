-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SettingMenuPage, time of decompilation: Sun May  3 10:11:57 2026 ]]
local _select = select

local function v70(tbl, idx, ...)
	local va = { ... }

	for i = 1, _select("#", ...) do
		tbl[idx + i - 1] = va[i]
	end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local OptionSlider = require(ReplicatedStorage.Source.Core.UI.Components.OptionSlider)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local SettingsServiceUtils = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceUtils)
local useSetting = require(ReplicatedStorage.Source.Features.Settings.UI.Hooks.useSetting)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local PlayerUpgradeUtils = require(ReplicatedStorage.Source.Features.Upgrades.PlayerUpgradeUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)

local function SettingToggleRow(t1: {[any]: any}) -- line: 27
	-- upvalues: useSetting (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), StylizedButton (copy)
	local v25, v26 = useSetting(t1.SettingPath)

	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(22, 52, 112, 52),
		Size = UDim2.new(0.95, 0, 0, 80),
		LayoutOrder = t1.LayoutOrder,
		TextLabel({
			Text = t1.Label,
			Size = UDim2.fromScale(0.7, 0.6),
			Position = UDim2.fromScale(0.02, 0.45),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 3
			}
		}),
		StylizedButton({
			Theme = function() --[[ Theme ]] -- line: 47
				-- upvalues: v25 (copy)
				if v25() then
					return "Green"
				end

				return "Red"
			end,
			Text = function() --[[ Text ]] -- line: 50
				-- upvalues: v25 (copy)
				if v25() then
					return "On"
				end

				return "Off"
			end,
			Size = UDim2.fromOffset(130, 55),
			Position = UDim2.fromScale(0.9, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ Activated ]] -- line: 56
				-- upvalues: v26 (copy), v25 (copy)
				v26(not v25())
			end
		})
	})
end
local function getSelectedOption(t2: {[any]: any}, p1) -- line: 70
	for _, v30 in t2 do
		if p1 == v30.value then
			return v30
		end
	end

	if type(p1) == "number" then
		local v31 = t2[1]
		local n1 = 1e999

		for _, v34 in t2 do
			if type(v34.value) == "number" then
				local v35 = math.abs(v34.value - p1)

				if v35 < n1 then
					n1 = v35
					v31 = v34
				end
			end
		end

		return v31
	end

	return t2[1]
end
local function SettingSliderRow(p2) -- line: 97
	-- upvalues: useSetting (copy), getSelectedOption (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), StylizedFrame (copy), OptionSlider (copy)
	local v37, v38 = useSetting(p2.SettingPath)

	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(22, 52, 112, 52),
		Size = UDim2.new(0.96, 0, 0, 140),
		LayoutOrder = p2.LayoutOrder,
		TextLabel({
			Text = p2.Label,
			Size = UDim2.fromScale(0.6, 0.32),
			Position = UDim2.fromScale(0.03, 0.24),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 3
			}
		}),
		StylizedFrame({
			Theme = "Grey",
			Size = UDim2.fromScale(0.162, 0.38),
			Position = UDim2.fromScale(0.895, 0.27),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextLabel({
				Text = function() --[[ Text ]] -- line: 127
					-- upvalues: getSelectedOption (copy), p2 (copy), v37 (copy)
					return getSelectedOption(p2.Options, v37()).label
				end,
				Size = UDim2.fromScale(0.9, 0.6),
				Position = UDim2.fromScale(0.5, 0.45),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Stroke = {
					Thickness = 2
				},
				DropShadow = {}
			})
		}),
		OptionSlider({
			Options = p2.Options,
			Value = function() --[[ Value ]] -- line: 140
				-- upvalues: getSelectedOption (copy), p2 (copy), v37 (copy)
				return getSelectedOption(p2.Options, v37()).value
			end,
			OnChanged = v38,
			Size = UDim2.fromScale(0.85, 0.45),
			Position = UDim2.fromScale(0.5, 0.6),
			AnchorPoint = Vector2.new(0.5, 0.5)
		})
	})
end
local function SettingLuckOverrideRow(n2: number) -- line: 160
	-- upvalues: useSetting (copy), Vide (copy), SettingsServiceUtils (copy), RollSlice (copy), UICorner (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), StylizedButton (copy)
	local v41, v42 = useSetting("luckOverrideEnabled")
	local v43, v44 = useSetting("luckOverrideValue")
	local u45 = false
	local v46 = Vide.create("TextBox")
	local t3 = {
		Size = UDim2.fromOffset(135, 48),
		Position = UDim2.fromScale(0.71, 0.475),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(28, 33, 45),
		BorderSizePixel = 0
	}
	local v48 = v43()

	t3.Text = tostring((math.clamp(math.floor((SettingsServiceUtils.resolveValue("luckOverrideValue", v48))), 1, (math.max(math.floor(RollSlice.maxLuck() or 1), 1)))))
	t3.PlaceholderText = "1"
	t3.PlaceholderColor3 = Color3.fromRGB(190, 205, 255)
	t3.TextColor3 = Color3.fromRGB(255, 255, 255)
	t3.TextSize = 26
	t3.TextScaled = false
	t3.Font = Enum.Font.BuilderSansExtraBold
	t3.ClearTextOnFocus = false
	t3.TextEditable = v41
	t3.MultiLine = false
	t3.TextStrokeTransparency = 0
	t3.TextXAlignment = Enum.TextXAlignment.Center
	t3.ZIndex = 3
	v70(t3, 1, UICorner({
		CornerRadius = UDim.new(0, 8)
	}))

	local v49 = v46(t3)
	local connection = v49:GetPropertyChangedSignal("Text"):Connect(function() -- line: 205
		-- upvalues: u45 (ref), v49 (copy)
		if u45 then
			return
		end

		local v64 = string.gsub(v49.Text, "%D", "")

		if v64 ~= v49.Text then
			u45 = true
			v49.Text = v64
			u45 = false
		end
	end)
	local connection2 = v49.FocusLost:Connect(function() --[[ commitText ]] -- line: 197
		-- upvalues: v49 (copy), SettingsServiceUtils (copy), RollSlice (copy), u45 (ref), v43 (copy), v44 (copy)
		local num = tonumber(v49.Text)
		local v62 = math.clamp(math.floor((SettingsServiceUtils.resolveValue("luckOverrideValue", num))), 1, (math.max(math.floor(RollSlice.maxLuck() or 1), 1)))
		local str = tostring(v62)

		u45 = true
		v49.Text = str
		u45 = false

		if v62 ~= v43() then
			v44(v62)
		end
	end)

	Vide.effect(function() -- line: 217
		-- upvalues: v49 (copy), v41 (copy), v43 (copy), SettingsServiceUtils (copy), RollSlice (copy), u45 (ref)
		v49.TextEditable = v41()
		v49.TextTransparency = not v41() and 0.35 or 0

		if not v49:IsFocused() then
			local v65 = v43()
			local str = tostring((math.clamp(math.floor((SettingsServiceUtils.resolveValue("luckOverrideValue", v65))), 1, (math.max(math.floor(RollSlice.maxLuck() or 1), 1)))))

			u45 = true
			v49.Text = str
			u45 = false
		end
	end)
	Vide.cleanup(function() -- line: 225
		-- upvalues: connection (copy), connection2 (copy)
		connection:Disconnect()
		connection2:Disconnect()
	end)

	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(22, 52, 112, 52),
		Size = UDim2.new(0.95, 0, 0, 100),
		LayoutOrder = n2,
		TextLabel({
			Text = "Manual Luck Override",
			Size = UDim2.fromScale(0.48, 0.5),
			Position = UDim2.fromScale(0.02, 0.38),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 3
			}
		}),
		TextLabel({
			TextSize = 18,
			Text = function() --[[ Text ]] -- line: 247
				-- upvalues: RollSlice (copy)
				return `Max x{ math.max(math.floor(RollSlice.maxLuck() or 1), 1) }`
			end,
			Size = UDim2.fromScale(0.32, 0.28),
			Position = UDim2.fromScale(0.03, 0.65),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 2
			},
			DropShadow = {}
		}),
		TextLabel({
			Text = "[!] Only use this if you want BAD slimes",
			TextSize = 18,
			Size = UDim2.fromScale(0.32, 0.28),
			Position = UDim2.fromScale(0.2, 0.65),
			AnchorPoint = Vector2.new(0, 0.5),
			TextColor3 = Color3.fromRGB(255, 0, 0),
			Stroke = {
				Thickness = 2
			},
			DropShadow = {}
		}),
		v49,
		StylizedButton({
			Theme = function() --[[ Theme ]] -- line: 273
				-- upvalues: v41 (copy)
				if v41() then
					return "Green"
				end

				return "Red"
			end,
			Text = function() --[[ Text ]] -- line: 276
				-- upvalues: v41 (copy)
				if v41() then
					return "On"
				end

				return "Off"
			end,
			Size = UDim2.fromOffset(130, 55),
			Position = UDim2.fromScale(0.9, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ Activated ]] -- line: 282
				-- upvalues: v41 (copy), v49 (copy), SettingsServiceUtils (copy), RollSlice (copy), u45 (ref), v43 (copy), v44 (copy), v42 (copy)
				if not v41() then
					local num = tonumber(v49.Text)
					local v68 = math.clamp(math.floor((SettingsServiceUtils.resolveValue("luckOverrideValue", num))), 1, (math.max(math.floor(RollSlice.maxLuck() or 1), 1)))
					local str = tostring(v68)

					u45 = true
					v49.Text = str
					u45 = false

					if v68 ~= v43() then
						v44(v68)
					end
				end

				v42(not v41())
			end
		})
	})
end
local function SectionHeader(s1: string, n3: number) -- line: 292
	-- upvalues: TextLabel (copy)
	return TextLabel({
		TextScaled = false,
		Text = s1,
		Size = UDim2.new(1, 0, 0, 34),
		LayoutOrder = n3,
		Stroke = {},
		DropShadow = {}
	})
end

return function() -- line: 303
	-- upvalues: getDataSource (copy), PlayerUpgradeUtils (copy), Frame (copy), ScrollingFrame (copy), UIPadding (copy), UIListLayout (copy), SectionHeader (copy), SettingToggleRow (copy), SettingSliderRow (copy), SettingsServiceUtils (copy), SettingLuckOverrideRow (copy)
	local v54 = getDataSource("upgrades")
	local t4 = {}
	local v56 = PlayerUpgradeUtils.getWalkSpeed(v54() or {})

	for i2 = PlayerUpgradeUtils.MIN_WALK_SPEED, v56 do
		table.insert(t4, {
			value = i2,
			label = tostring(i2)
		})
	end

	local t5 = {}

	for i3 = 1, PlayerUpgradeUtils.getMaxEnemies(v54() or {}) do
		table.insert(t5, {
			value = i3,
			label = tostring(i3)
		})
	end

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
				PaddingTop = UDim.new(0, 6),
				PaddingBottom = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 4)
			}),
			UIListLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 0)
			}),
			SectionHeader("Sounds", 1),
			SettingToggleRow({
				SettingPath = "music",
				Label = "Music",
				LayoutOrder = 2
			}),
			SettingToggleRow({
				SettingPath = "hitSounds",
				Label = "Hit Sounds",
				LayoutOrder = 3
			}),
			SettingToggleRow({
				SettingPath = "rollSounds",
				Label = "Roll Sounds",
				LayoutOrder = 4
			}),
			SettingToggleRow({
				SettingPath = "uiSounds",
				Label = "UI Sounds",
				LayoutOrder = 5
			}),
			SettingToggleRow({
				SettingPath = "coinGoopCollectionSounds",
				Label = "Coin/Goop Collection Sounds",
				LayoutOrder = 6
			}),
			SectionHeader("Gameplay", 7),
			SettingSliderRow({
				SettingPath = "rareRollCutscenes",
				Label = "Rare Roll Cutscenes",
				LayoutOrder = 8,
				Options = SettingsServiceUtils.getRareRollCutsceneOptions()
			}),
			SettingSliderRow({
				SettingPath = "playerWalkSpeed",
				Label = "Walk Speed",
				LayoutOrder = 9,
				Options = t4
			}),
			SettingSliderRow({
				SettingPath = "enemyLimit",
				Label = "Enemy Limit",
				LayoutOrder = 10,
				Options = t5
			}),
			SettingLuckOverrideRow(11),
			SettingToggleRow({
				SettingPath = "showHealthbars",
				Label = "Show Healthbars",
				LayoutOrder = 12
			}),
			SettingToggleRow({
				SettingPath = "cloverEmitterVfx",
				Label = "Clover Emitter VFX",
				LayoutOrder = 13
			}),
			SettingToggleRow({
				SettingPath = "showNotificationDots",
				Label = "Show Notification Dots",
				LayoutOrder = 14
			}),
			SettingToggleRow({
				SettingPath = "otherPlayerSlimes",
				Label = "Other Player Slimes",
				LayoutOrder = 15
			}),
			SettingToggleRow({
				SettingPath = "otherPlayerRareRollVisuals",
				Label = "Other Player Rare Rolls",
				LayoutOrder = 16
			}),
			SectionHeader("Performance", 17),
			SettingToggleRow({
				SettingPath = "hitSplatVfx",
				Label = "Hitsplat VFX",
				LayoutOrder = 18
			}),
			SettingToggleRow({
				SettingPath = "coinGoopCollectionVfx",
				Label = "Coin/Goop Collection VFX",
				LayoutOrder = 19
			}),
			SettingToggleRow({
				SettingPath = "slimeEnemyAnimations",
				Label = "Slime/Enemy Animations",
				LayoutOrder = 20
			})
		})
	})
end
