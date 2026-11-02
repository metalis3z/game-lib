--// BatArchiTechMan

local Monitor = script.Parent.Parent.Parent:WaitForChild("Heart Monitor")
local Beep = Monitor.Screen.Beep
local Gui = Monitor.Screen.SignGui
local ContentAmount = script.Parent.Parent.Parent:WaitForChild("IV Bag").ContentAmount

local PlayerOn = false

local WaitTime = 1.6

local Broken = script.Broken

script.Parent.Changed:connect(function(property)
		if property ~= 'Occupant' then return end
   			local Occupant = script.Parent.Occupant
    			if Occupant and ContentAmount.Value > 0 then	
				local BPM = math.random(70, 125)
	        		local Character = Occupant.Parent
	        		local Player = game.Players:GetPlayerFromCharacter(Character)
	 			if Player then 
					PlayerOn=true     
					while PlayerOn and ContentAmount.Value > 0 and not Broken.Value do
						if not PlayerOn then
							break
						end
						if ContentAmount.Value == 0 then
							break
						end
						local Humanoid = Player.Character.Humanoid
						wait(WaitTime * (Humanoid.Health / 100))
						if not PlayerOn then
							break
						end
						local ChanceOfDestroy = math.random(1, 300)
						if ChanceOfDestroy == 1 then
							Broken.Value = true
							Monitor.Screen.Broke:Play()
							Monitor.Screen.Sparkles.Enabled = true
						end
						Beep:Play()
						if Humanoid.Health <= 25 then
							Gui.PulseLabel.Text = "Critical"
							Gui.PulseLabel.TextColor3 = Color3.fromRGB(255, 119, 119)
							Gui.BPM.Text = BPM * 1.75 .. " BPM"
						elseif Humanoid.Health <= 50 then
							Gui.PulseLabel.Text = "Moderate"
							Gui.BPM.Text = BPM * 1.5 .. " BPM"
							Gui.PulseLabel.TextColor3 = Color3.fromRGB(255, 173, 7)
						elseif Humanoid.Health <= 75 then
							Gui.PulseLabel.Text = "Low"
							Gui.PulseLabel.TextColor3 = Color3.fromRGB(239, 255, 58)
							Gui.BPM.Text = BPM * 1.25 .. " BPM"
						else
							Gui.BPM.Text = BPM .. " BPM"
							Gui.PulseLabel.Text = "Fine"
							Gui.PulseLabel.TextColor3 = Color3.fromRGB(107, 255, 99)
						end
						ContentAmount.Value = ContentAmount.Value - 1
						Humanoid.Health = Humanoid.Health + 1	
					end
	   	    		end
    	else
		PlayerOn=false
		Gui.BPM.Text = "N/A"
		Gui.PulseLabel.Text = "N/A"
		Gui.PulseLabel	.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end)