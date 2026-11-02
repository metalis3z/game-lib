local OutfitEvents = game.ReplicatedStorage.OutfitEvents
local Player = game:GetService("Players").LocalPlayer
Player.Team = game.Teams.Dead
OutfitEvents.SetAvatarClient:FireServer(game.Players.LocalPlayer)
