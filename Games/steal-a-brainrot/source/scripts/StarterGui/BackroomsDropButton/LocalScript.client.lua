local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Net = require(RS.Packages.Net)
local BackroomsDropRemote = Net:RemoteEvent("BackroomsService/Drop")

local player = Players.LocalPlayer
local frame = script.Parent.DropFrame
local dropBtn = frame.DropBtn  -- maintenant une Frame

-- Montrer/cacher le bouton
local function update()
	local isStealing = player:GetAttribute("Stealing") == true
	local inBackrooms = player:GetAttribute("InBackrooms") == true
	local isSammyStealing = player:GetAttribute("SammyStealing") == true
	frame.Visible = isSammyStealing or (isStealing and inBackrooms)
end

player:GetAttributeChangedSignal("Stealing"):Connect(update)
player:GetAttributeChangedSignal("InBackrooms"):Connect(update)
player:GetAttributeChangedSignal("SammyStealing"):Connect(update)
task.spawn(update)

-- Anim hover / press sur la Frame
local function onInputBegan(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		TweenService:Create(dropBtn, TweenInfo.new(0.08), {
			Size = UDim2.new(0.94, 0, 0.88, 0),
			Position = UDim2.new(0.03, 0, 0.06, 0),
		}):Play()
	end
end

local function onInputEnded(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		TweenService:Create(dropBtn, TweenInfo.new(0.12, Enum.EasingStyle.Back), {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
		}):Play()

		-- Déclencher le drop
		local isStealing = player:GetAttribute("Stealing") == true
		local inBackrooms = player:GetAttribute("InBackrooms") == true
		local isSammyStealing = player:GetAttribute("SammyStealing") == true
		if isSammyStealing or (isStealing and inBackrooms) then
			BackroomsDropRemote:FireServer()
		end
	end
end

dropBtn.InputBegan:Connect(onInputBegan)
dropBtn.InputEnded:Connect(onInputEnded)
