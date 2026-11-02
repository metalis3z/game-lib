-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
for v2, v3 in pairs(script:GetChildren()) do
	v1[v3.Name] = v3;
end;
local u1 = require(script.Parent:WaitForChild("getLastWordFromPascalCase"));
function getConstraintTemplate(p1)
	p1 = u1(p1);
	return v1[p1] or v1.Default;
end;
function createConstraint(p2)
	local l__Name__4 = p2.Joint.Name;
	local v5 = getConstraintTemplate(l__Name__4):Clone();
	v5.Attachment0 = p2.Attachment0;
	v5.Attachment1 = p2.Attachment1;
	v5.Name = l__Name__4 .. "RagdollConstraint";
	local v6 = Instance.new("ObjectValue", v5);
	v6.Name = "RigidJoint";
	v6.Value = p2.Joint;
	return v5;
end;
return function(p3)
	local v7 = Instance.new("Folder");
	v7.Name = "RagdollConstraints";
	for v8, v9 in pairs(p3) do
		if v9.Joint.Name ~= "Root" then
			createConstraint(v9).Parent = v7;
		end;
	end;
	return v7;
end;
