-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RecipeInstanceServiceClient, time of decompilation: Sun May  3 10:12:24 2026 ]]
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local RecipeInstanceClient = require(ReplicatedStorage.Source.Features.Crafting.Classes.RecipeInstanceClient)
local CraftingServiceClient = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceClient)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)

return {
	init = function(p1) --[[ init ]] -- line: 12
		-- upvalues: Janitor (copy), CollectionService (copy), CraftingServiceUtils (copy), client (copy)
		p1.janitor = Janitor.new()
		p1.recipeInstances = {}

		for _, v10 in CollectionService:GetTagged(CraftingServiceUtils.RECIPE_TAG) do
			p1:addRecipeInstance(v10)
		end

		p1.janitor:Add(CollectionService:GetInstanceAddedSignal(CraftingServiceUtils.RECIPE_TAG):Connect(function(p2) -- line: 20
			-- upvalues: p1 (copy)
			p1:addRecipeInstance(p2)
		end))
		p1.janitor:Add(CollectionService:GetInstanceRemovedSignal(CraftingServiceUtils.RECIPE_TAG):Connect(function(p3) -- line: 23
			-- upvalues: p1 (copy)
			p1:removeRecipeInstance(p3)
		end))
		p1.janitor:Add(client:getChangedSignal("craftingRecipes"):Connect(function() -- line: 26
			-- upvalues: p1 (copy)
			p1:refreshVisibility()
		end))
		p1.janitor:Add(client:getChangedSignal("unlocks"):Connect(function() -- line: 29
			-- upvalues: p1 (copy)
			p1:refreshVisibility()
		end))
		p1.janitor:Add(client:getChangedSignal("maxZone"):Connect(function() -- line: 32
			-- upvalues: p1 (copy)
			p1:refreshVisibility()
		end))
		p1:refreshVisibility()
	end,
	getUnlockedRecipes = function(_) --[[ getUnlockedRecipes ]] -- line: 39
		-- upvalues: client (copy)
		return client:get("craftingRecipes") or {}
	end,
	getUnlocks = function(_) --[[ getUnlocks ]] -- line: 43
		-- upvalues: client (copy)
		return client:get("unlocks") or {}
	end,
	getMaxZone = function(_) --[[ getMaxZone ]] -- line: 47
		-- upvalues: client (copy)
		return (math.max(client:get("maxZone") or 1, 1))
	end,
	addRecipeInstance = function(p7, p8) --[[ addRecipeInstance ]] -- line: 51
		-- upvalues: RecipeInstanceClient (copy)
		p7:removeRecipeInstance(p8)

		local v16 = RecipeInstanceClient.new(p8, function(p9) -- line: 54
			-- upvalues: p7 (copy)
			p7:claimRecipe(p9)
		end)

		p7.recipeInstances[p8] = v16
		p7:updateRecipeInstanceVisibility(v16)
	end,
	removeRecipeInstance = function(p10, p11) --[[ removeRecipeInstance ]] -- line: 61
		local v19 = p10.recipeInstances[p11]

		if v19 == nil then
			return
		end

		v19:destroy()
		p10.recipeInstances[p11] = nil
	end,
	updateRecipeInstanceVisibility = function(p12, p13) --[[ updateRecipeInstanceVisibility ]] -- line: 71
		-- upvalues: CraftingServiceUtils (copy)
		p13:setVisible(CraftingServiceUtils.canShowRecipeInstance(p13.instance, p12:getUnlockedRecipes(), p12:getUnlocks(), p12:getMaxZone()))
	end,
	refreshVisibility = function(p14) --[[ refreshVisibility ]] -- line: 83
		for _, v24 in p14.recipeInstances do
			p14:updateRecipeInstanceVisibility(v24)
		end
	end,
	claimRecipe = function(p15, p16) --[[ claimRecipe ]] -- line: 89
		-- upvalues: CraftingServiceClient (copy)
		if p16.claimPending then
			return
		end

		if p16.recipeKey == nil then
			return
		end

		p16:setClaimPending(true)

		local v27 = CraftingServiceClient:claimRecipe(p16.recipeKey, p16.instance)

		p16:setClaimPending(false)

		if v27 then
			p16:setVisible(false)

			return
		end

		p15:updateRecipeInstanceVisibility(p16)
	end
}
