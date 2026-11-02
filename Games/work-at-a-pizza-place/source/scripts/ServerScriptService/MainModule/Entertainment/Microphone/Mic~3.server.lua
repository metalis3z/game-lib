local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

position = CFrame.new(model.StandBase.Position) * (model.StandBase.CFrame.lookVector * 2) + Vector3.new(0,4,0)

--[[local p = Instance.new("Part")
p.Parent = game.Workspace
p.Anchored = true
p.CFrame = CFrame.new(position)]]
	
	workspace.Main.Chatted.OnServerEvent:connect(function(speaker,msg)
		if speaker.Character and speaker.Character:FindFirstChild("Head") and speaker:DistanceFromCharacter(position) < 3.5 then
			
			for i,player in ipairs(game.Players:GetPlayers()) do
				
				if player.Character ~= nil and player.Character:FindFirstChild("Head") ~= nil and player:DistanceFromCharacter(speaker.Character.Head.Position) < 40 then
					spawn(function() --UPDATECHANGE
						if player == speaker or game:GetService("Chat"):CanUserChatAsync(speaker.userId,player.userId) then
							local filteredMessage
							pcall(function() filteredMessage = game:GetService("Chat"):FilterStringAsync(msg,speaker,player) end)
							if filteredMessage and filteredMessage ~= "" then
								workspace.Main.Microphone:FireClient(player,speaker.Name .. ": " .. filteredMessage)

							end
						end
					end)
				end
			end
		end
	end)
	

