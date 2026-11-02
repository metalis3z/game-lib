local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local camPart = Instance.new("Part", workspace:WaitForChild("Ignore"):WaitForChild(player.Name))
camPart.Transparency = 1
camPart.CanCollide = false
camPart.CanQuery = false
camPart.Anchored = true
camPart.Name = "SimulatedCamera"
local simCapsule = game:GetService("ReplicatedStorage").Resource.CapsuleCollider:Clone()
simCapsule.Parent = workspace
camera.CameraSubject = camPart

game:GetService("RunService").Heartbeat:Connect(function(dt)
	camPart.Position = workspace:WaitForChild("Ignore"):WaitForChild(player.Name).Position + Vector3.new(0,3,0)
	simCapsule.Position = workspace:WaitForChild("Ignore"):WaitForChild(player.Name).Position + Vector3.new(0,3,0)
	simCapsule.Name = player.Name .. "Capsule"
end)