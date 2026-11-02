-- Decompiled with the Synapse X Luau decompiler.

function buildAttachmentMap(p1)
	local v1 = {};
	for v2, v3 in pairs(p1:GetChildren()) do
		local v6
		v6 = v3
		if v6:IsA("BasePart") then
			for v7, v8 in pairs(v6:GetChildren()) do
				local v11
				v11 = v8
				if v11:IsA("Attachment") then
					local v12 = v11.Name:match("^(.+)RigAttachment$");
					local v13
					if v12 then
						v13 = v11.Parent:FindFirstChild(v12) or nil;
					else
						v13 = nil;
					end;
					if v13 then
						v1[v11.Name] = {
							Joint = v13, 
							Attachment0 = v13.Part0[v11.Name], 
							Attachment1 = v13.Part1[v11.Name]
						};
					end;
				end;			
			end;
		end;	
	end;
	return v1;
end;
local u1 = require(script:WaitForChild("buildConstraints"));
local u2 = require(script:WaitForChild("buildCollisionFilters"));
return function(p2)
	local l__Parent__14 = p2.Parent;
	p2.BreakJointsOnDeath = false;
	local l__HumanoidRootPart__15 = l__Parent__14:FindFirstChild("HumanoidRootPart");
	if l__HumanoidRootPart__15 then
		l__HumanoidRootPart__15.CanCollide = false;
	end;
	local v16 = buildAttachmentMap(l__Parent__14);
	local v17 = u1(v16);
	u2(v16, l__Parent__14.PrimaryPart).Parent = v17;
	v17.Parent = l__Parent__14;
	game:GetService("CollectionService"):AddTag(p2, "Ragdoll");
end;
