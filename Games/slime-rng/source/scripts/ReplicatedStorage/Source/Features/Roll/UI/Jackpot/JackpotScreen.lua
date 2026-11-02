-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JackpotScreen, time of decompilation: Sun May  3 10:11:51 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local ConsoleHint = require(ReplicatedStorage.Source.Core.UI.Components.ConsoleHint)
local ConfettiSequence = require(ReplicatedStorage.Source.Core.UI.Components.ConfettiSequence)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local RollServiceClient = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local JackpotWheel = require(script.Parent.Components.JackpotWheel)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local vector2 = Vector2.new(952, 178)

local function JackpotContent(t1: {[any]: any}) -- line: 46
	-- upvalues: getDataSource (copy), Vide (copy), Sounds (copy), UpgradeServiceUtils (copy), RollServiceClient (copy), TweenService (copy), RollSlice (copy), SoundController (copy), RunService (copy), JackpotWheel (copy), Frame (copy), ImageLabel (copy), ImageIds (copy), SlideFrame (copy), vector2 (copy), TextLabel (copy), UIListLayout (copy), ConfettiSequence (copy), Button (copy), ConsoleHint (copy)
	local v28 = getDataSource("upgrades")
	local v29 = #t1
	local v30 = Vide.source(false)
	local v31 = Vide.source(0)
	local v32 = Vide.source(0)
	local v33 = Vide.source(false)
	local v34 = Vide.source(1)
	local v35 = Vide.source(true)
	local v36 = Vide.source(true)
	local u37 = nil
	local u38 = false
	local u39 = false
	local u40 = nil
	local v41 = Sounds.ui.jackpotRingLoop.Volume or 0.5
	local u42 = nil
	local n1 = 0
	local n2 = 0
	local n3 = 0

	local function shouldShowAutoRollToggle() -- line: 70
		-- upvalues: UpgradeServiceUtils (copy), v28 (copy), RollServiceClient (copy)
		return UpgradeServiceUtils.ownsUpgrade("autoRoll", v28() or {}) and RollServiceClient:hasArmedJackpotSpin()
	end
	local function stopRingLoop(b1: boolean) -- line: 81
		-- upvalues: u40 (ref), u42 (ref), TweenService (copy)
		local v59 = u40

		if not v59 then
			return
		end

		if u42 then
			u42:Cancel()
			u42 = nil
		end

		if b1 then
			v59.Volume = 0
			v59:Stop()
			u40 = nil

			return
		end

		u42 = TweenService:Create(v59, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Volume = 0
		})

		local v60 = u42
		local u61 = nil

		u61 = v60.Completed:Connect(function() -- line: 104
			-- upvalues: u61 (ref), u42 (ref), v60 (copy), u40 (ref), v59 (copy)
			if u61 then
				u61:Disconnect()
				u61 = nil
			end

			if u42 == v60 then
				u42 = nil
			end

			if u40 == v59 then
				v59:Stop()
				u40 = nil
			end
		end)
		v60:Play()
	end
	local function finalizeRollFlow() -- line: 137
		-- upvalues: RollSlice (copy), Vide (copy), RollServiceClient (copy)
		if RollSlice.autoRoll() then
			local v63 = false

			Vide.batch(function() -- line: 124
				-- upvalues: v63 (copy), RollSlice (copy)
				if v63 then
					RollSlice.rollScreenShown(false)
				end

				RollSlice.bonusRollResults({})
				RollSlice.rollResults({})
				RollSlice.activeSpecialRolls({})
				RollSlice.jackpotScreenShown(false)
				RollSlice.actions.setJackpotSpinQueue({})
				RollSlice.actions.setInstantRevealRoll(false)
			end)
			task.defer(function() -- line: 140
				-- upvalues: RollServiceClient (copy)
				RollServiceClient:roll()
			end)

			return
		end

		local v64 = true

		Vide.batch(function() -- line: 124
			-- upvalues: v64 (copy), RollSlice (copy)
			if v64 then
				RollSlice.rollScreenShown(false)
			end

			RollSlice.bonusRollResults({})
			RollSlice.rollResults({})
			RollSlice.activeSpecialRolls({})
			RollSlice.jackpotScreenShown(false)
			RollSlice.actions.setJackpotSpinQueue({})
			RollSlice.actions.setInstantRevealRoll(false)
		end)
	end

	SoundController:Play(Sounds.misc.cutsceneStart)

	local v49 = table.clone(Sounds.ui.jackpotRingLoop)

	v49.Looped = true
	v49.LoopRegion = v49.PlaybackRegion
	v49.Volume = 0

	local Sound = SoundController:GetSound(v49)

	Sound.TimePosition = 0
	Sound:Play()
	u40 = Sound
	u42 = TweenService:Create(Sound, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Volume = v41
	})
	u42:Play()
	Vide.effect(function() -- line: 169
		-- upvalues: RunService (copy), v33 (copy), v30 (copy), v34 (copy), v32 (copy), n1 (ref), Vide (copy)
		local connection = RunService.Heartbeat:Connect(function(dt) -- line: 170
			-- upvalues: v33 (copy), v30 (copy), v34 (copy), v32 (copy), n1 (ref)
			if v33() or v30() then
				v34(1)

				return
			end

			local v71 = v32()
			local v72 = 7 + -4.9 * v71
			local v73 = math.max(0, 1 - v71) * 0.07

			n1 += v72 * dt
			v34(math.abs((math.sin(n1))) * v73 + 1)
		end)

		Vide.cleanup(function() -- line: 183
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
	end)
	Vide.cleanup(function() -- line: 235
		-- upvalues: u37 (ref), u40 (ref), u42 (ref)
		if u37 then
			task.cancel(u37)
			u37 = nil
		end

		local v67 = u40

		if not v67 then
			return
		end

		if u42 then
			u42:Cancel()
			u42 = nil
		end

		v67.Volume = 0
		v67:Stop()
		u40 = nil
	end)

	local t2 = {}

	for v52, v53 in t1 do
		local v54 = JackpotWheel
		local t3 = {
			spinData = v53,
			onComplete = function(_) --[[ onWheelComplete ]] -- line: 214
				-- upvalues: u38 (ref), n3 (ref), v29 (copy), v30 (copy), v35 (copy), v36 (copy), u37 (ref), finalizeRollFlow (copy)
				if u38 then
					return
				end

				n3 += 1

				if n3 < v29 then
					return
				end

				u38 = true
				v30(true)
				v35(false)
				v36(false)
				u37 = task.delay(0.35, function() -- line: 229
					-- upvalues: u37 (ref), finalizeRollFlow (copy)
					u37 = nil
					finalizeRollFlow()
				end)
			end,
			onFinalTick = function() --[[ onWheelFinalTick ]] -- line: 201
				-- upvalues: u39 (ref), n2 (ref), v29 (copy), v33 (copy), v34 (copy), stopRingLoop (copy), SoundController (copy), Sounds (copy), v31 (copy)
				if u39 then
					return
				end

				n2 += 1

				if n2 < v29 then
					return
				end

				if u39 then
					return
				end

				u39 = true
				v33(true)
				v34(1)
				stopRingLoop(false)
				SoundController:Play(Sounds.ui.jackpotFinal)
				v31(v31() + 1)
			end,
			onProgress = function(p2) --[[ onProgress ]] -- line: 249
				-- upvalues: v32 (copy)
				v32((math.max(v32(), p2)))
			end,
			playTickSounds = v52 == 1
		}
		local uDim2

		if v29 <= 1 then
			uDim2 = UDim2.fromScale(0.5, 0.57)
		else
			local v57 = (v29 + 1) / 2

			uDim2 = UDim2.fromScale((v52 - v57) * 0.34 + 0.5, 0.58)
		end

		t3.position = uDim2
		t3.scale = not (v29 > 1) and 1 or 1
		t3.zIndex = v52 * 20 + 5006
		table.insert(t2, (v54(t3)))
	end

	return Frame({
		Name = "JackpotScreen",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 5000,
		ImageLabel({
			Name = "Background",
			ImageTransparency = 0.08,
			ZIndex = 5000,
			Size = UDim2.fromScale(1.25, 1.25),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = ImageIds.upgradeBg
		}),
		SlideFrame({
			Name = "JackpotTitleGroupSlide",
			Shown = v35,
			ShownPosition = UDim2.fromScale(0.5, 0.12),
			HiddenPosition = UDim2.fromScale(0.5, -0.08),
			CanStartShown = false,
			Size = function() --[[ Size ]] -- line: 283
				-- upvalues: vector2 (copy), v34 (copy)
				return UDim2.fromOffset(vector2.X * v34(), vector2.Y * v34())
			end,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			ZIndex = 5004,
			TextLabel({
				Name = "JackpotTitle",
				BackgroundTransparency = 1,
				RichText = true,
				ZIndex = 5004,
				Size = UDim2.fromScale(1, 0.62),
				Position = UDim2.fromScale(0.5, 0.3),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = not (v29 > 1) and "BONUS JACKPOT" or "BONUS JACKPOTS",
				TextColor3 = Color3.fromRGB(255, 253, 231),
				Stroke = {
					Thickness = 5,
					Color = Color3.fromRGB(97, 49, 16)
				},
				Gradient = {
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 229, 145)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 151, 61))
					})
				},
				DropShadow = {
					Transparency = 0.35,
					Offset = UDim2.fromOffset(0, 8)
				}
			}),
			TextLabel({
				Name = "JackpotSubtitle",
				BackgroundTransparency = 1,
				RichText = true,
				Text = "1000X LUCK BONUS WHEEL",
				ZIndex = 5004,
				Size = UDim2.fromScale(0.8, 0.24),
				Position = UDim2.fromScale(0.5, 0.7),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextColor3 = Color3.fromRGB(255, 241, 201),
				Stroke = {
					Thickness = 3,
					Color = Color3.fromRGB(56, 29, 10)
				}
			})
		}),
		SlideFrame({
			Name = "JackpotWheelSlide",
			Shown = v36,
			ShownPosition = UDim2.fromScale(0.5, 0.6),
			HiddenPosition = UDim2.fromScale(0.5, 1.5),
			CanStartShown = false,
			Size = UDim2.fromScale(1, 0.78),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			ZIndex = 5006,
			t2,
			UIListLayout({
				Padding = UDim.new(0.05, 0),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder
			})
		}),
		ConfettiSequence({
			Name = "JackpotConfetti",
			Preset = "sideCannons",
			ZIndex = 100000,
			Trigger = v31
		}),
		SlideFrame({
			Name = "JackpotAutoRollToggle",
			Size = UDim2.fromOffset(129, 129),
			AnchorPoint = Vector2.new(0, 1),
			Shown = shouldShowAutoRollToggle,
			ShownPosition = UDim2.fromScale(0.02, 0.98),
			HiddenPosition = UDim2.fromScale(-0.2, 0.98),
			ZIndex = 5015,
			Button({
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				ZIndex = 5016,
				Visible = shouldShowAutoRollToggle,
				Activated = function() --[[ Activated ]] -- line: 382
					-- upvalues: RollServiceClient (copy), RollSlice (copy)
					RollServiceClient:setAutoRollEnabled(not RollSlice.autoRoll())
				end,
				Image = ImageIds.autoRoll,
				ConsoleHint({
					ZIndex = 5017,
					KeyCode = Enum.KeyCode.ButtonX,
					Position = UDim2.fromScale(0.18, 0.18),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(30, 30)
				}),
				TextLabel({
					RichText = true,
					ZIndex = 5017,
					Text = function() --[[ Text ]] -- line: 396
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
		})
	})
end

return function() -- line: 415
	-- upvalues: Vide (copy), RollSlice (copy), JackpotContent (copy)
	return Vide.show(function() -- line: 416
		-- upvalues: RollSlice (copy)
		return RollSlice.jackpotScreenShown() and #RollSlice.jackpotSpinQueue() > 0
	end, function() -- line: 418
		-- upvalues: RollSlice (copy), JackpotContent (copy)
		local v69 = RollSlice.jackpotSpinQueue()

		assert(#v69 > 0, "Expected jackpot spin queue while jackpot screen is shown")

		return JackpotContent(v69), 0
	end)
end
