-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollSlice, time of decompilation: Sun May  3 10:11:44 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local n1 = 0
local v4 = Vide.source(false)
local v5 = Vide.source(false)
local v6 = Vide.source(false)
local v7 = Vide.source(false)
local v8 = Vide.source({})
local v9 = Vide.source(nil)
local v10 = Vide.source(0)
local v11 = Vide.source(2)
local v12 = Vide.source(1)
local v13 = Vide.source(1)
local v14 = Vide.source(false)
local v15 = Vide.source(3)
local v16 = Vide.source(false)
local v17 = Vide.source(nil)
local v18 = Vide.source(nil)
local v19 = Vide.source({})
local v20 = Vide.source(nil)
local v21 = Vide.source(false)
local v22 = Vide.source(false)
local v23 = Vide.source(false)
local v24 = Vide.source(false)
local v25 = Vide.source({
	luck = 1,
	maxLuck = 1,
	luckOverridden = false,
	rolls = 0,
	columns = 1,
	extraRollChance = 0,
	jackpotChance = 0.001,
	luckRollChance = 0.18,
	rollTime = 3,
	rollSpeedMultiplier = 1,
	activeSpecialRolls = {}
})
local v26 = Vide.source({})
local v27 = Vide.source({})
local v28 = Vide.source({})
local v29 = Vide.source({})
local v30 = Vide.source(3)

return {
	actions = {
		addBonusRoll = function(p1, n2: number) --[[ addBonusRoll ]] -- line: 77
			-- upvalues: v27 (copy)
			local v40 = table.clone(v27())

			v40[n2] = p1
			v27(v40)
		end,
		registerRollCompletion = function() --[[ registerRollCompletion ]] -- line: 83
			-- upvalues: n1 (ref), v29 (copy)
			n1 += 1

			local str = tostring(n1)
			local v42 = table.clone(v29())

			v42[str] = false
			v29(v42)

			local function updateCompletion(b1: boolean?) -- line: 90
				-- upvalues: v29 (copy), str (copy)
				local v76 = table.clone(v29())

				v76[str] = b1
				v29(v76)
			end

			return {
				complete = function() --[[ complete ]] -- line: 97
					-- upvalues: v29 (copy), str (copy)
					local v77 = table.clone(v29())

					v77[str] = true
					v29(v77)
				end,
				destroy = function() --[[ destroy ]] -- line: 100
					-- upvalues: updateCompletion (copy)
					task.defer(updateCompletion, nil)
				end
			}
		end,
		resetRollCompletions = function() --[[ resetRollCompletions ]] -- line: 107
			-- upvalues: v29 (copy)
			v29({})
		end,
		setInstantRevealRoll = function(b2: boolean) --[[ setInstantRevealRoll ]] -- line: 111
			-- upvalues: v24 (copy)
			v24(b2)
		end,
		setResolvedRollStats = function(t1: {[any]: any}) --[[ setResolvedRollStats ]] -- line: 115
			-- upvalues: Vide (copy), v12 (copy), v13 (copy), v14 (copy), v30 (copy), v15 (copy)
			local v46 = t1.luck or 1
			local v47 = t1.maxLuck or v46
			local v48 = t1.rollTime or 3

			Vide.batch(function() -- line: 119
				-- upvalues: v12 (copy), v46 (copy), v13 (copy), v47 (copy), v14 (copy), t1 (copy), v30 (copy), v48 (copy), v15 (copy)
				v12(v46)
				v13(v47)
				v14(t1.luckOverridden == true)
				v30(v48)
				v15(v48)
			end)
		end,
		setRollTable = function(p2) --[[ setRollTable ]] -- line: 128
			-- upvalues: Vide (copy), v25 (copy), v12 (copy), v13 (copy), v14 (copy), v30 (copy), v15 (copy)
			local v50 = p2.rollTime or 3

			Vide.batch(function() -- line: 130
				-- upvalues: v25 (copy), p2 (copy), v12 (copy), v13 (copy), v14 (copy), v30 (copy), v50 (copy), v15 (copy)
				v25(p2)
				v12(p2.luck or 1)
				v13(p2.maxLuck or (p2.luck or 1))
				v14(p2.luckOverridden == true)
				v30(v50)
				v15(v50)
			end)
		end,
		setJackpotSpinData = function(p3) --[[ setJackpotSpinData ]] -- line: 140
			-- upvalues: Vide (copy), v8 (copy), v9 (copy)
			local v52 = if not p3 then {} else { p3 }

			Vide.batch(function() -- line: 142
				-- upvalues: v8 (copy), v52 (copy), v9 (copy), p3 (copy)
				v8(v52)
				v9(p3)
			end)
		end,
		setJackpotSpinQueue = function(t2: {[any]: any}?) --[[ setJackpotSpinQueue ]] -- line: 148
			-- upvalues: Vide (copy), v8 (copy), v9 (copy)
			local v54 = t2 or {}

			Vide.batch(function() -- line: 150
				-- upvalues: v8 (copy), v54 (copy), v9 (copy)
				v8(v54)
				v9(v54[1])
			end)
		end,
		hasQueuedJackpotSpin = function() --[[ hasQueuedJackpotSpin ]] -- line: 156
			-- upvalues: v8 (copy)
			return #v8() > 1
		end,
		advanceJackpotSpinQueue = function() --[[ advanceJackpotSpinQueue ]] -- line: 160
			-- upvalues: v8 (copy), Vide (copy), v9 (copy)
			local v55 = v8()

			if #v55 <= 1 then
				return false
			end

			local v56 = table.clone(v55)

			table.remove(v56, 1)
			Vide.batch(function() -- line: 168
				-- upvalues: v8 (copy), v56 (copy), v9 (copy)
				v8(v56)
				v9(v56[1])
			end)

			return true
		end,
		showJackpotScreen = function() --[[ showJackpotScreen ]] -- line: 175
			-- upvalues: v7 (copy)
			v7(true)
		end,
		clearJackpotPresentation = function() --[[ clearJackpotPresentation ]] -- line: 179
			-- upvalues: Vide (copy), v7 (copy), v8 (copy), v9 (copy)
			Vide.batch(function() -- line: 180
				-- upvalues: v7 (copy), v8 (copy), v9 (copy)
				v7(false)
				v8({})
				v9(nil)
			end)
		end,
		triggerLuckRain = function(n3: number) --[[ triggerLuckRain ]] -- line: 187
			-- upvalues: Vide (copy), v11 (copy), v10 (copy)
			task.defer(function() -- line: 189
				-- upvalues: Vide (copy), v11 (copy), n3 (copy), v10 (copy)
				Vide.batch(function() -- line: 190
					-- upvalues: v11 (copy), n3 (copy), v10 (copy)
					v11(n3)
					v10(v10() + 28)
				end)
			end)
		end,
		showRareRollCutscene = function(p4) --[[ showRareRollCutscene ]] -- line: 197
			-- upvalues: Vide (copy), v24 (copy), v18 (copy), v17 (copy), v16 (copy)
			Vide.batch(function() -- line: 198
				-- upvalues: v24 (copy), v18 (copy), v17 (copy), p4 (copy), v16 (copy)
				v24(false)
				v18(nil)
				v17(p4)
				v16(true)
			end)
		end,
		armRareRollCutscene = function(p5) --[[ armRareRollCutscene ]] -- line: 206
			-- upvalues: v18 (copy)
			v18(p5)
		end,
		clearPendingRareRollCutscene = function() --[[ clearPendingRareRollCutscene ]] -- line: 210
			-- upvalues: v18 (copy)
			v18(nil)
		end,
		beginNewSlimeRoll = function() --[[ beginNewSlimeRoll ]] -- line: 214
			-- upvalues: Vide (copy), v23 (copy), v21 (copy), v22 (copy)
			Vide.batch(function() -- line: 215
				-- upvalues: v23 (copy), v21 (copy), v22 (copy)
				v23(true)
				v21(false)
				v22(false)
			end)
		end,
		clearAutoEquipPending = function() --[[ clearAutoEquipPending ]] -- line: 222
			-- upvalues: v23 (copy)
			v23(false)
		end,
		setNewSlimeQueue = function(t3: {[any]: any}) --[[ setNewSlimeQueue ]] -- line: 226
			-- upvalues: v19 (copy), v20 (copy), Vide (copy), v22 (copy)
			local v61 = t3 or {}

			if #v61 == 0 then
				return
			end

			local v62 = table.clone(v19())
			local g69 = nil
			local v68 = nil

			for _, v64 in v61 do
				local v65 = v20()

				if v65 == nil or v65.id ~= v64.id then
					for v66, v67 in v62 do
						if v67.id == v64.id then
							v68 = v66
							g69 = true
						end

						if g69 then
							break
						end
					end

					if not g69 then
						v68 = nil
					end

					g69 = false

					if v68 == nil then
						table.insert(v62, v64)
					else
						local mutations = v62[v68].mutations

						if type(mutations) ~= "table" or next(mutations) == nil then
							local mutations2 = v64.mutations

							if type(mutations2) == "table" and next(mutations2) ~= nil then
								v62[v68] = v64
							end
						end
					end
				end
			end

			Vide.batch(function() -- line: 247
				-- upvalues: v19 (copy), v62 (copy), v22 (copy)
				v19(v62)
				v22(true)
			end)
		end,
		markNewSlimePopupReady = function() --[[ markNewSlimePopupReady ]] -- line: 253
			-- upvalues: v21 (copy)
			v21(true)
		end,
		showNextNewSlimePopup = function() --[[ showNextNewSlimePopup ]] -- line: 257
			-- upvalues: v21 (copy), v20 (copy), v19 (copy), Vide (copy)
			if not v21() or v20() ~= nil then
				return
			end

			local v72 = v19()
			local v73 = v72[1]

			if v73 == nil then
				return
			end

			local v74 = table.clone(v72)

			table.remove(v74, 1)
			Vide.batch(function() -- line: 270
				-- upvalues: v19 (copy), v74 (copy), v20 (copy), v73 (copy)
				v19(v74)
				v20(v73)
			end)
		end,
		dismissNewSlime = function() --[[ dismissNewSlime ]] -- line: 276
			-- upvalues: v20 (copy)
			if v20() == nil then
				return
			end

			v20(nil)
		end,
		clearRareRollCutscene = function() --[[ clearRareRollCutscene ]] -- line: 284
			-- upvalues: Vide (copy), v18 (copy), v16 (copy), v17 (copy)
			Vide.batch(function() -- line: 285
				-- upvalues: v18 (copy), v16 (copy), v17 (copy)
				v18(nil)
				v16(false)
				v17(nil)
			end)
		end,
		finishRareRollCutscene = function() --[[ finishRareRollCutscene ]] -- line: 292
			-- upvalues: Vide (copy), v18 (copy), v16 (copy), v17 (copy), v24 (copy)
			Vide.batch(function() -- line: 293
				-- upvalues: v18 (copy), v16 (copy), v17 (copy), v24 (copy)
				v18(nil)
				v16(false)
				v17(nil)
				v24(true)
			end)
		end
	},
	rollScreenShown = v5,
	rollResults = v26,
	bonusRollResults = v27,
	hiddenRoll = v4,
	luck = v12,
	maxLuck = v13,
	luckOverridden = v14,
	rollTime = v30,
	rollSpeed = v15,
	rollTable = v25,
	rollComplete = function() -- line: 48
		-- upvalues: v29 (copy)
		if next(v29()) == nil then
			return false
		end

		for _, v32 in v29() do
			if not v32 then
				return false
			end
		end

		return true
	end,
	autoRoll = v6,
	jackpotScreenShown = v7,
	jackpotSpinQueue = v8,
	jackpotSpinData = v9,
	activeSpecialRolls = v28,
	luckRainBurst = v10,
	luckRainMultiplier = v11,
	newSlimeQueue = v19,
	activeNewSlimePopupData = v20,
	newSlimePopupReady = v21,
	newSlimePopupSeenThisRoll = v22,
	autoEquipPending = v23,
	rareRollCutsceneShown = v16,
	rareRollCutsceneData = v17,
	pendingRareRollCutsceneData = v18,
	instantRevealRoll = v24
}
