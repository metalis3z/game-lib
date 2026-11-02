local RbxUtility = LoadLibrary('RbxUtility')
local Create = RbxUtility.Create

----------------------------------------

local Ghost = script.Parent
local Player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
local Character = Player.Character
local Humanoid = Character.Humanoid
local Alive = true

----------------------------------------
local Body = script.Parent.Body;

local torsoAt = Character.Torso.Position local toGhost = Body.Position - torsoAt toGhost = Vector3.new(toGhost.x, 0, toGhost.z).unit
local ghostAt = torsoAt + toGhost*3 + Vector3.new(0, 2 + 1*math.sin(tick()), 0)
Body.CFrame = Character.Torso.CFrame;

Create"BodyPosition"{
	Name = 'Float';
	Parent = Body;
	position = Character.Torso.Position + Vector3.new(1,1,1);
	--D = 500;
};
Create'BodyGyro'{
	Name = 'Rotate';
	Parent = Body;
	cframe = Character.Torso.CFrame;
	maxTorque = Vector3.new(40000, 20000, 40000);
};

wait(2);
--set up ghost following you
spawn(function()
	while Alive do
		local torsoAt = Character.Torso.Position
		local toGhost = Body.Position - torsoAt
		toGhost = Vector3.new(toGhost.x, 0, toGhost.z).unit
		local ghostAt = torsoAt + toGhost*3 + Vector3.new(0, 2 + 1*math.sin(tick()), 0)
		--
		Body.Float.position = ghostAt
		Body.Rotate.cframe = Character.Torso.CFrame 
		wait()
		Body.Anchored = false;
		Body.CanCollide = false;
		Body:SetNetworkOwner(nil)
	end
end)


--and finally set up a veiw of our health