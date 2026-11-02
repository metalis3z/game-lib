game.ReplicatedFirst:RemoveDefaultLoadingScreen()

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")


repeat wait(1) until game:IsLoaded()

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PlayerGui:SetTopbarTransparency(1)
