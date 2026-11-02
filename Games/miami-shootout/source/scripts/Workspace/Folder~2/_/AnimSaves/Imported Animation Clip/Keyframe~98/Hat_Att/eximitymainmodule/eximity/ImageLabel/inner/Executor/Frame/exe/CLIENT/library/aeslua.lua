-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = {};
aeslua = v2;
v2.AES128 = 16;
v2.AES192 = 24;
v2.AES256 = 32;
v2.ECBMODE = 1;
v2.CBCMODE = 2;
v2.OFBMODE = 3;
v2.CFBMODE = 4;
local l__string_char__1 = string.char;
local l__string_sub__2 = string.sub;
local l__string_byte__3 = string.byte;
local u4 = require(script.Parent:WaitForChild("ciphermode"));
function v1.pwToKey(p1, p2)
	local v3 = p2;
	if p2 == v2.AES192 then
		v3 = 32;
	end;
	if #p1 < v3 then
		local v4 = nil;
		v4 = "";
		for v5 = 1, v3 - #p1 do
			v4 = v4 .. l__string_char__1(0);
		end;
		p1 = p1 .. local v6;
	else
		p1 = l__string_sub__2(p1, 1, v3);
	end;
	p1 = u4.encryptString({ l__string_byte__3(p1, 1, #p1) }, p1, u4.encryptCBC);
	p1 = l__string_sub__2(p1, 1, p2);
	return { l__string_byte__3(p1, 1, #p1) };
end;
local u5 = require(script.Parent:WaitForChild("util"));
function v2.encrypt(p3, p4, p5, p6)
	local v7 = nil;
	local v8 = nil;
	assert(p3 ~= nil, "Empty password.");
	assert(p3 ~= nil, "Empty data.");
	local v9 = p6 or v2.CBCMODE;
	v7 = v1.pwToKey(p3, p5 or v2.AES128);
	v8 = u5.padByteString(p4);
	if v9 == v2.ECBMODE then
		return u4.encryptString(v7, v8, u4.encryptECB);
	end;
	if v9 == v2.CBCMODE then
		return u4.encryptString(v7, v8, u4.encryptCBC);
	end;
	if v9 == v2.OFBMODE then
		return u4.encryptString(v7, v8, u4.encryptOFB);
	end;
	if v9 ~= v2.CFBMODE then
		return nil;
	end;
	return u4.encryptString(v7, v8, u4.encryptCFB);
end;
function v2.decrypt(p7, p8, p9, p10)
	local v10 = nil;
	local v11 = p10 or v2.CBCMODE;
	v10 = v1.pwToKey(p7, p9 or v2.AES128);
	local v12 = nil;
	if v11 == v2.ECBMODE then
		v12 = u4.decryptString(v10, p8, u4.decryptECB);
	elseif v11 == v2.CBCMODE then
		v12 = u4.decryptString(v10, p8, u4.decryptCBC);
	elseif v11 == v2.OFBMODE then
		v12 = u4.decryptString(v10, p8, u4.decryptOFB);
	elseif v11 == v2.CFBMODE then
		v12 = u4.decryptString(v10, p8, u4.decryptCFB);
	end;
	result = u5.unpadByteString(v12);
	if result == nil then
		return nil;
	end;
	return result;
end;
return v2;
