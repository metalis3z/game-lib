-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local u1 = Random.new();
function Animate(p1, p2, p3)
	v1.Audio.Play("rbxassetid://6819173876", p2.PrimaryPart, 1, 0.8, 175);
	wait(2);
	if p2 then
		if not p2.Parent then
			return;
		end;
	else
		return;
	end;
	for v2, v3 in ipairs(p2:GetDescendants()) do
		if v3:IsA("BasePart") then
			v3.Anchored = true;
		end;	
	end;
	local v5 = p2.Box.Attachment.Smoke:Emit(5);
	local l__Top_Release__6 = p2:FindFirstChild("Top Release");
	l__Top_Release__6.Anchored = false;
	l__Top_Release__6.CanCollide = true;
	l__Top_Release__6:BreakJoints();
	l__Top_Release__6.Velocity = Vector3.new(0, 40, 0);
	l__Top_Release__6.RotVelocity = Vector3.new(u1:NextNumber(0, 30), u1:NextNumber(0, 30), u1:NextNumber(0, 30));
	if p1 == game.Players.LocalPlayer then
		v1.WorldFX.RewardBillboard(p2:GetPrimaryPartCFrame().p + Vector3.new(0, 2, 0), "+" .. v1.Functions.Commas(p3), "RewardBillboard", 4);
		v1.Audio.Play("rbxassetid://6819173921", p2.PrimaryPart, 1, 1, 250);
	end;
	v1.Functions.AddDebris(p2, 5);
end;
function LandCheck(p4, p5, p6)
	local l____MAP__7 = game.Workspace:WaitForChild("__MAP");
	while true do
		if p5 then

		else
			break;
		end;
		if p5.Parent then

		else
			break;
		end;
		local v8 = RaycastParams.new();
		v8.FilterType = Enum.RaycastFilterType.Whitelist;
		v8.FilterDescendantsInstances = { l____MAP__7 };
		local v9 = workspace:Raycast(p5:GetPrimaryPartCFrame().p, Vector3.new(0, -1, 0).Unit * 6, v8);
		if v9 then
			if v9.Instance then
				Animate(p4, p5, p6);
				return;
			end;
		end;
		v1.Heartbeat();	
	end;
end;
local l__Assets__2 = v1.Assets;
local l__CarePackages__3 = v1.Things:WaitForChild("CarePackages");
function Add(p7, p8)
	local v10 = v1.Player.Get("RootPart", p7);
	if not v10 then
		return;
	end;
	v1.Audio.Play("rbxassetid://6819173966", script, 1, 0.2);
	wait(3);
	local v11 = l__Assets__2:WaitForChild("CarePackage"):Clone();
	v11:SetPrimaryPartCFrame(CFrame.new(v10.CFrame.p) * CFrame.new(0, 30, 0) * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0));
	v11.Parent = l__CarePackages__3;
	for v12, v13 in pairs(v11:GetChildren()) do
		if v13:IsA("BasePart") then
			v1.PhysicsService:SetPartCollisionGroup(v13, "CarePackage");
		end;	
	end;
	for v17, v18 in pairs(v11:GetChildren()) do
		if v18:IsA("BasePart") then
			v18.Anchored = false;
		end;	
	end;
	LandCheck(p7, v11, p8);
end;
v1.Network.Fired("S"):Connect(function(p9, p10, p11)
	Add(p9, p11);
end);
