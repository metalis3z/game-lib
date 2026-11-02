

local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
v1.LocalPlayer.CharacterAdded:Connect(function(p3)

	local v4 = p3:WaitForChild("HumanoidRootPart", 5)
	if v4 then
		u2.RenderStepped:Wait()
		local v5 = workspace.CurrentCamera
		if v5 then
			local v6 = v4.CFrame.LookVector
			local v7 = v4.Position - v6 * 12 + Vector3.new(0, 4, 0)
			v5.CFrame = CFrame.lookAt(v7, v4.Position + Vector3.new(0, 1, 0))
		end
	else
		return
	end
end)