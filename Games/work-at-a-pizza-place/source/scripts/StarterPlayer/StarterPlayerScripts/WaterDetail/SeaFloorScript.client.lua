
local seaFloor = nil
if not workspace:FindFirstChild("SeaFloor") then
	seaFloor = game.ReplicatedStorage.SeaFloor:clone()
	seaFloor.Parent = workspace
else
	seaFloor = workspace.SeaFloor
end
local player = game.Players.LocalPlayer

while player.Character == nil do wait() end

local torso = player.Character:WaitForChild("HumanoidRootPart")

while seaFloor and seaFloor.Parent do
	wait(1.1)
	if not torso or not torso.Parent then
		torso = player.Character:WaitForChild("HumanoidRootPart",5)
	end
	if torso and (torso.Position.Y < 2.337 or torso.Velocity.Y < -60) then
		if player:DistanceFromCharacter(seaFloor.Position) > 20 then
			seaFloor.CFrame = CFrame.new(Vector3.new(torso.Position.X,-27.63,torso.Position.Z))
		end
		wait(2)
	end
end

script:Destroy()