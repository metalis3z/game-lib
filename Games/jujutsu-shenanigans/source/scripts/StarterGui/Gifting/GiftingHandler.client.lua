-- services

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local UserService = game:GetService("UserService")


-- references

local ComGet = game.ReplicatedStorage.Remotes.Comunicator.Get

local LocalPlayer = Players.LocalPlayer

local playerIcons = {}

local imageStartLink = "rbxthumb://type=AvatarHeadShot&id="
local imageEndLink = "&w=420&h=420"

local SelectedUserFrame = nil
local SelectedPassFrame = nil

shared.GiftingInfo = {}

local GUI = script.Parent
local MainFrame = GUI.Frame

local PlayersListFrame = MainFrame.ReceiverMagic.Receiver
local PlayersListScrollingFrame = PlayersListFrame.ScrollingFrame
local PlayersListSearchBox = PlayersListFrame.TextBox

local PassesScrollingFrame = MainFrame.ScrollingFrame
local SendButton = MainFrame.Send

local LastPlayersListSearchBoxCheck = tick()
local LastPlayerSearchedButton = nil

local GiftablePasses = shared.GiftablePasses
if not GiftablePasses then
	repeat
		GiftablePasses = shared.GiftablePasses
		
		task.wait()
	until GiftablePasses ~= nil
end


-- functions

local function createIconImageId(userId)
	return imageStartLink .. userId .. imageEndLink
end

local function createPlayerIcon(UserId, Name, DisplayName)
	if playerIcons[Name] ~= nil or UserId == Players.LocalPlayer.UserId then return end
	
	local ImageButton = script.ImageButton:Clone()
	
	ImageButton.Avatar.Image = createIconImageId(UserId)
	ImageButton.Avatar.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
	
	ImageButton.TextLabel.Text = DisplayName
	ImageButton.TextLabel.TextLabel.Text = string.format("(@%s)", Name)
	
	ImageButton.MouseButton1Click:Connect(function()
		if SelectedUserFrame ~= ImageButton then
			if SelectedUserFrame then
				TweenService:Create(SelectedUserFrame.Avatar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageColor3 = Color3.new(0.2, 0.2, 0.2)
				}):Play()
				
				TweenService:Create(SelectedUserFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 1
				}):Play()
			end
			
			if SendButton.Visible == false then
				SendButton.Size = UDim2.new(0, 0, 0.094, 0)
				SendButton.TextTransparency = 1.75
				TweenService:Create(SendButton, TweenInfo.new(0.62, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Size = UDim2.new(1.552, 0, 0.094, 0), 
					TextTransparency = 0
				}):Play()
			end

			SendButton.Visible = true
			
			
			shared.GiftingInfo.goalUserId = UserId
			SelectedUserFrame = ImageButton
			
			
			TweenService:Create(ImageButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = 0.75
			}):Play()
			
			TweenService:Create(ImageButton.Avatar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageColor3 = Color3.new(1, 1, 1)
			}):Play()
		end
	end)
	
	ImageButton.Parent = PlayersListScrollingFrame
	
	playerIcons[Name] = ImageButton
	
	return ImageButton
end

local function ResetPlayersListScrollingFrame()
	if LastPlayerSearchedButton then
		LastPlayerSearchedButton:Destroy()
		LastPlayerSearchedButton = nil
	end

	for _,v in playerIcons do
		v.Visible = true
	end	
end


-- runtime

PlayersListScrollingFrame.ChildAdded:Connect(function(ImageButton: ImageButton)
	if ImageButton:IsA("ImageButton") then
		PlayersListScrollingFrame.CanvasSize = UDim2.fromScale(0, 0.079 * (#PlayersListScrollingFrame:GetChildren() - 1))
	end
end)

PlayersListScrollingFrame.ChildRemoved:Connect(function(ImageButton: ImageButton)
	if ImageButton:IsA("ImageButton") then
		PlayersListScrollingFrame.CanvasSize = UDim2.fromScale(0, 0.079 * (#PlayersListScrollingFrame:GetChildren() - 1))
	end
end)

for ProductName, PassId: number in GiftablePasses do
	local productInfo = MarketplaceService:GetProductInfo(PassId, Enum.InfoType.Product)
	
	
	local PassIcon = productInfo.IconImageAssetId
	if PassIcon == 0 then
		PassIcon = 14684890890
	end
	
	
	local PassFrame = script.Frame:Clone()
	
	PassFrame.TextLabel.Text = ProductName
	PassFrame.TextLabel.TextLabel.Text = productInfo.PriceInRobux .. " ROBUX"
	
	PassFrame.ImageLabel.Image = "rbxassetid://" .. PassIcon
	PassFrame.ImageLabel.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
	
	PassFrame.Parent = PassesScrollingFrame
	
	PassFrame.Btn.MouseButton1Click:Connect(function()
		if SelectedPassFrame ~= PassFrame then
			if PlayersListFrame.Visible == false then
				PlayersListFrame.Visible = true
				
				PlayersListFrame.Position = UDim2.fromScale(1.5, 0.5)
				TweenService:Create(PlayersListFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Position = UDim2.fromScale(0.5, 0.5) }):Play()
			end
			

			if SelectedPassFrame ~= nil then
				TweenService:Create(SelectedPassFrame.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageColor3 = Color3.new(0.2, 0.2, 0.2)
				}):Play()
			end
			
			SelectedPassFrame = PassFrame
			shared.GiftingInfo.passName = ProductName
			
			TweenService:Create(PassFrame.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageColor3 = Color3.new(1, 1, 1)
			}):Play()
		end
	end)
end

for _, Player in Players:GetPlayers() do
	createPlayerIcon(Player.UserId, Player.Name, Player.DisplayName)
end

pcall(function()
	local FriendsList = Players:GetFriendsAsync(LocalPlayer.UserId)

	repeat
		for _, Data in FriendsList:GetCurrentPage() do
			createPlayerIcon(Data.Id, Data.Username, Data.DisplayName)
		end

		if FriendsList.IsFinished == false then
			FriendsList:AdvanceToNextPageAsync()
		end
	until FriendsList.IsFinished == true
end)

Players.PlayerAdded:Connect(function(Player)
	createPlayerIcon(Player.UserId, Player.Name, Player.DisplayName)
end)

Players.PlayerRemoving:Connect(function(Player)
	local playerIcon: ImageButton = playerIcons[Player.Name]
	
	if playerIcon then
		playerIcon:Destroy()
		playerIcons[Player.Name] = nil
	end
end)


local canvasYSize = 500
local function ChangePlayersListAbsoluteContentSize()
	local absoluteYSize = PlayersListScrollingFrame.UIListLayout.AbsoluteContentSize.Y
	
	if canvasYSize < absoluteYSize then
		canvasYSize = absoluteYSize
	end
	
	PlayersListScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(absoluteYSize, canvasYSize))
end

ChangePlayersListAbsoluteContentSize()
PlayersListScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ChangePlayersListAbsoluteContentSize)


local function ChangePassesListAbsoluteContentSize()
	PassesScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PassesScrollingFrame.UIGridLayout.AbsoluteContentSize.Y + 5)
end

ChangePassesListAbsoluteContentSize()
PassesScrollingFrame.UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ChangePassesListAbsoluteContentSize)

PlayersListSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	LastPlayersListSearchBoxCheck = tick()

	task.delay(0.3, function()
		if tick() - LastPlayersListSearchBoxCheck > 0.3 then
			pcall(function()
				if PlayersListSearchBox.Text == "" then
					ResetPlayersListScrollingFrame()
				else
					local Username = PlayersListSearchBox.Text
					local userId = Players:GetUserIdFromNameAsync(Username)

					if userId then
						local userInfo = UserService:GetUserInfosByUserIdsAsync({ userId })[1]

						if userInfo then
							for _,v in playerIcons do
								v.Visible = false
							end
							
							if playerIcons[Username] == nil then
								if LastPlayerSearchedButton then
									LastPlayerSearchedButton:Destroy()
									LastPlayerSearchedButton = nil
								end

								LastPlayerSearchedButton = createPlayerIcon(userId, Username, userInfo.DisplayName)

							else
								playerIcons[Username].Visible = true
							end

						else
							for _,v in playerIcons do
								v.Visible = true
							end	
						end

					else
						ResetPlayersListScrollingFrame()
					end
				end
			end)
		end
	end)
end)

SendButton.MouseButton1Click:Connect(function()
	local passName = shared.GiftingInfo.passName
	local goalUserId = shared.GiftingInfo.goalUserId
	
	if passName and goalUserId and ComGet:InvokeServer("ownsGamepass", { userId =  goalUserId, passName = passName }) == false then
		MarketplaceService:PromptProductPurchase(LocalPlayer, GiftablePasses[shared.GiftingInfo.passName])
	end
end)