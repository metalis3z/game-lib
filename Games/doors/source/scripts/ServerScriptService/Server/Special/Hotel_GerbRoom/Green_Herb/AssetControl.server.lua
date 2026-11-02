local l__Prompt__1 = script.Parent:FindFirstChild("Plant"):WaitForChild("HerbPrompt")

l__Prompt__1.Triggered:Connect(function(player)
	if player.Character.HerbGreen.Value == 1 then
		return
	else
		player.Character.HerbGreen.Value = 1
		require(game.ServerScriptService.Game.Directory["Achievements"]).achievement(player, 3)
		require(player.PlayerGui.MainUI.Initiator.Main_Game.HerbGreen):Load(player)
		game.ReplicatedStorage.Bricks.Caption:FireClient(player, 'My heart beats stronger than before.')	
	end
end)