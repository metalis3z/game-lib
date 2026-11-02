if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local BankRobbery = game:FindService('ReplicatedStorage'):WaitForChild('BankRobbery')

BankRobbery:GetPropertyChangedSignal('Value'):Connect(function()
	if BankRobbery.Value == true then
		script.Parent.Enabled = true
		task.spawn(function()
			for _ = 1, 75 do
				script.Parent:FindFirstChild('TextLabel').TextColor3 = Color3.fromRGB(255, 0, 4)
				task.wait(.2)
				script.Parent:FindFirstChild('TextLabel').TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end)
		task.wait(15)
		script.Parent.Enabled = false
	else
		script.Parent.Enabled = false
	end
end)