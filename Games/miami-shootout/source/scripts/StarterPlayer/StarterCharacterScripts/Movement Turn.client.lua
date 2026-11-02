-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent;
local l__Humanoid__2 = l__Parent__1:WaitForChild("Humanoid");
local l__HumanoidRootPart__3 = l__Parent__1:WaitForChild("HumanoidRootPart");
local v4 = nil;
local v5 = nil;
local v6 = nil;
local v7 = nil;
if l__Humanoid__2.RigType == Enum.HumanoidRigType.R15 then
	local v8 = l__Parent__1:WaitForChild("LowerTorso"):WaitForChild("Root");
	v4 = l__Parent__1:WaitForChild("UpperTorso"):WaitForChild("Waist");
	v6 = v4.C0;
	v5 = l__Parent__1:WaitForChild("Head"):WaitForChild("Neck");
	v7 = v5.C0;
else
	v8 = l__HumanoidRootPart__3:WaitForChild("RootJoint");
end;
local l__C0__1 = v8.C0;
game:GetService("RunService").RenderStepped:Connect(function(p1)
	local v9 = nil;
	local v10 = l__HumanoidRootPart__3.CFrame:VectorToObjectSpace(l__Humanoid__2.MoveDirection);
	v9 = v10.X * 0.15;
	local v11 = v10.Z * 0.15;
	local v12 = nil;
	if l__Humanoid__2.RigType == Enum.HumanoidRigType.R15 then
		local v13 = { 0, 0, -v9 };
		v12 = { 0, -v9 * 2.5, 0 };
	else
		v13 = { 0, -v9, 0 };
	end;
	v8.C0 = v8.C0:Lerp(l__C0__1 * CFrame.Angles(unpack(v13)), p1 * 7);
	if v4 then
		v4.C0 = v4.C0:Lerp(v6 * CFrame.Angles(unpack(v13)), p1 * 7);
	end;
	if v5 then
		v5.C0 = v5.C0:Lerp(v7 * CFrame.Angles(unpack(v12)), p1 * 7);
	end;
end);
