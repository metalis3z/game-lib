-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Players").LocalPlayer
local v1 = script.Parent
local u2 = v1:WaitForChild("Humanoid")
local v3 = game:GetService("RunService")
local u4 = v1:WaitForChild("HumanoidRootPart")
u2.AutoJumpEnabled = false
local u10 = v3.PostSimulation:Connect(function(p5) -- name: onPostSimulation
	-- upvalues: (copy) u2, (copy) u4
	local v6 = u2:GetState()
	if (v6 == Enum.HumanoidStateType.Running or v6 == Enum.HumanoidStateType.RunningNoPhysics) and (u2.WalkSpeed >= 50 and u4.AssemblyLinearVelocity.Magnitude > 10) then
		local v7 = u4
		local v8 = v7.AssemblyLinearVelocity
		local v9 = -50 * p5
		v7.AssemblyLinearVelocity = v8 + Vector3.new(0, v9, 0)
	end
end)
u2.Died:Connect(function()
	-- upvalues: (copy) u10
	u10:Disconnect()
end)