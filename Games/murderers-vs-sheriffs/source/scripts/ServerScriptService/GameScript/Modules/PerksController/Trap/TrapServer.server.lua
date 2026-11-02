local l_TrapSystem_0 = game.ReplicatedStorage.TrapSystem;

l_TrapSystem_0.PlaceTrap.OnServerInvoke = function(p1, p2)
	local PlayerData = game.ReplicatedStorage.GetPlayerData_REMOTE:Invoke();
	if not (PlayerData[p1.Name] == nil) then
		if PlayerData[p1.Name].Role == "Murderer" and PlayerData[p1.Name].Perk == "Trap" then
			local v1 = script.Parent.Trap:Clone();
			v1.PlacedPlayer.Value = p1;
			v1.Parent = p1.Character;
			v1:SetPrimaryPartCFrame(p2 - Vector3.new(0,3,0));
			v1.TrapVisual.Orientation = Vector3.new(-90, v1.TrapVisual.Orientation.Y, v1.TrapVisual.Orientation.Z);
			v1.TrapVisual.Touched:Connect(function(Hit)
				if Hit.Parent:FindFirstChild('Humanoid') then
					local v2 = game.Players:GetPlayerFromCharacter(Hit.Parent);
					if v2 and v2 ~= v1.PlacedPlayer.Value then
						game.ReplicatedStorage.TrapSystem.TrapHitLocal:FireClient(v2, v1, v2);
						v1.TrapVisual.CanTouch = false;
					end;
				end;
			end);
			l_TrapSystem_0.PlaceTrapLocal:FireClient(p1, v1);
			return v1;
		end;
	end;
end;

l_TrapSystem_0.TrapReplicate.OnServerEvent:Connect(function(p3,p4,p5)
	l_TrapSystem_0.TrapNotification:FireAllClients(p4);
	l_TrapSystem_0.TrapHitVisual:FireAllClients(p4,p5,p3);
	task.wait(4);
	p4:Destroy();
end);
