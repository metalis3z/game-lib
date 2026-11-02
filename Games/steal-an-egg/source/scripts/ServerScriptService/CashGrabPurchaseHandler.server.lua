-- CashGrabPurchaseHandler
-- Handles ProximityPrompt triggers on CashGrabModels to prompt Robux developer product purchases.
-- Reads the ProductName attribute from each prompt and looks up the real ProductId from PurchaseIdConfig.

local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

_G.CashGrabHandlerStatus = "starting"

local ok, err = pcall(function()
	_G.CashGrabHandlerStatus = "requiring PurchaseIdConfig"
	local PurchaseIdConfig = require(ReplicatedStorage:WaitForChild("PurchaseIdConfig"))
	_G.CashGrabHandlerStatus = "PurchaseIdConfig required OK"
	_G.CashGrabProductIds = PurchaseIdConfig.ProductIds

local CASH_GRAB_FOLDER_NAME = "CashGrabModels"
local connectedPrompts = {}
local usingPlaceholders = PurchaseIdConfig.UsingPlaceholderIds == true

local function setupPrompt(prompt: ProximityPrompt)
	if not prompt:IsA("ProximityPrompt") then
		return
	end

	if connectedPrompts[prompt] then
		return
	end

	-- Look up the product name from the prompt attribute, then resolve the real ProductId from PurchaseIdConfig
	local productName = prompt:GetAttribute("ProductName")
	print(("[CashGrab] Found prompt: %s | ProductName=%q | Enabled=%s"):format(prompt:GetFullName(), tostring(productName), tostring(prompt.Enabled)))
	if typeof(productName) ~= "string" or productName == "" then
		warn(("[CashGrab] Prompt at %s has no ProductName attribute"):format(prompt:GetFullName()))
		return
	end

	local productId = PurchaseIdConfig.ProductIds[productName]
	print(("[CashGrab] Resolved ProductId for '%s' = %s"):format(productName, tostring(productId)))
	if typeof(productId) ~= "number" or productId <= 0 then
		warn(("[CashGrab] No valid ProductId found in PurchaseIdConfig for '%s'"):format(productName))
		return
	end

	connectedPrompts[prompt] = true
	prompt.Triggered:Connect(function(player)
		print(("[CashGrab] Prompt triggered by %s for product '%s' (ID %d)"):format(player.Name, productName, productId))
		local ok, err = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, player, productId)
		if not ok then
			warn(("[CashGrab] Failed to prompt product purchase for %s (product '%s', ID %d): %s"):format(player.Name, productName, productId, tostring(err)))
		else
			print(("[CashGrab] PromptProductPurchase succeeded for %s"):format(player.Name))
		end
	end)
	print(("[CashGrab] Connected Triggered event for %s -> ProductId %d"):format(prompt:GetFullName(), productId))
end

local function scanFolder(folder: Instance)
	for _, descendant in folder:GetDescendants() do
		if descendant:IsA("ProximityPrompt") then
			setupPrompt(descendant)
		end
	end
end

local cashGrabFolder = Workspace:FindFirstChild(CASH_GRAB_FOLDER_NAME)
print(("[CashGrab] Looking for folder '%s' in Workspace: %s"):format(CASH_GRAB_FOLDER_NAME, tostring(cashGrabFolder)))
if cashGrabFolder then
	scanFolder(cashGrabFolder)
	cashGrabFolder.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("ProximityPrompt") then
			setupPrompt(descendant)
		end
	end)
else
	warn(("[CashGrab] Folder '%s' not found in Workspace"):format(CASH_GRAB_FOLDER_NAME))
end
print("[CashGrab] Handler initialization complete")
	_G.CashGrabHandlerStatus = "complete"
	_G.CashGrabConnectedPrompts = {}
	for prompt, _ in pairs(connectedPrompts) do
		table.insert(_G.CashGrabConnectedPrompts, prompt:GetFullName())
	end
end)

if not ok then
	_G.CashGrabHandlerStatus = "ERROR"
	_G.CashGrabHandlerError = tostring(err)
	warn("[CashGrab] Handler failed to initialize: " .. tostring(err))
end