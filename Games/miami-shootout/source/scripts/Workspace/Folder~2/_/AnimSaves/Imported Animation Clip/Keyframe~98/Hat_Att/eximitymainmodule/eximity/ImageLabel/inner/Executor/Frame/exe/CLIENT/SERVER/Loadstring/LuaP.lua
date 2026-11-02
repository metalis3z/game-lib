-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	OpMode = {
		iABC = 0, 
		iABx = 1, 
		iAsBx = 2
	}, 
	SIZE_C = 9, 
	SIZE_B = 9
};
v1.SIZE_Bx = v1.SIZE_C + v1.SIZE_B;
v1.SIZE_A = 8;
v1.SIZE_OP = 6;
v1.POS_OP = 0;
v1.POS_A = v1.POS_OP + v1.SIZE_OP;
v1.POS_C = v1.POS_A + v1.SIZE_A;
v1.POS_B = v1.POS_C + v1.SIZE_C;
v1.POS_Bx = v1.POS_C;
v1.MAXARG_Bx = math.ldexp(1, v1.SIZE_Bx) - 1;
v1.MAXARG_sBx = math.floor(v1.MAXARG_Bx / 2);
v1.MAXARG_A = math.ldexp(1, v1.SIZE_A) - 1;
v1.MAXARG_B = math.ldexp(1, v1.SIZE_B) - 1;
v1.MAXARG_C = math.ldexp(1, v1.SIZE_C) - 1;
function v1.GET_OPCODE(p1, p2)
	return p1.ROpCode[p2.OP];
end;
function v1.SET_OPCODE(p3, p4, p5)
	p4.OP = p3.OpCode[p5];
end;
function v1.GETARG_A(p6, p7)
	return p7.A;
end;
function v1.SETARG_A(p8, p9, p10)
	p9.A = p10;
end;
function v1.GETARG_B(p11, p12)
	return p12.B;
end;
function v1.SETARG_B(p13, p14, p15)
	p14.B = p15;
end;
function v1.GETARG_C(p16, p17)
	return p17.C;
end;
function v1.SETARG_C(p18, p19, p20)
	p19.C = p20;
end;
function v1.GETARG_Bx(p21, p22)
	return p22.Bx;
end;
function v1.SETARG_Bx(p23, p24, p25)
	p24.Bx = p25;
end;
function v1.GETARG_sBx(p26, p27)
	return p27.Bx - p26.MAXARG_sBx;
end;
function v1.SETARG_sBx(p28, p29, p30)
	p29.Bx = p30 + p28.MAXARG_sBx;
end;
function v1.CREATE_ABC(p31, p32, p33, p34, p35)
	return {
		OP = p31.OpCode[p32], 
		A = p33, 
		B = p34, 
		C = p35
	};
end;
function v1.CREATE_ABx(p36, p37, p38, p39)
	return {
		OP = p36.OpCode[p37], 
		A = p38, 
		Bx = p39
	};
end;
function v1.CREATE_Inst(p40, p41)
	local v2 = p41 % 64;
	p41 = (p41 - v2) / 64;
	local v3 = p41 % 256;
	p41 = (p41 - v3) / 256;
	return p40:CREATE_ABx(v2, v3, p41);
end;
function v1.Instruction(p42, p43)
	if p43.Bx then
		p43.C = p43.Bx % 512;
		p43.B = (p43.Bx - p43.C) / 512;
	end;
	local v4 = p43.A * 64 + p43.OP;
	local v5 = v4 % 256;
	local v6 = p43.C * 64 + (v4 - v5) / 256;
	local v7 = v6 % 256;
	local v8 = p43.B * 128 + (v6 - v7) / 256;
	local v9 = v8 % 256;
	return string.char(v5, v7, v9, (v8 - v9) / 256);
end;
function v1.DecodeInst(p44, p45)
	local v10 = {};
	local v11 = string.byte(p45, 1);
	local v12 = v11 % 64;
	v10.OP = v12;
	local v13 = string.byte(p45, 2) * 4 + (v11 - v12) / 64;
	local v14 = v13 % 256;
	v10.A = v14;
	local v15 = string.byte(p45, 3) * 4 + (v13 - v14) / 256;
	local v16 = v15 % 512;
	v10.C = v16;
	v10.B = string.byte(p45, 4) * 2 + (v15 - v16) / 512;
	if p44.OpMode[tonumber((string.sub(p44.opmodes[v12 + 1], 7, 7)))] ~= "iABC" then
		v10.Bx = v10.B * 512 + v10.C;
	end;
	return v10;
end;
v1.BITRK = math.ldexp(1, v1.SIZE_B - 1);
function v1.ISK(p46, p47)
	return p46.BITRK <= p47;
end;
function v1.INDEXK(p48, p49)
	return p49 - p48.BITRK;
end;
v1.MAXINDEXRK = v1.BITRK - 1;
function v1.RKASK(p50, p51)
	return p51 + p50.BITRK;
end;
v1.NO_REG = v1.MAXARG_A;
v1.opnames = {};
v1.OpCode = {};
v1.ROpCode = {};
local v17 = 0;
for v18 in string.gmatch("MOVE LOADK LOADBOOL LOADNIL GETUPVAL\nGETGLOBAL GETTABLE SETGLOBAL SETUPVAL SETTABLE\nNEWTABLE SELF ADD SUB MUL\nDIV MOD POW UNM NOT\nLEN CONCAT JMP EQ LT\nLE TEST TESTSET CALL TAILCALL\nRETURN FORLOOP FORPREP TFORLOOP SETLIST\nCLOSE CLOSURE VARARG\n", "%S+") do
	local v19 = "OP_" .. v18;
	v1.opnames[v17] = v18;
	v1.OpCode[v19] = v17;
	v1.ROpCode[v17] = v19;
	v17 = v17 + 1;
end;
v1.NUM_OPCODES = v17;
v1.OpArgMask = {
	OpArgN = 0, 
	OpArgU = 1, 
	OpArgR = 2, 
	OpArgK = 3
};
function v1.getOpMode(p52, p53)
	return p52.opmodes[p52.OpCode[p53]] % 4;
end;
function v1.getBMode(p54, p55)
	return math.floor(p54.opmodes[p54.OpCode[p55]] / 16) % 4;
end;
function v1.getCMode(p56, p57)
	return math.floor(p56.opmodes[p56.OpCode[p57]] / 4) % 4;
end;
function v1.testAMode(p58, p59)
	return math.floor(p58.opmodes[p58.OpCode[p59]] / 64) % 2;
end;
function v1.testTMode(p60, p61)
	return math.floor(p60.opmodes[p60.OpCode[p61]] / 128);
end;
v1.LFIELDS_PER_FLUSH = 50;
v1.opmodes = { 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABx, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABx, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 0 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABx, 0 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 0 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgR * 4 + v1.OpMode.iABC, 0 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iAsBx, 128 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 128 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 128 + v1.OpArgMask.OpArgK * 16 + v1.OpArgMask.OpArgK * 4 + v1.OpMode.iABC, 192 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 192 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 0 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iAsBx, 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iAsBx, 128 + v1.OpArgMask.OpArgN * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 0 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgU * 4 + v1.OpMode.iABC, 0 + v1.OpArgMask.OpArgN * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABx, 64 + v1.OpArgMask.OpArgU * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC };
v1.opmodes[0] = 64 + v1.OpArgMask.OpArgR * 16 + v1.OpArgMask.OpArgN * 4 + v1.OpMode.iABC;
return v1;
