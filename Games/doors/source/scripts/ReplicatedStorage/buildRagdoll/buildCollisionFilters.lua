-- Decompiled with the Synapse X Luau decompiler.

local u1 = require(script.Parent:WaitForChild("getLastWordFromPascalCase"));
local u2 = {
	Hand = "Arm", 
	Foot = "Leg"
};
function getLimbType(p1)
	local v1 = u1(p1);
	return u2[v1] or v1;
end;
function getLimbs(p2, p3)
	local u3 = {};
	local u4 = {};
	local u5 = {};
	local function u6(p4, p5)
		if p4.Name ~= "HumanoidRootPart" then
			local v2 = getLimbType(p4.Name);
			u3[v2] = u3[v2] or {};
			table.insert(u3[v2], p4);
			local v3 = u3[v2];
			if v2 ~= p5 then
				u4[v2] = u4[v2] or {};
				if p5 then
					u4[v2][p5] = true;
				end;
				table.insert(u5, {
					Part = p4, 
					Type = v2
				});
				p5 = v2;
			end;
		end;
		for v4, v5 in pairs(p4:GetChildren()) do
			local v8 = v5
			if v8:isA("Attachment") then
				if p3[v8.Name] then
					local l__Parent__9 = p3[v8.Name].Attachment1.Parent;
					if l__Parent__9 then
						if l__Parent__9 ~= p4 then
							u6(l__Parent__9, p5);
						end;
					end;
				end;
			end;		
		end;
	end;
	u6(p2);
	return u3, u5, u4;
end;
function createNoCollision(p6, p7)
	local v10 = Instance.new("NoCollisionConstraint");
	v10.Name = p6.Name .. "<->" .. p7.Name;
	v10.Part0 = p6;
	v10.Part1 = p7;
	return v10;
end;
return function(p8, p9)
	local v11 = Instance.new("Folder");
	v11.Name = "NoCollisionConstraints";
	local v12, v13, v14 = getLimbs(p9, p8);
	for v15 = 1, #v13 do
		for v16 = v15 + 1, #v13 do
			local l__Type__17 = v13[v15].Type;
			local l__Type__18 = v13[v16].Type;
			if not v14[l__Type__17][l__Type__18] and not v14[l__Type__18][l__Type__17] then
				createNoCollision(v13[v15].Part, v13[v16].Part).Parent = v11;
			end;
		end;
	end;
	for v19, v20 in pairs(v12) do
		for v21, v22 in pairs(v14[v19]) do
			for v23, v24 in pairs(v12[v21]) do
				for v25, v26 in pairs(v20) do
					createNoCollision(v26, v24).Parent = v11;
				end;
			end;
		end;
	end;
	return v11;
end;
