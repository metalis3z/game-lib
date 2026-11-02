---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CloneTrooper1019, 2014
-- Realism Mode (Server Side)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN DIFFERENCES:

-- The script only takes care of the joint CFrame replication to the serverside.
-- The client script is still the same, but it will Fire to UpdateY when the camera changes at a 0.1 interval
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

updateY = script.Parent.UpdateY -- script.Parent:WaitForChild("UpdateY")

function loadPlayerVariables(player)
	
	char = script.Parent.Parent -- player.Character
	humanoid = char.Humanoid -- char:WaitForChild("Humanoid")
	head = char.Head -- char:WaitForChild("Head")
	torso = char.Torso -- char:WaitForChild("Torso")
	root = char.HumanoidRootPart -- char:WaitForChild("HumanoidRootPart")
	lshoulder = torso["Left Shoulder"] -- torso:WaitForChild("Left Shoulder")
	rshoulder = torso["Right Shoulder"] -- torso:WaitForChild("Right Shoulder")
	neck = torso["Neck"] -- torso:WaitForChild("Neck")
	
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
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

updateY.OnServerEvent:connect(function (player,camY)

	if not char then
		loadPlayerVariables(player)
	end
	local abs,cos = math.abs,math.cos
	for joint,def in pairs(RIG) do
		joint.C0 = def.C0 * CFrame.Angles(def.Factor.X*camY,def.Factor.Y*camY,def.Factor.Z*camY)
		joint.C1 = def.C1
	end
	--rootJ.C0 = rootJ.C0 * CFrame.new(0,camY,0)
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------