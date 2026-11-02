local debris = game:GetService("Debris")

script.Parent.RemoteEvent.OnServerEvent:Connect(function(plr, sp, mouse, firerate, power)
	local humanoid = sp.Parent:FindFirstChild("Humanoid")
	local torso = sp.Parent:FindFirstChild("UpperTorso")

	sp.Handle.Transparency = 1
	local throwSound = sp.Handle:FindFirstChild("Throw")
	if throwSound then
		throwSound:Play()
	end

	local shoulder = torso:FindFirstChild("RightUpperArm")
	if shoulder then
		shoulder.CurrentAngle = 2
	end

	local projectile = sp.Handle:Clone()
	projectile.CanCollide = true
	projectile.Transparency = 0
	projectile.Anchored = false

	for _, child in pairs(projectile:GetDescendants()) do
		if child:IsA("Weld") or child:IsA("Motor6D") then
			child:Destroy()
		end
	end

	projectile.Parent = workspace

	local direction = (mouse - torso.Position).Unit
	projectile.CFrame = CFrame.new(torso.Position + direction * 2)
	projectile.Velocity = (direction * power) + Vector3.new(0, 20, 0)

	local scriptClone = script.Parent.LocalScript.Script:Clone()
	scriptClone.Parent = projectile
	scriptClone.Disabled = false

	local creatorTag = Instance.new("ObjectValue")
	creatorTag.Name = "creator"
	creatorTag.Value = plr
	creatorTag.Parent = projectile

	debris:AddItem(projectile, firerate + 10)

	wait(firerate)
	sp.Handle.Transparency = 0
end)
