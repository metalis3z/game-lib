game.Workspace.GameSettings.Fires.StarvialUse.Event:Connect(function(player)
	if game.Players:FindFirstChild(player).Character:GetAttribute("StarvialUsed", true) then
		return
	else
		game.Players:FindFirstChild(player).Character:SetAttribute("StarvialUsed", true)
	end

	local Humanoid = game.Players:FindFirstChild(player).Character.Humanoid
	local fire = game.Workspace.GameSettings.Fires.StarvialUse

	local VitaminsItem = game.Players:FindFirstChild(player).Character.StarVial

	local Hold = Humanoid:LoadAnimation(fire.idle)
	local Open = Humanoid:LoadAnimation(fire.open)

	if VitaminsItem:GetAttribute("Durability") == 1 then
		game.ReplicatedStorage.EntityInfo.StarVialEffect:FireClient(game.Players:FindFirstChild(player))
		Open:Play()
		VitaminsItem.Used.Value = true

		task.wait(Open.Length - 0.1)
		Open:Stop()

		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") + 8)
		task.wait(1)
		VitaminsItem:Destroy()
		task.wait(8)
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") - 8)
		task.wait(2)
		game.Players:FindFirstChild(player).Character:SetAttribute("StarvialUsed", false)
	else
		game.ReplicatedStorage.EntityInfo.StarVialEffect:FireClient(game.Players:FindFirstChild(player))
		Open:Play()
		VitaminsItem:SetAttribute("Durability", VitaminsItem:GetAttribute("Durability") - 1)
		task.wait(Open.Length - 0.1)
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") + 8)
		task.wait(9)
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") - 8)
		task.wait(2)
		game.Players:FindFirstChild(player).Character:SetAttribute("StarvialUsed", false)
	end
end)