local JoinTeam = game.ReplicatedStorage:WaitForChild("HomeConfig"):WaitForChild("JoinTeam")
local plr = game.Players.LocalPlayer
local fadeframe = plr.PlayerGui.Home.fadeFrame
local Button = script.Parent

Button.MouseButton1Click:Connect(function()
	game.StarterGui:SetCoreGuiEnabled("All", true)
	
	JoinTeam:FireServer(BrickColor.new("Bright orange"))
end)
