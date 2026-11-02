-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Variables = require(Library.Variables)
local GetProductByID = require(script.Parent.GetProductByID)
local GetGamepassByID = require(script.Parent.GetGamepassByID)
local LocalPlayer = Players.LocalPlayer
local t = { Constants.MAIN_DEV_ID }
local tbl = {}
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = nil

local function clearAllProductLocks() --[[ clearAllProductLocks | Line: 26 | Upvalues: t4 (copy) ]]
	for k, v in pairs(t4) do
		table.clear(v)
	end
end

local function markProductLocks(p1) --[[ markProductLocks | Line: 32 | Upvalues: tbl (copy), t4 (copy) ]]
	local v1 = tbl[p1]

	if not v1 then
		return
	end

	for i, v in ipairs(v1) do
		t4[v][p1] = true
	end
end

local function clearPromptInFlight() --[[ clearPromptInFlight | Line: 43 | Upvalues: v1 (ref), t4 (copy) ]]
	v1 = nil

	for k, v in pairs(t4) do
		table.clear(v)
	end
end

local function clearPendingProduct(p1, p2) --[[ clearPendingProduct | Line: 48 | Upvalues: t3 (copy), t2 (copy), tbl (copy), t4 (copy) ]]
	t3[p1] = nil

	if p2 then
		t2[p1] = true
	end

	local v1 = tbl[p1]

	if not v1 then
		return
	end

	for i, v in ipairs(v1) do
		t4[v][p1] = nil
	end
end

for k, v in pairs(tbl) do
	if not t4[k] then
		t4[k] = {}
	end

	for i, v2 in ipairs(v) do
		if not t4[v2] then
			t4[v2] = {}
		end
	end
end

if RunService:IsClient() then
	local Network = require(Library.Client.Network)

	Network.Fired("Product Failed"):Connect(function(p1) --[[ Line: 75 | Upvalues: t3 (copy), t2 (copy), tbl (copy), t4 (copy) ]]
		local ProductId = p1.ProductId

		t3[ProductId] = nil
		t2[ProductId] = true

		local v1 = tbl[ProductId]

		if not v1 then
			return
		end

		for i, v in ipairs(v1) do
			t4[v][ProductId] = nil
		end
	end)
	Network.Fired("Product Bought"):Connect(function(p1, p2) --[[ Line: 79 | Upvalues: t3 (copy), t2 (copy), tbl (copy), t4 (copy) ]]
		local ProductId = p2.ProductId

		t3[ProductId] = nil
		t2[ProductId] = true

		local v1 = tbl[ProductId]

		if not v1 then
			return
		end

		for i, v in ipairs(v1) do
			t4[v][ProductId] = nil
		end
	end)
	Network.Fired("Products: Receipt Processed"):Connect(function(p1) --[[ Line: 83 | Upvalues: t3 (copy), t2 (copy), tbl (copy), t4 (copy) ]]
		t3[p1] = nil
		t2[p1] = true

		local v1 = tbl[p1]

		if not v1 then
			return
		end

		for i, v in ipairs(v1) do
			t4[v][p1] = nil
		end
	end)
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(p1, p2, p3) --[[ Line: 87 | Upvalues: Players (copy), v1 (ref), t4 (copy), t3 (copy), tbl (copy), GetProductByID (copy) ]]
		if p1 ~= Players.LocalPlayer.UserId then
			return
		end

		v1 = nil

		for k, v in pairs(t4) do
			table.clear(v)
		end

		if p3 then
			local v12 = GetProductByID(p2)

			if not (v12 and v12.SinglePurchase) then
				return
			end

			t3[p2] = true
		else
			t3[p2] = nil

			local v2 = tbl[p2]

			if not v2 then
				return
			end

			for i, v in ipairs(v2) do
				t4[v][p2] = nil
			end
		end
	end)
end

local v2 = false

return {
	Prompt = function(p1, p2) --[[ Prompt | Line: 109 | Upvalues: RunService (copy), Library (copy), Variables (copy), v2 (ref), GetProductByID (copy), GetGamepassByID (copy), v1 (ref), t2 (copy), t3 (copy), t4 (copy), t (copy), LocalPlayer (copy), MarketplaceService (copy), tbl (copy) ]]
		assert(RunService:IsClient())

		local Signal = require(Library.Signal)
		local Audio = require(Library.Audio)
		local Functions = require(Library.Functions)
		local Client = Library:WaitForChild("Client")
		local Message = require(Client.Message)
		local Network = require(Client.Network)
		local FFlags = require(Client.FFlags)
		local Gamepasses = require(Client.Gamepasses)
		local Products = Network.NET_MAP.Products

		if not (FFlags.Get(FFlags.Keys.Purchases) or FFlags.CanBypass()) then
			Message.New("Sorry! Roblox is experiencing technical difficulties, and purchases have been temporarily disabled. Please try again soon.", {
				title = "Oops!",
				err = true
			})

			return
		end

		local GiftUserId = Variables.GiftUserId
		local GiftUserName = Variables.GiftUserName

		if GiftUserId then
			if not p2 then
				Message.New("Sorry! You cannot gift gamepasses!", {
					title = "Oops!",
					err = true
				})

				return
			end

			local v22 = GetProductByID(p1)

			if not v22 then
				Message.New("Sorry! Failed to find product!", {
					title = "Oops!",
					err = true
				})

				return
			end

			if not v22.ComputeItems then
				Message.New("Sorry! This product cannot be gifted!", {
					title = "Oops!",
					err = true
				})

				return
			end

			if not Message.New(("This purchase will be gifted to %*, are you sure?"):format(GiftUserName), true, {
				icon = Functions.GetThumbnailFromUserIdAsync(GiftUserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
			}) then
				Signal.Fire("Gift User Reset")

				return
			end

			local v3, v4 = Network.Invoke("Products: Gifting", GiftUserId, p1, nil)

			if not v3 then
				Message.New(v4 or "Sorry! Something went wrong!", {
					title = "Oops!",
					err = true
				})

				return
			end

			Signal.Fire("Gift User Reset")
			v2 = true
		elseif p2 and v2 then
			Network.Invoke("Products: Clear Gifting")
			v2 = false
		end

		if p2 then
			local v5 = GetProductByID(p1)

			if not v5 then
				Message.New("Sorry! Something went wrong! If this keeps happening please contact our support!", {
					title = "Oops!",
					err = true
				})

				return
			end

			if not FFlags.BulkGet("Product", v5._id) then
				Message.New("Sorry! Roblox is having trouble so we have temporarily disabled this purchase! Try back soon!", {
					title = "Oops!",
					err = true
				})

				return
			end

			if v1 ~= nil then
				Message.New("Finish the current purchase prompt first.", {
					title = "Oops!",
					err = true
				})

				return
			end

			if FFlags.Get(FFlags.Keys.BlockRepeatSingleProductPurchases) and v5.SinglePurchase then
				if t2[v5.ProductId] then
					Message.New("Roblox is having trouble and it looks like you\'ve already attempted to purchase this! Please attempt to rejoin if the purchase is not granted! (#1)", {
						title = "Oops!",
						err = true
					})

					return
				end

				if t3[v5.ProductId] then
					Message.New("Roblox is having trouble and it looks like you\'ve already attempted to purchase this! Please attempt to rejoin if the purchase is not granted! (#2)", {
						title = "Oops!",
						err = true
					})

					return
				end

				if FFlags.Get(FFlags.Keys.PurchaseAdditionalLocks) and (t4[v5.ProductId] and Functions.DictionaryLength(t4[v5.ProductId]) > 0) then
					Message.New("Roblox is having trouble and it looks like you\'ve already attempted to purchase this! Please attempt to rejoin if the purchase is not granted! (#3)", {
						title = "Oops!",
						err = true
					})

					return
				end
			end

			if v5.ClientTest then
				local v6, v7, v8 = Functions.wcall(v5.ClientTest)

				if not (v6 and v7) then
					Message.New(v8 or "Something went wrong attempting to purchase this product!", {
						title = "Oops!",
						err = true
					})

					return
				end
			end
		else
			local v9 = GetGamepassByID(p1)

			if not v9 then
				Message.New("Sorry! Something went wrong! If this keeps happening please contact our support!", {
					title = "Oops!",
					err = true
				})

				return
			end

			if not FFlags.BulkGet("Gamepass", v9._id) then
				Message.New("Sorry! Roblox is having trouble so we have temporarily disabled this purchase! Try back soon!", {
					title = "Oops!",
					err = true
				})

				return
			end

			if v9.ClientTest then
				local v10, v11, v122 = Functions.wcall(v9.ClientTest)

				if not (v10 and v11) then
					Message.New(v122 or "Something went wrong attempting to purchase this gamepass!", {
						title = "Oops!",
						err = true
					})

					return
				end
			end
		end

		if t[LocalPlayer.UserId] and FFlags.Get(FFlags.Keys.ProductBypassWhitelist) then
			if not Message.New("Instant whitelist purchase?", true) then
				return
			end

			local v15, v16 = Network.Invoke("Products: Whitelist Purchase", p1, p2 == true)

			if v15 then
				return
			end

			Message.New(v16 or "Something went wrong!", {
				err = true
			})
		end

		if p2 then
			local v17 = GetProductByID(p1)

			if not v17 then
				Message.New("Something went wrong! (#3)", {
					err = true
				})

				return
			end

			local v18, v19 = Network.Invoke(Products.REQUEST_SERVER_TEST, v17.ProductId)

			if not v18 then
				Message.New(v19 or "Something went wrong attempting to purchase this product!", {
					title = "Oops!",
					err = true
				})

				return
			end

			Audio.Play("rbxassetid://129627240635324", script, 1.35, 0.6)
			v1 = v17.ProductId

			local ProductId = v17.ProductId
			local v20 = tbl[ProductId]

			if v20 then
				for i, v in ipairs(v20) do
					t4[v][ProductId] = true
				end
			end

			if FFlags.Get(FFlags.Keys.LegacyPrompting) then
				Signal.Fire("Prompting Purchase")
				MarketplaceService:PromptProductPurchase(LocalPlayer, p1)
			else
				local v21, v22 = Network.Invoke(Products.REQUEST_PROMPT_PURCHASE, v17.ProductId)

				if not v21 then
					v1 = nil

					for k, v in pairs(t4) do
						table.clear(v)
					end

					Message.New(v22 or "Something went wrong attempting to purchase this product!", {
						title = "Oops!",
						err = true
					})

					return
				end
			end

			local _ = FFlags.Get(FFlags.Keys.LegacyPrompting)
		elseif not Gamepasses.Owns(p1) then
			Audio.Play("rbxassetid://129627240635324", script, 1.35, 0.6)
			Signal.Fire("Prompting Purchase")
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, p1)
		end
	end
}