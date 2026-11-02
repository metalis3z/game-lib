script.Parent.Activate.OnServerEvent:Connect(function(Player, State)
	if State then
		if Player.Character and Player.Character:FindFirstChild("UpperTorso") then
			local l_SpeedTrail_0 = script.SpeedTrail:Clone();
			l_SpeedTrail_0.Parent = Player.Character.UpperTorso;
			l_SpeedTrail_0.Attachment0 = Player.Character.UpperTorso.NeckAttachment;
			l_SpeedTrail_0.Attachment1 = Player.Character.UpperTorso.WaistRigAttachment;
			l_SpeedTrail_0.Enabled = true;
			task.delay(5, function()
				l_SpeedTrail_0.Enabled = false;
				wait(1);
				l_SpeedTrail_0:Destroy();
			end);
		end;
	end;
end);