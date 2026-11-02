local Tool = script.Parent
local Trap = nil
local debris = game:GetService("Debris")
local CanPlace = false

function plant(pos)
    if CanPlace == false then
	CanPlace = true

	local vCharacter = Tool.Parent
	local vPlayer = game.Players:GetPlayerFromCharacter(vCharacter)

	Trap = Instance.new("Part")
	Trap.Locked = false
	Trap.Size = Vector3.new(1.5, 1.02, 1.5)
	Trap.Name = "BearTrap"
	Trap.CanCollide = true
	Trap.Anchored = false
	Trap.Position = pos

	local mesh1 = Tool.Handle.Mesh1:Clone()
	mesh1.Parent = Trap
		
	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = vPlayer
	creator_tag.Name = "creator"
	creator_tag.Parent = Trap

	local stunsound = Tool.GetStun:Clone()
	stunsound.Parent = Trap
	stunsound.Name = "GetStun"

	local trapscript = Tool.BeartrapScript:Clone()
	trapscript.Parent = Trap
	trapscript.Disabled = false
	
	local mesh2 = Tool.Mesh2:clone()
	mesh2.Parent = trapscript
    
	Trap.Parent = game.Workspace

	debris:AddItem(Trap, 600)
	wait()
     CanPlace = false
end
end



while wait() do
    if script.Parent.Placed.Value == true then
	local character = Tool.Parent;
	local humanoid = character.Humanoid
	if humanoid == nil then
		print("Humanoid not found")
		return 
	end

	local targetPos = humanoid.TargetPoint
	local vCharacter = Tool.Parent
		plant(Tool.Handle.Position)
	script.Parent.Parent.Humanoid.WalkSpeed=10
	script.Parent.Parent.RunScript.Disabled=false
	script.Parent.Parent.StopScript.Stop.Value = false		
	script.Parent.Parent.StopScript.Disabled = true
	script.Parent.Placed.Value = true
	script.Parent.Placing.Value = false
	script.Parent.Handle.Sound:Stop()
	script.Parent.Bar.Value = 0
	Tool.Enabled = true
	Tool:Destroy()
	end
	end

