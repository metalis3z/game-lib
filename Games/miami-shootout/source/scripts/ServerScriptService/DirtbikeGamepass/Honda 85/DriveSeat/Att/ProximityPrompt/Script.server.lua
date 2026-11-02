
local userInputService = game:GetService("UserInputService")
local proximityPrompt = script.Parent
local seat = proximityPrompt.Parent.Parent
local plr = nil
local NAMER = seat.Name
local id = 30919642

seat:GetPropertyChangedSignal("Occupant"):Connect(function()
	if seat.Occupant then
		proximityPrompt.Enabled = false
	
	
	else
		proximityPrompt.Enabled = true
		
		
		for _,anim in pairs(plr.Character.Humanoid.Animator:GetPlayingAnimationTracks()) do

			if anim.Name == "HoseHold" then
				anim:Stop()
				break
			end
		end
	
		if plr.PlayerGui:FindFirstChild("Aux") then
			
			plr.PlayerGui:FindFirstChild("Aux"):Destroy()
		end
		plr.PlayerGui:FindFirstChild("Out"):Destroy()
	
	
		plr = nil
	end
end)
local panic = false
proximityPrompt.Triggered:Connect(function(player)
	if player.Name == seat.Owner.Value or seat.Owner.Value == "Everyone" then
		proximityPrompt.Enabled = false
		script.Parent.Parent.Parent.Parent.Name = player.Name.."'s Bike"
		
		plr = player
	

		
		if plr == nil then
			proximityPrompt.Enabled = true
		else
			
			seat.Owner.Value = player.Name
		

			if game:GetService("GamePassService"):PlayerHasPass(player, id) then 
				
				local AuxGUI = script.Aux:Clone()
				AuxGUI.Parent = player.PlayerGui
			end
			
			local Insounds = script.In:Clone()
			Insounds.Parent = player.PlayerGui
			Insounds.Disabled = false
			local out = script.Out:Clone()
			out.Parent = player.PlayerGui
		
			
			player.Character:FindFirstChild("Humanoid").JumpPower = 0
		seat:Sit(player.Character.Humanoid)
			
			plr.PlayerGui:FindFirstChild("Out").Exit.TextButton.MouseButton1Click:Connect(function()


				plr.Character:FindFirstChild("Humanoid").Sit = false
				
				
				
				
			end)
			
		end
		
	
	else
		
		if panic == false then
			panic = true
		
			panic = false
		end
		
		
	end

end)




