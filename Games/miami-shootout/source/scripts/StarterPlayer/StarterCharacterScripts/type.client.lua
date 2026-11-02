repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("isusertyping")

task.wait(3)

while wait() do
	if not script.Parent:FindFirstChild("isusertyping") then
		game.Players.LocalPlayer:Kick("next time maybe")
	end
end