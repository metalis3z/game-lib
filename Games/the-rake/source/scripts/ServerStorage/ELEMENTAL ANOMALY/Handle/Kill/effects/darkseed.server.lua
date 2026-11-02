
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
		wait(6)
game.Workspace.The_Rake.Torso.darkseedhitparticle.Enabled = false
game.Workspace.The_Rake.Torso.darkseedhit:Destroy()
		bv:Destroy()
		bv2:Destroy()
		bv3:Destroy()
		wait(1.5)
game.Workspace.The_Rake.Torso.darkseedhitparticle:Destroy()	
script:Destroy()