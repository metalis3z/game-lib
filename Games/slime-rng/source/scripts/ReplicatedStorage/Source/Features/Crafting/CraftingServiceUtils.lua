-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingServiceUtils, time of decompilation: Sun May  3 10:12:23 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local Recipes = require(ReplicatedStorage.Source.Features.Crafting.Recipes)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)
local v8 = table.clone(Recipes.getRecipes())

table.sort(v8, function(p1, p2) -- line: 35
	-- upvalues: Slimes (copy)
	local v17 = Slimes.getSlime(p1.outputId)
	local v18 = Slimes.getSlime(p2.outputId)
	local v19 = p1.layoutOrder or v17.layout
	local v20 = p2.layoutOrder or v18.layout

	if v19 == v20 then
		return p1.id < p2.id
	end

	return v19 < v20
end)

local t1 = {
	CRAFTING_MACHINE_UNLOCK_KEY = "craftingMachine",
	CRAFTING_MACHINE_UNLOCK_PRICE = 1000000,
	CRAFTING_MACHINE_USE_RADIUS = 10,
	AUTO_CRAFT_INTERVAL_SECONDS = 5,
	RECIPE_TAG = "Recipe",
	RECIPE_KEY_ATTRIBUTE = "key",
	RECIPE_CLAIM_MAX_DISTANCE = 10,
	RECIPE_CLAIM_VALIDATE_DISTANCE_BUFFER = 4
}

local function getRollOutcomeFromChanceMap(t2: {[any]: any}, t3: {[any]: any}) -- line: 82
	local v33 = math.random()
	local n1 = 0

	for _, v36 in t3 do
		n1 += math.clamp(t2[v36] or 0, 0, 1)

		if v33 < n1 then
			return v36
		end
	end

	return nil
end
local function getInheritedMutationChances(p3, t4: {[any]: any}) -- line: 110
	-- upvalues: InventoryServiceUtils (copy), t1 (copy), Mutations (copy)
	local v41 = InventoryServiceUtils.getVisualOdds(t1.getOutputDisplayData(p3))
	local t5 = {}

	if v41 <= 0 then
		return t5
	end

	for _, v44 in t4 do
		local v45 = InventoryServiceUtils.getBaseOdds(v44)

		if not (v45 <= 0) then
			local v46 = math.clamp((v41 / v45) ^ 2.2, 0, 1)

			if not (v46 <= 0) then
				local v47 = Mutations.getSizeMutationId(v44.mutations)

				if v47 ~= nil then
					t5[v47] = math.clamp((t5[v47] or 0) + v46, 0, 1)
				end

				for _, v49 in Mutations.modifierMutations do
					if Mutations.has(v44.mutations, v49) then
						t5[v49] = math.clamp((t5[v49] or 0) + v46, 0, 1)
					end
				end
			end
		end
	end

	return t5
end
local function getBaseSizeMutationChances(p4) -- line: 143
	-- upvalues: Mutations (copy)
	local t6 = {}

	for _, v53 in Mutations.sizeMutations do
		t6[v53] = if p4 == nil or p4[v53] == true then math.clamp(Mutations.get(v53).odds, 0, 1) else 0
	end

	return t6
end
local function getFinalSizeMutationChances(t7: {[any]: any}, p5) -- line: 152
	-- upvalues: getBaseSizeMutationChances (copy), Mutations (copy)
	local v56 = getBaseSizeMutationChances(p5)
	local t8 = {}
	local n2 = 0

	for _, v60 in Mutations.sizeMutations do
		n2 += t7[v60] or 0
	end

	local v61 = math.clamp(1 - n2, 0, 1)
	local n3 = 0

	for _, v64 in Mutations.sizeMutations do
		n3 += v56[v64] or 0
	end

	local v65 = math.clamp(1 - n3, 0, 1)
	local t9 = {{
		id = nil,
		chance = v61
	}}
	local t10 = {{
		id = nil,
		chance = v65
	}}

	for _, v69 in Mutations.sizeMutations do
		table.insert(t9, {
			id = v69,
			chance = math.clamp(t7[v69] or 0, 0, 1)
		})
		table.insert(t10, {
			id = v69,
			chance = math.clamp(v56[v69] or 0, 0, 1)
		})
	end

	for _, v71 in t9 do
		for _, v73 in t10 do
			local id = v71.id
			local id2 = v73.id
			local v76 = if id ~= nil then if id2 ~= nil then if not (Mutations.get(id).value >= Mutations.get(id2).value) then id2 else id else id else id2

			if v76 ~= nil then
				t8[v76] = (t8[v76] or 0) + v71.chance * v73.chance
			end
		end
	end

	return t8
end
local function buildInventoryEntries(t11: {[any]: any}) -- line: 195
	-- upvalues: InventoryServiceUtils (copy)
	local t12 = {}

	for v80, v81 in t11 do
		table.insert(t12, {
			uniqueId = v80,
			ownedAmount = type(v81) ~= "number" and 1 or math.max(v81, 0),
			slimeData = InventoryServiceUtils.getSlimeData(v80, v81),
			stackable = type(v81) == "number"
		})
	end

	table.sort(t12, function(t13: {[any]: any}, t14: {[any]: any}) -- line: 207
		if t13.stackable ~= t14.stackable then
			return t13.stackable
		end

		if t13.slimeData.level ~= t14.slimeData.level then
			return t13.slimeData.level < t14.slimeData.level
		end

		if t13.slimeData.xp ~= t14.slimeData.xp then
			return t13.slimeData.xp < t14.slimeData.xp
		end

		return t13.uniqueId < t14.uniqueId
	end)

	return t12
end

function t1.getRecipes() -- line: 224
	-- upvalues: v8 (copy)
	return v8
end
function t1.getRecipe(s1: string) -- line: 228
	-- upvalues: Recipes (copy)
	return Recipes.getRecipe(s1)
end
function t1.isRecipeOwned(t15: {[any]: any}?, s2: string) -- line: 232
	return t15 ~= nil and t15[s2] == true
end
function t1.canPurchaseRecipe(p6) -- line: 236
	return type(p6.unlockPrice) == "number" and p6.unlockPrice > 0
end
function t1.isRecipeVisible(p7, t16: {[any]: any}?) -- line: 240
	-- upvalues: t1 (copy)
	if t1.isRecipeOwned(t16, p7.id) then
		return true
	end

	return p7.hidden ~= true
end
function t1.isMachineUnlocked(t17: {[any]: any}?) -- line: 248
	-- upvalues: t1 (copy)
	return t17 ~= nil and t17[t1.CRAFTING_MACHINE_UNLOCK_KEY] == true
end
function t1.getRecipeKeyFromInstance(p8) -- line: 252
	-- upvalues: t1 (copy)
	local t1RECIPE_KEY_ATTRIBUTE = p8:GetAttribute(t1.RECIPE_KEY_ATTRIBUTE)

	if type(t1RECIPE_KEY_ATTRIBUTE) ~= "string" or t1RECIPE_KEY_ATTRIBUTE == "" then
		return nil
	end

	return t1RECIPE_KEY_ATTRIBUTE
end
function t1.getInstanceZoneId(p9) -- line: 261
	-- upvalues: Zones (copy)
	while p9 ~= nil do
		if p9:IsA("Model") then
			local num = tonumber(p9.Name)

			if num ~= nil and Zones.hasZone(num) then
				return num
			end
		end

		p9 = p9.Parent
	end

	return nil
end
function t1.getRecipeZoneId(p10) -- line: 277
	-- upvalues: t1 (copy)
	return t1.getInstanceZoneId(p10)
end
function t1.getMachineZoneId(p11) -- line: 281
	-- upvalues: t1 (copy)
	return t1.getInstanceZoneId(p11)
end
function t1.canShowRecipeInstance(p12, t18: {[any]: any}?, t19: {[any]: any}?, n4: number?) -- line: 285
	-- upvalues: t1 (copy)
	if not t1.isMachineUnlocked(t19) then
		return false
	end

	local v99 = t1.getRecipeKeyFromInstance(p12)

	if v99 == nil then
		return false
	end

	if t1.getRecipe(v99) == nil then
		return false
	end

	if t1.isRecipeOwned(t18, v99) then
		return false
	end

	local v100 = t1.getRecipeZoneId(p12)

	if v100 == nil then
		return false
	end

	return v100 <= math.max(n4 or 1, 1)
end
function t1.getIngredientDisplayData(p13) -- line: 314
	return {
		level = 1,
		xp = 0,
		id = p13.id,
		mutations = p13.mutations
	}
end
function t1.getOutputDisplayData(p14) -- line: 323
	return {
		level = 1,
		xp = 0,
		mutations = nil,
		id = p14.outputId
	}
end
function t1.getCraftAccumulatedXp(t20: {[any]: any}) -- line: 332
	-- upvalues: InventoryServiceUtils (copy)
	local n5 = 0

	for _, v106 in t20 do
		n5 += InventoryServiceUtils.getAccumulatedXp(v106)
	end

	return n5
end
function t1.getCraftOutputSlimeData(p15, t21: {[any]: any}) -- line: 341
	-- upvalues: t1 (copy), InventoryServiceUtils (copy)
	local v109 = t1.getCraftAccumulatedXp(t21)

	if v109 <= 0 then
		return t1.getOutputDisplayData(p15)
	end

	return InventoryServiceUtils.getSlimeDataFromAccumulatedXp(p15.outputId, v109, nil)
end
function t1.getSelectedSlimeDatas(t22: {[any]: any}?, t23: {[any]: any}?) -- line: 351
	-- upvalues: InventoryServiceUtils (copy)
	local t24 = {}
	local v113 = t22 or {}

	for _, v115 in t23 or {} do
		if type(v115) == "string" and v115 ~= "" then
			local v116 = v113[v115]

			if v116 ~= nil then
				table.insert(t24, InventoryServiceUtils.getSlimeData(v115, v116))
			end
		end
	end

	return t24
end
function t1.getIngredientDisplayName(p16) -- line: 374
	-- upvalues: Mutations (copy), Slimes (copy)
	return Mutations.getDisplayName(Slimes.getSlime(p16.id).name, p16.mutations)
end
function t1.getCraftMutationPreview(p17, t25: {[any]: any}, p18) -- line: 378
	-- upvalues: getInheritedMutationChances (copy), getFinalSizeMutationChances (copy), Mutations (copy)
	local v121 = getInheritedMutationChances(p17, t25)
	local t26 = {}
	local v123 = getFinalSizeMutationChances(v121, p18)

	for _, v125 in Mutations.sizeMutations do
		local v126 = math.clamp(v123[v125] or 0, 0, 1)

		if v126 > 0 then
			table.insert(t26, {
				id = v125,
				name = Mutations.get(v125).name,
				chance = v126
			})
		end
	end

	for _, v128 in Mutations.modifierMutations do
		local v129 = v121[v128] or 0
		local v130 = if p18 == nil or p18[v128] == true then math.clamp(Mutations.get(v128).odds, 0, 1) else 0
		local v131 = 1 - (1 - math.clamp(v129, 0, 1)) * (1 - math.clamp(v130, 0, 1))

		if v131 > 0 then
			table.insert(t26, {
				id = v128,
				name = Mutations.get(v128).name,
				chance = v131
			})
		end
	end

	table.sort(t26, function(t27: {[any]: any}, t28: {[any]: any}) -- line: 412
		-- upvalues: Mutations (copy)
		if t27.chance == t28.chance then
			return Mutations.get(t27.id).value > Mutations.get(t28.id).value
		end

		return t27.chance > t28.chance
	end)

	return t26
end
function t1.rollCraftMutations(p19, t29: {[any]: any}, p20) -- line: 423
	-- upvalues: getInheritedMutationChances (copy), getRollOutcomeFromChanceMap (copy), Mutations (copy), getBaseSizeMutationChances (copy)
	local v135 = getInheritedMutationChances(p19, t29)
	local t30 = {}
	local v137 = false
	local v138 = getRollOutcomeFromChanceMap(v135, Mutations.sizeMutations)
	local v139 = getRollOutcomeFromChanceMap(getBaseSizeMutationChances(p20), Mutations.sizeMutations)
	local v140 = if v138 ~= nil then if v139 ~= nil then if not (Mutations.get(v138).value >= Mutations.get(v139).value) then v139 else v138 else v138 else v139

	if v140 ~= nil then
		t30[v140] = true
		v137 = true
	end

	for _, v142 in Mutations.modifierMutations do
		local v143 = math.clamp(v135[v142] or 0, 0, 1)
		local v144 = if p20 == nil or p20[v142] == true then math.clamp(Mutations.get(v142).odds, 0, 1) else 0

		if v143 > math.random() or v144 > math.random() then
			t30[v142] = true
			v137 = true
		end
	end

	if v137 then
		return t30
	end

	return nil
end
function t1.matchesIngredient(p21, p22) -- line: 453
	-- upvalues: Mutations (copy)
	if p22.id ~= p21.id then
		return false
	end

	local mutations = p21.mutations

	if mutations == nil then
		return true
	end

	for _, v149 in Mutations.getIds(mutations) do
		if not Mutations.has(p22.mutations, v149) then
			return false
		end
	end

	return true
end
function t1.getOwnedAmount(p23) -- line: 472
	if p23 == nil then
		return 0
	end

	if type(p23) == "number" then
		return (math.max(p23, 0))
	end

	return 1
end
function t1.getRecipeSelectionPlan(p24, t31: {[any]: any}?, t32: {[any]: any}?) -- line: 484
	-- upvalues: InventoryServiceUtils (copy), t1 (copy)
	local v154 = t31 or {}
	local v155 = t32 or {}

	if #v155 ~= #p24.inputs then
		return nil
	end

	local t33 = {}

	for v157, v158 in p24.inputs do
		local v159 = v155[v157]

		if type(v159) ~= "string" or v159 == "" then
			return nil
		end

		local v160 = v154[v159]

		if v160 == nil then
			return nil
		end

		local v161 = InventoryServiceUtils.getSlimeData(v159, v160)

		if not t1.matchesIngredient(v158, v161) then
			return nil
		end

		t33[v159] = (t33[v159] or 0) + 1

		if t33[v159] > t1.getOwnedAmount(v160) then
			return nil
		end
	end

	return t33
end
function t1.getSelectedRecipeMaxCrafts(p25, t34: {[any]: any}?, t35: {[any]: any}?) -- line: 521
	-- upvalues: t1 (copy)
	local v165 = t34 or {}
	local v166 = t1.getRecipeSelectionPlan(p25, v165, t35)

	if v166 == nil then
		return 0
	end

	local n6 = 1e999

	for v168, v169 in v166 do
		n6 = math.min(n6, (math.floor(t1.getOwnedAmount(v165[v168]) / v169)))
	end

	if n6 == 1e999 then
		return 0
	end

	return (math.max(n6, 0))
end
function t1.getIngredientInventoryEntries(p26, t36: {[any]: any}?) -- line: 545
	-- upvalues: buildInventoryEntries (copy), t1 (copy)
	local t37 = {}

	for _, v174 in (buildInventoryEntries(t36 or {})) do
		if t1.matchesIngredient(p26, v174.slimeData) and v174.ownedAmount > 0 then
			table.insert(t37, v174)
		end
	end

	return t37
end
function t1.getRecipeMatchPlan(p27, t38: {[any]: any}?, _: {[any]: any}?) -- line: 561
	-- upvalues: buildInventoryEntries (copy), Mutations (copy), t1 (copy)
	local v178 = t38 or {}
	local v179 = buildInventoryEntries(v178)
	local t40 = {}
	local t41 = {}
	local t42 = {}

	for v183, v184 in p27.inputs do
		table.insert(t42, {
			index = v183,
			ingredient = v184,
			specificity = #Mutations.getIds(v184.mutations)
		})
	end

	table.sort(t42, function(p28, p29) -- line: 580
		if p28.specificity == p29.specificity then
			return p28.index < p29.index
		end

		return p28.specificity > p29.specificity
	end)

	for _, v186 in t42 do
		local uniqueId = nil

		for _, v189 in v179 do
			local v190 = t40[v189.uniqueId]

			if v190 == nil then
				v190 = v189.ownedAmount
				t40[v189.uniqueId] = v190
			end

			if not (v190 <= 0) and t1.matchesIngredient(v186.ingredient, v189.slimeData) then
				uniqueId = v189.uniqueId

				break
			end
		end

		if uniqueId == nil then
			return nil
		end

		t40[uniqueId] = t40[uniqueId] - 1
		t41[uniqueId] = (t41[uniqueId] or 0) + 1
	end

	return t41
end
function t1.canCraftRecipe(p30, t43: {[any]: any}?, t44: {[any]: any}?) -- line: 616
	-- upvalues: t1 (copy)
	return t1.getRecipeMatchPlan(p30, t43, t44) ~= nil
end
function t1.hasDiscoveredSlime(s3: string, t45: {[any]: any}?, p31) -- line: 624
	-- upvalues: IndexServiceUtils (copy), InventoryServiceUtils (copy)
	local v197 = t45 or {}

	if type(p31) == "table" then
		if p31.categories ~= nil then
			if IndexServiceUtils.isUnlocked(p31, "basic", s3) then
				return true
			end
		else
			local v198 = p31[s3]

			if v198 == true or type(v198) == "number" and v198 > 0 then
				return true
			end
		end
	end

	for v199, v200 in v197 do
		if s3 == InventoryServiceUtils.getSlimeData(v199, v200).id then
			return true
		end
	end

	return false
end

return t1
