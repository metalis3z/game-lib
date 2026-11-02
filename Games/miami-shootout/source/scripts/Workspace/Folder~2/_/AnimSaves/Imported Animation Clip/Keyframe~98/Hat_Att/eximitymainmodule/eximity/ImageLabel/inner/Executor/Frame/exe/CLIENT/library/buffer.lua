-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
({}).buffer = v1;
function v1.new()
	return {};
end;
function v1.addString(p1, p2)
	table.insert(p1, p2);
	for v2 = #p1 - 1, 1, -1 do
		if #p1[v2 + 1] < #p1[v2] then
			break;
		end;
		p1[v2] = p1[v2] .. table.remove(p1);
	end;
end;
function v1.toString(p3)
	for v3 = #p3 - 1, 1, -1 do
		p3[v3] = p3[v3] .. table.remove(p3);
	end;
	return p3[1];
end;
return v1;
