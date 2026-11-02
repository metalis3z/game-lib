if not game:IsLoaded() then game.Loaded:Wait() end

local mouse = game.Players.LocalPlayer:GetMouse()
local Event = script:FindFirstChild('SirenHandler')
local Car = script.Parent.Parent:FindFirstChild('Car').Value
local Sound = Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('Siren')

mouse.KeyDown:connect(function(key)
	if key == "f" then 
		Event:FireServer()
	end
end)

script.Parent.Interact.MouseButton1Click:Connect(function()
	Event:FireServer()
end)