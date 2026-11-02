local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)

TextChatService:WaitForChild("KiwiGames"):WaitForChild("FakePurchases").Triggered:Connect(function()
	InterfaceController:Toggle("FakePurchases", false)
end)