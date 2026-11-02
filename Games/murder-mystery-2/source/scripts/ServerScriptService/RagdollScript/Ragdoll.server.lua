local Character = script.Parent;
local Humanoid = Character:FindFirstChild("Humanoid");
local AddHats = require(script.WeldHat)
local Effects = game.ReplicatedStorage.GetSyncDataServer:Invoke("Effects");
Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
function OnDeath()
	local mode = Instance.new("Model")
	mode.Parent = game.Workspace
	mode.Name = "Raggy"
	local Creator = Character.Humanoid:FindFirstChild("Creator");
	local Creator2 = Character.Humanoid:FindFirstChild("Creator2");
	local Killer;
	if Creator then
		Killer = Creator.Value;
	elseif Creator2 then
		Killer = Creator2.Value;
	end;
	task.wait();
	Humanoid:Destroy()

	local children = Character:GetDescendants()
	for i = 1,#children do
		if children[i]:IsA("Motor6D") then
			children[i]:Destroy()
		end
	end

	local function ragdolljoints(part0, part1, attachment, char, classname, proproits)
		attachment = attachment.."RigAttachment"
		local ball = Instance.new(classname.."Constraint")
		ball.Parent = char
		ball.Attachment0 = part0:WaitForChild(attachment)
		ball.Attachment1 = part1:WaitForChild(attachment)

		for _,ConstantData in next,proproits or {} do
			ball[ConstantData[1]] = ConstantData[2]
		end
	end


	ragdolljoints(Character.Head, Character.UpperTorso, 'Neck', Character, 'BallSocket', {
		{"LimitsEnabled",true};
		{"TwistLimitsEnabled",true};
		{"TwistLowerAngle",-22.5};
		{"TwistUpperAngle",22.5};
		{"UpperAngle",60};
	})

	ragdolljoints(Character.LeftUpperArm, Character.UpperTorso, 'LeftShoulder', Character, 'BallSocket')

	ragdolljoints(Character.RightUpperArm, Character.UpperTorso, 'RightShoulder', Character,'BallSocket')

	ragdolljoints(Character.LeftUpperLeg, Character.LowerTorso, 'LeftHip', Character, 'BallSocket')

	ragdolljoints(Character.RightUpperLeg, Character.LowerTorso, 'RightHip', Character, 'BallSocket')


	ragdolljoints(Character.UpperTorso, Character.LowerTorso, 'Waist', Character, 'Hinge')

	ragdolljoints(Character.LeftLowerLeg, Character.LeftUpperLeg, 'LeftKnee', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",0};
		{"UpperAngle",-75};
	})

	ragdolljoints(Character.RightLowerLeg, Character.RightUpperLeg, 'RightKnee', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",0};
		{"UpperAngle",-75};
	})

	ragdolljoints(Character.LeftLowerLeg, Character.LeftFoot, 'LeftAnkle', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",-5};
		{"UpperAngle",5};
	})

	ragdolljoints(Character.RightLowerLeg, Character.RightFoot, 'RightAnkle', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",-5};
		{"UpperAngle",5};
	})

	ragdolljoints(Character.LeftLowerArm, Character.LeftHand, 'LeftWrist', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",-5};
		{"UpperAngle",5};
	})

	ragdolljoints(Character.RightLowerArm, Character.RightHand, 'RightWrist', Character ,'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",-5};
		{"UpperAngle",5};
	})

	ragdolljoints(Character.LeftLowerArm, Character.LeftUpperArm, 'LeftElbow', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",0};
		{"UpperAngle",90};
	})

	ragdolljoints(Character.RightLowerArm, Character.RightUpperArm, 'RightElbow', Character, 'Hinge', {
		{"LimitsEnabled",true};
		{"LowerAngle",0};
		{"UpperAngle",90};
	})

	Character.HumanoidRootPart.Anchored = true
	Character.HumanoidRootPart.CanCollide = false

	local Children = Character:GetChildren()
	for c =1,#Children do
		if Children[c]:IsA("MeshPart") or Children[c]:IsA("BasePart") or Children[c]:IsA("Shirt") or Children[c]:IsA("Pants") or Children[c]:IsA("Accessory") or Children[c]:IsA("BallSocketConstraint") or Children[c]:IsA("HingeConstraint")then
			Children[c].Parent = mode;
		end
	end
	local charBodyParts = mode:GetChildren()
	for f = 1,#charBodyParts do
		if charBodyParts[f]:IsA("CharacterAppearance") then
			charBodyParts[f].Parent = mode
		end
	end
	local children = Character:GetDescendants()
	for i = 1,#children do
		if children[i]:IsA("BasePart") then
			children[i].CanCollide = true
		end
	end
	local x = mode:GetDescendants()
	for i =1,#x do
		if x[i].ClassName == "Weld" then
			x[i]:Destroy()
		end
	end
	for _,Accessory in pairs(mode:GetChildren()) do
		if Accessory:IsA("Accessory") then
			AddHats(Accessory, mode)
		end
	end

	local Player = game.Players:GetPlayerFromCharacter(Character)

	local h  = Instance.new("Humanoid")
	h.Parent = mode
	h:ChangeState(Enum.HumanoidStateType.Ragdoll)
	h.RigType = Enum.HumanoidRigType.R15
	h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

	local playername = Instance.new("StringValue")
	playername.Name = "PlayerName"
	playername.Parent = mode
	playername.Value = Player.Name

	local value = Instance.new("ObjectValue")
	value.Parent = mode
	value.Name = "Creator"

	Character:Destroy()



	Character:Destroy()
	local PlayerData = game.ReplicatedStorage.GetPlayerData_REMOTE:Invoke();
	for PlayerName,TheData in pairs(PlayerData) do
		if TheData["Role"] == "Murderer" then
			local EquippedEffect = game.ReplicatedStorage.GetDataServer:Invoke(game.Players:FindFirstChild(PlayerName),"Effects").Equipped[1];
			if EquippedEffect ~= nil and EquippedEffect  ~= "None" and Killer ~= nil and Killer == game.Players:FindFirstChild(PlayerName) then
				require(Effects[EquippedEffect]["DeathModule"])(mode);
			end
		end
	end;

	spawn(function()
		wait(2.5)
		local x = mode:GetChildren()
		for v = 1,#x do
			if x[v]:IsA("BasePart") then
				x[v].Anchored = true;
				x[v].CollisionGroupId = 1
			end	
		end
	end)

	wait(1)
end
Humanoid.Died:connect(OnDeath)