script.Parent.OnServerEvent:Connect(function()
	local Car = script.Parent.Parent.Parent.Parent:FindFirstChild('Car').Value
	Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('Siren').Playing = not Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('Siren').Playing
	Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('First').Enabled = Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('Siren').Playing
	Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('Second').Enabled = Car:FindFirstChild('Body'):FindFirstChild('Chalim'):FindFirstChild('TheTop'):FindFirstChild('Siren').Playing
end)