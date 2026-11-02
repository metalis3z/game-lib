local LocalPlayer = game.Players.LocalPlayer
local Debounce = false
local Debris = game:GetService("Debris")

LocalPlayer.Character.Humanoid.Touched:Connect(function(Object)
	
	if Object.Name == "Trampoline_Hitbox" then
		
		if Debounce == false then
			
			Debounce = true
			
			local TrampolineForcePoint = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("TrampolineForcePoint")
			
			if TrampolineForcePoint ~= nil then
				TrampolineForcePoint:Destroy()
			end
			
			local Attachment = Instance.new("Attachment")
			Debris:AddItem(Attachment, Object.LaunchTime.Value)
			Attachment.Name = "TrampolineForcePoint"
			
			local LinearVelocity = Instance.new("LinearVelocity")
			LinearVelocity.MaxForce = math.huge
			LinearVelocity.VectorVelocity = Object.CFrame.UpVector * Object.LaunchPower.Value + (LocalPlayer.Character.HumanoidRootPart.Velocity - Vector3.new(0, LocalPlayer.Character.HumanoidRootPart.Velocity.Y, 0)) * 2.5
			LinearVelocity.Parent = Attachment
			LinearVelocity.Attachment0 = Attachment
			
			Attachment.Parent = LocalPlayer.Character.HumanoidRootPart
			
			local JumpSound = Object.JumpSound:Clone()
			JumpSound.Parent = Object
			JumpSound.PlaybackSpeed = JumpSound.PlaybackSpeed + math.random(-15, 15) / 100
			JumpSound.PlayOnRemove = true
			JumpSound:Destroy()
			
			for _, ParticleEmitter in pairs(Object:GetDescendants()) do
				if ParticleEmitter:IsA("ParticleEmitter") then
					ParticleEmitter:Emit(ParticleEmitter:GetAttribute("EmitCount"))
				end
			end
			
		end
		
		wait(0.1)
		
		Debounce = false
		
	end
	
end)
