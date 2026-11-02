Mouse = game.Players.LocalPlayer:GetMouse()
script.Parent:WaitForChild("Vehicle")
Vehicle = script.Parent.Vehicle.Value
On = false
Mouse.KeyDown:Connect(function(Key)
if Key == "r" then
if On == false then
Vehicle.Body:WaitForChild("Headlights")
Vehicle.Body.Headlights.RemoteEvent:FireServer()
On = true
elseif On == true then
Vehicle.Body.Headlights.RemoteEvent:FireServer()
On = false
end
end
end)