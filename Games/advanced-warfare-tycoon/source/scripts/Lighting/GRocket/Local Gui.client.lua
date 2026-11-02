local Tool = script.Parent
local Bulletd=Instance.new("Part")
Bulletd.Name="Bullet"
Bulletd.BrickColor=BrickColor.new("New Yeller")
Bulletd.Anchored=true
Bulletd.CanCollide=false
Bulletd.Locked=true
Bulletd.Size=Vector3.new(1,1,1)
Bulletd.Transparency=0.2
Bulletd.formFactor=0
Bulletd.TopSurface=0
Bulletd.BottomSurface=0
meshd=Instance.new("BlockMesh")
meshd.Parent=Bulletd
meshd.Name="Mesh"
meshd.Scale=Vector3.new(0.5,0.5,1)
local RayLength=1000
local busy = false
local Walking = false
local Firingle = true
local RFire = false
local Shooting = false
local sp = Tool.Spread	
local HClone = script.Parent.Handle:clone()
HClone.CanCollide = false
local firstunequip = true
local crouched = 1
local ArmHold = true
local Melee = 1
local Pos1 = false
local Pos2 = false
local Pos3 = false
local Pos4 = false
local printing = 1
local equipped = false

function WeldGun()
local w = Instance.new("Weld")
w.Parent = script.Parent.Handle
w.Part0 = script.Parent.Handle
w.Part1 = script.Parent.Knife
w.C0 = CFrame.new(0,-0.5,0.5) * CFrame.fromEulerAnglesXYZ(math.pi/2,0,0)
end

function cross(vector1, vector2)
return Vector3.new(vector1.y * vector2.z - vector2.y * vector1.z, vector1.z * vector2.x - vector1.x * vector2.z, vector1.x * vector2.y - vector2.x * vector1.y)
end

function dot(vector1, vector2)
return (vector1.x * vector2.x + vector1.y * vector2.y + vector1.z * vector2.z)
end

function getLineSphereCollide(linePoint1, lineVector, sphereCenter, radius)
local a = lineVector.x * lineVector.x + lineVector.y * lineVector.y + lineVector.z * lineVector.z
local b = lineVector.x * (linePoint1.x - sphereCenter.x) + lineVector.y * (linePoint1.y - sphereCenter.y) + lineVector.z * (linePoint1.z - sphereCenter.z)
local c = (linePoint1.x - sphereCenter.x) * (linePoint1.x - sphereCenter.x) + (linePoint1.y - sphereCenter.y) * (linePoint1.y - sphereCenter.y) + (linePoint1.z - sphereCenter.z) * (linePoint1.z - sphereCenter.z) - radius * radius
if (a > 0) and (b * b >= a * c) then
local diff = math.sqrt(b * b - a * c)
return ((-b - diff) / a), ((diff - b) / a)
else
return -1, -1
end
end

function raycast(model, start, vector, brickFunction)
local hit, normal, time = raycastRecursive(model, start, vector, brickFunction, vector.unit, dot(start, vector.unit))
if (dot(normal, vector) > 0) then
normal = -normal
end
return hit, start + time * vector, normal.unit, time
end
function raycastRecursive(model, start, vector, brickFunction, unitVec, startDist)
if (model.className == "Part") or (model.className == "Seat") or (model.className =="SpawnLocation") then
local range = model.Size.magnitude / 2
local dist = dot(model.Position, unitVec) - startDist
if (dist + range > 0) and (dist - range < vector.magnitude) and ((dist * unitVec + start - model.Position).magnitude < range) and brickFunction(model) then
local halfSize = model.Size / 2
if model.className ~= "SpawnLocation" then
if (model.Shape == Enum.PartType.Ball) then
local time, timeMax = getLineSphereCollide(start, vector, model.Position, halfSize.x)
if (time < 1) and (time >= 0) then
return model, (time * vector + start - model.Position), time
else
return nil, Vector3.new(0, 0, 0), 1
end
elseif (model.Shape == Enum.PartType.Block) then
local time = 1
local cf = model.CFrame - model.Position
local xvec = cf * Vector3.new(1, 0, 0)
local yvec = cf * Vector3.new(0, 1, 0)
local zvec = cf * Vector3.new(0, 0, 1)
local xspd = -dot(xvec, vector)
local yspd = -dot(yvec, vector)
local zspd = -dot(zvec, vector)
local xmin, xmax, ymin, ymax, zmin, zmax = -1
local dotProd = dot(xvec, start - model.Position)
if (xspd ~= 0) then
xmin = (dotProd - halfSize.x) / xspd
xmax = (dotProd + halfSize.x) / xspd
if (xmax < xmin) then
local swap = xmin
xmin = xmax
xmax = swap
end
else
if (math.abs(dotProd) < halfSize.x) then
xmax = 1
xmin = 0
else
return nil, Vector3.new(0, 0, 0), 1
end
end
local dotProd = dot(yvec, start - model.Position)
if (yspd ~= 0) then
ymin = (dotProd - halfSize.y) / yspd
ymax = (dotProd + halfSize.y) / yspd
if (ymax < ymin) then
local swap = ymin
ymin = ymax
ymax = swap
end
else
if (math.abs(dotProd) < halfSize.y) then
ymax = 1
ymin = 0
else
return nil, Vector3.new(0, 0, 0), 1
end
end
local dotProd = dot(zvec, start - model.Position)
if (zspd ~= 0) then
zmin = (dotProd - halfSize.z) / zspd
zmax = (dotProd + halfSize.z) / zspd
if (zmax < zmin) then
local swap = zmin
zmin = zmax
zmax = swap
end
else
if (math.abs(dotProd) < halfSize.z) then
zmax = 1
zmin = 0
else
return nil, Vector3.new(0, 0, 0), 1
end
end
if (xmin <= ymax) and (xmax >= ymin) and (xmin <= zmax) and (xmax >= zmin) and (zmin <= ymax) and (zmax >= ymin) then
local normal = xvec
local min = xmin
if (ymin > min) then
min = ymin
normal = yvec
end
if (zmin > min) then
min = zmin
normal = zvec
end
if (min >= 0) and (min < 1) then
time = min
elseif (xmax > 0) and (ymax > 0) and (zmax > 0) and (min < 0) then
time = 0
normal = Vector3.new(0, 0, 0)
end
return model, normal, time
else
return nil, Vector3.new(0, 0, 0), 1
end
else
local time = 1
local cf = model.CFrame - model.Position
local xvec = cf * Vector3.new(1, 0, 0)
local xspd = -dot(xvec, vector)
local xmin, xmax = -1
local dotProd = dot(xvec, start - model.Position)
if (xspd ~= 0) then
xmin = (dotProd - halfSize.x) / xspd
xmax = (dotProd + halfSize.x) / xspd
if (xmax < xmin) then
local swap = xmin
xmin = xmax
xmax = swap
end
else
if (math.abs(dotProd) < halfSize.x) then
xmax = 1
xmin = 0
else
return nil, Vector3.new(0, 0, 0), 1
end
end

local relVec = cf:pointToObjectSpace(vector) * Vector3.new(0, 1, 1)
local relPos = model.CFrame:pointToObjectSpace(start) * Vector3.new(0, 1, 1)
local rmin, rmax = getLineSphereCollide(relPos, relVec, Vector3.new(0, 0, 0), halfSize.y)
if (xmin <= rmax) and (xmax >= rmin) and (rmax > 0) then
local normal = xvec
local min = xmin
if (rmin > min) then
min = rmin
normal = cf * (relPos + relVec * min)
end
if (min >= 0) and (min < 1) then
time = min
elseif (xmax > 0) and (rmax > 0) and (min < 0) then
time = 0
normal = Vector3.new(0, 0, 0)
end
return model, normal, time
else
return nil, Vector3.new(0, 0, 0), 1
end
return nil, Vector3.new(0, 0, 0), 1
end
end
end
return nil, Vector3.new(0, 0, 0), 1
elseif (model.className=="Model") or (model.className=="Workspace") or (model.className=="Hat") or (model.className == "Tool") then
local children=model:GetChildren()
local time=1
local normal=Vector3.new(0, 0, 0)
local hit=nil
for n = 1, #children do
if children[n]~= nil then
local newHit, newNormal, newTime = raycastRecursive(children[n], start, vector, brickFunction, unitVec, startDist)
if (newTime < time) then
time = newTime
hit = newHit
normal = newNormal
end
end
end
return hit, normal, time
else
return nil, Vector3.new(0, 0, 0), 1
end
end

function Fire(aim)
local hole = Instance.new("Part")
hole.Shape = 0
hole.Name = "BulletHole"
hole.TopSurface = 0
hole.BottomSurface = 0
hole.Anchored = true
hole.CanCollide = false
hole.BrickColor = BrickColor.new(26)
hole.Size = Vector3.new(1,1,1)
holeMesh = Instance.new("SpecialMesh")
holeMesh.MeshType = "Sphere"
holeMesh.Scale = Vector3.new(0.7,0.7,0.7)
holeMesh.Parent = hole
local hr = script.HoleRemove:clone()
hr.Parent = hole
hr.Disabled = false
hole.Parent = game.Workspace  
Tool.Fire:play()
local bullet=Bulletd:clone()
local totalDist=0
Lengthdist=-RayLength/.5
local startpoint=(Tool.Handle.CFrame*CFrame.new(-0,0,0)).p
local dir=aim-startpoint
dir=computeDirection(dir)
local cfrm=CFrame.new(startpoint, dir+startpoint)
	local hit,pos,normal,time=raycast(game.Workspace, startpoint, cfrm*Vector3.new(0,0,Lengthdist)-startpoint, function(brick)
	if brick.Name=="Bullet" or brick.Name=="BulletEffect" or brick.Name == "Blood" or brick.Name == "BulletHole" then
	return false
	elseif brick:IsDescendantOf(Tool) or brick:IsDescendantOf(Tool.Parent) then
	return false
	elseif brick.Parent.className=="Tool" or brick.Parent.className=="Hat" or brick.Parent.Name=="Accoutrement" or brick.className == "SpawnLocation" then
	return false
	end
	return true
	end)
bullet.Parent=game.Workspace
if hit~=nil then
local humanoid=hit.Parent:FindFirstChild("Humanoid")
	if humanoid~=nil and humanoid.className=="Humanoid" then
		if humanoid.Health > 0 then
			if hit.Name=="Head" then
			damage=100
			else
			damage=25
			end
		humanoid:TakeDamage(damage)
		end
	end
distance=(startpoint-pos).magnitude
bullet.CFrame=cfrm*CFrame.new(0,0,-distance/2)
bullet.Mesh.Scale=Vector3.new(.15,.15,distance)
hole.CFrame = CFrame.new(pos)
else
bullet.CFrame=cfrm*CFrame.new(0,0,-RayLength/2) 
bullet.Mesh.Scale=Vector3.new(.15,.15,RayLength)
end
coroutine.resume(coroutine.create(function (item) 
wait(math.random(35, 40)/100)
item:remove() end), bullet)
wait(0.01)
end

function Run(speed)
if speed > 0 then
sp.Value = 15
Walking = true
else
sp.Value = 5
Walking = false
end
end

function computeDirection2(pos)
local invrtDir = 1 / math.sqrt((pos.magnitude * pos.magnitude))
local dir = Vector3.new(pos.x * invrtDir, pos.y * invrtDir, pos.z * invrtDir)
return dir
end

function onButton1Down(mouse)
enabled = true
Shooting = true
	while Shooting do wait()
		if Firingle == true and Shooting == true then
			if RFire == false then
			local mag=(Tool.Parent.Humanoid.TargetPoint-(script.Parent.Handle.CFrame*CFrame.new(-0,0,1)).p).magnitude
			local rndm=Vector3.new((math.random(-sp.Value,sp.Value)/250)*mag,(math.random(-sp.Value,sp.Value)/250)*mag,(math.random(-sp.Value,sp.Value)/250)*mag)
			Fire(Tool.Parent.Humanoid.TargetPoint + rndm)
			else
			return
			end
		else
		return
		end
	end
end

function onButton1Up(mouse)
Shooting = false
enabled = false
firing = false
end

function computeDirection(vec)
local lenSquared = vec.magnitude * vec.magnitude
local invSqrt = 1 / math.sqrt(lenSquared)
return Vector3.new(vec.x * invSqrt, vec.y * invSqrt, vec.z * invSqrt)
end

function keyPressed(key)
key:lower()
if key == "" then
if Melee == 1 then
script.Parent.Melee.Value = 1
Melee = 0
ArmHold = false
local p = game.Players.LocalPlayer
local c = p.Character
local t = c.Torso
local rs = t["Right Shoulder"]
if ArmHold == true then
printing = 1
elseif ArmHold == false then
Pos1 = true
wait(0.2)
Pos1 = false
Pos2 = true
Tool.Knife.Transparency = 0
Tool.Handle.Transparency = 1
wait(0.2)
Pos2 = false
Pos3 = true
wait(0.2)
Pos3 = false
Pos4 = true
wait(0.2)
Pos4 = false
ArmHold = true
wait(0.2)
Tool.Knife.Transparency = 1
Tool.Handle.Transparency = 0
script.Parent.Melee.Value = 0
Melee = 1
end
elseif Melee == 0 then
return
end
else
return
end
end

function unEquip()
equipped = false
script.Parent.Handle.Transparency = 1
script.Parent.Knife.Transparency = 1
if firstunequip == true then
firstunequip = false
handle = HClone:clone()
handle.Name = "Gun"
local p = game.Players.LocalPlayer.Character:GetChildren()
for i = 1,#p do
if p[i].Name == "Gun" then
p[i]:Remove()
end
end
handle.Parent = game.Players.LocalPlayer.Character
local w = Instance.new("Weld")
local torso = game.Players.LocalPlayer.Character.Torso
w.Parent = torso.Parent["Left Leg"]
w.Part0 = torso
w.Part1 = handle
w.C0 = CFrame.new(1,-1.5,0) * CFrame.fromEulerAnglesXYZ(math.pi/-4,0,0)
else
hgun = game.Players.LocalPlayer.Character:findFirstChild("Gun")
if hgun ~= nil then
hgun.Transparency = 1
end
end
local p = game.Players.LocalPlayer
local c = p.Character
local t = c.Torso
local h = c.Humanoid
h.WalkSpeed = 16
end

function GetLookVector(part, vector)
return CFrame.new(part.CFrame.p, part.CFrame.p + vector)
end

function onEquippedLocal(mouse)
equipped = true
mouse.Icon = "http://www.roblox.com/asset/?id=15324984"
WeldGun()
local p = game.Players.LocalPlayer.Character:GetChildren()
for i = 1,#p do
if p[i].Name == "Gun" then
p[i].Transparency = 1
end
end
if mouse == nil then
print("Mouse not found")
return 
end
mouse.Icon = "http://www.roblox.com/asset/?id=15324984"
Tool.Parent.Humanoid.Running:connect(Run)
mouse.Button1Down:connect(function() onButton1Down(mouse) end)
mouse.Button1Up:connect(function() onButton1Up(mouse) end)
mouse.KeyDown:connect(keyPressed)
Tool.Unequipped:connect(unEquip)
while true do
wait()
local camera = game.Workspace.CurrentCamera
local torso = game.Players.LocalPlayer.Character.Torso
local position = GetLookVector(torso, camera.CoordinateFrame.lookVector)
if equipped == true then
--torso.CFrame = position
printing = 1
else
printing = 1
end
local p = game.Players.LocalPlayer
local c = p.Character
local t = c.Torso
local rs = t["Right Shoulder"]
if ArmHold == true then
printing = 1
elseif ArmHold == false then
if Pos1 == true then
rs.DesiredAngle = 0
elseif Pos2 == true then
rs.DesiredAngle = 4
elseif Pos3 == true then
rs.DesiredAngle = 2
elseif Pos4 == true then
rs.DesiredAngle = 3
elseif Pos1 == false and Pos2 == false and Pos3 == false and Pos4 == false then
return
end
end
end
end

Tool.Equipped:connect(onEquippedLocal)