--credit to prince games studio
local t = {
	StartOrder = 3
}
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Signal = require(ReplicatedStorage.ClientModules.Signal)
local MessagePrompt = require(ReplicatedStorage.ClientModules.MessagePrompt)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local DevProducts = require(ReplicatedStorage.SharedModules.DevProducts)
local Environment = require(ReplicatedStorage.SharedModules.Environment)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local LocalPlayer = Players.LocalPlayer
local v1 = if Environment.env == "Dev" then true else RunService:IsStudio()

local function debugPrint(p1) --[[ debugPrint | Line: 20 | Upvalues: v1 (copy) ]]
	if not v1 then
		return
	end

	print(p1)
end

local v2 = Signal.new()
local v3 = Signal.new()
local v4 = Signal.new()
local v5 = Signal.new()

t.PurchaseStartedSignal = v2
t.PurchaseCancelledSignal = v3
t.PurchaseCompleteSignal = v4
t.PurchaseFailedSignal = v5
t.PurchaseStarted = v2
t.PurchaseCancelled = v3
t.PurchaseComplete = v4
t.PurchaseFailed = v5

local t2 = {}
local t3 = {}
local t4 = {}
local v6 = false
local v7 = false
local v8 = false
local v9 = false

local function isInstantPurchasesEnabled() --[[ isInstantPurchasesEnabled | Line: 51 | Upvalues: Environment (copy) ]]
	local v1 = workspace:GetAttribute("InstantPurchasesEnabled")

	if type(v1) == "boolean" then
		return v1
	end

	return Environment.config.InstantPurchases
end

local function setEnabled(p1, p2) --[[ setEnabled | Line: 59 ]]
	if p1:IsA("ScreenGui") then
		p1.Enabled = p2

		return
	end

	if p1:IsA("LayerCollector") then
		p1.Enabled = p2

		return
	end

	if not p1:IsA("GuiObject") then
		return
	end

	p1.Visible = p2
end

local function setText(p1, p2) --[[ setText | Line: 69 ]]
	if not p1 then
		return
	end

	if not (p1:IsA("TextLabel") or (p1:IsA("TextButton") or p1:IsA("TextBox"))) then
		return
	end

	p1.Text = p2
end

local function setImage(p1, p2) --[[ setImage | Line: 76 ]]
	if not p1 then
		return
	end

	if not (p1:IsA("ImageLabel") or p1:IsA("ImageButton")) then
		return
	end

	p1.Image = p2
end

local function getPromptChoice(p1, p2) --[[ getPromptChoice | Line: 83 | Upvalues: LocalPlayer (copy), t4 (copy), MarketplaceService (copy) ]]
	local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

	if not PlayerGui then
		return nil
	end

	local PreRobuxPrompt = PlayerGui:FindFirstChild("PreRobuxPrompt")

	if not PreRobuxPrompt then
		return nil
	end

	local v1 = t4[p2]

	if not v1 then
		local ok, result = pcall(function() --[[ Line: 96 | Upvalues: MarketplaceService (ref), p2 (copy) ]]
			return MarketplaceService:GetProductInfoAsync(p2, Enum.InfoType.Product)
		end)

		if ok then
			t4[p2] = result
			v1 = result
		end
	end

	local v2 = if v1 then v1.Name else v1
	local v3 = if v1 then v1.PriceInRobux else v1
	local v4 = if v1 then v1.IconImageAssetId else v1
	local v5 = if type(v4) == "number" then "rbxassetid://" .. tostring(v4) else "https://www.roblox.com/thumbs/asset.ashx?assetid=" .. tostring(p2) .. "&x=100&y=100&format=png"
	local v6 = if type(v3) == "number" then ("<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> %*"):format(v3) else "<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> ?"
	local v8 = if type(v2) == "string" and v2 ~= "" then v2 else p1

	local function descend(p1, p2) --[[ descend | Line: 115 ]]
		local v1 = p1

		for i, v in ipairs(p2) do
			local v2 = v1:FindFirstChild(v)

			if not v2 then
				return nil
			end

			v1 = v2
		end

		return v1
	end

	local v9 = descend(PreRobuxPrompt, {
		"ProductPurchaseModal",
		"SheetContainer",
		"Sheet",
		"Content",
		"Content",
		"ScrollingFrame",
		"ScrollingFrame",
		"SheetContentContainer",
		"ProductDetailsContainer",
		"ProductDetails"
	})

	if v9 then
		local v10 = descend(v9, { "ItemDetailsFrame", "ItemDetailsFrame", "ItemName" })
		local ItemIcon = v9:FindFirstChild("ItemIcon")
		local v11 = descend(v9, { "ItemDetailsFrame", "ItemDetails", "ItemCost" })

		if v10 and (v10 and (v10:IsA("TextLabel") or (v10:IsA("TextButton") or v10:IsA("TextBox")))) then
			v10.Text = v8
		end

		if ItemIcon and (ItemIcon and (ItemIcon:IsA("ImageLabel") or ItemIcon:IsA("ImageButton"))) then
			ItemIcon.Image = v5
		end

		if v11 and (v11 and (v11:IsA("TextLabel") or (v11:IsA("TextButton") or v11:IsA("TextBox")))) then
			v11.Text = v6
		end
	end

	local v12 = descend(PreRobuxPrompt, { "ProductPurchaseModal", "SheetContainer", "Sheet", "Content", "Actions", "1" })

	if not v12 then
		return nil
	end

	local BuyRobux = v12:FindFirstChild("BuyRobux")
	local BuyTokens = v12:FindFirstChild("BuyTokens")

	if not (BuyRobux and BuyTokens) then
		return nil
	end

	if PreRobuxPrompt:IsA("ScreenGui") or PreRobuxPrompt:IsA("LayerCollector") then
		PreRobuxPrompt.Enabled = true
	elseif PreRobuxPrompt:IsA("GuiObject") then
		PreRobuxPrompt.Visible = true
	end

	local v13 = false
	local v14 = nil

	local function finish(p1) --[[ finish | Line: 171 | Upvalues: v13 (ref), v14 (ref) ]]
		if not v13 then
			v13 = true
			v14 = p1
		end
	end

	local v15 = BuyRobux.MouseButton1Click:Connect(function() --[[ Line: 177 | Upvalues: v13 (ref), v14 (ref) ]]
		if not v13 then
			v13 = true
			v14 = "Robux"
		end
	end)
	local v16 = BuyTokens.MouseButton1Click:Connect(function() --[[ Line: 181 | Upvalues: v13 (ref), v14 (ref) ]]
		if not v13 then
			v13 = true
			v14 = "Tokens"
		end
	end)
	local list = {}
	local ok, result = pcall(function() --[[ Line: 187 | Upvalues: PreRobuxPrompt (copy) ]]
		return PreRobuxPrompt.ProductPurchaseModal.Backdrop
	end)

	if ok and (result and result:IsA("GuiButton")) then
		list[#list + 1] = result.MouseButton1Click:Connect(function() --[[ Line: 191 | Upvalues: v13 (ref), v14 (ref) ]]
			if not v13 then
				v13 = true
				v14 = nil
			end
		end)
	end

	local ok2, result2 = pcall(function() --[[ Line: 196 | Upvalues: PreRobuxPrompt (copy) ]]
		return PreRobuxPrompt.ProductPurchaseModal.SheetContainer.Sheet.Content.Header.Content.CloseAffordance
	end)

	if ok2 and (result2 and result2:IsA("GuiButton")) then
		list[#list + 1] = result2.MouseButton1Click:Connect(function() --[[ Line: 200 | Upvalues: v13 (ref), v14 (ref) ]]
			if not v13 then
				v13 = true
				v14 = nil
			end
		end)
	end

	local v17 = if PreRobuxPrompt:IsA("ScreenGui") or PreRobuxPrompt:IsA("LayerCollector") then PreRobuxPrompt:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 208 | Upvalues: PreRobuxPrompt (copy), v13 (ref), v14 (ref) ]]
	if PreRobuxPrompt.Enabled ~= false then
		return
	end

	if v13 then
		return
	end

	v13 = true
	v14 = nil
end) else nil
	local v19 = os.clock()

	while not v13 and (PreRobuxPrompt.Parent and not (os.clock() - v19 > 60)) do
		task.wait()
	end

	if v15 then
		v15:Disconnect()
	end

	if v16 then
		v16:Disconnect()
	end

	if v17 then
		v17:Disconnect()
	end

	for i, v in ipairs(list) do
		v:Disconnect()
	end

	if PreRobuxPrompt:IsA("ScreenGui") or PreRobuxPrompt:IsA("LayerCollector") then
		PreRobuxPrompt.Enabled = false
	elseif PreRobuxPrompt:IsA("GuiObject") then
		PreRobuxPrompt.Visible = false
	end

	return v14
end

local v10 = Instance.new("BindableEvent")

local function preloadAllProductInfo() --[[ preloadAllProductInfo | Line: 237 | Upvalues: v6 (ref), v7 (ref), DevProducts (copy), t4 (copy), v8 (ref), v10 (copy), MarketplaceService (copy) ]]
	if v6 then
		return
	end

	v6 = true

	if not v7 then
		repeat
			task.wait()
		until v7
	end

	local t = {}

	for v1, v2 in DevProducts.Products do
		local v3 = type(v2) == "table" and v2.ProductId or nil

		if type(v3) == "number" and not t[v3] then
			t[v3] = true
		end
	end

	local t2 = {}

	for v4 in t do
		if t4[v4] == nil then
			table.insert(t2, v4)
		end
	end

	if #t2 == 0 then
		v8 = true
		v10:Fire()

		return
	end

	local v5 = #t2

	for v62, v72 in t2 do
		task.spawn(function() --[[ Line: 269 | Upvalues: MarketplaceService (ref), v72 (copy), t4 (ref), v5 (ref), v8 (ref), v10 (ref) ]]
			for i = 1, 3 do
				local ok, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v72, Enum.InfoType.Product)

				if ok then
					t4[v72] = result

					break
				elseif i < 3 then
					task.wait(i * 0.5)
				end
			end

			v5 = v5 - 1

			if v5 ~= 0 then
				return
			end

			v8 = true
			v10:Fire()
		end)
	end
end

function t.GetPreloadedProductInfoByProductId(p1, p2) --[[ GetPreloadedProductInfoByProductId | Line: 290 | Upvalues: t4 (copy) ]]
	return t4[p2]
end
function t.GetPreloadedProductInfo(p1, p2) --[[ GetPreloadedProductInfo | Line: 294 | Upvalues: DevProducts (copy), t4 (copy) ]]
	local v1 = DevProducts.GetByKey(p2)

	if not v1 then
		return nil
	end

	local ProductId = v1.ProductId

	if type(ProductId) == "number" then
		return t4[ProductId]
	end

	return nil
end
function t.WaitForPreloadedProductInfoByProductId(p1, p2, p3) --[[ WaitForPreloadedProductInfoByProductId | Line: 306 | Upvalues: v8 (ref), v10 (copy), t4 (copy) ]]
	if not v8 then
		v10.Event:Wait()
	end

	if type(p2) == "number" then
		return t4[p2]
	end

	return nil
end
function t.WaitForPreloadedProductInfo(p1, p2, p3) --[[ WaitForPreloadedProductInfo | Line: 314 | Upvalues: v8 (ref), v10 (copy), DevProducts (copy), t4 (copy) ]]
	if not v8 then
		v10.Event:Wait()
	end

	local v1 = DevProducts.GetByKey(p2)

	if not v1 then
		return nil
	end

	local ProductId = v1.ProductId

	if type(ProductId) == "number" then
		return t4[ProductId]
	end

	return nil
end
function t.PromptPurchaseInternal(p1, p2) --[[ PromptPurchaseInternal | Line: 327 | Upvalues: DevProducts (copy), PlayerStateClient (copy), getPromptChoice (copy), Networking (copy), MarketplaceService (copy), LocalPlayer (copy) ]]
	local v1 = DevProducts.GetByKey(p2)

	if not v1 then
		return false, "Invalid product"
	end

	local ProductId = v1.ProductId

	if type(ProductId) ~= "number" then
		return false, "Invalid product"
	end

	local TokenCost = v1.TokenCost
	local v2 = PlayerStateClient:GetLocalReplica() or PlayerStateClient:WaitForLocalReplica(2)
	local v3 = if v2 then v2.Data.Tokens or 0 else 0

	if not (if type(TokenCost) == "number" and TokenCost >= 0 then TokenCost <= v3 else false) then
		MarketplaceService:PromptProductPurchase(LocalPlayer, ProductId)

		return true, "Prompted Robux"
	end

	local v5 = getPromptChoice(p2, ProductId)

	if v5 == "Tokens" then
		return Networking.DevProducts.PurchaseWithTokens:Fire(p2)
	end

	if v5 == "Robux" then
		MarketplaceService:PromptProductPurchase(LocalPlayer, ProductId)

		return true, "Prompted Robux"
	end

	return false, "Cancelled"
end
function t.Init(p1) --[[ Init | Line: 359 | Upvalues: MarketplaceService (copy), LocalPlayer (copy), t2 (copy), v4 (copy), v5 (copy), t3 (copy), v1 (copy), Networking (copy), DevProducts (copy), v7 (ref), preloadAllProductInfo (copy), v9 (ref) ]]
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(p1, p2, p3) --[[ Line: 360 | Upvalues: LocalPlayer (ref), t2 (ref), v4 (ref), v5 (ref) ]]
		if p1 ~= LocalPlayer.UserId then
			return
		end

		local v1 = t2[p2]

		if not v1 then
			return
		end

		t2[p2] = nil

		if p3 then
			v4:Fire(v1)
		else
			v5:Fire(v1, "Robux purchase cancelled")
		end
	end)
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p1, p2, p3) --[[ Line: 374 | Upvalues: LocalPlayer (ref), t3 (ref), v1 (ref), Networking (ref), v4 (ref), v5 (ref) ]]
		if p1 ~= LocalPlayer then
			return
		end

		local v12 = t3[p2]

		if v12 then
			t3[p2] = nil

			if p3 then
				task.spawn(function() --[[ Line: 390 | Upvalues: v12 (copy), p2 (copy), v1 (ref), Networking (ref), v4 (ref), v5 (ref) ]]
					local v13 = ("[GamepassGearDebug] purchase finished for %* (id %*); notifying server"):format(v12, p2)

					if v1 then
						print(v13)
					end

					local ok, result, result2 = pcall(Networking.DevProducts.GamepassPurchased.Fire, Networking.DevProducts.GamepassPurchased, v12)

					if ok and result then
						local v2 = ("[GamepassGearDebug] server confirmed grant for %*"):format(v12)

						if not v1 then
							v4:Fire(v12)

							return
						end

						print(v2)
						v4:Fire(v12)
					else
						warn((("[GamepassGearDebug] server grant FAILED for %*: invokeOk=%*, message=%*"):format(v12, ok, if ok then result2 else result)))
						v5:Fire(v12, if ok then result2 else "Server error")
					end
				end)
			else
				v5:Fire(v12, "Gamepass purchase cancelled")
			end
		else
			if not p3 then
				return
			end

			warn((("[GamepassGearDebug] gamepass %* purchased but no pending key; server NOT notified"):format(p2)))
		end
	end)
	task.spawn(function() --[[ Line: 406 | Upvalues: DevProducts (ref), v7 (ref), preloadAllProductInfo (ref) ]]
		local v1 = workspace:GetAttribute("RemoteDeveloperProducts")

		if not v1 then
			workspace:GetAttributeChangedSignal("RemoteDeveloperProducts"):Wait()
			v1 = workspace:GetAttribute("RemoteDeveloperProducts")
		end

		for v3, v4 in game:GetService("HttpService"):JSONDecode(v1) do
			DevProducts.AddProduct({
				Key = v4[1],
				ProductId = v4[3],
				TokenCost = v4[2]
			})
		end

		-- Overrides del usuario (sus propios ProductId) — se aplican DESPUÉS, ganan.
		local okOv, Overrides = pcall(require, ReplicatedStorage.SharedModules.DevProductOverrides)
		if okOv and type(Overrides) == "table" then
			for key, productId in pairs(Overrides.Products or {}) do
				if type(key) == "string" and type(productId) == "number" then
					local ex = DevProducts.GetByKey(key)
					DevProducts.AddProduct({ Key = key, ProductId = productId, TokenCost = ex and ex.TokenCost })
				end
			end
		end

		v7 = true
		task.spawn(preloadAllProductInfo)
	end)
	task.spawn(function() --[[ Line: 425 | Upvalues: DevProducts (ref), v9 (ref) ]]
		local v1 = workspace:GetAttribute("RemoteGamepasses")

		if not v1 then
			workspace:GetAttributeChangedSignal("RemoteGamepasses"):Wait()
			v1 = workspace:GetAttribute("RemoteGamepasses")
		end

		for v3, v4 in game:GetService("HttpService"):JSONDecode(v1) do
			DevProducts.AddGamepass({
				Key = v4[1],
				GamepassId = v4[2],
				Name = v4[3],
				Image = v4[4]
			})
		end

		-- Overrides de gamepass del usuario (preserva Name/Image existentes).
		local okOv, Overrides = pcall(require, ReplicatedStorage.SharedModules.DevProductOverrides)
		if okOv and type(Overrides) == "table" then
			for key, gamepassId in pairs(Overrides.Gamepasses or {}) do
				if type(key) == "string" and type(gamepassId) == "number" then
					local ex = DevProducts.GetGamepassByKey(key)
					DevProducts.AddGamepass({ Key = key, GamepassId = gamepassId, Name = ex and ex.Name, Image = ex and ex.Image })
				end
			end
		end

		v9 = true
	end)
end
function t.PromptPurchase(p1, p2) --[[ PromptPurchase | Line: 444 | Upvalues: v2 (copy), DevProducts (copy), v5 (copy), Environment (copy), t4 (copy), MessagePrompt (copy), Networking (copy), v4 (copy), v3 (copy), t2 (copy) ]]
	v2:Fire(p2)

	-- Avisar al server QUÉ key se va a comprar (necesario para x3/x10 con ID
	-- compartido: el ProductId solo no distingue el ítem). DevProductService lo
	-- valida contra el ProductId antes de entregar.
	pcall(function()
		local folder = ReplicatedStorage:FindFirstChild("RemoteEvents")
		local remote = folder and folder:FindFirstChild("DevProductPendingPurchase")
		if remote then
			remote:FireServer(p2)
		end
	end)

	local v1 = DevProducts.GetByKey(p2)

	if not v1 then
		v5:Fire(p2, "Invalid product")

		return false, "Invalid product"
	end

	local v22 = workspace:GetAttribute("InstantPurchasesEnabled")

	if if type(v22) == "boolean" then v22 else Environment.config.InstantPurchases then
		local ProductId = v1.ProductId
		local v42 = if type(ProductId) == "number" then t4[ProductId] else nil

		local FakeRobuxPrompt = require(game:GetService("ReplicatedStorage").SharedModules.FakeRobuxPrompt)
		if not FakeRobuxPrompt.Prompt({
			kind = "Product",
			id = ProductId,
			name = (v42 and type(v42.Name) == "string" and v42.Name ~= "") and v42.Name or p2,
			image = (v42 and type(v42.IconImageAssetId) == "number" and v42.IconImageAssetId > 0) and ("rbxassetid://" .. v42.IconImageAssetId) or nil,
		}) then
			v3:Fire(p2)

			return false, "Cancelled"
		end

		local v7, v8 = Networking.DevProducts.InstantGrant:Fire(p2)

		if v7 then
			v4:Fire(p2)

			return true, "Instant granted"
		end

		v5:Fire(p2, v8 or "Instant grant failed")

		return false, v8 or "Instant grant failed"
	end

	local v9, v10 = p1:PromptPurchaseInternal(p2)

	if v9 and v10 == "Prompted Robux" then
		local ProductId = v1.ProductId

		if type(ProductId) ~= "number" then
			return v9, v10
		end

		t2[ProductId] = p2
	else
		if v9 then
			v4:Fire(p2)

			return v9, v10
		end

		if v10 == "Cancelled" then
			v3:Fire(p2)
		else
			v5:Fire(p2, v10)
		end
	end

	return v9, v10
end
function t.PromptGamepassPurchase(p1, p2) --[[ PromptGamepassPurchase | Line: 503 | Upvalues: v2 (copy), DevProducts (copy), v5 (copy), MarketplaceService (copy), LocalPlayer (copy), Environment (copy), MessagePrompt (copy), Networking (copy), v4 (copy), v3 (copy), t3 (copy) ]]
	v2:Fire(p2)

	local v1 = DevProducts.GetGamepassByKey(p2)

	if not v1 then
		v5:Fire(p2, "Invalid gamepass")

		return false, "Invalid gamepass"
	end

	local GamepassId = v1.GamepassId

	if type(GamepassId) ~= "number" then
		v5:Fire(p2, "Invalid gamepass")

		return false, "Invalid gamepass"
	end

	local ok, result = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, LocalPlayer.UserId, GamepassId)

	if ok and result then
		v5:Fire(p2, "Already owned")

		return false, "Already owned"
	end

	local v22 = LocalPlayer:GetAttribute("OwnedGamepasses")

	if type(v22) == "string" and v22 ~= "" then
		local v32 = p2:match("^Gamepass:([^:]+)")

		if v32 then
			for v42 in v22:gmatch("[^,]+") do
				if v42 == v32 then
					v5:Fire(p2, "Already owned")

					return false, "Already owned"
				end
			end
		end
	end

	local v52 = workspace:GetAttribute("InstantPurchasesEnabled")

	if not (if type(v52) == "boolean" then v52 else Environment.config.InstantPurchases) then
		t3[GamepassId] = p2
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, GamepassId)

		return true, "Prompted Gamepass"
	end

	local FakeRobuxPrompt = require(game:GetService("ReplicatedStorage").SharedModules.FakeRobuxPrompt)
	if not FakeRobuxPrompt.Prompt({
		kind = "Gamepass",
		id = GamepassId,
		name = (type(v1.Name) == "string" and v1.Name ~= "") and v1.Name or p2,
		image = v1.Image,
	}) then
		v3:Fire(p2)

		return false, "Cancelled"
	end

	local v9, v10 = Networking.DevProducts.InstantGrantGamepass:Fire(p2)

	if v9 then
		v4:Fire(p2)

		return true, "Instant granted"
	end

	v5:Fire(p2, v10 or "Instant grant failed")

	return false, v10 or "Instant grant failed"
end
function t.WaitForGamepassesReady(p1) --[[ WaitForGamepassesReady | Line: 567 | Upvalues: v9 (ref) ]]
	if v9 then
		return
	end

	while not v9 do
		task.wait()
	end
end

return t