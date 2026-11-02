-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = {};
({}).gf = v2;
v1.n = 256;
v1.ord = 255;
v1.irrPolynom = 283;
v1.exp = {};
v1.log = {};
local u1 = require(script.Parent:WaitForChild("bit"));
function v2.add(p1, p2)
	return u1.bxor(p1, p2);
end;
function v2.sub(p3, p4)
	return u1.bxor(p3, p4);
end;
function v2.invert(p5)
	if p5 == 1 then
		return 1;
	end;
	return v1.exp[v1.ord - v1.log[p5]];
end;
function v2.mul(p6, p7)
	if p6 == 0 or p7 == 0 then
		return 0;
	end;
	local v3 = v1.log[p6] + v1.log[p7];
	if v1.ord <= v3 then
		v3 = v3 - v1.ord;
	end;
	return v1.exp[v3];
end;
function v2.div(p8, p9)
	if p8 == 0 then
		return 0;
	end;
	local v4 = v1.log[p8] - v1.log[p9];
	if v4 < 0 then
		v4 = v4 + v1.ord;
	end;
	return v1.exp[v4];
end;
function v2.printLog()
	for v5 = 1, v1.n do
		print("log(", v5 - 1, ")=", v1.log[v5 - 1]);
	end;
end;
function v2.printExp()
	for v6 = 1, v1.n do
		print("exp(", v6 - 1, ")=", v1.exp[v6 - 1]);
	end;
end;
function v1.initMulTable()
	for v7 = 0, v1.ord - 1 do
		v1.exp[v7] = 1;
		v1.log[1] = v7;
		local v8 = u1.bxor(u1.lshift(1, 1), 1);
		if v1.ord < v8 then
			v8 = v2.sub(v8, v1.irrPolynom);
		end;
	end;
end;
v1.initMulTable();
return v2;
