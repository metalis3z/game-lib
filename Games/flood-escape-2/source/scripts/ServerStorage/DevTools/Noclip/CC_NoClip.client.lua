--I HATE THIS CODE

local userinput = game:GetService("UserInputService")
local tool = script.Parent
local player = game.Players.LocalPlayer
local cam = workspace.CurrentCamera
local selected = false

local speed = 1.5

function getNextMovement()
	local nextMove = Vector3.new(0,0,0)
	if userinput:IsKeyDown("W") then
		nextMove = nextMove + Vector3.new(0,0,-1)
	end
	if userinput:IsKeyDown("S") then
		nextMove = nextMove + Vector3.new(0,0,1)
	end
	if userinput:IsKeyDown("A") then
		nextMove = nextMove + Vector3.new(-1,0,0)
	end
	if userinput:IsKeyDown("D") then
		nextMove = nextMove + Vector3.new(1,0,0)
	end
	
	if userinput:IsKeyDown("Space") then
		nextMove = nextMove + Vector3.new(0,1,0)
	elseif userinput:IsKeyDown("LeftControl") then
		nextMove = nextMove + Vector3.new(0,-1,0)
	end
	return CFrame.new(nextMove*speed)
	
end

tool.Equipped:Connect(function()
	local human = player.Character.Humanoid
	local rootpart = player.Character.HumanoidRootPart
	human.PlatformStand = true
	rootpart.Anchored = true
	selected = true
	while selected do
		wait()
		local look = (cam.Focus.Position - cam.CFrame.Position).Unit
		local pos = rootpart.Position
		local nextMove = getNextMovement()
		rootpart.CFrame = CFrame.new(pos,pos+look) * nextMove
	end
end)

tool.Unequipped:Connect(function()
	selected = false
	player.Character.Humanoid.PlatformStand = false
	player.Character.HumanoidRootPart.Anchored = false
end)



