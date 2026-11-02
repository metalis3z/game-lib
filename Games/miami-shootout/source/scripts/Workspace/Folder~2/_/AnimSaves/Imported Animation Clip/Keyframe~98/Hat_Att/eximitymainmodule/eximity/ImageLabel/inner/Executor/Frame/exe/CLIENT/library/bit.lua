-- Decompiled with the Synapse X Luau decompiler.

bit = {};
local l__math_fmod__1 = math.fmod;
function bit.bnot(p1)
	return 4294967295 - l__math_fmod__1(p1, 4294967296);
end;
local function u2(p2)
	return l__math_fmod__1(p2, 4294967296);
end;
function bit.lshift(p3, p4)
	return l__math_fmod__1(u2(p3) * 2 ^ p4, 4294967296);
end;
local l__math_floor__3 = math.floor;
function bit.rshift(p5, p6)
	return l__math_floor__3(l__math_fmod__1(p5, 4294967296) / 2 ^ p6);
end;
function bit.band(p7, p8)
	local v1 = 0;
	local v2 = 1;
	for v3 = 0, 31 do
		if l__math_fmod__1(p7, 2) == 1 and l__math_fmod__1(p8, 2) == 1 then
			v1 = v1 + v2;
		end;
		p7 = bit.rshift(p7, 1);
		p8 = bit.rshift(p8, 1);
		v2 = v2 * 2;
	end;
	return v1;
end;
function bit.bor(p9, p10)
	local v4 = 0;
	local v5 = 1;
	for v6 = 0, 31 do
		if l__math_fmod__1(p9, 2) == 1 or l__math_fmod__1(p10, 2) == 1 then
			v4 = v4 + v5;
		end;
		p9 = bit.rshift(p9, 1);
		p10 = bit.rshift(p10, 1);
		v5 = v5 * 2;
	end;
	return v4;
end;
function bit.bxor(p11, p12)
	local v7 = 0;
	local v8 = 1;
	for v9 = 0, 31 do
		if l__math_fmod__1(p11, 2) ~= l__math_fmod__1(p12, 2) then
			v7 = v7 + v8;
		end;
		p11 = bit.rshift(p11, 1);
		p12 = bit.rshift(p12, 1);
		v8 = v8 * 2;
	end;
	return v7;
end;
return bit;
