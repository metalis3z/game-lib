if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Backpack, PlayerGui = Player:FindFirstChild('Backpack'), Player:FindFirstChild('PlayerGui')
if not Player.Character then Player.CharacterAdded:Wait() end
Player.Character:WaitForChild('HumanoidRootPart') Player.Character:WaitForChild('Humanoid')

local CivCars = workspace:WaitForChild('CivCars')
local CryptoPrice = game:FindService('ReplicatedStorage'):WaitForChild('Crypto')
local ETHPrice = game:FindService('ReplicatedStorage'):WaitForChild('ETH')
local DOGEPrice = game:FindService('ReplicatedStorage'):WaitForChild('DOGE')
local CurrentCrypto = Player:WaitForChild('Crypto')
local CurrentETH = Player:WaitForChild('ETH')
local CurrentDOGE = Player:WaitForChild('DOGE')

local Stored = Player:WaitForChild('stored')
local Bank = Stored:WaitForChild('Bank')
local GymStrength, GymStamina = Stored:WaitForChild('GymStrength'), Stored:WaitForChild('GymStamina')

local MuteTeleChat = false
local MuteMessages = false

local Frame = script.Parent:WaitForChild('Main')
local Bottom, Top = Frame:WaitForChild('Bottom'), Frame:WaitForChild('TopApps')

local Unlock, InsideTime, Wifi, Connection = Frame:WaitForChild('Unlock'), Frame:WaitForChild('InsideTime'), Frame:WaitForChild('Wifi'), Frame:WaitForChild('Connection')
local SettingsFrame, CaseColorFrame, NotificationsFrame, VenPayFrame, TeleChatFrame, VehicleFrame, CryptoFrame, MessagesFrame, CurrencyFrame, ETHFrame, HomeFrame, NotiFrame, DOGEFrame, FitnessFrame = Frame:WaitForChild('SettingsFrame'), Frame:WaitForChild('CaseColorFrame'), Frame:WaitForChild('NotificationsFrame'), Frame:WaitForChild('VenPayFrame'), Frame:WaitForChild('TeleChatFrame'), Frame:WaitForChild('VehicleFrame'), Frame:WaitForChild('CryptoFrame'), Frame:WaitForChild('MessagesFrame'), Frame:WaitForChild('CurrencyFrame'), Frame:WaitForChild('ETHFrame'), Frame:WaitForChild('HomeFrame'), Frame:WaitForChild('NotiFrame'), Frame:WaitForChild('DOGEFrame'), Frame:WaitForChild('FitnessFrame')

task.wait(5)

local NewMessage = function(ScrollingBar, ThePlayer, Text, AppName)
 	local Clone
	if ThePlayer == Player then
		Clone = ScrollingBar:FindFirstChild('MyMessage'):Clone()
	else
		Clone = ScrollingBar:FindFirstChild('TargetMessage'):Clone()
	end
	Clone.Parent = ScrollingBar
	Clone.Name = ThePlayer.Name .. ' Message'
	Clone:WaitForChild('Main'):WaitForChild('Username').Text = '@' .. ThePlayer.Name
	if AppName.Name == 'TeleChatFrame' then
		TeleChatFrame:WaitForChild('ScrollingMessages').CanvasPosition = Vector2.new(0, 50000)
	else
		AppName:WaitForChild('ScrollingMessages').CanvasPosition = Vector2.new(0, 50000)
	end
	Clone:WaitForChild('Main'):WaitForChild('Content').Text = Text
	Clone.Visible = true
end

local NewNoti = function(Text, Image)
	local Clone = NotiFrame:FindFirstChild('NotificationCopy'):Clone()
	Clone.Parent = NotiFrame
	Clone.Visible = true
	Clone:FindFirstChild('Frame'):FindFirstChild('Main').Text = Text
	Clone:FindFirstChild('Frame'):FindFirstChild('Icon').Image = Image
	Clone:FindFirstChild('Frame'):FindFirstChild('Icon'):FindFirstChild('IconText').Text = 'New Message Sent'
	Clone:FindFirstChild('Frame'):FindFirstChild('UIStroke').Transparency = .6
	task.wait(5)
	Clone:Destroy()
end

local ChangeTopColor = function(Arg)
	if Arg == true then
		InsideTime.TextColor3 = Color3.fromRGB(0, 0, 0)
		Connection.TextColor3 = Color3.fromRGB(0, 0, 0)
		Wifi.ImageColor3 = Color3.fromRGB(0, 0, 0)
	else
		InsideTime.TextColor3 = Color3.fromRGB(255, 255, 255)
		Connection.TextColor3 = Color3.fromRGB(255, 255, 255)
		Wifi.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end
end

local ChangeInteraction = function(Arg)
	for _,v in next, Top:GetChildren() do
		if v:IsA('ImageButton') then
			v.Interactable = Arg
		end
	end
	for _,v in next, Bottom:GetChildren() do
		if v:IsA('ImageButton') then
			v.Interactable = Arg
		end
	end
end
ChangeInteraction(true)

local GetPlayer = function(Username)
	for _,v in next, game:FindService('Players'):GetPlayers() do
		if string.lower(v.Name) == string.lower(Username) then
			return v
		end
	end
	return false
end

Frame:FindFirstChild('Unlock').MouseButton1Click:Connect(function()
	if Frame:FindFirstChild('Unlock').Visible then
		if Frame:FindFirstChild('Date').Visible and Frame:FindFirstChild('Time').Visible then
			Frame:FindFirstChild('Unlock').Visible = false
			Frame:FindFirstChild('Date').Visible = false
			Frame:FindFirstChild('Time').Visible = false
			Frame:FindFirstChild('Info').Visible = false
			Frame:FindFirstChild('TopApps').Visible = true
			Frame:FindFirstChild('InsideTime').Visible = true
			Frame:FindFirstChild('Widget').Visible = true
			Bottom.Visible = true
			return
		end
		if SettingsFrame.Visible and not CaseColorFrame.Visible and not NotificationsFrame.Visible then
			Unlock.Visible = false
			SettingsFrame.Visible = false
			ChangeTopColor(false)
		elseif SettingsFrame.Visible and CaseColorFrame.Visible then
			CaseColorFrame.Visible = false
		elseif SettingsFrame.Visible and NotificationsFrame.Visible then
			NotificationsFrame.Visible = false
		elseif VenPayFrame.Visible then
			VenPayFrame.Visible = false
			Unlock.Visible = false
		elseif TeleChatFrame.Visible then
			TeleChatFrame.Visible = false
			ChangeTopColor(false)
			Unlock.Visible = false
		elseif VehicleFrame.Visible then
			VehicleFrame.Visible = false
			ChangeTopColor(false)
			Unlock.Visible = false
		elseif FitnessFrame.Visible then
			FitnessFrame.Visible = false
			ChangeTopColor(true)
			Unlock.Visible = false
		elseif HomeFrame.Visible then
			HomeFrame.Visible = false
			ChangeTopColor(false)
			Unlock.Visible = false
		elseif Frame:FindFirstChild('MoneyGroup').Visible then
			Frame:FindFirstChild('MoneyGroup').Visible = false
			Frame:FindFirstChild('Cover').Visible = false
			Unlock.Visible = false
		elseif Frame:FindFirstChild('TalkGroup').Visible then
			Frame:FindFirstChild('TalkGroup').Visible = false
			Frame:FindFirstChild('Cover').Visible = false
			Unlock.Visible = false
		elseif Frame:FindFirstChild('MiscGroup').Visible then
			Frame:FindFirstChild('MiscGroup').Visible = false
			Frame:FindFirstChild('Cover').Visible = false
			Unlock.Visible = false
		elseif CurrencyFrame.Visible and not CryptoFrame.Visible and not ETHFrame.Visible and not DOGEFrame.Visible then
			CurrencyFrame.Visible = false
			Unlock.Visible = false
		elseif CryptoFrame.Visible then
			CryptoFrame.Visible = false
			Unlock.Visible = true
		elseif ETHFrame.Visible then
			ETHFrame.Visible = false
			Unlock.Visible = true
		elseif DOGEFrame.Visible then
			DOGEFrame.Visible = false
			Unlock.Visible = true
		elseif MessagesFrame.Visible then
			for _,v in next, MessagesFrame:GetChildren() do
				if v:IsA('Frame') then
					v.Visible = false
				end
			end
			Unlock.Visible = false
			MessagesFrame.Visible = false
			ChangeTopColor(false)
		end
		if Unlock.Visible == false then
			ChangeInteraction(true)
			ChangeTopColor(true)
			Unlock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		end
	end
end)

for _,v in next, Bottom:GetChildren() do
	if v:IsA('ImageButton') then
		if v.Name == 'Settings' then
			v.MouseButton1Click:Connect(function()
				SettingsFrame.Visible = true
				Unlock.Visible = true
				ChangeTopColor(true)
				ChangeInteraction(false)
				SettingsFrame.TheName.Text = Player.Name
				SettingsFrame.User.Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		elseif v.Name == 'TeleChat' then
			v.MouseButton1Click:Connect(function()
				TeleChatFrame.Visible = true
				Unlock.Visible = true
				ChangeInteraction(false)
				Frame:FindFirstChild('TalkGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeTopColor(true)
				v:FindFirstChild('Noti').Visible = false
				Frame:FindFirstChild('TalkGroup'):FindFirstChild('TeleChat'):FindFirstChild('Noti').Visible = false
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		elseif v.Name == 'VenPay' then
			v.MouseButton1Click:Connect(function()
				VenPayFrame.Visible = true
				Unlock.Visible = true
				ChangeInteraction(false)
				VenPayFrame:FindFirstChild('User').Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				VenPayFrame:FindFirstChild('TheName').Text = Player.Name
				Frame:FindFirstChild('MoneyGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		end
	end
end

for _,v in next, SettingsFrame:GetChildren() do
	if v:IsA('TextButton') then
		if v.Name == 'CaseColor' then
			v.MouseButton1Click:Connect(function()
				CaseColorFrame.Visible = true
				Unlock.Visible = true
				ChangeTopColor(true)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		elseif v.Name == 'Notifications' then
			v.MouseButton1Click:Connect(function()
				NotificationsFrame.Visible = true
				Unlock.Visible = true
				ChangeTopColor(true)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		end
	end
end

for _,v in next, CaseColorFrame:FindFirstChild('Scroll'):GetChildren() do
	if v:IsA('TextButton') and v.Name == 'Color' then
		v.MouseButton1Click:Connect(function()
			Frame:FindFirstChild('CaseColor').Color = v.BackgroundColor3
		end)
		v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
	end
end

for _,v in next, NotificationsFrame:GetChildren() do
	if v:IsA('Frame') then
		v:FindFirstChild('Interaction').MouseButton1Click:Connect(function()
			if v:FindFirstChild('Interaction').Text == 'ENABLED' then
				v:FindFirstChild('Interaction').Text = 'DISABLED'
				v:FindFirstChild('Interaction').BackgroundColor3 = Color3.fromRGB(200, 0, 0)
				if v.Name == 'TeleChat' then MuteTeleChat = true elseif v.Name == 'Messages' then MuteMessages = true end
			else
				v:FindFirstChild('Interaction').Text = 'ENABLED'
				v:FindFirstChild('Interaction').BackgroundColor3 = Color3.fromRGB(0, 200, 0)
				if v.Name == 'TeleChat' then MuteTeleChat = false elseif v.Name == 'Messages' then MuteMessages = false end
			end
		end)
		v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
	end
end

for _,v in next, Top:GetChildren() do
	if v:IsA('ImageButton') then
		if Frame:FindFirstChild(v.Name .. 'Group') then
			v.MouseButton1Click:Connect(function()
				ChangeInteraction(false)
				Frame:FindFirstChild(v.Name .. 'Group').Visible = true
				Frame:FindFirstChild('Cover').Visible = true
				Frame:FindFirstChild('Unlock').Visible = true
				ChangeTopColor(true)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		end
	end
end

for _,v in next, Frame:FindFirstChild('MoneyGroup'):GetChildren() do
	if v:IsA('ImageButton') then
		if v.Name == 'VenPay' then
			v.MouseButton1Click:Connect(function()
				VenPayFrame.Visible = true
				Unlock.Visible = true
				VenPayFrame:FindFirstChild('User').Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				VenPayFrame:FindFirstChild('TheName').Text = Player.Name
				Frame:FindFirstChild('MoneyGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeInteraction(false)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		elseif v.Name == 'Crypto' then
			v.MouseButton1Click:Connect(function()
				CurrencyFrame.Visible = true
				Unlock.Visible = true
				Unlock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Frame:FindFirstChild('MoneyGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeTopColor(false)
				ChangeInteraction(false)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		end
	end
end

CurrencyFrame:FindFirstChild('Crypto').MouseButton1Click:Connect(function()
	CryptoFrame.Visible = true
	CryptoFrame:FindFirstChild('User').Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	CryptoFrame:FindFirstChild('TheName').Text = Player.Name
	ChangeTopColor(false)
end)
CurrencyFrame:FindFirstChild('Crypto').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

CurrencyFrame:FindFirstChild('DOGE').MouseButton1Click:Connect(function()
	DOGEFrame.Visible = true
	DOGEFrame:FindFirstChild('User').Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	DOGEFrame:FindFirstChild('TheName').Text = Player.Name
	ChangeTopColor(false)
end)
CurrencyFrame:FindFirstChild('DOGE').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

CurrencyFrame:FindFirstChild('ETH').MouseButton1Click:Connect(function()
	ETHFrame.Visible = true
	ETHFrame:FindFirstChild('User').Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	ETHFrame:FindFirstChild('TheName').Text = Player.Name
	ChangeTopColor(false)
end)
CurrencyFrame:FindFirstChild('ETH').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

CryptoFrame:FindFirstChild('Buy').MouseButton1Click:Connect(function()
	if Bank.Value >= CryptoPrice.Value then
		game:FindService('ReplicatedStorage'):WaitForChild('Phone'):FireServer('Crypto', 'Purchase', CryptoPrice.Value)
		if CurrentCrypto.Value >= 10 then
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		end
	end
end)
CryptoFrame:FindFirstChild('Buy').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

ETHFrame:FindFirstChild('Buy').MouseButton1Click:Connect(function()
	if Bank.Value >= ETHPrice.Value then
		game:FindService('ReplicatedStorage'):WaitForChild('Phone'):FireServer('ETH', 'Purchase', ETHPrice.Value)
		if CurrentETH.Value >= 20 then
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		end
	end
end)
ETHFrame:FindFirstChild('Buy').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

DOGEFrame:FindFirstChild('Buy').MouseButton1Click:Connect(function()
	if Bank.Value >= DOGEPrice.Value then
		game:FindService('ReplicatedStorage'):WaitForChild('Phone'):FireServer('DOGE', 'Purchase', DOGEPrice.Value)
		if CurrentETH.Value >= 20 then
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		end
	end
end)
DOGEFrame:FindFirstChild('Buy').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

CryptoFrame:FindFirstChild('Sell').MouseButton1Click:Connect(function()
	if CurrentCrypto.Value >= 1 then
		game:FindService('ReplicatedStorage'):WaitForChild('Phone'):FireServer('Crypto', 'Sell', CryptoPrice.Value)
		if not script.Kaching.IsPlaying then script.Kaching:Play() end
	end
end)
CryptoFrame:FindFirstChild('Sell').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

ETHFrame:FindFirstChild('Sell').MouseButton1Click:Connect(function()
	if CurrentETH.Value >= 1 then
		game:FindService('ReplicatedStorage'):WaitForChild('Phone'):FireServer('ETH', 'Sell', ETHPrice.Value)
		if not script.Kaching.IsPlaying then script.Kaching:Play() end
	end
end)
ETHFrame:FindFirstChild('Sell').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

DOGEFrame:FindFirstChild('Sell').MouseButton1Click:Connect(function()
	if CurrentDOGE.Value >= 1 then
		game:FindService('ReplicatedStorage'):WaitForChild('Phone'):FireServer('DOGE', 'Sell', DOGEPrice.Value)
		if not script.Kaching.IsPlaying then script.Kaching:Play() end
	end
end)
DOGEFrame:FindFirstChild('Sell').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

for _,v in next, Frame:FindFirstChild('TalkGroup'):GetChildren() do
	if v:IsA('ImageButton') then
		if v.Name == 'TeleChat' then
			v.MouseButton1Click:Connect(function()
				TeleChatFrame.Visible = true
				Unlock.Visible = true
				ChangeInteraction(false)
				Frame:FindFirstChild('TalkGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeTopColor(true)
				Top.Talk:FindFirstChild('Noti').Visible = false
				Frame:FindFirstChild('TalkGroup'):FindFirstChild('TeleChat'):FindFirstChild('Noti').Visible = false
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		elseif v.Name == 'Messages' then
			v.MouseButton1Click:Connect(function()
				MessagesFrame.Visible = true
				Unlock.Visible = true
				ChangeInteraction(false)
				Frame:FindFirstChild('TalkGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeTopColor(true)
				MessagesFrame.TheName.Text = Player.Name
				MessagesFrame.User.Image = game:FindService('Players'):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		end
	end
end

for _,v in next, Frame:FindFirstChild('MiscGroup'):GetChildren() do
	if v:IsA('ImageButton') then
		if v.Name == 'Vehicle' then
			v.MouseButton1Click:Connect(function()
				VehicleFrame.Visible = true
				Unlock.Visible = true
				Frame:FindFirstChild('MiscGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeTopColor(true)
				ChangeInteraction(false)
				if CivCars:FindFirstChild(Player.Name .. "'s Car") then
					VehicleFrame:FindFirstChild('CarName').Text = CivCars:FindFirstChild(Player.Name .. "'s Car").Name
					VehicleFrame:FindFirstChild('CarType').Text = 'RS6'
					VehicleFrame:FindFirstChild('Track').Visible = true
					VehicleFrame:FindFirstChild('Unlock').Visible = true
					VehicleFrame:FindFirstChild('Lock').Visible = true
					VehicleFrame:FindFirstChild('Refresh').Visible = true
					VehicleFrame:FindFirstChild('Nun').Visible = false
				else
					VehicleFrame:FindFirstChild('Nun').Visible = true
				end
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
		elseif v.Name == 'Home' then
			v.MouseButton1Click:Connect(function()
				HomeFrame.Visible = true
				Unlock.Visible = true
				Frame:FindFirstChild('MiscGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				ChangeTopColor(true)
				ChangeInteraction(false)
				if Player:FindFirstChild('HomeOwner') then
					for _,v in next, workspace:FindFirstChild('Map'):FindFirstChild('Apt Buy Doors'):GetDescendants() do
						if v.Name == 'Owner' and v:IsA('StringValue') then
							if v.Value == tostring(Player.Name) then
								if v.Parent:FindFirstChild('APT') then
									HomeFrame:FindFirstChild('APT').Text = v.Parent:FindFirstChild('APT').Value
								end
							end
						end
					end
					HomeFrame:FindFirstChild('Extra').Visible = true
					HomeFrame:FindFirstChild('Scroll').Visible = true
					HomeFrame:FindFirstChild('APT').Visible = true
					for _,v in next, Player:WaitForChild('InvData'):GetChildren() do
						local Clone = HomeFrame:FindFirstChild('CLONE'):Clone()
						Clone.Parent = HomeFrame:FindFirstChild('Scroll')
						Clone.Text = v.Name Clone.Name = v.Name
						Clone.Visible = true
					end
				else
					HomeFrame:FindFirstChild('Nun').Visible = true
				end
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)	
		elseif v.Name == 'Fitness' then
			v.MouseButton1Click:Connect(function()
				FitnessFrame.Visible = true
				Unlock.Visible = true
				Frame:FindFirstChild('MiscGroup').Visible = false
				Frame:FindFirstChild('Cover').Visible = false
				Unlock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ChangeTopColor(false)
				ChangeInteraction(false)
			end)
			v.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)	
		end
	end
end

FitnessFrame:FindFirstChild('Purchase').MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, 1854901363)
end)
FitnessFrame:FindFirstChild('Purchase').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

VehicleFrame:FindFirstChild('Track').MouseButton1Click:Connect(function()
	if Player.Character:FindFirstChild('ArrowHandler') then Player.Character:FindFirstChild('ArrowHandler'):Destroy() end
	if Player.Character:FindFirstChild('Arrow') then Player.Character:FindFirstChild('Arrow'):Destroy() end
	local Clone = script:FindFirstChild('ArrowHandler'):Clone()
	Clone.Parent = Player.Character
	Clone.Target.Value = workspace.CivCars:WaitForChild(Player.Name .. "'s Car"):WaitForChild('DriveSeat')
	Clone.Enabled = true
end)
VehicleFrame:FindFirstChild('Track').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

VehicleFrame:FindFirstChild('Lock').MouseButton1Click:Connect(function()
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('/lock')
end)
VehicleFrame:FindFirstChild('Lock').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

VehicleFrame:FindFirstChild('Unlock').MouseButton1Click:Connect(function()
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('/unlock')
end)
VehicleFrame:FindFirstChild('Unlock').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

VehicleFrame:FindFirstChild('Refresh').MouseButton1Click:Connect(function()
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('RefreshVehicle')
end)
VehicleFrame:FindFirstChild('Refresh').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

local MoneySendCooldown = false
VenPayFrame:FindFirstChild('Send').MouseButton1Click:Connect(function()
	local Amount = VenPayFrame:FindFirstChild('Amount')
	local Username = GetPlayer(VenPayFrame:FindFirstChild('Username').Text)
	
	if Username ~= nil and Username ~= false and Username.UserId then
		if Username ~= Player then
			if tonumber(Amount.Text) ~= nil and math.floor(Amount.Text) ~= nil then
				if MoneySendCooldown == false then 
					MoneySendCooldown = true
					Amount = tonumber(math.floor(Amount.Text))
					if Bank.Value >= Amount then
						if Amount <= 0 then return end
						if Amount > 100000 then game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('You cant send this much.', 2) return end
						game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendMoney', Username, Amount)
						task.wait(.1)
						VenPayFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
						task.wait(1.5)
					else
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('You dont have this amount to send.', 2)
					end
					MoneySendCooldown = false
				else
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('VenPay Cooldown.', 2)
				end
			else
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('Amount is nil.', 2)
			end
		else
			game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('You Cant Send Yourself Money.', 2)
		end
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('Player Not Found.', 2)
	end
end)
VenPayFrame:FindFirstChild('Send').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

local Cooldown = false
local ChatBox = TeleChatFrame:FindFirstChild('Chat')
TeleChatFrame:WaitForChild('SendMessage').MouseButton1Click:Connect(function()
	local Message = ChatBox.Text
	ChatBox.Text = ''
	if Message ~= '' then
		if Cooldown == false then
			Cooldown = true
			game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendMessage', Message)
			task.wait(3)
			Cooldown = false
		end
	end
end)
TeleChatFrame:WaitForChild('SendMessage').MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)

ChatBox.FocusLost:Connect(function(Pressed)
	if Pressed == true then
		local Message = ChatBox.Text
		ChatBox.Text = ''
		if Message ~= '' then
			if Cooldown == false then
				Cooldown = true
				game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendMessage', Message)
				task.wait(3)
				Cooldown = false
			end
		end
	end
end)

VenPayFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
CryptoFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
ETHFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
DOGEFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
Bank.Changed:Connect(function()
	VenPayFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
	CryptoFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
	ETHFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
	DOGEFrame:FindFirstChild('Balance').Text = '$' .. Bank.Value
end)

CryptoFrame:FindFirstChild('Current').Text = 'BTC Price: $' .. tostring(CryptoPrice.Value)
CurrencyFrame:FindFirstChild('CryptoCurrent').Text = '$' .. tostring(CryptoPrice.Value)
CryptoPrice.Changed:Connect(function()
	CryptoFrame:FindFirstChild('Current').Text = 'BTC Price: $' .. tostring(CryptoPrice.Value)
	CurrencyFrame:FindFirstChild('CryptoCurrent').Text = '$' .. tostring(CryptoPrice.Value)
end)

ETHFrame:FindFirstChild('Current').Text = 'ETH Price: $' .. tostring(ETHPrice.Value)
CurrencyFrame:FindFirstChild('ETHCurrent').Text = '$' .. tostring(ETHPrice.Value)
ETHPrice.Changed:Connect(function()
	ETHFrame:FindFirstChild('Current').Text = 'ETH Price: $' .. tostring(ETHPrice.Value)
	CurrencyFrame:FindFirstChild('ETHCurrent').Text = '$' .. tostring(ETHPrice.Value)
end)

DOGEFrame:FindFirstChild('Current').Text = 'DOGE Price: $' .. tostring(DOGEPrice.Value)
CurrencyFrame:FindFirstChild('DOGECurrent').Text = '$' .. tostring(DOGEPrice.Value)
DOGEPrice.Changed:Connect(function()
	DOGEFrame:FindFirstChild('Current').Text = 'DOGE Price: $' .. tostring(DOGEPrice.Value)
	CurrencyFrame:FindFirstChild('DOGECurrent').Text = '$' .. tostring(DOGEPrice.Value)
end)

CryptoFrame:FindFirstChild('BTCBalance').Text = 'BTC Balance: ' .. tostring(CurrentCrypto.Value)
CurrentCrypto.Changed:Connect(function()
	CryptoFrame:FindFirstChild('BTCBalance').Text = 'BTC Balance: ' .. tostring(CurrentCrypto.Value)
end)

ETHFrame:FindFirstChild('ETHBalance').Text = 'ETH Balance: ' .. tostring(CurrentETH.Value)
CurrentETH.Changed:Connect(function()
	ETHFrame:FindFirstChild('ETHBalance').Text = 'ETH Balance: ' .. tostring(CurrentETH.Value)
end)

DOGEFrame:FindFirstChild('DOGEBalance').Text = 'DOGE Balance: ' .. tostring(CurrentDOGE.Value)
CurrentDOGE.Changed:Connect(function()
	DOGEFrame:FindFirstChild('DOGEBalance').Text = 'DOGE Balance: ' .. tostring(CurrentDOGE.Value)
end)

CryptoFrame:FindFirstChild('Countdown').Text = game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value .. 's'
ETHFrame:FindFirstChild('Countdown').Text = game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value .. 's'
DOGEFrame:FindFirstChild('Countdown').Text = game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value .. 's'
game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Changed:Connect(function()
	CryptoFrame:FindFirstChild('Countdown').Text = game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value .. 's'
	ETHFrame:FindFirstChild('Countdown').Text = game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value .. 's'
	DOGEFrame:FindFirstChild('Countdown').Text = game:FindService('ReplicatedStorage'):FindFirstChild('CryptoTimer').Value .. 's'
end)

FitnessFrame:FindFirstChild('Strength'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStrength.Value / 100, 0, 1, 0), "Out", "Linear", 0)
FitnessFrame:FindFirstChild('Strength'):FindFirstChild('Amount').Text = GymStrength.Value .. '/100'
GymStrength.Changed:Connect(function()
	FitnessFrame:FindFirstChild('Strength'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStrength.Value / 100, 0, 1, 0), "Out", "Linear", 0)
	FitnessFrame:FindFirstChild('Strength'):FindFirstChild('Amount').Text = GymStrength.Value .. '/100'
end)

FitnessFrame:FindFirstChild('Stamina'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStamina.Value / 100, 0, 1, 0), "Out", "Linear", 0)
FitnessFrame:FindFirstChild('Stamina'):FindFirstChild('Amount').Text = GymStamina.Value .. '/100'
GymStamina.Changed:Connect(function()
	FitnessFrame:FindFirstChild('Stamina'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStamina.Value / 100, 0, 1, 0), "Out", "Linear", 0)
	FitnessFrame:FindFirstChild('Stamina'):FindFirstChild('Amount').Text = GymStamina.Value .. '/100'
end)

game:FindService('ReplicatedStorage'):WaitForChild('Phone').OnClientEvent:Connect(function(ThePlayer, Argument, Extra, Extra2)
	if Argument == 'AddMessage' then
		NewMessage(TeleChatFrame:FindFirstChild('ScrollingMessages'), ThePlayer, Extra, TeleChatFrame)
		if MuteTeleChat == false then
			if ThePlayer ~= Player then
				Top.Talk:FindFirstChild('Noti').Visible = true
				Frame:FindFirstChild('TalkGroup'):FindFirstChild('TeleChat'):FindFirstChild('Noti').Visible = true
				if not script.TeleChat.IsPlaying then script.TeleChat:Play() end
				NewNoti(Extra, 'rbxassetid://17362926991')
			end
		end
	elseif Argument == 'AddPrivateMessage' then
		if MessagesFrame:FindFirstChild(ThePlayer.Name) then
			NewMessage(MessagesFrame:FindFirstChild(ThePlayer.Name):WaitForChild('ScrollingMessages'), ThePlayer, Extra, MessagesFrame:FindFirstChild(ThePlayer.Name))
			if MuteMessages == false then
				Top.Talk:FindFirstChild('Noti').Visible = true
				Frame:FindFirstChild('TalkGroup'):FindFirstChild('Messages'):FindFirstChild('Noti').Visible = true
				MessagesFrame:FindFirstChild('Scroll'):FindFirstChild(ThePlayer.Name):FindFirstChild('Noti').Visible = true
				if not script.Notifys.IsPlaying then script.Notifys:Play() end
				NewNoti(Extra, 'rbxassetid://17380721180')
			end
		elseif Extra2 then
			if MessagesFrame:FindFirstChild(Extra2.Name) then
				NewMessage(MessagesFrame:FindFirstChild(Extra2.Name):WaitForChild('ScrollingMessages'), ThePlayer, Extra, MessagesFrame:FindFirstChild(Extra2.Name))
			end
		end
	end
end)

for _,v in next, game:FindService('Players'):GetPlayers() do
	if v ~= Player then
		if not MessagesFrame:FindFirstChild(v.Name) then
			local Clone = MessagesFrame:FindFirstChild('MessageTemplate'):Clone()
			Clone.Name = v.Name
			Clone:FindFirstChild('SettingsText').Text = v.Name
			Clone.Parent = MessagesFrame
			Clone.SendMessage.MouseButton1Click:Connect(function()
				local Message = Clone.Chat.Text
				Clone.Chat.Text = ''
				if Message ~= '' then
					if Cooldown == false then
						Cooldown = true
						game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendPrivateMessage', Message, v)
						task.wait(3)
						Cooldown = false
					end
				end
			end)
			Clone.SendMessage.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
			Clone.Chat.FocusLost:Connect(function(Pressed)
				if Pressed == true then
					local Message = Clone.Chat.Text
					Clone.Chat.Text = ''
					if Message ~= '' then
						if Cooldown == false then
							Cooldown = true
							game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendPrivateMessage', Message, v)
							task.wait(3)
							Cooldown = false
						end
					end
				end
			end)
		end
		local Clone = MessagesFrame:FindFirstChild('Template'):Clone()
		Clone.Name = v.Name
		Clone:FindFirstChild('TheName').Text = v.Name
		Clone.Parent = MessagesFrame:FindFirstChild('Scroll')
		Clone.Visible = true
		Clone.MouseButton1Click:Connect(function()
			if MessagesFrame:FindFirstChild(v.Name) then
				MessagesFrame:FindFirstChild(v.Name).Visible = true
				Top.Talk:FindFirstChild('Noti').Visible = false
				Frame:FindFirstChild('TalkGroup'):FindFirstChild('Messages'):FindFirstChild('Noti').Visible = false
				Clone:FindFirstChild('Noti').Visible = false
			end
		end)
		Clone.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
	end
end

game:FindService('Players').PlayerAdded:Connect(function(v)
	if v ~= Player then
		if not MessagesFrame:FindFirstChild(v.Name) then
			local Clone = MessagesFrame:FindFirstChild('MessageTemplate'):Clone()
			Clone.Name = v.Name
			Clone:FindFirstChild('SettingsText').Text = v.Name
			Clone.Parent = Frame:FindFirstChild('MessagesFrame')
			Clone.SendMessage.MouseButton1Click:Connect(function()
				local Message = Clone.Chat.Text
				Clone.Chat.Text = ''
				if Message ~= '' then
					if Cooldown == false then
						Cooldown = true
						game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendPrivateMessage', Message, v)
						task.wait(3)
						Cooldown = false
					end
				end
			end)
			Clone.SendMessage.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
			Clone.Chat.FocusLost:Connect(function(Pressed)
				if Pressed == true then
					local Message = Clone.Chat.Text
					Clone.Chat.Text = ''
					if Message ~= '' then
						if Cooldown == false then
							Cooldown = true
							game:FindService('ReplicatedStorage'):FindFirstChild('Phone'):FireServer('SendPrivateMessage', Message, v)
							task.wait(3)
							Cooldown = false
						end
					end
				end
			end)
		end
		local Clone = MessagesFrame:FindFirstChild('Template'):Clone()
		Clone.Name = v.Name
		Clone:FindFirstChild('TheName').Text = v.Name
		Clone.Parent = MessagesFrame:FindFirstChild('Scroll')
		Clone.Visible = true
		Clone.MouseButton1Click:Connect(function()
			if MessagesFrame:FindFirstChild(v.Name) then
				MessagesFrame:FindFirstChild(v.Name).Visible = true
				Top.Talk:FindFirstChild('Noti').Visible = false
				Frame:FindFirstChild('TalkGroup'):FindFirstChild('Messages'):FindFirstChild('Noti').Visible = false
				Clone:FindFirstChild('Noti').Visible = false
			end
		end)
		Clone.MouseEnter:Connect(function() if not script.Hover.IsPlaying then script.Hover:Play() end end)
	end
end)

game:FindService('Players').PlayerRemoving:Connect(function(Player)
	if MessagesFrame:FindFirstChild(Player.Name) then
		MessagesFrame:FindFirstChild(Player.Name):Destroy()
	end
	if MessagesFrame.Scroll:FindFirstChild(Player.Name) then
		MessagesFrame.Scroll:FindFirstChild(Player.Name):Destroy()
	end
end)

local currentTime = os.date("*t")
local daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
local months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
local hour = tostring(currentTime.hour)
local minute = tostring(currentTime.min)
local dayOfWeek = daysOfWeek[currentTime.wday]
local month = months[currentTime.month]
local day = tostring(currentTime.day)

if #hour == 1 then hour = "0" .. hour end
if #minute == 1 then minute = "0" .. minute end

local Together = hour .. ":" .. minute
local Date = dayOfWeek .. ", " .. month .. " " .. day
InsideTime.Text = Together
Frame:FindFirstChild('Time').Text = Together
Frame:FindFirstChild('Date').Text = Date

while task.wait(10) do
	local currentTime = os.date("*t")
	local daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
	local months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
	local hour = tostring(currentTime.hour)
	local minute = tostring(currentTime.min)
	local dayOfWeek = daysOfWeek[currentTime.wday]
	local month = months[currentTime.month]
	local day = tostring(currentTime.day)

	if #hour == 1 then hour = "0" .. hour end
	if #minute == 1 then minute = "0" .. minute end

	local Together = hour .. ":" .. minute
	local Date = dayOfWeek .. ", " .. month .. " " .. day
	InsideTime.Text = Together
	Frame:FindFirstChild('Time').Text = Together
	Frame:FindFirstChild('Date').Text = Date
end