local Tool = script.Parent
local Ball = Tool.Handle
local MouseLoc = Tool:WaitForChild("MouseLoc",10)

function fire(direction)

	Tool.Handle.Boing:Play()

	local vCharacter = Tool.Parent
	local vPlayer = game.Players:GetPlayerFromCharacter(vCharacter)

	local missile = Instance.new("Part")       

	local spawnPos = vCharacter.PrimaryPart.Position

	spawnPos  = spawnPos + (direction * 5)

	missile.Position = spawnPos
	missile.Size = Vector3.new(2,2,2)
	missile.Velocity = direction * 200
	missile.BrickColor = BrickColor.Random()
	missile.Shape = 0
	missile.Locked = true
	missile.BottomSurface = 0
	missile.TopSurface = 0
	missile.Name = "Cannon Shot"
	missile.Elasticity = 1
	missile.Reflectance = .2
	missile.Friction = 0

	Tool.Handle.Boing:Clone().Parent = missile
	
	local new_script = script.Parent.CannonBall:Clone()
	new_script.Disabled = false
	new_script.Parent = missile

	local creator_tag = Instance.new("ObjectValue")
	creator_tag.Value = vPlayer
	creator_tag.Name = "creator"
	creator_tag.Parent = missile

	missile.Parent = workspace
end



Tool.Enabled = true
function onActivated()
	if not Tool.Enabled then
		return
	end
	Tool.Enabled = false
	local character = Tool.Parent;
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		print("Humanoid not found")
		return 
	end
	local targetPos = MouseLoc:InvokeClient(game:GetService("Players"):GetPlayerFromCharacter(character))
	local lookAt = (targetPos - character.Head.Position).unit
	fire(lookAt)
	wait(2)
	Tool.Enabled = true
end


Tool.Activated:Connect(onActivated)

