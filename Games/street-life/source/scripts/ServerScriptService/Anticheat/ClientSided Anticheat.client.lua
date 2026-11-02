if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:FindService('Players')
local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild('Backpack')
local PlayerGui = Backpack
local Character = Player.Character or Player.CharacterAdded:Wait()

local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
local Humanoid = Character:WaitForChild('Humanoid')

local ReplicatedStorage = game:FindService('ReplicatedStorage')
local Script
local Remote 

local LogService = game:FindService('LogService')
local MessageOut = LogService.MessageOut


task.wait(2)

for _,v in ipairs(PlayerGui:GetChildren()) do
	if v:IsA('LocalScript') and string.find(v.Name, '%d') and string.find(v.Name, 'Camera') then
		Script = v
	end
end
for _,v in ipairs(ReplicatedStorage:GetChildren()) do
	if v:IsA('RemoteEvent') and string.find(v.Name, '%d') and not string.find(v.Name, '%a') then
		Remote = v
	end
end

Backpack.ChildAdded:Connect(function(Child)
	if Child:IsA('HopperBin') then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
		print('1')
	end
end)

local Flagged = {'BodyGyro', 'BodyPosition', 'BodyAngularVelocity', 'BodyThrust', 'SelectionBox', 'HumanoidRootPart', 'Humanoid'}
Character.ChildAdded:Connect(function(Child)
	if table.find(Flagged, Child.ClassName) then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
		print('2')
	end
end)

Character.ChildRemoved:Connect(function(Child)
	if table.find(Flagged, Child.ClassName) then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
		print('255')
	end
end)

Humanoid.ChildAdded:Connect(function(Child)
	if table.find(Flagged, Child.ClassName) then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
		print('3')
	end
end)

HumanoidRootPart.ChildAdded:Connect(function(Child)
	if table.find(Flagged, Child.ClassName) then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
		print('4')
	end
end)

Character.ChildRemoved:Connect(function(Child)
	if Script then
		if Child:IsA('LocalScript') and Child.Name == Script.Name then
			Humanoid.Health = 0
			Remote:FireServer(Remote.Name)
			print('5')
		end
	end
end)

MessageOut:Connect(function(Message)
	Message = string.lower(Message)
	if string.find(Message, 'no humanoid.') or string.find(Message, 'remoteevent') or string.find(Message, 'hub') then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
		print('6')
		return
	end	
end)

if not Script then
	repeat for _,v in ipairs(PlayerGui:GetChildren()) do
			if v:IsA('LocalScript') and string.find(v.Name, '%d') and string.find(v.Name, 'Camera') then
				Script = v
			end
		end
		task.wait(.1)
	until Script  
end

Script:GetPropertyChangedSignal('Enabled'):Connect(function()
	if Script then
		if not Script.Enabled then
			Script.Enabled = true
			Remote:FireServer(Remote.Name)
			print('AAAAAAAAAAAAA')
			return
		end
	end
end)

while task.wait(1) and (true) do
	if Humanoid.WalkSpeed > 50 then
		Humanoid.WalkSpeed = 10
		Remote:FireServer(Remote.Name)
		print('B')
	elseif Humanoid.JumpPower > 50 then
		Humanoid.JumpPower = 50
		Remote:FireServer(Remote.Name)
		print('G')
	end
	if not Script then
		Humanoid.Health = 0
		Remote:FireServer(Remote.Name)
	end
end