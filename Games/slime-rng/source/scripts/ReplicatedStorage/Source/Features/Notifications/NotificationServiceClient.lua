-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NotificationServiceClient, time of decompilation: Sun May  3 10:11:58 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Networker = require(ReplicatedStorage.Packages.Networker)
local DisplayNameWithIcons = require(ReplicatedStorage.Source.Core.UI.DisplayNameWithIcons)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local Notifications = require(ReplicatedStorage.Source.Features.Notifications.UI.Notifications)
local TextNotifications = require(ReplicatedStorage.Source.Features.Notifications.UI.TextNotifications)
local AnnouncementMessages = require(ReplicatedStorage.Source.Core.UI.Components.AnnouncementMessages)

return {
	init = function(p1) --[[ init ]] -- line: 11
		-- upvalues: Networker (copy)
		p1.networker = Networker.client.new("NotificationService", p1)
	end,
	serverNotification = function(_, p3) --[[ serverNotification ]] -- line: 15
		-- upvalues: Notifications (copy)
		Notifications.addNotification(p3)
	end,
	textNotification = function(_, p3) --[[ textNotification ]]
		-- upvalues: TextNotifications (copy)
		TextNotifications.add(p3.message, {
			Color = p3.Color,
			StrokeColor = p3.StrokeColor,
			Duration = p3.Duration,
			Confetti = p3.Confetti,
		})
	end,
	announcement = function(_, p3) --[[ announcement ]]
		-- upvalues: AnnouncementMessages (copy)
		AnnouncementMessages.add(p3.message, {
			Color = p3.Color,
			Position = p3.Position,
			Size = p3.Size,
			Duration = p3.Duration,
			Sound = p3.Sound,
			Confetti = p3.Confetti,
		})
	end,
	globalMessage = function(_, p5) --[[ globalMessage ]] -- line: 19
		-- upvalues: TextChatService (copy)
		local v13 = if not p5.color then Color3.new(1, 1, 1) else Color3.fromRGB(p5.color.R, p5.color.G, p5.color.B)
		local v14 = math.round(v13.R * 255)
		local v15 = math.round(v13.G * 255)
		local v16 = math.round(v13.B * 255)

		TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral"):DisplaySystemMessage(`<font color="rgb({ v14 }, { v15 }, { v16 })">{ p5.message }</font>`)
	end,
	sendProductMessage = function(_: {[any]: any}, p6, n1: number) --[[ sendProductMessage ]] -- line: 37
		-- upvalues: MonetizationServiceClient (copy), TextChatService (copy), DisplayNameWithIcons (copy)
		local v20 = MonetizationServiceClient:getProductInfo(n1)
		local RBXGeneral = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
		local v22 = `{ DisplayNameWithIcons(p6) } has purchased { v20.Name } for { v20.CostText }!`

		RBXGeneral:DisplaySystemMessage(`<font color="rgb({ not (v20.PriceInRobux > 1000) and "109, 255, 31" or "225, 0, 255" })">{ v22 }</font>`)
	end,
	productMessage = function(p7, p8) --[[ productMessage ]] -- line: 45
		-- upvalues: Players (copy)
		if type(p8) ~= "table" or (type(p8.userId) ~= "number" or type(p8.productId) ~= "number") then
			return
		end

		local PlayerByUserId = Players:GetPlayerByUserId(p8.userId)

		if PlayerByUserId == nil then
			return
		end

		p7:sendProductMessage(PlayerByUserId, p8.productId)
	end
}
