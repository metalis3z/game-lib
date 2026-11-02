---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CloneTrooper1019, 2014
-- Realism Mode (Client Side)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
wait(.1) -- Local Scripts can be really annoying sometimes.

player = game.Players.LocalPlayer
c = workspace.CurrentCamera
rs = game:GetService("RunService")

char = script.Parent.Parent -- player.Character or player.CharacterAdded:wait()

while not char:IsDescendantOf(game) do
	wait(.1)
end

humanoid = char.Humanoid -- char:WaitForChild("Humanoid")
head = char.Head -- char:WaitForChild("Head")
torso = char.Torso -- char:WaitForChild("Torso")
root = char.HumanoidRootPart -- char:WaitForChild("HumanoidRootPart")
lshoulder = torso["Left Shoulder"] -- torso:WaitForChild("Left Shoulder")
rshoulder = torso["Right Shoulder"] -- torso:WaitForChild("Right Shoulder")
neck = torso["Neck"] -- torso:WaitForChild("Neck")

waveScale = 0
scaleIncrement = 0.05 --0.05
lastY = 0
pi2 = math.pi*2

offStates = {"Jumping","PlatformStanding","Ragdoll","Seated","FallingDown","FreeFalling","GettingUp","Swimming"}
onStates = {"Running","Climbing"}

active = false
rs = game:GetService("RunService")
connections = {}

server = script.Parent
updateY = server:WaitForChild("UpdateY")

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RIG = {
	[rshoulder] =
	{
		C0 = rshoulder.C0;
		C1 = rshoulder.C1;
	    Factor = Vector3.new(0,0,1/1);--0,0,1/3
	};
	[lshoulder] = 
	{
		C0 = lshoulder.C0;
		C1 = lshoulder.C1;
		Factor = Vector3.new(0,0,-1/1);--0,0,-1/3
	};
	[neck] =
	{
		C0 = neck.C0;
		C1 = neck.C1;
		Factor = Vector3.new(-1/1,0,0);--2/3,0,0
	};
}
	
for _,state in pairs(offStates) do
	table.insert(connections,humanoid[state]:connect(function ()
		active = false
	end))
end

for _,state in pairs(onStates) do
	table.insert(connections,humanoid[state]:connect(function (speed)
		active = (speed>1)
	end))
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

table.insert(connections,rs.RenderStepped:connect(function ()
	if active then
		if waveScale < 0.5 then
			waveScale = math.min(0.5,waveScale+scaleIncrement)
		end
	else
		if waveScale > 0 then
			waveScale = math.max(0,waveScale-scaleIncrement)
		end
	end
	local abs,cos = math.abs,math.cos
	local camY = c.CoordinateFrame.lookVector.Y
	if script.Parent.Server.Disabled == false then
	updateY:FireServer(camY)
	end
	for joint,def in pairs(RIG) do
		joint.C0 = def.C0 * CFrame.Angles(def.Factor.X*camY,def.Factor.Y*camY,def.Factor.Z*camY)
		joint.C1 = def.C1
	end
end))

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


