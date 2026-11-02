local Pad1 = script.Parent.Parent.Parent.TP1.TeleportPad
local TP1 = script.Parent.Parent.Parent.TP1
local TouchingPlayers = {};
local teleportingValue = script.Parent.Parent.CanUse
local teleportingValue2 = script.Parent.Parent.Parent.TP1.CanUse
script.Parent.Touched:Connect(function(touchPart)
	if script.Parent.Parent.Zap.Charge.Playing == false then
		if game.Players:GetPlayerFromCharacter(touchPart.Parent) and touchPart.Name == "HumanoidRootPart" then
			if not table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(touchPart.Parent)) then
				table.insert(TouchingPlayers,game.Players:GetPlayerFromCharacter(touchPart.Parent))
			end
		end	
		if touchPart and TouchingPlayers[1] ~= nil and game.Players:GetPlayerFromCharacter(touchPart.Parent) and script.Parent.Parent.CanUse.Value == true then
			teleportingValue.Value = false
			teleportingValue2.Value = false
			local teleportLocation = CFrame.new(Pad1.CFrame.X, Pad1.CFrame.Y + 5.5, Pad1.CFrame.Z)
			local ZapPart = script.Parent.Parent.Zap
			local ZapPart2 = script.Parent.Parent.Parent.TP1.Zap
			local GlowingPads = script.Parent.Parent.GlowingPads
			local ParticleParts = script.Parent.Parent.ParticleParts
			local Lights = script.Parent.Parent.TPLights
			ZapPart.Charge:Play()
			ParticleParts.BottomPad.Accelerate.Enabled = true
			ParticleParts.TopPad.Accelerate.Enabled = true
			ParticleParts.BottomPad.Slow.Enabled = false
			ParticleParts.TopPad.Slow.Enabled = false
			wait(1)
			if TouchingPlayers[1] ~= nil and teleportingValue.Value == false then
				local Player = TouchingPlayers[math.random(1,#TouchingPlayers)]
				local Character = Player.Character
				ZapPart.Charge:Stop()
				Character:SetPrimaryPartCFrame(teleportLocation)
				TouchingPlayers = {};
				teleportingValue.Value = false
				teleportingValue2.Value = false
				TP1.ParticleParts.BottomPad.Slow.Enabled = false
				TP1.ParticleParts.TopPad.Slow.Enabled = false
				TP1.GlowingPads.BottomPad.BrickColor = BrickColor.new("Really red")
				TP1.GlowingPads.TopPad.BrickColor = BrickColor.new("Really red")
				TP1.TPLights.Light1.BrickColor = BrickColor.new("Really red")
				TP1.TPLights.Light2.BrickColor = BrickColor.new("Really red")
				TP1.TPLights.Light3.BrickColor = BrickColor.new("Really red")
				wait(0.001)
				ZapPart2.Zap:Play()
				ParticleParts.BottomPad.Accelerate.Enabled = false
				ParticleParts.TopPad.Accelerate.Enabled = false
				ParticleParts.BottomPad.Slow.Enabled = false
				ParticleParts.TopPad.Slow.Enabled = false
				GlowingPads.BottomPad.BrickColor = BrickColor.new("Really red")
				GlowingPads.TopPad.BrickColor = BrickColor.new("Really red")
				Lights.Light1.BrickColor = BrickColor.new("Really red")
				Lights.Light2.BrickColor = BrickColor.new("Really red")
				Lights.Light3.BrickColor = BrickColor.new("Really red")
				wait(22)
				teleportingValue.Value = true
				teleportingValue2.Value = true
				GlowingPads.BottomPad.BrickColor = BrickColor.new("Lime green")
				GlowingPads.TopPad.BrickColor = BrickColor.new("Lime green")
				Lights.Light1.BrickColor = BrickColor.new("Lime green")
				Lights.Light2.BrickColor = BrickColor.new("Lime green")
				Lights.Light3.BrickColor = BrickColor.new("Lime green")
				ParticleParts.BottomPad.Slow.Enabled = true
				ParticleParts.TopPad.Slow.Enabled = true
				TP1.ParticleParts.BottomPad.Slow.Enabled = true
				TP1.ParticleParts.TopPad.Slow.Enabled = true
				TP1.GlowingPads.BottomPad.BrickColor = BrickColor.new("Lime green")
				TP1.GlowingPads.TopPad.BrickColor = BrickColor.new("Lime green")
				TP1.TPLights.Light1.BrickColor = BrickColor.new("Lime green")
				TP1.TPLights.Light2.BrickColor = BrickColor.new("Lime green")
				TP1.TPLights.Light3.BrickColor = BrickColor.new("Lime green")
			else
				GlowingPads.BottomPad.BrickColor = BrickColor.new("Lime green")
				GlowingPads.TopPad.BrickColor = BrickColor.new("Lime green")
				Lights.Light1.BrickColor = BrickColor.new("Lime green")
				Lights.Light2.BrickColor = BrickColor.new("Lime green")
				Lights.Light3.BrickColor = BrickColor.new("Lime green")
				ParticleParts.BottomPad.Slow.Enabled = true
				ParticleParts.BottomPad.Accelerate.Enabled = false
				ParticleParts.TopPad.Accelerate.Enabled = false
				ParticleParts.TopPad.Slow.Enabled = true
				TP1.ParticleParts.BottomPad.Slow.Enabled = true
				TP1.ParticleParts.TopPad.Slow.Enabled = true
				TP1.GlowingPads.BottomPad.BrickColor = BrickColor.new("Lime green")
				TP1.GlowingPads.TopPad.BrickColor = BrickColor.new("Lime green")
				TP1.TPLights.Light1.BrickColor = BrickColor.new("Lime green")
				TP1.TPLights.Light2.BrickColor = BrickColor.new("Lime green")
				TP1.TPLights.Light3.BrickColor = BrickColor.new("Lime green")
				wait(0.5)
				teleportingValue.Value = true
				teleportingValue2.Value = true

			end
		end
	end
end)
script.Parent.Touched:Connect(function(Part)
	
end)
script.Parent.TouchEnded:Connect(function(touchPart)
	if game.Players:GetPlayerFromCharacter(touchPart.Parent) and touchPart.Name == "HumanoidRootPart" then
		if table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(touchPart.Parent)) then
			for Index,Player in pairs(TouchingPlayers) do
				if Player == game.Players:GetPlayerFromCharacter(touchPart.Parent) then
					table.remove(TouchingPlayers,Index,Player)
				end
			end
		end
	end
end)