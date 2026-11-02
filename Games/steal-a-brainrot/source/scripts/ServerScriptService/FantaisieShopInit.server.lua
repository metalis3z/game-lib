local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Ensure CollectionService tags are set at runtime
local function setupFantaisieShopTags()
	local fantaisieShop = workspace:FindFirstChild("FantaisieShop")
	if not fantaisieShop then
		warn("[FantaisieShopInit] FantaisieShop model not found in workspace")
		return
	end

	-- Tag the Rig as FantaisieShopNPC
	local rig = fantaisieShop:FindFirstChild("Rig")
	if rig then
		if not CollectionService:HasTag(rig, "FantaisieShopNPC") then
			CollectionService:AddTag(rig, "FantaisieShopNPC")
		end
		-- Remove any MerchantNPC tag that might have been cloned
		if CollectionService:HasTag(rig, "MerchantNPC") then
			CollectionService:RemoveTag(rig, "MerchantNPC")
		end
	end

	-- Tag the ProximityPrompt as FantaisieShopPrompt
	local promptPart = fantaisieShop:FindFirstChild("Prompt")
	if promptPart then
		local proxPrompt = promptPart:FindFirstChildOfClass("ProximityPrompt")
		if proxPrompt then
			if not CollectionService:HasTag(proxPrompt, "FantaisieShopPrompt") then
				CollectionService:AddTag(proxPrompt, "FantaisieShopPrompt")
			end
		end
	end

	-- Ensure parent model does NOT have the FantaisieShopNPC tag (only the Rig should have it)
	if CollectionService:HasTag(fantaisieShop, "FantaisieShopNPC") then
		CollectionService:RemoveTag(fantaisieShop, "FantaisieShopNPC")
		warn("[FantaisieShopInit] Removed stray FantaisieShopNPC tag from parent model")
	end

	-- Tag the model itself
	if not CollectionService:HasTag(fantaisieShop, "FantaisieShop") then
		CollectionService:AddTag(fantaisieShop, "FantaisieShop")
	end
	if not CollectionService:HasTag(fantaisieShop, "NewPlayersHidden") then
		CollectionService:AddTag(fantaisieShop, "NewPlayersHidden")
	end

	print("[FantaisieShopInit] Tags set up successfully")
end

-- Run setup
setupFantaisieShopTags()

-- Also re-setup if the model is re-added
workspace.ChildAdded:Connect(function(child)
	if child.Name == "FantaisieShop" then
		task.wait(1)
		setupFantaisieShopTags()
	end
end)