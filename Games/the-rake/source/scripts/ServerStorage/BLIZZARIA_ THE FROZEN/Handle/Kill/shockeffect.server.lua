
		local bv = Instance.new("BodyVelocity")
		bv.Velocity = script.Parent.HumanoidRootPart.CFrame.lookVector * 10
		bv.P = 10000
		bv.MaxForce = Vector3.new(500000,500000,500000)
		bv.Parent = game.Workspace.The_Rake.HumanoidRootPart
		game.Workspace.The_Rake.NPC.Jump = true
		local bv2 = Instance.new("BodyVelocity")
		bv.Velocity = script.Parent.HumanoidRootPart.CFrame.lookVector * 5
		bv.P = 5000
		bv.MaxForce = Vector3.new(500000,500000,500000)
		bv.Parent = game.Workspace.The_Rake.HumanoidRootPart
		game.Workspace.The_Rake.NPC.Jump = true
		local bv3 = Instance.new("BodyVelocity")
		bv.Velocity = script.Parent.HumanoidRootPart.CFrame.lookVector * 5
		bv.P = 15000
		bv.MaxForce = Vector3.new(500000,500000,500000)
		bv.Parent = game.Workspace.The_Rake.HumanoidRootPart
		game.Workspace.The_Rake.NPC.Jump = true
		local iceblock = game.ReplicatedStorage.Special.Ice:Clone()
		iceblock.Parent = game.Workspace.The_Rake.HumanoidRootPart
		iceblock.Orientation = game.Workspace.The_Rake.HumanoidRootPart.Orientation
iceblock.Position = game.Workspace.The_Rake.HumanoidRootPart.Position
game.Workspace.The_Rake.Head.Anchored = true
game.Workspace.The_Rake.Torso.Anchored = true
game.Workspace.The_Rake["Left Arm"].Anchored = true
game.Workspace.The_Rake["Right Arm"].Anchored = true
game.Workspace.The_Rake["Left Leg"].Anchored = true
game.Workspace.The_Rake["Right Leg"].Anchored = true
		iceblock.Anchored = true
		iceblock.CanCollide = true
		wait(6)
		game.Workspace.The_Rake.Torso.HitParticle.Enabled = false
		bv:Destroy()
		bv2:Destroy()
		bv3:Destroy()
		wait(1.5)
		game.Workspace.The_Rake.Torso.HitParticle:Destroy()
wait(5)
game.Workspace.The_Rake.Head.Anchored = false
game.Workspace.The_Rake.Torso.Anchored = false
game.Workspace.The_Rake["Left Arm"].Anchored = false
game.Workspace.The_Rake["Right Arm"].Anchored = false
game.Workspace.The_Rake["Left Leg"].Anchored = false
game.Workspace.The_Rake["Right Leg"].Anchored = false
		iceblock:Destroy()
script:Destroy()