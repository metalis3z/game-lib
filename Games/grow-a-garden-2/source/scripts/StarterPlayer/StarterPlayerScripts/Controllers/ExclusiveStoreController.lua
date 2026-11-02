--credit to leon games studio
local t = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local NumberUtils = require(ReplicatedStorage.SharedModules.NumberUtils)
local DevProductController = require(Players.LocalPlayer.PlayerScripts.Controllers.DevProductController)
local PlayerSelector = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PlayerSelector")

local function formatTime(p1) --[[ formatTime | Line: 18 ]]
	local v2 = math.max(math.ceil(p1), 0)
	local v3 = math.floor(v2 / 60)
	local v4 = v2 % 60

	if v3 > 0 then
		return string.format("%dm %ds", v3, v4)
	end

	return tostring(v4) .. "s"
end

local function handleGiftPurchase(p1) --[[ handleGiftPurchase | Line: 28 | Upvalues: PlayerSelector (copy), Networking (copy), DevProductController (copy) ]]
	local v1 = nil

	task.spawn(function() --[[ Line: 30 | Upvalues: PlayerSelector (ref), v1 (ref) ]]
		v1 = PlayerSelector.PlayerSelected.Event:Wait() or "cancelled"
	end)
	PlayerSelector.Enabled = true

	repeat
		task.wait()
	until v1 ~= nil

	if v1 ~= "cancelled" then
		local ok, result = pcall(function() --[[ Line: 43 | Upvalues: Networking (ref), v1 (ref) ]]
			Networking.DevProducts.SetGiftTarget:Fire(v1.UserId)
		end)

		if not ok then
			warn((("[ExclusiveStoreController] SetGiftTarget fire failed (%*): %*"):format(p1, result)))
		end

		local ok2, result2 = pcall(function() --[[ Line: 49 | Upvalues: DevProductController (ref), p1 (copy) ]]
			DevProductController:PromptPurchase(p1 .. ":Gift")
		end)

		if not ok2 then
			warn((("[ExclusiveStoreController] Gift purchase prompt failed (%*): %*"):format(p1, result2)))
		end
	end
end

function t.Init(p1) --[[ Init | Line: 61 ]] end
function t.Setup(p1, p2) --[[ Setup | Line: 63 | Upvalues: DevProductController (copy), NumberUtils (copy), RunService (copy), handleGiftPurchase (copy), Networking (copy) ]]
	local container = p2.container
	local templates = p2.templates

	for v1, v2 in templates do
		v2.Visible = false
	end

	local Robux_Shelf = container:WaitForChild("Robux_Shelf")

	Robux_Shelf.Visible = false

	local Buttons = Robux_Shelf.Main_Frame.Buttons
	local v3 = Buttons:WaitForChild("1Button")
	local GiftButton1 = Buttons:WaitForChild("GiftButton1")
	local Seed_Name = Robux_Shelf.Main_Frame:WaitForChild("Seed_Name")
	local t = {}
	local v4 = nil
	local v5 = false
	local v6 = Color3.fromHex("#2d2617")
	local v7 = Color3.fromHex("#2f0000")
	local v8 = ColorSequence.new(Color3.fromHex("#ff0000"))
	local t2 = {}

	local function updateTextAppearance(p1, p2, p3) --[[ updateTextAppearance | Line: 93 | Upvalues: v6 (copy), v7 (copy), t2 (copy), v8 (copy) ]]
		local Text = p1:FindFirstChild("Text")

		if not Text then
			return
		end

		local TextLabel = Text:FindFirstChild("TextLabel")

		if not TextLabel then
			return
		end

		local v1 = TextLabel:FindFirstChildWhichIsA("TextLabel")
		local v2 = TextLabel:FindFirstChildWhichIsA("UIStroke")

		if v2 then
			v2.Color = if p2 then v6 else v7
		end

		if not v1 then
			return
		end

		local v4 = v1:FindFirstChildWhichIsA("UIStroke")

		if v4 then
			v4.Color = if p2 then v6 else v7
		end

		local v62 = v1:FindFirstChildWhichIsA("UIGradient")

		if not v62 then
			return
		end

		if not t2[p3] then
			t2[p3] = v62.Color
		end

		v62.Color = if p2 then t2[p3] else v8
	end

	local function getSelectedEntry() --[[ getSelectedEntry | Line: 125 | Upvalues: v4 (ref), t (copy) ]]
		if not v4 then
			return nil
		end

		for v1, v2 in t do
			if v2.frame == v4 then
				return v2
			end
		end

		return nil
	end

	local function hideShelf() --[[ hideShelf | Line: 135 | Upvalues: Robux_Shelf (copy) ]]
		Robux_Shelf.Visible = false
	end

	local function updateShelf() --[[ updateShelf | Line: 139 | Upvalues: v4 (ref), Robux_Shelf (copy), t (copy), Seed_Name (copy), DevProductController (ref), NumberUtils (ref), v3 (copy), GiftButton1 (copy) ]]
		if not v4 then
			Robux_Shelf.Visible = false

			return
		end

		local v1

		if v4 then
			for v2, v32 in t do
				if v32.frame == v4 then
					v1 = v32

					break
				end
			end
		end

		if v1 then
			local itemData = v1.itemData

			Seed_Name.Value = itemData.itemName
			task.spawn(function() --[[ Line: 155 | Upvalues: DevProductController (ref), itemData (copy), v4 (ref), v1 (copy), NumberUtils (ref), v3 (ref) ]]
				local v12 = DevProductController:WaitForPreloadedProductInfo(itemData.productKey, 5)

				if v4 ~= v1.frame then
					return
				end

				if v12 then
					local v2 = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v12.PriceInRobux)))

					v3.TextDisplay.TextLabel.Text = v2
					v3.TextDisplay.TextLabel.TextLabel.Text = v2
				else
					v3.TextDisplay.TextLabel.Text = "Buy"
					v3.TextDisplay.TextLabel.TextLabel.Text = "Buy"
				end
			end)
			GiftButton1.Visible = itemData.giftable
			Robux_Shelf.Visible = true
		else
			Robux_Shelf.Visible = false
		end
	end

	local function clearDeal(p1) --[[ clearDeal | Line: 174 | Upvalues: t (copy), v4 (ref), Robux_Shelf (copy), t2 (copy) ]]
		local v1 = t[p1]

		if not v1 then
			return
		end

		if v4 == v1.frame then
			v4 = nil
			Robux_Shelf.Visible = false
		end

		if v1.heartbeat then
			v1.heartbeat:Disconnect()
		end

		for v2, v3 in v1.connections do
			v3:Disconnect()
		end

		t2[p1] = nil
		v1.frame:Destroy()
		t[p1] = nil
	end

	local function setupDeal(p1, p2) --[[ setupDeal | Line: 197 | Upvalues: clearDeal (copy), templates (copy), container (copy), DevProductController (ref), NumberUtils (ref), updateTextAppearance (copy), v4 (ref), Robux_Shelf (copy), t (copy), updateShelf (copy), RunService (ref) ]]
		clearDeal(p1)

		local v1 = templates[p1]

		if not v1 then
			return
		end

		local v2 = p2.items[1]

		if not v2 then
			return
		end

		local v3 = v1:Clone()

		v3.Name = "ActiveDeal_" .. p1
		v3.Visible = true
		v3.Parent = container

		local Main_Frame = v3:FindFirstChild("Main_Frame")

		if not Main_Frame then
			return
		end

		local t2 = {}
		local Seed_Text = Main_Frame:FindFirstChild("Seed_Text")

		if Seed_Text then
			Seed_Text.Text = v2.itemName

			local v42 = Seed_Text:FindFirstChildWhichIsA("TextLabel")

			if v42 then
				v42.Text = v2.itemName
			end
		end

		local ImageDisplay = Main_Frame:FindFirstChild("ImageDisplay")

		if ImageDisplay then
			local Vector = ImageDisplay:FindFirstChild("Vector")

			if Vector then
				Vector.Image = v2.image or ""
			end
		end

		local Rarity = Main_Frame:FindFirstChild("Rarity")

		if Rarity then
			local Rarity_Text = Rarity:FindFirstChild("Rarity_Text")

			if Rarity_Text then
				Rarity_Text.Text = p1

				local v5 = Rarity_Text:FindFirstChildWhichIsA("TextLabel")

				if v5 then
					v5.Text = p1
				end
			end
		end

		local Stock_Text = Main_Frame:FindFirstChild("Stock_Text")

		if Stock_Text then
			Stock_Text.Text = if v2.stock > 0 then "x" .. v2.stock .. " in Stock" else "0 Stock"
		end

		local SoldOut = Main_Frame:FindFirstChild("SoldOut")

		if SoldOut then
			SoldOut.Visible = v2.stock <= 0
		end

		local Text = Main_Frame:FindFirstChild("Text")

		if Text then
			local TextLabel = Text:FindFirstChild("TextLabel")

			if TextLabel and v2.stock <= 0 then
				TextLabel.Text = "SOLD OUT"

				local v8 = TextLabel:FindFirstChildWhichIsA("TextLabel")

				if v8 then
					v8.Text = "SOLD OUT"
				end
			elseif TextLabel then
				task.spawn(function() --[[ Line: 269 | Upvalues: DevProductController (ref), v2 (copy), NumberUtils (ref), TextLabel (copy) ]]
					local v1 = DevProductController:WaitForPreloadedProductInfo(v2.productKey, 5)
					local v22 = if v1 then ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v1.PriceInRobux))) else ""

					TextLabel.Text = v22

					local v4 = TextLabel:FindFirstChildWhichIsA("TextLabel")

					if not v4 then
						return
					end

					v4.Text = v22
				end)
			end
		end

		updateTextAppearance(Main_Frame, if v2.stock > 0 then true else false, p1)

		local TextButton = Main_Frame:FindFirstChild("TextButton")

		if TextButton then
			local function f11() --[[ Line: 287 | Upvalues: v4 (ref), v3 (copy), Robux_Shelf (ref), t (ref), updateShelf (ref) ]]
				if v4 == v3 then
					v4 = nil
					Robux_Shelf.Visible = false

					return
				end

				local v1 = nil

				for v2, v32 in t do
					if v32.frame == v3 then
						v1 = v32

						break
					end
				end

				if not (v1 and v1.itemData.stock <= 0) then
					v4 = v3
					Robux_Shelf.LayoutOrder = v3.LayoutOrder + 1
					updateShelf()
				end
			end

			table.insert(t2, TextButton.Activated:Connect(f11))
		end

		local LeavesIn = Main_Frame:FindFirstChild("LeavesIn")
		local v12 = LeavesIn and LeavesIn:FindFirstChild("Timer")
		local v13 = LeavesIn and LeavesIn:FindFirstChild("UIGradient")
		local expiresAt = p2.expiresAt
		local restockTime = p2.restockTime

		t[p1] = {
			frame = v3,
			heartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 317 | Upvalues: expiresAt (copy), clearDeal (ref), p1 (copy), v12 (copy), v13 (copy), restockTime (copy) ]]
				local v1 = expiresAt - os.time()

				if v1 <= 0 then
					clearDeal(p1)

					return
				end

				if v12 then
					local v4 = math.max(math.ceil(v1), 0)
					local v5 = math.floor(v4 / 60)
					local v6 = v4 % 60

					v12.Text = if v5 > 0 then string.format("%dm %ds", v5, v6) else tostring(v6) .. "s"
					v12.TextColor3 = if v1 <= 30 then Color3.fromHex("#ff0000") else Color3.new(255/255, 255/255, 255/255)
				end

				if not v13 then
					return
				end

				v13.Offset = Vector2.new(v1 / restockTime, 0)
			end),
			itemData = v2,
			connections = t2
		}
	end

	local function updateStock(p1, p2) --[[ updateStock | Line: 343 | Upvalues: t (copy), DevProductController (ref), NumberUtils (ref), updateTextAppearance (copy), v4 (ref), Robux_Shelf (copy) ]]
		local v1 = t[p1]

		if not v1 then
			return
		end

		local v2 = p2.items[1]

		if not v2 then
			return
		end

		v1.itemData.stock = v2.stock

		local Main_Frame = v1.frame:FindFirstChild("Main_Frame")

		if not Main_Frame then
			return
		end

		local Stock_Text = Main_Frame:FindFirstChild("Stock_Text")

		if Stock_Text then
			Stock_Text.Text = if v2.stock > 0 then "x" .. v2.stock .. " in Stock" else "0 Stock"
		end

		local SoldOut = Main_Frame:FindFirstChild("SoldOut")

		if SoldOut then
			SoldOut.Visible = v2.stock <= 0
		end

		local Text = Main_Frame:FindFirstChild("Text")

		if Text then
			local TextLabel = Text:FindFirstChild("TextLabel")

			if TextLabel and v2.stock <= 0 then
				TextLabel.Text = "SOLD OUT"

				local v5 = TextLabel:FindFirstChildWhichIsA("TextLabel")

				if v5 then
					v5.Text = "SOLD OUT"
				end
			elseif TextLabel then
				task.spawn(function() --[[ Line: 378 | Upvalues: DevProductController (ref), v1 (copy), NumberUtils (ref), TextLabel (copy) ]]
					local v12 = DevProductController:WaitForPreloadedProductInfo(v1.itemData.productKey, 5)
					local v2 = if v12 then ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v12.PriceInRobux))) else ""

					TextLabel.Text = v2

					local v4 = TextLabel:FindFirstChildWhichIsA("TextLabel")

					if not v4 then
						return
					end

					v4.Text = v2
				end)
			end
		end

		updateTextAppearance(Main_Frame, if v2.stock > 0 then true else false, p1)

		if not (v2.stock <= 0) or v4 ~= v1.frame then
			return
		end

		v4 = nil
		Robux_Shelf.Visible = false
	end

	v3.Activated:Connect(function() --[[ Line: 403 | Upvalues: v5 (ref), v4 (ref), t (copy), DevProductController (ref) ]]
		if v5 then
			return
		end

		local v1

		if v4 then
			for v2, v3 in t do
				if v3.frame == v4 then
					v1 = v3

					break
				end
			end
		end

		if not v1 then
			return
		end

		if v1.itemData.stock <= 0 then
			return
		end

		v5 = true

		local ok, result = pcall(function() --[[ Line: 410 | Upvalues: DevProductController (ref), v1 (copy) ]]
			DevProductController:PromptPurchase(v1.itemData.productKey)
		end)

		if not ok then
			warn((("[ExclusiveStoreController] Buy purchase prompt failed (%*): %*"):format(v1.itemData.productKey, result)))
		end

		task.wait()
		v5 = false
	end)
	GiftButton1.Activated:Connect(function() --[[ Line: 420 | Upvalues: v5 (ref), v4 (ref), t (copy), handleGiftPurchase (ref) ]]
		if v5 then
			return
		end

		local v1

		if v4 then
			for v2, v3 in t do
				if v3.frame == v4 then
					v1 = v3

					break
				end
			end
		end

		if not v1 then
			return
		end

		if v1.itemData.stock <= 0 then
			return
		end

		if not v1.itemData.giftable then
			return
		end

		v5 = true

		local ok, result = pcall(function() --[[ Line: 428 | Upvalues: handleGiftPurchase (ref), v1 (copy) ]]
			handleGiftPurchase(v1.itemData.productKey)
		end)

		if ok then
			task.wait()
			v5 = false

			return
		end

		warn((("[ExclusiveStoreController] Gift flow failed (%*): %*"):format(v1.itemData.productKey, result)))
		task.wait()
		v5 = false
	end)
	Networking.ExclusiveShop.DealUpdate.OnClientEvent:Connect(function(p1) --[[ Line: 441 | Upvalues: t (copy), clearDeal (copy), updateStock (copy), setupDeal (copy) ]]
		for k in pairs(t) do
			if not p1[k] then
				clearDeal(k)
			end
		end

		for v1, v2 in p1 do
			if t[v1] then
				updateStock(v1, v2)

				continue
			end

			setupDeal(v1, v2)
		end
	end)
end

return t