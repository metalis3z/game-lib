-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
({}).ciphermode = v1;
local u1 = require(script.Parent:WaitForChild("aes"));
local u2 = require(script.Parent:WaitForChild("buffer"));
local l__string_byte__3 = string.byte;
local l__string_char__4 = string.char;
function v1.encryptString(p1, p2, p3)
	local v2 = iv or { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	local v3 = u1.expandEncryptionKey(p1);
	local v4 = u2.new();
	for v5 = 1, #p2 / 16 do
		local v6 = (v5 - 1) * 16 + 1;
		local v7 = { l__string_byte__3(p2, v6, v6 + 15) };
		p3(v3, v7, v2);
		u2.addString(v4, (l__string_char__4(unpack(v7))));
	end;
	return u2.toString(v4);
end;
function v1.encryptECB(p4, p5, p6)
	u1.encrypt(p4, p5, 1, p5, 1);
end;
local u5 = require(script.Parent:WaitForChild("util"));
function v1.encryptCBC(p7, p8, p9)
	u5.xorIV(p8, p9);
	u1.encrypt(p7, p8, 1, p8, 1);
	p9[1] = p8[1];
	p9[2] = p8[2];
	p9[3] = p8[3];
	p9[4] = p8[4];
	p9[5] = p8[5];
	p9[6] = p8[6];
	p9[7] = p8[7];
	p9[8] = p8[8];
	p9[9] = p8[9];
	p9[10] = p8[10];
	p9[11] = p8[11];
	p9[12] = p8[12];
	p9[13] = p8[13];
	p9[14] = p8[14];
	p9[15] = p8[15];
	p9[16] = p8[16];
end;
function v1.encryptOFB(p10, p11, p12)
	u1.encrypt(p10, p12, 1, p12, 1);
	u5.xorIV(p11, p12);
end;
function v1.encryptCFB(p13, p14, p15)
	u1.encrypt(p13, p15, 1, p15, 1);
	u5.xorIV(p14, p15);
	p15[1] = p14[1];
	p15[2] = p14[2];
	p15[3] = p14[3];
	p15[4] = p14[4];
	p15[5] = p14[5];
	p15[6] = p14[6];
	p15[7] = p14[7];
	p15[8] = p14[8];
	p15[9] = p14[9];
	p15[10] = p14[10];
	p15[11] = p14[11];
	p15[12] = p14[12];
	p15[13] = p14[13];
	p15[14] = p14[14];
	p15[15] = p14[15];
	p15[16] = p14[16];
end;
function v1.decryptString(p16, p17, p18)
	local v8 = iv or { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	if p18 == v1.decryptOFB or p18 == v1.decryptCFB then
		local v9 = u1.expandEncryptionKey(p16);
	else
		v9 = u1.expandDecryptionKey(p16);
	end;
	local v10 = u2.new();
	for v11 = 1, #p17 / 16 do
		local v12 = (v11 - 1) * 16 + 1;
		local v13 = { l__string_byte__3(p17, v12, v12 + 15) };
		v8 = p18(v9, v13, v8);
		u2.addString(v10, (l__string_char__4(unpack(v13))));
	end;
	return u2.toString(v10);
end;
function v1.decryptECB(p19, p20, p21)
	u1.decrypt(p19, p20, 1, p20, 1);
	return p21;
end;
function v1.decryptCBC(p22, p23, p24)
	u1.decrypt(p22, p23, 1, p23, 1);
	u5.xorIV(p23, p24);
	return { p23[1], p23[2], p23[3], p23[4], p23[5], p23[6], p23[7], p23[8], p23[9], p23[10], p23[11], p23[12], p23[13], p23[14], p23[15], p23[16] };
end;
function v1.decryptOFB(p25, p26, p27)
	u1.encrypt(p25, p27, 1, p27, 1);
	u5.xorIV(p26, p27);
	return p27;
end;
function v1.decryptCFB(p28, p29, p30)
	u1.encrypt(p28, p30, 1, p30, 1);
	u5.xorIV(p29, p30);
	return { p29[1], p29[2], p29[3], p29[4], p29[5], p29[6], p29[7], p29[8], p29[9], p29[10], p29[11], p29[12], p29[13], p29[14], p29[15], p29[16] };
end;
return v1;
