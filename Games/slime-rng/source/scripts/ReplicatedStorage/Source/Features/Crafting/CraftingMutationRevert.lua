-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMutationRevert, time of decompilation: Sun May  3 10:12:25 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local t1 = {}

local function cloneMutations(p1) -- line: 12
	if p1 == nil then
		return nil
	end

	return table.clone(p1)
end
local function rollMutationAtBaseRate(p2, p3) -- line: 48
	-- upvalues: Mutations (copy)
	local v21 = Mutations.get(p3)

	if math.random() >= v21.odds then
		return
	end

	if v21.category == "size" then
		local v22 = Mutations.getSizeMutationId(p2)

		if v22 ~= nil then
			if Mutations.get(v22).value >= v21.value then
				return
			end

			p2[v22] = nil
		end
	end

	p2[p3] = true
end
local function rerollCraftedMutations(p4) -- line: 68
	-- upvalues: Mutations (copy), cloneMutations (copy), rollMutationAtBaseRate (copy)
	if not Mutations.hasAny(p4) then
		return nil
	end

	local v24 = Mutations.getIds(p4)

	if #v24 <= 1 then
		return cloneMutations(p4)
	end

	local v25 = v24[math.random(1, #v24)]
	local t2 = {
		[v25] = true
	}

	for _, v28 in v24 do
		if v28 ~= v25 then
			rollMutationAtBaseRate(t2, v28)
		end
	end

	if Mutations.hasAny(t2) then
		return t2
	end

	return nil
end
local function getFallbackRarestRollStat(t3: {[any]: any}) -- line: 92
	-- upvalues: InventoryServiceUtils (copy), Slimes (copy)
	local t4 = nil
	local n1 = 1

	for v32, v33 in t3 do
		if type(v33) ~= "number" or not (v33 <= 0) then
			local v34 = InventoryServiceUtils.getSlimeData(v32, v33)
			local id = v34.id
			local v36

			if type(id) ~= "string" or id == "" then
				v36 = false
			else
				local ok, result = pcall(Slimes.getSlime, id)

				v36 = ok and result.craftable == true
			end

			if not v36 then
				local v39 = math.max(1, (math.ceil(1 / InventoryServiceUtils.getVisualOdds({
					level = 1,
					xp = 0,
					id = v34.id,
					mutations = v34.mutations
				}))))

				if t4 == nil or n1 < v39 then
					t4 = {
						id = v34.id
					}

					local mutations = v34.mutations

					t4.mutations = if mutations ~= nil then table.clone(mutations) else nil
					n1 = v39
				end
			end
		end
	end

	if t4 == nil then
		return {
			odds = 1,
			slimeData = {
				id = ""
			}
		}
	end

	return {
		slimeData = t4,
		odds = n1
	}
end
local function getResolvedRarestRollStat(p5) -- line: 130
	-- upvalues: Slimes (copy), getFallbackRarestRollStat (copy)
	local rarestRoll = p5.stats.rarestRoll
	local v43 = if rarestRoll ~= nil then rarestRoll.slimeData else nil
	local v44 = if v43 ~= nil then v43.id else nil

	if type(v44) == "string" and v44 ~= "" then
		local v45

		if type(v44) ~= "string" or v44 == "" then
			v45 = false
		else
			local ok, result = pcall(Slimes.getSlime, v44)

			v45 = ok and result.craftable == true
		end

		if not v45 then
			return rarestRoll
		end
	end

	return (getFallbackRarestRollStat(p5.inventory or {}))
end

function t1.apply(_, p7) -- line: 142
	-- upvalues: InventoryServiceUtils (copy), Slimes (copy), rerollCraftedMutations (copy), getResolvedRarestRollStat (copy)
	if p7.craftingMutationRevertV1 == true then
		return
	end

	local t5 = {}

	for v51, v52 in p7.inventory or {} do
		local v53 = InventoryServiceUtils.getSlimeData(v51, v52)

		if type(v52) == "table" then
			local v54 = table.clone(v52)
			local id = v53.id
			local v56

			if type(id) ~= "string" or id == "" then
				v56 = false
			else
				local ok, result = pcall(Slimes.getSlime, id)

				v56 = ok and result.craftable == true
			end

			if v56 then
				v54.mutations = rerollCraftedMutations(v53.mutations)
			end

			t5[v51] = v54
		elseif type(v52) == "number" then
			local v59 = math.max(v52, 0)

			if not (v59 <= 0) then
				local v60 = v51
				local id = v53.id
				local v62

				if type(id) ~= "string" or id == "" then
					v62 = false
				else
					local ok, result = pcall(Slimes.getSlime, id)

					v62 = ok and result.craftable == true
				end

				if v62 then
					v60 = InventoryServiceUtils.genKey({
						id = v53.id,
						mutations = rerollCraftedMutations(v53.mutations)
					})
				end

				t5[v60] = (t5[v60] or 0) + v59
			end
		end
	end

	p7.inventory = t5
	p7.stats.rarestRoll = getResolvedRarestRollStat(p7)
	p7.craftingMutationRevertV1 = true
end

return t1
