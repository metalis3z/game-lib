-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local CommerceService = game:GetService("CommerceService")

game:GetService("ConfigService")

local CollectionService = game:GetService("CollectionService")
local v7 = RunService:IsStudio() and false
local v8 = RunService:IsStudio() and false
local v9 = RunService:IsStudio() and false
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local CustomRichTextController = require(ReplicatedStorage.Controllers.CustomRichTextController)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Synchronizer = require(Packages.Synchronizer)
local Observers = require(Packages.Observers)
local Replion = require(Packages.Replion)
local FFlags = require(Packages.FFlags)
local Signal = require(Packages.Signal)
local Timer = require(Packages.Timer)
local Trove = require(Packages.Trove)
local Net = require(Packages.Net)
local Mutations = require(ReplicatedStorage.Shared.Mutations)
local MutationText = require(ReplicatedStorage.Shared.MutationText)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimatedButton = require(Classes.AnimatedButton)
local Utils = ReplicatedStorage:WaitForChild("Utils")
local NumberUtils = require(Utils.NumberUtils)
local TimeUtils = require(Utils.TimeUtils)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Animals = require(Shared.Animals)

require(Shared.BaseSkins)

local Marketplace = require(Shared.Marketplace)
local Updates = require(Shared.Updates)
local Policy = require(Shared.Policy)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local ServerLuck = require(Datas.ServerLuck)
local LuckyBlocks = require(Datas.LuckyBlocks)
local Mutations2 = require(Datas.Mutations)
local Shop = require(Datas.Shop)
local MerchShopData = require(ReplicatedStorage.Datas.MerchShopData)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests)
local LuckyBlockFlags = require(ReplicatedStorage.Shared.Flags.LuckyBlockFlags)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Shop2 = PlayerGui:WaitForChild("Shop").Shop
local v49 = Shop2:QueryDescendants(".Shop_BlackFridaySale")
local u50 = nil
local GiftPlayer = PlayerGui:WaitForChild("GiftPlayer").GiftPlayer
local Close = GiftPlayer:WaitForChild("Header"):WaitForChild("Close")
local List = GiftPlayer:WaitForChild("Main"):WaitForChild("List")
local Template = List:WaitForChild("Template")
local GiftPlayerSelect = Shop2.GiftPlayerSelect
local GiftButton = GiftPlayerSelect.Buttons:WaitForChild("GiftButton")
local Txt = GiftButton:WaitForChild("Txt")
local GiftInventoryButton = GiftPlayerSelect.Buttons.GiftInventoryButton
local PlayerSelected = GiftPlayerSelect:WaitForChild("PlayerSelected")
local Headshot = PlayerSelected:WaitForChild("PlayerImage"):WaitForChild("Headshot")
local PlayerName = PlayerSelected:WaitForChild("PlayerName")
local v62 = Net:RemoteEvent("ShopService/Purchase")
local v63 = Net:RemoteEvent("ShopService/ShopOpened")
local v64 = Timer.new(300)
local u65 = nil
local v66 = Signal.new()
local v67 = Signal.new()
local u68 = nil
local t1 = {
	GiftFrame = GiftPlayer,
	ToggleGiftSignal = v66
}

local function BLACKFRIDAY_toggleSaleLabels(p1)
	if p1 == u50 then
		return
	end

	u50 = p1

	for _, v95 in v49 do
		v95.Visible = p1
	end
end
local function formatPriceInRobux(p2)
	if p2 == 999999999 then
		return "???"
	end

	return (NumberUtils:Comma(p2))
end
local function formatPriceInUSD(p3)
	if p3 == 999999999 then
		return "$???"
	end

	return `${ string.format(p3, "%0.2f") }`
end
local function formatPriceInRobuxToUSD(p4)
	if p4 == 999999999 then
		return "$???"
	end

	local v99 = math.ceil(0.012375 * p4 * 100) / 100

	if v99 == 999999999 then
		return "$???"
	end

	return `${ string.format(v99, "%0.2f") }`
end

local t2 = {}

local function unbindLabelProductPrice(p5)
	if t2[p5] then
		t2[p5]:Destroy()
	end
end
local function bindLabelToProductPrice(p6, n1: number, s1: string?, n2: number?)
	local u105 = s1 or "Product"
	local s2 = "\238\128\130"

	if n2 then
		s2 = `<font weight="{ n2 }">{ s2 }</font>`
	end

	local PriceInRobux = nil

	local function updateLabel()
		local v294 = Synchronizer:Get(LocalPlayer)

		if v294 then
			local v295 = v294:Get({
				"FailedGifts",
				(tostring(n1))
			})

			if v295 ~= nil and next(v295) then
				p6.Text = `FREE ({ #v295 })`

				return
			end
		end

		local Instant = FFlags:GetInstant("CustomProductPrices", {})
		local v297 = Instant and Instant[tostring(n1)] or PriceInRobux

		if v297 == nil then
			p6.Text = `{ s2 }...`

			return
		end

		p6.Text = `{ s2 }{ (if v297 ~= 999999999 then NumberUtils:Comma(v297) else "???") }`
	end
	local function updateRbxPrice()
		for attempt = 1, 8 do
			local ok, result = pcall(function()
				return Marketplace:GetProductInfo(n1, u105)
			end)

			if ok and result and type(result.PriceInRobux) == "number" and result.PriceInRobux ~= 999999999 then
				PriceInRobux = result.PriceInRobux
				updateLabel()
				return
			end

			Marketplace:RemoveCache(n1)
			task.wait(0.5)
		end

		if PriceInRobux == nil then
			PriceInRobux = 999999999
			updateLabel()
		end
	end

	do
		local ok, result = pcall(function()
			return Marketplace:GetProductInfo(n1, u105)
		end)
		if ok and result and type(result.PriceInRobux) == "number" and result.PriceInRobux ~= 999999999 then
			PriceInRobux = result.PriceInRobux
		end
	end

	updateLabel()

	local v110 = Trove.new()

	t2[p6] = v110
	v110:Add(function()
		t2[p6] = nil
	end)
	v110:Add(p6.Destroying:Connect(function()
		v110:Destroy()
	end))

	local Instant = FFlags:GetInstant("RefreshClientDisplayedPrices")
	local Instant2 = FFlags:GetInstant("CustomProductPrices")

	local function checkForFFlagUpdates()
		local Instant3 = FFlags:GetInstant("RefreshClientDisplayedPrices")

		if Instant3 ~= Instant then
			Instant = Instant3
			Marketplace:RemoveCache(n1)

			local ok, result = pcall(function()
				return Marketplace:GetProductInfo(n1, u105)
			end)

			if ok and result and type(result.PriceInRobux) == "number" then
				PriceInRobux = result.PriceInRobux
			else
				PriceInRobux = 999999999
			end

			updateLabel()
		end

		local Instant4 = FFlags:GetInstant("CustomProductPrices")

		if Instant4 ~= Instant2 then
			Instant2 = Instant4
			updateLabel()
		end
	end

	v110:Add(FFlags:OnUpdate(checkForFFlagUpdates))
	v110:Add(FFlags:OnChange("CustomProductPrices", updateLabel))
	v110:Add(FFlags:OnChange("RefreshClientDisplayedPrices", checkForFFlagUpdates))
	Synchronizer:WaitAndCall(LocalPlayer, function(p7)
		if t2[p6] ~= v110 then
			return
		end

		v110:Add(p7:OnArrayInserted({
			"FailedGifts",
			(tostring(n1))
		}, updateLabel))
		v110:Add(p7:OnArrayRemoved({
			"FailedGifts",
			(tostring(n1))
		}, updateLabel))
		v110:Add(p7:OnChanged({
			"FailedGifts",
			(tostring(n1))
		}, updateLabel))
	end)
	v110:Add(task.spawn(updateRbxPrice))

	return v110
end
local function SetLayoutOrder(p8, n3: number?)
	local OriginalOrder = p8:GetAttribute("OriginalOrder")

	if not OriginalOrder then
		OriginalOrder = p8.LayoutOrder
		p8:SetAttribute("OriginalOrder", OriginalOrder)
	end

	p8.LayoutOrder = n3 or OriginalOrder
end
local function setupOdds(p9, p10, s3: string)
	local v120 = Trove.new()
	local u121 = nil

	local function setOddsVisibility(b1: boolean)
		p9.Visible = b1

		if b1 == u121 then
			return
		end

		u121 = b1

		if b1 then
			local v306 = Mutations.get()
			local t3 = {}
			local v308 = LuckyBlockFlags.OddsOverride:Get()[s3]

			if v308 and next(v308) then
				for v309, v310 in v308 do
					table.insert(t3, {
						animal = v309,
						chance = v310
					})
				end
			else
				for _, v312 in p10.Animals do
					if (not v312.IsEnabled or v312.IsEnabled()) and v312.Chance then
						table.insert(t3, {
							animal = v312.Name,
							chance = v312.Chance
						})
					end
				end
			end

			table.sort(t3, function(p11, p12)
				return p12.chance < p11.chance
			end)

			local v313 = p9:GetAttribute("XScalar") or 1
			local u314 = p9.Template.Size.X.Scale * v313
			local v315 = math.ceil(1 / u314) + 1
			local v316 = math.ceil(v315 / #t3) * #t3
			local t4 = table.create(v316)
			local n4 = 0

			for i = 1, v316 do
				local v320 = t3[(i - 1) % #t3 + 1]
				local clone = v120:Clone(p9.Template)

				clone.Name = tostring(i)
				clone.LayoutOrder = i
				clone.Chance.Text = `{ v320.chance }%`
				clone.Visible = true
				clone.Position = UDim2.fromScale(n4, 0.5)
				clone.Parent = p9
				n4 += u314
				t4[i] = clone

				local v322 = Animals:AttachOnViewport(v320.animal, clone, true, v306)

				if v322 then
					v120:Add(v322)
				end
			end

			if v315 <= #t4 then
				local n5 = 0.5

				if v313 > 1 then
					n5 *= v313
				end

				v120:Add(RunService.PreRender:Connect(function(n6: number)
					local v430 = u314 * n6 * n5

					for _, v432 in t4 do
						v432.Position = v432.Position - UDim2.fromScale(v430, 0)

						if v432.Position.X.Scale <= -u314 then
							v432.Position = v432.Position + UDim2.fromScale(u314 * #t4, 0)
						end
					end
				end))
			end

			return
		end

		v120:Clean()
	end

	Updates.OnUpdateEnabled:Connect(function()
		if p9.Visible and u68:IsOpened() then
			p9.Visible = false

			if u121 ~= false then
				u121 = false
				v120:Clean()
			end

			setOddsVisibility(true)
		end
	end)
	Updates.OnUpdateDisabled:Connect(function()
		if p9.Visible and u68:IsOpened() then
			p9.Visible = false

			if u121 ~= false then
				u121 = false
				v120:Clean()
			end

			setOddsVisibility(true)
		end
	end)
	u68.OnClose:Connect(function()
		p9.Visible = false

		if u121 == false then
			return
		end

		u121 = false
		v120:Clean()
	end)
	u68.OnOpen:Connect(function()
		setOddsVisibility(true)
	end)
	Mutations.watch(function()
		if p9.Visible and u68:IsOpened() then
			p9.Visible = false

			if u121 ~= false then
				u121 = false
				v120:Clean()
			end

			setOddsVisibility(true)
		end
	end)
	LuckyBlockFlags.OddsOverride.Changed:Connect(function()
		if p9.Visible and u68:IsOpened() then
			p9.Visible = false

			if u121 ~= false then
				u121 = false
				v120:Clean()
			end

			setOddsVisibility(true)
		end
	end)
end
local function SetupLuckyBlocks()
	local LuckyBlocksList = Shop2.Content.List.LuckyBlocksList
	local LuckyBlocks2 = Shop2.Content.List.LuckyBlocks

	LuckyBlocksList.Visible = false
	LuckyBlocks2.Visible = false

	local v125 = Policy.getPolicy(Players.LocalPlayer)

	if not v125 or v125.ArePaidRandomItemsRestricted then
		return
	end

	LuckyBlocksList.Visible = true
	LuckyBlocks2.Visible = true
	task.spawn(function()
		while true do
			local ServerTimeNow = workspace:GetServerTimeNow()
			local v325 = FFlags:GetInstant("LuckyBlockEndTimer", 1753545600) - ServerTimeNow

			LuckyBlocks2.Text = not (v325 > 0) and "LUCKY BLOCKS" or `LUCKY BLOCKS (<font color="#ffff00">{ TimeUtils:E(v325) }</font>)`
			task.wait(1)
		end
	end)

	local function setup(p13, s4: string?, n7: number?)
		local v329 = s4 or p13.Name
		local v330 = LuckyBlocks[v329]

		if not v330 then
			return
		end

		local v331 = n7 or v330.ProductId

		if not v331 then
			return
		end

		for _, child in ipairs(p13:GetChildren()) do
			if child.Name == "Odds" then
				local v334 = child:GetAttribute("LuckyBlock") or v329

				setupOdds(child, LuckyBlocks[v334], v334)
			end
		end

		local v335 = Trove.new()

		local function updateInfo()
			v335:Destroy()

			if not u68:IsOpened() then
				return
			end

			local v433 = Mutations.get()

			if v433 and Mutations2[v433] then
				MutationText.ApplyToLabel(p13.Mutation, v433, "Rich")
				p13.Mutation.Visible = true
			else
				p13.Mutation.Visible = nil
			end

			for _, child in ipairs(p13:GetChildren()) do
				if child:IsA("ViewportFrame") and child.Name == "IconViewport" then
					local v436 = child:GetAttribute("LuckyBlock") or v329
					local v437 = Animals:AttachOnViewport(v436, child, true, v433)

					if v437 then
						v335:Add(v437)
					end
				end
			end
		end

		task.spawn(updateInfo)
		u68.OnClose:Connect(function()
			updateInfo()
		end)
		u68.OnOpen:Connect(function()
			updateInfo()
		end)
		Mutations.watch(function()
			task.spawn(updateInfo)
		end)

		local v337 = AnimatedButton.new(p13.Buy)

		v337:Animate()
		v337.OnActivated:Connect(function()
			local GiftProductId = p13.Buy:GetAttribute("GiftProductId")

			v62:FireServer(GiftProductId or v331, u65)
		end)
		task.spawn(function()
			bindLabelToProductPrice(p13.Buy.Price, v331, "Product", 100)
		end)
	end

	task.spawn(function()
		local function isSummerLuckyBlockActive()
			return Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026")
		end

		local v339 = Shop2.Content.List:FindFirstChild("Octo Lucky Block")

		if not v339 then
			return
		end

		for _, child in ipairs(v339:GetChildren()) do
			if child.Name == "Odds" then
				setupOdds(child, LuckyBlocks["Premium Octo Lucky Block"], "Premium Octo Lucky Block")
			end
		end

		local v342 = Trove.new()

		local function updateInfo()
			v342:Destroy()

			if not u68:IsOpened() then
				return
			end

			local v439 = Mutations.get()

			if v439 and Mutations2[v439] then
				MutationText.ApplyToLabel(v339.Mutation, v439, "Rich")
				v339.Mutation.Visible = true
			else
				v339.Mutation.Visible = nil
			end

			for _, child in ipairs(v339:GetChildren()) do
				if child:IsA("ViewportFrame") and child.Name == "IconViewport" then
					local v442 = Animals:AttachOnViewport("Premium Octo Lucky Block", child, true, v439)

					if v442 then
						v342:Add(v442)
					end
				end
			end
		end

		task.spawn(updateInfo)
		u68.OnClose:Connect(updateInfo)
		u68.OnOpen:Connect(updateInfo)
		Mutations.watch(updateInfo)

		local v344 = AnimatedButton.new(v339.Buttons.Buy)

		v344:Animate()
		v344.OnActivated:Connect(function()
			v62:FireServer(3603521263, u65)
		end)

		local v345 = AnimatedButton.new(v339.Buttons.Buy3)

		v345:Animate()
		v345.OnActivated:Connect(function()
			v62:FireServer(3603521264, u65)
		end)

		local v346 = AnimatedButton.new(v339.Buttons.Buy10)

		v346:Animate()
		v346.OnActivated:Connect(function()
			v62:FireServer(3603521280, u65)
		end)

		local function updateBuyVisibility()
			if v339.Buttons:FindFirstChild("Buy") then v339.Buttons.Buy.Visible = true end
			v345.Instance.Visible = true
			v346.Instance.Visible = true
		end

		task.spawn(function()
			bindLabelToProductPrice(v339.Buttons.Buy.Price, 3603521263, "Product")
			bindLabelToProductPrice(v339.Buttons.Buy3.Price, 3603521264, "Product")
			bindLabelToProductPrice(v339.Buttons.Buy10.Price, 3603521280, "Product")
		end)
		task.spawn(function()
			local v445 = Synchronizer:Wait(LocalPlayer)

			if not v445 then
				return
			end

			v445:OnChanged({
				"LuckyBlocks",
				(tostring(3603521264))
			}, updateBuyVisibility)
			updateBuyVisibility()
		end)
		task.spawn(updateBuyVisibility)

		local Timer2 = v339:WaitForChild("Timer")
		local SummerTitle = v339.Parent:FindFirstChild("SummerTitle")

		Timer.Simple(1, function()
			v339.Visible = Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026")

			if SummerTitle then
				SummerTitle.Visible = Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026")
			end

			local v446 = Updates.Methods.GetUpdateTime("Update-07/04/2026") or 0
			local ServerTimeNow = workspace:GetServerTimeNow()

			if Timer2 then
				Timer2.Text = `{ TimeUtils:E(v446 - ServerTimeNow) } left`
			end
		end)
	end)

	for _, child in LuckyBlocksList:GetChildren() do
		setup(child)
	end

	task.spawn(function()
		local ItemsListPromo1 = Shop2.Content.List.ItemsListPromo1

		setup(ItemsListPromo1["Secret Lucky Block"])

		local function update()
			ItemsListPromo1.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.FlyingCarpetPromo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo1.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.FlyingCarpetPromo", false)
	end)
	task.spawn(function()
		local ItemsListPromo2 = Shop2.Content.List.ItemsListPromo2

		setup(ItemsListPromo2["Secret Lucky Block"])

		local function update()
			ItemsListPromo2.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.AdminPanelPromo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo2.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.AdminPanelPromo", false)
	end)
	task.spawn(function()
		local ItemsListPromo3 = Shop2.Content.List.ItemsListPromo3

		setup(ItemsListPromo3["Secret Lucky Block"])
		setup(ItemsListPromo3["Secret Lucky Block x3"], "Secret Lucky Block", 3437062543)

		local function update()
			ItemsListPromo3.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.SecretLuckyBlockX3Promo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo3.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.SecretLuckyBlockX3Promo", false)
	end)
	task.spawn(function()
		local ItemsListPromo4 = Shop2.Content.List.ItemsListPromo4

		setup(ItemsListPromo4["Secret Lucky Block x3"], "Secret Lucky Block", 3437062543)
		setup(ItemsListPromo4["Secret Lucky Block x8"], "Secret Lucky Block", 3437979356)

		local function update()
			ItemsListPromo4.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.SecretLuckyBlockX8Promo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo4.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.SecretLuckyBlockX8Promo", false)
	end)
	task.spawn(function()
		local ItemsListPromo5 = Shop2.Content.List.ItemsListPromo5

		setup(ItemsListPromo5["All Lucky Blocks"], "Secret Lucky Block", 3437989614)
		setup(ItemsListPromo5["Secret Lucky Block"])

		local function update()
			ItemsListPromo5.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.AllLuckyBlockPromo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo5.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.AllLuckyBlockPromo", false)
	end)
	task.spawn(function()
		local ItemsListPromo6 = Shop2.Content.List.ItemsListPromo6

		setup(ItemsListPromo6["Secret Lucky Block"])

		local function update()
			ItemsListPromo6.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.LaserGunPromo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo6.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.LaserGunPromo", false)
	end)
	task.spawn(function()
		local ItemsListPromo7 = Shop2.Content.List.ItemsListPromo7

		setup(ItemsListPromo7["Secret Lucky Block"])

		local function update()
			ItemsListPromo7.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.BlackholeSlapPromo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo7.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.BlackholeSlapPromo", false)
	end)
	task.spawn(function()
		local ItemsListPromo8 = Shop2.Content.List.ItemsListPromo8

		setup(ItemsListPromo8["Secret Lucky Block"])

		local function update()
			ItemsListPromo8.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.BanHammerPromo", false)
		end

		ABTests.Loaded:Connect(update)
		ItemsListPromo8.Visible = ABTests.GetAttribute(LocalPlayer, "Shop.BanHammerPromo", false)
	end)
end
local function SetupServerLuck()
	local ServerLuck2 = Shop2.Content.List.ServerLuck
	local u130 = nil

	Synchronizer:WaitAndCall("ServerLuck", function(p14)
		local u367 = nil
		local u368 = nil
		local elapsed = os.clock()

		local function update()
			if os.clock() - elapsed >= 300 then
				elapsed = os.clock()
				u367 = nil
			end

			local v448 = p14:Get("EndTime")

			if v448 then
				local v449 = math.clamp(math.floor(v448 - workspace:GetServerTimeNow()), 0, 1e999)

				if v449 <= 0 then
					v448 = nil
					u367 = nil
				else
					ServerLuck2.Frame.Timer.Text = TimeUtils:A(v449)
				end
			end

			ServerLuck2.Frame.Timer.Visible = v448 ~= nil

			local v450 = p14:Get("Index") or 0
			local n8 = 1

			for v452, v453 in ServerLuck do
				if (not v453.IsEnabled or v453.IsEnabled()) and n8 < v452 then
					n8 = v452
				end
			end

			local v454 = math.min(v450 + 1, n8)

			if v450 ~= u367 or n8 ~= u368 then
				u367 = v450
				u368 = n8

				if u130 then
					u130()
					u130 = nil
				end

				local v455

				if n8 <= v450 then
					v455 = n8 ~= 3 and "<font color=\"#FFFF00\">MAX</font>" or "<rainbow>MAX</rainbow>"
				else
					local v456 = if v450 ~= 0 then ServerLuck[v450].Multiplier else 1
					local Multiplier = ServerLuck[v454].Multiplier
					local Tag = ServerLuck[v454].Tag

					v455 = (`<font color="#FFFFFF">%dx</font> &gt; { not Tag and "<font color=\"#FFFF00\">%dx</font>" or `<{ Tag }>%dx</{ Tag }>` }`):format(v456, Multiplier)
				end

				local v459 = ServerLuck[v454]
				local ProductInfo = Marketplace:GetProductInfo(v459.ProductId, "Product")

				bindLabelToProductPrice(ServerLuck2.Frame.Buy.Price, v459.ProductId)
				ServerLuck2.Frame.LuckVector.Image = v459 and v459.Icon or ProductInfo.Icon
				ServerLuck2.Frame.Pattern.Image = v459 and v459.Icon or ProductInfo.Icon
				CustomRichTextController.apply(ServerLuck2.Frame.Amount, v455)
			end
		end

		p14:OnChanged("Index", update)
		p14:OnChanged("EndTime", update)
		Updates.OnUpdateEnabled:Connect(update)
		Updates.OnUpdateDisabled:Connect(update)
		Timer.Simple(1, update)

		local v371 = AnimatedButton.new(ServerLuck2.Frame.Buy)

		v371:Animate()
		v371.OnActivated:Connect(function()
			local v461 = p14:Get("Index") or 0
			local n9 = 1

			for v463, v464 in ServerLuck do
				if (not v464.IsEnabled or v464.IsEnabled()) and n9 < v463 then
					n9 = v463
				end
			end

			local v465 = math.min(v461 + 1, n9)

			v62:FireServer(ServerLuck[v465].ProductId)
		end)
	end)
end

local u81 = nil

local function ClearGiftProduct(p15)
	local Buy = p15:FindFirstChild("Buy")

	if Buy then
		Buy:SetAttribute("GiftProductId", nil)
	end

	local v133 = p15:GetAttribute("ForceProductId") or (tonumber(p15.Name) or p15:GetAttribute("ProductId"))
	local v134 = v133 and Shop[v133]
	local v135 = Buy and (Buy:FindFirstChild("Price") or Buy:FindFirstChild("Txt"))

	if v135 and v134 then
		if t2[v135] then
			t2[v135]:Destroy()
		end

		bindLabelToProductPrice(v135, v133, v134.Type ~= "Gamepass" and "Product" or "Gamepass")
	end
end
local function UpdateGiftProduct(p16)
	if u81 == nil then
		return
	end

	local v137 = p16:GetAttribute("ForceProductId") or (tonumber(p16.Name) or p16:GetAttribute("ProductId"))
	local v138 = v137 and Shop[v137]

	if not v138 then
		warn(`Failed to find ShopData for product { v137 }`, p16:GetFullName())

		return
	end

	local v139 = if not u81 then v138.GiftProductNoRegional or v138.GiftProduct else v138.GiftProduct

	if not v139 then
		return
	end

	local Buy = p16:FindFirstChild("Buy")
	local v141 = Buy and (Buy:FindFirstChild("Price") or Buy:FindFirstChild("Txt"))

	if not Buy or not v141 then
		return
	end

	Buy:SetAttribute("GiftProductId", v139)

	if t2[v141] then
		t2[v141]:Destroy()
	end

	bindLabelToProductPrice(v141, v139, "Product")
end
local function UpdateGiftProducts()
	u81 = nil

	if not u65 then
		for _, v143 in CollectionService:GetTagged("ProductFrame") do
			ClearGiftProduct(v143)
		end

		return
	end

	if FFlags:Get("DevProductRegionalPricingDisabled", false) then
		return
	end

	u81 = Net:Invoke("ShopService/UseRegionalPriceGifts", u65)

	for _, v145 in CollectionService:GetTagged("ProductFrame") do
		UpdateGiftProduct(v145)
	end
end
local function SetupGiftInventory()
	local ValentinesShopController = require(ReplicatedStorage.Controllers.ValentinesShopController)
	local v147 = Synchronizer:Wait(LocalPlayer)

	local function updateGiftInventory()
		local inv = v147:Get({
			"ValentinesEvent",
			"GiftInventory"
		}) or {}
		GiftInventoryButton.Visible = #inv > 0 and not ValentinesShopController:IsEnabled()
	end

	v147:OnChanged({
		"ValentinesEvent",
		"GiftInventory"
	}, updateGiftInventory)
	v147:OnArrayInserted({
		"ValentinesEvent",
		"GiftInventory"
	}, updateGiftInventory)
	v147:OnArrayRemoved({
		"ValentinesEvent",
		"GiftInventory"
	}, updateGiftInventory)
	Updates.OnUpdateDisabled:Connect(updateGiftInventory)
	Updates.OnUpdateEnabled:Connect(updateGiftInventory)
	task.spawn(updateGiftInventory)

	local v149 = AnimatedButton.new(GiftInventoryButton)

	v149:Animate()
	v149.OnActivated:Connect(function()
		ValentinesShopController:Open("Gifts", "Shop")
	end)
end
local function SetupGiftPlayerSelect()
	local v150 = AnimatedButton.new(GiftButton)

	v150:Animate()
	v150.OnActivated:Connect(function()
		if u65 then
			u65 = nil
			PlayerSelected.Visible = false
			Txt.Text = "Gift Player"
			v66:Fire(false)
			UpdateGiftProducts()

			return
		end

		GiftPlayer.Visible = not GiftPlayer.Visible
	end)
end
local function SetupGiftPlayer()
	local v151 = AnimatedButton.new(Close)

	v151:Animate()
	v151.OnActivated:Connect(function()
		GiftPlayer.Visible = false
		v66:Fire(false)
	end)
end
local function AddPlayerToGiftList(p17)
	if p17 == LocalPlayer then
		return
	end

	local clone = Template:Clone()

	clone.Name = p17.Name
	clone.PlayerName.Text = p17.Name

	local Headshot2 = clone.PlayerImage.Headshot
	local s5 = ""

	if pcall(function()
		s5 = Players:GetUserThumbnailAsync(p17.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	end) then
		Headshot2.Image = s5
	end

	local Gift = clone.Gift
	local v157 = AnimatedButton.new(Gift)

	v157:Animate()
	v157.OnActivated:Connect(function()
		u65 = p17.UserId
		GiftPlayer.Visible = false
		Txt.Text = "Back"
		PlayerSelected.Visible = true
		PlayerName.Text = "@" .. p17.Name
		Headshot.Image = s5
		v66:Fire(true)
		UpdateGiftProducts()
	end)
	clone.Visible = true
	clone.Parent = List
end
local function RemovePlayerFromGiftList(p18)
	local p18Name = List:FindFirstChild(p18.Name)

	if p18Name then
		p18Name:Destroy()
	end
end
local function SetupBlackFridayEvent()
	local u160 = nil

	local function updateBlackfridaySale()
		local ServerTimeNow = workspace:GetServerTimeNow()
		local Instant = FFlags:GetInstant("BlackfridaySale/EndTimestamp", 0)
		local v374 = Instant - ServerTimeNow
		local v375 = Instant >= workspace:GetServerTimeNow()

		Shop2.Txt1.Text = `<font color="rgb(255,255,255)">BLACK FRIDAY SALE: </font>{ TimeUtils:E((math.max(v374, 0))) } left`

		if v375 == u160 then
			return
		end

		u160 = v375

		if v375 == u50 then
			return
		end

		u50 = v375

		for _, v377 in v49 do
			v377.Visible = v375
		end
	end

	FFlags:OnUpdate(updateBlackfridaySale)
	Timer.Simple(1, updateBlackfridaySale)
	task.spawn(updateBlackfridaySale)
end
local function SortShopByProductRank(b2: boolean?, b3: boolean?)
	local v164 = Synchronizer:Get(LocalPlayer)
	local List2 = Shop2.Content.List
	local t5 = {
		ServerLuck = {
			Frame = List2.ServerLuck,
			Title = List2.ServerLuckTitle,
			ProductIds = {
				ServerLuck[1].ProductId,
				ServerLuck[2].ProductId
			}
		},
		StarterPack = {
			Frame = List2.StarterPack,
			Title = List2.Title,
			ProductIds = { 3290334159 }
		},
		LuckyBlocks = {
			Frame = List2.LuckyBlocksList,
			Title = List2.LuckyBlocks,
			ProductIds = {
				3329528158,
				3329527999,
				3329528437
			}
		},
		Gear = {
			Frame = List2.ItemsList,
			Title = List2.Gear,
			ProductIds = {}
		},
		Gamepasses = {
			Frame = List2.GamepassList,
			Title = List2.Gamepass,
			ProductIds = {}
		},
		Money = {
			Frame = List2.MoneyList,
			Title = List2.Money,
			ProductIds = {}
		}
	}

	local function addProductIds(t6: {[any]: any}, p19)
		for _, child in p19:GetChildren() do
			local num = tonumber(child.Name)

			if num then
				table.insert(t6, num)
			end
		end
	end

	addProductIds(t5.Gear.ProductIds, t5.Gear.Frame)
	addProductIds(t5.Gamepasses.ProductIds, t5.Gamepasses.Frame)
	addProductIds(t5.Gamepasses.ProductIds, t5.Gamepasses.Frame.Main)

	for _, child in t5.Money.Frame:GetChildren() do
		if child:IsA("GuiObject") then
			addProductIds(t5.Money.ProductIds, child)
		end
	end

	local t7 = {}

	for _, v172 in t5 do
		for _, v174 in v172.ProductIds do
			local v175 = Shop[v174]

			if not v175 then
				warn(`Invalid productId { v174 } appears in the shop but not found in ShopData`)
			else
				table.insert(t7, {
					Id = v174,
					InfoType = if v175.Type ~= "Gamepass" then Enum.InfoType.Product else Enum.InfoType.GamePass
				})
			end
		end
	end

	local ok, result = pcall(function()
		return MarketplaceService:RankProductsAsync(t7)
	end)

	if not ok or typeof(result) ~= "table" then
		warn(`MarketplaceService:RankProductsAsync() failed: { result }`)

		return
	end

	local t8 = {}

	for v179, v180 in result do
		t8[v180.ProductIdentifier.Id] = v179
	end

	for _, v182 in t5 do
		local n10 = 0
		local n11 = 1e999

		for _, v186 in v182.ProductIds do
			local v187 = t8[v186]

			if v187 then
				n10 += v187
				n11 = math.min(n11, v187)
			end
		end

		if b3 then
			v182.Rank = n11
		else
			v182.Rank = n10 / #v182.ProductIds
		end
	end

	local t9 = {}

	for v189, _ in t5 do
		table.insert(t9, v189)
	end

	local t10 = {
		Gear = 0,
		ServerLuck = 0,
		LuckyBlocks = 0,
		Gamepasses = 0,
		StarterPack = 0,
		Money = 0
	}

	for _, v193 in t9 do
		t10[v193] = (t10[v193] or 0) + FFlags:Get(`ShopSectionRankOverrides/{ v193 }`, 0)

		local v194 = t5[v193]

		v194.Rank = v194.Rank - t10[v193]
	end

	table.sort(t9, function(p20, p21)
		return t5[p20].Rank < t5[p21].Rank
	end)

	local t11 = {}

	for v196, v197 in t9 do
		t11[v197] = v196
	end

	if b2 then
		for v198, v199 in t5 do
			local v200 = 5 + (t11[v198] or 1) * 10

			if v199.Frame then
				local Frame = v199.Frame
				local OriginalOrder = Frame:GetAttribute("OriginalOrder")

				if not OriginalOrder then
					OriginalOrder = Frame.LayoutOrder
					Frame:SetAttribute("OriginalOrder", OriginalOrder)
				end

				Frame.LayoutOrder = v200 or OriginalOrder
			end

			if v199.Title then
				local Title = v199.Title
				local v204 = v200 - 1
				local OriginalOrder = Title:GetAttribute("OriginalOrder")

				if not OriginalOrder then
					OriginalOrder = Title.LayoutOrder
					Title:SetAttribute("OriginalOrder", OriginalOrder)
				end

				Title.LayoutOrder = v204 or OriginalOrder
			end
		end
	end

	for v206, _ in t8 do
		local v208 = Shop[v206]

		if v208 and v164 and if v208.Type ~= "Gamepass" then v208.Type == "Item" and v164:Get(`Items.{ v208.Display }`) else v164:Get(`Gamepass.{ v208.Display }`) then
			t8[v206] = t8[v206] + 1000
		end
	end

	for _, child in t5.Gear.Frame:GetChildren() do
		local num = tonumber(child.Name)

		if num and child:IsA("GuiObject") then
			local v212 = t8[num] or 1
			local OriginalOrder = child:GetAttribute("OriginalOrder")

			if not OriginalOrder then
				OriginalOrder = child.LayoutOrder
				child:SetAttribute("OriginalOrder", OriginalOrder)
			end

			child.LayoutOrder = v212 or OriginalOrder
		end
	end

	local v214 = t8[1227013099] or 1
	local v215 = true

	for _, v217 in t5.Gamepasses.ProductIds do
		if v214 > (t8[v217] or 1) then
			v215 = false

			break
		end
	end

	t5.Gamepasses.Frame.Main.LayoutOrder = not v215 and -1 or 100

	for _, child in t5.Gamepasses.Frame.Main:GetChildren() do
		local num = tonumber(child.Name)

		if num and child:IsA("GuiObject") then
			local v221 = t8[num] or 1
			local OriginalOrder = child:GetAttribute("OriginalOrder")

			if not OriginalOrder then
				OriginalOrder = child.LayoutOrder
				child:SetAttribute("OriginalOrder", OriginalOrder)
			end

			child.LayoutOrder = v221 or OriginalOrder
		end
	end

	local v223 = t5.Money.Frame:FindFirstChild("1")
	local v224 = t5.Money.Frame:FindFirstChild("2")

	if not v224 or not v223 then
		return
	end

	local GuiObject = v224:FindFirstChildWhichIsA("GuiObject")
	local GuiObject2 = v223:FindFirstChildWhichIsA("GuiObject")
	local UIListLayout = v224.UIListLayout
	local UIListLayout2 = v223.UIListLayout

	if not GuiObject2 or not GuiObject then
		return
	end

	local clone = GuiObject2:Clone()
	local clone2 = GuiObject:Clone()

	v224.LayoutOrder = 1
	v223.LayoutOrder = 2
	t5.Money.Frame.UIListLayout.Padding = UDim.new(0.05, 0)
	UIListLayout.Parent = v224
	UIListLayout2.Parent = v223

	local t12 = {}

	for _, v233 in result do
		local str = tostring(v233.ProductIdentifier.Id)

		t12[str] = (t12[str] or 0) + FFlags:Get(`ShopProductRankOverrides/{ str }`, 0)

		local ProductIdentifierId = v233.ProductIdentifier.Id

		t8[ProductIdentifierId] = t8[ProductIdentifierId] - t12[str]
	end

	local v236 = t5.Money.ProductIds[1]
	local t13 = {}
	local t14 = {}

	for _, v240 in t5.Money.ProductIds do
		if (t8[v240] or 1) < (t8[v236] or 1) then
			v236 = v240
		end

		table.insert(t13, v240)

		local v241 = Shop[v240]

		if not v241 then
			return
		end

		t14[v240] = v241.Value
	end

	local u242 = v236 ~= t13[#t13] or false

	table.sort(t13, function(p22, p23)
		if u242 then
			return t14[p22] < t14[p23]
		end

		return t14[p22] > t14[p23]
	end)

	local t15 = { v236 }

	for _, v245 in t13 do
		if v245 ~= v236 then
			table.insert(t15, v245)
		end
	end

	for v246, v247 in t15 do
		local v248 = v223:FindFirstChild((tostring(v247))) or v224:FindFirstChild((tostring(v247)))

		if v248 then
			v248.LayoutOrder = v246

			local v249 = v246 <= 2
			local v250 = if not v249 then clone else clone2

			v248.Size = v250.Size
			v248.Image = v250.Image

			for _, child in v248:GetChildren() do
				local childName = v250:FindFirstChild(child.Name)

				if child:IsA("GuiObject") and childName then
					child.Size = childName.Size
					child.Position = childName.Position
					child.AnchorPoint = childName.AnchorPoint
				end
			end

			v248.Parent = if not v249 then v223 else v224
		end
	end

	clone:Destroy()
	clone2:Destroy()
end
local function SetupMerchShop()
	local ClientAPI = require(ReplicatedStorage.Controllers.StockEventController.ClientAPI)
	local u255 = false
	local u256 = false
	local v257 = ClientAPI.create("Boppin Bunny")
	local List3 = Shop2.Content.List
	local Plush = List3.Plush
	local t16 = {
		Plush,
		List3.Codes,
		List3.Redeem
	}
	local CurrentItem = MerchShopData.CurrentItem
	local PlushSpacer = List3:FindFirstChild("PlushSpacer")

	Animals:AttachOnViewportWithOptimizations("Boppin Bunny", Plush.Frame.Item.ViewportFrame)
	Gradients.apply(Plush.Frame.Item.UIStroke, "Zebra")
	Gradients.apply(Plush.Frame.Item.Title, "Zebra")

	local function updateMerchVisibility()
		local v387 = Policy.getPolicy(Players.LocalPlayer)
		local v388 = true

		if not v387 or not v387.IsEligibleToPurchaseCommerceProduct then
			v388 = false
		end

		local v389 = MerchShopData.IsEnabled() and not u255

		if not v388 and FFlags:GetInstant("MerchShopHideIfPolicyDisabledV2", false) then
			v389 = false
		end

		local Instant = FFlags:GetInstant("MerchShopHideAllFrontend", false)
		local Instant5 = FFlags:GetInstant("MerchShopOnlyShowRedeemCode", false)

		for _, v393 in t16 do
			if v393 == Plush and Instant5 and v389 or Instant then
				v393.Visible = false
			else
				v393.Visible = v389
			end
		end

		Plush.Frame.Buy.Visible = v388
		Plush.Frame.CodeRedeem.Visible = not v388
		Plush.Frame.WebsiteLink.Visible = not v388

		if PlushSpacer then
			PlushSpacer.Visible = Plush.Visible
		end
	end

	updateMerchVisibility()
	FFlags:OnUpdate(updateMerchVisibility)
	Updates.OnUpdateEnabled:Connect(updateMerchVisibility)
	Updates.OnUpdateDisabled:Connect(updateMerchVisibility)

	if not MerchShopData.CurrentItem then
		u255 = true
		updateMerchVisibility()

		return
	end

	local function updateStock()
		local Stock = v257:GetStock("Boppin Bunny")

		if typeof(Stock) == "number" then
			u256 = Stock <= 0
			Plush.Frame.Stock.Text = if not (Stock <= 0) then `{ NumberUtils:Comma(Stock) } LEFT` else "SOLD OUT"
		else
			Plush.Frame.Stock.Text = "??? LEFT"
		end

		if u256 then
			Spr.target(Plush.Frame.Buy, 1, 5, {
				BackgroundColor3 = Color3.fromRGB(122, 122, 122)
			})

			return
		end

		Spr.target(Plush.Frame.Buy, 1, 5, {
			BackgroundColor3 = Color3.fromRGB(81, 158, 86)
		})
	end

	v257:OnStockChange("Boppin Bunny", updateStock)
	task.spawn(updateStock)
	Plush.Frame.Buy.Price.Text = "???"

	local ok, result = pcall(function()
		return CommerceService:GetCommerceProductInfoAsync(MerchShopData.CurrentItem.CommerceProductId)
	end)

	if ServerData.IsDevGame() and not ok then
		result = {
			Item = MerchShopData.TestProductInfo
		}
		updateMerchVisibility()
	elseif not ok or typeof(result) ~= "table" or typeof(result.Item) ~= "table" then
		u255 = true
		updateMerchVisibility()

		return
	end

	Plush.Frame.Buy.Price.Text = result and (not not result.Item and result.Item.DisplayPrice) or "$29.99"
	Plush.Frame.Buy.Activated:Connect(function()
		if u256 then
			return
		end

		CommerceService:PromptCommerceProductPurchase(LocalPlayer, CurrentItem.CommerceProductId)
	end)

	local function initTextbox(p24)
		local u396 = false

		local function submitCode()
			if u396 or not p24.Active then
				return
			end

			local p24Text = p24.Text

			if #p24Text ~= MerchShopData.CodeLength then
				NotificationController:Error("Invalid code")

				return
			end

			u396 = true
			p24.Text = ""
			p24.PlaceholderText = "Redeeming..."
			p24.Selectable = false
			p24.Active = false
			p24:ReleaseFocus()

			local ok2, result2, v469 = pcall(function()
				return Net:RemoteFunction("RequestRedemption"):InvokeServer(p24Text)
			end)

			if not ok2 then
				NotificationController:Error("Unexpected error")
				warn(result2)
			elseif not result2 then
				NotificationController:Error(typeof(v469) ~= "string" and "Request failed" or v469)
			elseif ok2 and result2 then
				NotificationController:Success(typeof(v469) ~= "string" and "Code redeemed!" or v469)
			end

			p24.Text = ""
			p24.PlaceholderText = "Code Here..."
			task.wait(0.5)
			p24.Selectable = true
			p24.Active = true
			u396 = false
		end

		p24.FocusLost:Connect(function(enterPressed: boolean)
			if not enterPressed then
				return
			end

			submitCode()
		end)
		p24:GetPropertyChangedSignal("Text"):Connect(function()
			local p24Text = p24.Text
			local v472 = string.sub(string.upper(string.gsub(p24Text, "[^%w]", "")), 1, MerchShopData.CodeLength)

			if v472 ~= p24Text then
				p24.Text = v472
			end

			if #v472 == MerchShopData.CodeLength then
				submitCode()
			end
		end)
	end

	initTextbox(Plush.Frame.CodeRedeem.TextBox)
	initTextbox(List3.Codes.CodeRedeem.TextBox)
end

function t1.Start(_)
	u68 = InterfaceController:Register("Shop", Shop2, "TopQuint")
	u68:AttachCloseButton(Shop2.Header.Close)
	u68:Close()
	Synchronizer:WaitAndCall(LocalPlayer, function(p26)
		local function isWaveriderActive()
			return Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026")
		end
		local function isSummerBaseActive()
			return Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026")
		end

		Observers.observeTag("CashProduct", function(p27)
			local num = tonumber(p27.Name)
			local v475 = Shop[num]

			if not v475 then
				return
			end

			p27:AddTag("ProductFrame")

			local Buy = p27:WaitForChild("Buy", 5)
			local Icon = p27:WaitForChild("Icon", 5)
			local Amount = p27:WaitForChild("Amount", 5)

			if v475.Icon then
				Icon.ScaleType = Enum.ScaleType.Fit
				Icon.Image = v475.Icon
			end

			local function updateAmountLabel()
				if Amount then
					local v575 = v475.Value or 0
					local v576 = p26:Get("Rebirth") or 0

					if v576 > 0 then
						v575 *= if not (v576 <= 1) then v576 else 1.5
					end

					Amount.Text = `${ NumberUtils:Comma(v575) }`
				end
			end
			local function updateInfo()
				local ProductInfo = Marketplace:GetProductInfo(num, "Product")

				if Buy then
					bindLabelToProductPrice(Buy.Txt, num)
				end

				if Icon and ProductInfo.Icon then
					Icon.ScaleType = Enum.ScaleType.Fit

					if not v475.Icon then
						Icon.Image = ProductInfo.Icon
					end
				end
			end

			local ProductInfo = Marketplace:GetProductInfo(num, "Product")

			if Buy then
				bindLabelToProductPrice(Buy.Txt, num)
			end

			if Icon and ProductInfo.Icon then
				Icon.ScaleType = Enum.ScaleType.Fit

				if not v475.Icon then
					Icon.Image = ProductInfo.Icon
				end
			end

			p26:OnChanged("Rebirth", updateAmountLabel, true)

			local v482 = AnimatedButton.new(Buy)

			v482:Animate()
			v482.OnActivated:Connect(function()
				local GiftProductId = Buy:GetAttribute("GiftProductId")

				v62:FireServer(GiftProductId or num, u65)
			end)
			v64.Tick:Connect(function()
				local ProductInfo2 = Marketplace:GetProductInfo(num, "Product")

				if Buy then
					bindLabelToProductPrice(Buy.Txt, num)
				end

				if Icon and ProductInfo2.Icon then
					Icon.ScaleType = Enum.ScaleType.Fit

					if not v475.Icon then
						Icon.Image = ProductInfo2.Icon
					end
				end
			end)
		end)
		Observers.observeTag("ItemProduct", function(p28)
			local num = tonumber(p28.Name)
			local v485 = Shop[num]

			if not v485 then
				return
			end

			p28:AddTag("ProductFrame")

			local Buy = p28:WaitForChild("Buy", 5)
			local v487 = Buy and Buy:WaitForChild("Price", 5)
			local Icon = p28:FindFirstChild("Icon", true)
			local u489 = false
			local u490 = false

			if v485.Icon and Icon then
				Icon.ScaleType = Enum.ScaleType.Fit
				Icon.Image = v485.Icon
			end

			local function updateVisibility()
				local v580 = u65 and Players:GetPlayerByUserId(u65) or LocalPlayer

				if num == 3290152513 then
					local v581 = p28.Parent:FindFirstChild((tostring(3603521272)))

					if not v581 then
						return
					end

					local v582 = v580:GetAttribute("HasFlyingCarpet") and (Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026"))

					p28.Visible = not v582

					if v581 then
						v581.LayoutOrder = p28.LayoutOrder
						v581.Visible = v582
					end
				end
			end
			local function updateOwned()
				updateVisibility()
				u489 = true

				local v583 = v487

				if t2[v583] then
					t2[v583]:Destroy()
				end

				v487.Text = "Owned"
			end
			local function updateInfo()
				updateVisibility()

				local ProductInfo = Marketplace:GetProductInfo(num, "Product")

				if v487 and (u489 == false or u490 == true) then
					bindLabelToProductPrice(v487, num)
				end

				if ProductInfo.Icon and Icon then
					Icon.ScaleType = Enum.ScaleType.Fit

					if not v485.Icon then
						Icon.Image = ProductInfo.Icon
					end
				end
			end

			local u494 = nil

			v66:Connect(function(p29)
				if u494 then
					u494:Disconnect()
					u494 = nil
				end

				local v586 = u65 and (p29 and Players:GetPlayerByUserId(u65))

				if v586 and num == 3290152513 then
					u494 = v586:GetAttributeChangedSignal("HasFlyingCarpet"):Connect(updateVisibility)
				end

				u490 = p29

				if not p29 and u489 then
					updateVisibility()
					u489 = true

					local v587 = v487

					if t2[v587] then
						t2[v587]:Destroy()
					end

					v487.Text = "Owned"
				else
					updateInfo()
				end

				updateVisibility()
			end)
			v64.Tick:Connect(function()
				updateVisibility()

				if u489 == false then
					updateInfo()
				end
			end)
			p26:OnDictionaryInserted("Items", function(_, p31)
				updateVisibility()

				if p31 == v485.Display and u490 == false then
					updateVisibility()
					u489 = true

					local v590 = v487

					if t2[v590] then
						t2[v590]:Destroy()
					end

					v487.Text = "Owned"
				end
			end)

			if p26:Get(`Items.{ v485.Display }`) == true then
				updateVisibility()
				u489 = true

				if t2[v487] then
					t2[v487]:Destroy()
				end

				v487.Text = "Owned"
			end

			Updates.OnUpdateEnabled:Connect(updateVisibility)
			Updates.OnUpdateDisabled:Connect(updateVisibility)
			updateInfo()
			updateVisibility()

			local v495 = AnimatedButton.new(Buy)

			v495:Animate()
			v495.OnActivated:Connect(function()
				local GiftProductId = Buy:GetAttribute("GiftProductId")

				v62:FireServer(GiftProductId or num, u65)
			end)
		end)
		Observers.observeTag("GamepassProduct", function(p32)
			local num = tonumber(p32.Name)
			local v498 = Shop[num]

			if not v498 then
				return
			end

			p32:AddTag("ProductFrame")

			local Buy = p32:WaitForChild("Buy", 5)
			local v500 = Buy and Buy:WaitForChild("Price", 5)

			p32:WaitForChild("Icon", 5)

			local u501 = false
			local u502 = false

			local function updateOwned()
				u501 = true

				local v592 = v500

				if t2[v592] then
					t2[v592]:Destroy()
				end

				v500.Text = "Owned"
			end
			local function updateInfo()
				if v500 and (u501 == false or u502) then
					if u502 then
						bindLabelToProductPrice(v500, p32:GetAttribute("ProductId"), "Product")

						return
					end

					bindLabelToProductPrice(v500, num, "Gamepass")
				end
			end

			v66:Connect(function(p33)
				u502 = p33

				if not p33 and u501 then
					u501 = true

					local v594 = v500

					if t2[v594] then
						t2[v594]:Destroy()
					end

					v500.Text = "Owned"

					return
				end

				if v500 and (u501 == false or u502) then
					if u502 then
						bindLabelToProductPrice(v500, p32:GetAttribute("ProductId"), "Product")

						return
					end

					bindLabelToProductPrice(v500, num, "Gamepass")
				end
			end)
			v64.Tick:Connect(function()
				if u501 == false and v500 and (u501 == false or u502) then
					if u502 then
						bindLabelToProductPrice(v500, p32:GetAttribute("ProductId"), "Product")

						return
					end

					bindLabelToProductPrice(v500, num, "Gamepass")
				end
			end)
			p26:OnDictionaryInserted("Gamepass", function(_, p35)
				if p35 == v498.Display then
					u501 = true

					local v597 = v500

					if t2[v597] then
						t2[v597]:Destroy()
					end

					v500.Text = "Owned"
				end
			end)

			if p26:Get(`Gamepass.{ v498.Display }`) == true then
				u501 = true

				if t2[v500] then
					t2[v500]:Destroy()
				end

				v500.Text = "Owned"
			end

			if v500 and (u501 == false or u502) then
				if u502 then
					bindLabelToProductPrice(v500, p32:GetAttribute("ProductId"), "Product")
				else
					bindLabelToProductPrice(v500, num, "Gamepass")
				end
			end

			local v505 = AnimatedButton.new(Buy)

			v505:Animate()
			v505.OnActivated:Connect(function()
				if u65 then
					local v598 = Buy:GetAttribute("GiftProductId") or p32:GetAttribute("ProductId")

					v62:FireServer(v598 or num, u65)

					return
				end

				v62:FireServer(num, u65)
			end)
		end)
		Observers.observeTag("StarterPack", function(p36)
			local v507 = Trove.new()
			local v508 = Shop[3290334159]

			if not v508 then
				return v507:WrapClean()
			end

			p36:SetAttribute("ProductId", 3290334159)
			p36:AddTag("ProductFrame")

			local Buy = p36:WaitForChild("Buy", 5)
			local v510 = Buy and Buy:WaitForChild("Price", 5)
			local u511 = false
			local u512 = false
			local v513 = p36.Parent and p36.Parent:FindFirstChild("Title")

			local function updateOwned()
				u511 = true

				local v599 = v510

				if t2[v599] then
					t2[v599]:Destroy()
				end

				v510.Text = "Owned"
			end
			local function ToggleVisibility()
				for _, v601 in v508.Rewards.Items do
					if p26:Get("Items." .. v601) == true and u512 == false then
						p36.Visible = false

						if v513 then
							v513.Visible = false
						end

						return
					end
				end

				p36.Visible = true

				if v513 then
					v513.Visible = true
				end
			end
			local function updateInfo()
				if v510 and (u511 == false or u512 == true) then
					bindLabelToProductPrice(v510, 3290334159)
				end
			end

			v507:Add(v67:Connect(ToggleVisibility))
			v507:Add(v66:Connect(function(p37)
				u512 = p37

				if not p37 and u511 then
					u511 = true

					local v603 = v510

					if t2[v603] then
						t2[v603]:Destroy()
					end

					v510.Text = "Owned"
				elseif v510 and (u511 == false or u512 == true) then
					bindLabelToProductPrice(v510, 3290334159)
				end

				ToggleVisibility()
			end))
			v507:Add(v64.Tick:Connect(function()
				if u511 == false and v510 and (u511 == false or u512 == true) then
					bindLabelToProductPrice(v510, 3290334159)
				end
			end))
			ToggleVisibility()
			v507:Add(p26:OnDictionaryInserted("Items", ToggleVisibility))

			if v510 and (u511 == false or u512 == true) then
				bindLabelToProductPrice(v510, 3290334159)
			end

			local v517 = AnimatedButton.new(Buy)

			v507:Add(v517)
			v517:Animate()
			v517.OnActivated:Connect(function()
				local GiftProductId = Buy:GetAttribute("GiftProductId")

				v62:FireServer(GiftProductId or 3290334159, u65)
			end)

			return v507:WrapClean()
		end)
		Observers.observeTag("WaveriderFrame", function(p38)
			local v519 = Trove.new()

			p38.Visible = false

			local v520 = Policy.getPolicy(Players.LocalPlayer)
			local v521 = p38.Parent and p38.Parent:FindFirstChild("WaveriderSpacer")
			local Buy = p38.ContentsFrame:WaitForChild("Buy", 5)
			local v523 = Buy and Buy:WaitForChild("Price", 5)
			local u524 = false
			local u525 = false

			local function getProductId()
				if not v520 or v520.ArePaidRandomItemsRestricted then
					return 3603521272
				end

				return 3603521291
			end

			p38.ContentsFrame.LuckyBlock.Visible = (not not v520 and not v520.ArePaidRandomItemsRestricted and 3603521291 or 3603521272) == 3603521291
			p38.Visible = true
			p38:SetAttribute("ProductId", not not v520 and not v520.ArePaidRandomItemsRestricted and 3603521291 or 3603521272)
			p38:AddTag("ProductFrame")

			local function updateOwned()
				u524 = true

				local v605 = v523

				if t2[v605] then
					t2[v605]:Destroy()
				end

				v523.Text = "Owned"
			end

			local u528 = false

			local function ToggleVisibility()
				local v606 = Shop[not not v520 and not v520.ArePaidRandomItemsRestricted and 3603521291 or 3603521272]

				if not v606 then
					p38.Visible = false

					if v521 then
						v521.Visible = false
					end

					return
				end

				if v606.Type == "Item" then
					if p26:Get("Items." .. v606.Display) == true and u525 == false then
						p38.Visible = false

						if v521 then
							v521.Visible = false
						end

						return
					end
				else
					for _, v608 in v606.Rewards.Items do
						if p26:Get("Items." .. v608) == true and u525 == false then
							p38.Visible = false

							if v521 then
								v521.Visible = false
							end

							return
						end
					end
				end

				local v609 = Updates.Methods.IsEnabled("Update-06/13/2026") and not Updates.Methods.IsEnabled("Update-07/04/2026")

				p38.Visible = v609

				if v521 then
					v521.Visible = v609
				end
			end
			local function updateInfo()
				local v610 = not not v520 and not v520.ArePaidRandomItemsRestricted and 3603521291 or 3603521272

				p38:SetAttribute("ProductId", v610)
				task.spawn(UpdateGiftProduct, p38)
				p38.ContentsFrame.LuckyBlock.Visible = v610 == 3603521291

				if v523 and (u524 == false or u525 == true) then
					bindLabelToProductPrice(v523, v610)
				end
			end

			v519:Add(v66:Connect(function(p39)
				u525 = p39

				if not p39 and u524 then
					u524 = true

					local v612 = v523

					if t2[v612] then
						t2[v612]:Destroy()
					end

					v523.Text = "Owned"
				else
					updateInfo()
				end

				ToggleVisibility()
			end))
			v519:Add(v64.Tick:Connect(function()
				if u524 == false then
					updateInfo()
				end
			end))
			v519:Add(FFlags:OnUpdate(function()
				ToggleVisibility()
			end))

			local Timer3 = p38.ContentsFrame:WaitForChild("Timer", 5)

			v519:Add(Timer.Simple(1, function()
				local v613 = Updates.Methods.GetUpdateTime("Update-07/04/2026") or 0
				local ServerTimeNow = workspace:GetServerTimeNow()

				if Timer3 then
					Timer3.Text = `{ TimeUtils:E(v613 - ServerTimeNow) } left`
				end

				if v613 <= ServerTimeNow then
					if not u528 then
						u528 = true
						ToggleVisibility()

						return
					end
				elseif u528 then
					u528 = false
					ToggleVisibility()
				end
			end))
			v519:Add(Updates.OnUpdateEnabled:Connect(ToggleVisibility))
			v519:Add(Updates.OnUpdateDisabled:Connect(ToggleVisibility))
			v519:Add(p26:OnDictionaryInserted("Items", ToggleVisibility))
			ToggleVisibility()
			updateInfo()

			local v532 = AnimatedButton.new(Buy)

			v519:Add(v532)
			v532:Animate()
			v532.OnActivated:Connect(function()
				local GiftProductId = Buy:GetAttribute("GiftProductId")

				v62:FireServer(GiftProductId or (not not v520 and not v520.ArePaidRandomItemsRestricted and 3603521291 or 3603521272), u65)
			end)

			return v519:WrapClean()
		end)
		Observers.observeTag("RedOctoBase", function(p40)
			local v534 = Trove.new()

			p40.Visible = false

			local v535 = Policy.getPolicy(Players.LocalPlayer)
			local v536 = p40.Parent and p40.Parent:FindFirstChild("OctoBaseSpacer")
			local Buy = p40:WaitForChild("Buy", 5)
			local v538 = Buy and Buy:WaitForChild("Price", 5)
			local u539 = false
			local u540 = false

			local function getProductId()
				if not v535 or v535.ArePaidRandomItemsRestricted then
					return 3603521320
				end

				return 3603521290
			end

			p40.LuckyBlock.Visible = (not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320) == 3603521290
			p40.Visible = true
			p40:SetAttribute("ProductId", not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320)
			p40:AddTag("ProductFrame")

			local function ToggleVisibility()
				if p26:Get("PurchasedBaseSkins.Octo") == true and u539 == false then
					p40.Visible = false

					if v535 and v535.ArePaidRandomItemsRestricted then
						local SummerTitle = p40.Parent:FindFirstChild("SummerTitle")

						if SummerTitle then
							SummerTitle.Visible = false
						end
					end

					if v536 then
						v536.Visible = false
					end

					return
				end

				local v617 = isSummerBaseActive()

				p40.Visible = v617

				if v536 then
					v536.Visible = v617
				end

				if v535 and v535.ArePaidRandomItemsRestricted then
					local SummerTitle = p40.Parent:FindFirstChild("SummerTitle")

					if SummerTitle then
						SummerTitle.Visible = v617
					end
				end
			end
			local function updateInfo()
				local v619 = not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320

				p40:SetAttribute("ProductId", v619)
				task.spawn(UpdateGiftProduct, p40)
				p40.LuckyBlock.Visible = v619 == 3603521290

				if v538 then
					bindLabelToProductPrice(v538, v619)
				end
			end

			v534:Add(v66:Connect(function(p41)
				u539 = p41

				local v621 = not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320

				p40:SetAttribute("ProductId", v621)
				task.spawn(UpdateGiftProduct, p40)
				p40.LuckyBlock.Visible = v621 == 3603521290

				if v538 then
					bindLabelToProductPrice(v538, v621)
				end

				ToggleVisibility()
			end))
			v534:Add(v64.Tick:Connect(function()
				local v622 = not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320

				p40:SetAttribute("ProductId", v622)
				task.spawn(UpdateGiftProduct, p40)
				p40.LuckyBlock.Visible = v622 == 3603521290

				if v538 then
					bindLabelToProductPrice(v538, v622)
				end
			end))
			v534:Add(FFlags:OnUpdate(function()
				ToggleVisibility()
			end))
			v534:Add(Updates.OnUpdateEnabled:Connect(ToggleVisibility))
			v534:Add(Updates.OnUpdateDisabled:Connect(ToggleVisibility))

			local Timer4 = p40:WaitForChild("Timer", 5)

			v534:Add(Timer.Simple(1, function()
				local v623 = Updates.Methods.GetUpdateTime("Update-07/04/2026") or 0
				local ServerTimeNow = workspace:GetServerTimeNow()

				if Timer4 then
					Timer4.Text = `{ TimeUtils:E(v623 - ServerTimeNow) } left`
				end

				if v623 <= ServerTimeNow then
					if not u540 then
						u540 = true
						ToggleVisibility()

						return
					end
				elseif u540 then
					u540 = false
					ToggleVisibility()
				end
			end))
			ToggleVisibility()
			v534:Add(p26:OnDictionaryInserted("UnlockedBaseSkins", ToggleVisibility))
			v534:Add(p26:OnDictionaryInserted("BaseSkinInventory", ToggleVisibility))
			v534:Add(p26:OnDictionaryInserted("PurchasedBaseSkins", ToggleVisibility))

			local v545 = not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320

			p40:SetAttribute("ProductId", v545)
			task.spawn(UpdateGiftProduct, p40)
			p40.LuckyBlock.Visible = v545 == 3603521290

			if v538 then
				bindLabelToProductPrice(v538, v545)
			end

			local v546 = AnimatedButton.new(Buy)

			v534:Add(v546)
			v546:Animate()
			v546.OnActivated:Connect(function()
				local GiftProductId = Buy:GetAttribute("GiftProductId")

				v62:FireServer(GiftProductId or (not not v535 and not v535.ArePaidRandomItemsRestricted and 3603521290 or 3603521320), u65)
			end)

			return v534:WrapClean()
		end)
		Observers.observeTag("RainbowText", function(p42)
			return Gradients.apply(p42, "Rainbow")
		end)
		Observers.observeTag("ZebraText", function(p43)
			return Gradients.apply(p43, "Zebra")
		end)
		v64:Start()

		local function preloadProductIds(t17: {[any]: any})
			for _, v551 in t17 do
				task.defer(Marketplace.GetProductInfo, Marketplace, v551, "Product")
			end
		end

		preloadProductIds({
			ServerLuck[3].ProductId,
			ServerLuck[2].ProductId
		})
	end)

	local v269 = AnimatedButton.new(GiftButton)

	v269:Animate()
	v269.OnActivated:Connect(function()
		if u65 then
			u65 = nil
			PlayerSelected.Visible = false
			Txt.Text = "Gift Player"
			v66:Fire(false)
			UpdateGiftProducts()

			return
		end

		GiftPlayer.Visible = not GiftPlayer.Visible
	end)
	task.spawn(SetupGiftInventory)

	local v270 = AnimatedButton.new(Close)

	v270:Animate()
	v270.OnActivated:Connect(function()
		GiftPlayer.Visible = false
		v66:Fire(false)
	end)

	SetupServerLuck()
	SetupLuckyBlocks()
	SetupBlackFridayEvent()
	task.spawn(SetupMerchShop)

	for _, player in Players:GetPlayers() do
		AddPlayerToGiftList(player)
	end

	Players.PlayerAdded:Connect(function(player)
		AddPlayerToGiftList(player)
	end)
	Players.PlayerRemoving:Connect(function(player)
		local playerName = List:FindFirstChild(player.Name)

		if playerName then
			playerName:Destroy()
		end
	end)

	for _, child in Shop2.Header.Main:GetChildren() do
		if child:IsA("ImageButton") then
			local childName = Shop2.Content.List:FindFirstChild(child.Name)

			if childName then
				local v280 = AnimatedButton.new(child)

				v280:Animate()
				v280.OnActivated:Connect(function()
					local List4 = Shop2.Content.List
					local v418 = childName.AbsolutePosition.Y - List4.AbsolutePosition.Y + List4.CanvasPosition.Y

					List4.CanvasPosition = Vector2.new(List4.CanvasPosition.X, v418)
				end)
			end
		end
	end

	task.spawn(function()
		local function update()
			local DefaultsSize = u68.Defaults.Size
			local v571 = ABTests.GetAttribute(LocalPlayer, "Shop.Scale", 1)
			local uDim2 = UDim2.new(DefaultsSize.X.Scale * v571, DefaultsSize.X.Offset, DefaultsSize.Y.Scale * v571, DefaultsSize.Y.Offset)

			if uDim2.X.Scale ~= u68.Defaults.Size.X.Scale or uDim2.Y.Scale ~= u68.Defaults.Size.Y.Scale then
				Shop2.Size = uDim2
				u68.Defaults.Size = uDim2
			end

			local v573 = ABTests.GetAttribute(LocalPlayer, "Shop.HideLuckyBlocksTitle", false)

			Shop2.Content.List.LuckyBlocks.Visible = not v573

			local v574 = ABTests.GetAttribute(LocalPlayer, "Shop.PromoTitle", nil)

			if v574 then
				Shop2.Content.List.PromoTitle.Text = v574
				Shop2.Content.List.PromoTitle.Visible = true

				return
			end

			Shop2.Content.List.PromoTitle.Visible = false
		end

		ABTests.Loaded:Connect(update)
		update()
		Synchronizer:WaitAndCall(LocalPlayer, function()
			update()
		end)
	end)
	u68.OnClose:Connect(function()
		t1:RemoveGiftingTarget()
	end)

	local u281 = false

	local function RunExperiments(p45)
		if u281 then
			return
		end

		u281 = true

		local v421 = p45:Get({
			"Configs",
			"ShopProductRankSorting"
		}) or v7
		local v422 = p45:Get({
			"Configs",
			"ShopSectionRankSorting"
		}) or v8
		local v423 = p45:Get({
			"Configs",
			"ShopSectionTopProductRankSorting"
		}) or v9

		if v421 or v422 or v423 then
			SortShopByProductRank(v422 == true or v423 == true, v423 == true)
		end
	end

	Synchronizer:WaitAndCall(LocalPlayer, function(_)
		local v425 = Replion.Client:WaitReplion(`{ LocalPlayer.Name }_Configs`, 60)

		if not v425 then
			return
		end

		RunExperiments(v425)
	end)
	Replion.Client:OnReplionAddedWithTag("PlayerConfigs", function(p47)
		Synchronizer:Wait(LocalPlayer)
		RunExperiments(p47)
	end)
	u68.OnOpen:Connect(function()
		v63:FireServer()
	end)
end
function t1.OpenGiftingScreen(_)
	GiftPlayer.Visible = true
end
function t1.CloseGiftingScreen(_)
	GiftPlayer.Visible = false
end
function t1.RemoveGiftingTarget(_)
	if u65 then
		u65 = nil
		PlayerSelected.Visible = false
		Txt.Text = "Gift Player"
		v66:Fire(false)
	end
end
function t1.GetGiftingTarget(_)
	return u65
end
function t1.BindLabelToProductPrice(_: {[any]: any}, p52, n14: number, s6: string?, n15: number?)
	return (bindLabelToProductPrice(p52, n14, s6, n15))
end
function t1.UnbindLabelProductPrice(_: {[any]: any}, p53)
	if t2[p53] then
		t2[p53]:Destroy()
	end
end

return t1