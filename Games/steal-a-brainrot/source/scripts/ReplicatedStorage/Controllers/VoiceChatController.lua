local VoiceChatController = nil

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local TopbarPlus = require(ReplicatedStorage.Packages.TopbarPlus)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local TopbarPlus = TopbarPlus.new():setLabel("VC Servers"):setOrder(3)
local VoiceChat = PlayerGui:WaitForChild("VoiceChat").VoiceChat

local Close = VoiceChat.Close
local Yes = VoiceChat.Yes
local Cancel = VoiceChat.Cancel

return {
	Start = function(_)
		if game.PlaceId == ServerData.VoiceServersPlaceId or ServerData.IsDuelsServer() then
			TopbarPlus:setEnabled(false)
		end
		
		VoiceChatController = InterfaceController:Register("VoiceChat", VoiceChat, "TopQuint")
		VoiceChatController:AttachCloseButton(Close)
		VoiceChatController:AttachCloseButton(Cancel)
		VoiceChatController:Close()
		
		TopbarPlus.selected:Connect(function()
			InterfaceController:SetState("VoiceChat", true)
		end)
		
		TopbarPlus.deselected:Connect(function()
			InterfaceController:SetState("VoiceChat", false)
		end)
		
		VoiceChatController.OnOpen:Connect(function()
			TopbarPlus:select()
		end)
		
		VoiceChatController.OnClose:Connect(function()
			TopbarPlus:deselect()
		end)
		
		local AnimatedButtonYes = AnimatedButton.new(Yes)
		AnimatedButtonYes:Animate()
		
		AnimatedButtonYes.OnActivated:Connect(function()
			local Status, Result = pcall(function()
				return VoiceChatService:IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId)
			end)
			
			if Status and Result then
				TeleportService:Teleport(ServerData.VoiceServersPlaceId, LocalPlayer)
				return
			else
				NotificationController:Error("You must have Voice Chat enabled to join this experience.")
				return
			end
		end)
		
		local Status1, Result1 = pcall(function()
			return VoiceChatService:IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId)
		end)
		
		if Status1 and not Result1 then
			TopbarPlus:setEnabled(false)
		end
	end
}