-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")

Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
Humanoid.AutoJumpEnabled = false

local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")

local function onPostSimulation(p1) --[[ onPostSimulation | Line: 15 | Upvalues: Humanoid (copy), HumanoidRootPart (copy) ]]
	local v1 = Humanoid:GetState()

	if v1 ~= Enum.HumanoidStateType.Running and v1 ~= Enum.HumanoidStateType.RunningNoPhysics or not (Humanoid.WalkSpeed >= 50 and HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 10) then
		return
	end

	HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity + Vector3.new(0, -50 * p1, 0)
end

local v2 = RunService.PostSimulation:Connect(onPostSimulation)

Humanoid.Died:Connect(function() --[[ Line: 24 | Upvalues: v2 (copy) ]]
	v2:Disconnect()
end)