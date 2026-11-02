local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Packages.Observers);
local v3 = require(l_ReplicatedStorage_0.Packages.Trove);
local v4 = require(l_ReplicatedStorage_0.Shared.VFX);
local v5 = {};
local v6 = {};
local function _(v7, v8, v9)
	local v10 = v7:LoadAnimation(v8);
	v9:Add(function()
		v10:Stop(0);
		v10:Destroy();
	end);
	return v10;
end;
local function v28(v12, v13, v14, v15)
	v12 = vector.create(v12.X, 0, v12.Z);
	v13 = vector.create(v13.X, 0, v13.Z);
	v14 = vector.create(v14.X, 0, v14.Z);
	local v16 = vector.create(v15.X, 0, v15.Z) - v13;
	local v17 = v14 - v13;
	local v18 = v12 - v13;
	local v19 = v16:Dot(v16);
	local v20 = v16:Dot(v17);
	local v21 = v16:Dot(v18);
	local v22 = v17:Dot(v17);
	local v23 = v17:Dot(v18);
	local v24 = v19 * v22 - v20 * v20;
	if v24 == 0 then
		return false;
	else
		local v25 = (v22 * v21 - v20 * v23) / v24;
		local v26 = (v19 * v23 - v20 * v21) / v24;
		local v27 = false;
		if v25 >= 0 then
			v27 = false;
			if v26 >= 0 then
				v27 = v25 + v26 <= 1;
			end;
		end;
		return v27;
	end;
end;
local function _(v29, v30, v31, v32)
	local l_Unit_0 = (v31 - v30):Cross(v32 - v30).Unit;
	return v29 - l_Unit_0 * (v29 - v30):Dot(l_Unit_0);
end;
v6.WaterSurfacePoint = function(_, v36)
	for _, v38 in v5 do
		local v39, v40, v41 = unpack(v38);
		local l_WorldPosition_0 = v39.WorldPosition;
		local l_WorldPosition_1 = v40.WorldPosition;
		local l_WorldPosition_2 = v41.WorldPosition;
		if v28(v36, l_WorldPosition_0, l_WorldPosition_1, l_WorldPosition_2) then
			l_WorldPosition_0 = v39.Bone.WorldPosition + v39.Bone.Transform.Position;
			l_WorldPosition_1 = v40.Bone.WorldPosition + v40.Bone.Transform.Position;
			l_WorldPosition_2 = v41.Bone.WorldPosition + v41.Bone.Transform.Position;
			local l_l_WorldPosition_0_0 = l_WorldPosition_0;
			local l_Unit_1 = (l_WorldPosition_1 - l_l_WorldPosition_0_0):Cross(l_WorldPosition_2 - l_l_WorldPosition_0_0).Unit;
			return v36 - l_Unit_1 * (v36 - l_l_WorldPosition_0_0):Dot(l_Unit_1);
		end;
	end;
	return v36;
end;
v6.Start = function(_)
	v2.observeTag("FishingCatchZone", function(v48)
		task.wait(1);
		local v49 = v3.new();
		if v48:FindFirstChild("PoolVFX") then
			v48:FindFirstChild("PoolVFX"):Destroy();
		end;
		local l_v48_Attribute_0 = v48:GetAttribute("Pool");
		local l_FirstChild_0 = script.PoolVFX:FindFirstChild(l_v48_Attribute_0);
		l_FirstChild_0.Name = "PoolVFX";
		l_FirstChild_0:PivotTo(v48.CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
		l_FirstChild_0.Parent = v48;
		v49:Add(function()
			v4.disable(l_FirstChild_0);
			task.wait(2);
			l_FirstChild_0:Destroy();
		end);
		local l_FirstChild_1 = l_ReplicatedStorage_0.Models.Animals:FindFirstChild(l_v48_Attribute_0);
		if l_FirstChild_1 and l_FirstChild_0:FindFirstChild("Animation") then
			local v53 = v49:Clone(l_FirstChild_1);
			v53.PrimaryPart.Anchored = true;
			v53:PivotTo(CFrame.new(v48.Position));
			v53.Parent = v48;
			local l_v53_FirstChildWhichIsA_0 = v53:FindFirstChildWhichIsA("Animator", true);
			if l_v53_FirstChildWhichIsA_0 then
				local v55 = l_v53_FirstChildWhichIsA_0:LoadAnimation(l_FirstChild_0.Animation);
				v49:Add(function()
					v55:Stop(0);
					v55:Destroy();
				end);
				local l_v55_0 = v55;
				l_v55_0.Looped = true;
				l_v55_0:Play();
			end;
		end;
		return v49:WrapClean();
	end);
	v2.observeTag("FishingWater", function(v57)
		local v58 = {};
		for _, v60 in v57:GetChildren() do
			if v60:IsA("Bone") then
				local l_v60_Attribute_0 = v60:GetAttribute("Order");
				local v62 = {
					Order = l_v60_Attribute_0, 
					X = (l_v60_Attribute_0 - 1) % 5 + 1, 
					Y = math.floor((l_v60_Attribute_0 - 1) / 5) + 1, 
					WorldPosition = v60.WorldPosition, 
					Bone = v60
				};
				v58[vector.create(v62.X, v62.Y)] = v62;
			end;
		end;
		local v63 = {};
		for _, v65 in v58 do
			local l_X_0 = v65.X;
			local l_Y_0 = v65.Y;
			if l_X_0 < 5 then
				local v68 = v58[vector.create(l_X_0, l_Y_0)];
				local v69 = v58[vector.create(l_X_0 + 1, l_Y_0)];
				local v70 = v58[vector.create(l_X_0, l_Y_0 + 1)];
				local v71 = v58[vector.create(l_X_0 + 1, l_Y_0 + 1)];
				if v68 and v69 and v70 and v71 then
					table.insert(v63, {
						v68, 
						v69, 
						v70
					});
					table.insert(v63, {
						v69, 
						v71, 
						v70
					});
				end;
			end;
		end;
		v5 = v63;
		return function()
			v5 = nil;
		end;
	end);
	v2.observeTag("FishingBobber", function(v72)
		local v73 = v72:WaitForChild("RopeConstraint", 30);
		local l_Beam_0 = Instance.new("Beam");
		l_Beam_0.Attachment0 = v73.Attachment0;
		l_Beam_0.Attachment1 = v73.Attachment1;
		l_Beam_0.TextureSpeed = 0;
		l_Beam_0.Segments = 1;
		l_Beam_0.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0));
		l_Beam_0.Width0 = 0.04;
		l_Beam_0.Width1 = 0.04;
		l_Beam_0.Transparency = NumberSequence.new(0);
		l_Beam_0.Parent = v72;
		local v75 = nil;
		local v76 = nil;
		local function _()
			if v76 then
				v76:Disconnect();
			end;
			if v75 then
				v75:Destroy();
			end;
		end;
		local function _()
			if v76 then
				v76:Disconnect();
			end;
			if v75 then
				v75:Destroy();
			end;
			v75 = script.catchbubbles:Clone();
			v75.Parent = v72;
			v76 = l_RunService_0.RenderStepped:Connect(function()
				if not v72:IsDescendantOf(workspace) then
					if v76 then
						v76:Disconnect();
					end;
					if v75 then
						v75:Destroy();
						return;
					end;
				else
					v75.CFrame = CFrame.new(v72.PrimaryPart.Position);
				end;
			end);
		end;
		v72:GetAttributeChangedSignal("bite"):Connect(function()
			if v72:GetAttribute("bite") then
				if v76 then
					v76:Disconnect();
				end;
				if v75 then
					v75:Destroy();
				end;
				v75 = script.catchbubbles:Clone();
				v75.Parent = v72;
				v76 = l_RunService_0.RenderStepped:Connect(function()
					if not v72:IsDescendantOf(workspace) then
						if v76 then
							v76:Disconnect();
						end;
						if v75 then
							v75:Destroy();
							return;
						end;
					else
						v75.CFrame = CFrame.new(v72.PrimaryPart.Position);
					end;
				end);
				return;
			else
				if v76 then
					v76:Disconnect();
				end;
				if v75 then
					v75:Destroy();
				end;
				return;
			end;
		end);
		return function()
			l_Beam_0:Destroy();
		end;
	end);
end;
return v6;