local Pad1 = script.Parent.Parent.TP2.TeleportPad
local TP2 = script.Parent.Parent.TP2
local TouchingPlayers = {};
local teleportingValue = script.Parent.Parent.CanUse
local TweenService = game:GetService("TweenService")

local ZapPart = script.Parent.Zap
local ZapPart2 = TP2.Zap
local GlowingPads = script.Parent.GlowingPads
local ParticleParts = script.Parent.ParticleParts
local Lights = script.Parent.TPLights
local Tube = script.Parent.Tube
local teleportLocation = CFrame.new(Pad1.CFrame.X, Pad1.CFrame.Y + 5.5, Pad1.CFrame.Z)

local function ChangeLights(Color)
	local LightTable = {"DecorationLights","GlowingPads","TPLights"}

	for _,ModleName in LightTable do
		for _,Light in TP2[ModleName]:GetChildren() do
			if Light:IsA("Part") then
				Light.Color = Color
			end
		end
		for _,Light in script.Parent[ModleName]:GetChildren() do
			if Light:IsA("Part") then
				Light.Color = Color
			end
		end
	end
end

local LightTween1 = TweenService:Create(Lights.Light1,TweenInfo.new(0.33, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{Color = Color3.fromRGB(255, 255, 0)})
local LightTween2 = TweenService:Create(Lights.Light2,TweenInfo.new(0.33, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{Color = Color3.fromRGB(255, 255, 0)})
local LightTween3 = TweenService:Create(Lights.Light3,TweenInfo.new(0.33, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{Color = Color3.fromRGB(255, 255, 0)})
local TubeTween1 = TweenService:Create(Tube.TPTube,TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = Tube.MaxTube.CFrame, Size = Tube.MaxTube.Size })
local TubeTween2 = TweenService:Create(TP2.Tube.TPTube,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = Tube.TubeEnd.CFrame})


local function ToggleEffects(Value)
	if Value == "Toggle" then
		for _,Particle in ParticleParts:GetDescendants() do
			if Particle:IsA("ParticleEmitter") then
				Particle.Enabled = not Particle.Enabled
			end
		end
	elseif Value then
		ParticleParts.BottomPad.Slow.Enabled = true
		ParticleParts.TopPad.Slow.Enabled = true
		TP2.ParticleParts.TopPad.Slow.Enabled = true
		TP2.ParticleParts.BottomPad.Slow.Enabled = true
		ParticleParts.BottomPad.Accelerate.Enabled = false
		ParticleParts.TopPad.Accelerate.Enabled = false
	else
		ParticleParts.BottomPad.Slow.Enabled = false
		ParticleParts.TopPad.Slow.Enabled = false
		ParticleParts.BottomPad.Accelerate.Enabled = false
		ParticleParts.TopPad.Accelerate.Enabled = false
		TP2.ParticleParts.TopPad.Slow.Enabled = false
		TP2.ParticleParts.BottomPad.Slow.Enabled = false
	end
end

script.Parent.TeleportBox.Touched:Connect(function(touchPart)
	if script.Parent.Zap.Charge.Playing == false then
		if game.Players:GetPlayerFromCharacter(touchPart.Parent) and touchPart.Name == "HumanoidRootPart" then
			if not table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(touchPart.Parent)) then
				table.insert(TouchingPlayers,game.Players:GetPlayerFromCharacter(touchPart.Parent))
			end
		end	
		if touchPart and TouchingPlayers[1] ~= nil and game.Players:GetPlayerFromCharacter(touchPart.Parent) and teleportingValue.Value == true then
			teleportingValue.Value = false
			ZapPart.Charge:Play()
			ToggleEffects("Toggle")
			TubeTween2:Play()
			Tube.TPTube.Poison.Enabled = true
			LightTween1:Play()
			task.wait(0.3)
			LightTween2:Play()
			task.wait(0.3)
			LightTween3:Play()
			wait(0.3)
			TubeTween2:Play()
			task.wait(0.1)

			if TouchingPlayers[1] ~= nil and teleportingValue.Value == false then
				Tube.TPTube.Poison.Enabled = false
				ZapPart.Transparency = 0
				ZapPart2.Transparency = 0
				TweenService:Create(ZapPart,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{Transparency = 1}):Play()
				TweenService:Create(ZapPart2,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{Transparency = 1}):Play()
				local Player = TouchingPlayers[math.random(1,#TouchingPlayers)]
				local Character = Player.Character
				ZapPart.Charge:Stop()
				Character:SetPrimaryPartCFrame(teleportLocation)
				TouchingPlayers = {};
				teleportingValue.Value = false
				ChangeLights(Color3.fromRGB(255,0,0))
				TweenService:Create(Tube.TPTube,TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = Tube.TubeEnd.CFrame, Size = Tube.TubeEnd.Size }):Play()
				ZapPart2.Zap:Play()
				ToggleEffects(false)
				wait(22)
				Tube.TPTube.CFrame = Tube.TubeStart.CFrame
				TP2.Tube.TPTube.CFrame = TP2.Tube.TubeStart.CFrame
				teleportingValue.Value = true
				ChangeLights(Color3.fromRGB(0,255,0))
				ToggleEffects(true)
			else
				Tube.TPTube.CFrame = Tube.TubeStart.CFrame
				TP2.Tube.TPTube.CFrame = TP2.Tube.TubeStart.CFrame
				teleportingValue.Value = true
				ChangeLights(Color3.fromRGB(0,255,0))
				ToggleEffects(true)
			end
		end
	end
end)

script.Parent.TeleportBox.TouchEnded:Connect(function(touchPart)
	if game.Players:GetPlayerFromCharacter(touchPart.Parent) and touchPart.Name == "HumanoidRootPart" then
		if table.find(TouchingPlayers,game.Players:GetPlayerFromCharacter(touchPart.Parent)) then
			for Index,Player in pairs(TouchingPlayers) do
				if Player == game.Players:GetPlayerFromCharacter(touchPart.Parent) then
					table.remove(TouchingPlayers,Index,Player)
					if teleportingValue.Value then
						TubeTween1:Cancel()
						TubeTween2:Cancel()
						LightTween1:Cancel()
						LightTween2:Cancel()
						LightTween3:Cancel()

						Tube.TPTube.Poison.Enabled = false

						TweenService:Create(Tube.TPTube,TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = Tube.TubeStart.CFrame, Size = Tube.TubeStart.Size }):Play()
						Lights.Light1.Color = Color3.fromRGB(0,255,0)
						Lights.Light2.Color = Color3.fromRGB(0,255,0)
						Lights.Light3.Color = Color3.fromRGB(0,255,0)
						TweenService:Create(TP2.Tube.TPTube,TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{CFrame = Tube.TubeEnd.CFrame}):Play()
						teleportingValue.Value = true
						ChangeLights(Color3.fromRGB(0,255,0))
						ToggleEffects(true)
					end
				end
			end
		end
	end
end)