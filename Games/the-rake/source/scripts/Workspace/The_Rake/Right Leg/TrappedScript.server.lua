local Tool = script.Parent;
local Trap = script.Parent.BeartrapPart

Trap.Changed:Connect(function()
	if Trap.Transparency == 0 then
		workspace.Trapped.Value = true
		wait(7)
		
		--workspace.Stunned.Value = 0
		--script.Parent.Parent.BugValue.Value = 1
		--script.Parent.Parent.UvFix.UvValue.Value=1
		--wait()
		--script.Parent.Parent.BugFix.Disabled = true
		--script.Parent.Parent.UvFix.Disabled=true
		--wait()
		--script.Parent.Parent.BugValue.Value = 0
		--script.Parent.Parent.UvFix.UvValue.Value=0
		--script.parent.Parent.RagdollPart1.CanCollide = false
		--script.parent.Parent.RagdollPart2.CanCollide = false
		--script.parent.Parent.RagdollPart3.CanCollide = false
		--script.parent.Parent.RagdollPart4.CanCollide = false
		--script.Parent.Parent.RagdollPart5.CanCollide = false
		--script.parent.Parent.Torso["Neck"].Part1=script.Parent.parent.Head
		--script.parent.Parent.Torso["Left Hip"].Part1=script.Parent.parent["Left Leg"]
		--script.parent.Parent.Torso["Right Hip"].Part1=script.Parent.parent["Right Leg"]
		--script.parent.Parent.Torso["Left Shoulder"].Part1=script.Parent.parent["Left Arm"]
		--script.parent.Parent.Torso["Right Shoulder"].Part1=script.Parent.parent["Right Arm"]
		--script.Parent.Parent.Configuration.StunTime.Value = 0
		--script.Parent.Parent.Torso.Swing:Stop()
		--script.Parent.Parent.Torso.Anchored = false
		--script.Parent.Parent.NPC.PlatformStand = false
		--script.Parent.Parent.Torso.HitBox.DamageScript.Disabled = false
		--script.Parent.Parent.MainScript.Disabled = false
		--script.Parent.Parent.Stunning.Value = false
		--script.Parent.Parent.NPC.WalkSpeed = script.Parent.Parent.Configuration.WalkSpeed.Value
		workspace.Trapped.Value = false
		
		local p = Trap:Clone()
		local Clank = script.Parent.BeartrapPart.Clank:Clone()
		Clank.Parent = p
		p.Name = "ReleasedTrap"
		p.qRelativeCFrameWeldValue:Destroy()
		p.qCFrameWeldThingy:Destroy()
		p.CanCollide = true
		p.Release.Disabled = false
		p.Parent = game.Workspace
		
		
		Trap.Transparency = 1
		end
	end)
