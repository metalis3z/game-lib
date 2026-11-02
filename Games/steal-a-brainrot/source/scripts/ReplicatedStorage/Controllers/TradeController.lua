-- Script Path: ReplicatedStorage.Controllers.TradeController
-- Version corrigée : clés uniques par IndexOnPlot

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local UsersAPI = require(ReplicatedStorage.Shared.UsersAPI)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CornerNotificationController = require(ReplicatedStorage.Controllers.CornerNotificationController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Bases = require(ReplicatedStorage.Datas.Bases)
local Traits = require(ReplicatedStorage.Datas.Traits)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local Animals_2 = require(ReplicatedStorage.Shared.Animals)
local Friends = require(ReplicatedStorage.Shared.Friends)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Prompt = PlayerGui:WaitForChild("TradePrompts").Prompt
local TradePlayerList = PlayerGui:WaitForChild("TradePlayerList").TradePlayerList
local TradeLiveTrade = PlayerGui:WaitForChild("TradeLiveTrade").TradeLiveTrade

-- Remotes (sans GUID)
local CreateInvite   = Net:RemoteEvent("TradeService/CreateInvite")
local DeclineInvite  = Net:RemoteEvent("TradeService/DeclineInvite")
local AcceptInvite   = Net:RemoteFunction("TradeService/AcceptInvite")
local SearchUser     = Net:RemoteFunction("TradeService/SearchUser")
local InviteRemote   = Net:RemoteFunction("TradeService/Invite")
local CancelTrade    = Net:RemoteEvent("TradeService/CancelTrade")
local AddBrainrot    = Net:RemoteFunction("TradeService/AddBrainrot")
local RemoveBrainrot = Net:RemoteFunction("TradeService/RemoveBrainrot")
local TradeCompleted = Net:RemoteEvent("TradeService/TradeCompleted")
local AcceptRemote   = Net:RemoteEvent("TradeService/Accept")
local ReadyRemote    = Net:RemoteEvent("TradeService/Ready")

local t = {}

function t._createPlayerList()
	local frame = InterfaceController:Register("TradePlayerList", TradePlayerList, "TopQuint")
	frame:AttachCloseButton(TradePlayerList.Header.Close)
	frame:Close()
	local SearchBox = TradePlayerList.bg.SearchFrame.SearchBox
	local currentTab = nil
	local updateCoroutine = nil
	local Template = TradePlayerList.Other.List.UIListLayout.Template
	local Template_2 = TradePlayerList.Global.List.UIListLayout.Template

	local function updateUserCard(parent, data, order, existing)
		local name = ("%s_%s"):format(data.username, data.userId)
		local card = existing or parent:FindFirstChild(name)
		if card then
			card.Fill.Status2.Text = data.inGame and "Online" or (data.isFriend and "Away" or "Offline")
			card.Fill.Status2.TextColor3 = data.inGame and Color3.fromRGB(86,211,74) or (data.isFriend and Color3.fromRGB(239,225,69) or Color3.fromRGB(211,38,38))
			card.Fill.PlayerImage.Status.BackgroundColor3 = data.inGame and Color3.fromRGB(86,211,74) or (data.isFriend and Color3.fromRGB(239,225,69) or Color3.fromRGB(211,38,38))
			local sendBtn = card.Fill.Send
			sendBtn.BackgroundColor3 = (data.inGame and data.canInvite) and Color3.fromRGB(81,158,86) or (data.isFriend and Color3.fromRGB(81,158,86) or Color3.fromRGB(112,112,112))
			card.LayoutOrder = data.inGame and order or order + 300
		end
	end

	local function createUserCard(parent, data, order)
		local name = ("%s_%s"):format(data.username, data.userId)
		local card = (parent == TradePlayerList.Other.List and Template:Clone() or Template_2:Clone())
		card.Name = name
		card.Fill.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100"):format(data.userId)
		card.Fill.Username.Text = ("@%s"):format(data.username)
		updateUserCard(parent, data, order, card)
		card.Visible = true
		card.Parent = parent
		local cooldown = false
		card.Fill.Send.Activated:Connect(function()
			if data.canInvite and not cooldown then
				SoundController:PlaySound("Sounds.Sfx.Activated")
				if data.inGame then
					cooldown = true
					xpcall(function()
						local success, err = InviteRemote:InvokeServer(data.userId)
						if not success and type(err) == "string" then
							NotificationController:Error(err)
						end
						card.Fill.Send.Txt.Text = success and "SENT!" or "FAILED"
						task.wait(5)
						card.Fill.Send.Txt.Text = "SEND"
					end, warn)
					cooldown = false
				elseif data.isFriend then
					local canInvite, _ = pcall(function()
						return SocialService:CanSendGameInviteAsync(LocalPlayer)
					end)
					if canInvite then
						local opts = Instance.new("ExperienceInviteOptions")
						opts.InviteUser = data.userId
						opts.PromptMessage = ("Invite @%s to trade"):format(data.username)
						opts.LaunchData = HttpService:JSONEncode({ type = "TradeInvite", sender = LocalPlayer.UserId })
						SocialService:PromptGameInvite(LocalPlayer, opts)
					end
				end
			end
		end)
		return card
	end

	local trove = Trove.new()
	local function updateLists()
		local curr = coroutine.running()
		updateCoroutine = curr
		trove:Clean()
		if currentTab == "Search" then return end
		local inGameFriends = Friends:GetInGameFriends(LocalPlayer)
		local playersList = {}
		if currentTab == "Server" then
			for _, plr in Players:GetPlayers() do
				if plr ~= LocalPlayer then
					table.insert(playersList, {
						username = plr.Name,
						userId = plr.UserId,
						inGame = true,
						canInvite = true,
						isFriend = table.find(inGameFriends, plr) ~= nil
					})
				end
			end
		elseif currentTab == "Friends" then
			local success, friends = Friends:GetOnlineFriends()
			if success and type(friends) == "table" then
				for _, f in friends do
					local inGame = f.PlaceId and table.find(ServerData.AllPlaces, f.PlaceId) ~= nil
					table.insert(playersList, {
						username = f.UserName,
						userId = f.VisitorId,
						inGame = inGame,
						canInvite = true,
						isFriend = true
					})
				end
			end
		end
		if curr == updateCoroutine then
			for i, data in playersList do
				trove:Add(createUserCard(currentTab == "Search" and TradePlayerList.Global.List or TradePlayerList.Other.List, data, i))
			end
		end
	end

	local function setTab(tab)
		if currentTab == tab then return end
		currentTab = tab
		SearchBox.Text = ""
		TradePlayerList.Other.Visible = tab ~= "Search"
		TradePlayerList.Global.Visible = tab == "Search"
		TradePlayerList.bg.SearchFrame.Visible = tab == "Search"
		for _, btn in TradePlayerList.Btns:GetChildren() do
			if btn:IsA("GuiButton") then
				btn.BackgroundColor3 = btn.Name == tab and Color3.fromRGB(81,158,86) or Color3.fromRGB(115,152,172)
			end
		end
		updateLists()
	end

	Players.PlayerAdded:Connect(function() if currentTab == "Server" then updateLists() end end)
	Players.PlayerRemoving:Connect(function() if currentTab == "Server" then updateLists() end end)

	SearchBox.FocusLost:Connect(function(enterPressed)
		if not enterPressed then return end
		local text = SearchBox.Text
		SearchBox.TextEditable = false
		SearchBox.Active = false
		SearchBox.Text = "..."
		trove:Clean()
		local ok, userId = pcall(function() return Players:GetUserIdFromNameAsync(text) end)
		if not ok or type(userId) ~= "number" then
			SearchBox.Text = string.find(tostring(userId), "Unknown user") and "User not found!" or "Failed to search"
			task.wait(5)
			SearchBox.Text = ""
			SearchBox.TextEditable = true
			SearchBox.Active = true
			updateLists()
			return
		end
		local success, inGame, canInvite = SearchUser:InvokeServer(userId)
		if not success then
			SearchBox.Text = type(inGame) == "string" and inGame or "Failed"
			task.wait(5)
			SearchBox.Text = ""
			SearchBox.TextEditable = true
			SearchBox.Active = true
			updateLists()
			return
		end
		local username = text
		local userData = UsersAPI:GetUser(userId)
		if userData and userData.IsLoaded then username = userData.Username end
		trove:Add(createUserCard(TradePlayerList.Global.List, {
			userId = userId,
			username = username,
			inGame = inGame,
			canInvite = canInvite
		}, 1))
		SearchBox.Text = ""
		task.wait(5)
		SearchBox.TextEditable = true
		SearchBox.ClearTextOnFocus = true
		SearchBox.Active = true
	end)

	local function updateCrossTab()
		local disabled = FFlags:GetInstant("TradeService/CrossServerDisabled", false)
		for _, btn in TradePlayerList.Btns:GetChildren() do
			if btn:IsA("GuiButton") and btn.Name ~= "Server" then
				btn.Visible = not disabled
			end
		end
		if disabled and currentTab ~= "Server" then setTab("Server") end
	end

	for _, btn in TradePlayerList.Btns:GetChildren() do
		if btn:IsA("GuiButton") then
			local tabName = btn.Name
			local animBtn = AnimatedButton.new(btn)
			animBtn:Animate()
			animBtn.OnActivated:Connect(function() setTab(tabName) end)
		end
	end
	setTab("Server")
	updateCrossTab()
	FFlags:OnUpdate(updateCrossTab)

	Observers.observeTag("TradeMachinePrompt", function(prompt)
		local conn = prompt.Triggered:Connect(function() InterfaceController:Toggle("TradePlayerList") end)
		return function() conn:Disconnect() end
	end)
end

function t._createInvites()
	local activeInvites = {}
	CreateInvite.OnClientEvent:Connect(function(inviteId, inviteData)
		local timeLeft = inviteData.expires - workspace:GetServerTimeNow()
		if timeLeft <= 0 then return end
		local fromUser = UsersAPI:GetUser(inviteData.from)
		if not fromUser then return end
		local frame = Prompt:Clone()
		frame.Username.Text = ("@%s wants to trade with you"):format(fromUser.Username)
		frame.Visible = true
		local remove = CornerNotificationController:Add(frame)
		local invite = { id = inviteId, invite = inviteData, frame = frame }
		table.insert(activeInvites, invite)

		local function destroy()
			local idx = table.find(activeInvites, invite)
			if idx then table.remove(activeInvites, idx); remove() end
		end

		local accepted = false
		frame.Yes.Activated:Connect(function()
			if accepted then return end
			SoundController:PlaySound("Sounds.Sfx.Activated")
			if workspace:GetServerTimeNow() > inviteData.expires then
				destroy(); return
			end
			accepted = true
			xpcall(function()
				local idx = table.find(activeInvites, invite)
				if idx then table.remove(activeInvites, idx); remove() end
				local success, err = AcceptInvite:InvokeServer(inviteId)
				if not success and type(err) == "string" then
					NotificationController:Error(err)
				end
			end, warn)
			accepted = false
		end)

		frame.No.Activated:Connect(function()
			if workspace:GetServerTimeNow() > inviteData.expires then
				destroy(); return
			end
			SoundController:PlaySound("Sounds.Sfx.Activated")
			DeclineInvite:FireServer(inviteId)
			destroy()
		end)

		invite.frame = frame
		task.delay(timeLeft, destroy)
	end)
end

function t._createLiveTrade()
	local tradeChannel = ReplicatorClient.get(("Trade_%d"):format(LocalPlayer.UserId))
	InterfaceController:Register("TradeLiveTrade", TradeLiveTrade, "TopQuint"):Close()
	local closeBtn = AnimatedButton.new(TradeLiveTrade.Header.Close)
	closeBtn:Animate(nil, nil, 5)
	local playerData = Synchronizer:Wait(LocalPlayer)
	if not playerData then return end
	local trove = Trove.new()

	local function playTradeMachineAnimation()
		for _, machine in CollectionService:GetTagged("TradeMachine") do
			local animator = machine:FindFirstChild("Animate")
			if animator then
				local anim = animator:FindFirstChildWhichIsA("Animation")
				if anim then
					local controller = machine:FindFirstChildWhichIsA("AnimationController") or machine:FindFirstChildWhichIsA("Humanoid")
					if controller then
						local animatorInst = controller:FindFirstChildWhichIsA("Animator")
						if animatorInst then
							local track = animatorInst:LoadAnimation(anim)
							track.Looped = false
							track:Play()
						end
					end
				end
			end
		end
	end
	TradeCompleted.OnClientEvent:Connect(playTradeMachineAnimation)

	local function cleanup()
		InterfaceController:SetState("TradeLiveTrade", false)
		trove:Clean()
	end

	local currentTradeId = nil
	tradeChannel:ListenRaw(function(state)
		if state == nil then
			currentTradeId = nil
			InterfaceController:SetState("TradeLiveTrade", false)
			trove:Clean()
			return
		end
		local active = tradeChannel:TryIndex({ "active", "data" })
		if not active then
			currentTradeId = nil
			InterfaceController:SetState("TradeLiveTrade", false)
			trove:Clean()
			return
		end
		if currentTradeId == active.tradeId then
			InterfaceController:SetState("TradePlayerList", false)
			InterfaceController:SetState("TradeLiveTrade", true)
			return
		end
		trove:Clean()
		InterfaceController:SetState("TradePlayerList", false)
		InterfaceController:SetState("TradeLiveTrade", true)
		currentTradeId = active.tradeId

		local users = tradeChannel:TryIndex({ "active", "data", "users" }) or {}
		local mySlot, otherSlot, otherUserId
		for slot, uid in users do
			if uid == LocalPlayer.UserId then mySlot = slot else otherSlot = slot; otherUserId = uid end
		end
		if not mySlot or not otherSlot then return end

		local otherUsername = tradeChannel:TryIndex({ "active", "data", "players", otherSlot, "username" }) or "???"
		TradeLiveTrade.Other.Username.Text = ("@%s's Offer"):format(otherUsername)
		TradeLiveTrade.Other.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100"):format(otherUserId)
		TradeLiveTrade.Your.Username.Text = "Your Offer"
		TradeLiveTrade.Your.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100"):format(LocalPlayer.UserId)

		-- Panneaux "Sign" désactivés
		local YourSign = TradeLiveTrade:FindFirstChild("YourSign")
		local OtherSign = TradeLiveTrade:FindFirstChild("OtherSign")
		if YourSign then YourSign.Visible = false end
		if OtherSign then OtherSign.Visible = false end

		local function updateBaseSlots()
			local players = tradeChannel:TryIndex({ "active", "data", "players" })
			if type(players) ~= "table" then return end
			local myData = players[mySlot]
			local otherData = players[otherSlot]
			if type(myData) ~= "table" or type(otherData) ~= "table" then return end
			local myOffered = #(myData.offer and myData.offer.brainrots or {})
			local otherOffered = #(otherData.offer and otherData.offer.brainrots or {})
			local base = Bases[playerData:Get("Rebirth") or 0]
			if base then
				local maxAnimals = base.MaxAnimals
				local pods = playerData:Get("AnimalPodiums") or {}
				local occupied = 0
				for i = 1, maxAnimals do
					if pods[i] ~= "Empty" and pods[i] ~= nil then occupied = occupied + 1 end
				end
				local afterTrade = occupied - myOffered + otherOffered
				TradeLiveTrade.Your.BaseSlots.Text = ("%d/%d"):format(afterTrade, maxAnimals)
				TradeLiveTrade.Your.BaseSlots.TextColor3 = maxAnimals < afterTrade and Color3.fromRGB(255,70,70) or Color3.fromRGB(255,255,255)
			end
			local otherMax = otherData.maxSlots
			local otherEmpty = otherData.emptySlots
			if type(otherMax) == "number" and type(otherEmpty) == "number" then
				local afterTradeOther = otherMax - otherEmpty - otherOffered + myOffered
				TradeLiveTrade.Other.BaseSlots.Text = ("%d/%d"):format(afterTradeOther, otherMax)
				TradeLiveTrade.Other.BaseSlots.TextColor3 = otherMax < afterTradeOther and Color3.fromRGB(255,70,70) or Color3.fromRGB(255,255,255)
			end
		end

		trove:Add(tradeChannel:Observe({ "active", "data", "players" }, updateBaseSlots))
		trove:Add(playerData:OnChanged("AnimalPodiums", updateBaseSlots))

		local function updateState()
			local lastChange = tradeChannel:TryIndex({ "active", "data", "lastChange" })
			local players = tradeChannel:TryIndex({ "active", "data", "players" })
			local usersTable = tradeChannel:TryIndex({ "active", "data", "users" })
			if type(lastChange) ~= "number" or type(players) ~= "table" or type(usersTable) ~= "table" then return end
			local anyOffers = false
			for _, p in players do
				if p.offer and next(p.offer.brainrots) then anyOffers = true; break end
			end
			local allReady = true
			for _, p in players do if not p.ready then allReady = false; break end end
			local allAccepted = true
			for _, p in players do if not p.accepted then allAccepted = false; break end end
			local myEntry = players[table.find(usersTable, LocalPlayer.UserId)]
			local timeLeft = lastChange + 5 - workspace:GetServerTimeNow()
			local canAccept = timeLeft <= 0 and (allReady and not myEntry.accepted) or (anyOffers and not myEntry.ready)
			Spr.target(TradeLiveTrade.Other.ReadyButton, 1, 5, {
				BackgroundColor3 = canAccept and Color3.fromRGB(81,158,86) or Color3.fromRGB(112,112,112)
			})
			TradeLiveTrade.Other.Timer.Text = (allAccepted or tradeChannel:TryIndex({ "active", "data", "isProcessing" })) and "Processing..." or (timeLeft <= 0 and "" or ("🔮%s Left"):format(math.floor(timeLeft*10)/10))
		end

		local stateTrove = trove:Extend()
		trove:Add(tradeChannel:Observe({ "active", "data", "lastChange" }, function()
			stateTrove:Clean()
			if tradeChannel:TryIndex({ "active", "data", "lastChange" }) then
				stateTrove:Add(Timer.Simple(0.1, updateState, true))
			end
		end))

		local selectionTrove = trove:Extend()
		local function addBrainrot(slot, animal)
			local success, err = AddBrainrot:InvokeServer(slot, animal)
			if not success and type(err) == "string" then NotificationController:Error(err) end
			return success
		end
		local function removeBrainrot(slot, animal)
			local success, err = RemoveBrainrot:InvokeServer(slot, animal)
			if not success and type(err) == "string" then NotificationController:Error(err) end
			return success
		end

		local selectionCards = {}
		local offeredIndices = {}
		local renderTrove = trove:Extend()

		local function updateSelectionColors()
			for idx, card in selectionCards do
				local offered = offeredIndices[idx] == true
				card.isOffered = offered
				card.frame.Spacer.BackgroundColor3 = offered and Color3.fromRGB(15,50,15) or Color3.fromRGB(35,45,50)
				card.frame.Spacer.UIStroke.Color = offered and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,0,0)
			end
		end

		local function renderOffer(offerTrove, cache, container, brainrots)
			local newKeys = {}
			for _, br in brainrots do
				-- Clé incluant IndexOnPlot pour différencier deux mêmes animaux sur des plots différents
				local key = ("%s:%s:%s:%s:%d"):format(br.UUID or "", br.Index or "", br.Mutation or "", table.concat(br.Traits or {}, ","), br.IndexOnPlot or 0)
				newKeys[key] = true
				if not cache[key] then
					local animalData = Animals[br.Index]
					if animalData then
						local subTrove = offerTrove:Extend()
						local card = subTrove:Clone(container.Template)
						card.LayoutOrder = br.Order or 0
						card.Visible = true
						card.Spacer.Title.Text = animalData.DisplayName or br.Index
						card.Spacer.Cash.Text = ("$%s/s"):format(NumberUtils:ToString(Animals_2:GetGeneration(br.Index, br.Mutation, br.Traits)))
						local view = Animals_2:AttachOnViewportWithOptimizations(br.Index, card.Spacer.ViewportFrame, nil, br.Mutation)
						if view then subTrove:Add(view) end
						for _, trait in ipairs(br.Traits or {}) do
							local traitData = Traits[trait]
							if traitData then
								local icon = subTrove:Clone(card.Spacer.Traits.Template)
								icon.Name = trait
								icon.Visible = true
								icon.Image = traitData.Icon
								icon.Parent = card.Spacer.Traits
							end
						end
						card.Parent = container
						cache[key] = { trove = subTrove }
					end
				end
			end
			for key, entry in pairs(cache) do
				if not newKeys[key] then
					entry.trove:Clean()
					cache[key] = nil
				end
			end
		end

		local function clearOfferCache(cache)
			for _, entry in pairs(cache) do entry.trove:Clean() end
			table.clear(cache)
		end

		local selectionVisible = true
		local function setSelectionVisible(visible)
			selectionVisible = visible
			for _, card in selectionCards do card.frame.Visible = visible end
		end

		local otherOfferCache = {}
		local otherOfferTrove = trove:Extend()
		local isBothReady = false

		trove:Add(tradeChannel:Observe({ "active", "data", "players" }, function(players)
			offeredIndices = {}
			if type(players) ~= "table" then
				isBothReady = false
				clearOfferCache(otherOfferCache)
				setSelectionVisible(true)
				updateSelectionColors()
				return
			end
			local myData = players[mySlot]
			local myBrainrots = (myData and myData.offer and myData.offer.brainrots) or {}
			for _, br in myBrainrots do
				if type(br.IndexOnPlot) == "number" then offeredIndices[br.IndexOnPlot] = true end
			end
			local allReady = true
			for _, p in players do if not p.ready then allReady = false; break end end
			TradeLiveTrade.Your.Ready.Visible = myData.accepted or (not allReady and myData.ready)
			TradeLiveTrade.Your.Ready.Label.Text = myData.accepted and "Confirmed!" or "Ready!"
			if allReady then
				setSelectionVisible(false)
				renderOffer(renderTrove, otherOfferCache, TradeLiveTrade.Your.ScrollingFrame, myBrainrots)
			else
				if isBothReady then
					clearOfferCache(otherOfferCache)
				end
				setSelectionVisible(true)
				updateSelectionColors()
			end
			isBothReady = allReady
		end))

		local function createSelectionCard(idx, animal)
			local animalData = Animals[animal.Index]
			if not animalData then return end
			local cardTrove = selectionTrove:Extend()
			local card = cardTrove:Clone(TradeLiveTrade.Your.ScrollingFrame.Template)
			card.Name = ("Selection_%d"):format(idx)
			card.Visible = selectionVisible
			card.Spacer.Title.Text = animalData.DisplayName or animal.Index
			card.Spacer.Cash.Text = ("$%s/s"):format(NumberUtils:ToString(Animals_2:GetGeneration(animal.Index, animal.Mutation, animal.Traits)))
			local view = Animals_2:AttachOnViewportWithOptimizations(animal.Index, card.Spacer.ViewportFrame, nil, animal.Mutation)
			if view then cardTrove:Add(view) end
			for _, trait in ipairs(animal.Traits or {}) do
				local traitData = Traits[trait]
				if traitData then
					local icon = cardTrove:Clone(card.Spacer.Traits.Template)
					icon.Name = trait
					icon.Visible = true
					icon.Image = traitData.Icon
					icon.Parent = card.Spacer.Traits
				end
			end
			card.Parent = TradeLiveTrade.Your.ScrollingFrame
			local isProcessing = false
			cardTrove:Add(card.Spacer.Activated:Connect(function()
				if isProcessing then return end
				isProcessing = true
				SoundController:PlaySound("Sounds.Sfx.Activated")
				if offeredIndices[idx] then
					xpcall(removeBrainrot, warn, idx, animal)
				else
					xpcall(addBrainrot, warn, idx, animal)
				end
				isProcessing = false
			end))
			-- Clé incluant IndexOnPlot
			local key = ("%s:%s:%s:%s:%d"):format(animal.UUID or "", animal.Index or "", animal.Mutation or "", table.concat(animal.Traits or {}, ","), idx)
			local cardEntry = { frame = card, trove = cardTrove, isOffered = false, key = key }
			selectionCards[idx] = cardEntry
			local offered = offeredIndices[idx] == true
			cardEntry.isOffered = offered
			card.Spacer.BackgroundColor3 = offered and Color3.fromRGB(15,50,15) or Color3.fromRGB(35,45,50)
			card.Spacer.UIStroke.Color = offered and Color3.fromRGB(0,255,0) or Color3.fromRGB(0,0,0)
		end

		local function renderAnimalPodiums()
			local pods = playerData:Get("AnimalPodiums") or {}
			local seen = {}
			for idx, animal in pods do
				if type(animal) == "table" and not animal.Machine then
					seen[idx] = true
					local key = ("%s:%s:%s:%s:%d"):format(animal.UUID or "", animal.Index or "", animal.Mutation or "", table.concat(animal.Traits or {}, ","), idx)
					local existing = selectionCards[idx]
					if not existing or existing.key ~= key then
						if existing then existing.trove:Clean(); selectionCards[idx] = nil end
						createSelectionCard(idx, animal)
					end
				end
			end
			for idx, card in selectionCards do
				if not seen[idx] then
					card.trove:Clean()
					selectionCards[idx] = nil
				end
			end
		end

		trove:Add(playerData:OnChanged("AnimalAddedOrRemoved", renderAnimalPodiums))
		trove:Add(playerData:OnChanged("AnimalPodiums", renderAnimalPodiums, true))

		local cancelling = false
		local function cancelTrade()
			if cancelling then return end
			cancelling = true
			SoundController:PlaySound("Sounds.Sfx.Activated")
			CancelTrade:FireServer()
			cancelling = false
		end
		trove:Add(TradeLiveTrade.Other.Cancel.Activated:Connect(cancelTrade))
		trove:Add(closeBtn.OnActivated:Connect(cancelTrade))

		TradeLiveTrade.Other.ReadyButton.Txt.Text = "READY"
		local _readyCooldown = false
		trove:Add(TradeLiveTrade.Other.ReadyButton.Activated:Connect(function()
			if _readyCooldown then return end
			SoundController:PlaySound("Sounds.Sfx.Activated")
			local lastChange = tradeChannel:TryIndex({ "active", "data", "lastChange" })
			if type(lastChange) ~= "number" or workspace:GetServerTimeNow() < lastChange + 8 then
				local timeLeft = math.ceil((lastChange or 0) + 8 - workspace:GetServerTimeNow())
				if timeLeft > 0 then NotificationController:Error(("Attends encore %ds avant d'accepter !"):format(timeLeft)) end
				return
			end
			local players = tradeChannel:TryIndex({ "active", "data", "players" })
			if type(players) ~= "table" then return end
			local allReady = true
			for _, p in players do if not p.ready then allReady = false; break end end
			if allReady then
				_readyCooldown = true
				AcceptRemote:FireServer()
			else
				_readyCooldown = true
				ReadyRemote:FireServer()
			end
			task.delay(2, function() _readyCooldown = false end)
		end))

		local otherPlayersCache = {}
		local otherPlayersTrove = {}
		trove:Add(tradeChannel:Observe({ "active", "data", "players" }, function(players)
			if type(players) ~= "table" then return end
			local allReady = true
			for _, p in players do if not p.ready then allReady = false; break end end
			TradeLiveTrade.Other.ReadyButton.Txt.Text = allReady and "ACCEPT" or "READY"
			for slot, data in players do
				if tonumber(slot) and tonumber(slot) ~= mySlot then
					local container = TradeLiveTrade.Other.ScrollingFrame
					if not otherPlayersCache[slot] then
						otherPlayersCache[slot] = trove:Extend()
						otherPlayersTrove[slot] = {}
					end
					TradeLiveTrade.Other.Ready.Visible = data.accepted or (not allReady and data.ready)
					TradeLiveTrade.Other.Ready.Label.Text = data.accepted and "Confirmed!" or "Ready!"
					renderOffer(otherPlayersCache[slot], otherPlayersTrove[slot], container, (data.offer and data.offer.brainrots) or {})
				end
			end
		end))
	end)
end

function t.Start()
	task.spawn(t._createPlayerList, t)
	task.spawn(t._createInvites, t)
	task.spawn(t._createLiveTrade, t)
end

return t