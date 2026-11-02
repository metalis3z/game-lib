--[[
    IMPROVED BUY_TOOLS SCRIPT WITH MULTI-FOLDER SUPPORT
    
    This script now supports multiple tool folders for easy organization!
    
    HOW TO ADD NEW TOOL FOLDERS:
    1. Create a new Folder in ReplicatedStorage (e.g., "VIP_Tools")
    2. Add your tools to that folder
    3. Add the folder to the TOOL_FOLDERS list below:
       
       local TOOL_FOLDERS = {
           ReplicatedStorage:WaitForChild("Tools"),
           ReplicatedStorage:WaitForChild("Code_Tools"),
           ReplicatedStorage:WaitForChild("VIP_Tools"),  -- Add this line
       }
    
    FEATURES:
    - Searches through all configured folders for tools
    - Easy to add/remove folders without changing other code
    - Debug function available (uncomment debugToolFolders() call)
    - Maintains all existing functionality (VIP, consumables, saving)
    
    TROUBLESHOOTING:
    - If tools aren't found, check folder names in TOOL_FOLDERS
    - Use debugToolFolders() to see all available tools
    - Make sure tools have proper ItemInfo structure
--]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SaveLoadItem = Remotes:WaitForChild("SaveLoadItem")
local BuyToolRemote = Remotes:WaitForChild("BuyTool")
local Notification = Remotes:WaitForChild("Notification")
local ToolDataStore = DataStoreService:GetDataStore("PlayerTools_V1")
local Values = ReplicatedStorage:WaitForChild("Values")
local VIP_GAMEPASS_ID = Values:WaitForChild("VIPGamepassId").Value

-- Server-side handler for notifications
-- This allows clients to send notifications to themselves
Notification.OnServerEvent:Connect(function(player, title, message, duration)
	-- Fire the notification back to the specific client who requested it
	Notification:FireClient(player, title, message, duration)
end)

-- EASY TO EDIT: Add or remove tool folders here
-- The script will search through all these folders for tools
local TOOL_FOLDERS = {
    ReplicatedStorage:WaitForChild("Tools"),
    ReplicatedStorage:WaitForChild("Code_Tools"),
    -- Add more folders here like:
    -- ReplicatedStorage:WaitForChild("VIP_Tools"),
    -- ReplicatedStorage:WaitForChild("Seasonal_Tools"),
    -- ReplicatedStorage:WaitForChild("Admin_Tools"),
}

-- Helper function to find a tool in any of the configured folders
local function findTool(toolName)
    for _, folder in ipairs(TOOL_FOLDERS) do
        if folder then
            local tool = folder:FindFirstChild(toolName)
            if tool then
                return tool
            end
        end
    end
    return nil
end

-- Helper function to get all available tools from all folders
local function getAllAvailableTools()
    local allTools = {}
    for _, folder in ipairs(TOOL_FOLDERS) do
        if folder then
            for _, tool in ipairs(folder:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(allTools, tool)
                end
            end
        end
    end
    return allTools
end

-- Debug function to list all configured folders and their tools
local function debugToolFolders()
    print("=== Tool Folders Debug ===")
    for i, folder in ipairs(TOOL_FOLDERS) do
        if folder then
            print(string.format("Folder %d: %s (%d tools)", i, folder.Name, #folder:GetChildren()))
            for _, tool in ipairs(folder:GetChildren()) do
                if tool:IsA("Tool") then
                    print("  - " .. tool.Name)
                end
            end
        else
            print(string.format("Folder %d: nil", i))
        end
    end
    print("========================")
end

-- Uncomment the line below to debug tool folders on server start
-- debugToolFolders()

-- Function to check if player has VIP
local function playerHasVIP(player)
    local success, hasPass = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(player.UserId, VIP_GAMEPASS_ID)
    end)
    
    if success then
        return hasPass
    else
        warn("Failed to check VIP status for " .. player.Name .. ": " .. tostring(hasPass))
        return false
    end
end

-- List of items that should NOT respawn and NOT save permanently
local Consumables = {
	["Grenade"] = true,
	["Forcefield 20 Seconds"] = true,
	["MedKit"] = true,
	["10+ Speed 20 Seconds"] = true
}

--- 1. HELPER: Give tool
local function giveTool(player, toolName)
	local toolTemplate = findTool(toolName)
	if not toolTemplate then return end

	-- If it's NOT a consumable, put it in StarterGear so it respawns on death
	if not Consumables[toolName] then
		local starterGear = player:FindFirstChild("StarterGear")
		if starterGear and not starterGear:FindFirstChild(toolName) then
			toolTemplate:Clone().Parent = starterGear
		end
	end

	-- Always give to Backpack for immediate use
	-- (Consumables only go here, so they disappear on death/use)
	local backpack = player:FindFirstChild("Backpack")
	if backpack and not backpack:FindFirstChild(toolName) then
		toolTemplate:Clone().Parent = backpack
	end
end

--- 2. HELPER: Save Inventory (Only saves permanent items)
local function saveInventory(player)
	if not player then return end

	local ownedTools = {}
	local starterGear = player:FindFirstChild("StarterGear")

	-- We only save what is in StarterGear (the permanent items)
	if starterGear then
		for _, tool in ipairs(starterGear:GetChildren()) do
			if tool:IsA("Tool") then
				table.insert(ownedTools, tool.Name)
			end
		end
	end

	local success, err = pcall(function()
		ToolDataStore:SetAsync(player.UserId, {Inventory = ownedTools})
	end)

	if success then
		SaveLoadItem:FireClient(player, ownedTools)
	else
		warn("DataStore Error: " .. err)
	end
end

--- 3. HELPER: Load Inventory
local function loadInventory(player)
	local success, data = pcall(function()
		return ToolDataStore:GetAsync(player.UserId)
	end)

	if success and data and data.Inventory then
		for _, toolName in ipairs(data.Inventory) do
			giveTool(player, toolName)
		end
		SaveLoadItem:FireClient(player, data.Inventory)
	end
end

--- 4. FIXED BUY LOGIC
BuyToolRemote.OnServerEvent:Connect(function(player, itemName, itemPrice)
	local toolTemplate = findTool(itemName)
	if not toolTemplate then return end

	-- Check if player already has the permanent version
	if not Consumables[itemName] and player.StarterGear:FindFirstChild(itemName) then 
		Notification:FireClient(player, "Already Owned", "You already own this item!", 3)
		return 
	end

	-- Check if this is a VIP item
	local isVIPItem = toolTemplate.ItemInfo:FindFirstChild("VIP") and toolTemplate.ItemInfo.VIP.Value
	
	-- If VIP item, check if player has VIP
	if isVIPItem and not playerHasVIP(player) then
		Notification:FireClient(player, "VIP Required", "You need to purchase the VIP gamepass to buy this item!", 4)
		return
	end

	local money = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money")

	if itemPrice == 0 or (money and money.Value >= itemPrice) then
		if itemPrice > 0 then
			money.Value -= itemPrice
		end

		giveTool(player, itemName)
		
		-- Send success notification
		if isVIPItem then
			Notification:FireClient(player, "VIP Item Purchased!", "You successfully purchased " .. itemName .. "!", 5)
		else
			Notification:FireClient(player, "Item Purchased!", "You successfully purchased " .. itemName .. "!", 3)
		end

		-- Only save data if it's a permanent item
		if not Consumables[itemName] then
			saveInventory(player)
		end
	else
		Notification:FireClient(player, "Insufficient Funds", "You don't have enough money to buy this item!", 3)
	end
end)

--- 5. PLAYER EVENTS
Players.PlayerAdded:Connect(function(player)
	loadInventory(player)
end)

Players.PlayerRemoving:Connect(function(player)
	saveInventory(player)
end)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		saveInventory(player)
	end
end)
