local Players = game:GetService("Players")

local InfectionPart = workspace.SCPs.InfectionSpreader:WaitForChild("610InfectionSpreader")

local Touched = false

local Infected = {}

function BlurScreen(Amount, Time)
	local Blur = game.Lighting.Blur
	Blur.Size = 0
	game:GetService("TweenService"):Create(Blur, TweenInfo.new(Time, Enum.EasingStyle.Sine), {Size = Amount}):Play()
end

function ModifyProperty(Obj, Time, Amount)
   game:GetService("TweenService"):Create(Obj, TweenInfo.new(Time, Enum.EasingStyle.Sine), {Size = Amount}):Play()
end



game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	if child.Name == "Infected" then
		local busy = true
		game.Players.LocalPlayer:WaitForChild("PlayerGui").InfectionGui.Frame.TextLabel.Text = "You start to feel uneasy..."
		spawn(function()
			
			while busy == true and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health ~= 0 do
				wait(0.5)
			end
			game.Players.LocalPlayer:WaitForChild("PlayerGui").InfectionGui.Frame.TextLabel.Text = "You start to feel uneasy... jk you died rip transformation"
			
		end)
			local Player = game.Players.LocalPlayer
						
					BlurScreen(50, 10)
						wait(2)
				
		game:GetService("TweenService"):Create(Player:WaitForChild("PlayerGui").InfectionGui.Frame, TweenInfo.new(5, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
					wait(5)
					ModifyProperty(game.Lighting:WaitForChild("Blur"), 5, 25)
					wait(5)
		game:GetService("TweenService"):Create(Player:WaitForChild("PlayerGui").InfectionGui.Frame.TextLabel, TweenInfo.new(5, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()
					wait(2)
		game:GetService("TweenService"):Create(Player:WaitForChild("PlayerGui").InfectionGui.Frame.TextLabel, TweenInfo.new(5, Enum.EasingStyle.Sine), {TextTransparency = 1}):Play()
					wait(5)
		game:GetService("TweenService"):Create(Player:WaitForChild("PlayerGui").InfectionGui.Frame, TweenInfo.new(5, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
					wait(3)
					ModifyProperty(game.Lighting:WaitForChild("Blur"), 5, 0)
					Player.Character.Humanoid.PlatformStand = false
					wait(6)
					workspace.CurrentCamera.CameraSubject = workspace:FindFirstChild(Player.Name).UpperTorso
			   
				 
				
				
			
				
			
			
		end
	

end)