local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)

local RedNotificationController = {}

local initialized = false

function RedNotificationController.Send(text)
	NotificationsController.Send("Red", text or "")
end

function RedNotificationController.NotEnoughCash()
	RedNotificationController.Send("Not enough cash :(")
end

function RedNotificationController.Init()
	if initialized then return end
	initialized = true

	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local NotEnoughCashEvent = Remotes:WaitForChild("NotEnoughCash")
	NotEnoughCashEvent.OnClientEvent:Connect(function(message)
		local text = (typeof(message) == "string" and message ~= "") and message or "Not enough cash :("
		RedNotificationController.Send(text)
	end)
end

return RedNotificationController
