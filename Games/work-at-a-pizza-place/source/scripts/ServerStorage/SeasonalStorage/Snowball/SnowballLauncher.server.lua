Tool = script.Parent
VELOCITY = 50 -- constant
loaded=false

local Pellet = Tool.Handle:Clone()
Pellet.Name = "Snowball"
script.Parent.SnowballScript:clone().Parent = Pellet


function isTurbo(character)
	return false
end


function fire(v, turbo)


	--wqqqTool.Handle.Fire:play()

-- find player's head pos

	local vCharacter = Tool.Parent
	local vPlayer = game.Players:playerFromCharacter(vCharacter)

	local head = vCharacter:findFirstChild("Head")
	if head == nil then return end


	local launch = head.Position + 10 * v

	local missile = Pellet:clone()
    
	missile.Position = launch
	missile.Velocity = v * 220--160
	missile.Locked = true


	local force = Instance.new("BodyForce")
	force.force = Vector3.new(0,40,0)
	force.Parent = missile

	if (turbo) then
		missile.Velocity = v * 140
		force.force = Vector3.new(0,45,0)
	end

	missile.SnowballScript.Disabled = false

	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = vCharacter
	creator_tag.Name = "creator"
	creator_tag.Parent = missile
	
	missile.Parent = game.Workspace
	
	missile:SetNetworkOwner(vPlayer)

end



function rndDir()
	return Vector3.new(math.random() - .5, math.random() - .5, math.random() - .5).unit
end

Tool.Enabled = true
function onActivated(player,mouseHitp)
	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false
	Tool.Handle.Transparency=1
	local character = Tool.Parent;
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid == nil then
		return 
	end


	local targetPos = mouseHitp --humanoid.TargetPoint
	local lookAt = (targetPos - character.Head.Position).unit

	fire(lookAt )

	wait(2)
	Tool.Enabled = true
Tool.Handle.Transparency=0

	
end

script.Parent.Clicked.OnServerEvent:connect(onActivated)


