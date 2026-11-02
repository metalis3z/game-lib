On = false
Lights = script.Parent.G1:GetChildren()

script.Parent.RemoteEvent.OnServerEvent:Connect(function(Mode)
if On == false then
for i = 1,#Lights do
Lights[i].Material = Enum.Material.Neon
On = true
end
elseif On == true then
for i = 1,#Lights do
Lights[i].Material = Enum.Material.SmoothPlastic
On = false
end	
end
end)

