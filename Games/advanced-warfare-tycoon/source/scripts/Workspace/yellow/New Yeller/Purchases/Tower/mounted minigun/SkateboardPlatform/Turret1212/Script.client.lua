math.randomseed(tick())
firin = false
smoken = 0

function onB1D(mouse)
firin = true
smoken = 0
while firin do 
wait(0.09)
if mouse.Target.Parent ~= script.Parent.Vehicle.Value and mouse.Target.Parent.Parent ~= script.Parent.Vehicle.Value then
script.Parent.Vehicle.Value.Barrel.Fire:Play()
script.Parent.Vehicle.Value.Barrel.Transparency = 0.5
theTar = mouse.Hit.p + Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
bull = Instance.new("Part")
bull.Parent = nil
bull.CFrame = CFrame.new((theTar + script.Parent.Vehicle.Value.Barrel.Position)/2,script.Parent.Vehicle.Value.Barrel.Position)
bull.CanCollide = false
bull.BrickColor = BrickColor.new(24)
bull.Anchored = true
bull.formFactor = 0
bull.Name = "Bullet"
bull.Transparency = 0.4
bull.Size = Vector3.new(1,1,1)
mesher = Instance.new("BlockMesh")
mesher.Parent = bull
mesher.Scale = Vector3.new(0.3, 0.3, (mouse.Hit.p - script.Parent.Vehicle.Value.Barrel.Position).magnitude)
script.Cle:clone().Parent = bull
every = game.Workspace:GetChildren()
for thing = 1, #every do
if every[thing] ~= nil then
if every[thing].className == "Model" then
if every[thing]:findFirstChild("Torso") ~= nil then
if every[thing]:findFirstChild("Torso").className == "Part" then
if (every[thing]:findFirstChild("Torso").Position - theTar).magnitude < 2 then
if every[thing]:findFirstChild("Humanoid") ~= nil then
every[thing].Humanoid.Health = every[thing].Humanoid.Health - math.random(6, 13)
end
end
end
end
end
end
end
bull.Parent = game.Workspace
smoken = smoken + 1
if smoken > 10000000000000000 then
script.Parent.Vehicle.Value.Barrel.Smoke.Enabled = true
end
script.Parent.Vehicle.Value.Barrel.Transparency = 0
end
end
end

function onB1U(mouse)
firin = false
smoken = 0
script.Parent.Vehicle.Value.Barrel.Smoke.Enabled = false
end

function onM(mouse)
if mouse.Target ~= nil then
if mouse.Target.Parent:findFirstChild("Humanoid") ~= nil then
mouse.Icon = "http://www.roblox.com/asset/?id=23805077"
elseif mouse.Target.Parent:findFirstChild("Humanoid") == nil then
mouse.Icon = "http://www.roblox.com/asset/?id=23746854"
end
elseif mouse.Target == nil then
mouse.Icon = "http://www.roblox.com/asset/?id=23746854"
end
end


function onI(mouse)
if mouse.Target ~= nil then
if mouse.Target.Parent:findFirstChild("Humanoid") ~= nil then
mouse.Icon = "http://www.roblox.com/asset/?id=23805077"
elseif mouse.Target.Parent:findFirstChild("Humanoid") == nil then
mouse.Icon = "http://www.roblox.com/asset/?id=23746854"
end
elseif mouse.Target == nil then
mouse.Icon = "http://www.roblox.com/asset/?id=23746854"
end
end


function onSele(mouse)
	print(mouse.Icon)
mouse.Button1Down:connect(function() onB1D(mouse) end)
mouse.Button1Up:connect(function() onB1U(mouse) end)
mouse.Move:connect(function() onM(mouse) end)
mouse.Idle:connect(function() onI(mouse) end)
mouse.Icon = "http://www.roblox.com/asset/?id=23746854"
end

script.Parent.Selected:connect(onSele)
script.Parent.Deselected:connect(function(mouse)
	mouse.Icon = ""
end)
