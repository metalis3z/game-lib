-- DevProductPedestalServer: wires the ProximityPrompt on each dev-product
-- pedestal (Workspace.DevProduct1, DevProduct2, ...) to the Robux purchase
-- flow. The pedestal model carries a ProductId attribute (0 = product not
-- created yet, prompt no-ops) read live at trigger time, and its display item
-- model (DisplayLootItem attribute) names the loot item granted on purchase
-- via RarityItemSpawner.GrantClaimedLoot.

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

local PurchaseService = require(ServerScriptService.Source.Services.PurchaseService)
local RarityItemsConfig = require(ReplicatedStorage.Source.Configs.RarityItemsConfig)
local spawnerScript = ServerScriptService:WaitForChild("RarityItemSpawner")
local grantFunc = spawnerScript:WaitForChild("GrantClaimedLoot", 30)

local function wirePedestal(model)
	local display
	for _, child in ipairs(model:GetChildren()) do
		if child:IsA("Model") and child:GetAttribute("DisplayLootItem") then
			display = child
			break
		end
	end
	if not display then return end
	local prompt = model:FindFirstChildWhichIsA("ProximityPrompt", true)
	if not prompt then return end
	local itemName = display:GetAttribute("ItemId")

	-- keep the advertised $value in sync with the loot economy config (the
	-- static label once drifted to $19M while Dragon Egg's real value was $48M)
	local valueLabel = model:FindFirstChild("ValueLabel", true)
	if valueLabel and valueLabel:IsA("TextLabel") and itemName then
		local ok, value = pcall(RarityItemsConfig.GetItemValue, itemName)
		if ok and tonumber(value) and value > 0 then
			local text = RarityItemsConfig.FormatValue(value)
			valueLabel.Text = text
			local inner = valueLabel:FindFirstChild("Inner")
			if inner and inner:IsA("TextLabel") then inner.Text = text end
		end
	end

	prompt.Triggered:Connect(function(player)
		local productId = tonumber(model:GetAttribute("ProductId")) or 0
		PurchaseService.PromptProduct(player, productId, "DevProduct:" .. tostring(itemName), function(success)
			if success and grantFunc then
				-- persist=true: a Robux-bought pedestal item (Dragon Egg) must
				-- survive a rejoin even if the buyer never sells it
				grantFunc:Invoke(player, itemName, true)
			end
		end)
	end)
end

-- ===== limited-offer countdown (Dragon Egg pedestal) =====
-- The pedestal's TimerFrame counts down to a FIXED unix deadline: the
-- first boot after this shipped establishes now + 7 days and SAVES it, so
-- server restarts keep counting from wherever it was instead of resetting
-- (ported from "+1 Kick Door" 2026-07-21). The deadline is published on
-- the pedestal model as the OfferDeadline attribute (unix seconds);
-- PedestalOfferTimerClient renders the countdown text client-side with the
-- server-synced clock. Clamps at 0 when it expires -- nothing is unwired.
local OFFER_SECONDS = 7 * 24 * 60 * 60
local offerStore
pcall(function()
	offerStore = DataStoreService:GetDataStore("PedestalOfferDeadlines")
end)

local function ensureOfferDeadline(model)
	if not model:FindFirstChild("TimerFrame", true) then return end
	local deadline
	if offerStore then
		pcall(function()
			deadline = offerStore:GetAsync(model.Name)
		end)
		if type(deadline) ~= "number" then
			deadline = os.time() + OFFER_SECONDS
			pcall(function()
				offerStore:SetAsync(model.Name, deadline)
			end)
		end
	else
		-- DataStores unavailable (Studio without API access): still count down
		deadline = os.time() + OFFER_SECONDS
	end
	model:SetAttribute("OfferDeadline", deadline)
end

for _, inst in ipairs(Workspace:GetChildren()) do
	if inst:IsA("Model") and inst.Name:match("^DevProduct%d+$") then
		wirePedestal(inst)
		task.spawn(ensureOfferDeadline, inst)
	end
end
