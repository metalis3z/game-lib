local col = game:GetService("CollectionService")

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg)
		if msg:lower() == "/vc" or msg:lower() == "/joinvc" or msg:lower() == "/e vc" or msg:lower() == "/e joinvc" then
			if game.PlaceId == 9874911474 then
				
				if not game:GetService("VoiceChatService"):IsVoiceEnabledForUserIdAsync(p.UserId) then
					return game.ReplicatedStorage.server:FireClient(p,"alert","Must have VC to tp to VC server!")
				end
				
				if col:HasTag(p,"cuffed") then
					return game.ReplicatedStorage.server:FireClient(p,"alert","Can't tp to VC server while handcuffed!")
				end
				
				if p.Character.Humanoid.Health ~= p.Character.Humanoid.MaxHealth then
					return game.ReplicatedStorage.server:FireClient(p,"alert","Must be full HP to tp to VC server!")
				end
				
				game:GetService("TeleportService"):Teleport(12982974948, p)
				game.ReplicatedStorage.server:FireClient(p,"lmsg","Teleporting to VC server...")
			end
		end
	end)
end)