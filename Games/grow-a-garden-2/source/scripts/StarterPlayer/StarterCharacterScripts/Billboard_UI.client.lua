--credit to leon games studio
local HumanoidRootPart = script.Parent:WaitForChild("HumanoidRootPart")
local v1 = script.Billboard_UI:Clone()

v1.Parent = game.Players.LocalPlayer.PlayerGui
v1.Adornee = HumanoidRootPart