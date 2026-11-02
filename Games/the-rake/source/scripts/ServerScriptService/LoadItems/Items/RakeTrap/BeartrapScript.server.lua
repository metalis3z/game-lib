
local Trap = script.Parent

local touched = false

wait(1.5)

Trap.Anchored = false

function onTouched(part)
if touched == true then
	return end
	local RakeHuman = part.Parent:FindFirstChild("NPC")
	if RakeHuman ~= nil and touched == false and workspace.Trapped.Value == false then
		workspace.Trapped.Value = true
		touched = true
		script.Parent.CanCollide=false
        workspace.The_Rake.Stunning.Value = 1
		workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 7
		workspace.The_Rake.Torso.CFrame = Trap.CFrame
		local humanoid = game.Workspace.The_Rake:FindFirstChild("NPC")
	humanoid.Health = humanoid.Health - 1000
		Trap.GetStun:Play()
		workspace.The_Rake.NPC.PlatformStand = true
		wait(0.1)
workspace.The_Rake.NPC.PlatformStand = false
		Trap.Transparency =  Trap.Transparency + 1
		workspace.The_Rake["Right Leg"].BeartrapPart.Transparency =  Trap.Transparency - 1
      wait(0.2)
          workspace.The_Rake.Head.RakeHurt4:Play()
		     wait(7)
		 workspace.The_Rake.Stunning.Value = 0
workspace.The_Rake["Right Leg"].BeartrapPart.Transparency =  Trap.Transparency + 1
      Trap.CanCollide = false
        Trap:Destroy()
	end

end

Trap.Touched:Connect(onTouched)
