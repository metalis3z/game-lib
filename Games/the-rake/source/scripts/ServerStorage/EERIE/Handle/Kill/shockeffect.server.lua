
		local bv = Instance.new("BodyVelocity")
		bv.Velocity = script.Parent.HumanoidRootPart.CFrame.lookVector * 13
		bv.P = 1250
		bv.MaxForce = Vector3.new(4000,4000,4000)
		bv.Parent = game.Workspace.The_Rake.HumanoidRootPart
		game.Workspace.The_Rake.NPC.Jump = true
		wait(4)
		game.Workspace.The_Rake.Torso.HitParticle.Enabled = false
		bv:Destroy()
		wait(1.5)
		game.Workspace.The_Rake.Torso.HitParticle:Destroy()
script:Destroy()