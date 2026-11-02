local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PromptFavoriteEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("PromptFavoriteEvent")

local FavoritePrompt = {}

function FavoritePrompt.Init()
	Players.PlayerAdded:Connect(function(player)
		task.spawn(function()
			task.wait(30)

			if player.Parent then -- verifica que el jugador siga en el juego
				PromptFavoriteEvent:FireClient(player)
			end
		end)
	end)
end

FavoritePrompt.Init()

return FavoritePrompt