--credit to quartz games studio
repeat
	task.wait()
until game.Players.LocalPlayer:HasTag("ControllersStarted")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer2 = game:GetService("Players").LocalPlayer
local Controllers = LocalPlayer2.PlayerScripts:WaitForChild("Controllers")
local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")
local MarketplaceService = game:GetService("MarketplaceService")
local DevProductController = require(Controllers:WaitForChild("DevProductController"))
local GuiController = require(Controllers:WaitForChild("GuiController"))
local SeedInspectController = require(Controllers:WaitForChild("SeedInspectController"))
local GearInspectController = require(Controllers:WaitForChild("GearInspectController"))
local DevProducts = require(SharedModules:WaitForChild("DevProducts"))
local RobuxShopContent = require(SharedModules:WaitForChild("RobuxShopContent"))
local SeedPackData = require(SharedModules:WaitForChild("SeedPackData"))
local SeedData = require(SharedModules:WaitForChild("SeedData"))
local GearShopData = require(SharedModules:WaitForChild("GearShopData"))
local NumberUtils = require(SharedModules:WaitForChild("NumberUtils"))
local Networking = require(SharedModules:WaitForChild("Networking"))
local ScrollingFrame = script.Parent:WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local ShecklesButton = ScrollingFrame.Parent:WaitForChild("Header"):WaitForChild("ShecklesButton")
local GearsButton = ScrollingFrame.Parent:WaitForChild("Header"):WaitForChild("GearsButton")
local SeedsButton = ScrollingFrame.Parent:WaitForChild("Header"):WaitForChild("SeedsButton")
local BottomBar = LocalPlayer2:WaitForChild("PlayerGui"):WaitForChild("CinematicBars"):WaitForChild("BottomBar")
local v1 = script.Parent

local function scrollToSection(p1) --[[ scrollToSection | Line: 39 | Upvalues: ScrollingFrame (copy), TweenService (copy) ]]
	if p1.Name == "Gears" then
		if p1 then
			TweenService:Create(ScrollingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CanvasPosition = Vector2.new(0, p1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y - 3)
			}):Play()
		end
	elseif p1.Name == "Gacha" then
		if p1 then
			TweenService:Create(ScrollingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CanvasPosition = Vector2.new(0, 0)
			}):Play()
		end
	elseif p1 then
		TweenService:Create(ScrollingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CanvasPosition = Vector2.new(0, p1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y)
		}):Play()
	end
end

ShecklesButton.Activated:Connect(function() --[[ Line: 60 | Upvalues: scrollToSection (copy), ScrollingFrame (copy) ]]
	scrollToSection(ScrollingFrame:FindFirstChild("Sheckles"))
end)
GearsButton.Activated:Connect(function() --[[ Line: 64 | Upvalues: scrollToSection (copy), ScrollingFrame (copy) ]]
	scrollToSection(ScrollingFrame:FindFirstChild("Gears"))
end)
SeedsButton.Activated:Connect(function() --[[ Line: 68 | Upvalues: scrollToSection (copy), ScrollingFrame (copy) ]]
	scrollToSection(ScrollingFrame:FindFirstChild("Gacha"))
end)

local t = {}
local t2 = {}
local t3 = {}
local t4 = {}

for v2, v3 in SeedData do
	local _ = t[v3.SeedName]

	t[v3.SeedName] = v3
end

for v4, v5 in GearShopData.Data do
	t2[v5.ItemName] = v5
end

local Players = game:GetService("Players")

local function recipientOwnsGamepass(p1, p2) --[[ recipientOwnsGamepass | Line: 94 | Upvalues: Players (copy) ]]
	local v1 = p2:match("^Gamepass:([^:]+)")

	if not v1 then
		return false
	end

	local v2 = p1.Player or Players:GetPlayerByUserId(p1.UserId)

	if not v2 then
		return false
	end

	local v3 = v2:GetAttribute("OwnedGamepasses")

	if type(v3) ~= "string" or v3 == "" then
		return false
	end

	for v4 in v3:gmatch("[^,]+") do
		if v4 == v1 then
			return true
		end
	end

	return false
end

local function recipientOwnsGamepassByName(p1, p2) --[[ recipientOwnsGamepassByName | Line: 109 ]]
	if not p1 then
		return false
	end

	local v1 = p1:GetAttribute("OwnedGamepasses")

	if type(v1) ~= "string" or v1 == "" then
		return false
	end

	for v2 in v1:gmatch("[^,]+") do
		if v2 == p2 then
			return true
		end
	end

	return false
end

local function selectGiftTarget(p1) --[[ selectGiftTarget | Line: 123 ]]
	local v1 = nil

	task.spawn(function() --[[ Line: 125 | Upvalues: v1 (ref) ]]
		local v12 = script.Parent.Parent.PlayerSelector.PlayerSelected.Event:Wait()

		v1 = if v12 == nil then "cancelled" else v12
	end)

	local Enabled = script.Parent.Enabled

	script.Parent.Enabled = false
	script.Parent.Parent.PlayerSelector:SetAttribute("OnlineOnly", p1)
	script.Parent.Parent.PlayerSelector.Enabled = true

	repeat
		task.wait()
	until v1 ~= nil

	script.Parent.Enabled = Enabled

	return v1
end

local function handleGiftButton(p1) --[[ handleGiftButton | Line: 144 | Upvalues: selectGiftTarget (copy), Players (copy), ReplicatedStorage (copy), recipientOwnsGamepass (copy), Networking (copy), DevProductController (copy) ]]
	local v1 = p1:match("^Currency:Sheckles:") ~= nil
	local v2 = selectGiftTarget(v1)

	if v2 == "cancelled" then
		return
	end

	if v1 then
		local Player = v2.Player

		if not (Player and Player:IsDescendantOf(Players)) then
			ReplicatedStorage:FindFirstChild("Notify"):Fire("That player went offline.")

			return
		end
	end

	if recipientOwnsGamepass(v2, p1) then
		ReplicatedStorage:FindFirstChild("Notify"):Fire((("<font color=\"#5B9CF5\">@%*</font> already owns this gamepass!"):format(v2.Name)))

		return
	end

	local ok, result = pcall(function() --[[ Line: 168 | Upvalues: Networking (ref), v2 (copy) ]]
		Networking.DevProducts.SetGiftTarget:Fire(v2.UserId)
	end)

	if not ok then
		warn((("[RobuxShop] SetGiftTarget fire failed (%*): %*"):format(p1, result)))
	end

	local ok2, result2 = pcall(function() --[[ Line: 174 | Upvalues: DevProductController (ref), p1 (copy) ]]
		DevProductController:PromptPurchase((("%*:Gift"):format(p1)))
	end)

	if ok2 then
		return
	end

	warn((("[RobuxShop] Gift purchase prompt failed (%*): %*"):format(p1, result2)))
end

local function handleGamepassGift(p1) --[[ handleGamepassGift | Line: 185 | Upvalues: selectGiftTarget (copy), Players (copy), ReplicatedStorage (copy), Networking (copy), DevProductController (copy) ]]
	local v1 = selectGiftTarget(true)

	if v1 == "cancelled" then
		return
	end

	local Player = v1.Player

	if not (Player and Player:IsDescendantOf(Players)) then
		ReplicatedStorage:FindFirstChild("Notify"):Fire("That player went offline.")

		return
	end

	local v2

	if Player then
		local v3 = Player:GetAttribute("OwnedGamepasses")

		if type(v3) == "string" and v3 ~= "" then
			v2 = false

			for v4 in v3:gmatch("[^,]+") do
				if v4 == p1 then
					v2 = true

					break
				end
			end
		else
			v2 = false
		end
	else
		v2 = false
	end

	if v2 then
		ReplicatedStorage:FindFirstChild("Notify"):Fire((("<font color=\"#5B9CF5\">@%*</font> already owns this gamepass!"):format(Player.Name)))

		return
	end

	local ok, result = pcall(function() --[[ Line: 202 | Upvalues: Networking (ref), Player (copy) ]]
		Networking.DevProducts.SetGiftTarget:Fire(Player.UserId)
	end)

	if not ok then
		warn((("[RobuxShop] SetGiftTarget fire failed (gamepass %*): %*"):format(p1, result)))
	end

	local ok2, result2 = pcall(function() --[[ Line: 208 | Upvalues: DevProductController (ref), p1 (copy) ]]
		DevProductController:PromptPurchase((("Gift:%*:1"):format(p1)))
	end)

	if ok2 then
		return
	end

	warn((("[RobuxShop] Gamepass gift prompt failed (%*): %*"):format(p1, result2)))
end

local function setupBuyButtons(p1, p2) --[[ setupBuyButtons | Line: 216 | Upvalues: DevProductController (copy), NumberUtils (copy), handleGiftButton (copy) ]]
	local t = {}

	for k, v in pairs(p1.Buttons:GetChildren()) do
		table.insert(t, v)
	end

	if p1.Buttons:FindFirstChild("Set1") then
		for k, v in pairs(p1.Buttons:GetChildren()) do
			for k2, v2 in pairs(v:GetChildren()) do
				table.insert(t, v2)
			end
		end
	else
		for k, v in pairs(p1.Buttons:GetChildren()) do
			table.insert(t, v)
		end
	end

	for v1, v2 in t do
		if v2:IsA("TextButton") then
			local v3 = v2.Name:find("Gift")
			local v4 = ("%*:%*"):format(p2, (v2.Name:match("%d+")))
			local v5 = DevProductController:WaitForPreloadedProductInfo(v4, 5)

			if v5 then
				local v6 = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v5.PriceInRobux)))

				if v3 then
					v2.Activated:Connect(function() --[[ Line: 254 | Upvalues: handleGiftButton (ref), v4 (copy) ]]
						handleGiftButton(v4)
					end)

					continue
				end

				v2.Price.Text = v6
				v2.Price.TextLabel.Text = v6
				v2.Activated:Connect(function() --[[ Line: 250 | Upvalues: DevProductController (ref), v4 (copy) ]]
					DevProductController:PromptPurchase(v4)
				end)

				continue
			end

			v2.Visible = false
		end
	end
end

local function applySeedPackHeaderStyling(p1, p2) --[[ applySeedPackHeaderStyling | Line: 261 ]]
	p1.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p2[1]), ColorSequenceKeypoint.new(0.123, p2[1]), ColorSequenceKeypoint.new(1, p2[2]) })
	p1.UIStroke.Color = p2[3]
	p1.TextLabel.UIStroke.Color = p2[3]
	p1.TextLabel.TextLabel.UIStroke.Color = p2[3]
	p1.TextLabel.TextLabel.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(0.418, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(1, p2[4]) })
end

local function populateSeedPackPrizes(p1, p2) --[[ populateSeedPackPrizes | Line: 278 | Upvalues: t (copy), SeedInspectController (copy), GuiController (copy) ]]
	table.sort(p2, function(p1, p2) --[[ Line: 279 ]]
		return p1.Chance > p2.Chance
	end)

	for v1, v2 in p2 do
		local v3 = p1.Prizes:FindFirstChild((("Item%*"):format(v1)))

		if v3 then
			v3:SetAttribute("SeedToolTip", v2.SeedName)
			v3.ItemImage.Image = t[v2.SeedName].SeedImage.Value
			v3.ItemName.Text = ("%* Seed"):format(v2.SeedName)
			v3.Odds.Text = ("%*%%"):format(v2.Chance)
			v3.Inspect.Activated:Connect(function() --[[ Line: 293 | Upvalues: SeedInspectController (ref), v2 (copy), GuiController (ref) ]]
				SeedInspectController.Inspect(v2, function() --[[ Line: 296 | Upvalues: GuiController (ref) ]]
					GuiController:Open("RobuxShop", nil, { "HUD" })
				end)
			end)
		end
	end
end

local SeedPacks = game.ReplicatedStorage.Assets.SeedPacks

local function clearViewports() --[[ clearViewports | Line: 306 | Upvalues: t4 (copy) ]]
	for v1, v2 in t4 do
		if v2.Model then
			v2.Model:Destroy()
		end

		if v2.Camera then
			v2.Camera:Destroy()
		end
	end

	table.clear(t4)
end

local function populateAllViewports() --[[ populateAllViewports | Line: 314 | Upvalues: clearViewports (copy), t3 (copy) ]]
	clearViewports()

	for v1, v2 in t3 do
		v2()
	end
end

local function renderSeedPack(p1) --[[ renderSeedPack | Line: 321 | Upvalues: SeedPackData (copy), ScrollingFrame (copy), SeedPacks (copy), t4 (copy), t3 (copy), populateSeedPackPrizes (copy), setupBuyButtons (copy), BottomBar (copy) ]]
	for v1, v2 in p1 do
		local v3 = SeedPackData.GetData(v2.Name)

		if not v3 then
			break
		end

		local v4 = ScrollingFrame.Gacha:Clone()
		local ViewportFrame = v4.BevelEffect.Sunburst.ViewportFrame

		local function populateViewport() --[[ populateViewport | Line: 332 | Upvalues: ViewportFrame (copy), SeedPacks (ref), v2 (copy), v4 (copy), t4 (ref) ]]
			for v1, v22 in ViewportFrame:GetChildren() do
				if v22:IsA("Model") or v22:IsA("Camera") then
					v22:Destroy()
				end
			end

			local v3 = SeedPacks:FindFirstChild(v2.Name)

			if not v3 then
				return
			end

			local v42 = v3:Clone()

			v42.Parent = ViewportFrame

			local v5 = nil

			for k, v in pairs(v42:GetDescendants()) do
				if v:IsA("ImageLabel") then
					v5 = v.Image

					break
				end
			end

			v4.BevelEffect.Sunburst.ViewportFrame.ImageLabel.Image = v5

			local v6 = v42:GetPivot()
			local Camera = Instance.new("Camera")

			Camera.Parent = ViewportFrame
			Camera.FieldOfView = 47
			Camera.CFrame = v6 * CFrame.new(0, 0, -3)
			Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, v6.Position)
			ViewportFrame.CurrentCamera = Camera
			table.insert(t4, {
				VP = ViewportFrame,
				Model = v42,
				Camera = Camera
			})
		end

		table.insert(t3, populateViewport)
		v4.Header.TextLabel.TextLabel.Text = v2.DisplayName
		v4.Header.TextLabel.Text = v2.DisplayName
		populateSeedPackPrizes(v4, v3.Seeds)
		setupBuyButtons(v4, (("SeedPack:%*"):format(v2.Name)))
		setupBuyButtons(BottomBar, (("SeedPack:%*"):format(v2.Name)))
		v4.Visible = true
		v4.Parent = ScrollingFrame
	end
end

local function formatTime(p1) --[[ formatTime | Line: 384 ]]
	local v1 = p1 // 86400
	local v2 = p1 % 86400 // 3600
	local v3 = p1 % 3600 // 60
	local v4, v5

	if v1 > 0 then
		local v6 = ("%*d %*h %*m"):format(v1, v2, v3)

		if v6 then
			v4 = v6
		else
			v5 = ("%*h %*m %*s"):format(v2, v3, p1 % 60)
			v4 = v5
		end
	else
		v5 = ("%*h %*m %*s"):format(v2, v3, p1 % 60)
		v4 = v5
	end

	return v4
end

local t5 = {
	SeedPacks = renderSeedPack,
	StarterPack = function(p1) --[[ renderStarterPack | Line: 389 | Upvalues: ScrollingFrame (copy), DevProductController (copy), RunService (copy), LocalPlayer2 (copy), NumberUtils (copy), t (copy), t2 (copy), SeedPackData (copy) ]]
		local StarterPack = ScrollingFrame:FindFirstChild("StarterPack")

		if not StarterPack then
			return
		end

		local v1 = DevProductController:WaitForPreloadedProductInfo("Standalone:StarterPack:1", 5)

		if not v1 then
			return
		end

		local v2 = nil
		local v3 = nil

		v3 = RunService.Heartbeat:Connect(function() --[[ Line: 396 | Upvalues: LocalPlayer2 (ref), StarterPack (copy), v3 (ref), v2 (ref) ]]
			local v22 = math.max(0, (LocalPlayer2:GetAttribute("StarterPackExpiresAt") or 0) - os.time())

			StarterPack.Visible = v22 > 0

			local v5 = v22 // 86400
			local v6 = v22 % 86400 // 3600
			local v7 = v22 % 3600 // 60
			local v8, v9

			if v5 > 0 then
				local v10 = ("%*d %*h %*m"):format(v5, v6, v7)

				if v10 then
					v8 = v10
				else
					v9 = ("%*h %*m %*s"):format(v6, v7, v22 % 60)
					v8 = v9
				end
			else
				v9 = ("%*h %*m %*s"):format(v6, v7, v22 % 60)
				v8 = v9
			end

			StarterPack.Timer.TextLabel.Text = v8

			local v11 = v22 // 86400
			local v12 = v22 % 86400 // 3600
			local v13 = v22 % 3600 // 60
			local v14, v15

			if v11 > 0 then
				local v16 = ("%*d %*h %*m"):format(v11, v12, v13)

				if v16 then
					v14 = v16
				else
					v15 = ("%*h %*m %*s"):format(v12, v13, v22 % 60)
					v14 = v15
				end
			else
				v15 = ("%*h %*m %*s"):format(v12, v13, v22 % 60)
				v14 = v15
			end

			StarterPack.Timer.TextLabel.TextLabel.Text = v14

			if not (v22 <= 0) then
				return
			end

			v3:Disconnect()

			if not v2 then
				return
			end

			v2:Disconnect()
		end)
		StarterPack.Title.Text = p1.DisplayName
		StarterPack.Title.TextLabel.Text = p1.DisplayName
		StarterPack.BuyButton.Price.Text = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v1.PriceInRobux)))
		StarterPack.BuyButton.Price.TextLabel.Text = StarterPack.BuyButton.Price.Text
		StarterPack.WasPrice.Text = ("Was \238\128\130%*"):format((NumberUtils.FormatWithCommas((math.floor(v1.PriceInRobux * 3)))))

		for v5, v6 in p1.Items do
			local v7 = StarterPack.Rewards:FindFirstChild((("Item%*"):format(v5)))

			if v7 then
				local Type = v6.Type
				local v8 = v6.Name
				local v9 = ("x%* "):format(tonumber(v6.Count) or 1)

				if Type == "Seed" then
					v7.ItemImage.Image = t[v8].SeedImage.Value
					v7.ItemName.Text = ("%*%* Seed"):format(v9, v8)

					continue
				end

				if Type == "Gear" then
					v7.ItemImage.Image = t2[v8].IMG
					v7.ItemName.Text = ("%*%*"):format(v9, v8)

					continue
				end

				if Type == "SeedPack" then
					local v10 = SeedPackData.GetData(v8)

					if v10 then
						v7.ItemImage.Image = v10.IMG or ""
					end

					v7.ItemName.Text = ("%*%*"):format(v9, v8)
				end
			end
		end

		v2 = StarterPack.BuyButton.Activated:Connect(function() --[[ Line: 431 | Upvalues: DevProductController (ref) ]]
			DevProductController:PromptPurchase("Standalone:StarterPack:1")
		end)
	end,
	Sheckles = function(p1) --[[ renderSheckles | Line: 436 | Upvalues: ScrollingFrame (copy), DevProductController (copy), NumberUtils (copy), handleGiftButton (copy) ]]
		local Sheckles = ScrollingFrame:FindFirstChild("Sheckles")

		table.sort(p1, function(p1, p2) --[[ Line: 438 ]]
			return p1.Amount < p2.Amount
		end)

		for v1, v2 in p1 do
			local Amount = v2.Amount
			local Image = v2.Image
			local v3 = Sheckles.Frame:FindFirstChild((("Package%*"):format(v1)))
			local v4 = DevProductController:WaitForPreloadedProductInfo(("Currency:Sheckles:%*"):format(v2.Amount), 5)
			local ProductImage = v3:FindFirstChild("ProductImage", true)
			local Amount2 = v3:FindFirstChild("Amount", true)
			local BuyButton = v3:FindFirstChild("BuyButton")
			local BuyGiftButton = v3:FindFirstChild("BuyGiftButton")

			if v4 and (ProductImage and (Amount2 and BuyButton)) then
				ProductImage.Image = Image
				Amount2.Text = ("%* Sheckles"):format((NumberUtils.FormatWithCommas(Amount)))
				BuyButton.Price.Text = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v4.PriceInRobux)))
				BuyButton.Price.TextLabel.Text = BuyButton.Price.Text
				BuyButton.Activated:Connect(function() --[[ Line: 454 | Upvalues: DevProductController (ref), v2 (copy) ]]
					DevProductController:PromptPurchase((("Currency:Sheckles:%*"):format(v2.Amount)))
				end)
				BuyGiftButton.Activated:Connect(function() --[[ Line: 458 | Upvalues: handleGiftButton (ref), v2 (copy) ]]
					handleGiftButton((("Currency:Sheckles:%*"):format(v2.Amount)))
				end)
			end
		end
	end,
	Gears = function(p1) --[[ renderGears | Line: 464 | Upvalues: ScrollingFrame (copy), DevProducts (copy), DevProductController (copy), MarketplaceService (copy), t2 (copy), NumberUtils (copy), handleGamepassGift (copy), handleGiftButton (copy), GearInspectController (copy), GuiController (copy), LocalPlayer2 (copy) ]]
		local Gears = ScrollingFrame:FindFirstChild("Gears")

		for v1, v2 in p1 do
			local v3 = Gears.Frame:FindFirstChild((("Gear%*"):format(v1)))

			if v3 then
				local isNotGamepassKey = v2.GamepassKey ~= nil
				local v4 = nil
				local v5

				if isNotGamepassKey then
					local v6 = DevProducts.GetGamepassByKey(v2.GamepassKey)
					local v7, v8, v9, v10

					if v6 then
						v5 = v6.Image
						v7, v8 = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v6.GamepassId, Enum.InfoType.GamePass)

						if v7 and v8 then
							v4 = v8.PriceInRobux

							if not v5 then
								v9 = v8.IconImageAssetId

								if type(v9) == "number" then
									v10 = ("rbxassetid://%*"):format(v8.IconImageAssetId)
									v5 = v10
								end
							end
						end

						if v5 then
							v3.ImageDisplay.ItemImage.Image = v5
							v3.ItemName.Text = v2.Name
							v3.ItemName.ItemName.Text = v2.Name
							v3.Description.Text = v2.Description

							if v4 then
								v3.BuyButton.Price.Text = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v4)))
								v3.BuyButton.Price.TextLabel.Text = v3.BuyButton.Price.Text
							else
								v3.BuyButton.Price.Text = "..."
								v3.BuyButton.Price.TextLabel.Text = "..."
							end

							if v2.Name == "Rainbow Carpet" then
								v3.UIGradient:Destroy()
								script.UIGradient:Clone().Parent = v3
							else
								v3.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v2.Colors[1]), ColorSequenceKeypoint.new(0.147, v2.Colors[2]), ColorSequenceKeypoint.new(1, v2.Colors[5]) })
							end

							v3.ItemName.ItemName.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(1, v2.Colors[5]) })
							v3.ItemName.ItemName.UIStroke.Color = v2.Colors[3]
							v3.ItemName.UIStroke.Color = v2.Colors[3]
							v3.Description.UIStroke.Color = v2.Colors[3]
							v3.UIStroke.Color = v2.Colors[3]
							v3.ImageDisplay.BackgroundColor3 = v2.Colors[3]
							v3.ImageDisplay.Sunburst.ImageColor3 = v2.Colors[5]

							if isNotGamepassKey then
								v3.BuyButton.Activated:Connect(function() --[[ Line: 536 | Upvalues: DevProductController (ref), v2 (copy) ]]
									DevProductController:PromptGamepassPurchase(v2.GamepassKey)
								end)
								v3.GiftButton.Activated:Connect(function() --[[ Line: 538 | Upvalues: handleGamepassGift (ref), v2 (copy) ]]
									handleGamepassGift(v2.Name)
								end)
							else
								v3.BuyButton.Activated:Connect(function() --[[ Line: 541 | Upvalues: DevProductController (ref), v2 (copy) ]]
									DevProductController:PromptPurchase((("Gear:%*:1"):format(v2.Name)))
								end)
								v3.GiftButton.Activated:Connect(function() --[[ Line: 543 | Upvalues: handleGiftButton (ref), v2 (copy) ]]
									handleGiftButton((("Gear:%*:1"):format(v2.Name)))
								end)
							end

							v3.Inspect.Activated:Connect(function() --[[ Line: 547 | Upvalues: GearInspectController (ref), v2 (copy), GuiController (ref) ]]
								GearInspectController.Inspect({
									GearName = v2.Name
								}, function() --[[ Line: 550 | Upvalues: GuiController (ref) ]]
									GuiController:Open("RobuxShop", nil, { "HUD" })
								end)
							end)
						end
					else
						DevProductController:WaitForGamepassesReady()

						local v11 = DevProducts.GetGamepassByKey(v2.GamepassKey)

						if v11 then
							v6 = v11
							v5 = v11.Image
							v7, v8 = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v11.GamepassId, Enum.InfoType.GamePass)

							if v7 and v8 then
								v4 = v8.PriceInRobux

								if not v5 then
									v9 = v8.IconImageAssetId

									if type(v9) == "number" then
										v10 = ("rbxassetid://%*"):format(v8.IconImageAssetId)
										v5 = v10
									end
								end
							end

							if v5 then
								v3.ImageDisplay.ItemImage.Image = v5
								v3.ItemName.Text = v2.Name
								v3.ItemName.ItemName.Text = v2.Name
								v3.Description.Text = v2.Description

								if v4 then
									v3.BuyButton.Price.Text = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v4)))
									v3.BuyButton.Price.TextLabel.Text = v3.BuyButton.Price.Text
								else
									v3.BuyButton.Price.Text = "..."
									v3.BuyButton.Price.TextLabel.Text = "..."
								end

								if v2.Name == "Rainbow Carpet" then
									v3.UIGradient:Destroy()
									script.UIGradient:Clone().Parent = v3
								else
									v3.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v2.Colors[1]), ColorSequenceKeypoint.new(0.147, v2.Colors[2]), ColorSequenceKeypoint.new(1, v2.Colors[5]) })
								end

								v3.ItemName.ItemName.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(1, v2.Colors[5]) })
								v3.ItemName.ItemName.UIStroke.Color = v2.Colors[3]
								v3.ItemName.UIStroke.Color = v2.Colors[3]
								v3.Description.UIStroke.Color = v2.Colors[3]
								v3.UIStroke.Color = v2.Colors[3]
								v3.ImageDisplay.BackgroundColor3 = v2.Colors[3]
								v3.ImageDisplay.Sunburst.ImageColor3 = v2.Colors[5]

								if isNotGamepassKey then
									v3.BuyButton.Activated:Connect(function() --[[ Line: 536 | Upvalues: DevProductController (ref), v2 (copy) ]]
										DevProductController:PromptGamepassPurchase(v2.GamepassKey)
									end)
									v3.GiftButton.Activated:Connect(function() --[[ Line: 538 | Upvalues: handleGamepassGift (ref), v2 (copy) ]]
										handleGamepassGift(v2.Name)
									end)
								else
									v3.BuyButton.Activated:Connect(function() --[[ Line: 541 | Upvalues: DevProductController (ref), v2 (copy) ]]
										DevProductController:PromptPurchase((("Gear:%*:1"):format(v2.Name)))
									end)
									v3.GiftButton.Activated:Connect(function() --[[ Line: 543 | Upvalues: handleGiftButton (ref), v2 (copy) ]]
										handleGiftButton((("Gear:%*:1"):format(v2.Name)))
									end)
								end

								v3.Inspect.Activated:Connect(function() --[[ Line: 547 | Upvalues: GearInspectController (ref), v2 (copy), GuiController (ref) ]]
									GearInspectController.Inspect({
										GearName = v2.Name
									}, function() --[[ Line: 550 | Upvalues: GuiController (ref) ]]
										GuiController:Open("RobuxShop", nil, { "HUD" })
									end)
								end)
							end
						end
					end
				else
					local v12 = t2[v2.Name]
					local v13 = DevProductController:WaitForPreloadedProductInfo(("Gear:%*:1"):format(v2.Name), 5)
					local v14 = if v12 then v12.IMG else v12

					v5, v4 = v14, if v13 then v13.PriceInRobux else v13

					if v5 then
						v3.ImageDisplay.ItemImage.Image = v5
						v3.ItemName.Text = v2.Name
						v3.ItemName.ItemName.Text = v2.Name
						v3.Description.Text = v2.Description

						if v4 then
							v3.BuyButton.Price.Text = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v4)))
							v3.BuyButton.Price.TextLabel.Text = v3.BuyButton.Price.Text
						else
							v3.BuyButton.Price.Text = "..."
							v3.BuyButton.Price.TextLabel.Text = "..."
						end

						if v2.Name == "Rainbow Carpet" then
							v3.UIGradient:Destroy()
							script.UIGradient:Clone().Parent = v3
						else
							v3.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v2.Colors[1]), ColorSequenceKeypoint.new(0.147, v2.Colors[2]), ColorSequenceKeypoint.new(1, v2.Colors[5]) })
						end

						v3.ItemName.ItemName.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(1, v2.Colors[5]) })
						v3.ItemName.ItemName.UIStroke.Color = v2.Colors[3]
						v3.ItemName.UIStroke.Color = v2.Colors[3]
						v3.Description.UIStroke.Color = v2.Colors[3]
						v3.UIStroke.Color = v2.Colors[3]
						v3.ImageDisplay.BackgroundColor3 = v2.Colors[3]
						v3.ImageDisplay.Sunburst.ImageColor3 = v2.Colors[5]

						if isNotGamepassKey then
							v3.BuyButton.Activated:Connect(function() --[[ Line: 536 | Upvalues: DevProductController (ref), v2 (copy) ]]
								DevProductController:PromptGamepassPurchase(v2.GamepassKey)
							end)
							v3.GiftButton.Activated:Connect(function() --[[ Line: 538 | Upvalues: handleGamepassGift (ref), v2 (copy) ]]
								handleGamepassGift(v2.Name)
							end)
						else
							v3.BuyButton.Activated:Connect(function() --[[ Line: 541 | Upvalues: DevProductController (ref), v2 (copy) ]]
								DevProductController:PromptPurchase((("Gear:%*:1"):format(v2.Name)))
							end)
							v3.GiftButton.Activated:Connect(function() --[[ Line: 543 | Upvalues: handleGiftButton (ref), v2 (copy) ]]
								handleGiftButton((("Gear:%*:1"):format(v2.Name)))
							end)
						end

						v3.Inspect.Activated:Connect(function() --[[ Line: 547 | Upvalues: GearInspectController (ref), v2 (copy), GuiController (ref) ]]
							GearInspectController.Inspect({
								GearName = v2.Name
							}, function() --[[ Line: 550 | Upvalues: GuiController (ref) ]]
								GuiController:Open("RobuxShop", nil, { "HUD" })
							end)
						end)
					end
				end
			end
		end

		local t = {}

		for v16, v17 in p1 do
			if v17.GamepassKey then
				local v18 = Gears.Frame:FindFirstChild((("Gear%*"):format(v16)))

				if v18 then
					table.insert(t, {
						frame = v18,
						name = v17.Name
					})
				end
			end
		end

		if not (#t > 0) then
			return
		end

		local function refreshOwnedState() --[[ refreshOwnedState | Line: 568 | Upvalues: LocalPlayer2 (ref), t (copy) ]]
			local t2 = {}

			for v1 in (LocalPlayer2:GetAttribute("OwnedGamepasses") or ""):gmatch("[^,]+") do
				t2[v1] = true
			end

			for v2, v3 in t do
				local v4 = t2[v3.name] == true

				v3.frame.BuyButton.Visible = not v4
				v3.frame.OwnedText.Visible = v4
			end
		end

		refreshOwnedState()
		LocalPlayer2:GetAttributeChangedSignal("OwnedGamepasses"):Connect(refreshOwnedState)
	end
}

for v6, v7 in RobuxShopContent do
	local v8 = t5[v6]

	if v8 then
		task.spawn(v8, v7)
	end
end

v1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 600 | Upvalues: v1 (copy), clearViewports (copy), t3 (copy) ]]
	if not v1.Enabled then
		clearViewports()

		return
	end

	clearViewports()

	for v12, v2 in t3 do
		v2()
	end
end)
GuiController:Hook("Click", ScrollingFrame.Parent:WaitForChild("Header"):WaitForChild("ExitButton")).Clicked:Connect(function() --[[ Line: 608 | Upvalues: GuiController (copy) ]]
	GuiController:Close()
end)

local v9 = Random.new()
local v10 = script.Parent
local t6 = {}

local function register(p1) --[[ register | Line: 617 | Upvalues: t6 (copy), v9 (copy) ]]
	if not p1:IsA("ImageLabel") or p1.Name ~= "Sparkle" then
		return
	end

	t6[p1] = {
		speed = v9:NextNumber(0.8, 1.5),
		offset = v9:NextNumber(0, 6.283185307179586)
	}
end

local function unregister(p1) --[[ unregister | Line: 626 | Upvalues: t6 (copy) ]]
	t6[p1] = nil
end

for v11, v12 in v10:QueryDescendants("ImageLabel#Sparkle") do
	register(v12)
end

v10.DescendantAdded:Connect(register)
v10.DescendantRemoving:Connect(unregister)
RunService.Heartbeat:Connect(function() --[[ Line: 632 | Upvalues: t6 (copy) ]]
	local v1 = os.clock() * 3

	for v2, v3 in t6 do
		local v4 = v1 * v3.speed + v3.offset

		v2.Rotation = math.sin(v4) * 15
		v2.ImageTransparency = math.sin(v4 * 1.3) * 0.4 + 0.4
	end
end)