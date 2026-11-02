


function onChatted(msg, recipient, speaker) 
--	local ogskin = speaker.Character.Head.Color
local source = string.lower(speaker.Name) -- Converts name of speaker to lowercase
msg = string.lower(msg)

	if (msg == "/gloves") then --Chat Command
		
		
		if not speaker.Character.LeftHand:FindFirstChild("Glove") then
			
			function RightOn()
				
				G1 = script.Glove:Clone()
				G1.Face = Enum.NormalId.Front
				G1.Parent = speaker.Character.RightHand


				G2 = script.Glove:Clone()
				G2.Face = Enum.NormalId.Back
				G2.Parent = speaker.Character.RightHand


				G3 = script.Glove:Clone()
				G3.Face = Enum.NormalId.Left
				G3.Parent = speaker.Character.RightHand


				G4 = script.Glove:Clone()
				G4.Face = Enum.NormalId.Right
				G4.Parent = speaker.Character.RightHand


				G5 = script.Glove:Clone()
				G5.Face = Enum.NormalId.Top
				G5.Parent = speaker.Character.RightHand


				G6 = script.Glove:Clone()
				G6.Face = Enum.NormalId.Bottom
				G6.Parent = speaker.Character.RightHand
				
				-----------------------------------
			
				
				
				
			end
			function LeftOn()
				

				G11 = script.Glove:Clone()
				G11.Face = Enum.NormalId.Front
				G11.Parent = speaker.Character.LeftHand


				G22 = script.Glove:Clone()
				G22.Face = Enum.NormalId.Back
				G22.Parent = speaker.Character.LeftHand


				G33 = script.Glove:Clone()
				G33.Face = Enum.NormalId.Left
				G33.Parent = speaker.Character.LeftHand


				G44 = script.Glove:Clone()
				G44.Face = Enum.NormalId.Right
				G44.Parent = speaker.Character.LeftHand


				G55 = script.Glove:Clone()
				G55.Face = Enum.NormalId.Top
				G55.Parent = speaker.Character.LeftHand


				G66 = script.Glove:Clone()
				G66.Face = Enum.NormalId.Bottom
				G66.Parent = speaker.Character.LeftHand

			end
			local On = speaker.Character.Humanoid:LoadAnimation(script.On)
			On:Play()
			wait(0.5)
			LeftOn()
			
			wait(0.5)
			RightOn()
			
			
			
		else
			
			
			if speaker.Character.RightHand:FindFirstChild("Glove") then
			
				function RightOff()
					
					
					local children = speaker.Character.RightHand:GetChildren()
					for i = 1, #children do
						if  children[i].Name == "Glove" then
							children[i]:Destroy()
							
							
						end
					end
					
					
					
					
				end
				
				function LeftOff()


					local children = speaker.Character.LeftHand:GetChildren()
					for i = 1, #children do
						if  children[i].Name == "Glove" then
							children[i]:Destroy()


						end
					end




				end
				
				
				
				local Off = speaker.Character.Humanoid:LoadAnimation(script.Off)
				Off:Play()
				wait(0.5)

				RightOff()
				wait(0.5)
				LeftOff()
				
				
			end
		end
		
		
	
	end 

end 


-- Do not edit without experience.
function onPlayerEntered(newPlayer) 
newPlayer.Chatted:connect(function(msg, recipient) onChatted(msg, recipient, newPlayer) end) 
end 

game.Players.ChildAdded:connect(onPlayerEntered)



