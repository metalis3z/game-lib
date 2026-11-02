local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local ValentinesShopService = require(ServerScriptService.Services.ValentinesShopService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local ValentinesShopData = require(ReplicatedStorage.Datas.ValentinesShop)
	local Shop = require(ReplicatedStorage.Datas.Shop)

	print("[GiftCommands] Loading gift commands...")

	-- Build brainrot list
	local brainrotList = {}
	for name, _ in pairs(AnimalsData) do
		table.insert(brainrotList, name)
	end
	table.sort(brainrotList)
	print("[GiftCommands] Loaded", #brainrotList, "brainrot types")

	-- Build mutation list
	local mutationList = {}
	for name, _ in pairs(MutationsData) do
		table.insert(mutationList, name)
	end
	table.sort(mutationList)
	print("[GiftCommands] Loaded", #mutationList, "mutations")

	-- Build product list with proper name extraction from the ValentinesShopData
	local productList = {}
	local productNameToIdMap = {} -- Map from display name to product ID
	local productIdToNameMap = {} -- Map from product ID to display name

	for productId, productInfo in pairs(ValentinesShopData.Products) do
		local displayName = nil

		-- Priority 1: Use the item field if it exists (this is the main field from the data)
		if productInfo.item then
			displayName = productInfo.item

			-- Priority 2: Handle lucky blocks specially based on product ID
		elseif productInfo.isLuckyBlock then
			if productId == 3531057541 then
				displayName = "Heart Lucky Block (1x)"
			elseif productId == 3531057803 then
				displayName = "Heart Lucky Block (3x)"
			elseif productId == 3531057804 then
				displayName = "Heart Lucky Block (10x)"
			elseif productId == 3329528437 then
				displayName = "Secret Lucky Block"
			else
				displayName = "Lucky Block"
			end
		end

		-- If we found a name, add it to our maps
		if displayName then
			productIdToNameMap[productId] = displayName

			-- Store in lowercase for case-insensitive matching
			local lowerName = string.lower(displayName)
			productNameToIdMap[lowerName] = productId

			table.insert(productList, displayName)
		end
	end

	-- Sort products alphabetically
	table.sort(productList)

	print("[GiftCommands] Loaded", #productList, "products")

	-- Helper function to find product by name or ID
	local function findProduct(input)
		-- Try to parse as number first
		local asNumber = tonumber(input)
		if asNumber and ValentinesShopData.Products[asNumber] then
			return asNumber, productIdToNameMap[asNumber] or "Product #" .. asNumber
		end

		-- Search by name (case-insensitive)
		local lowerInput = string.lower(input)

		-- First try exact match
		if productNameToIdMap[lowerInput] then
			local id = productNameToIdMap[lowerInput]
			return id, productIdToNameMap[id]
		end

		-- Then try partial match
		for productName, productId in pairs(productNameToIdMap) do
			if string.find(productName, lowerInput, 1, true) then
				return productId, productIdToNameMap[productId]
			end
		end

		return nil, nil
	end

	--------------------------------------------------------------------------------
	-- Command: giftbrainrot
	--------------------------------------------------------------------------------
	Conch.register("giftbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true
			},
			{
				kind = "argument",
				type = "string",
				name = "Message",
				optional = true
			}
		end,
		callback = function(targetPlayer, brainrotName, mutation, message)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			if not AnimalsData[brainrotName] then
				return false, "Brainrot '" .. tostring(brainrotName) .. "' not found."
			end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then
					return false, "Mutation '" .. tostring(mutation) .. "' not found."
				end
				cleanMutation = mutation
			end

			local cleanMessage = nil
			if message and message ~= "" then
				cleanMessage = string.sub(message, 1, 200)
			end

			-- Get the admin/sender player (the one executing the command)
			local senderPlayer = Players:FindFirstChild("AdminExecutor") or Players:GetPlayers()[1]
			if not senderPlayer then
				return false, "Could not determine sender player"
			end

			-- Use the service's GiveAdminGift method
			local success, err = ValentinesShopService:GiveAdminGift(
				targetPlayer,
				senderPlayer,
				brainrotName,
				cleanMutation,
				cleanMessage
			)

			if not success then
				return false, "Failed to send gift: " .. tostring(err)
			end

			local msg = string.format("✓ Sent %s to %s", brainrotName, targetPlayer.Name)
			if cleanMutation then
				msg = msg .. " with " .. cleanMutation .. " mutation"
			end

			return true, msg
		end
	})
	print("[GiftCommands] ✓ Registered: giftbrainrot")

	--------------------------------------------------------------------------------
	-- Command: giftproduct
	--------------------------------------------------------------------------------
	Conch.register("giftproduct", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "ProductName",
				suggestions = productList,
			},
			{
				kind = "argument",
				type = "string",
				name = "Message",
				optional = true
			}
		end,
		callback = function(targetPlayer, productInput, message)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local productId, productName = findProduct(productInput)
			if not productId then
				return false, "Product '" .. tostring(productInput) .. "' not found. Use /giftlist products to see available items."
			end

			local productInfo = ValentinesShopData.Products[productId]
			if not productInfo then
				return false, "Product data not found for ID " .. tostring(productId)
			end

			local cleanMessage = nil
			if message and message ~= "" then
				cleanMessage = string.sub(message, 1, 60)
			end

			-- Get the admin/sender player
			local senderPlayer = Players:FindFirstChild("AdminExecutor") or Players:GetPlayers()[1]
			if not senderPlayer then
				return false, "Could not determine sender player"
			end

			-- Use the service's GiveAdminProduct method (this properly triggers animations)
			local success, err = ValentinesShopService:GiveAdminProduct(
				targetPlayer,
				senderPlayer,
				productId,
				cleanMessage
			)

			if not success then
				return false, "Failed to send gift: " .. tostring(err)
			end

			return true, string.format("✓ Sent %s to %s", productName, targetPlayer.Name)
		end
	})
	print("[GiftCommands] ✓ Registered: giftproduct")

	--------------------------------------------------------------------------------
	-- Command: giftlist
	--------------------------------------------------------------------------------
	Conch.register("giftlist", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "Type",
				suggestions = { "brainrot", "products", "mutations" },
				optional = true
			}
		end,
		callback = function(listType)
			listType = listType and string.lower(listType) or "brainrot"

			if listType == "brainrot" then
				return true, "═══ Available Brainrot (" .. #brainrotList .. ") ═══\n" .. table.concat(brainrotList, ", ")

			elseif listType == "products" then
				return true, "═══ Available Products (" .. #productList .. ") ═══\n" .. table.concat(productList, ", ")

			elseif listType == "mutations" then
				return true, "═══ Available Mutations (" .. #mutationList .. ") ═══\n" .. table.concat(mutationList, ", ")
			else
				return false, "Invalid type. Use: brainrot, products, or mutations"
			end
		end
	})
	print("[GiftCommands] ✓ Registered: giftlist")

	--------------------------------------------------------------------------------
	-- Command: giftcheck
	--------------------------------------------------------------------------------
	Conch.register("giftcheck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local success, result = pcall(function()
				-- Use the service's GetGiftInventory method
				local giftInventory = ValentinesShopService:GetGiftInventory(targetPlayer)

				if #giftInventory == 0 then
					return string.format("%s has no gifts in their inventory.", targetPlayer.Name)
				end

				local giftList = {}
				table.insert(giftList, string.format("═══ %s's Gifts (%d) ═══", targetPlayer.Name, #giftInventory))
				table.insert(giftList, "")

				for i, gift in ipairs(giftInventory) do
					local giftName = gift.RewardName or gift.BrainrotName or gift.AdminBrainrot or productIdToNameMap[gift.ProductId] or "Unknown Gift"
					local sender = gift.SenderUsername or "Unknown"

					local giftDesc = string.format("[%d] %s", i, giftName)

					if gift.Mutation then
						giftDesc = giftDesc .. " (" .. gift.Mutation .. ")"
					end

					giftDesc = giftDesc .. " — from " .. sender

					if gift.Message and gift.Message ~= "" then
						giftDesc = giftDesc .. '\n    💌 "' .. gift.Message .. '"'
					end

					table.insert(giftList, giftDesc)
				end

				return table.concat(giftList, "\n")
			end)

			if not success then
				return false, "Failed to check gifts: " .. tostring(result)
			end

			return true, result
		end
	})
	print("[GiftCommands] ✓ Registered: giftcheck")

	--------------------------------------------------------------------------------
	-- Command: giftclear
	--------------------------------------------------------------------------------
	Conch.register("giftclear", {
		permissions = { "admin" },
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local success, err = pcall(function()
				-- Use the service's ClearGiftInventory method
				ValentinesShopService:ClearGiftInventory(targetPlayer)
			end)

			if not success then
				return false, "Failed to clear gifts: " .. tostring(err)
			end

			return true, string.format("✓ Cleared all gifts from %s", targetPlayer.Name)
		end
	})
	print("[GiftCommands] ✓ Registered: giftclear")

	--------------------------------------------------------------------------------
	-- Command: gifthelp
	--------------------------------------------------------------------------------
	Conch.register("gifthelp", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local help = {
				"═══════════ Gift Commands Help ═══════════",
				"",
				"▸ /giftbrainrot <player> <brainrot> [mutation] [message]",
				"  Send a brainrot (animal) to a player",
				"  Example: /giftbrainrot Player123 Cat Golden \"Happy Valentine's!\"",
				"",
				"▸ /giftproduct <player> <product name> [message]",
				"  Send a product/item to a player",
				"  Type to see autocomplete suggestions!",
				"  Example: /giftproduct Player123 Rose Base",
				"  Example: /giftproduct Player123 Admin Commands",
				"",
				"▸ /giftlist [type]",
				"  List available items (brainrot, products, mutations)",
				"  Example: /giftlist products",
				"",
				"▸ /giftcheck <player>",
				"  Check a player's gift inventory",
				"",
				"▸ /giftclear <player>",
				"  Clear all gifts from a player's inventory (Admin only)",
				"",
				"═══════════════════════════════════════════",
			}
			return true, table.concat(help, "\n")
		end
	})
	print("[GiftCommands] ✓ Registered: gifthelp")

	print("═══════════════════════════════════════════")
	print("[GiftCommands] ✓ All commands loaded successfully!")local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local ValentinesShopService = require(ServerScriptService.Services.ValentinesShopService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local ValentinesShopData = require(ReplicatedStorage.Datas.ValentinesShop)
	local Shop = require(ReplicatedStorage.Datas.Shop)

	print("[GiftCommands] Loading gift commands...")

	-- Build brainrot list
	local brainrotList = {}
	for name, _ in pairs(AnimalsData) do
		table.insert(brainrotList, name)
	end
	table.sort(brainrotList)
	print("[GiftCommands] Loaded", #brainrotList, "brainrot types")

	-- Build mutation list
	local mutationList = {}
	for name, _ in pairs(MutationsData) do
		table.insert(mutationList, name)
	end
	table.sort(mutationList)
	print("[GiftCommands] Loaded", #mutationList, "mutations")

	-- Build product list with proper name extraction from the ValentinesShopData
	local productList = {}
	local productNameToIdMap = {} -- Map from display name to product ID
	local productIdToNameMap = {} -- Map from product ID to display name

	for productId, productInfo in pairs(ValentinesShopData.Products) do
		local displayName = nil

		-- Priority 1: Use the item field if it exists (this is the main field from the data)
		if productInfo.item then
			displayName = productInfo.item

			-- Priority 2: Handle lucky blocks specially based on product ID
		elseif productInfo.isLuckyBlock then
			if productId == 3531057541 then
				displayName = "Heart Lucky Block (1x)"
			elseif productId == 3531057803 then
				displayName = "Heart Lucky Block (3x)"
			elseif productId == 3531057804 then
				displayName = "Heart Lucky Block (10x)"
			elseif productId == 3329528437 then
				displayName = "Secret Lucky Block"
			else
				displayName = "Lucky Block"
			end
		end

		-- If we found a name, add it to our maps
		if displayName then
			productIdToNameMap[productId] = displayName

			-- Store in lowercase for case-insensitive matching
			local lowerName = string.lower(displayName)
			productNameToIdMap[lowerName] = productId

			table.insert(productList, displayName)
		end
	end

	-- Sort products alphabetically
	table.sort(productList)

	print("[GiftCommands] Loaded", #productList, "products")

	-- Helper function to find product by name or ID
	local function findProduct(input)
		-- Try to parse as number first
		local asNumber = tonumber(input)
		if asNumber and ValentinesShopData.Products[asNumber] then
			return asNumber, productIdToNameMap[asNumber] or "Product #" .. asNumber
		end

		-- Search by name (case-insensitive)
		local lowerInput = string.lower(input)

		-- First try exact match
		if productNameToIdMap[lowerInput] then
			local id = productNameToIdMap[lowerInput]
			return id, productIdToNameMap[id]
		end

		-- Then try partial match
		for productName, productId in pairs(productNameToIdMap) do
			if string.find(productName, lowerInput, 1, true) then
				return productId, productIdToNameMap[productId]
			end
		end

		return nil, nil
	end

	--------------------------------------------------------------------------------
	-- Command: giftbrainrot
	--------------------------------------------------------------------------------
	Conch.register("giftbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true
			},
			{
				kind = "argument",
				type = "string",
				name = "Message",
				optional = true
			}
		end,
		callback = function(targetPlayer, brainrotName, mutation, message)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			if not AnimalsData[brainrotName] then
				return false, "Brainrot '" .. tostring(brainrotName) .. "' not found."
			end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then
					return false, "Mutation '" .. tostring(mutation) .. "' not found."
				end
				cleanMutation = mutation
			end

			local cleanMessage = nil
			if message and message ~= "" then
				cleanMessage = string.sub(message, 1, 200)
			end

			-- Get the admin/sender player (the one executing the command)
			local senderPlayer = Players:FindFirstChild("AdminExecutor") or Players:GetPlayers()[1]
			if not senderPlayer then
				return false, "Could not determine sender player"
			end

			-- Use the service's GiveAdminGift method
			local success, err = ValentinesShopService:GiveAdminGift(
				targetPlayer,
				senderPlayer,
				brainrotName,
				cleanMutation,
				cleanMessage
			)

			if not success then
				return false, "Failed to send gift: " .. tostring(err)
			end

			local msg = string.format("✓ Sent %s to %s", brainrotName, targetPlayer.Name)
			if cleanMutation then
				msg = msg .. " with " .. cleanMutation .. " mutation"
			end

			return true, msg
		end
	})
	print("[GiftCommands] ✓ Registered: giftbrainrot")

	--------------------------------------------------------------------------------
	-- Command: giftproduct
	--------------------------------------------------------------------------------
	Conch.register("giftproduct", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "ProductName",
				suggestions = productList,
			},
			{
				kind = "argument",
				type = "string",
				name = "Message",
				optional = true
			}
		end,
		callback = function(targetPlayer, productInput, message)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local productId, productName = findProduct(productInput)
			if not productId then
				return false, "Product '" .. tostring(productInput) .. "' not found. Use /giftlist products to see available items."
			end

			local productInfo = ValentinesShopData.Products[productId]
			if not productInfo then
				return false, "Product data not found for ID " .. tostring(productId)
			end

			local cleanMessage = nil
			if message and message ~= "" then
				cleanMessage = string.sub(message, 1, 60)
			end

			-- Get the admin/sender player
			local senderPlayer = Players:FindFirstChild("AdminExecutor") or Players:GetPlayers()[1]
			if not senderPlayer then
				return false, "Could not determine sender player"
			end

			-- Use the service's GiveAdminProduct method (this properly triggers animations)
			local success, err = ValentinesShopService:GiveAdminProduct(
				targetPlayer,
				senderPlayer,
				productId,
				cleanMessage
			)

			if not success then
				return false, "Failed to send gift: " .. tostring(err)
			end

			return true, string.format("✓ Sent %s to %s", productName, targetPlayer.Name)
		end
	})
	print("[GiftCommands] ✓ Registered: giftproduct")

	--------------------------------------------------------------------------------
	-- Command: giftlist
	--------------------------------------------------------------------------------
	Conch.register("giftlist", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "Type",
				suggestions = { "brainrot", "products", "mutations" },
				optional = true
			}
		end,
		callback = function(listType)
			listType = listType and string.lower(listType) or "brainrot"

			if listType == "brainrot" then
				return true, "═══ Available Brainrot (" .. #brainrotList .. ") ═══\n" .. table.concat(brainrotList, ", ")

			elseif listType == "products" then
				return true, "═══ Available Products (" .. #productList .. ") ═══\n" .. table.concat(productList, ", ")

			elseif listType == "mutations" then
				return true, "═══ Available Mutations (" .. #mutationList .. ") ═══\n" .. table.concat(mutationList, ", ")
			else
				return false, "Invalid type. Use: brainrot, products, or mutations"
			end
		end
	})
	print("[GiftCommands] ✓ Registered: giftlist")

	--------------------------------------------------------------------------------
	-- Command: giftcheck
	--------------------------------------------------------------------------------
	Conch.register("giftcheck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local success, result = pcall(function()
				-- Use the service's GetGiftInventory method
				local giftInventory = ValentinesShopService:GetGiftInventory(targetPlayer)

				if #giftInventory == 0 then
					return string.format("%s has no gifts in their inventory.", targetPlayer.Name)
				end

				local giftList = {}
				table.insert(giftList, string.format("═══ %s's Gifts (%d) ═══", targetPlayer.Name, #giftInventory))
				table.insert(giftList, "")

				for i, gift in ipairs(giftInventory) do
					local giftName = gift.RewardName or gift.BrainrotName or gift.AdminBrainrot or productIdToNameMap[gift.ProductId] or "Unknown Gift"
					local sender = gift.SenderUsername or "Unknown"

					local giftDesc = string.format("[%d] %s", i, giftName)

					if gift.Mutation then
						giftDesc = giftDesc .. " (" .. gift.Mutation .. ")"
					end

					giftDesc = giftDesc .. " — from " .. sender

					if gift.Message and gift.Message ~= "" then
						giftDesc = giftDesc .. '\n    💌 "' .. gift.Message .. '"'
					end

					table.insert(giftList, giftDesc)
				end

				return table.concat(giftList, "\n")
			end)

			if not success then
				return false, "Failed to check gifts: " .. tostring(result)
			end

			return true, result
		end
	})
	print("[GiftCommands] ✓ Registered: giftcheck")

	--------------------------------------------------------------------------------
	-- Command: giftclear
	--------------------------------------------------------------------------------
	Conch.register("giftclear", {
		permissions = { "admin" },
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			}
		end,
		callback = function(targetPlayer)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local success, err = pcall(function()
				-- Use the service's ClearGiftInventory method
				ValentinesShopService:ClearGiftInventory(targetPlayer)
			end)

			if not success then
				return false, "Failed to clear gifts: " .. tostring(err)
			end

			return true, string.format("✓ Cleared all gifts from %s", targetPlayer.Name)
		end
	})
	print("[GiftCommands] ✓ Registered: giftclear")

	--------------------------------------------------------------------------------
	-- Command: gifthelp
	--------------------------------------------------------------------------------
	Conch.register("gifthelp", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local help = {
				"═══════════ Gift Commands Help ═══════════",
				"",
				"▸ /giftbrainrot <player> <brainrot> [mutation] [message]",
				"  Send a brainrot (animal) to a player",
				"  Example: /giftbrainrot Player123 Cat Golden \"Happy Valentine's!\"",
				"",
				"▸ /giftproduct <player> <product name> [message]",
				"  Send a product/item to a player",
				"  Type to see autocomplete suggestions!",
				"  Example: /giftproduct Player123 Rose Base",
				"  Example: /giftproduct Player123 Admin Commands",
				"",
				"▸ /giftlist [type]",
				"  List available items (brainrot, products, mutations)",
				"  Example: /giftlist products",
				"",
				"▸ /giftcheck <player>",
				"  Check a player's gift inventory",
				"",
				"▸ /giftclear <player>",
				"  Clear all gifts from a player's inventory (Admin only)",
				"",
				"═══════════════════════════════════════════",
			}
			return true, table.concat(help, "\n")
		end
	})
	print("[GiftCommands] ✓ Registered: gifthelp")

	print("═══════════════════════════════════════════")
	print("[GiftCommands] ✓ All commands loaded successfully!")
	print("[GiftCommands] Available commands:")
	print("  • giftbrainrot - Send brainrot/animals")
	print("  • giftproduct  - Send items/products")
	print("  • giftlist     - List available items")
	print("  • giftcheck    - Check player gifts")
	print("  • giftclear    - Clear player gifts (Admin)")
	print("  • gifthelp     - Show command help")
	print("═══════════════════════════════════════════")
end

return module
	print("[GiftCommands] Available commands:")
	print("  • giftbrainrot - Send brainrot/animals")
	print("  • giftproduct  - Send items/products")
	print("  • giftlist     - List available items")
	print("  • giftcheck    - Check player gifts")
	print("  • giftclear    - Clear player gifts (Admin)")
	print("  • gifthelp     - Show command help")
	print("═══════════════════════════════════════════")
end

return module