-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local RunService = game:GetService("RunService")
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local AbstractItem = require(ReplicatedStorage.Library.Items.AbstractItem)
local ItemUI = require(ReplicatedStorage.Library.Client.UI.ItemUI)
local ItemContainerUI = require(ReplicatedStorage.Library.Client.UI.ItemContainerUI)
local Types = require(ReplicatedStorage.Library.Items.Types).Types
local TradingCmds = require(ReplicatedStorage.Library.Client.TradingCmds)
local CurrencyCmds = require(ReplicatedStorage.Library.Client.CurrencyCmds)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Functions = require(ReplicatedStorage.Library.Functions)
local Message = require(ReplicatedStorage.Library.Client.Message)
local Audio = require(ReplicatedStorage.Library.Audio)
local Variables = require(ReplicatedStorage.Library.Variables)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local FlashText = require(ReplicatedStorage.Library.Client.GUIFX.FlashText)
local Tooltip = require(ReplicatedStorage.Library.Client.GUIFX.Tooltip)
local InfoOverlay = require(ReplicatedStorage.Library.Client.InfoOverlay)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local ScreenResolution = require(ReplicatedStorage.Library.Client.ScreenResolution)
local Trading = require(ReplicatedStorage.Library.Types.Trading)
local Notifications = require(script.Notifications)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

require(script.PlayerList)

local LocalPlayer = game.Players.LocalPlayer
local v2 = GUI.TradeWindow()
local Frame = v2:WaitForChild("Frame")
local Buttons = Frame.Buttons
local ChatOverlay = Frame.ChatOverlay
local ClientDiamonds = Frame.ClientDiamonds
local Input = ClientDiamonds.Diamonds.Input
local ClientItems = Frame.ClientItems
local TextLabel = Frame.PlayerDiamonds.TextLabel
local PlayerItems = Frame.PlayerItems
local Tabs = Frame.Tabs
local v3 = Frame:WaitForChild("shadow-toolbar")
local PlayerRAPHolder = Frame.PlayerRAPHolder
local ClientRAPHolder = Frame.ClientRAPHolder
local Filters = ClientItems.Filters
local Confirmed = Filters.Confirmed
local Confirmed2 = PlayerItems.Confirmed
local Status = ClientItems.Status
local Status2 = PlayerItems.Status
local ChatButton = Frame.ChatButton
local Cancel = Buttons.CancelHolder.Cancel
local Ready = Buttons.ReadyHolder.Ready
local Footer = ChatOverlay.Footer
local Input2 = Footer.Message.Input
local Send = Footer.Send
local Notification = ChatButton.Notification
local ClientBar = ClientItems.ClientBar
local GridMode = ClientBar.Container.GridMode
local Input3 = ClientBar.Search.Input
local ClientTitle = Frame.ClientTitle
local ClientIcon = Frame.ClientIcon
local PlayerTitle = Frame.PlayerTitle
local PlayerIcon = Frame.PlayerIcon
local Notice = Frame.Notice
local GreenGradient = Assets.UI.Gradients.GreenGradient
local RedGradient = Assets.UI.Gradients.RedGradient
local GreyGradient = Assets.UI.Gradients.GreyGradient
local BlueGradient = Assets.UI.Gradients.BlueGradient
local v4 = Color3.new(0/255, 0/255, 0/255)
local v5 = Color3.new(255/255, 255/255, 255/255)
local v6 = Color3.fromRGB(64, 252, 59)
local v7 = table.clone(Trading.InventoryItemTypes)
local v9 = assert(v7[1], "Missing default category in trading categories")
local t = {}

t.__index = t
t.__class = "Trading"

local function getTradeItemKey(p1) --[[ getTradeItemKey | Line: 137 ]]
	if p1:IsA("Brainrot") then
		return p1:GetUID()
	end

	return p1:GetId()
end

function t._build() --[[ _build | Line: 149 | Upvalues: t (copy), FuncWrapper (copy), v9 (copy) ]]
	local v2 = setmetatable({}, t)

	v2._funcWrapper = FuncWrapper.CreateWrapper(v2)
	v2._isGridView = false
	v2._userState = nil
	v2._isModificationLocked = false
	v2._lastDiamondValue = 0
	v2._categoryGroup = v9
	v2._currentRenderSelectedItems = {}
	v2._currentItems = {}
	v2._clientItemContainer = nil
	v2._playerItemContainer = nil
	v2._lastMessageTime = nil
	v2._confirmTimestamp = nil
	v2._closeTradeListeners = {}
	v2:_init()

	return v2
end
function t.RemoveTradeNotif(p1) --[[ RemoveTradeNotif | Line: 178 | Upvalues: Notifications (copy) ]]
	Notifications:Remove()
end
function t.HasTradeNotif(p1) --[[ HasTradeNotif | Line: 182 | Upvalues: Notifications (copy) ]]
	return Notifications:HasTradeNotif()
end
function t._getResolution(p1) --[[ _getResolution | Line: 186 ]]
	return p1._isGridView and {
		{
			ResolutionThreshold = 0.65,
			PerRow = 6,
			Padding = UDim2.fromOffset(4, 8)
		},
		{
			ResolutionThreshold = 1.2,
			PerRow = 8,
			Padding = UDim2.fromOffset(5, 7.5)
		},
		{
			ResolutionThreshold = (1 / 0),
			PerRow = 8,
			Padding = UDim2.fromOffset(7.5, 10)
		}
	} or {
		{
			ResolutionThreshold = 0.65,
			PerRow = 4,
			Padding = UDim2.fromOffset(5, 10)
		},
		{
			ResolutionThreshold = 1.2,
			PerRow = 4,
			Padding = UDim2.fromOffset(10, 15)
		},
		{
			ResolutionThreshold = (1 / 0),
			PerRow = 4,
			Padding = UDim2.fromOffset(15, 20)
		}
	}
end
function t._diamondChangedSFX(p1, p2, p3, p4) --[[ _diamondChangedSFX | Line: 224 | Upvalues: Audio (copy), FlashText (copy) ]]
	if tostring(p3) ~= tostring(p4) then
		Audio.Play("rbxassetid://123259573996522", script, nil, 1)
		FlashText(p2)
	end
end
function t._setSelectionEnabled(p1, p2) --[[ _setSelectionEnabled | Line: 234 ]]
	if not p1._userState then
		return
	end

	for k, v in pairs(p1._userState.containers) do
		v:SetSelectionEnabled(p2)
	end
end
function t._populateCategoryItems(p1, p2) --[[ _populateCategoryItems | Line: 245 | Upvalues: Types (copy) ]]
	return table.clone(assert(Types[p2], "ItemType not found for category: " .. tostring(p2)):All())
end
function t._refreshTabAvailability(p1) --[[ _refreshTabAvailability | Line: 250 | Upvalues: Tabs (copy) ]]
	if not p1._userState then
		return
	end

	for i, v in ipairs(Tabs:GetChildren()) do
		if v:IsA("GuiButton") then
			local v1 = p1._userState.population[v.Name]
			local v2 = if v1 then next(v1) ~= nil else v1

			v.Icon.ImageColor3 = v2 and Color3.new(255/255, 255/255, 255/255) or Color3.new(0/255, 0/255, 0/255)
			v.Icon.ImageTransparency = if v2 then 0 else 0.8
			v.Icon.Icon.Visible = false
		end
	end
end
function t._refreshCategory(p1, p2) --[[ _refreshCategory | Line: 266 ]]
	if not p1._userState then
		return
	end

	local v1 = p1:_populateCategoryItems(p2)

	p1._userState.population[p2] = v1

	local v2 = p1._userState.containers[p2]

	if v2 then
		v2:Populate(v1)
		p1:_syncCategorySelectionFromTradeState(p2)
	end

	p1:_refreshTabAvailability()
end
function t._syncLocalSelectionFromTradeState(p1, p2, p3) --[[ _syncLocalSelectionFromTradeState | Line: 283 | Upvalues: TradingCmds (copy), LocalPlayer (copy) ]]
	local v1 = TradingCmds.GetState()

	if not (v1 and p1._userState) then
		return
	end

	local v2 = v1:PlayerIndex(LocalPlayer)

	if not v2 then
		return
	end

	local v3 = p1._userState.containers[p2]

	if not v3 then
		return
	end

	local v4 = v1._items[v2][p2]
	local v5 = if v4 then v4[p3] else v4

	v3:SetSelectionAmount(p3, if v5 then v5:GetAmount() else 0)
end
function t._syncCategorySelectionFromTradeState(p1, p2) --[[ _syncCategorySelectionFromTradeState | Line: 307 | Upvalues: TradingCmds (copy), LocalPlayer (copy) ]]
	if not p1._userState then
		return
	end

	local v1 = TradingCmds.GetState()

	if not v1 then
		return
	end

	local v2 = v1:PlayerIndex(LocalPlayer)

	if not v2 then
		return
	end

	local v3 = p1._userState.containers[p2]

	if not v3 then
		return
	end

	v3:ClearSelection()

	local v4 = v1._items[v2][p2]

	if not v4 then
		return
	end

	for k, v in pairs(v4) do
		if v then
			v3:SetSelectionAmount(k, v:GetAmount())
		end
	end
end
function t._getAllSelected(p1, p2) --[[ _getAllSelected | Line: 344 ]]
	local t = {}

	for k, v in pairs(p2) do
		for k2, v2 in pairs(v) do
			if not v2:IsA("Currency") then
				t[k2] = v2
			end
		end
	end

	return t
end
function t._isChatting(p1) --[[ _isChatting | Line: 356 | Upvalues: ChatOverlay (copy) ]]
	return ChatOverlay.Visible
end
function t._incrementChatNotification(p1) --[[ _incrementChatNotification | Line: 360 | Upvalues: Notification (copy) ]]
	if not p1:_isChatting() then
		local v1 = tonumber(Notification.Count.Text) or 0

		assert(v1, "Chat notification count must be a valid number")
		Notification.Count.Text = v1 + 1
		Notification.Visible = true
	end
end
function t._getOtherDiamonds(p1) --[[ _getOtherDiamonds | Line: 372 | Upvalues: Functions (copy) ]]
	local Currency = p1._currentItems.Currency

	if not Currency then
		return 0
	end

	if Functions.DictionaryLength(Currency) == 0 then
		return 0
	end

	local _, v1 = next(Currency)

	if v1 then
		return v1:GetAmount()
	end

	return 0
end
function t._setDiamondAmount(p1) --[[ _setDiamondAmount | Line: 388 | Upvalues: Functions (copy), Input (copy), CurrencyCmds (copy), TradingCmds (copy), Audio (copy) ]]
	local v1 = Functions.ParseNumberSmart(Input.Text)

	if not CurrencyCmds.GetItem("Coins") then
		p1:_diamondChangedSFX(Input, "0", p1._lastDiamondValue)
		Input.Text = "0"
		p1._lastDiamondValue = 0
		TradingCmds.SetCurrency("Coins", 0)

		return
	end

	local function reset() --[[ reset | Line: 397 | Upvalues: p1 (copy), Input (ref), TradingCmds (ref) ]]
		p1:_diamondChangedSFX(Input, "0", p1._lastDiamondValue)
		Input.Text = "0"
		p1._lastDiamondValue = 0
		TradingCmds.SetCurrency("Coins", 0)
	end

	if not v1 then
		p1:_diamondChangedSFX(Input, "0", p1._lastDiamondValue)
		Input.Text = "0"
		p1._lastDiamondValue = 0
		TradingCmds.SetCurrency("Coins", 0)

		return
	end

	local v2 = math.round(v1)

	if v2 <= 0 then
		p1:_diamondChangedSFX(Input, "0", p1._lastDiamondValue)
		Input.Text = "0"
		p1._lastDiamondValue = 0
		TradingCmds.SetCurrency("Coins", 0)

		return
	end

	local v3 = if CurrencyCmds.CanAfford("Coins", v2) then v2 else CurrencyCmds.Get("Coins")

	Audio.Play("rbxassetid://123259573996522", script, nil, 1)
	Input.Text = Functions.Commas(v3)
	p1:_diamondChangedSFX(Input, v3, p1._lastDiamondValue)
	p1._lastDiamondValue = v3
	TradingCmds.SetCurrency("Coins", v3)
end
function t._sendChatMessage(p1) --[[ _sendChatMessage | Line: 429 | Upvalues: TradingCmds (copy), Input2 (copy), Functions (copy), Send (copy), GreyGradient (copy), Trading (copy), BlueGradient (copy), Message (copy) ]]
	local v1 = TradingCmds.GetState()
	local Text = Input2.Text

	if not v1 or (not p1._userState or Text == "") then
		return
	end

	Input2.Text = ""
	p1._lastMessageTime = workspace:GetServerTimeNow()
	Functions.GradientSwap(Send, GreyGradient)
	task.delay(Trading.ClientMessageDebounce, function() --[[ Line: 438 | Upvalues: Functions (ref), Send (ref), BlueGradient (ref) ]]
		Functions.GradientSwap(Send, BlueGradient)
	end)

	local v2, v3 = TradingCmds.Message(Text)

	if v2 or not v3 then
		return
	end

	Message.New(v3, {
		err = true,
		tradeAllowed = true
	})
end
function t._updateMessageScroll(p1) --[[ _updateMessageScroll | Line: 453 | Upvalues: ChatOverlay (copy) ]]
	local Messages = ChatOverlay.Messages
	local UIListLayout = Messages:FindFirstChildOfClass("UIListLayout")

	Messages.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X, UIListLayout.AbsoluteContentSize.Y + 50)
end
function t._receivedMessage(p1, p2, p3) --[[ _receivedMessage | Line: 461 | Upvalues: LocalPlayer (copy), Assets (copy), ChatOverlay (copy), Functions (copy), Audio (copy) ]]
	local v1 = if p2 == LocalPlayer then true else false
	local v2 = v1 and Assets.UI.Trading.Chat.ClientLine:Clone() or Assets.UI.Trading.Chat.PlayerLine:Clone()
	local ImageLabel = v2:FindFirstChild("ImageLabel")

	task.defer(function() --[[ Line: 466 | Upvalues: ChatOverlay (ref) ]]
		ChatOverlay.Messages.CanvasPosition = ChatOverlay.Messages.AbsoluteCanvasSize
	end)

	if not v1 then
		if ImageLabel then
			ImageLabel.Image = ""
			task.spawn(function() --[[ Line: 473 | Upvalues: ImageLabel (copy), Functions (ref), p2 (copy) ]]
				ImageLabel.Image = Functions.GetThumbnailFromUserIdAsync(p2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180) or ""
			end)
		end

		if not p1:_isChatting() then
			p1:_incrementChatNotification()
		end
	end

	v2:FindFirstChildOfClass("Frame"):FindFirstChild("Label").Text = p3
	v2.Parent = ChatOverlay.Messages
	Audio.Play(if v1 then "rbxassetid://130425178156489" else "rbxassetid://93792051643626", script, 1, 1)
	p1:_updateMessageScroll()
end
function t._getReadyStatus(p1) --[[ _getReadyStatus | Line: 498 | Upvalues: TradingCmds (copy), LocalPlayer (copy) ]]
	local v1 = TradingCmds.GetState()

	if not v1 then
		return
	end

	local v2 = v1:PlayerIndex(LocalPlayer)

	if v2 then
		return v1._ready[v2], v1._ready[v1:Index2(v2)]
	end
end
function t._renderGroup(p1, p2) --[[ _renderGroup | Line: 512 | Upvalues: Filters (copy), Input3 (copy), ItemContainerUI (copy), ItemUI (copy), Trading (copy), AbstractItem (copy), Message (copy), TradingCmds (copy) ]]
	if not p1._userState then
		return
	end

	if p1:_getReadyStatus() then
		return
	end

	local v1 = Filters:FindFirstChild(p2)

	assert(v1, "Filter group not found for category: " .. tostring(p2))
	Input3.Text = ""

	for i, v in ipairs(Filters:GetChildren()) do
		if v:IsA("GuiObject") then
			v.Visible = v.Name == p2
		end
	end

	if p1._userState.containers[p2] then
		return
	end

	for k, v in pairs(v1:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end

	local v3 = ItemContainerUI.new(v1, {
		LoadSpeed = 40,
		Permitted = function(p1) --[[ Permitted | Line: 535 ]]
			return p1:IsTradable()
		end,
		Creator = function(p1) --[[ Creator | Line: 538 | Upvalues: ItemUI (ref) ]]
			local t = {
				NoActionMenu = true
			}

			t.HideQuantity = p1:GetAmount() == 1

			return ItemUI.Create(p1, t)
		end,
		SelectionPermitted = function(p1) --[[ SelectionPermitted | Line: 545 ]]
			return p1:IsTradable()
		end,
		Comparator = function(p1, p2) --[[ Comparator | Line: 548 | Upvalues: ItemContainerUI (ref) ]]
			local v1 = p1:IsTradable()

			if v1 == p2:IsTradable() then
				return ItemContainerUI.Comparators.Default(p1, p2)
			end

			return v1
		end,
		ResolutionSettings = p1:_getResolution(),
		SelectionMode = ItemContainerUI.SelectionMode.UNLIMITED,
		QuantityMode = ItemContainerUI.QuantityMode.NORMAL,
		EventMode = ItemContainerUI.EventMode.ON_RELEASE,
		MaxSelectedStacks = Trading.ItemLimit,
		SearchBar = Input3
	})

	assert(v3, "Failed to create item container for category: " .. tostring(p2))

	if p1._userState.population[p2] then
		v3:Populate(p1._userState.population[p2])
		p1:_syncCategorySelectionFromTradeState(p2)
		v3:AddItemListener(function(p1, p2, p3) --[[ Line: 568 | Upvalues: AbstractItem (ref), Message (ref), TradingCmds (ref), v3 (copy) ]]
			local v1 = AbstractItem:Get(p1)

			if not v1 then
				Message.New("Failed to add item to trade!", {
					tradeAllowed = true
				})

				return
			end

			local v4, v5 = TradingCmds.SetItem(v1.Class.Name, if v1:IsA("Brainrot") then v1:GetUID() else v1:GetId(), p2)

			if v4 then
				return
			end

			v3:SetSelectionAmount(p1, p3)
			task.spawn(function() --[[ Line: 580 | Upvalues: Message (ref), v5 (copy) ]]
				Message.New(v5 or "Failed to add item to trade!", {
					tradeAllowed = true
				})
			end)
		end)
	end

	p1._userState.containers[p2] = v3
	p1._categoryGroup = p2
end
function t._unRenderSelectedItems(p1) --[[ _unRenderSelectedItems | Line: 598 | Upvalues: Filters (copy) ]]
	if not p1._clientItemContainer then
		Filters.Items.Visible = false

		return
	end

	p1._clientItemContainer:Destroy()
	p1._clientItemContainer = nil
	Filters.Items.Visible = false
end
function t._renderSelectedItems(p1, p2) --[[ _renderSelectedItems | Line: 607 | Upvalues: Filters (copy), PlayerItems (copy), ItemContainerUI (copy), ItemUI (copy) ]]
	local v1 = p2 and p1._currentRenderSelectedItems or p1._currentItems
	local v2 = p2 and Filters.Items or PlayerItems.Items

	if p2 then
		v2.Visible = true
	end

	local t = {
		LoadSpeed = 40,
		Comparator = ItemContainerUI.Comparators.Default,
		Permitted = function(p1) --[[ Permitted | Line: 615 ]]
			return p1:IsTradable()
		end,
		Creator = function(p1) --[[ Creator | Line: 618 | Upvalues: ItemUI (ref) ]]
			local t = {
				NoActionMenu = true,
				NoButtonFX = true
			}

			t.HideQuantity = p1:GetAmount() == 1

			return ItemUI.Create(p1, t)
		end,
		ResolutionSettings = p1:_getResolution(),
		SelectionMode = ItemContainerUI.SelectionMode.DISABLED
	}

	if p2 then
		if not p1._clientItemContainer then
			p1._clientItemContainer = ItemContainerUI.new(v2, t)
		end

		assert(p1._clientItemContainer, "Client item container could not be created")
		p1._clientItemContainer:Populate(p1:_getAllSelected(v1))
	else
		if not p1._playerItemContainer then
			p1._playerItemContainer = ItemContainerUI.new(v2, t)
		end

		assert(p1._playerItemContainer, "Player item container could not be created")
		p1._playerItemContainer:Populate(p1:_getAllSelected(v1))
	end
end
function t._unRenderContainers(p1) --[[ _unRenderContainers | Line: 646 | Upvalues: Filters (copy) ]]
	for i, v in ipairs(Filters:GetChildren()) do
		if v:IsA("GuiObject") and v.Name ~= "Items" then
			v.Visible = false
		end
	end
end
function t._clientReady(p1) --[[ _clientReady | Line: 655 ]]
	p1:_unRenderContainers()
	p1:_renderSelectedItems(true)
end
function t._clientUnready(p1) --[[ _clientUnready | Line: 661 | Upvalues: v9 (copy) ]]
	p1:_unRenderSelectedItems()
	p1:_renderGroup(p1._categoryGroup or v9)
end
function t._clearTabNotifications(p1) --[[ _clearTabNotifications | Line: 667 | Upvalues: Tabs (copy) ]]
	for i, v in ipairs(Tabs:GetChildren()) do
		if v:IsA("GuiObject") then
			local TopRight = v:FindFirstChild("TopRight")

			if TopRight then
				TopRight.Visible = false
			end
		end
	end
end
function t._setupMaxSelections(p1) --[[ _setupMaxSelections | Line: 679 | Upvalues: Trading (copy) ]]
	if not p1._userState then
		return
	end

	local ItemLimit = Trading.ItemLimit
	local sum = 0

	for k, v in pairs(p1._userState.containers) do
		sum = sum + v:GetStackCount()
	end

	for k, v in pairs(p1._userState.containers) do
		v:SetMaximumSelectedStacks(ItemLimit - sum + v:GetStackCount())
	end
end
function t._renderTabNotifications(p1) --[[ _renderTabNotifications | Line: 693 | Upvalues: Tabs (copy) ]]
	if not p1._userState then
		return
	end

	for i, v in ipairs(Tabs:GetChildren()) do
		if v:IsA("GuiObject") then
			local v1 = p1._userState.containers[v.Name]

			if v1 then
				local TopRight = v:FindFirstChild("TopRight")

				if TopRight then
					local Amount = TopRight:FindFirstChild("Frame"):FindFirstChild("Amount")
					local v2 = v1:GetSelectionCount()

					if v2 <= 0 then
						TopRight.Visible = false

						continue
					end

					TopRight.Visible = true
					Amount.Text = tostring(v2)
				end
			end
		end
	end
end
function t._getConfirmedStatus(p1) --[[ _getConfirmedStatus | Line: 717 | Upvalues: TradingCmds (copy), LocalPlayer (copy) ]]
	local v1 = TradingCmds.GetState()

	if not v1 then
		return
	end

	local v2 = v1:PlayerIndex(LocalPlayer)

	if v2 then
		return v1._confirmed[v2], v1._confirmed[v1:Index2(v2)]
	end
end
function t._update(p1) --[[ _update | Line: 731 | Upvalues: TradingCmds (copy), Status (copy), Status2 (copy), ClientItems (copy), v6 (copy), v4 (copy), PlayerItems (copy), ClientTitle (copy), v5 (copy), PlayerTitle (copy), Input (copy), Confirmed (copy), Confirmed2 (copy), ClientIcon (copy), PlayerIcon (copy), Tabs (copy), v3 (copy), GridMode (copy), TextLabel (copy), Functions (copy), Input3 (copy), ClientBar (copy), Notice (copy), Audio (copy), Trading (copy), Ready (copy), GreyGradient (copy), RedGradient (copy), GreenGradient (copy) ]]
	local v1 = TradingCmds.GetState()

	if not v1 then
		return
	end

	local v2, v32 = p1:_getReadyStatus()
	local v42 = v2 and v32
	local v52, v62 = p1:_getConfirmedStatus()
	local v7 = v2 and not v42 or v52
	local v8 = v32 and not v42 or v62

	Status.Visible = v7
	Status2.Visible = v8
	Status.Text = if v52 then "Confirmed!" else "Ready!"
	Status2.Text = if v62 then "Confirmed!" else "Ready!"
	ClientItems.UIStroke.Color = v7 and v6 or v4
	PlayerItems.UIStroke.Color = v8 and v6 or v4
	ClientTitle.TextColor3 = v7 and v6 or v5
	PlayerTitle.TextColor3 = v8 and v6 or v5
	Input.Parent.Parent.BackgroundColor3 = v7 and v6 or v4
	Input.Parent.Parent.UIStroke.Color = v7 and v6 or v4
	Input.TextEditable = not p1:_isChatting() and not v2
	Input.ClearTextOnFocus = not p1:_isChatting() and not v2
	Confirmed.Visible = v52
	Confirmed2.Visible = v62
	ClientIcon.Visible = not p1:_isChatting()
	PlayerIcon.Visible = not p1:_isChatting()
	ClientTitle.Visible = not p1:_isChatting()
	PlayerTitle.Visible = not p1:_isChatting()
	Tabs.Visible = not v2 and not p1:_isChatting()
	v3.Visible = not v2 and not p1:_isChatting()
	GridMode.ImageColor3 = p1._isGridView and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(42, 43, 49)

	local v322 = p1:_getOtherDiamonds()

	p1:_diamondChangedSFX(TextLabel, Functions.Commas(v322), TextLabel.Text)
	TextLabel.Text = Functions.Commas(v322)
	Input3.TextEditable = not p1:_isChatting()
	ClientBar.Visible = not v2

	if v1._readyTimer then
		if v1._confirmedTimer then
			local v33 = v1._confirmedTimer - workspace:GetServerTimeNow()
			local v35 = math.floor((math.floor(v33 * 10) / 10 + 0.1) * 10 + 0.5) / 10

			if v33 <= 0 then
				p1._confirmTimestamp = nil
				Notice.Text = "\226\140\155 Trade confirming..."
			else
				if p1._confirmTimestamp and p1._confirmTimestamp ~= math.floor(v35) then
					Audio.Play("rbxassetid://132281384049192", script, nil, 1)
				end

				p1._confirmTimestamp = math.floor(v35)
				Notice.Text = "\226\140\155 " .. v35 .. " seconds left..."
			end
		else
			Notice.Text = "Countdown starts when both players are Confirmed!"
		end
	else
		Notice.Text = ""
	end

	local v36 = Trading.ModificationReadyDuration - (workspace:GetServerTimeNow() - v1._lastModified)

	if v36 > 0 then
		p1._isModificationLocked = true
		Ready.TextLabel.Text = "(" .. math.floor((math.floor(v36 * 10) / 10 + 0.1) * 10 + 0.5) / 10 .. ")"
		Functions.GradientSwap(Ready, GreyGradient)
	else
		p1._isModificationLocked = false
		Ready.TextLabel.Text = if v2 then if v2 and not v42 then "Unready!" elseif v42 and not v52 then "Confirm!" elseif v42 and v52 then "Unconfirm!" else "Ready!" else "Ready!"
		Functions.GradientSwap(Ready, v7 and RedGradient or GreenGradient)
	end

	p1:_setupMaxSelections()
	p1:_renderTabNotifications()
end
function t._closeTrade(p1) --[[ _closeTrade | Line: 823 | Upvalues: TabController (copy), Variables (copy) ]]
	if not p1._userState then
		return
	end

	TabController.SetLockedTab(nil)

	for i, v in ipairs(p1._closeTradeListeners) do
		task.spawn(v)
	end

	for k, v in pairs(p1._userState.containers) do
		v:Destroy()
	end

	if p1._clientItemContainer then
		p1._clientItemContainer:Destroy()
		p1._clientItemContainer = nil
	end

	if p1._playerItemContainer then
		p1._playerItemContainer:Destroy()
		p1._playerItemContainer = nil
	end

	p1._currentRenderSelectedItems = {}
	p1._currentItems = {}
	p1._userState = nil
	Variables.Trading = false
end
function t._setupTrade(p1, p2) --[[ _setupTrade | Line: 850 | Upvalues: Variables (copy), TabController (copy), v7 (copy), Tabs (copy), ButtonFX (copy), InfoOverlay (copy), Input (copy), TextLabel (copy), ClientRAPHolder (copy), PlayerRAPHolder (copy), Notification (copy), Input2 (copy), ChatOverlay (copy), Notice (copy), PlayerTitle (copy), PlayerIcon (copy), ClientIcon (copy), Functions (copy), LocalPlayer (copy), v9 (copy), AbstractItem (copy) ]]
	Variables.Trading = true
	TabController.SetLockedTab("TradeWindow")

	local function populateItems() --[[ populateItems | Line: 853 | Upvalues: v7 (ref), p1 (copy) ]]
		local t = {}

		for i, v in ipairs(v7) do
			t[v] = p1:_populateCategoryItems(v)
		end

		return t
	end

	p1._userState = {
		populator = populateItems,
		population = populateItems(),
		containers = {}
	}
	assert(p1._userState, "User state could not be properly initialized")

	for i, v in ipairs(Tabs:GetChildren()) do
		if v:IsA("GuiButton") then
			local v1 = v.Name

			if p1._userState.population[v1] and next(p1._userState.population[v1]) then
				local function onTabActivated() --[[ onTabActivated | Line: 871 | Upvalues: p1 (copy), v (copy) ]]
					if not p1:_isChatting() then
						p1:_renderGroup(v.Name)
					end
				end

				local v2 = v.Activated:Connect(onTabActivated)

				table.insert(p1._closeTradeListeners, ButtonFX(v))
				table.insert(p1._closeTradeListeners, InfoOverlay.Hook(v, {
					{ "Title", v.Name }
				}))

				local function f4() --[[ Line: 883 | Upvalues: v2 (ref) ]]
					v2:Disconnect()
				end

				table.insert(p1._closeTradeListeners, f4)
			end

			v.Icon.Icon.Visible = false
		end
	end

	Input.Text = "0"
	TextLabel.Text = "0"
	ClientRAPHolder.Amount.Text = "0"
	PlayerRAPHolder.Amount.Text = "0"
	Notification.Count.Text = "0"
	Notification.Visible = false
	Input2.Text = ""
	ChatOverlay.Visible = false
	p1:_setSelectionEnabled(true)

	for k, v in pairs(ChatOverlay.Messages:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	p1:_updateMessageScroll()
	Notice.Text = "Countdown starts when both players are Ready!"
	PlayerTitle.Text = p2:GetAttribute("Partner") and p2.Name .. " (\240\159\148\165 Partner)" or p2.Name
	PlayerIcon.Image = ""
	ClientIcon.Image = ""
	PlayerIcon.Loading.Visible = true
	ClientIcon.Loading.Visible = true
	task.spawn(function() --[[ Line: 916 | Upvalues: PlayerIcon (ref), Functions (ref), p2 (copy) ]]
		PlayerIcon.Image = Functions.GetThumbnailFromUserIdAsync(p2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180) or ""
		PlayerIcon.Loading.Visible = false
	end)
	task.spawn(function() --[[ Line: 926 | Upvalues: ClientIcon (ref), Functions (ref), LocalPlayer (ref) ]]
		ClientIcon.Image = Functions.GetThumbnailFromUserIdAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180) or ""
		ClientIcon.Loading.Visible = false
	end)
	p1:_clearTabNotifications()
	p1:_refreshTabAvailability()
	p1:_renderGroup(v9)

	local function connectInventoryRefresh(p12) --[[ connectInventoryRefresh | Line: 939 | Upvalues: LocalPlayer (ref), p1 (copy), v7 (ref) ]]
		local v1 = p12:Connect(function(p13, p23) --[[ Line: 940 | Upvalues: LocalPlayer (ref), p1 (ref), v7 (ref) ]]
			if p23 ~= LocalPlayer or not p1._userState then
				return
			end

			local v1 = p13.Class.Name

			if table.find(v7, v1) ~= nil then
				p1:_refreshCategory(v1)
			end
		end)
		local _closeTradeListeners = p1._closeTradeListeners

		table.insert(_closeTradeListeners, function() --[[ Line: 952 | Upvalues: v1 (copy) ]]
			v1:Disconnect()
		end)
	end

	local v72 = AbstractItem.Added:Connect(function(p13, p23) --[[ Line: 940 | Upvalues: LocalPlayer (ref), p1 (copy), v7 (ref) ]]
		if p23 ~= LocalPlayer or not p1._userState then
			return
		end

		local v1 = p13.Class.Name

		if table.find(v7, v1) ~= nil then
			p1:_refreshCategory(v1)
		end
	end)

	table.insert(p1._closeTradeListeners, function() --[[ Line: 952 | Upvalues: v72 (copy) ]]
		v72:Disconnect()
	end)

	local v8 = AbstractItem.Removed:Connect(function(p13, p23) --[[ Line: 940 | Upvalues: LocalPlayer (ref), p1 (copy), v7 (ref) ]]
		if p23 ~= LocalPlayer or not p1._userState then
			return
		end

		local v1 = p13.Class.Name

		if table.find(v7, v1) ~= nil then
			p1:_refreshCategory(v1)
		end
	end)

	table.insert(p1._closeTradeListeners, function() --[[ Line: 952 | Upvalues: v8 (copy) ]]
		v8:Disconnect()
	end)

	local v92 = AbstractItem.Tracked:Connect(function(p13, p23) --[[ Line: 940 | Upvalues: LocalPlayer (ref), p1 (copy), v7 (ref) ]]
		if p23 ~= LocalPlayer or not p1._userState then
			return
		end

		local v1 = p13.Class.Name

		if table.find(v7, v1) ~= nil then
			p1:_refreshCategory(v1)
		end
	end)

	table.insert(p1._closeTradeListeners, function() --[[ Line: 952 | Upvalues: v92 (copy) ]]
		v92:Disconnect()
	end)
	p1._lastDiamondValue = 0
	p1._confirmTimestamp = nil
end
function t._calculateRAPValues(p1) --[[ _calculateRAPValues | Line: 966 ]]
	local sum = 0
	local sum2 = 0

	for k, v in pairs(p1._currentRenderSelectedItems) do
		for k2, v2 in pairs(v) do
			if v2:IsA("Currency") then
				sum = sum + v2:GetAmount()

				continue
			end

			if v2:IsRAPVisible() then
				sum = sum + (v2:GetDevRAP() or 0) * v2:GetAmount()
			end
		end
	end

	for k, v in pairs(p1._currentItems) do
		for k2, v2 in pairs(v) do
			if v2:IsA("Currency") then
				sum2 = sum2 + v2:GetAmount()

				continue
			end

			if v2:IsRAPVisible() then
				sum2 = sum2 + (v2:GetDevRAP() or 0) * v2:GetAmount()
			end
		end
	end

	return sum, sum2
end
function t._updateRAPValues(p1) --[[ _updateRAPValues | Line: 990 | Upvalues: PlayerRAPHolder (copy), Functions (copy), ClientRAPHolder (copy) ]]
	local v1, v2 = p1:_calculateRAPValues()

	PlayerRAPHolder.Amount.Text = Functions.NumberShorten(v2, false)
	ClientRAPHolder.Amount.Text = Functions.NumberShorten(v1, false)
end
function t._updateItems(p1, p2, p3) --[[ _updateItems | Line: 997 ]]
	p1._currentRenderSelectedItems = p2
	p1._currentItems = p3
	p1:_renderSelectedItems(false)
	p1:_updateRAPValues()
end
function t._updateItemsById(p1, p2) --[[ _updateItemsById | Line: 1005 | Upvalues: TradingCmds (copy), LocalPlayer (copy) ]]
	local v3 = assert(TradingCmds.GetState(p2), "Trade state not found for tradeId: " .. tostring(p2))
	local v5 = assert(v3:PlayerIndex(LocalPlayer), "Player index not found for localPlayer in UpdateItemsById")

	p1:_updateItems(v3._items[v5], v3._items[v3:Index2(v5)])
	p1:_update()
end
function t._onTradeCreated(p1, p2, p3, p4) --[[ _onTradeCreated | Line: 1015 | Upvalues: LocalPlayer (copy), TabController (copy) ]]
	p1:_setupTrade(if p3 == LocalPlayer and p4 then p4 else p3)
	p1:_update()
	TabController.OpenTab("TradeWindow")
end
function t._onTradeSetReady(p1, p2, p3, p4) --[[ _onTradeSetReady | Line: 1022 | Upvalues: TradingCmds (copy), LocalPlayer (copy), Audio (copy) ]]
	local v1 = TradingCmds.GetState(p2)

	assert(v1, "Trade state not found for tradeId: " .. tostring(p2))

	local v3 = v1:PlayerIndex(LocalPlayer)

	assert(v3, "Player index not found for localPlayer in TradeSetReady")

	if p4 then
		Audio.Play("rbxassetid://129831368538797", script, nil, 1)
	end

	if v3 == p3 and p4 then
		p1:_clientReady()
	elseif v3 == p3 then
		p1:_clientUnready()
	end

	p1:_update()
end
function t._onTradeSetItem(p1, p2, p3, p4, p5) --[[ _onTradeSetItem | Line: 1044 | Upvalues: TradingCmds (copy), LocalPlayer (copy) ]]
	local v1 = TradingCmds.GetState(p2)

	if v1 then
		local v2 = v1:PlayerIndex(LocalPlayer)

		if v2 and v2 == p3 then
			p1:_syncLocalSelectionFromTradeState(p4, p5)
		end
	end

	p1:_updateItemsById(p2)
end
function t._onTradeMessage(p1, p2, p3, p4) --[[ _onTradeMessage | Line: 1062 | Upvalues: TradingCmds (copy) ]]
	local v1 = TradingCmds.GetState(p2)

	assert(v1, "Trade state not found for tradeId: " .. tostring(p2))
	p1:_receivedMessage(v1:Player1(p3), p4)
end
function t._onTradeDestroyed(p1, p2, p3) --[[ _onTradeDestroyed | Line: 1070 | Upvalues: TabController (copy), Audio (copy), Message (copy) ]]
	TabController.SetLockedTab(nil)

	if TabController.Get() == "TradeWindow" then
		TabController.CloseTab()
	end

	if p3 then
		local v1 = string.find(p3, "successfully") ~= nil

		if v1 then
			Audio.Play("rbxassetid://85645660281534", script, nil, 1)
		end

		local t = {
			tradeAllowed = true
		}

		t.sound = if v1 then "rbxassetid://74508332171664" else "rbxassetid://109670773332731"
		Message.New(p3, t)
	end

	p1:_closeTrade()
end
function t._onReadyButtonActivated(p1) --[[ _onReadyButtonActivated | Line: 1089 | Upvalues: TradingCmds (copy), v1 (copy), Message (copy), Functions (copy) ]]
	local v12 = TradingCmds.GetState()

	if not v12 then
		return
	end

	if p1:_isChatting() or (v12._executing or p1._isModificationLocked) then
		return
	end

	if v12._readyTimer == nil then
		local v2 = p1:_getReadyStatus()

		v1:AtTrace():Log((("ReadyButton activated, ready: %*"):format(v2)))

		if not v2 and (Functions.DictionaryLength(p1._currentItems) == 0 and not Message.New("Are you sure? You won\'t get anything from this trade.", true, {
			tradeAllowed = true
		})) then
			warn("no items")

			return
		end

		local v3, v4 = TradingCmds.SetReady(not v2)

		warn("set ready reqeust:", "ready?", v2, "success?", v3, "error?", v4)

		if v3 or not v4 then
			return
		end

		Message.New(v4, {
			tradeAllowed = true
		})
	else
		local v5 = p1:_getConfirmedStatus()

		v1:AtTrace():Log((("ReadyButton activated, confirmed: %*"):format(v5)))

		if not (v5 or Message.New("Are you sure? Make sure the trade is fair before continuing.", true, {
			tradeAllowed = true
		})) then
			return
		end

		local v6, v7 = TradingCmds.SetConfirmed(not v5)

		if not v6 and v7 then
			Message.New(v7, {
				tradeAllowed = true
			})
		end
	end
end
function t._onGridToggleActivated(p1) --[[ _onGridToggleActivated | Line: 1140 ]]
	if p1:_isChatting() then
		return
	end

	p1._isGridView = not p1._isGridView

	local v1 = p1:_getResolution()

	if p1._userState then
		for k, v in pairs(p1._userState.containers) do
			v:ChangeResolutionSettings(v1)
		end
	end

	if p1._clientItemContainer then
		p1._clientItemContainer:ChangeResolutionSettings(v1)
	end

	if p1._playerItemContainer then
		p1._playerItemContainer:ChangeResolutionSettings(v1)
	end

	p1:_update()
end
function t._onClientDiamondsInputBegan(p1, p2, p3) --[[ _onClientDiamondsInputBegan | Line: 1165 | Upvalues: TradingCmds (copy), Input (copy) ]]
	if p3 then
		return
	end

	local v1 = TradingCmds.GetState()

	if not v1 then
		return
	end

	local v2 = if v1._readyTimer == nil then false else true
	local v3 = p1:_getReadyStatus()

	if p1:_isChatting() or (v3 or (v2 or p2.UserInputType ~= Enum.UserInputType.MouseButton1 and p2.UserInputType ~= Enum.UserInputType.Touch)) then
		return
	end

	Input:CaptureFocus()
end
function t._onChatButtonActivated(p1) --[[ _onChatButtonActivated | Line: 1189 | Upvalues: ChatOverlay (copy), Notification (copy), Input3 (copy) ]]
	ChatOverlay.Visible = not ChatOverlay.Visible
	p1:_setSelectionEnabled(not ChatOverlay.Visible)
	Notification.Count.Text = 0
	Notification.Visible = false

	if not ChatOverlay.Visible then
		return
	end

	Input3:ReleaseFocus()
end
function t._onClientDiamondInputFocusLost(p1) --[[ _onClientDiamondInputFocusLost | Line: 1200 | Upvalues: TradingCmds (copy) ]]
	local v1 = TradingCmds.GetState()

	if not v1 then
		return
	end

	if v1._executing then
		return
	end

	if not v1._readyTimer then
		p1:_setDiamondAmount()
	end
end
function t._onSendButtonActivated(p1) --[[ _onSendButtonActivated | Line: 1214 | Upvalues: Trading (copy) ]]
	if p1._lastMessageTime and workspace:GetServerTimeNow() - p1._lastMessageTime <= Trading.ClientMessageDebounce then
		return
	end

	p1:_sendChatMessage()
end
function t._onChatInputFocusLost(p1, p2) --[[ _onChatInputFocusLost | Line: 1226 ]]
	if p2 then
		p1:_sendChatMessage()
	end
end
function t._onScreenResolutionChanged(p1) --[[ _onScreenResolutionChanged | Line: 1235 | Upvalues: v2 (copy) ]]
	if not v2.Enabled then
		return
	end

	p1:_updateMessageScroll()
end
function t._onCancelButtonActivated(p1) --[[ _onCancelButtonActivated | Line: 1241 | Upvalues: TradingCmds (copy) ]]
	if not TradingCmds.GetState() then
		return
	end

	if not p1:_isChatting() then
		TradingCmds.Decline()
	end
end
function t._init(p1) --[[ _init | Line: 1252 | Upvalues: TradingCmds (copy), ScreenResolution (copy), GUI (copy), Cancel (copy), Ready (copy), ChatButton (copy), GridMode (copy), ClientDiamonds (copy), Send (copy), Input (copy), Input2 (copy), ButtonFX (copy), Tooltip (copy), Variables (copy), RunService (copy) ]]
	TradingCmds.TradeCreated:Connect(p1._funcWrapper(p1._onTradeCreated))
	TradingCmds.TradeSetReady:Connect(p1._funcWrapper(p1._onTradeSetReady))
	TradingCmds.TradeSetItem:Connect(p1._funcWrapper(p1._onTradeSetItem))
	TradingCmds.TradeMessage:Connect(p1._funcWrapper(p1._onTradeMessage))
	TradingCmds.TradeDestroyed:Connect(p1._funcWrapper(p1._onTradeDestroyed))
	ScreenResolution.Changed:Connect(p1._funcWrapper(p1._onScreenResolutionChanged))
	GUI.ButtonActivated(Cancel, p1._funcWrapper(p1._onCancelButtonActivated))
	GUI.ButtonActivated(Ready, p1._funcWrapper(p1._onReadyButtonActivated))
	GUI.ButtonActivated(ChatButton, p1._funcWrapper(p1._onChatButtonActivated))
	GridMode.Activated:Connect(p1._funcWrapper(p1._onGridToggleActivated))
	ClientDiamonds.InputBegan:Connect(p1._funcWrapper(p1._onClientDiamondsInputBegan))
	Send.Activated:Connect(p1._funcWrapper(p1._onSendButtonActivated))
	Input.FocusLost:Connect(p1._funcWrapper(p1._onClientDiamondInputFocusLost))
	Input2.FocusLost:Connect(p1._funcWrapper(p1._onChatInputFocusLost))
	ButtonFX(Cancel)
	ButtonFX(Ready)
	ButtonFX(GridMode)
	ButtonFX(ChatButton)
	ButtonFX(Send)
	Tooltip(GridMode, "Toggle Grid View")
	task.spawn(function() --[[ Line: 1279 | Upvalues: Variables (ref), RunService (ref), p1 (copy) ]]
		while true do
			while not Variables.Trading do
				RunService.Heartbeat:Wait()
			end

			p1:_update()
			RunService.Heartbeat:Wait()
		end
	end)
end

return t._build()