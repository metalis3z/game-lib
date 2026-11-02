-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = {};
({}).util = v1;
local u1 = require(script.Parent:WaitForChild("bit"));
function v1.byteParity(p1)
	p1 = u1.bxor(p1, u1.rshift(p1, 4));
	p1 = u1.bxor(p1, u1.rshift(p1, 2));
	p1 = u1.bxor(p1, u1.rshift(p1, 1));
	return u1.band(p1, 1);
end;
function v1.getByte(p2, p3)
	if p3 == 0 then
		return u1.band(p2, 255);
	end;
	return u1.band(u1.rshift(p2, p3 * 8), 255);
end;
function v1.putByte(p4, p5)
	if p5 == 0 then
		return u1.band(p4, 255);
	end;
	return u1.lshift(u1.band(p4, 255), p5 * 8);
end;
function v1.bytesToInts(p6, p7, p8)
	local v3 = {};
	for v4 = 0, p8 - 1 do
		v3[v4] = v1.putByte(p6[p7 + v4 * 4], 3) + v1.putByte(p6[p7 + v4 * 4 + 1], 2) + v1.putByte(p6[p7 + v4 * 4 + 2], 1) + v1.putByte(p6[p7 + v4 * 4 + 3], 0);
	end;
	return v3;
end;
function v1.intsToBytes(p9, p10, p11, p12)
	p12 = p12 or #p9;
	for v5 = 0, p12 do
		for v6 = 0, 3 do
			p10[p11 + v5 * 4 + (3 - v6)] = v1.getByte(p9[v5], v6);
		end;
	end;
	return p10;
end;
local l__string_format__2 = string.format;
function v2.bytesToHex(p13)
	local v7 = "";
	local v8, v9, v10 = ipairs(p13);
	while true do
		v8(v9, v10);
		if not v8 then
			break;
		end;
		v10 = v8;
		v7 = v7 .. l__string_format__2("%02x ", v9);	
	end;
	return v7;
end;
local l__string_byte__3 = string.byte;
function v1.toHexString(p14)
	local v11 = type(p14);
	if v11 == "number" then
		return l__string_format__2("%08x", p14);
	end;
	if v11 == "table" then
		return v2.bytesToHex(p14);
	end;
	if v11 ~= "string" then
		return p14;
	end;
	return v2.bytesToHex({ l__string_byte__3(p14, 1, #p14) });
end;
local l__math_random__4 = math.random;
local l__string_char__5 = string.char;
local l__math_ceil__6 = math.ceil;
function v1.padByteString(p15)
	local v12 = nil;
	local v13 = #p15;
	local v14 = l__math_random__4(0, 255);
	local v15 = l__math_random__4(0, 255);
	p15 = l__string_char__5(v14, v15, v14, v15, v1.getByte(v13, 3), v1.getByte(v13, 2), v1.getByte(v13, 1), v1.getByte(v13, 0)) .. p15;
	v12 = "";
	for v16 = 1, l__math_ceil__6(#p15 / 16) * 16 - #p15 do
		v12 = v12 .. l__string_char__5(l__math_random__4(0, 255));
	end;
	return p15 .. local v17;
end;
function v2.properlyDecrypted(p16)
	local v18 = { l__string_byte__3(p16, 1, 4) };
	if v18[1] == v18[3] and v18[2] == v18[4] then
		return true;
	end;
	return false;
end;
function v1.unpadByteString(p17)
	if not v2.properlyDecrypted(p17) then
		return nil;
	end;
	return string.sub(p17, 9, 8 + (v1.putByte(l__string_byte__3(p17, 5), 3) + v1.putByte(l__string_byte__3(p17, 6), 2) + v1.putByte(l__string_byte__3(p17, 7), 1) + v1.putByte(l__string_byte__3(p17, 8), 0)));
end;
function v1.xorIV(p18, p19)
	for v19 = 1, 16 do
		p18[v19] = u1.bxor(p18[v19], p19[v19]);
	end;
end;
return v1;
