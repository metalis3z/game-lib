Tool = script.Parent
RemoteEvent = Tool:WaitForChild("RemoteEvent")
Animation = script.Parent:WaitForChild("Animation")

Enabled = false

Tool.Equipped:Connect(function(Mouse)

if Mouse ~= nil then
local Player = Tool.Parent
local Humanoid = Player:FindFirstChild("Humanoid")

Mouse.Button1Down:Connect(function()
if Humanoid ~= nil and Humanoid.Health > 0 then

if Enabled == true then
return
end

Enabled = true

local Animate = Humanoid:LoadAnimation(Animation)
if Animate then
Animate:Play()
end
RemoteEvent:FireServer()
wait(15)
Enabled = false
end
end)

end
end)