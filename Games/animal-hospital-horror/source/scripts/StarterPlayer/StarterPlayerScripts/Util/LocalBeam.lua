local t = {}

player = game:GetService("Players").LocalPlayer
function t.ShootEffect(p1, p2) --[[ ShootEffect | Line: 5 ]]
	local beam = Instance.new("Part")

	beam.Name = "beam"
	beam.Color = Color3.fromRGB(255, 222, 75)
	beam.Transparency = 0.3
	beam.Anchored = true
	beam.Locked = true
	beam.CanCollide = false

	local v1 = math.min((p1 - p2).magnitude, 200)

	beam.Size = Vector3.new(0.15, 0.15, v1)
	beam.CFrame = CFrame.new(p1, p2) * CFrame.new(0, 0, -v1 / 2)

	local v2 = game.ReplicatedStorage.Misc:FindFirstChild("CartoonSmoke"):Clone()

	v2.Position = p2
	v2.Parent = workspace
	beam.Parent = workspace
	game:GetService("Debris"):AddItem(beam, 0.05)
	game:GetService("Debris"):AddItem(v2, 1)
	v2.Smoke:Emit(10)
end

return t