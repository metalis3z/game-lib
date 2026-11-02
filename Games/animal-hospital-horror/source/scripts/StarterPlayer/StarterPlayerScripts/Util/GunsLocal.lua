local t = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

game:GetService("TweenService")

local CurrentCamera = workspace.CurrentCamera

function t.ShootEffect(p1, p2) --[[ ShootEffect | Line: 8 | Upvalues: CurrentCamera (copy), LocalPlayer (copy) ]]
	local p = CurrentCamera.CFrame.p
	local v1 = (p2 - p).unit * 60
	local v2 = RaycastParams.new()
	local v3 = game:GetService("CollectionService"):GetTagged("GunIgnore")

	table.insert(v3, LocalPlayer.Character)
	v2.FilterDescendantsInstances = v3
	v2.FilterType = Enum.RaycastFilterType.Exclude
	v2.IgnoreWater = true

	local v4 = workspace:Raycast(p, v1, v2)
	local v6 = v4 and v4.Position or p + v1
	local Part = Instance.new("Part")

	Part.Color = Color3.fromRGB(255, 222, 75)
	Part.Transparency = 0.3
	Part.Anchored = true
	Part.Locked = true
	Part.CanCollide = false
	Part.CanTouch = false
	Part.CanQuery = false

	local magnitude = (p1 - v6).magnitude

	Part.Size = Vector3.new(0.15, 0.15, magnitude)
	Part.CFrame = CFrame.new(p1, v6) * CFrame.new(0, 0, -magnitude / 2)

	local v7 = game.ReplicatedStorage.Misc:FindFirstChild("CartoonSmoke"):Clone()

	v7.Position = v6
	v7.Parent = workspace
	Part.Parent = workspace
	game:GetService("Debris"):AddItem(Part, 0.05)
	game:GetService("Debris"):AddItem(v7, 1)
	v7.Smoke:Emit(10)

	return v6, v4 and v4.Instance or nil
end

return t