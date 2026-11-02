-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthRoot, time of decompilation: Sun May  3 10:11:41 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local ConfettiSequence = require(ReplicatedStorage.Source.Core.UI.Components.ConfettiSequence)
local ScreenShake = require(ReplicatedStorage.Source.Core.UI.Components.ScreenShake)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local LuckHudState = require(ReplicatedStorage.Source.Features.Hud.LuckHudState)
local RebirthSlice = require(ReplicatedStorage.Source.Features.Rebirth.RebirthSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local uDim2 = UDim2.fromScale(0.5, 0.5)
local uDim2_2 = UDim2.new(0.5, -302, 0.5, 0)
local uDim2_3 = UDim2.new(0.5, 302, 0.5, 0)
local uDim2_4 = UDim2.new(0.5, -82, 0.5, 0)
local uDim2_5 = UDim2.new(0.5, 82, 0.5, 0)
local uDim2_6 = UDim2.fromOffset(302, 302)
local uDim2_7 = UDim2.fromOffset(269, 269)
local uDim2_8 = UDim2.fromOffset(346, 346)
local uDim2_9 = UDim2.fromOffset(43, 43)
local uDim2_10 = UDim2.fromOffset(82, 82)

local function getLuckCounterGoalPosition() -- line: 32
	-- upvalues: LuckHudState (copy)
	local v27 = LuckHudState.getCounterCenter()

	return UDim2.fromOffset(v27.X, v27.Y)
end
local function formatLuckValue(n1: number) -- line: 37
	-- upvalues: Abbreviate (copy)
	local v29 = math.round(n1 * 100) / 100

	if math.abs(v29) >= 1000 then
		return Abbreviate(v29, 4)
	end

	if v29 % 1 == 0 then
		return (tostring(v29))
	end

	return string.gsub(string.format("%.2f", v29), "%.?0+$", "")
end
local function LuckBurstCard(s1: string, p1: ((...any) -> ...any), p2: ((...any) -> ...any), p3: ((...any) -> ...any), p4: ((...any) -> ...any), p5: ((...any) -> ...any), p6: ((...any) -> ...any), n2: number) -- line: 54
	-- upvalues: ImageLabel (copy), ImageIds (copy), TextLabel (copy)
	return ImageLabel({
		Name = s1,
		Visible = p1,
		Image = ImageIds.luckIcons[1],
		ScaleType = Enum.ScaleType.Fit,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = p2,
		Size = p3,
		ImageTransparency = p4,
		ZIndex = n2,
		TextLabel({
			Name = "Amount",
			RichText = true,
			Text = p6,
			Size = UDim2.fromScale(0.7, 0.34),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextColor3 = Color3.fromRGB(240, 255, 240),
			TextTransparency = p5,
			Stroke = {
				Thickness = 4,
				Transparency = p5
			},
			DropShadow = {
				Transparency = p5
			},
			ZIndex = n2 + 1
		})
	})
end

return function() -- line: 96
	-- upvalues: RebirthSlice (copy), Vide (copy), formatLuckValue (copy), uDim2 (copy), uDim2_9 (copy), uDim2_6 (copy), SoundController (copy), Sounds (copy), uDim2_2 (copy), uDim2_3 (copy), uDim2_7 (copy), uDim2_4 (copy), uDim2_5 (copy), uDim2_8 (copy), getLuckCounterGoalPosition (copy), uDim2_10 (copy), ConfettiSequence (copy), ScreenShake (copy), Frame (copy), LuckBurstCard (copy)
	local u39 = RebirthSlice.burstId()
	local v40 = Vide.source(0)
	local v41 = Vide.source(0)
	local v42 = Vide.source(formatLuckValue(1))
	local v43 = Vide.source("x" .. string.gsub(string.format("%.2f", 1.5), "%.?0+$", ""))
	local v44 = Vide.source(formatLuckValue(1.5))
	local v45 = Vide.source(false)
	local v46 = Vide.source(false)
	local v47 = Vide.source(false)
	local v48 = Vide.source(uDim2)
	local v49 = Vide.source(uDim2)
	local v50 = Vide.source(uDim2)
	local v51 = Vide.source(uDim2_9)
	local v52 = Vide.source(uDim2_9)
	local v53 = Vide.source(uDim2_9)
	local v54 = Vide.source(1)
	local v55 = Vide.source(1)
	local v56 = Vide.source(1)
	local v57 = Vide.source(1)
	local v58 = Vide.source(1)
	local v59 = Vide.source(1)
	local v60 = Vide.spring(v48, 0.2, 0.72)
	local v61 = Vide.spring(v49, 0.2, 0.72)
	local v62 = Vide.spring(v50, 0.22, 0.74)
	local v63 = Vide.spring(v51, 0.2, 0.72)
	local v64 = Vide.spring(v52, 0.2, 0.72)
	local v65 = Vide.spring(v53, 0.22, 0.74)
	local v66 = Vide.spring(v54, 0.18, 1)
	local v67 = Vide.spring(v55, 0.18, 1)
	local v68 = Vide.spring(v56, 0.18, 1)
	local v69 = Vide.spring(v57, 0.18, 1)
	local v70 = Vide.spring(v58, 0.18, 1)
	local v71 = Vide.spring(v59, 0.18, 1)
	local t1 = {}

	local function cancelLuckBurstAnimation() -- line: 132
		-- upvalues: t1 (copy), Vide (copy), v45 (copy), v46 (copy), v47 (copy)
		for _, v76 in t1 do
			task.cancel(v76)
		end

		table.clear(t1)
		Vide.batch(function() -- line: 138
			-- upvalues: v45 (copy), v46 (copy), v47 (copy)
			v45(false)
			v46(false)
			v47(false)
		end)
	end
	local function playLuckBurstAnimation(p7) -- line: 157
		-- upvalues: cancelLuckBurstAnimation (copy), v42 (copy), formatLuckValue (copy), v43 (copy), v44 (copy), Vide (copy), v45 (copy), v46 (copy), v47 (copy), v48 (copy), uDim2 (copy), v49 (copy), v50 (copy), v51 (copy), uDim2_9 (copy), v52 (copy), v53 (copy), v54 (copy), v55 (copy), v56 (copy), v57 (copy), v58 (copy), v59 (copy), uDim2_6 (copy), SoundController (copy), Sounds (copy), t1 (copy), uDim2_2 (copy), uDim2_3 (copy), uDim2_7 (copy), uDim2_4 (copy), uDim2_5 (copy), uDim2_8 (copy), getLuckCounterGoalPosition (copy), uDim2_10 (copy)
		cancelLuckBurstAnimation()
		v42(formatLuckValue((math.max(p7.baseLuck, 1))))

		local v81 = v43
		local v82 = math.max(p7.multiplier, 1)

		v81("x" .. formatLuckValue(v82))
		v44(formatLuckValue((math.max(p7.resultLuck, 1))))
		Vide.batch(function() -- line: 163
			-- upvalues: v45 (copy), v46 (copy), v47 (copy), v48 (copy), uDim2 (copy), v49 (copy), v50 (copy), v51 (copy), uDim2_9 (copy), v52 (copy), v53 (copy), v54 (copy), v55 (copy), v56 (copy), v57 (copy), v58 (copy), v59 (copy)
			v45(true)
			v46(false)
			v47(false)
			v48(uDim2)
			v49(uDim2)
			v50(uDim2)
			v51(uDim2_9)
			v52(uDim2_9)
			v53(uDim2_9)
			v54(1)
			v55(1)
			v56(1)
			v57(1)
			v58(1)
			v59(1)
		end)

		local function v83() -- line: 181
			-- upvalues: Vide (copy), v51 (copy), uDim2_6 (copy), v54 (copy), v57 (copy), SoundController (copy), Sounds (copy)
			Vide.batch(function() -- line: 182
				-- upvalues: v51 (copy), uDim2_6 (copy), v54 (copy), v57 (copy)
				v51(uDim2_6)
				v54(0)
				v57(0)
			end)
			SoundController:Play(Sounds.misc.swoosh)
		end

		local thread = nil

		thread = task.delay(0.09, function() -- line: 147
			-- upvalues: t1 (copy), thread (ref), v83 (copy)
			local v101 = table.find(t1, thread)

			if v101 then
				table.remove(t1, v101)
			end

			v83()
		end)
		table.insert(t1, thread)

		local function v85() -- line: 190
			-- upvalues: Vide (copy), v48 (copy), uDim2_2 (copy), v46 (copy), v49 (copy), uDim2_3 (copy), v52 (copy), uDim2_7 (copy), v55 (copy), v58 (copy), SoundController (copy), Sounds (copy)
			Vide.batch(function() -- line: 191
				-- upvalues: v48 (copy), uDim2_2 (copy), v46 (copy), v49 (copy), uDim2_3 (copy), v52 (copy), uDim2_7 (copy), v55 (copy), v58 (copy)
				v48(uDim2_2)
				v46(true)
				v49(uDim2_3)
				v52(uDim2_7)
				v55(0)
				v58(0)
			end)
			SoundController:Play(Sounds.misc.swoosh)
		end

		local thread2 = nil

		thread2 = task.delay(1.26, function() -- line: 147
			-- upvalues: t1 (copy), thread2 (ref), v85 (copy)
			local v102 = table.find(t1, thread2)

			if v102 then
				table.remove(t1, v102)
			end

			v85()
		end)
		table.insert(t1, thread2)

		local function v87() -- line: 202
			-- upvalues: Vide (copy), v48 (copy), uDim2_4 (copy), v49 (copy), uDim2_5 (copy)
			Vide.batch(function() -- line: 203
				-- upvalues: v48 (copy), uDim2_4 (copy), v49 (copy), uDim2_5 (copy)
				v48(uDim2_4)
				v49(uDim2_5)
			end)
		end

		local thread3 = nil

		thread3 = task.delay(2.46, function() -- line: 147
			-- upvalues: t1 (copy), thread3 (ref), v87 (copy)
			local v103 = table.find(t1, thread3)

			if v103 then
				table.remove(t1, v103)
			end

			v87()
		end)
		table.insert(t1, thread3)

		local function v89() -- line: 209
			-- upvalues: Vide (copy), v54 (copy), v55 (copy), v57 (copy), v58 (copy), v47 (copy), v50 (copy), uDim2 (copy), v53 (copy), v56 (copy), v59 (copy), SoundController (copy), Sounds (copy)
			Vide.batch(function() -- line: 210
				-- upvalues: v54 (copy), v55 (copy), v57 (copy), v58 (copy), v47 (copy), v50 (copy), uDim2 (copy), v53 (copy), v56 (copy), v59 (copy)
				v54(1)
				v55(1)
				v57(1)
				v58(1)
				v47(true)
				v50(uDim2)
				v53(UDim2.fromOffset(403, 403))
				v56(0)
				v59(0)
			end)
			SoundController:Play(Sounds.misc.luckCombination)
		end

		local thread4 = nil

		thread4 = task.delay(2.52, function() -- line: 147
			-- upvalues: t1 (copy), thread4 (ref), v89 (copy)
			local v104 = table.find(t1, thread4)

			if v104 then
				table.remove(t1, v104)
			end

			v89()
		end)
		table.insert(t1, thread4)

		local function v91() -- line: 224
			-- upvalues: v53 (copy), uDim2_8 (copy)
			v53(uDim2_8)
		end

		local thread5 = nil

		thread5 = task.delay(2.62, function() -- line: 147
			-- upvalues: t1 (copy), thread5 (ref), v91 (copy)
			local v105 = table.find(t1, thread5)

			if v105 then
				table.remove(t1, v105)
			end

			v91()
		end)
		table.insert(t1, thread5)

		local function v93() -- line: 228
			-- upvalues: Vide (copy), v45 (copy), v46 (copy)
			Vide.batch(function() -- line: 229
				-- upvalues: v45 (copy), v46 (copy)
				v45(false)
				v46(false)
			end)
		end

		local thread6 = nil

		thread6 = task.delay(3.48, function() -- line: 147
			-- upvalues: t1 (copy), thread6 (ref), v93 (copy)
			local v106 = table.find(t1, thread6)

			if v106 then
				table.remove(t1, v106)
			end

			v93()
		end)
		table.insert(t1, thread6)

		local function v95() -- line: 235
			-- upvalues: Vide (copy), v50 (copy), getLuckCounterGoalPosition (copy), v56 (copy), v59 (copy), v53 (copy), uDim2_10 (copy)
			Vide.batch(function() -- line: 236
				-- upvalues: v50 (copy), getLuckCounterGoalPosition (copy), v56 (copy), v59 (copy), v53 (copy), uDim2_10 (copy)
				v50(getLuckCounterGoalPosition())
				v56(1)
				v59(1)
				v53(uDim2_10)
			end)
		end

		local thread7 = nil

		thread7 = task.delay(4.16, function() -- line: 147
			-- upvalues: t1 (copy), thread7 (ref), v95 (copy)
			local v107 = table.find(t1, thread7)

			if v107 then
				table.remove(t1, v107)
			end

			v95()
		end)
		table.insert(t1, thread7)

		local function v97() -- line: 244
			-- upvalues: v47 (copy)
			v47(false)
		end

		local thread8 = nil

		thread8 = task.delay(6.06, function() -- line: 147
			-- upvalues: t1 (copy), thread8 (ref), v97 (copy)
			local v108 = table.find(t1, thread8)

			if v108 then
				table.remove(t1, v108)
			end

			v97()
		end)
		table.insert(t1, thread8)
	end

	Vide.effect(function() -- line: 249
		-- upvalues: RebirthSlice (copy), u39 (ref), v40 (copy), v41 (copy), playLuckBurstAnimation (copy)
		local v99 = RebirthSlice.burstId()

		if v99 == u39 then
			return
		end

		u39 = v99
		v40(v40() + 1)
		v41(v41() + 1)
		playLuckBurstAnimation(RebirthSlice.latestBurst())
	end)
	Vide.cleanup(cancelLuckBurstAnimation)

	return {
		ConfettiSequence({
			Name = "RebirthConfetti",
			ZIndex = 60,
			Trigger = v40
		}),
		ScreenShake({
			Name = "RebirthShake",
			Duration = 0.9,
			PositionStrength = 0.55,
			RotationStrength = 0.04363323129985824,
			BindName = "RebirthCameraShake",
			Trigger = v41
		}),
		Frame({
			Name = "RebirthLuckBurstLayer",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Visible = function() --[[ Visible ]] -- line: 283
				-- upvalues: v45 (copy), v46 (copy), v47 (copy)
				return v45() or (v46() or v47())
			end,
			ZIndex = 70,
			LuckBurstCard("CurrentLuckBurst", v45, v60, v63, v66, v69, v42, 71),
			LuckBurstCard("MultiplierLuckBurst", v46, v61, v64, v67, v70, v43, 73),
			LuckBurstCard("ResultLuckBurst", v47, v62, v65, v68, v71, v44, 75)
		})
	}
end
