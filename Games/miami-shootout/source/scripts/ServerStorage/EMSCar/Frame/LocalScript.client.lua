print("WAITING FOR A CAR")
repeat wait() until script.Parent.Car.Value ~= nil
print("SIREN LOADED")
local car = script.Parent.Car.Value

local buttons = script.Parent:GetChildren()

function honk()
	car:FindFirstChild("SirenPlay"):FireServer(car,"honk")
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.H then
		honk()
	end
end)

for ind,button in pairs(buttons) do
	if button:IsA("TextButton") then
		
		button.MouseButton1Click:Connect(function()
			if button.Name == "Honk" then
				honk()
			elseif button.Name == "STOP" then
				car:FindFirstChild("SirenPlay"):FireServer(car,"stopsirens")
			else
				car:FindFirstChild("SirenPlay"):FireServer(car,"play",button.Name)
			end
		end)
		
	end
end

local lights = script.Parent.lights

lights.On.MouseButton1Click:Connect(function()
	car:FindFirstChild("SirenPlay"):FireServer(car,"lights","rumbler","on")	
end)

lights.Off.MouseButton1Click:Connect(function()
	car:FindFirstChild("SirenPlay"):FireServer(car,"lights","rumbler","off")	
end)

local spotLightC = script.Parent.spotlight

spotLightC.On.MouseButton1Click:Connect(function()
	car:FindFirstChild("SirenPlay"):FireServer(car,"spotlight","on")
end)

spotLightC.Off.MouseButton1Click:Connect(function()
	car:FindFirstChild("SirenPlay"):FireServer(car,"spotlight","off")
end)