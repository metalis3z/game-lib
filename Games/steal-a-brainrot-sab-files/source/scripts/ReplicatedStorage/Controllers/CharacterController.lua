-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
if game:GetService("RunService"):IsServer() then
	return {}
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Signal = require(Packages.Signal)
local LocalPlayer = Players.LocalPlayer
local Controls = nil

if RunService:IsClient() then
	local PlayerScripts = LocalPlayer.PlayerScripts

	Controls = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls()
end

local t1 = {
	OnCharacterAdded = Signal.new(),
	OnSetCFrame = Signal.new(),
	originalMoveFunction = Controls and Controls.moveFunction
}
local InverseControls = LocalPlayer:GetAttribute("InverseControls")

LocalPlayer:GetAttributeChangedSignal("InverseControls"):Connect(function()
	InverseControls = LocalPlayer:GetAttribute("InverseControls")
end)

if Controls then
	function Controls.moveFunction(p1, p2, p3)
		if InverseControls then
			p2 = -p2
		end

		t1:RequestMove(p1, p2, p3)
	end

	t1.originalMoveFunction = Controls.moveFunction
end

function t1.RequestMove(_: {[any]: any}, p4, vector3: Vector3, b1: boolean)
	if p4:GetAttribute("FreezeLocalMovement") then
		return
	end

	p4:Move(vector3, b1)
end
function t1.WaitForCharacter(_: {[any]: any}, p5)
	local Character = nil
	local v21 = nil
	local v22 = nil

	while not Character do
		Character, v21, v22 = t1:GetCharacter(p5)
		task.wait()
	end

	return Character, v21, v22
end
function t1.GetCharacter(_: {[any]: any}, p6)
	local Character = (p6 or LocalPlayer).Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChild("Humanoid")

	if not Humanoid then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	return Character, Humanoid, HumanoidRootPart
end
function t1.SetCFrame(_: {[any]: any}, cFrame: CFrame)
	local v30, _, v32 = t1:GetCharacter()

	if not v30 then
		return
	end

	v32.CFrame = cFrame
	t1.OnSetCFrame:Fire(cFrame)
end
function t1.Start(_)
	local n1 = 2.08

	local function onCharacterAdded(p8)
		workspace.Gravity = 196.2
		t1.OnCharacterAdded:Fire(p8)

		local Humanoid = p8:WaitForChild("Humanoid")

		if not Humanoid then
			return
		end

		n1 = Humanoid.HipHeight

		local n2 = 0

		Humanoid.StateChanged:Connect(function(oldState, newState)
			if Humanoid.Health <= 0 then
				return
			end

			if ReplicatedStorage:GetAttribute("EggrotHuntEvent") then
				return
			end

			if oldState == Enum.HumanoidStateType.Jumping and newState == Enum.HumanoidStateType.Jumping or oldState == Enum.HumanoidStateType.Freefall and newState == Enum.HumanoidStateType.Jumping then
				n2 += 1
				task.delay(60, function()
					n2 -= 1
				end)

				local v45 = LocalPlayer:GetAttribute("ExtraJumps") or 0

				if n2 >= 5 + v45 then
					Humanoid.Health = 0
				end
			end
		end)
	end

	LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

	if LocalPlayer.Character then
		task.spawn(onCharacterAdded, LocalPlayer.Character)
	end

	RunService.PreSimulation:Connect(function(_: number)
		debug.profilebegin("CharacterController")

		local v40, v41, _ = t1:GetCharacter()

		if not v40 or not v41 then
			debug.profileend()

			return
		end

		v41.HipHeight = v40:GetAttribute("NewHipHeight") or n1
		debug.profileend()
	end)
end

return t1
