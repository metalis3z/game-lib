--credit to quartz games studio
local Players = game:GetService("Players")
local v1 = script.Parent
local LocalPlayer = Players.LocalPlayer
local v2 = false

v1.CanCollide = false
v1.Touched:Connect(function(p1) --[[ Line: 9 | Upvalues: LocalPlayer (copy), v2 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	if not p1:IsDescendantOf(Character) then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	if HumanoidRootPart.AssemblyLinearVelocity.Y < 0 then
		return
	end

	if not v2 then
		v2 = true
		HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 80, 0)
		task.wait(0.25)
		v2 = false
	end
end)