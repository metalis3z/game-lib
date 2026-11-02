--[[
     Rescripted by arxx pls no
]]
wait(1)
local _Players = game:GetService('Players')
local _LocalPlayer = _Players.LocalPlayer
local _PlayerGui = _LocalPlayer.PlayerGui
local _Screengui = _PlayerGui:FindFirstChild("ScreenGui")
local _ReplicatedEvents = game.ReplicatedStorage.Events
local _TextChatService = game:GetService("TextChatService")
local _SoundService = game:GetService("SoundService")
local _Templates = game:GetService("ReplicatedStorage").Templates
local _BoothModels = script.BoothModels

local currentBooth
local interaction
local FrameTI = TweenInfo.new(.5, Enum.EasingStyle.Quint)

local clock = os.clock()

-- functions
function tween(Object, Time, Data)

	game.TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle.Quint), Data):Play()

end

local function GetBooth(slot)
	for i,v in pairs(workspace.BoothModels:GetChildren()) do
		if v:IsA("Model") then
			if v:GetAttribute("BoothID") == slot then
				currentBooth = v
			end
		end
	end
end

local function GetInteraction(slot)
	for i,v in pairs(workspace.BoothInteractions:GetChildren()) do
		if v:IsA("Part") then
			if v:GetAttribute("BoothSlot") == slot then
				interaction = v
			end
		end
	end
end

local function PopUpGreen(text)

	workspace.Camera.FieldOfView = 65
	
	game.SoundService.Success2:Play()

	spawn(function()
		local PopupTemplate = _Templates.PopupTemplate:Clone()
		PopupTemplate.Text = text
		PopupTemplate.TextColor3 = Color3.fromRGB(24, 255, 97)
		PopupTemplate.Parent = _Screengui
		tween(PopupTemplate, 0.9, {
			Position = UDim2.new(0, 0, 0.8, 0)
		})
		wait(0.75)
		tween(PopupTemplate, 3, {
			TextTransparency = 1
		})
		wait(2)
		PopupTemplate:Destroy()
	end)

	tween(workspace.Camera, 0.5, {
		FieldOfView = 70
	})

end

local function PopUpRed(text)

	workspace.Camera.FieldOfView = 65
	
	game.SoundService.Fail:Play()

	spawn(function()
		local PopupTemplate = _Templates.PopupTemplate:Clone()
		PopupTemplate.Text = text
		PopupTemplate.TextColor3 = Color3.fromRGB(255, 0, 0)
		PopupTemplate.Parent = _Screengui
		tween(PopupTemplate, 0.9, {
			Position = UDim2.new(0, 0, 0.8, 0)
		})
		wait(0.75)
		tween(PopupTemplate, 3, {
			TextTransparency = 1
		})
		wait(2)
		PopupTemplate:Destroy()
	end)

	tween(workspace.Camera, 0.5, {
		FieldOfView = 70
	})

end

function OpenFrame(Frame)

	local StartPosition = UDim2.fromScale(.5, .53)
	local FOV = 60

	Frame.Visible = true
	Frame.Position = StartPosition		
	game.TweenService:Create(workspace.CurrentCamera, FrameTI, {FieldOfView = FOV}):Play()
	game.TweenService:Create(Frame, FrameTI, {Position = UDim2.fromScale(.5, .5)}):Play()

end

function CloseFrame(Frame)
	Frame.Visible = false
	game.TweenService:Create(workspace.CurrentCamera, FrameTI, {FieldOfView = 70}):Play()
end
-- Warning

-- Buttons
for i,v in pairs(_Screengui:FindFirstChild("Buttons"):GetDescendants()) do
	if v:IsA("TextButton") then
		v.MouseEnter:Connect(function()
			game.SoundService.Hover2:Play()
			if v.ImageLabel.ImageColor3 == Color3.fromRGB(0, 166, 255) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
				v.BackgroundColor3 = Color3.fromRGB(0, 166, 255)
			elseif v.ImageLabel.ImageColor3 == Color3.fromRGB(255, 78, 78) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
				v.BackgroundColor3 = Color3.fromRGB(255, 78, 78)
			elseif v.ImageLabel.ImageColor3 == Color3.fromRGB(255, 52, 177) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
				v.BackgroundColor3 = Color3.fromRGB(255, 52, 177)
			elseif v.ImageLabel.ImageColor3 == Color3.fromRGB(255, 170, 0) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
				v.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
			end
			v.TextLabel.Visible = true
		end)
		
		v.MouseLeave:Connect(function()
			if v.BackgroundColor3 == Color3.fromRGB(0, 166, 255) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(0, 166, 255)
				v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			elseif v.BackgroundColor3 == Color3.fromRGB(255, 78, 78) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 78, 78)
				v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			elseif v.BackgroundColor3 == Color3.fromRGB(255, 52, 177) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 52, 177)
				v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			elseif v.BackgroundColor3 == Color3.fromRGB(255, 170, 0) then
				v.ImageLabel.ImageColor3 = Color3.fromRGB(255, 170, 0)
				v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			end
			v.TextLabel.Visible = false
		end)
	end
end

-- Interaction
for _,prox in pairs(workspace:FindFirstChild("BoothInteractions"):GetDescendants()) do
	if prox:IsA("ProximityPrompt") then
		prox.Triggered:Connect(function()
			if prox.Name == "Claim" then
				if _LocalPlayer:GetAttribute("Claimed") == false then
					local booth 
					local slot = prox.Parent:GetAttribute("BoothSlot")
					local interaction

					for i,v in pairs(workspace.BoothModels:GetChildren()) do
						if v:IsA("Model") then
							if v:GetAttribute("BoothID") == slot then
								booth = v
							end
						end
					end
					
					for i,v in pairs(workspace.BoothInteractions:GetChildren()) do
						if v:IsA("Part") then
							if v:GetAttribute("BoothSlot") == slot then
								interaction = v
							end
						end
					end
					
					prox.Parent.Claim.Enabled = false
					prox.Parent.Edit.Enabled = true
					game.ReplicatedStorage.Events.ClaimBooth:FireServer(booth, slot, interaction)
					PopUpGreen("claimed!")
					wait(1)
					PopUpRed("please wait while your gamepasses are loading")
					_Screengui.Buttons.EditBooth.Visible = true
					local s,f = pcall(function()
						local slot = _LocalPlayer:GetAttribute("OwnedBooth")
						GetBooth(slot)
						wait()
						_PlayerGui.YourBooth.Adornee = currentBooth
						_PlayerGui.YourBooth.Enabled = true
					end)
					if f then
						warn(f)
					end
				else
					PopUpRed("you already own a booth!")
				end
			elseif prox.Name == "Edit" then
				if _LocalPlayer:GetAttribute("Claimed") == true then
					OpenFrame(_Screengui.EditBooth)
				else
					prox.Parent.Claim.Enabled = true
					prox.Parent.Edit.Enabled = false
					PopUpRed("You dont own a booth!")
				end
			end
		end)
	end
end

-- Buttons
_Screengui.Buttons.EditBooth.Activated:Connect(function()
	OpenFrame(_Screengui.EditBooth)
end)

_Screengui.Buttons.Shop.Activated:Connect(function()
	OpenFrame(_Screengui.GameShop)
end)

_Screengui.Buttons.Settings.Activated:Connect(function()
	OpenFrame(_Screengui.Settings)
end)

_Screengui.Buttons.Codes.Activated:Connect(function()
	OpenFrame(_Screengui.RedeemCode)
end)

_Screengui.Buttons.Gift.Activated:Connect(function()
	OpenFrame(_Screengui.Gift)
end)

-- Close
_Screengui.EditBooth.Buttons.Close.Activated:Connect(function()
	CloseFrame(_Screengui.EditBooth)
end)

_Screengui.GameShop.Buttons.Close.Activated:Connect(function()
	CloseFrame(_Screengui.GameShop)
end)

_Screengui.Settings.Buttons.Close.Activated:Connect(function()
	CloseFrame(_Screengui.Settings)
end)

_Screengui.RedeemCode.Buttons.Close.Activated:Connect(function()
	CloseFrame(_Screengui.RedeemCode)
end)

_Screengui.Gift.Buttons.Close.Activated:Connect(function()
	CloseFrame(_Screengui.Gift)
end)
-- Edit Booth
_Screengui.EditBooth.Apply.Activated:Connect(function()
	local text = _Screengui.EditBooth.TextBox.Text
	GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
	if currentBooth then
		_ReplicatedEvents.Changetext:FireServer(currentBooth, text)
		CloseFrame(_Screengui.EditBooth)
		PopUpGreen("applied!")
	end
end)
_Screengui.EditBooth.Buttons.Refresh.Activated:Connect(function()
	GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
	_ReplicatedEvents.Refresh:FireServer(currentBooth)
	PopUpRed("please wait while your gamepasses are loading")
end)
_Screengui.EditBooth.Buttons.Settings.Activated:Connect(function()
	_Screengui.EditBooth.Visible = false
	_Screengui.BoothSettings.Visible = true
end)
_Screengui.BoothSettings.ScrollingFrame.UnclaimBooth.Activated:Connect(function()
	GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
	GetInteraction(_LocalPlayer:GetAttribute("OwnedBooth"))
	_ReplicatedEvents.Unclaim:FireServer(currentBooth, _LocalPlayer:GetAttribute("OwnedBooth"), interaction)
	_Screengui.Buttons.EditBooth.Visible = false
	CloseFrame(_Screengui.BoothSettings)
	interaction.Edit.Enabled = false
	_PlayerGui.YourBooth.Adornee = nil
	_PlayerGui.YourBooth.Enabled = false
	interaction.Claim.Enabled = true
	PopUpGreen("unclaimed!")
end)
_Screengui.BoothSettings.Buttons.Close.Activated:Connect(function()
	_Screengui.BoothSettings.Visible = false
	CloseFrame(_Screengui.BoothSettings)
end)

-- Codes
_Screengui.RedeemCode.Frame.Redeem.Activated:Connect(function()
	local code = _Screengui.RedeemCode.Frame.Code.Text
	_ReplicatedEvents.Codes.Redeeem:FireServer(code)
	CloseFrame(_Screengui.RedeemCode)
end)

_ReplicatedEvents.Codes.success.OnClientEvent:Connect(function()
	PopUpGreen("successfully redeemed code!")
end)

_ReplicatedEvents.Codes.error.OnClientEvent:Connect(function()
	PopUpRed("code failed to redeem, please try again")
end)

_ReplicatedEvents.Codes.wrong.OnClientEvent:Connect(function()
	PopUpRed("code does not exist")
end)

_ReplicatedEvents.Codes.AlreadyClaimed.OnClientEvent:Connect(function()
	PopUpRed("you have already redeemed this code!")
end)

-- donation popup
_ReplicatedEvents.DonationMessages.Popup["50"].OnClientEvent:Connect(function(DonatedUser, price)
	local msg2 = string.format('<font color="rgb(47, 255, 0)" size="18">%s</font>', "You tipped " .. "<b>" .. price .. "</b> to @" .. DonatedUser)
	PopUpGreen(msg2)
end)

_ReplicatedEvents.DonationMessages.Popup["100"].OnClientEvent:Connect(function(DonatedUser, price)
	local msg2 = string.format('<font color="rgb(255, 0, 174)" size="18">%s</font>', "You donated " .. "<b>" .. price .. "</b> to @" .. DonatedUser)
	PopUpGreen(msg2)
end)

_ReplicatedEvents.DonationMessages.Popup["1000"].OnClientEvent:Connect(function(DonatedUser, price)
	local msg2 = string.format('<font color="rgb(255, 225, 0)" size="18">%s</font>', "You donated " .. "<b>" .. price .. "</b> to @" .. DonatedUser)
	PopUpGreen(msg2)
end)

_ReplicatedEvents.DonationMessages.Popup["10000"].OnClientEvent:Connect(function(DonatedUser, price)
	local msg2 = string.format('<font color="rgb(0, 187, 255)" size="18">%s</font>', "You donated " .. "<b>" .. price .. "</b> to @" .. DonatedUser)
	PopUpGreen(msg2)
end)

-- 2

_ReplicatedEvents.DonationMessages.Popup2["50"].OnClientEvent:Connect(function(DonatedUser, price)
	_SoundService.KaChing:Play()
	local msg2 = string.format('<font color="rgb(47, 255, 0)" size="18">%s</font>', "@" .. DonatedUser .. " tipped you " .. "" .. price)
	PopUpGreen(msg2)
end)

_ReplicatedEvents.DonationMessages.Popup2["100"].OnClientEvent:Connect(function(DonatedUser, price)
	_SoundService.KaChing:Play()
	local msg2 = string.format('<font color="rgb(255, 0, 174)" size="18">%s</font>', "@" .. DonatedUser .. " donated you " .. "" .. price .. "!")
	PopUpGreen(msg2)
end)

_ReplicatedEvents.DonationMessages.Popup2["1000"].OnClientEvent:Connect(function(DonatedUser, price)
	_SoundService.KaChing:Play()
	local msg2 = string.format('<font color="rgb(255, 225, 0)" size="18">%s</font>', "@" .. DonatedUser .. " donated you " .. "" .. price .. "!!")
	PopUpGreen(msg2)
end)

_ReplicatedEvents.DonationMessages.Popup2["10000"].OnClientEvent:Connect(function(DonatedUser, price)
	_SoundService.KaChing:Play()
	local msg2 = string.format('<font color="rgb(0, 187, 255)" size="18">%s</font>', "@" .. DonatedUser .. " donated you " .. "" .. price .. "!!!")
	PopUpGreen(msg2)
end)

-- Change booth
_Screengui.BoothSettings.ScrollingFrame.ChangeTheme.Themes.Basic.Activated:Connect(function()
	local s, f = pcall(function()
		GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
		_ReplicatedEvents.ChangeBooth:FireServer(_BoothModels:FindFirstChild("BasicBooth"), currentBooth, _LocalPlayer:GetAttribute("OwnedBooth"))
	end)
	if s then
		PopUpGreen("successfully changed booth!")
		wait()
		GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
		_PlayerGui.YourBooth.Adornee = currentBooth
		_PlayerGui.YourBooth.Enabled = true
	else
		PopUpRed("There was a error")
	end
end)

_Screengui.BoothSettings.ScrollingFrame.ChangeTheme.Themes.Gold.Activated:Connect(function()
	local s, f = pcall(function()
		if _LocalPlayer:FindFirstChild("leaderstats").Donated.Value >= 50 then
			GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
			_ReplicatedEvents.ChangeBooth:FireServer(_BoothModels:FindFirstChild("GoldBooth"), currentBooth, _LocalPlayer:GetAttribute("OwnedBooth"))
			PopUpGreen("successfully changed booth!")
			wait()
			GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
			_PlayerGui.YourBooth.Adornee = currentBooth
			_PlayerGui.YourBooth.Enabled = true
		else
			PopUpRed("You do not have " .. "" .. "50 donated!")
		end
	end)
	
	if f then
		PopUpRed("There was a error")
	end
end)

_Screengui.BoothSettings.ScrollingFrame.ChangeTheme.Themes.Diamond.Activated:Connect(function()
	local s, f = pcall(function()
		if _LocalPlayer:FindFirstChild("leaderstats").Donated.Value >= 100 then
			GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
			_ReplicatedEvents.ChangeBooth:FireServer(_BoothModels:FindFirstChild("DiamondBooth"), currentBooth, _LocalPlayer:GetAttribute("OwnedBooth"))
			PopUpGreen("successfully changed booth!")
			wait()
			GetBooth(_LocalPlayer:GetAttribute("OwnedBooth"))
			_PlayerGui.YourBooth.Adornee = currentBooth
			_PlayerGui.YourBooth.Enabled = true
		else
			PopUpRed("You do not have " .. "" .. "100 donated!")
		end
	end)

	if f then
		PopUpRed("There was a error")
	end
end)

-- settings
for i, v in pairs(_Screengui.Settings.ScrollingFrame:GetDescendants()) do
	if v:IsA("TextButton") then
		v.Activated:Connect(function()
			if v.Frame.ToggleFrame.Circle.Position == UDim2.new(0.8, 0, 0.5, 0) then
				game.TweenService:Create(v.Frame.ToggleFrame.Circle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
					Position = UDim2.new(0.2, 0, 0.5, 0)
				}):Play()
				game.TweenService:Create(v.Frame.ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					BackgroundColor3 = Color3.fromRGB(226, 226, 226)
				}):Play()
			else
				game.TweenService:Create(v.Frame.ToggleFrame.Circle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
					Position = UDim2.new(0.8, 0, 0.5, 0)
				}):Play()
				game.TweenService:Create(v.Frame.ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					BackgroundColor3 = Color3.fromRGB(13, 255, 0)
				}):Play()
			end
		end)
	end
end

_Screengui.Settings.ScrollingFrame.Music.Activated:Connect(function()
	if game.SoundService.dudu.IsPlaying then
		game.SoundService.dudu:Pause()
	else
		game.SoundService.dudu:Resume()
	end
	PopUpGreen("Applied!")
end)

_Screengui.Settings.ScrollingFrame.Night.Activated:Connect(function()
	if game.Lighting.ClockTime == 10 then
		game.Lighting.ClockTime = 0
	else
		game.Lighting.ClockTime = 10
	end
	PopUpGreen("Applied!")
end)

_Screengui.Settings.Buttons.Close.Activated:Connect(function()
	CloseFrame(_Screengui.Settings)
end)

_Screengui.Settings.Apply.Activated:Connect(function()
	CloseFrame(_Screengui.Settings)
end)

_PlayerGui:FindFirstChild("YourBooth").TextLabel.Button.Activated:Connect(function()
	local slot = _LocalPlayer:GetAttribute("OwnedBooth")
	GetBooth(slot)
	_ReplicatedEvents.Parent.TpToBooth:FireServer(currentBooth)
end)

print("[CLIENT]: Main local script loaded in " .. os.clock() - clock .. " ms")