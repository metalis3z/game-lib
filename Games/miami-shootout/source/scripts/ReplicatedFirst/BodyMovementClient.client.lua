local Player = game:GetService("Players").LocalPlayer
local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("BodyMovementEvent")
local FactorsR6 = {X = 0.75,Y = 0.75};
local FactorsR15 = {["Torso"] = {X = 0.25,Y = 0.25},["Head"] = {X = 0.5,Y = 0.5}};
function GetRigType(Character:Model)
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end
	return Humanoid.RigType
end
function GetMotor6D(Character:Model,Name:string)
	for _,v:Instance in pairs(Character:GetDescendants()) do
		if v:IsA("Motor6D") and v.Name == Name then
			return v
		end
	end
	return
end
RemoteEvent.OnClientEvent:Connect(function(OtherPlayer:Player,Joint:Motor6D,Angle:CFrame)
	if OtherPlayer == Player then
		return
	end
	Joint.C0 = Angle
end)
game:GetService("RunService").RenderStepped:Connect(function()
	local Camera = workspace.CurrentCamera
	if not Camera then
		return
	end
	local Character = Player.Character
	if not Character then
		return
	end
	local RigType = GetRigType(Character)
	if not RigType then
		return
	end
	local CameraDirection = Character:GetPivot():ToObjectSpace(Camera:GetRenderCFrame()).LookVector
	local CameraX,CameraY = math.asin(CameraDirection.X),math.asin(CameraDirection.Y)
	if RigType == Enum.HumanoidRigType.R15 then
		local Neck = GetMotor6D(Character,"Neck")
		if Neck then
			local NeckPos = CFrame.new(0,Neck.C0.Y,0)
			Neck.C0 = (NeckPos*CFrame.Angles(CameraY*FactorsR15["Head"].Y,-CameraX*FactorsR15["Head"].X,0))
			RemoteEvent:FireServer(Neck,Neck.C0)
		end
		local Waist = GetMotor6D(Character,"Waist")
		if Waist then
			local WaistPos = CFrame.new(0,Waist.C0.Y,0)
			Waist.C0 = (WaistPos*CFrame.Angles(CameraY*FactorsR15["Torso"].Y,-CameraX*FactorsR15["Torso"].X,0))
			RemoteEvent:FireServer(Waist,Waist.C0)
		end
	elseif RigType == Enum.HumanoidRigType.R6 then
		local Neck = GetMotor6D(Character,"Neck")
		if Neck then
			local NeckPos = CFrame.new(0,Neck.C0.Y,0)
			Neck.C0 = (NeckPos*CFrame.Angles(3*math.pi/2,0,math.pi)*CFrame.Angles(-CameraY*FactorsR6.Y,0,-CameraX*FactorsR6.X))
			RemoteEvent:FireServer(Neck,Neck.C0)
		end
	end
end)