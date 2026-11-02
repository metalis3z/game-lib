local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local UsersAPI = require(ReplicatedStorage.Shared.UsersAPI)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)

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
local Animals2 = require(ReplicatedStorage.Shared.Animals)
local TradingFlags = require(ReplicatedStorage.Shared.Flags.TradingFlags)
local Friends = require(ReplicatedStorage.Shared.Friends)
local BaseSkins = require(ReplicatedStorage.Shared.BaseSkins)
local Gears = require(ReplicatedStorage.Shared.Gears)
local Index = require(ReplicatedStorage.Datas.Index)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Prompt = PlayerGui:WaitForChild("TradePrompts").Prompt
local TradePlayerList = PlayerGui:WaitForChild("TradePlayerList").TradePlayerList
local TradeLiveTrade = PlayerGui:WaitForChild("TradeLiveTrade").TradeLiveTrade
local CreateInviteEvent = Net:RemoteEvent("TradeService/CreateInvite")
local DeclineInviteEvent = Net:RemoteEvent("TradeService/DeclineInvite")
local AcceptInviteFunc = Net:RemoteFunction("TradeService/AcceptInvite")
local SearchUserFunc = Net:RemoteFunction("TradeService/SearchUser")
local InviteFunc = Net:RemoteFunction("TradeService/Invite")
local CancelTradeEvent = Net:RemoteEvent("TradeService/CancelTrade")
local SendChatMessageEvent = Net:RemoteEvent("TradeService/SendChatMessage")
local AddBrainrotFunc = Net:RemoteFunction("TradeService/AddBrainrot")
local RemoveBrainrotFunc = Net:RemoteFunction("TradeService/RemoveBrainrot")
local AddItemFunc = Net:RemoteFunction("TradeService/AddItem")
local RemoveItemFunc = Net:RemoteFunction("TradeService/RemoveItem")
local GetTradeHistoryFunc = Net:RemoteFunction("TradeService/GetTradeHistory")
local HistoryUpdatedEvent = Net:RemoteEvent("TradeService/HistoryUpdated")
local TradeCompletedEvent = Net:RemoteEvent("TradeService/TradeCompleted")
local AcceptEvent = Net:RemoteEvent("TradeService/Accept")
local ReadyEvent = Net:RemoteEvent("TradeService/Ready")
local ToggleSettingFunc = Net:RemoteFunction("SettingsService/ToggleSetting")
local TradeNotificationEvent = Net:RemoteEvent("TradeService/TradeNotification")

local function brainrotKey(brainrotData)
	return `{ brainrotData.UUID or "" }:{ brainrotData.Index or "" }:{ brainrotData.Mutation or "" }:{ table.concat(brainrotData.Traits or {}, ",") }`
end

local function renderBrainrotCard(cardFrame, brainrotData, trove)
	local animalData = Animals[brainrotData.Index]
	cardFrame.Spacer.Title.Text = animalData and animalData.DisplayName or brainrotData.Index
	cardFrame.Spacer.Cash.Text = `${ NumberUtils:ToString(Animals2:GetGeneration(brainrotData.Index, brainrotData.Mutation, brainrotData.Traits)) }/s`
	local viewportCleanup = Animals2:AttachOnViewportWithOptimizations(brainrotData.Index, cardFrame.Spacer.ViewportFrame, nil, brainrotData.Mutation)
	if viewportCleanup then
		trove:Add(viewportCleanup)
	end
	for _, trait in brainrotData.Traits or {} do
		local traitData = Traits[trait]
		if traitData then
			local clone = trove:Clone(cardFrame.Spacer.Traits.Template)
			clone.Name = trait
			clone.Visible = true
			clone.Image = traitData.Icon
			clone.Parent = cardFrame.Spacer.Traits
		end
	end
end

local function renderBaseSkinCard(cardFrame, skinData, trove)
	cardFrame.Spacer.Title.Text = skinData.SkinName
	cardFrame.Spacer.Cash.Text = "Base Skin"
	local ViewportFrame = cardFrame.Spacer.ViewportFrame
	local skinImage = BaseSkins.GetImage(skinData.SkinName)
	if skinImage then
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Name = "SkinImage"
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
		ImageLabel.Size = UDim2.fromScale(1, 1)
		ImageLabel.ScaleType = Enum.ScaleType.Fit
		ImageLabel.Image = skinImage
		ImageLabel.Parent = ViewportFrame
		trove:Add(ImageLabel)
		return
	end
	local indexEntry = Index[skinData.SkinName]
	if indexEntry and indexEntry.MainColor then
		ViewportFrame.BackgroundColor3 = indexEntry.MainColor
	end
end

local function renderGearCard(cardFrame, gearData, trove)
	cardFrame.Spacer.Title.Text = Gears.GetDisplayName(gearData.GearName)
	cardFrame.Spacer.Cash.Text = "Gear"
	local ViewportFrame = cardFrame.Spacer.ViewportFrame
	local gearImage = Gears.GetImage(gearData.GearName)
	if gearImage then
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.Name = "GearImage"
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
		ImageLabel.Size = UDim2.fromScale(1, 1)
		ImageLabel.ScaleType = Enum.ScaleType.Fit
		ImageLabel.Image = gearImage
		ImageLabel.Parent = ViewportFrame
		trove:Add(ImageLabel)
	end
end

local ITEM_TYPES = {
	"Brainrot",
	"BaseSkin",
	"Gear"
}

local ItemTypeConfig = {
	Brainrot = {
		Id = "Brainrot",
		OfferKey = "brainrots",
		TabButton = "Brainrots",
		FetchInventory = function(playerData)
			local inventory = {}
			local animalPodiums = playerData:Get("AnimalPodiums")
			if typeof(animalPodiums) ~= "table" then
				return inventory
			end
			for podiumIdx, podiumData in animalPodiums do
				if typeof(podiumData) == "table" and not podiumData.Machine and Animals[podiumData.Index] then
					table.insert(inventory, {
						SelKey = tostring(podiumIdx),
						RefKey = tostring(podiumIdx),
						ContentKey = `{ podiumData.UUID or "" }:{ podiumData.Index or "" }:{ podiumData.Mutation or "" }:{ table.concat(podiumData.Traits or {}, ",") }`,
						Record = podiumData,
						Ref = {
							podiumIndex = podiumIdx,
							brainrot = podiumData
						}
					})
				end
			end
			return inventory
		end,
		RenderCard = renderBrainrotCard,
		ReadOffer = function(offerData)
			local result = {}
			local brainrots = offerData.brainrots
			if typeof(brainrots) ~= "table" then
				return result
			end
			for _, brainrot in brainrots do
				if typeof(brainrot) == "table" and brainrot.IndexOnPlot ~= nil then
					result[tostring(brainrot.IndexOnPlot)] = brainrot
				end
			end
			return result
		end,
		Add = function(ref)
			local success, errorMsg = AddBrainrotFunc:InvokeServer("6b5f15fb-5cb9-4d07-a031-bbff8e641eda", ref.podiumIndex, ref.brainrot)
			if not success and typeof(errorMsg) == "string" then
				NotificationController:Error(errorMsg == "please_wait" and "Please wait before adding another brainrot" or errorMsg)
			end
		end,
		Remove = function(ref)
			local success, errorMsg = RemoveBrainrotFunc:InvokeServer("1a5f9c76-711f-4c90-8117-2ffd3fa21c6d", ref.podiumIndex, ref.brainrot)
			if not success and typeof(errorMsg) == "string" then
				NotificationController:Error(errorMsg == "please_wait_remove" and "Please wait before removing another brainrot" or errorMsg)
			end
		end
	},
	BaseSkin = {
		Id = "BaseSkin",
		OfferKey = "baseSkins",
		TabButton = "BaseSkins",
		FetchInventory = function(playerData)
			local inventory = {}
			local baseSkinInventory = playerData:Get("BaseSkinInventory")
			if typeof(baseSkinInventory) ~= "table" then
				return inventory
			end
			for uuid, skinRecord in baseSkinInventory do
				if typeof(uuid) == "string" and typeof(skinRecord) == "table" and typeof(skinRecord.SkinName) == "string" and BaseSkins.IsTradable(skinRecord.SkinName) then
					table.insert(inventory, {
						SelKey = uuid,
						RefKey = uuid,
						ContentKey = `{ uuid }:{ skinRecord.SkinName }`,
						Record = {
							UUID = uuid,
							SkinName = skinRecord.SkinName
						},
						Ref = {
							UUID = uuid,
							SkinName = skinRecord.SkinName
						}
					})
				end
			end
			return inventory
		end,
		RenderCard = renderBaseSkinCard,
		ReadOffer = function(offerData)
			local result = {}
			local baseSkins = offerData.baseSkins
			if typeof(baseSkins) ~= "table" then
				return result
			end
			for _, skin in baseSkins do
				if typeof(skin) == "table" and typeof(skin.UUID) == "string" then
					result[skin.UUID] = skin
				end
			end
			return result
		end,
		Add = function(ref)
			local success, errorMsg = AddItemFunc:InvokeServer("f2c4a9d1-3b7e-4a51-9c8d-1e6f0a2b3c4d", "BaseSkin", ref)
			if not success and typeof(errorMsg) == "string" then
				NotificationController:Error(errorMsg)
			end
		end,
		Remove = function(ref)
			local success, errorMsg = RemoveItemFunc:InvokeServer("a7e1b5c9-2d48-4f63-8a90-5c1d2e3f4a6b", "BaseSkin", ref)
			if not success and typeof(errorMsg) == "string" then
				NotificationController:Error(errorMsg)
			end
		end
	},
	Gear = {
		Id = "Gear",
		OfferKey = "gears",
		TabButton = "Gears",
		FetchInventory = function(playerData)
			local inventory = {}
			for _, gearRecord in Gears.ListOwned(playerData) do
				local gearKey = if typeof(gearRecord.UUID) ~= "string" then `name:{ gearRecord.GearName }` else gearRecord.UUID
				table.insert(inventory, {
					SelKey = gearKey,
					RefKey = gearKey,
					ContentKey = `{ gearKey }:{ gearRecord.GearName }`,
					Record = {
						GearName = gearRecord.GearName,
						UUID = gearRecord.UUID
					},
					Ref = {
						GearName = gearRecord.GearName,
						UUID = gearRecord.UUID
					}
				})
			end
			return inventory
		end,
		RenderCard = renderGearCard,
		ReadOffer = function(offerData)
			local result = {}
			local gears = offerData.gears
			if typeof(gears) ~= "table" then
				return result
			end
			for _, gear in gears do
				if typeof(gear) == "table" and typeof(gear.GearName) == "string" then
					result[if typeof(gear.UUID) ~= "string" then `name:{ gear.GearName }` else gear.UUID] = gear
				end
			end
			return result
		end,
		Add = function(ref)
			local success, errorMsg = AddItemFunc:InvokeServer("f2c4a9d1-3b7e-4a51-9c8d-1e6f0a2b3c4d", "Gear", ref)
			if not success and typeof(errorMsg) == "string" then
				NotificationController:Error(errorMsg)
			end
		end,
		Remove = function(ref)
			local success, errorMsg = RemoveItemFunc:InvokeServer("a7e1b5c9-2d48-4f63-8a90-5c1d2e3f4a6b", "Gear", ref)
			if not success and typeof(errorMsg) == "string" then
				NotificationController:Error(errorMsg)
			end
		end
	}
}

local TabButtonToType = {}
for _, itemType in ITEM_TYPES do
	TabButtonToType[ItemTypeConfig[itemType].TabButton] = itemType
end

local TradeController = {}

local function len(tbl)
	local count = 0
	for _ in tbl do
		count += 1
	end
	return count
end

function TradeController._createPlayerList(_)
	local playerListInterface = InterfaceController:Register("TradePlayerList", TradePlayerList, "TopQuint")
	playerListInterface:AttachCloseButton(TradePlayerList.Header.Close)
	playerListInterface:Close()
	local Sections = TradePlayerList.Sections
	local Players2 = Sections.Players
	local List = Players2.List
	local SearchBox = Players2.SearchFrame.SearchBox
	local ScrollingFrame = Sections.Settings.ScrollingFrame
	local ScrollingFrame2 = Sections.History.ScrollingFrame
	local BtnToSection = {
		All = "Players",
		Friends = "History",
		Global = "Settings"
	}
	local clone = List.Frame:Clone()
	for _, child in List:GetChildren() do
		if child:IsA("GuiObject") then
			child:Destroy()
		end
	end
	local function updateUserCard(userData: {[any]: any}, index: number, frame)
		frame.Fill.Status2.Text = if not userData.inGame then not userData.isFriend and "Offline" or "Away" else "Online"
		frame.Fill.Status2.TextColor3 = if not userData.inGame then if not userData.isFriend then Color3.fromRGB(211, 38, 38) else Color3.fromRGB(239, 225, 69) else Color3.fromRGB(86, 211, 74)
			frame.Fill.PlayerImage.Status.BackgroundColor3 = if not userData.inGame then if not userData.isFriend then Color3.fromRGB(211, 38, 38) else Color3.fromRGB(239, 225, 69) else Color3.fromRGB(86, 211, 74)
				frame.Fill.Send.BackgroundColor3 = if not (not not userData.inGame and userData.canInvite) and not userData.isFriend then Color3.fromRGB(0, 0, 0) else Color3.fromRGB(0, 0, 0)
				frame.LayoutOrder = if not userData.inGame then index + 300 else index
			end
			local function createUserCard(userData: {[any]: any}, index: number)
				local userCardFrame = clone:Clone()
				userCardFrame.Name = `{ userData.username }_{ userData.userId }`
				userCardFrame.Fill.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ userData.userId }&w=100&h=100`
				userCardFrame.Fill.Username.Text = `@{ userData.username }`
				updateUserCard(userData, index, userCardFrame)
				userCardFrame.Visible = true
				userCardFrame.Parent = List
				local isSending = false
				userCardFrame.Fill.Send.Activated:Connect(function()
					if not userData.canInvite or isSending then
						return
					end
					SoundController:PlaySound("Sounds.Sfx.Activated")
					if userData.inGame then
						isSending = true
						xpcall(function()
							local success, errorMsg = InviteFunc:InvokeServer("afb005f9-6e81-4e0a-8bb0-3555938a9658", userData.realUserId or userData.userId)
							if not success and typeof(errorMsg) == "string" then
								NotificationController:Error(errorMsg)
							end
							userCardFrame.Fill.Send.Txt.Text = not success and "FAILED" or "SENT!"
							task.wait(5)
							userCardFrame.Fill.Send.Txt.Text = "SEND"
						end, warn)
						isSending = false
						return
					end
					if userData.isFriend then
						local ok, result = pcall(function()
							return SocialService:CanSendGameInviteAsync(LocalPlayer)
						end)
						if not ok or not result then
							return
						end
						local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")
						ExperienceInviteOptions.InviteUser = userData.userId
						ExperienceInviteOptions.PromptMessage = `Invite @{ userData.username } to trade`
						ExperienceInviteOptions.LaunchData = HttpService:JSONEncode({
							type = "TradeInvite",
							sender = LocalPlayer.UserId
						})
						SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
					end
				end)
				return userCardFrame
			end
			local playersTrove = Trove.new()
			local isSearching = false
			local function renderServerPlayers()
				isSearching = false
				playersTrove:Clean()
				local InGameFriends = Friends:GetInGameFriends(LocalPlayer)
				local index = 0
				for _, player in Players:GetPlayers() do
					if player ~= LocalPlayer then
						index += 1
						playersTrove:Add((createUserCard({
							inGame = true,
							canInvite = true,
							username = player:GetAttribute("MorphedUsername") or player.Name,
							userId = player:GetAttribute("MorphedUserId") or player.UserId,
							realUserId = player.UserId,
							isFriend = table.find(InGameFriends, player) ~= nil
						}, index)))
					end
				end
			end
			SearchBox.FocusLost:Connect(function(enterPressed: boolean)
				if not enterPressed then
					return
				end
				local SearchBoxText = SearchBox.Text
				if SearchBoxText == "" then
					renderServerPlayers()
					return
				end
				isSearching = true
				SearchBox.TextEditable = false
				SearchBox.Active = false
				SearchBox.Text = "..."
				playersTrove:Clean()
				local ok, result = pcall(function()
					return Players:GetUserIdFromNameAsync(SearchBoxText)
				end)
				if not ok or typeof(result) ~= "number" then
					SearchBox.Text = (typeof(result) ~= "string" or not string.find(result, "Unknown user")) and "Failed to search for user, try again later" or "User not found!"
					task.wait(5)
					SearchBox.Text = ""
					SearchBox.TextEditable = true
					SearchBox.Active = true
					renderServerPlayers()
					return
				end
				local ok2, result2, inGame, canInvite, _csMorph, _dnMorph, _duMorph, realUserId = pcall(function()
					return SearchUserFunc:InvokeServer("792baf13-54a1-4663-92c4-1edd9da1e3e2", result)
				end)
				if not ok2 or not result2 then
					SearchBox.Text = if typeof(result2) ~= "string" then typeof(inGame) ~= "string" and "Failed to search for user, try again later" or inGame else result2
					task.wait(5)
					SearchBox.Text = ""
					SearchBox.TextEditable = true
					SearchBox.Active = true
					renderServerPlayers()
					return
				end
				local ok3, result3 = pcall(function()
					return UsersAPI:GetUser(result)
				end)
				playersTrove:Add((createUserCard({
					userId = result,
					realUserId = realUserId or result,
					username = if not ok3 or (typeof(result3) ~= "table" or not result3.IsLoaded) then string.upper(SearchBoxText) else result3.Username,
					inGame = inGame,
					canInvite = canInvite
				}, 1)))
				SearchBox.Text = ""
				task.wait(5)
				SearchBox.TextEditable = true
				SearchBox.Active = true
			end)
			Players.PlayerAdded:Connect(function()
				if not isSearching then
					renderServerPlayers()
				end
			end)
			Players.PlayerRemoving:Connect(function()
				if not isSearching then
					renderServerPlayers()
				end
			end)
			local playerSync = Synchronizer:Wait(LocalPlayer)
			local settingsTrove = Trove.new()
			local settingsTemplate = ScrollingFrame.Template:Clone()
			for _, child in ScrollingFrame:GetChildren() do
				if child:IsA("GuiObject") then
					child:Destroy()
				end
			end
			local function renderSettings()
				settingsTrove:Clean()
				if not playerSync then
					return
				end
				local receiveTradesSetting = playerSync:Get("Settings.Receive Trades from") or "Everyone"
				local clone4 = settingsTrove:Clone(settingsTemplate)
				clone4.Name = "Receive Trades from"
				clone4.Function.Text = "Receive Trades From"
				local btnBgColor = if receiveTradesSetting ~= "Everyone" then if receiveTradesSetting ~= "Friends" then Color3.fromRGB(245, 56, 56) else Color3.fromRGB(255, 149, 0) else Color3.fromRGB(0, 11, 158)
					local strokeColor = if receiveTradesSetting ~= "Everyone" then if receiveTradesSetting ~= "Friends" then Color3.fromRGB(177, 0, 0) else Color3.fromRGB(190, 111, 0) else Color3.fromRGB(2, 56, 0)
						local Button = clone4.Buttons.Button
						Button.Text.Text = receiveTradesSetting
						Button.BackgroundColor3 = btnBgColor
						Button.UIStroke.Color = strokeColor
						Button.Text.UIStroke.Color = strokeColor
						local animBtn = AnimatedButton.new(Button)
						settingsTrove:Add(animBtn)
						animBtn:Animate()
						settingsTrove:Add(animBtn.OnActivated:Connect(function()
							local nextSettingValue = if receiveTradesSetting ~= "Everyone" then receiveTradesSetting ~= "Friends" and "Everyone" or "No one" else "Friends"
							local success, errorMsg = ToggleSettingFunc:InvokeServer("Receive Trades from", nextSettingValue)
							if not success then
								NotificationController:Error(typeof(errorMsg) ~= "string" and "Failed to update setting" or errorMsg)
								SoundController:PlaySound("Sounds.Sfx.Error")
							end
						end))
						clone4.LayoutOrder = 1
						clone4.Visible = true
						clone4.Parent = ScrollingFrame
						local onlyWithEnabled = playerSync:Get("Settings.Only Receive Trades With") == true
						local clone5 = settingsTrove:Clone(settingsTemplate)
						clone5.Name = "Only Receive Trades With"
						clone5.Function.Text = "Only Receive Trades With"
						local btn2BgColor = if not onlyWithEnabled then Color3.fromRGB(112, 112, 112) else Color3.fromRGB(0, 11, 158)
						local stroke2Color = if not onlyWithEnabled then Color3.fromRGB(64, 64, 64) else Color3.fromRGB(2, 56, 0)
						local Button2 = clone5.Buttons.Button
						Button2.Text.Text = not onlyWithEnabled and "SELECT" or "ON"
						Button2.BackgroundColor3 = btn2BgColor
						Button2.UIStroke.Color = stroke2Color
						Button2.Text.UIStroke.Color = stroke2Color
						local animBtn2 = AnimatedButton.new(Button2)
						settingsTrove:Add(animBtn2)
						animBtn2:Animate()
						settingsTrove:Add(animBtn2.OnActivated:Connect(function()
							local success, errorMsg = ToggleSettingFunc:InvokeServer("Only Receive Trades With")
							if not success then
								NotificationController:Error(typeof(errorMsg) ~= "string" and "Failed to update setting" or errorMsg)
								SoundController:PlaySound("Sounds.Sfx.Error")
								return
							end
							if not onlyWithEnabled then
								InterfaceController:Toggle("SelectBrainrots", true)
							end
						end))
						clone5.LayoutOrder = 2
						clone5.Visible = true
						clone5.Parent = ScrollingFrame
					end
					renderSettings()
					if playerSync then
						playerSync:OnChanged("Settings.Receive Trades from", renderSettings)
						playerSync:OnChanged("Settings.Only Receive Trades With", renderSettings)
					end
					local closedTemplate = ScrollingFrame2.ClosedTemplate:Clone()
					local openedTemplate = ScrollingFrame2.OpenedTemplate:Clone()
					for _, child in ScrollingFrame2:GetChildren() do
						if child:IsA("GuiObject") then
							child:Destroy()
						end
					end
					local function formatTradeTime(timestamp)
						if typeof(timestamp) ~= "number" then
							return ""
						end
						return (os.date("%b %d, %I:%M %p", (math.floor(timestamp))))
					end
					local function fillItemScroll(scrollFrame, offerData, trove)
						local Template = scrollFrame:FindFirstChild("Template")
						if not Template then
							return
						end
						local UIGridLayout = scrollFrame:FindFirstChildOfClass("UIGridLayout")
						if UIGridLayout then
							UIGridLayout.CellSize = if not (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) then UDim2.new(0.33, -2, 0.75, -2) else UDim2.new(0.5, -2, 0.8, -2)
						end
						local templateClone = Template:Clone()
						for _, child in scrollFrame:GetChildren() do
							if child:IsA("GuiObject") then
								child:Destroy()
							end
						end
						for _, itemType in ITEM_TYPES do
							local typeConfig = ItemTypeConfig[itemType]
							local itemsList = if typeof(offerData) ~= "table" then nil else offerData[typeConfig.OfferKey]
							if typeof(itemsList) == "table" then
								for _, item in itemsList do
									local itemCard = trove:Clone(templateClone)
									itemCard.Visible = true
									typeConfig.RenderCard(itemCard, item, trove)
									itemCard.Parent = scrollFrame
								end
							end
						end
						templateClone:Destroy()
					end
					local function buildClosedRow(tradeEntry, trove)
						local rowFrame = trove:Clone(closedTemplate)
						rowFrame.Visible = true
						local Btn = rowFrame.Btn
						local leftLabel = nil
						local rightLabel = nil
						for _, child in Btn:GetChildren() do
							if child:IsA("TextLabel") then
								if child.TextXAlignment == Enum.TextXAlignment.Right then
									rightLabel = child
								else
									leftLabel = child
								end
							end
						end
						if leftLabel then
							leftLabel.Text = `Trade with @{ tradeEntry.otherUsername or "?" }`
						end
						if rightLabel then
							local time = tradeEntry.time
							rightLabel.Text = if typeof(time) == "number" then os.date("%b %d, %I:%M %p", (math.floor(time))) else ""
						end
						Btn.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ tradeEntry.otherUserId }&w=100&h=100`
						return rowFrame, Btn
					end
					local function buildOpenedRow(tradeEntry, trove)
						local rowFrame = trove:Clone(openedTemplate)
						rowFrame.Visible = true
						local Btn = rowFrame.Btn
						Btn.You.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ LocalPlayer.UserId }&w=100&h=100`
						fillItemScroll(Btn.You.ItemsScroll, tradeEntry.you, trove)
						Btn.Other.Label.Text = `@{ tradeEntry.otherUsername or "?" }`
						Btn.Other.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ tradeEntry.otherUserId }&w=100&h=100`
						fillItemScroll(Btn.Other.ItemsScroll, tradeEntry.other, trove)
						return rowFrame, Btn
					end
					local historyTrove = Trove.new()
					local historyData = {}
					local historyLoaded = false
					local historyDirty = false
					local function renderHistoryRows()
						historyTrove:Clean()
						local closeOpenRow = nil
						for entryIdx, entry in historyData do
							local rowTrove = historyTrove:Extend()
							local isOpen = false
							local function draw()
								rowTrove:Clean()
								local rowFrame, rowBtn
								if isOpen then
									rowFrame, rowBtn = buildOpenedRow(entry, rowTrove)
								else
									rowFrame, rowBtn = buildClosedRow(entry, rowTrove)
								end
								rowFrame.LayoutOrder = entryIdx
								rowFrame.Parent = ScrollingFrame2
								rowTrove:Add(rowBtn.Activated:Connect(function()
									SoundController:PlaySound("Sounds.Sfx.Activated")
									if isOpen then
										isOpen = false
										closeOpenRow = nil
										draw()
										return
									end
									if closeOpenRow then
										closeOpenRow()
									end
									isOpen = true
									function closeOpenRow()
										isOpen = false
										draw()
									end
									draw()
								end))
							end
							draw()
						end
					end
					local function ensureHistory()
						if historyLoaded then
							if historyDirty then
								historyDirty = false
								renderHistoryRows()
							end
							return
						end
						local ok, result, historyList = pcall(function()
							return GetTradeHistoryFunc:InvokeServer("c3d9e8f1-2a4b-4c6d-8e0f-1a2b3c4d5e6f")
						end)
						if not ok or not result or typeof(historyList) ~= "table" then
							return
						end
						historyData = historyList
						historyLoaded = true
						historyDirty = false
						renderHistoryRows()
					end
					HistoryUpdatedEvent.OnClientEvent:Connect(function(newEntry)
						if not historyLoaded or typeof(newEntry) ~= "table" then
							return
						end
						table.insert(historyData, 1, newEntry)
						if Sections.History.Visible then
							renderHistoryRows()
							return
						end
						historyDirty = true
					end)
					local function setSection(sectionName: string)
						for _, child in Sections:GetChildren() do
							if child:IsA("GuiObject") then
								child.Visible = sectionName == child.Name
							end
						end
						for _, child in TradePlayerList.Btns:GetChildren() do
							if child:IsA("GuiButton") then
								child.BackgroundColor3 = if sectionName ~= BtnToSection[child.Name] then Color3.fromRGB(0, 0, 0) else Color3.fromRGB(0, 11, 158)
							end
						end
						if sectionName == "History" then
							task.spawn(ensureHistory)
						end
					end
					for _, child in TradePlayerList.Btns:GetChildren() do
						if child:IsA("GuiButton") then
							local sectionName = BtnToSection[child.Name]
							if sectionName then
								local animBtn = AnimatedButton.new(child)
								animBtn:Animate()
								animBtn.OnActivated:Connect(function()
									SoundController:PlaySound("Sounds.Sfx.Activated")
									setSection(sectionName)
								end)
							end
						end
					end
					Players2.SearchFrame.Visible = true
					renderServerPlayers()
					setSection("Players")
					Observers.observeTag("TradeMachinePrompt", function(promptPart)
						local connection = promptPart.Triggered:Connect(function()
							InterfaceController:Toggle("TradePlayerList")
						end)
						return function()
							connection:Disconnect()
						end
					end)
				end

				function TradeController._createInvites(_)
					local pendingInvites = {}
					CreateInviteEvent.OnClientEvent:Connect(function(inviteId: string, inviteData: {[any]: any})
						local ServerTimeNow = workspace:GetServerTimeNow()
						local timeRemaining = inviteData.expires - ServerTimeNow
						if timeRemaining <= 0 then
							return
						end
						local User = UsersAPI:GetUser(inviteData.from)
						if not User then
							return
						end
						local thread = nil
						local clone = Prompt:Clone()
						clone.Username.Text = `@{ User.Username } wants to trade with you`
						clone.Visible = true
						local removeNotification = CornerNotificationController:Add(clone)
						local inviteEntry = {
							id = inviteId,
							invite = inviteData,
							frame = clone
						}
						table.insert(pendingInvites, inviteEntry)
						local function destroy()
							local foundIdx = table.find(pendingInvites, inviteEntry)
							if not foundIdx then
								return
							end
							table.remove(pendingInvites, foundIdx)
							removeNotification()
						end
						local isAccepting = false
						clone.Yes.Activated:Connect(function()
							if isAccepting then
								return
							end
							SoundController:PlaySound("Sounds.Sfx.Activated")
							if workspace:GetServerTimeNow() > inviteData.expires then
								local foundIdx = table.find(pendingInvites, inviteEntry)
								if not foundIdx then
									return
								end
								table.remove(pendingInvites, foundIdx)
								removeNotification()
								return
							end
							isAccepting = true
							xpcall(function()
								local foundIdx = table.find(pendingInvites, inviteEntry)
								if foundIdx then
									table.remove(pendingInvites, foundIdx)
									removeNotification()
								end
								local success, errorMsg = AcceptInviteFunc:InvokeServer("57624f2b-8aa9-4974-bb7a-08f058af33ef", inviteId)
								if not success and typeof(errorMsg) == "string" then
									NotificationController:Error(errorMsg)
									return
								end
								if thread and coroutine.status(thread) == "suspended" then
									pcall(task.cancel, thread)
								end
							end, warn)
							isAccepting = false
						end)
						clone.No.Activated:Connect(function()
							if workspace:GetServerTimeNow() > inviteData.expires then
								local foundIdx = table.find(pendingInvites, inviteEntry)
								if not foundIdx then
									return
								end
								table.remove(pendingInvites, foundIdx)
								removeNotification()
								return
							end
							SoundController:PlaySound("Sounds.Sfx.Activated")
							DeclineInviteEvent:FireServer("99448380-7cdd-45ad-be4e-332ec6194ba6", inviteId)
							if thread and coroutine.status(thread) == "suspended" then
								pcall(task.cancel, thread)
							end
							local foundIdx = table.find(pendingInvites, inviteEntry)
							if not foundIdx then
								return
							end
							table.remove(pendingInvites, foundIdx)
							removeNotification()
						end)
						inviteEntry.frame = clone
						thread = task.delay(timeRemaining, destroy)
					end)
				end

				function TradeController._createLiveTrade(_)
					local tradeReplicator = ReplicatorClient.get(`Trade_{ LocalPlayer.UserId }`)
					InterfaceController:Register("TradeLiveTrade", TradeLiveTrade, "TopQuint"):Close()
					local closeBtnAnimated = AnimatedButton.new(TradeLiveTrade.Header.Close)
					closeBtnAnimated:Animate(nil, nil, 5)
					local playerSync = Synchronizer:Wait(LocalPlayer)
					if not playerSync then
						return
					end
					local liveTradeTrove = Trove.new()
					local function playTradeMachineAnimation()
						for _, tradeMachine in CollectionService:GetTagged("TradeMachine") do
							local Animate = tradeMachine:FindFirstChild("Animate")
							if Animate then
								local Animation = Animate:FindFirstChildWhichIsA("Animation")
								if Animation then
									local animController = tradeMachine:FindFirstChildWhichIsA("AnimationController") or tradeMachine:FindFirstChildWhichIsA("Humanoid")
									if animController then
										local Animator = animController:FindFirstChildWhichIsA("Animator")
										if Animator then
											local track = Animator:LoadAnimation(Animation)
											track.Looped = false
											track:Play()
										end
									end
								end
							end
						end
					end
					TradeCompletedEvent.OnClientEvent:Connect(playTradeMachineAnimation)
					local function cleanupTrade()
						InterfaceController:SetState("TradeLiveTrade", false)
						liveTradeTrove:Clean()
					end
					local pendingCompletedNotif = nil
					TradeNotificationEvent.OnClientEvent:Connect(function(notifType, data)
						if notifType == "completed" then
							pendingCompletedNotif = data
						elseif notifType == "canceled" then
							NotificationController:Error(("@%s canceled"):format(data))
						end
					end)
					local function showPendingCompletion()
						if pendingCompletedNotif then
							NotificationController:Notify(("<font color='#00ff00'>Trade with @%s completed! 🎉</font>"):format(pendingCompletedNotif))
							pendingCompletedNotif = nil
							task.delay(0.15, function()
								SoundController:PlaySound("Sounds.Sfx.Success")
							end)
						end
					end
					local activeTradeId = nil
					tradeReplicator:ListenRaw(function(rawData)
						if rawData == nil then
							activeTradeId = nil
							InterfaceController:SetState("TradeLiveTrade", false)
							liveTradeTrove:Clean()
							showPendingCompletion()
							return
						end
						local activeData = tradeReplicator:TryIndex({ "active", "data" })
						if not activeData then
							activeTradeId = nil
							InterfaceController:SetState("TradeLiveTrade", false)
							liveTradeTrove:Clean()
							showPendingCompletion()
							return
						end
						if activeTradeId == activeData.tradeId then
							InterfaceController:SetState("TradePlayerList", false)
							InterfaceController:SetState("TradeLiveTrade", true)
							return
						end
						liveTradeTrove:Clean()
						InterfaceController:SetState("TradePlayerList", false)
						InterfaceController:SetState("TradeLiveTrade", true)
						local __liveTradeId = activeData.tradeId
						local __setupOk, __setupErr = xpcall(function()
							local usersMap = tradeReplicator:TryIndex({ "active", "data", "users" }) or {}
							local localSlotKey = nil
							local otherSlotKey = nil
							local otherUserId = nil
							for slotKey, userId in usersMap do
								if userId == LocalPlayer.UserId then
									localSlotKey = slotKey
								else
									otherSlotKey = slotKey
									otherUserId = userId
								end
							end
							if not localSlotKey or not otherSlotKey or not otherUserId then
								return
							end
							local otherUsername = tradeReplicator:TryIndex({ "active", "data", "players", otherSlotKey, "username" }) or "???"
							TradeLiveTrade.Other.Username.Text = `@{ otherUsername }'s Offer`
							local otherDisplayUserId = tradeReplicator:TryIndex({ "active", "data", "players", otherSlotKey, "displayUserId" }) or otherUserId
							TradeLiveTrade.Other.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ otherDisplayUserId }&w=100&h=100`
							TradeLiveTrade.Your.Username.Text = "Your Offer"
							TradeLiveTrade.Your.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ LocalPlayer.UserId }&w=100&h=100`
							local Chat = TradeLiveTrade.Chat
							local NormalChat = Chat.NormalChat
							local RestrictedChat = Chat.RestrictedChat
							local TextBox = NormalChat.ChatBox.TextBox
							local ScrollingFrame = NormalChat.ScrollingFrame
							local ScrollingFrame3 = RestrictedChat.ScrollingFrame
							local Presets = RestrictedChat.Presets
							Chat.Header.Txt1.Text = "Trade Chat"
							local isRestrictedChat = false
							local chatCooldownEnd = 0
							local chatRenderTrove = liveTradeTrove:Extend()
							local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
							GetTextBoundsParams.RichText = false
							liveTradeTrove:Add(GetTextBoundsParams)
							local function getChatMessages()
								local rawChatData = tradeReplicator:TryIndex({ "active", "data", "chat" })
								if typeof(rawChatData) ~= "table" then
									return {}
								end
								local sortedKeys = {}
								for key in rawChatData do
									table.insert(sortedKeys, key)
								end
								table.sort(sortedKeys, function(a, b)
									return (tonumber(a) or 0) < (tonumber(b) or 0)
								end)
								local messages = {}
								for _, key in sortedKeys do
									local msg = rawChatData[key]
									if typeof(msg) == "table" and msg.u ~= nil and typeof(msg.t) == "string" then
										table.insert(messages, msg)
									end
								end
								return messages
							end
							local function fitChatRow(rowFrame, text: string)
								local rowLabel = rowFrame.Label
								local AbsoluteSizeX = rowLabel.AbsoluteSize.X
								if AbsoluteSizeX < 1 then
									return
								end
								local rowParent = rowFrame.Parent
								if not rowParent then
									return
								end
								local fontSize = math.clamp(math.round(rowParent.AbsoluteSize.Y * 0.12), 16, 30)
								GetTextBoundsParams.Font = rowLabel.FontFace
								GetTextBoundsParams.Size = fontSize
								GetTextBoundsParams.Width = AbsoluteSizeX
								GetTextBoundsParams.Text = text
								local ok, result = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams)
								local textHeight = if not ok then fontSize else result.Y
								if ok and AbsoluteSizeX < result.X and result.X > 0 then
									fontSize = math.max(1, (math.floor(fontSize * (AbsoluteSizeX / result.X))))
									GetTextBoundsParams.Size = fontSize
									local ok4, result4 = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams)
									if ok4 then
										textHeight = result4.Y
									end
								end
								rowLabel.TextScaled = false
								rowLabel.TextWrapped = true
								rowLabel.TextSize = fontSize
								local rowHeight = math.max(math.round(textHeight + fontSize), (math.round(fontSize * 2)))
								rowFrame.Size = UDim2.new(rowFrame.Size.X.Scale, rowFrame.Size.X.Offset, 0, rowHeight)
							end
							local function renderChat()
								chatRenderTrove:Clean()
								local activeScrollFrame = if not isRestrictedChat then ScrollingFrame else ScrollingFrame3
								local TemplateYou = activeScrollFrame.TemplateYou
								local TemplateOther = activeScrollFrame.TemplateOther
								TemplateYou.Visible = false
								TemplateOther.Visible = false
								local messages = getChatMessages()
								local maxMessages = tonumber(TradingFlags.SignMaxMessages:Get()) or 50
								local renderedRows = {}
								for i = math.max(1, #messages - maxMessages + 1), #messages do
									local msg = messages[i]
									local isLocalPlayer = tonumber(msg.u) == LocalPlayer.UserId
									local clone = chatRenderTrove:Clone(if not isLocalPlayer then TemplateOther else TemplateYou)
									clone.Name = `Message_{ i }`
									clone.LayoutOrder = i
									clone.Label.Text = msg.t
									clone.PlayerImage.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={ tonumber(msg.u) or msg.u }&w=100&h=100`
									clone.Visible = true
									clone.Parent = activeScrollFrame
									table.insert(renderedRows, {
										frame = clone,
										text = msg.t
									})
								end
								task.defer(function()
									for _, renderedRow in renderedRows do
										if renderedRow.frame.Parent then
											fitChatRow(renderedRow.frame, renderedRow.text)
										end
									end
									activeScrollFrame.CanvasPosition = Vector2.new(0, activeScrollFrame.AbsoluteCanvasSize.Y)
								end)
							end
							local function updateChatMode()
								local canFreeType = (not TradingFlags.SignFreeTypeDisabled:Get() and (tradeReplicator:TryIndex({ "active", "data", "players", localSlotKey, "canChat" }) and tradeReplicator:TryIndex({ "active", "data", "players", otherSlotKey, "canChat" }))) == true
								local chatEnabled = TradingFlags.SignEnabled:Get()
								local presetsEnabled = TradingFlags.SignPresetsEnabled:Get()
								if chatEnabled and (not canFreeType and not presetsEnabled) then
									chatEnabled = false
								end
								isRestrictedChat = not canFreeType
								Chat.Visible = chatEnabled
								NormalChat.Visible = chatEnabled and canFreeType
								RestrictedChat.Visible = chatEnabled and not canFreeType
								local isOnCooldown = os.clock() < chatCooldownEnd
								TextBox.ClearTextOnFocus = false
								TextBox.TextEditable = canFreeType and not isOnCooldown
								TextBox.Active = canFreeType
								TextBox.Interactable = canFreeType
								renderChat()
							end
							local function applyChatCooldown(isPreset: boolean)
								local cooldown = if not isPreset then TradingFlags.SignCooldown:Get() else TradingFlags.SignPresetCooldown:Get()
								chatCooldownEnd = os.clock() + cooldown
								updateChatMode()
								task.delay(cooldown, updateChatMode)
							end
							liveTradeTrove:Add(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
								local filteredText = string.gsub(TextBox.Text, "[\r\n]", "")
								local maxLength = TradingFlags.SignMaxLength:Get()
								if utf8.len(filteredText) == nil then
									filteredText = ""
								elseif maxLength < #filteredText then
									filteredText = string.sub(filteredText, 1, maxLength)
								end
								if filteredText ~= TextBox.Text then
									TextBox.Text = filteredText
								end
							end))
							liveTradeTrove:Add(TextBox.Focused:Connect(function()
								local cooldownRemaining = math.ceil(chatCooldownEnd - os.clock())
								if cooldownRemaining > 0 then
									TextBox:ReleaseFocus()
									NotificationController:Error(`Please wait { cooldownRemaining }s before sending another message`)
								end
							end))
							liveTradeTrove:Add(TextBox.FocusLost:Connect(function(enterPressed: boolean)
								if not enterPressed or not TradingFlags.SignEnabled:Get() then
									return
								end
								local TextBoxText = TextBox.Text
								if #TextBoxText == 0 then
									return
								end
								SoundController:PlaySound("Sounds.Sfx.Activated")
								SendChatMessageEvent:FireServer("b7e3f1a2-4c89-4d5e-a6b0-9f8e7d6c5b4a", TextBoxText)
								TextBox.Text = ""
								applyChatCooldown(false)
							end))
							local presetButtons = {}
							for _, child in Presets:GetChildren() do
								if child:IsA("GuiButton") then
									local TextLabel = child:FindFirstChildWhichIsA("TextLabel")
									table.insert(presetButtons, {
										button = child,
										label = TextLabel
									})
								end
							end
							table.sort(presetButtons, function(a, b)
								return a.button.Name < b.button.Name
							end)
							local function updatePresetLabels()
								local presets = TradingFlags.SignPresets:Get()
								for presetIdx, presetBtnInfo in presetButtons do
									local presetText = presets[presetIdx] or ""
									if presetBtnInfo.label then
										presetBtnInfo.label.Text = presetText
									else
										presetBtnInfo.button.Text = presetText
									end
									presetBtnInfo.button.Visible = presetText ~= ""
								end
							end
							updatePresetLabels()
							liveTradeTrove:Add((TradingFlags.SignPresets.Changed:Connect(updatePresetLabels)))
							for presetIdx, presetBtnInfo in presetButtons do
								liveTradeTrove:Add(presetBtnInfo.button.Activated:Connect(function()
									if not TradingFlags.SignEnabled:Get() or not TradingFlags.SignPresetsEnabled:Get() then
										return
									end
									local cooldownRemaining = math.ceil(chatCooldownEnd - os.clock())
									if cooldownRemaining > 0 then
										NotificationController:Error(`Please wait { cooldownRemaining }s before sending another message`)
										return
									end
									local presetText = TradingFlags.SignPresets:Get()[presetIdx]
									if not presetText or presetText == "" then
										return
									end
									SoundController:PlaySound("Sounds.Sfx.Activated")
									SendChatMessageEvent:FireServer("b7e3f1a2-4c89-4d5e-a6b0-9f8e7d6c5b4a", presetText)
									applyChatCooldown(true)
								end))
							end
							local chatRenderQueued = false
							local function queueRenderChat()
								if chatRenderQueued then
									return
								end
								chatRenderQueued = true
								task.defer(function()
									chatRenderQueued = false
									renderChat()
								end)
							end
							updateChatMode()
							liveTradeTrove:Add((TradingFlags.SignEnabled.Changed:Connect(updateChatMode)))
							liveTradeTrove:Add((TradingFlags.SignPresetsEnabled.Changed:Connect(updateChatMode)))
							liveTradeTrove:Add((TradingFlags.SignFreeTypeDisabled.Changed:Connect(updateChatMode)))
							liveTradeTrove:Add((TradingFlags.SignMaxMessages.Changed:Connect(renderChat)))
							liveTradeTrove:Add(tradeReplicator:Listen({ "active", "data", "players", localSlotKey, "canChat" }, updateChatMode))
							liveTradeTrove:Add(tradeReplicator:Listen({ "active", "data", "players", otherSlotKey, "canChat" }, updateChatMode))
							liveTradeTrove:Add(tradeReplicator:Observe({ "active", "data", "chat" }, function()
								queueRenderChat()
							end))
							liveTradeTrove:Add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueRenderChat))
							liveTradeTrove:Add(ScrollingFrame3:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueRenderChat))
							local function updateBaseSlots()
								local playersData = tradeReplicator:TryIndex({ "active", "data", "players" })
								if typeof(playersData) ~= "table" then
									return
								end
								local localPlayerData = playersData[localSlotKey]
								local otherPlayerData = playersData[otherSlotKey]
								if typeof(localPlayerData) ~= "table" or typeof(otherPlayerData) ~= "table" then
									return
								end
								local yourBrainrotCount
								if typeof(localPlayerData.offer) == "table" and typeof(localPlayerData.offer.brainrots) == "table" then
									yourBrainrotCount = 0
									for _ in localPlayerData.offer.brainrots do
										yourBrainrotCount += 1
									end
								else
									yourBrainrotCount = 0
								end
								local otherBrainrotCount
								if typeof(otherPlayerData.offer) == "table" and typeof(otherPlayerData.offer.brainrots) == "table" then
									otherBrainrotCount = 0
									for _ in otherPlayerData.offer.brainrots do
										otherBrainrotCount += 1
									end
								else
									otherBrainrotCount = 0
								end
								local baseData = Bases[playerSync:Get("Rebirth")]
								if baseData then
									local MaxAnimals = baseData.MaxAnimals
									local animalPodiums = playerSync:Get("AnimalPodiums")
									local podiumCount = 0
									if animalPodiums then
										for i = 1, MaxAnimals do
											if animalPodiums[i] ~= "Empty" and animalPodiums[i] ~= nil then
												podiumCount += 1
											end
										end
									end
									local yourProjectedSlots = podiumCount - yourBrainrotCount + otherBrainrotCount
									TradeLiveTrade.Your.BaseSlots.Text = `{ yourProjectedSlots }/{ MaxAnimals }`
									TradeLiveTrade.Your.BaseSlots.TextColor3 = if not (MaxAnimals < yourProjectedSlots) then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(255, 70, 70)
								end
								local maxSlots = otherPlayerData.maxSlots
								local emptySlots = otherPlayerData.emptySlots
								if typeof(maxSlots) == "number" and typeof(emptySlots) == "number" then
									local otherProjectedSlots = maxSlots - emptySlots - otherBrainrotCount + yourBrainrotCount
									TradeLiveTrade.Other.BaseSlots.Text = `{ otherProjectedSlots }/{ maxSlots }`
									TradeLiveTrade.Other.BaseSlots.TextColor3 = if not (maxSlots < otherProjectedSlots) then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(255, 70, 70)
								end
							end
							liveTradeTrove:Add(tradeReplicator:Observe({ "active", "data", "players" }, updateBaseSlots))
							liveTradeTrove:Add(playerSync:OnChanged("AnimalPodiums", updateBaseSlots))
							local function updateState()
								local lastChange = tradeReplicator:TryIndex({ "active", "data", "lastChange" })
								local playersData = tradeReplicator:TryIndex({ "active", "data", "players" })
								local usersMap = tradeReplicator:TryIndex({ "active", "data", "users" })
								if typeof(lastChange) ~= "number" or (typeof(playersData) ~= "table" or typeof(usersMap) ~= "table") then
									return
								end
								local anyOfferHasItems = false
								for _, playerData in playersData do
									if typeof(playerData.offer) == "table" then
										for _, itemType in ITEM_TYPES do
											local offerItems = playerData.offer[ItemTypeConfig[itemType].OfferKey]
											if typeof(offerItems) == "table" and next(offerItems) then
												anyOfferHasItems = true
												break
											end
										end
										if anyOfferHasItems then
											break
										end
									end
								end
								local allReady = true
								for _, playerData in playersData do
									if not playerData.ready then
										allReady = false
										break
									end
								end
								local allAccepted = true
								for _, playerData in playersData do
									if not playerData.accepted then
										allAccepted = false
										break
									end
								end
								local localPlayerData = playersData[table.find(usersMap, LocalPlayer.UserId)]
								local timeLeft = lastChange + 5 - workspace:GetServerTimeNow()
								local canInteract = timeLeft <= 0 and if not allReady then not not anyOfferHasItems and (not localPlayerData or not localPlayerData.ready) else not localPlayerData or not localPlayerData.accepted
								Spr.target(TradeLiveTrade.Other.ReadyButton, 1, 5, {
									BackgroundColor3 = if not canInteract then Color3.fromRGB(0, 64, 255) else Color3.fromRGB(81, 158, 86)
								})
								TradeLiveTrade.Other.Timer.Text = if not allAccepted and not tradeReplicator:TryIndex({ "active", "data", "isProcessing" }) then if not (timeLeft <= 0) then `⏰{ math.floor(timeLeft * 10) / 10 }s Left` else "" else "Processing..."
								end
								local timerTrove = liveTradeTrove:Extend()
								liveTradeTrove:Add(tradeReplicator:Observe({ "active", "data", "lastChange" }, function(lastChange: number)
									timerTrove:Clean()
									if lastChange == nil then
										return
									end
									timerTrove:Add(Timer.Simple(0.1, function()
										updateState()
									end, true))
								end))
								local inventoryTroves = {}
								local inventoryFrames = {}
								local selectedItems = {}
								for _, itemType in ITEM_TYPES do
									inventoryTroves[itemType] = liveTradeTrove:Extend()
									inventoryFrames[itemType] = {}
									selectedItems[itemType] = {}
								end
								local offersTrove = liveTradeTrove:Extend()
								local activeTab = ITEM_TYPES[1]
								local selectionVisible = true
								local function isTypeActive(typeName: string)
									return typeName == "Brainrot"
								end
								local function isSelectionVisible(typeName: string, refKey: string)
									return selectionVisible and (typeName == activeTab or selectedItems[typeName][refKey] == true)
								end
								local function applySelectionColor(typeName: string, frameInfo: {[any]: any})
									local isSelected = selectedItems[typeName][frameInfo.refKey] == true
									frameInfo.frame.Spacer.BackgroundColor3 = if not isSelected then Color3.fromRGB(247, 0, 255) else Color3.fromRGB(247, 0, 255)
									frameInfo.frame.Spacer.UIStroke.Color = if not isSelected then Color3.fromRGB(247, 0, 255) else Color3.fromRGB(0, 255, 0)
									local frame = frameInfo.frame
									local refKey = frameInfo.refKey
									frame.Visible = selectionVisible and (typeName == activeTab or selectedItems[typeName][refKey] == true)
								end
								local function updateSelectionColors()
									for typeName, frames in inventoryFrames do
										for _, frameInfo in frames do
											applySelectionColor(typeName, frameInfo)
										end
									end
								end
								local function setSelectionFramesVisible(visible: boolean)
									selectionVisible = visible
									for typeName, frames in inventoryFrames do
										for _, frameInfo in frames do
											local frame = frameInfo.frame
											local refKey = frameInfo.refKey
											frame.Visible = selectionVisible and (typeName == activeTab or selectedItems[typeName][refKey] == true)
										end
									end
								end
								local function renderInventory(typeName: string)
									local typeConfig = ItemTypeConfig[typeName]
									local frameMap = inventoryFrames[typeName]
									local inventoryTrove = inventoryTroves[typeName]
									local ScrollingFrame4 = TradeLiveTrade.Your.ScrollingFrame
									local currentKeys = {}
									for _, item in (typeConfig.FetchInventory(playerSync)) do
										currentKeys[item.SelKey] = true
										local existingFrameInfo = frameMap[item.SelKey]
										if not existingFrameInfo or existingFrameInfo.contentKey ~= item.ContentKey then
											if existingFrameInfo then
												existingFrameInfo.trove:Clean()
												frameMap[item.SelKey] = nil
											end
											local itemTrove = inventoryTrove:Extend()
											local clone = itemTrove:Clone(ScrollingFrame4.Template)
											clone.Name = `Selection_{ typeName }_{ item.SelKey }`
											local RefKey = item.RefKey
											clone.Visible = selectionVisible and (typeName == activeTab or selectedItems[typeName][RefKey] == true)
											typeConfig.RenderCard(clone, item.Record, itemTrove)
											clone.Parent = ScrollingFrame4
											local isToggling = false
											local RefKey2 = item.RefKey
											local Ref = item.Ref
											itemTrove:Add(clone.Spacer.Activated:Connect(function()
												if isToggling then
													return
												end
												isToggling = true
												SoundController:PlaySound("Sounds.Sfx.Activated")
												if selectedItems[typeName][RefKey2] then
													xpcall(typeConfig.Remove, warn, Ref)
												else
													xpcall(typeConfig.Add, warn, Ref)
												end
												isToggling = false
											end))
											local frameInfo = {
												frame = clone,
												trove = itemTrove,
												refKey = RefKey2,
												contentKey = item.ContentKey
											}
											frameMap[item.SelKey] = frameInfo
											applySelectionColor(typeName, frameInfo)
										end
									end
									for k, v in pairs(frameMap) do
										if not currentKeys[k] then
											v.trove:Clean()
											frameMap[k] = nil
										end
									end
								end
								local function renderAllInventories()
									for _, typeName in ITEM_TYPES do
										renderInventory(typeName)
									end
								end
								local function renderOffers(offersTroveArg, offerFrames: {[any]: any}, scrollFrame, offer)
									for _, typeName in ITEM_TYPES do
										if not offerFrames[typeName] then
											offerFrames[typeName] = {}
										end
										local typeFrames = offerFrames[typeName]
										do
											local typeConfig = ItemTypeConfig[typeName]
											local currentOfferKeys = {}
											for offerKey, offerItem in (typeConfig.ReadOffer(offer)) do
												currentOfferKeys[offerKey] = true
												if not typeFrames[offerKey] then
													local cardTrove = offersTroveArg:Extend()
													local clone = cardTrove:Clone(scrollFrame.Template)
													clone.LayoutOrder = offerItem.Order or 0
													clone.Visible = true
													typeConfig.RenderCard(clone, offerItem, cardTrove)
													clone.Parent = scrollFrame
													typeFrames[offerKey] = {
														trove = cardTrove
													}
												end
											end
											for k, v in pairs(typeFrames) do
												if not currentOfferKeys[k] then
													v.trove:Clean()
													typeFrames[k] = nil
												end
											end
										end
									end
								end
								local function clearOfferStates(offerFrames: {[any]: any})
									for _, typeFrames in offerFrames do
										for k, v in pairs(typeFrames) do
											v.trove:Clean()
											typeFrames[k] = nil
										end
									end
								end
								local function setTab(tabType: string)
									if not ItemTypeConfig[tabType] then
										return
									end
									activeTab = tabType
									for _, child in TradeLiveTrade["Side Buttons"]:GetChildren() do
										if child:IsA("GuiButton") then
											child.BackgroundColor3 = if tabType ~= TabButtonToType[child.Name] then Color3.fromRGB(64, 86, 97) else Color3.fromRGB(81, 158, 86)
										end
									end
									for typeName, frames in inventoryFrames do
										for _, frameInfo in frames do
											local frame = frameInfo.frame
											local refKey = frameInfo.refKey
											frame.Visible = selectionVisible and (typeName == activeTab or selectedItems[typeName][refKey] == true)
										end
									end
								end
								for _, child in TradeLiveTrade["Side Buttons"]:GetChildren() do
									if child:IsA("GuiButton") then
										local tabType = TabButtonToType[child.Name]
										if not tabType then
											child.Visible = false
										else
											child.Visible = true
											local animBtn = AnimatedButton.new(child)
											animBtn:Animate()
											liveTradeTrove:Add(animBtn)
											liveTradeTrove:Add(animBtn.OnActivated:Connect(function()
												setTab(tabType)
											end))
										end
									end
								end
								local offerFrames = {}
								local wasAllReady = false
								liveTradeTrove:Add(tradeReplicator:Observe({ "active", "data", "players" }, function(playersData)
									for _, typeName in ITEM_TYPES do
										selectedItems[typeName] = {}
									end
									if typeof(playersData) ~= "table" then
										wasAllReady = false
										clearOfferStates(offerFrames)
										setSelectionFramesVisible(true)
										updateSelectionColors()
										TradeLiveTrade["Side Buttons"].Visible = true
										return
									end
									local localPlayerTradeData = playersData[localSlotKey]
									local localOffer = if typeof(localPlayerTradeData) ~= "table" or typeof(localPlayerTradeData.offer) ~= "table" then {} else localPlayerTradeData.offer
									for _, typeName in ITEM_TYPES do
										local selectedKeys = {}
										for key in ItemTypeConfig[typeName].ReadOffer(localOffer) do
											selectedKeys[key] = true
										end
										selectedItems[typeName] = selectedKeys
									end
									local allReady = true
									for _, playerData in playersData do
										if not playerData.ready then
											allReady = false
											break
										end
									end
									local allAccepted = true
									for _, playerData in playersData do
										if not playerData.accepted then
											allAccepted = false
											break
										end
									end
									TradeLiveTrade["Side Buttons"].Visible = not allAccepted
									TradeLiveTrade.Your.Ready.Visible = not not localPlayerTradeData.accepted or not allReady and localPlayerTradeData.ready
									TradeLiveTrade.Your.Ready.Label.Text = not localPlayerTradeData.accepted and "Ready!" or "Confirmed!"
									if allReady then
										setSelectionFramesVisible(false)
										renderOffers(offersTrove, offerFrames, TradeLiveTrade.Your.ScrollingFrame, localOffer)
									else
										if wasAllReady then
											clearOfferStates(offerFrames)
										end
										setSelectionFramesVisible(true)
										updateSelectionColors()
									end
									wasAllReady = allReady
								end))
								for _, typeName in ITEM_TYPES do
									renderInventory(typeName)
								end
								setTab(ITEM_TYPES[1])
								liveTradeTrove:Add(playerSync:OnChanged("AnimalAddedOrRemoved", function()
									renderInventory("Brainrot")
								end))
								liveTradeTrove:Add(playerSync:OnChanged("AnimalPodiums", function()
									renderInventory("Brainrot")
								end, true))
								liveTradeTrove:Add(playerSync:OnChanged("BaseSkinInventory", function()
									renderInventory("BaseSkin")
								end, true))
								liveTradeTrove:Add(playerSync:OnDictionaryInserted("BaseSkinInventory", function()
									renderInventory("BaseSkin")
								end))
								liveTradeTrove:Add(playerSync:OnDictionaryRemoved("BaseSkinInventory", function()
									renderInventory("BaseSkin")
								end))
								liveTradeTrove:Add(playerSync:OnChanged("GearInventory", function()
									renderInventory("Gear")
								end, true))
								liveTradeTrove:Add(playerSync:OnDictionaryInserted("GearInventory", function()
									renderInventory("Gear")
								end))
								liveTradeTrove:Add(playerSync:OnDictionaryRemoved("GearInventory", function()
									renderInventory("Gear")
								end))
								liveTradeTrove:Add(playerSync:OnDictionaryInserted("Items", function()
									renderInventory("Gear")
								end))
								liveTradeTrove:Add(playerSync:OnDictionaryRemoved("Items", function()
									renderInventory("Gear")
								end))
								local isCancelling = false
								local function cancelTrade()
									if isCancelling then
										return
									end
									isCancelling = true
									SoundController:PlaySound("Sounds.Sfx.Activated")
									warn("[TDBG] CANCEL clicked, firing server")
									CancelTradeEvent:FireServer("9d1937e7-6262-487b-98be-af45618270c9")
									isCancelling = false
								end
								liveTradeTrove:Add(TradeLiveTrade.Other.Cancel.Activated:Connect(cancelTrade))
								liveTradeTrove:Add(closeBtnAnimated.OnActivated:Connect(cancelTrade))
								TradeLiveTrade.Other.ReadyButton.Txt.Text = "READY"
								local readyButton = AnimatedButton.new(TradeLiveTrade.Other.ReadyButton)
								liveTradeTrove:Add(readyButton)
								readyButton:Animate()
								liveTradeTrove:Add(readyButton.OnActivated:Connect(function()
									warn("[TDBG] READY/ACCEPT button clicked")
									local lastChange = tradeReplicator:TryIndex({ "active", "data", "lastChange" })
									if typeof(lastChange) == "number" and workspace:GetServerTimeNow() < lastChange + 5 then
										return
									end
									local playersData = tradeReplicator:TryIndex({ "active", "data", "players" })
									if typeof(playersData) ~= "table" then
										return
									end
									local allReady = true
									for _, playerData in playersData do
										if not playerData.ready then
											allReady = false
											break
										end
									end
									warn("[TDBG] ready decision: lastChange=", lastChange, " playersType=", typeof(playersData), " allReady=", allReady)
									if allReady then
										AcceptEvent:FireServer("918ee0f5-e98f-413f-b76e-baee47b021cb")
										return
									end
									ReadyEvent:FireServer("d73acf93-6f32-44df-b813-0f6b32c7afd9")
								end))
								local otherPlayerTroves = {}
								local otherOfferFrames = {}
								liveTradeTrove:Add(tradeReplicator:Observe({ "active", "data", "players" }, function(playersData)
									if typeof(playersData) ~= "table" then
										return
									end
									local allReady = true
									for _, playerData in playersData do
										if not playerData.ready then
											allReady = false
											break
										end
									end
									warn("[TDBG] other-players observe FIRED, slots=", #playersData)
									TradeLiveTrade.Other.ReadyButton.Txt.Text = not allReady and "READY" or "ACCEPT"
									for slotKey, playerTradeData in playersData do
										local num = tonumber(slotKey)
										if num and num ~= localSlotKey then
											local ScrollingFrame5 = TradeLiveTrade.Other.ScrollingFrame
											if not otherPlayerTroves[slotKey] then
												otherPlayerTroves[slotKey] = liveTradeTrove:Extend()
												otherOfferFrames[slotKey] = {}
											end
											TradeLiveTrade.Other.Ready.Visible = not not playerTradeData.accepted or not allReady and playerTradeData.ready
											TradeLiveTrade.Other.Ready.Label.Text = not playerTradeData.accepted and "Ready!" or "Confirmed!"
											warn("[TDBG] render OTHER slot ", slotKey, " brainrots=", (playerTradeData.offer and playerTradeData.offer.brainrots) and #playerTradeData.offer.brainrots or 0)
											renderOffers(otherPlayerTroves[slotKey], otherOfferFrames[slotKey], ScrollingFrame5, playerTradeData.offer or {})
										end
									end
								end))
								activeTradeId = __liveTradeId
							end, debug.traceback)
						if not __setupOk then
							warn("[TDBG] LiveTrade setup failed; retrying on next update -> ", __setupErr)
							activeTradeId = nil
						end
					end)
				end

				function TradeController.Start(self)
					task.spawn(self._createPlayerList, self)
					task.spawn(self._createInvites, self)
					task.spawn(self._createLiveTrade, self)
				end

				return TradeController