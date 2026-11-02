game:GetService("ServerScriptService")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService     = game:GetService("SocialService")
local HttpService       = game:GetService("HttpService")
local Players           = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CreateTween  = require(ReplicatedStorage.Packages.CreateTween)
local Observers    = require(ReplicatedStorage.Packages.Observers)
local UsersAPI     = require(ReplicatedStorage.Shared.UsersAPI)
require(ReplicatedStorage.Packages.Promise)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove  = require(ReplicatedStorage.Packages.Trove)
local Net    = require(ReplicatedStorage.Packages.Net)
require(ReplicatedStorage.Packages.Spr)

local NotificationController       = require(ReplicatedStorage.Controllers.NotificationController)
local ConfirmationController       = require(ReplicatedStorage.Controllers.ConfirmationController)
local InterfaceController          = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController              = require(ReplicatedStorage.Controllers.SoundController)
local CornerNotificationController = require(ReplicatedStorage.Controllers.CornerNotificationController)

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local ServerData     = require(ReplicatedStorage.Datas.ServerData)
local Friends   = require(ReplicatedStorage.Shared.Friends)
require(ReplicatedStorage.Shared.Updates)

local LocalPlayer  = Players.LocalPlayer
local PlayerGui    = LocalPlayer.PlayerGui
local PlayerListUI = PlayerGui:WaitForChild("DuelsMachinePlayerList").DuelsMachinePlayerList
local PromptUI     = PlayerGui:WaitForChild("DuelsMachinePrompt").DuelsMachinePrompt

local ReconnectWarnRemote = Net:RemoteEvent("DuelsMachineService/ReconnectWarn")
local CreateInviteRemote  = Net:RemoteEvent("DuelsMachineService/CreateInvite")
local ReconnectRemote     = Net:RemoteEvent("DuelsMachineService/Reconnect")
local AcceptInviteFunc    = Net:RemoteFunction("DuelsMachineService/AcceptInvite")
local SearchUserFunc      = Net:RemoteFunction("DuelsMachineService/SearchUser")
local InviteFunc          = Net:RemoteFunction("DuelsMachineService/Invite")
local DuelsMachineController = {

	IsEnabled = function(_)
		local enabled = not (FFlags:GetInstant("DuelsMachineService/Disabled") or ServerData.IsNewPlayersServer())
		if enabled then
			local notDuelsOrTsunami = not (ServerData.IsDuelsServer() or ServerData.IsTsunamiServer())
			enabled = notDuelsOrTsunami and true or notDuelsOrTsunami
		end
		return enabled
	end,

	SendInvite = function(_, userId)
		return InviteFunc:InvokeServer(userId)
	end,
	_createPlayerList = function(_)
		local window = InterfaceController:Register("DuelsMachinePlayerList", PlayerListUI, "TopQuint")
		window:AttachCloseButton(PlayerListUI.Header.Close)
		window:Close()

		local searchBox       = PlayerListUI.SearchFrame.SearchBox
		local currentTab      = nil
		local activeCoroutine = nil

		local function updatePlayerEntry(listParent, playerInfo, sortOrder, existingFrame)
			local frame = existingFrame or listParent:FindFirstChild(("%s_%s"):format(playerInfo.username, playerInfo.userId))
			if not frame then return end

			frame.Fill.Status2.Text = playerInfo.inGame and "Online" or (playerInfo.isFriend and "Away" or "Offline")

			local statusColor
			if playerInfo.inGame then
				statusColor = Color3.fromRGB(86, 211, 74)
			elseif playerInfo.isFriend then
				statusColor = Color3.fromRGB(239, 225, 69)
			else
				statusColor = Color3.fromRGB(211, 38, 38)
			end
			frame.Fill.Status2.TextColor3 = statusColor
			frame.Fill.PlayerImage.Status.BackgroundColor3 = statusColor

			local canSend = (playerInfo.inGame and playerInfo.canInvite) or playerInfo.isFriend
			frame.Fill.Send.BackgroundColor3 = canSend
				and Color3.fromRGB(81, 158, 86)
				or  Color3.fromRGB(112, 112, 112)

			frame.LayoutOrder = playerInfo.inGame and sortOrder or sortOrder + 300
		end

		local function createPlayerEntry(listParent, playerInfo, sortOrder)
			local frameName = ("%s_%s"):format(playerInfo.username, playerInfo.userId)
			local frame = PlayerListUI.LocalList.UIListLayout.Template:Clone()
			frame.Name = frameName
			frame.Fill.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(playerInfo.userId)
			frame.Fill.Username.Text = ("@%s"):format(playerInfo.username)
			updatePlayerEntry(listParent, playerInfo, sortOrder, frame)
			frame.Visible = true
			frame.Parent = listParent

			local isSending = false
			frame.Fill.Send.Activated:Connect(function()
				if not playerInfo.canInvite or isSending then return end
				SoundController:PlaySound("Sounds.Sfx.Activated")

				if playerInfo.inGame then
					isSending = true
					xpcall(function()
						local success, errorMsg = InviteFunc:InvokeServer(playerInfo.userId)
						if not success and typeof(errorMsg) == "string" then
							NotificationController:Error(errorMsg)
						end
						frame.Fill.Send.Txt.Text = success and "SENT!" or "FAILED"
						task.wait(5)
						frame.Fill.Send.Txt.Text = "SEND"
					end, warn)
					isSending = false

				elseif playerInfo.isFriend then
					local ok, canSendInvite = pcall(function()
						return SocialService:CanSendGameInviteAsync(LocalPlayer)
					end)
					if not (ok and canSendInvite) then return end

					local options = Instance.new("ExperienceInviteOptions")
					options.InviteUser    = playerInfo.userId
					options.PromptMessage = ("Invite %s to a duel"):format(playerInfo.username)
					options.LaunchData    = HttpService:JSONEncode({
						type   = "DuelsInvite",
						sender = LocalPlayer.UserId
					})
					SocialService:PromptGameInvite(LocalPlayer, options)
				end
			end)

			return frame
		end
		local trove = Trove.new()

		local function refreshList()
			local thisCoroutine = coroutine.running()
			activeCoroutine = thisCoroutine
			trove:Clean()

			if currentTab == "Global" then return end

			local inGameFriends = Friends:GetInGameFriends(LocalPlayer)
			local entries = {}

			if currentTab == "Server" then
				for _, player in Players:GetPlayers() do
					if player ~= LocalPlayer then
						table.insert(entries, {
							username  = player.Name,
							userId    = player.UserId,
							inGame    = true,
							canInvite = true,
							isFriend  = table.find(inGameFriends, player) ~= nil
						})
					end
				end

			elseif currentTab == "Friends" then
				local ok, onlineFriends = Friends:GetOnlineFriends()
				if ok and typeof(onlineFriends) == "table" then
					for _, friend in onlineFriends do
						local isInOurGame = friend.PlaceId and table.find(ServerData.AllPlaces, friend.PlaceId) ~= nil
						table.insert(entries, {
							username  = friend.UserName,
							userId    = friend.VisitorId,
							inGame    = isInOurGame,
							canInvite = true,
							isFriend  = true
						})
					end
				end
			end

			if thisCoroutine == activeCoroutine then
				for i, entry in entries do
					trove:Add(createPlayerEntry(PlayerListUI.LocalList, entry, i))
				end
			end
		end

		local function switchTab(tabName)
			if currentTab == tabName then return end
			currentTab = tabName
			searchBox.Text = ""

			PlayerListUI.LocalList.Visible   = tabName ~= "Global"
			PlayerListUI.GlobalList.Visible  = tabName == "Global"
			PlayerListUI.SearchFrame.Visible = tabName == "Global"

			for _, btn in PlayerListUI.Btns:GetChildren() do
				if btn:IsA("GuiButton") then
					btn.BackgroundColor3 = (currentTab == btn.Name)
						and Color3.fromRGB(81, 158, 86)
						or  Color3.fromRGB(115, 152, 172)
				end
			end

			refreshList()
		end
		Players.PlayerAdded:Connect(function()
			if currentTab == "Server" then refreshList() end
		end)
		Players.PlayerRemoving:Connect(function()
			if currentTab == "Server" then refreshList() end
		end)

		searchBox.FocusLost:Connect(function(enterPressed)
			if not enterPressed then return end

			local query = searchBox.Text
			searchBox.TextEditable = false
			searchBox.Active = false
			searchBox.Text = "..."
			trove:Clean()

			local ok, userId = pcall(function()
				return Players:GetUserIdFromNameAsync(query)
			end)
			if not ok or typeof(userId) ~= "number" then
				searchBox.Text = (typeof(userId) == "string" and string.find(userId, "Unknown user"))
					and "User not found!"
					or  "Failed to search for user, try again later"
				task.wait(5)
				searchBox.Text = ""
				searchBox.TextEditable = true
				searchBox.Active = true
				return false
			end

			local serverOk, found, isInGame, canInvite = pcall(function()
				return SearchUserFunc:InvokeServer(userId)
			end)
			if not (serverOk and found) then
				local errorMsg = typeof(found) == "string" and found
					or typeof(isInGame) == "string" and isInGame
					or "Failed to search for user, try again later"
				searchBox.Text = errorMsg
				task.wait(5)
				searchBox.Text = ""
				searchBox.TextEditable = true
				searchBox.Active = true
				return false
			end

			local nameOk, userData = pcall(function()
				return UsersAPI:GetUser(userId)
			end)
			local displayName = (nameOk and typeof(userData) == "table" and userData.IsLoaded)
				and userData.Username
				or  string.upper(query)

			trove:Add(createPlayerEntry(PlayerListUI.GlobalList, {
				userId    = userId,
				username  = displayName,
				inGame    = isInGame,
				canInvite = canInvite,
			}, 1))

			searchBox.Text = ""
			task.wait(5)
			searchBox.TextEditable = true
			searchBox.ClearTextOnFocus = true
			searchBox.Active = true
		end)

		for _, btn in PlayerListUI.Btns:GetChildren() do
			if btn:IsA("GuiButton") then
				local tabName = btn.Name
				local button = AnimatedButton.new(btn)
				button:Animate()
				button.OnActivated:Connect(function()
					switchTab(tabName)
				end)
			end
		end

		switchTab("Server")

		Observers.observeTag("DuelsMachinePrompt", function(prompt)
			local conn = prompt.Triggered:Connect(function()
				InterfaceController:Toggle("DuelsMachinePlayerList")
			end)
			return function()
				conn:Disconnect()
			end
		end)
	end,
	_createInvites = function(_)
		local activeInvites = {}

		CreateInviteRemote.OnClientEvent:Connect(function(inviteId, inviteData)
			local serverTime = workspace:GetServerTimeNow()
			local timeLeft   = inviteData.expires - serverTime
			if timeLeft <= 0 then return end

			local senderData = UsersAPI:GetUser(inviteData.from)
			if not senderData then return end

			local frame = PromptUI.InviteTemplate:Clone()
			frame.Username.Text = ("@%s invited you to a Duel!"):format(senderData.Username)
			frame.Visible = true

			local removeNotification = CornerNotificationController:Add(frame)
			local inviteEntry = { id = inviteId, invite = inviteData, frame = frame }
			table.insert(activeInvites, inviteEntry)

			local cleanupTask = nil

			local function removeInvite()
				local index = table.find(activeInvites, inviteEntry)
				if index then
					table.remove(activeInvites, index)
					removeNotification()
				end
			end

			CreateTween(frame.Fill, TweenInfo.new(timeLeft), {
				Size = UDim2.fromScale(0, frame.Fill.Size.Y.Scale)
			})

			local isAccepting = false

			frame.Yes.Activated:Connect(function()
				if isAccepting then return end
				SoundController:PlaySound("Sounds.Sfx.Activated")

				if workspace:GetServerTimeNow() > inviteData.expires then
					removeInvite()
					return
				end

				isAccepting = true
				xpcall(function()
					local success, errorMsg = AcceptInviteFunc:InvokeServer(inviteId)
					if success or typeof(errorMsg) ~= "string" then
						if cleanupTask and coroutine.status(cleanupTask) == "suspended" then
							pcall(task.cancel, cleanupTask)
						end
						removeInvite()
					else
						NotificationController:Error(errorMsg)
					end
				end, warn)
				isAccepting = false
			end)

			frame.No.Activated:Connect(function()
				if workspace:GetServerTimeNow() > inviteData.expires then
					removeInvite()
					return
				end
				SoundController:PlaySound("Sounds.Sfx.Activated")
				if cleanupTask and coroutine.status(cleanupTask) == "suspended" then
					pcall(task.cancel, cleanupTask)
				end
				removeInvite()
			end)

			inviteEntry.frame = frame
			cleanupTask = task.delay(timeLeft, removeInvite)
		end)

		ReconnectRemote.OnClientEvent:Connect(function(opponentUserId)
			local _, opponentData = pcall(function()
				return UsersAPI:GetUser(opponentUserId)
			end)
			if not (opponentData and opponentData.IsLoaded) then return end

			local playerChannel = Synchronizer:Wait(LocalPlayer)
			if not playerChannel then return end

			local wantsToReconnect = ConfirmationController:Show(
				("You disconnected an active duel with @%s"):format(opponentData.Username),
				600,
				"ReconnectTemplate"
			)

			if not wantsToReconnect then
				if playerChannel:Get("DuelsReconnectWarn") then return end
				local confirmLeave = ConfirmationController:Show(
					"Leaving the duel will count as a forfeit and you will lose your brainrot! Are you sure?",
					60,
					"WarningTemplate"
				)
				if confirmLeave then
					ReconnectWarnRemote:FireServer()
					return
				end
			end

			ReconnectRemote:FireServer(wantsToReconnect)
		end)
	end,

	Start = function(self)
		task.spawn(self._createPlayerList, self)
		task.spawn(self._createInvites, self)
	end
}

task.spawn(function()
	local openButton = PlayerGui:WaitForChild("LeftCenter"):WaitForChild("LeftCenter").Buttons:WaitForChild("DuelsMachinePlayerList")
	local animatedButton = AnimatedButton.new(openButton)
	animatedButton:Animate()
	animatedButton.OnActivated:Connect(function()
		InterfaceController:Toggle("DuelsMachinePlayerList")
	end)
end)

return DuelsMachineController