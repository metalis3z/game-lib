local Character = script.Parent
local Humanoid = Character:FindFirstChild("Humanoid")
Humanoid.BreakJointsOnDeath = false
local Head = Character:FindFirstChild("Head")
local Torso = Character:FindFirstChild("Torso")
local Larm = Character:FindFirstChild("Left Arm")
local Rarm = Character:FindFirstChild("Right Arm")
local Lleg = Character:FindFirstChild("Left Leg")
local Rleg = Character:FindFirstChild("Right Leg")
function onDeath (Chr)
	Character.MovingTorso.Client.Disabled = true
	Character.MovingTorso.Server.Disabled = true
	Character:FindFirstChildOfClass("Humanoid").AutoRotate = false
if Head then
	local Neck = Instance.new("Weld")
	Neck.Part0 = Torso
	Neck.Part1 = Head
	Neck.Parent = Neck.Part0
	Neck.C0 = CFrame.new(0, 1.5, 0)
	Neck.C1 = CFrame.new()
	Neck.Name = "Neck2"
	wait(0.01)
	Torso.Neck:Remove()
end
if Rarm then
	Rarm.CFrame = Torso.CFrame * CFrame.new(1.5, 0, 0)
	local RS = Instance.new("Glue")
	RS.Part0 = Torso
	RS.Part1 = Rarm
	RS.Parent = RS.Part0
	RS.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	RS.C1 = CFrame.new(-0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	RS.Name = "RightShoulder"
	wait(0.01)
	Torso["Right Shoulder"]:Remove()
end
if Larm then
	Larm.CFrame = Torso.CFrame * CFrame.new(-1.5, 0, 0)
	local LS = Instance.new("Glue")
	LS.Part0 = Torso
	LS.Part1 = Larm
	LS.Parent = LS.Part0
	LS.C0 = CFrame.new(-1.5, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	LS.C1 = CFrame.new(0, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	LS.Name = "LeftShoulder"
	wait(0.01)
	Torso["Left Shoulder"]:Remove()
end
if Rleg then
	Rleg.CFrame = Torso.CFrame * CFrame.new(0.5, -2, 0)
	local RH = Instance.new("Glue")
	RH.Part0 = Torso
	RH.Part1 = Rleg
	RH.Parent = RH.Part0
	RH.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	RH.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	RH.Name = "RightHip"
	wait(0.01)
	Torso["Right Hip"]:Remove()
end
if Lleg then
	Lleg.CFrame = Torso.CFrame * CFrame.new(-0.5, -2, 0)
	local LH = Instance.new("Glue")
	LH.Part0 = Torso
	LH.Part1 = Lleg
	LH.Parent = LH.Part0
	LH.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	LH.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	LH.Name = "LeftHip"
	wait(0.01)
	Torso["Left Hip"]:Remove()
end
end
Humanoid.Died:Connect(onDeath)