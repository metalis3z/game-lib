---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CloneTrooper1019, 2014
-- Realism Mode (Client Side)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
wait() -- Local Scripts can be really annoying sometimes.

player = game.Players.LocalPlayer
c = workspace.CurrentCamera
rs = game:GetService("RunService")

char = script.Parent -- player.Character or player.CharacterAdded:wait()

while not char:IsDescendantOf(game) do
	wait()
end

humanoid = char.Humanoid -- char:WaitForChild("Humanoid")
head = char.Head -- char:WaitForChild("Head")
torso = char.Torso -- char:WaitForChild("Torso")
root = char.HumanoidRootPart -- char:WaitForChild("HumanoidRootPart")
rootJ = root.RootJoint -- root:WaitForChild("RootJoint")
lhip = torso["Left Hip"] -- torso:WaitForChild("Left Hip")
lshoulder = torso["Left Shoulder"] -- torso:WaitForChild("Left Shoulder")
rshoulder = torso["Right Shoulder"] -- torso:WaitForChild("Right Shoulder")
rhip = torso["Right Hip"] --torso:WaitForChild("Right Hip")
neck = torso["Neck"] -- torso:WaitForChild("Neck")

waveScale = 0
scaleIncrement = 0.05
lastY = 0
pi2 = math.pi*2

offStates = {"Jumping","PlatformStanding","Ragdoll","Seated","FallingDown","FreeFalling","GettingUp","Swimming"}
onStates = {"Running","Climbing"}

active = false
rs = game:GetService("RunService")
connections = {}

server = script.Parent

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RIG = {
	[rootJ] = 
	{
		C0 = rootJ.C0 * CFrame.new(-1,0,0);
		C1 = rootJ.C1 * CFrame.new(-1,0,0);
		Factor = Vector3.new(-2/3,0,0);
	};
	[lhip] =
	{
		C0 = lhip.C0;
		C1 = lhip.C1;
		Factor = Vector3.new(0,0,2/3);
	};
	[rhip] =
	{
		C0 = rhip.C0;
		C1 = rhip.C1;
		Factor = Vector3.new(0,0,-2/3);
	};
	[rshoulder] =
	{
		C0 = rshoulder.C0;
		C1 = rshoulder.C1;
		Factor = Vector3.new(0,0,1/3);
	};
	[lshoulder] = 
	{
		C0 = lshoulder.C0;
		C1 = lshoulder.C1;
		Factor = Vector3.new(0,0,-1/3);
	};
	[neck] =
	{
		C0 = neck.C0;
		C1 = neck.C1;
		Factor = Vector3.new(-2/3,0,0);
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
	for joint,def in pairs(RIG) do
		joint.C0 = def.C0 * CFrame.Angles(def.Factor.X*camY,def.Factor.Y*camY,def.Factor.Z*camY)
		joint.C1 = def.C1
	end
	rootJ.C0 = rootJ.C0 * CFrame.new(0,camY,0) -- Painful fix, but the player glides forward and backwards a bit when looking up and down without this.
	local headOffset = CFrame.new()
	if (c.Focus.p-c.CoordinateFrame.p).magnitude < 1 then
		c.FieldOfView = 80
		local dist = head.CFrame:toObjectSpace(torso.CFrame).p.magnitude
		headOffset = root.CFrame:toObjectSpace(head.CFrame) - Vector3.new(0,dist - ((1+camY)/8),0.25)
		script.Parent.Head.Transparency = 1
	else
		c.FieldOfView = 80
		script.Parent.Head.Transparency = 0
	end
	local t = cos(tick() * (math.pi*2.5))
	local bobble = CFrame.new((t/3)*waveScale,abs(t/5)*waveScale,0) -- Makes the view move side to side. The wave scale is tweened between 0 and 1 depending on if the player is walking or not.
	humanoid.CameraOffset = (headOffset * bobble).p
end))

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function lock(part)
	if part and part:IsA("BasePart") then
		part.LocalTransparencyModifier = part.Transparency
		part.Changed:connect(function (property)
			part.LocalTransparencyModifier = part.Transparency
		end)
	end
end

for _,v in pairs(char:GetChildren()) do
	lock(v)
end

char.ChildAdded:connect(lock)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------