-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollItem, time of decompilation: Sun May  3 10:11:49 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RolledIcon = require(script.Parent.RolledIcon)
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local RollServiceUtils = require(ReplicatedStorage.Source.Features.Roll.RollServiceUtils)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local GetScaledRevealTime = require(ReplicatedStorage.Source.Features.Roll.UI.GetScaledRevealTime)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local function transformGlobalProgress(n1: number) -- line: 39
	if n1 < 0.713094 then
		return (n1 - 1) ^ 2 * -1.112 + 1.112
	end

	if n1 < 0.792065 then
		return 1.03 - (n1 - 0.75) ^ 2 * 7
	end

	return (n1 - 0.919) ^ 2 * 1.9 + 0.987
end
local function transformGlobalBonusProgress(n2: number) -- line: 49
	if n2 < 0.796176 then
		return (n2 - 1) ^ 2 * -1.0705 + 1.0705
	end

	if n2 < 0.86973 then
		return 1.03 - (n2 - 0.82) ^ 2 * 7
	end

	return (n2 - 0.947) ^ 2 * 3.8 + 0.99
end
local function rollFakeResultForColumn(p1, t1: {[any]: any}) -- line: 84
	-- upvalues: RollSlice (copy), RollServiceUtils (copy), SpecialDiceServiceUtils (copy)
	local forcedMutationId = RollSlice.rollTable().forcedMutationId

	local function rollCandidate() -- line: 90
		-- upvalues: p1 (copy), RollServiceUtils (copy), SpecialDiceServiceUtils (copy), RollSlice (copy), forcedMutationId (copy)
		if p1 and RollServiceUtils.isLuckRoll(p1) then
			local v63 = RollServiceUtils.getLuckMultiplier(p1) or 1

			return SpecialDiceServiceUtils.applyToRollResult(RollServiceUtils.rollResult(RollSlice.rollTable(), nil, "LUCK", v63), forcedMutationId)
		end

		if p1 and RollServiceUtils.isBonusRoll(p1) then
			return SpecialDiceServiceUtils.applyToRollResult(RollServiceUtils.rollResult(RollSlice.rollTable(), nil, "BONUS", 1), forcedMutationId)
		end

		return SpecialDiceServiceUtils.applyToRollResult(RollServiceUtils.rollResult(RollSlice.rollTable()), forcedMutationId)
	end

	local v29 = rollCandidate()
	local g35 = nil
	local v34 = nil

	for _ = 1, 12 do
		for _, v32 in t1 do
			local v33 = v32()

			if not not v29 and if v33 then not RollServiceUtils.isNonSlimeRoll(v29) and (not RollServiceUtils.isNonSlimeRoll(v33) and v29.id == v33.id) else false then
				v34 = true
				g35 = true
			end

			if g35 then
				break
			end
		end

		if not g35 then
			v34 = false
		end

		g35 = false

		if not v34 then
			return v29
		end

		v29 = rollCandidate()
	end

	return v29
end
local function playResultSound(p2, n3: number) -- line: 124
	-- upvalues: RollServiceUtils (copy), Sounds (copy), SoundController (copy)
	if RollServiceUtils.isBonusRoll(p2) then
		local v38 = math.min((math.max(1, n3) - 1) * 0.15 + 1, 1.6)
		local v39 = table.clone(Sounds.ui.drum)

		v39.PlaybackSpeed = v38
		SoundController:Play(v39)

		return
	end

	if RollServiceUtils.isLuckRoll(p2) then
		SoundController:Play(Sounds.ui.sparkle)

		return
	end

	SoundController:Play(Sounds.ui.rollFinal)
end

return function(t2: {[any]: any}) -- line: 153
	-- upvalues: transformGlobalBonusProgress (copy), transformGlobalProgress (copy), RollSlice (copy), Vide (copy), rollFakeResultForColumn (copy), SoundController (copy), Sounds (copy), playResultSound (copy), RollServiceUtils (copy), GetScaledRevealTime (copy), Frame (copy), RolledIcon (copy)
	local v46 = if not t2.isBonus then transformGlobalProgress else transformGlobalBonusProgress
	local v47 = not t2.isBonus and 0.713094 or 0.796176
	local v48 = RollSlice.rollSpeed()
	local isBonus = t2.isBonus
	local v50 = math.clamp(v48 * 2 + 0.5, 1, 5)

	if isBonus then
		v50 *= 0.6
	end

	local v51 = math.max(2, (math.round(v50)))
	local v52 = (t2.i - 1) / 4
	local n4 = 0
	local v54 = Vide.source(1)
	local v55, v56 = Vide.spring(v54, 0.35, 0.65)
	local v57 = Vide.source(0)
	local v58 = Vide.source(UDim2.fromScale(0, 0))
	local v59 = Vide.source(1)
	local displayedResult = t2.displayedResult
	local v61 = t2.i == 3
	local u62 = false

	Vide.effect(function() -- line: 173
		-- upvalues: RollSlice (copy), v61 (copy), t2 (copy), displayedResult (copy), Vide (copy), v57 (copy), v58 (copy), v59 (copy), n4 (ref), v46 (copy), v51 (copy), v52 (copy), v47 (copy), rollFakeResultForColumn (copy), SoundController (copy), Sounds (copy)
		if RollSlice.instantRevealRoll() then
			if v61 then
				local result = t2.result

				displayedResult(result)
			end

			Vide.batch(function() -- line: 179
				-- upvalues: v57 (copy), v61 (copy), v58 (copy), v59 (copy)
				v57(not v61 and 0 or 1)
				v58(UDim2.fromScale(0.5, 0.5))
				v59(not v61 and 1 or 0)
			end)
			n4 = 1

			return
		end

		local v66 = t2.progress()
		local v67 = v46(v66)
		local v68 = (v67 * v51 % 1 + v52) % 1
		local v69 = 1 - math.clamp((v68 * 2 - 1) ^ 2 - 0.01, 0, 1)

		if v68 < n4 and v66 < v47 then
			local v70 = math.floor(v67 * v51)

			if v61 and v70 >= v51 - 1 then
				local result = t2.result

				displayedResult(result)
			else
				local v72 = rollFakeResultForColumn(t2.previousResult, t2.adjacentResults)

				displayedResult(v72)
			end
		elseif n4 < 0.5 and v68 >= 0.5 then
			SoundController:Play(Sounds.ui.rollTick)
		end

		Vide.batch(function() -- line: 206
			-- upvalues: v57 (copy), v69 (copy), v68 (copy), v58 (copy), RollSlice (copy), v59 (copy)
			v57(v69)

			local v76 = 0.5 + (v68 - 0.5) * 4

			v58(UDim2.fromScale(0.5, v76))

			local v77 = 1 - v69

			if RollSlice.hiddenRoll() then
				v77 = math.clamp(v77 * 3.2, 0, 1)
			end

			v59(v77)
		end)
		n4 = v68
	end)
	Vide.effect(function() -- line: 220
		-- upvalues: t2 (copy), v61 (copy), v54 (copy), u62 (ref), playResultSound (copy), RollServiceUtils (copy), RollSlice (copy), v56 (copy), GetScaledRevealTime (copy), Vide (copy)
		if not t2.completed() then
			return
		end

		if not v61 then
			v54(0)

			return
		end

		if not u62 then
			local result = t2.result
			local bonusStreak = t2.bonusStreak

			playResultSound(result, bonusStreak)

			if RollServiceUtils.isLuckRoll(result) then
				RollSlice.actions.triggerLuckRain(RollServiceUtils.getLuckMultiplier(result) or 2)
			end

			u62 = true
		end

		v54(1.4)

		if t2.hasNext then
			v56({
				impulse = 1
			})
			v54(1)

			return
		end

		local u75 = nil

		u75 = task.delay(GetScaledRevealTime(1.5), function() -- line: 243
			-- upvalues: v56 (copy), v54 (copy), u75 (ref)
			v56({
				impulse = 1
			})
			v54(0)
			u75 = nil
		end)
		Vide.cleanup(function() -- line: 249
			-- upvalues: u75 (ref)
			if u75 then
				task.cancel(u75)
				u75 = nil
			end
		end)
	end)

	return Frame({
		Size = function() --[[ Size ]] -- line: 258
			-- upvalues: RollSlice (copy)
			if RollSlice.hiddenRoll() then
				return UDim2.fromOffset(110, 110)
			end

			return UDim2.fromOffset(190, 190)
		end,
		Position = v58,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Vide.create("UIScale")({
			Scale = function() --[[ Scale ]] -- line: 268
				-- upvalues: v57 (copy), v55 (copy)
				return v57() * v55()
			end
		}),
		RolledIcon({
			data = displayedResult,
			transparency = v59
		})
	})
end
