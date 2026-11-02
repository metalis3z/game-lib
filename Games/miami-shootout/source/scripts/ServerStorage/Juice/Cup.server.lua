local CD = false
local tool = script.Parent
local handle = script.Parent.Handle
local anim = Instance.new("Animation")
local plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
local animation = plr.Character.Humanoid:LoadAnimation(script.Parent.Cup.Cork)
anim.AnimationId = "http://www.roblox.com/Asset?ID=12689400081" 
local track3
tool.Equipped:Connect(function()
	wait(0.01)
	track3 = script.Parent.Parent.Humanoid:LoadAnimation(anim)
	track3.Priority = Enum.AnimationPriority.Action
	track3.Looped = true
	track3:Play()
end)
tool.Unequipped:Connect(function()
	if track3 then
		track3:Stop()
	end
end)



script.Parent.Activated:Connect(function()
	
	if script.Parent.Infos.Sips.Value >= 1 then
		if CD == false then
		
			
			CD = true
			local track = script.Parent.Parent.Humanoid:LoadAnimation(script.Sip)

			track:Play()
			wait(0.3)
			script.Parent.Handle.Att.ParticleEmitter.Enabled = true
			handle.Drink:Play()
			wait(0.4)
			script.Parent.Handle.Att.ParticleEmitter.Enabled = false
			wait(0.8)
			script.Parent.Infos.Sips.Value = script.Parent.Infos.Sips.Value - 1
			
			if  script.Parent.Infos.Sips.Value == 0 then
				local track2 = script.Parent.Parent.Humanoid:LoadAnimation(script.Done)
				
				animation:Play()
				handle["Open Lid"]:Play()
				handle["Lid "].Transparency = 0
				wait(1)
				track2:Play()
				wait(0.25)
				handle["Plastic Cup"]:Play()
				
				local can = script.Parent.Handle:Clone()
				can.Parent = game.Workspace
				can.CFrame = script.Parent.Handle.CFrame
				can.Velocity = (script.Parent.Handle.CFrame.rightVector) * 7.5 + Vector3.new(0,math.random(8, 23),math.random(-5,5))
				can.RotVelocity = Vector3.new(0,math.random(50,300),0)
				script.Parent.Handle.Transparency = 1
				can.CanCollide = true
				local Debris = game:GetService("Debris")
				Debris:AddItem(can, 30)
				track3:Stop()
			tool:Destroy()
				
			end
			CD = false
	end
		
	end
	
	
end)