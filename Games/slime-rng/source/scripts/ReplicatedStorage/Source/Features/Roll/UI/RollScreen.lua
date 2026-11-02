-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollScreen, time of decompilation: Sun May  3 10:11:47 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local ParticleEmitter2D = require(ReplicatedStorage.Source.Core.UI.Components.ParticleEmitter2D)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local ConsoleHint = require(ReplicatedStorage.Source.Core.UI.Components.ConsoleHint)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local RollServiceClient = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)
local RollServiceUtils = require(ReplicatedStorage.Source.Features.Roll.RollServiceUtils)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local GetScaledRevealTime = require(ReplicatedStorage.Source.Features.Roll.UI.GetScaledRevealTime)
local RollItem = require(ReplicatedStorage.Source.Features.Roll.UI.Components.RollItem)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local indexes = Vide.indexes
local t1 = {
	[1] = Color3.fromRGB(0, 255, 55),
	[2] = Color3.fromRGB(0, 217, 255),
	[3] = Color3.fromRGB(195, 0, 255),
	[4] = Color3.fromRGB(255, 123, 0),
	[5] = Color3.fromRGB(255, 0, 0)
}

local function getRollColumnSize() -- line: 64
	-- upvalues: RollSlice (copy)
	local v37 = not RollSlice.hiddenRoll() and 190 or 110

	return UDim2.fromOffset(v37, v37)
end
local function mutationsMatch(p1, p2) -- line: 73
	-- upvalues: Mutations (copy)
	if p1 == p2 then
		return true
	end

	local v40 = Mutations.hasAny(p1)
	local v41 = Mutations.hasAny(p2)

	if not v40 and not v41 then
		return true
	end

	if not v40 or not v41 then
		return false
	end

	for _, v43 in Mutations.sortedMutations do
		if (not not p1 and (p1[v43] or false)) ~= (not not p2 and (p2[v43] or false)) then
			return false
		end
	end

	return true
end
local function RollColumn(p3, n1: number) -- line: 105
	-- upvalues: RollSlice (copy), Vide (copy), getRollColumnSize (copy), RollItem (copy), RollServiceUtils (copy), RunService (copy), mutationsMatch (copy), GetScaledRevealTime (copy), Frame (copy)
	local v48 = p3()
	local v49 = n1 % 100 ~= 0
	local v50 = n1 % 100 + 1
	local v51 = v48[v50]
	local v52 = v48[v50 + 1] ~= nil
	local v53 = RollSlice.instantRevealRoll()
	local v54 = RollSlice.actions.registerRollCompletion()
	local source = Vide.source
	local uDim2

	if v49 then
		uDim2 = UDim2.fromOffset(0, 0)
	else
		local v57 = not RollSlice.hiddenRoll() and 190 or 110

		uDim2 = UDim2.fromOffset(v57, v57)
	end

	local v58 = source(uDim2)
	local v59 = Vide.spring(v58, 0.35, 0.7)
	local v60 = Vide.source(not v53 and 0 or 1)
	local v61 = Vide.source(false)

	Vide.effect(function() -- line: 117
		-- upvalues: RollSlice (copy), v61 (copy), v52 (copy), v58 (copy), getRollColumnSize (copy), Vide (copy)
		local u78 = nil

		if RollSlice.rollComplete() and (v61() and not v52) then
			u78 = task.delay(2, function() -- line: 121
				-- upvalues: v58 (copy), u78 (ref)
				v58(UDim2.fromOffset(0, 0))
				u78 = nil
			end)
		else
			v58(getRollColumnSize())
		end

		Vide.cleanup(function() -- line: 129
			-- upvalues: u78 (ref)
			if u78 then
				task.cancel(u78)
				u78 = nil
			end
		end)
	end)

	local t2 = {}
	local t3 = {
		[1] = Vide.source(nil),
		[2] = Vide.source(nil),
		[3] = Vide.source(nil),
		[4] = Vide.source(nil)
	}

	for i = 1, 4 do
		local v65 = RollItem
		local t4 = {
			result = v51,
			i = i,
			hasNext = v52
		}
		local n2 = 0

		for j = v50, 1, -1 do
			local v69 = v48[j]

			if not v69 or v69.kind ~= "BONUS" then
				break
			end

			n2 += 1
		end

		t4.bonusStreak = n2
		t4.previousResult = v48[v50 - 1]
		t4.displayedResult = t3[i]
		t4.adjacentResults = {
			t3[if i ~= 1 then i - 1 else #t3],
			t3[if i ~= #t3 then i + 1 else 1]
		}
		t4.progress = v60
		t4.completed = v61
		t4.isBonus = v49
		table.insert(t2, (v65(t4)))
	end

	local u70 = nil
	local u71 = nil
	local u72 = nil
	local u73 = false
	local u74 = false

	if v53 then
		task.defer(function() -- line: 182
			-- upvalues: u73 (ref), v61 (copy), u74 (ref), v52 (copy), RollServiceUtils (copy), v51 (copy), RollSlice (copy), v48 (copy), n1 (copy), v54 (copy)
			if u73 then
				return
			end

			u73 = true
			v61(true)

			if not u74 and not v52 and RollServiceUtils.isBonusRoll(v51) and RollSlice.jackpotSpinData() ~= nil then
				u74 = true
				task.defer(RollSlice.actions.showJackpotScreen)
			end

			if v52 then
				RollSlice.actions.addBonusRoll(v48, n1 + 1)
			end

			v54.complete()
		end)
	else
		u72 = RunService.Heartbeat:Connect(function(dt) -- line: 196
			-- upvalues: v60 (copy), RollSlice (copy), v49 (copy), v52 (copy), v51 (copy), RollServiceUtils (copy), mutationsMatch (copy), u70 (ref), GetScaledRevealTime (copy), v61 (copy), u74 (ref), v54 (copy), u71 (ref), v48 (copy), n1 (copy), u72 (ref)
			local v80 = v60()
			local v81 = dt / RollSlice.rollTime()

			if v49 then
				v81 *= 2.5
			end

			local v82 = v80 + v81

			if not v52 and v80 < 0.025 and v82 >= 0.025 then
				local v83 = v51
				local v84 = RollSlice.pendingRareRollCutsceneData()

				if v84 ~= nil and (not RollServiceUtils.isNonSlimeRoll(v83) and (v83.id == v84.id and mutationsMatch(v83.mutations, v84.mutations))) then
					RollSlice.actions.showRareRollCutscene(v51)
				end
			end

			if v82 >= 1 then
				v82 = 1
				u70 = task.delay(GetScaledRevealTime(0.2), function() -- line: 216
					-- upvalues: v61 (copy), u70 (ref), u74 (ref), v52 (copy), RollServiceUtils (copy), v51 (copy), RollSlice (copy), v54 (copy)
					v61(true)
					u70 = nil

					if not u74 and (not v52 and RollServiceUtils.isBonusRoll(v51) and RollSlice.jackpotSpinData() ~= nil) then
						u74 = true
						task.defer(RollSlice.actions.showJackpotScreen)
					end

					if not v52 then
						v54.complete()
					end
				end)

				if v52 then
					u71 = task.delay(GetScaledRevealTime(0.5), function() -- line: 226
						-- upvalues: u71 (ref), RollSlice (copy), v48 (copy), n1 (copy), v54 (copy)
						u71 = nil
						RollSlice.actions.addBonusRoll(v48, n1 + 1)
						task.defer(v54.complete)
					end)
				end

				if u72 then
					u72:Disconnect()
					u72 = nil
				end
			end

			v60(v82)
		end)
	end

	Vide.cleanup(function() -- line: 242
		-- upvalues: v54 (copy), u72 (ref), u71 (ref), u70 (ref)
		v54.destroy()

		if u72 then
			u72:Disconnect()
			u72 = nil
		end

		if u71 then
			task.cancel(u71)
			u71 = nil
		end

		if u70 then
			task.cancel(u70)
			u70 = nil
		end
	end)

	return Frame({
		LayoutOrder = n1,
		Size = v59,
		t2
	})
end
local function RollScreen() -- line: 266
	-- upvalues: getDataSource (copy), Vide (copy), RollSlice (copy), UpgradeServiceUtils (copy), GetScaledRevealTime (copy), RollServiceClient (copy), Frame (copy), ImageIds (copy), ParticleEmitter2D (copy), SettingsState (copy), t1 (copy), AutoScaledFrame (copy), DropShadow (copy), UIListLayout (copy), ImageLabel (copy), getRollColumnSize (copy), indexes (copy), RollColumn (copy), SlideFrame (copy), Button (copy), ConsoleHint (copy), TextLabel (copy)
	local v75 = getDataSource("upgrades")
	local v76 = Vide.source(1)
	local v77 = Vide.spring(v76, 0.5, 1)

	Vide.effect(function() -- line: 290
		-- upvalues: v76 (copy), RollSlice (copy)
		v76((not RollSlice.rollScreenShown() or RollSlice.hiddenRoll()) and 1 or 0)
	end)
	Vide.effect(function() -- line: 294
		-- upvalues: RollSlice (copy), GetScaledRevealTime (copy), Vide (copy), RollServiceClient (copy)
		if not RollSlice.rollComplete() or (RollSlice.rareRollCutsceneShown() or RollSlice.jackpotScreenShown()) then
			return
		end

		local u87 = nil

		u87 = task.delay(GetScaledRevealTime(1.5) + 0.05, function() -- line: 301
			-- upvalues: u87 (ref), RollSlice (copy), Vide (copy), RollServiceClient (copy)
			u87 = nil

			if RollSlice.jackpotSpinData() ~= nil then
				RollSlice.actions.showJackpotScreen()

				return
			end

			if RollSlice.autoRoll() then
				local v102 = false

				Vide.batch(function() -- line: 272
					-- upvalues: v102 (copy), RollSlice (copy)
					if v102 then
						RollSlice.rollScreenShown(false)
					end

					RollSlice.bonusRollResults({})
					RollSlice.rollResults({})
					RollSlice.activeSpecialRolls({})
					RollSlice.jackpotScreenShown(false)
					RollSlice.actions.setJackpotSpinQueue({})
					RollSlice.actions.setInstantRevealRoll(false)
				end)
				task.defer(function() -- line: 310
					-- upvalues: RollServiceClient (copy)
					RollServiceClient:roll()
				end)

				return
			end

			local v103 = true

			Vide.batch(function() -- line: 272
				-- upvalues: v103 (copy), RollSlice (copy)
				if v103 then
					RollSlice.rollScreenShown(false)
				end

				RollSlice.bonusRollResults({})
				RollSlice.rollResults({})
				RollSlice.activeSpecialRolls({})
				RollSlice.jackpotScreenShown(false)
				RollSlice.actions.setJackpotSpinQueue({})
				RollSlice.actions.setInstantRevealRoll(false)
			end)
		end)
		Vide.cleanup(function() -- line: 318
			-- upvalues: u87 (ref)
			if u87 then
				task.cancel(u87)
				u87 = nil
			end
		end)
	end)

	return Frame({
		Name = "RollScreen",
		Size = UDim2.fromScale(1, 1),
		Vide.create("ImageLabel")({
			Name = "Background",
			BackgroundTransparency = 1,
			ZIndex = 0,
			Size = UDim2.fromScale(1.25, 1.25),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = ImageIds.upgradeBg,
			ImageTransparency = v77
		}),
		ParticleEmitter2D({
			UIName = "LuckRainEmitter",
			UIZIndex = 12,
			Rate = 0,
			Drag = 0.05,
			UISize = UDim2.fromScale(1, 1),
			UIVisible = function() --[[ UIVisible ]] -- line: 345
				-- upvalues: SettingsState (copy), RollSlice (copy)
				return SettingsState.get("cloverEmitterVfx") and (RollSlice.rollScreenShown() or RollSlice.hiddenRoll() and RollSlice.rollResults()[1] ~= nil)
			end,
			Burst = RollSlice.luckRainBurst,
			Texture = function() --[[ Texture ]] -- line: 351
				-- upvalues: RollSlice (copy), ImageIds (copy), t1 (copy)
				local v88 = math.clamp(math.floor((math.log(math.max(RollSlice.luckRainMultiplier(), 1), 2))), 1, #ImageIds.luckIcons)
				local v89 = ImageIds.luckIcons[v88]

				if not t1[v88] then
					local _ = t1[#t1]
				end

				return v89
			end,
			Lifetime = NumberRange.new(1.6, 2.4),
			Speed = NumberRange.new(0.18, 0.33),
			Rotation = NumberRange.new(0, 360),
			RotSpeed = NumberRange.new(-120, 120),
			Direction = Vector2.new(0, 1),
			SpreadAngle = Vector2.new(70, 0),
			SpawnPositionMin = Vector2.new(0, -0.08),
			SpawnPositionMax = Vector2.new(1, -0.08),
			Acceleration = Vector2.new(0, 0.3),
			Size = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.08),
				NumberSequenceKeypoint.new(0.7, 0.07),
				NumberSequenceKeypoint.new(1, 0.05)
			}),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.8, 0.12),
				NumberSequenceKeypoint.new(1, 1)
			}),
			Color = function() --[[ Color ]] -- line: 375
				-- upvalues: RollSlice (copy), ImageIds (copy), t1 (copy)
				local v91 = math.clamp(math.floor((math.log(math.max(RollSlice.luckRainMultiplier(), 1), 2))), 1, #ImageIds.luckIcons)
				local _ = ImageIds.luckIcons[v91]
				local v93 = t1[v91] or t1[#t1]

				return ColorSequence.new(Color3.fromRGB(255, 255, 255), v93)
			end
		}),
		AutoScaledFrame({
			Name = "RollColumns",
			Size = function() --[[ Size ]] -- line: 384
				-- upvalues: RollSlice (copy)
				if RollSlice.hiddenRoll() then
					return UDim2.fromOffset(780, 210)
				end

				return UDim2.fromOffset(1360, 540)
			end,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = function() --[[ Position ]] -- line: 391
				-- upvalues: RollSlice (copy)
				if RollSlice.hiddenRoll() then
					return UDim2.fromScale(0.5, 0.15)
				end

				return UDim2.fromScale(0.5, 0.5)
			end,
			BackgroundTransparency = 1,
			DropShadow({
				ZIndex = 0,
				ImageTransparency = 0.55,
				Visible = RollSlice.hiddenRoll,
				Size = UDim2.fromScale(1.08, 1.1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ImageColor3 = Color3.fromRGB(0, 0, 0)
			}),
			Frame({
				Name = "RollColumnsContent",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ZIndex = 1,
				UIListLayout({
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = function() --[[ Padding ]] -- line: 422
						-- upvalues: RollSlice (copy)
						return UDim.new(0, not RollSlice.hiddenRoll() and 72 or 34)
					end
				}),
				ImageLabel({
					Name = "RollDividerLeft",
					LayoutOrder = -1,
					ImageTransparency = function() --[[ ImageTransparency ]] -- line: 428
						-- upvalues: RollSlice (copy), v77 (copy)
						if RollSlice.hiddenRoll() then
							return 0
						end

						return v77()
					end,
					Size = function() --[[ Size ]] -- line: 434
						-- upvalues: RollSlice (copy)
						if RollSlice.hiddenRoll() then
							return UDim2.fromOffset(84, 21)
						end

						return UDim2.fromOffset(126, 31.5)
					end,
					Image = ImageIds.rollDivider
				}),
				Frame({
					Name = "RollDividerRight",
					Size = function() --[[ Size ]] -- line: 447
						-- upvalues: RollSlice (copy)
						if RollSlice.hiddenRoll() then
							return UDim2.fromOffset(84, 21)
						end

						return UDim2.fromOffset(126, 31.5)
					end,
					LayoutOrder = 9999,
					ImageLabel({
						Rotation = 180,
						ImageTransparency = function() --[[ ImageTransparency ]] -- line: 456
							-- upvalues: RollSlice (copy), v77 (copy)
							if RollSlice.hiddenRoll() then
								return 0
							end

							return v77()
						end,
						Image = ImageIds.rollDivider,
						Size = UDim2.fromScale(1, 1)
					})
				}),
				Frame({
					BackgroundTransparency = 1,
					Visible = function() --[[ Visible ]] -- line: 469
						-- upvalues: RollSlice (copy)
						return #RollSlice.rollResults() == 0
					end,
					Size = getRollColumnSize
				}),
				indexes(RollSlice.rollResults, function(p4, n3: number) -- line: 476
					-- upvalues: RollColumn (copy)
					return RollColumn(p4, n3 * 100)
				end),
				indexes(RollSlice.bonusRollResults, RollColumn)
			})
		}),
		SlideFrame({
			Name = "AutoRollToggle",
			Size = UDim2.fromOffset(129, 129),
			Shown = function() --[[ Shown ]] -- line: 487
				-- upvalues: RollSlice (copy), v75 (copy), UpgradeServiceUtils (copy)
				local v96 = RollSlice.rollScreenShown()

				if v96 then
					local v97 = v75() or {}

					v96 = UpgradeServiceUtils.ownsUpgrade("autoRoll", v97)
				end

				return v96
			end,
			ShownPosition = UDim2.new(0.35, 0, 0.98, -65),
			HiddenPosition = UDim2.new(0.35, 0, 1, 80),
			Button({
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 10,
				Visible = function() --[[ Visible ]] -- line: 497
					-- upvalues: v75 (copy), UpgradeServiceUtils (copy), RollSlice (copy)
					local v98 = v75() or {}

					return UpgradeServiceUtils.ownsUpgrade("autoRoll", v98) and not RollSlice.hiddenRoll()
				end,
				Activated = function() --[[ Activated ]] -- line: 500
					-- upvalues: RollServiceClient (copy), RollSlice (copy)
					RollServiceClient:setAutoRollEnabled(not RollSlice.autoRoll())
				end,
				Image = ImageIds.autoRoll,
				ConsoleHint({
					ZIndex = 11,
					KeyCode = Enum.KeyCode.ButtonX,
					Position = UDim2.fromScale(0.18, 0.18),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(30, 30)
				}),
				TextLabel({
					RichText = true,
					Text = function() --[[ Text ]] -- line: 514
						-- upvalues: RollSlice (copy)
						if RollSlice.autoRoll() then
							return "AUTO - <font color=\"rgb(62,255,36)\">ON</font>"
						end

						return "AUTO - <font color=\"rgb(255,23,23)\">OFF</font>"
					end,
					Size = UDim2.fromScale(1, 0.2),
					Position = UDim2.fromScale(0.5, 0.9),
					AnchorPoint = Vector2.new(0.5, 1),
					Stroke = {}
				})
			})
		}),
		SlideFrame({
			Name = "HideRoll",
			Size = UDim2.fromOffset(129, 129),
			Shown = function() --[[ Shown ]] -- line: 533
				-- upvalues: RollSlice (copy), v75 (copy), UpgradeServiceUtils (copy)
				local v99 = RollSlice.rollScreenShown()

				if v99 then
					local v100 = v75() or {}

					v99 = UpgradeServiceUtils.ownsUpgrade("autoRoll", v100)
				end

				return v99
			end,
			ShownPosition = UDim2.new(0.65, 0, 0.98, -65),
			HiddenPosition = UDim2.new(0.65, 0, 1, 80),
			Button({
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 10,
				Visible = function() --[[ Visible ]] -- line: 543
					-- upvalues: v75 (copy), UpgradeServiceUtils (copy), RollSlice (copy)
					local v101 = v75() or {}

					return UpgradeServiceUtils.ownsUpgrade("autoRoll", v101) and (RollSlice.autoRoll() and not RollSlice.hiddenRoll())
				end,
				Activated = function() --[[ Activated ]] -- line: 546
					-- upvalues: Vide (copy), RollServiceClient (copy), RollSlice (copy)
					Vide.batch(function() -- line: 547
						-- upvalues: RollServiceClient (copy), RollSlice (copy)
						RollServiceClient:setHiddenRollEnabled(true)
						RollSlice.rollScreenShown(false)
					end)
				end,
				Image = ImageIds.hideRoll,
				ConsoleHint({
					ZIndex = 11,
					KeyCode = Enum.KeyCode.ButtonY,
					Position = UDim2.fromScale(0.18, 0.18),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(30, 30)
				}),
				TextLabel({
					Text = "HIDE",
					Size = UDim2.fromScale(1, 0.2),
					Position = UDim2.fromScale(0.5, 0.9),
					AnchorPoint = Vector2.new(0.5, 1),
					Stroke = {}
				})
			})
		})
	})
end

return function() -- line: 574
	-- upvalues: Vide (copy), RollSlice (copy), RollScreen (copy)
	return Vide.show(function() -- line: 575
		-- upvalues: RollSlice (copy)
		if RollSlice.rareRollCutsceneShown() or (RollSlice.rareRollCutsceneData() ~= nil or RollSlice.jackpotScreenShown()) then
			return false
		end

		if RollSlice.rollScreenShown() then
			return true
		end

		if RollSlice.hiddenRoll() and RollSlice.autoRoll() then
			return true
		end

		return RollSlice.hiddenRoll() and RollSlice.rollResults()[1] ~= nil
	end, function() -- line: 593
		-- upvalues: RollScreen (copy)
		return RollScreen(), 0.4
	end)
end
