
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local Players = game:GetService("Players")
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local TopbarPlus = require(ReplicatedStorage.Packages.TopbarPlus)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local v8 = require(ReplicatedStorage.Packages.Net):RemoteEvent("TeleportService/RequestVoiceServer")
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local u12 = nil
local v13 = TopbarPlus.new():setLabel("VC Servers"):setOrder(3)

local VoiceChat = PlayerGui:WaitForChild("VoiceChat").VoiceChat
local Close = VoiceChat.Close
local Yes = VoiceChat.Yes
local Cancel = VoiceChat.Cancel

return {
	Start = function(_)
		task.spawn(function()
			if game.PlaceId == ServerData.VoiceServersPlaceId or ServerData.IsDuelsServer() then
				v13:setEnabled(false)
			end

			u12 = InterfaceController:Register("VoiceChat", VoiceChat, "TopQuint")
			u12:AttachCloseButton(Close)
			u12:AttachCloseButton(Cancel)
			u12:Close()
			v13.selected:Connect(function()
				InterfaceController:SetState("VoiceChat", true)
			end)
			v13.deselected:Connect(function()
				InterfaceController:SetState("VoiceChat", false)
			end)
			u12.OnOpen:Connect(function()
				v13:select()
			end)
			u12.OnClose:Connect(function()
				v13:deselect()
			end)

			local v19 = AnimatedButton.new(Yes)

			v19:Animate()
			v19.OnActivated:Connect(function()
				local ok, result = pcall(function()
					return VoiceChatService:IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId)
				end)

				if ok and result then
					v8:FireServer()

					return
				end

				NotificationController:Error("You must have Voice Chat enabled to join this experience.")
			end)

			local ok, result = pcall(function()
				return VoiceChatService:IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId)
			end)

			if ok and not result then
				v13:setEnabled(false)
			end
		end)
	end
}
