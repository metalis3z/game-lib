local l__TweenService__3 = game:GetService("TweenService");

game.Workspace.GameSettings.Fires.VitaminsUse.Event:Connect(function(player)
	if game.Players:FindFirstChild(player).Character:GetAttribute("VitaminsUsed", true) then
		return
	else
		game.Players:FindFirstChild(player).Character:SetAttribute("VitaminsUsed", true)
	end

	local Humanoid = game.Players:FindFirstChild(player).Character.Humanoid
	local fire = game.Workspace.GameSettings.Fires.VitaminsUse

	local VitaminsItem = game.Players:FindFirstChild(player).Character.Vitamins

	local Hold = Humanoid:LoadAnimation(fire.idle)
	local Open = Humanoid:LoadAnimation(fire.open)

	if VitaminsItem:GetAttribute("Durability") == 1 then
		Open:Play()
		VitaminsItem.Handle.sound_open:Play()
		VitaminsItem:SetAttribute("Durability", VitaminsItem:GetAttribute("Durability") - 1)

		VitaminsItem.Used.Value = true

		task.wait(Open.Length - 0.1)
		Open:Stop()
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") + 5)
		task.wait(1)
		VitaminsItem:Destroy()
		task.wait(8)
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") - 5)
		task.wait(2)
		game.Players:FindFirstChild(player).Character:SetAttribute("VitaminsUsed", false)
	else
		Open:Play()
		VitaminsItem.Handle.sound_open:Play()
		VitaminsItem:SetAttribute("Durability", VitaminsItem:GetAttribute("Durability") - 1)
		task.wait(Open.Length - 0.1)
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") + 5)
		task.wait(9)
		Humanoid:SetAttribute("SpeedBoostExtra", Humanoid:GetAttribute("SpeedBoostExtra") - 5)
		task.wait(2)
		game.Players:FindFirstChild(player).Character:SetAttribute("VitaminsUsed", false)
	end
end)