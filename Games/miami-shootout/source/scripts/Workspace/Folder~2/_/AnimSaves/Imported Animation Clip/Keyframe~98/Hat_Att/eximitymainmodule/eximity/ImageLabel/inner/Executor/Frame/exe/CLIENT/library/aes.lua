-- Decompiled with the Synapse X Luau decompiler.

bit = require(script.Parent:WaitForChild("bit"));
local v1 = {};
local v2 = {};
math_floor = math.floor;
({}).aes = v1;
v1.ROUNDS = "rounds";
v1.KEY_TYPE = "type";
v1.ENCRYPTION_KEY = 1;
v1.DECRYPTION_KEY = 2;
v2.SBox = {};
v2.iSBox = {};
v2.table0 = {};
v2.table1 = {};
v2.table2 = {};
v2.table3 = {};
v2.tableInv0 = {};
v2.tableInv1 = {};
v2.tableInv2 = {};
v2.tableInv3 = {};
v2.rCon = { 16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824, 2147483648, 452984832, 905969664, 1811939328, 3623878656, 2868903936, 1291845632, 2583691264, 788529152 };
local u1 = require(script.Parent:WaitForChild("util"));
function v2.affinMap(p1)
	mask = 248;
	result = 0;
	for v3 = 1, 8 do
		result = bit.lshift(result, 1);
		parity = u1.byteParity(bit.band(p1, mask));
		result = result + parity;
		lastbit = bit.band(mask, 1);
		mask = bit.band(bit.rshift(mask, 1), 255);
		if lastbit ~= 0 then
			mask = bit.bor(mask, 128);
		else
			mask = bit.band(mask, 127);
		end;
	end;
	return bit.bxor(result, 99);
end;
local u2 = require(script.Parent:WaitForChild("gf"));
function v2.calcSBox()
	for v4 = 0, 255 do
		if v4 ~= 0 then
			inverse = u2.invert(v4);
		else
			inverse = v4;
		end;
		mapped = v2.affinMap(inverse);
		v2.SBox[v4] = mapped;
		v2.iSBox[mapped] = v4;
	end;
end;
function v2.calcRoundTables()
	for v5 = 0, 255 do
		byte = v2.SBox[v5];
		v2.table0[v5] = u1.putByte(u2.mul(3, byte), 0) + u1.putByte(byte, 1) + u1.putByte(byte, 2) + u1.putByte(u2.mul(2, byte), 3);
		v2.table1[v5] = u1.putByte(byte, 0) + u1.putByte(byte, 1) + u1.putByte(u2.mul(2, byte), 2) + u1.putByte(u2.mul(3, byte), 3);
		v2.table2[v5] = u1.putByte(byte, 0) + u1.putByte(u2.mul(2, byte), 1) + u1.putByte(u2.mul(3, byte), 2) + u1.putByte(byte, 3);
		v2.table3[v5] = u1.putByte(u2.mul(2, byte), 0) + u1.putByte(u2.mul(3, byte), 1) + u1.putByte(byte, 2) + u1.putByte(byte, 3);
	end;
end;
function v2.calcInvRoundTables()
	for v6 = 0, 255 do
		byte = v2.iSBox[v6];
		v2.tableInv0[v6] = u1.putByte(u2.mul(11, byte), 0) + u1.putByte(u2.mul(13, byte), 1) + u1.putByte(u2.mul(9, byte), 2) + u1.putByte(u2.mul(14, byte), 3);
		v2.tableInv1[v6] = u1.putByte(u2.mul(13, byte), 0) + u1.putByte(u2.mul(9, byte), 1) + u1.putByte(u2.mul(14, byte), 2) + u1.putByte(u2.mul(11, byte), 3);
		v2.tableInv2[v6] = u1.putByte(u2.mul(9, byte), 0) + u1.putByte(u2.mul(14, byte), 1) + u1.putByte(u2.mul(11, byte), 2) + u1.putByte(u2.mul(13, byte), 3);
		v2.tableInv3[v6] = u1.putByte(u2.mul(14, byte), 0) + u1.putByte(u2.mul(11, byte), 1) + u1.putByte(u2.mul(13, byte), 2) + u1.putByte(u2.mul(9, byte), 3);
	end;
end;
function v2.rotWord(p2)
	return bit.lshift(p2, 8) + bit.rshift(bit.band(p2, 4278190080), 24);
end;
function v2.subWord(p3)
	return u1.putByte(v2.SBox[u1.getByte(p3, 0)], 0) + u1.putByte(v2.SBox[u1.getByte(p3, 1)], 1) + u1.putByte(v2.SBox[u1.getByte(p3, 2)], 2) + u1.putByte(v2.SBox[u1.getByte(p3, 3)], 3);
end;
function v1.expandEncryptionKey(p4)
	local v7 = {};
	local v8 = math_floor(#p4 / 4);
	if (v8 == 4 or v8 == 6 or v8 == 8) and v8 * 4 == #p4 then
		v7[v1.ROUNDS] = v8 + 6;
		v7[v1.KEY_TYPE] = v1.ENCRYPTION_KEY;
		for v9 = 0, v8 - 1 do
			v7[v9] = u1.putByte(p4[v9 * 4 + 1], 3) + u1.putByte(p4[v9 * 4 + 2], 2) + u1.putByte(p4[v9 * 4 + 3], 1) + u1.putByte(p4[v9 * 4 + 4], 0);
		end;
		for v10 = v8, (v7[v1.ROUNDS] + 1) * 4 - 1 do
			local v11 = v7[v10 - 1];
			if v10 % v8 == 0 then
				v11 = bit.bxor(v2.subWord((v2.rotWord(v11))), v2.rCon[math_floor(v10 / v8)]);
			elseif v8 > 6 and v10 % v8 == 4 then
				v11 = v2.subWord(v11);
			end;
			v7[v10] = bit.bxor(v7[v10 - v8], v11);
		end;
		return v7;
	end;
	print("Invalid key size: ", v8);
	return nil;
end;
function v2.invMixColumnOld(p5)
	local v12 = u1.getByte(p5, 3);
	local v13 = u1.getByte(p5, 2);
	local v14 = u1.getByte(p5, 1);
	local v15 = u1.getByte(p5, 0);
	return u1.putByte(u2.add(u2.add(u2.add(u2.mul(11, v13), u2.mul(13, v14)), u2.mul(9, v15)), u2.mul(14, v12)), 3) + u1.putByte(u2.add(u2.add(u2.add(u2.mul(11, v14), u2.mul(13, v15)), u2.mul(9, v12)), u2.mul(14, v13)), 2) + u1.putByte(u2.add(u2.add(u2.add(u2.mul(11, v15), u2.mul(13, v12)), u2.mul(9, v13)), u2.mul(14, v14)), 1) + u1.putByte(u2.add(u2.add(u2.add(u2.mul(11, v12), u2.mul(13, v13)), u2.mul(9, v14)), u2.mul(14, v15)), 0);
end;
function v2.invMixColumn(p6)
	local v16 = u1.getByte(p6, 3);
	local v17 = u1.getByte(p6, 2);
	local v18 = u1.getByte(p6, 1);
	local v19 = u1.getByte(p6, 0);
	local v20 = bit.bxor(v19, v18);
	local v21 = bit.bxor(v17, v16);
	local v22 = bit.bxor(v20, v21);
	local v23 = bit.bxor(v22, u2.mul(8, v22));
	w = bit.bxor(v23, u2.mul(4, bit.bxor(v18, v16)));
	local v24 = bit.bxor(v23, u2.mul(4, bit.bxor(v19, v17)));
	return u1.putByte(bit.bxor(bit.bxor(v19, v24), u2.mul(2, bit.bxor(v16, v19))), 0) + u1.putByte(bit.bxor(bit.bxor(v18, w), u2.mul(2, v20)), 1) + u1.putByte(bit.bxor(bit.bxor(v17, v24), u2.mul(2, bit.bxor(v16, v19))), 2) + u1.putByte(bit.bxor(bit.bxor(v16, w), u2.mul(2, v21)), 3);
end;
function v1.expandDecryptionKey(p7)
	local v25 = v1.expandEncryptionKey(p7);
	if v25 == nil then
		return nil;
	end;
	v25[v1.KEY_TYPE] = v1.DECRYPTION_KEY;
	for v26 = 4, (v25[v1.ROUNDS] + 1) * 4 - 5 do
		v25[v26] = v2.invMixColumnOld(v25[v26]);
	end;
	return v25;
end;
function v2.addRoundKey(p8, p9, p10)
	for v27 = 0, 3 do
		p8[v27] = bit.bxor(p8[v27], p9[p10 * 4 + v27]);
	end;
end;
function v2.doRound(p11, p12)
	p12[0] = bit.bxor(bit.bxor(bit.bxor(v2.table0[u1.getByte(p11[0], 3)], v2.table1[u1.getByte(p11[1], 2)]), v2.table2[u1.getByte(p11[2], 1)]), v2.table3[u1.getByte(p11[3], 0)]);
	p12[1] = bit.bxor(bit.bxor(bit.bxor(v2.table0[u1.getByte(p11[1], 3)], v2.table1[u1.getByte(p11[2], 2)]), v2.table2[u1.getByte(p11[3], 1)]), v2.table3[u1.getByte(p11[0], 0)]);
	p12[2] = bit.bxor(bit.bxor(bit.bxor(v2.table0[u1.getByte(p11[2], 3)], v2.table1[u1.getByte(p11[3], 2)]), v2.table2[u1.getByte(p11[0], 1)]), v2.table3[u1.getByte(p11[1], 0)]);
	p12[3] = bit.bxor(bit.bxor(bit.bxor(v2.table0[u1.getByte(p11[3], 3)], v2.table1[u1.getByte(p11[0], 2)]), v2.table2[u1.getByte(p11[1], 1)]), v2.table3[u1.getByte(p11[2], 0)]);
end;
function v2.doLastRound(p13, p14)
	p14[0] = u1.putByte(v2.SBox[u1.getByte(p13[0], 3)], 3) + u1.putByte(v2.SBox[u1.getByte(p13[1], 2)], 2) + u1.putByte(v2.SBox[u1.getByte(p13[2], 1)], 1) + u1.putByte(v2.SBox[u1.getByte(p13[3], 0)], 0);
	p14[1] = u1.putByte(v2.SBox[u1.getByte(p13[1], 3)], 3) + u1.putByte(v2.SBox[u1.getByte(p13[2], 2)], 2) + u1.putByte(v2.SBox[u1.getByte(p13[3], 1)], 1) + u1.putByte(v2.SBox[u1.getByte(p13[0], 0)], 0);
	p14[2] = u1.putByte(v2.SBox[u1.getByte(p13[2], 3)], 3) + u1.putByte(v2.SBox[u1.getByte(p13[3], 2)], 2) + u1.putByte(v2.SBox[u1.getByte(p13[0], 1)], 1) + u1.putByte(v2.SBox[u1.getByte(p13[1], 0)], 0);
	p14[3] = u1.putByte(v2.SBox[u1.getByte(p13[3], 3)], 3) + u1.putByte(v2.SBox[u1.getByte(p13[0], 2)], 2) + u1.putByte(v2.SBox[u1.getByte(p13[1], 1)], 1) + u1.putByte(v2.SBox[u1.getByte(p13[2], 0)], 0);
end;
function v2.doInvRound(p15, p16)
	p16[0] = bit.bxor(bit.bxor(bit.bxor(v2.tableInv0[u1.getByte(p15[0], 3)], v2.tableInv1[u1.getByte(p15[3], 2)]), v2.tableInv2[u1.getByte(p15[2], 1)]), v2.tableInv3[u1.getByte(p15[1], 0)]);
	p16[1] = bit.bxor(bit.bxor(bit.bxor(v2.tableInv0[u1.getByte(p15[1], 3)], v2.tableInv1[u1.getByte(p15[0], 2)]), v2.tableInv2[u1.getByte(p15[3], 1)]), v2.tableInv3[u1.getByte(p15[2], 0)]);
	p16[2] = bit.bxor(bit.bxor(bit.bxor(v2.tableInv0[u1.getByte(p15[2], 3)], v2.tableInv1[u1.getByte(p15[1], 2)]), v2.tableInv2[u1.getByte(p15[0], 1)]), v2.tableInv3[u1.getByte(p15[3], 0)]);
	p16[3] = bit.bxor(bit.bxor(bit.bxor(v2.tableInv0[u1.getByte(p15[3], 3)], v2.tableInv1[u1.getByte(p15[2], 2)]), v2.tableInv2[u1.getByte(p15[1], 1)]), v2.tableInv3[u1.getByte(p15[0], 0)]);
end;
function v2.doInvLastRound(p17, p18)
	p18[0] = u1.putByte(v2.iSBox[u1.getByte(p17[0], 3)], 3) + u1.putByte(v2.iSBox[u1.getByte(p17[3], 2)], 2) + u1.putByte(v2.iSBox[u1.getByte(p17[2], 1)], 1) + u1.putByte(v2.iSBox[u1.getByte(p17[1], 0)], 0);
	p18[1] = u1.putByte(v2.iSBox[u1.getByte(p17[1], 3)], 3) + u1.putByte(v2.iSBox[u1.getByte(p17[0], 2)], 2) + u1.putByte(v2.iSBox[u1.getByte(p17[3], 1)], 1) + u1.putByte(v2.iSBox[u1.getByte(p17[2], 0)], 0);
	p18[2] = u1.putByte(v2.iSBox[u1.getByte(p17[2], 3)], 3) + u1.putByte(v2.iSBox[u1.getByte(p17[1], 2)], 2) + u1.putByte(v2.iSBox[u1.getByte(p17[0], 1)], 1) + u1.putByte(v2.iSBox[u1.getByte(p17[3], 0)], 0);
	p18[3] = u1.putByte(v2.iSBox[u1.getByte(p17[3], 3)], 3) + u1.putByte(v2.iSBox[u1.getByte(p17[2], 2)], 2) + u1.putByte(v2.iSBox[u1.getByte(p17[1], 1)], 1) + u1.putByte(v2.iSBox[u1.getByte(p17[0], 0)], 0);
end;
function v1.encrypt(p19, p20, p21, p22, p23)
	p21 = p21 and 1;
	p22 = p22 or {};
	p23 = p23 and 1;
	local v28 = {};
	local v29 = {};
	if p19[v1.KEY_TYPE] ~= v1.ENCRYPTION_KEY then
		print("No encryption key: ", p19[v1.KEY_TYPE]);
		return;
	end;
	local v30 = u1.bytesToInts(p20, p21, 4);
	v2.addRoundKey(v30, p19, 0);
	local v31 = 1;
	while v31 < p19[v1.ROUNDS] - 1 do
		v2.doRound(v30, v29);
		v2.addRoundKey(v29, p19, v31);
		local v32 = v31 + 1;
		v2.doRound(v29, v30);
		v2.addRoundKey(v30, p19, v32);
		v31 = v32 + 1;	
	end;
	v2.doRound(v30, v29);
	v2.addRoundKey(v29, p19, v31);
	v2.doLastRound(v29, v30);
	v2.addRoundKey(v30, p19, v31 + 1);
	return u1.intsToBytes(v30, p22, p23);
end;
function v1.decrypt(p24, p25, p26, p27, p28)
	p26 = p26 and 1;
	p27 = p27 or {};
	p28 = p28 and 1;
	local v33 = {};
	local v34 = {};
	if p24[v1.KEY_TYPE] ~= v1.DECRYPTION_KEY then
		print("No decryption key: ", p24[v1.KEY_TYPE]);
		return;
	end;
	local v35 = u1.bytesToInts(p25, p26, 4);
	v2.addRoundKey(v35, p24, p24[v1.ROUNDS]);
	local v36 = p24[v1.ROUNDS] - 1;
	while v36 > 2 do
		v2.doInvRound(v35, v34);
		v2.addRoundKey(v34, p24, v36);
		local v37 = v36 - 1;
		v2.doInvRound(v34, v35);
		v2.addRoundKey(v35, p24, v37);
		v36 = v37 - 1;	
	end;
	v2.doInvRound(v35, v34);
	v2.addRoundKey(v34, p24, v36);
	v2.doInvLastRound(v34, v35);
	v2.addRoundKey(v35, p24, v36 - 1);
	return u1.intsToBytes(v35, p27, p28);
end;
v2.calcSBox();
v2.calcRoundTables();
v2.calcInvRoundTables();
return v1;
