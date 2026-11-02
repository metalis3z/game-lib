if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:FindService('Players')
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')

local ReplicatedStorage = game:FindService('ReplicatedStorage')
local Remote 
local Script

task.wait(4) 

for _,v in ipairs(Character:GetChildren()) do
	if v:IsA('LocalScript') and string.find(v.Name, '%d') and not string.find(v.Name, '%a') then
		Script = v
	end
end
for _,v in ipairs(ReplicatedStorage:GetChildren()) do
	if v:IsA('RemoteEvent') and string.find(v.Name, '%d') and not string.find(v.Name, '%a') then
		Remote = v
	end
end

Character.ChildRemoved:Connect(function(Child)
	if Script then
		if Child:IsA('LocalScript') and Child.Name == Script.Name then
			Remote:FireServer(Remote.Name)
			print('aaaa')
			return
		end
	end
end)

if not Script then
	repeat for _,v in ipairs(Character:GetChildren()) do
			if v:IsA('LocalScript') and string.find(v.Name, '%d') and not string.find(v.Name, '%a') then
				Script = v
			end
		end
		task.wait(.1)
	until Script
end

Script:GetPropertyChangedSignal('Enabled'):Connect(function()
	if not Script.Enabled then
		Script.Enabled = true
		Remote:FireServer(Remote.Name)
		return
	end
end)

while task.wait(1) do
	if not Script then
		Remote:FireServer(Remote.Name)
	end
end