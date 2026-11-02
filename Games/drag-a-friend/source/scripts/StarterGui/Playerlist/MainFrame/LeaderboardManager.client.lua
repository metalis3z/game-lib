local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VoiceChatService = game:GetService("VoiceChatService")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local MarketplaceService = game:GetService("MarketplaceService")

local MainFrame = script.Parent
local MainScroll = MainFrame.MainScroll
local PlayerList = MainScroll.PlayerList
local Information = MainFrame.Information
local UserTemplate = script.User

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local function CheckGamePassAndSetIcon(player, icon)
	local GAMEPASS_ID = 1152457093

	local success, hasGamePass = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
	end)

	if success and hasGamePass then
		icon.Image = "rbxassetid://15024010866"
		icon.Visible = true
	end
end

local function HandleFriendAction(targetPlayer)
	local localPlayer = Players.LocalPlayer
	if localPlayer:IsFriendsWith(targetPlayer.UserId) then
		StarterGui:SetCore("PromptUnfriend", targetPlayer)
	else
		StarterGui:SetCore("PromptSendFriendRequest", targetPlayer)
	end
end

local function HandleBlockAction(targetPlayer)
	StarterGui:SetCore("PromptBlockPlayer", targetPlayer)
end

local function ShowInformationForPlayer(player)
	local success, content, isReady = pcall(function()
		return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)

	Information.User.PlayerIcon.Image = success and isReady and content or "rbxassetid://0"
	Information.User.DisplayName.Text = player.DisplayName
	Information.User.Username.Text = "@"..player.Name

	Information.User.Icon.Visible = player.MembershipType == Enum.MembershipType.Premium

	local areFriends = Players.LocalPlayer:IsFriendsWith(player.UserId)
	Information.User.Icon2.Visible = areFriends

	local GAMEPASS_ID = 1152457093

	local success, hasGamePass = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
	end)
	Information.User.Icon3.Visible = success and hasGamePass or false

	local success, voiceEnabled = pcall(function()
		return VoiceChatService:IsVoiceEnabledForUserIdAsync(player.UserId)
	end)
	Information.MultiOptions.VoiceUser.Visible = success and voiceEnabled or false

	Information.Visible = true
	local infoTween = TweenService:Create(Information, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { GroupTransparency = 0 })
	infoTween:Play()

	Information.AddFriend.AddFriendButton.MouseButton1Click:Connect(function()
		local targetPlayer = Players:FindFirstChild(Information.User.Username.Text:sub(2))
		if targetPlayer then
			HandleFriendAction(targetPlayer)
		end
	end)

	Information.InspectAvatar.InspectButton.MouseButton1Click:Connect(function()
		local targetPlayer = Players:FindFirstChild(Information.User.Username.Text:sub(2))
		if targetPlayer then
			GuiService:InspectPlayerFromUserId(targetPlayer.UserId)
		end
	end)

	Information.Block.BlockButton.MouseButton1Click:Connect(function()
		local targetPlayer = Players:FindFirstChild(Information.User.Username.Text:sub(2))
		if targetPlayer then
			HandleBlockAction(targetPlayer)
		end
	end)
end

local function AddPlayer(player)
	local UserFrame = UserTemplate:Clone()

	UserFrame.Name = player.Name

	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size420x420
	local success, content, isReady = pcall(function()
		return Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
	end)

	if success and isReady then
		UserFrame.PlayerIcon.Image = content
	else
		UserFrame.PlayerIcon.Image = "rbxassetid://0"
	end

	if player.MembershipType == Enum.MembershipType.Premium then
		UserFrame.Icon.Visible = true
	else
		CheckGamePassAndSetIcon(player, UserFrame.Icon)
	end

	UserFrame.MoreInfoButton.MouseButton1Click:Connect(function()
		ShowInformationForPlayer(player)
	end)

	UserFrame.DisplayName.Text = player.DisplayName
	UserFrame.Username.Text = "@"..player.Name

	UserFrame.Parent = PlayerList
end

Information.MultiOptions.Close.Button.MouseButton1Click:Connect(function()
	local closeTween = TweenService:Create(Information, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { GroupTransparency = 1 })
	closeTween.Completed:Connect(function()
		Information.Visible = false
	end)
	closeTween:Play()
end)

local function RemovePlayer(player)
	local UserFrame = PlayerList:FindFirstChild(player.Name)
	if UserFrame then
		UserFrame:Destroy()
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	AddPlayer(player)
end

local isShown = true
local isTweening = false

local function toggleScrollVisibility()
	if isTweening then return end

	isTweening = true

	if not isShown then
		MainScroll.Visible = true
	end

	local targetTransparency = isShown and 1 or 0
	local tweenGoal = { GroupTransparency = targetTransparency }

	local tween = TweenService:Create(MainScroll, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), tweenGoal)
	tween.Completed:Connect(function()
		if isShown then
			MainScroll.Visible = false
		end
		isShown = not isShown
		isTweening = false
	end)

	tween:Play()
end

UserInputService.InputBegan:Connect(function(input, isProcessed)
	if isProcessed then return end 
	if input.KeyCode == Enum.KeyCode.Tab then
		toggleScrollVisibility()
	end
end)

Players.PlayerAdded:Connect(AddPlayer)
Players.PlayerRemoving:Connect(RemovePlayer)