-- Decompiled with the Synapse X Luau decompiler.

local v1 = { "MOVE", "LOADK", "LOADBOOL", "LOADNIL", "GETUPVAL", "GETGLOBAL", "GETTABLE", "SETGLOBAL", "SETUPVAL", "SETTABLE", "NEWTABLE", "SELF", "ADD", "SUB", "MUL", "DIV", "MOD", "POW", "UNM", "NOT", "LEN", "CONCAT", "JMP", "EQ", "LT", "LE", "TEST", "TESTSET", "CALL", "TAILCALL", "RETURN", "FORLOOP", "FORPREP", "TFORLOOP", "SETLIST", "CLOSE", "CLOSURE", "VARARG" };
local function u1(p1, p2, p3)
	local v2 = nil;
	if not p3 then
		local v3 = 2 ^ (p2 - 1);
		if v3 <= p1 % (v3 + v3) then
			return 1;
		else
			return 0;
		end;
	end;
	v2 = 0;
	local v4 = 0;
	for v5 = p2, p3 do
		v2 = v2 + 2 ^ v4 * u1(p1, v5);
		v4 = v4 + 1;
	end;
	return local v6;
end;
local u2 = { "ABC", "ABx", "ABC", "ABC", "ABC", "ABx", "ABC", "ABx", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "AsBx", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "ABC", "AsBx", "AsBx", "ABC", "ABC", "ABC", "ABx", "ABC" };
local function u3(...)
	return select("#", ...), { ... };
end;
local function u4(p4, p5)
	local v7 = {};
	local u5 = nil;
	v7[0] = function(p6)
		u5[p6.A] = u5[p6.B];
	end;
	local l__constants__6 = p4.constants;
	v7[1] = function(p7)
		u5[p7.A] = l__constants__6[p7.Bx].data;
	end;
	local u7 = 1;
	v7[2] = function(p8)
		u5[p8.A] = p8.B ~= 0;
		if p8.C ~= 0 then
			u7 = u7 + 1;
		end;
	end;
	v7[3] = function(p9)
		for v8 = p9.A, p9.B do
			u5[v8] = nil;
		end;
	end;
	v7[4] = function(p10)
		u5[p10.A] = p5[p10.B];
	end;
	local u8 = nil;
	v7[5] = function(p11)
		u5[p11.A] = u8[l__constants__6[p11.Bx].data];
	end;
	v7[6] = function(p12)
		local l__C__9 = p12.C;
		u5[p12.A] = u5[p12.B][l__C__9 > 255 and l__constants__6[l__C__9 - 256].data or u5[l__C__9]];
	end;
	v7[7] = function(p13)
		u8[l__constants__6[p13.Bx].data] = u5[p13.A];
	end;
	v7[8] = function(p14)
		p5[p14.B] = u5[p14.A];
	end;
	v7[9] = function(p15)
		local l__B__10 = p15.B;
		local l__C__11 = p15.C;
		u5[p15.A][l__B__10 > 255 and l__constants__6[l__B__10 - 256].data or u5[l__B__10]] = l__C__11 > 255 and l__constants__6[l__C__11 - 256].data or u5[l__C__11];
	end;
	v7[10] = function(p16)
		u5[p16.A] = {};
	end;
	v7[11] = function(p17)
		local l__A__12 = p17.A;
		local l__C__13 = p17.C;
		local v14 = u5[p17.B];
		u5[l__A__12 + 1] = v14;
		u5[l__A__12] = v14[l__C__13 > 255 and l__constants__6[l__C__13 - 256].data or u5[l__C__13]];
	end;
	v7[12] = function(p18)
		local l__B__15 = p18.B;
		local l__C__16 = p18.C;
		u5[p18.A] = (l__B__15 > 255 and l__constants__6[l__B__15 - 256].data or u5[l__B__15]) + (l__C__16 > 255 and l__constants__6[l__C__16 - 256].data or u5[l__C__16]);
	end;
	v7[13] = function(p19)
		local l__B__17 = p19.B;
		local l__C__18 = p19.C;
		u5[p19.A] = (l__B__17 > 255 and l__constants__6[l__B__17 - 256].data or u5[l__B__17]) - (l__C__18 > 255 and l__constants__6[l__C__18 - 256].data or u5[l__C__18]);
	end;
	v7[14] = function(p20)
		local l__B__19 = p20.B;
		local l__C__20 = p20.C;
		u5[p20.A] = (l__B__19 > 255 and l__constants__6[l__B__19 - 256].data or u5[l__B__19]) * (l__C__20 > 255 and l__constants__6[l__C__20 - 256].data or u5[l__C__20]);
	end;
	v7[15] = function(p21)
		local l__B__21 = p21.B;
		local l__C__22 = p21.C;
		u5[p21.A] = (l__B__21 > 255 and l__constants__6[l__B__21 - 256].data or u5[l__B__21]) / (l__C__22 > 255 and l__constants__6[l__C__22 - 256].data or u5[l__C__22]);
	end;
	v7[16] = function(p22)
		local l__B__23 = p22.B;
		local l__C__24 = p22.C;
		u5[p22.A] = (l__B__23 > 255 and l__constants__6[l__B__23 - 256].data or u5[l__B__23]) % (l__C__24 > 255 and l__constants__6[l__C__24 - 256].data or u5[l__C__24]);
	end;
	v7[17] = function(p23)
		local l__B__25 = p23.B;
		local l__C__26 = p23.C;
		u5[p23.A] = (l__B__25 > 255 and l__constants__6[l__B__25 - 256].data or u5[l__B__25]) ^ (l__C__26 > 255 and l__constants__6[l__C__26 - 256].data or u5[l__C__26]);
	end;
	v7[18] = function(p24)
		u5[p24.A] = -u5[p24.B];
	end;
	v7[19] = function(p25)
		u5[p25.A] = not u5[p25.B];
	end;
	v7[20] = function(p26)
		u5[p26.A] = #u5[p26.B];
	end;
	v7[21] = function(p27)
		local v27 = nil;
		local l__B__28 = p27.B;
		v27 = u5[l__B__28];
		for v29 = l__B__28 + 1, p27.C do
			v27 = v27 .. u5[v29];
		end;
		u5[p27.A] = local v30;
	end;
	v7[22] = function(p28)
		u7 = u7 + p28.sBx;
	end;
	v7[23] = function(p29)
		local l__B__31 = p29.B;
		local l__C__32 = p29.C;
		if (l__B__31 > 255 and l__constants__6[l__B__31 - 256].data or u5[l__B__31]) == (l__C__32 > 255 and l__constants__6[l__C__32 - 256].data or u5[l__C__32]) ~= (p29.A ~= 0) then
			u7 = u7 + 1;
		end;
	end;
	v7[24] = function(p30)
		local l__B__33 = p30.B;
		local l__C__34 = p30.C;
		if (l__B__33 > 255 and l__constants__6[l__B__33 - 256].data or u5[l__B__33]) < (l__C__34 > 255 and l__constants__6[l__C__34 - 256].data or u5[l__C__34]) ~= (p30.A ~= 0) then
			u7 = u7 + 1;
		end;
	end;
	v7[25] = function(p31)
		local l__B__35 = p31.B;
		local l__C__36 = p31.C;
		if (l__B__35 > 255 and l__constants__6[l__B__35 - 256].data or u5[l__B__35]) <= (l__C__36 > 255 and l__constants__6[l__C__36 - 256].data or u5[l__C__36]) ~= (p31.A ~= 0) then
			u7 = u7 + 1;
		end;
	end;
	v7[26] = function(p32)
		if not (not u5[p32.A]) == (p32.C == 0) then
			u7 = u7 + 1;
		end;
	end;
	v7[27] = function(p33)
		local v37 = u5[p33.B];
		if not (not v37) == (p33.C == 0) then
			u7 = u7 + 1;
			return;
		end;
		u5[p33.A] = v37;
	end;
	local u9 = nil;
	v7[28] = function(p34)
		local l__A__38 = p34.A;
		local l__B__39 = p34.B;
		local l__C__40 = p34.C;
		local v41 = {};
		if l__B__39 ~= 1 then
			if l__B__39 ~= 0 then
				local v42 = l__A__38 + l__B__39 - 1;
			else
				v42 = u9;
			end;
			local v43 = 0;
			for v44 = l__A__38 + 1, v42 do
				v43 = v43 + 1;
				v41[v43] = u5[v44];
			end;
			local v45, v46 = u3(u5[l__A__38](unpack(v41, 1, v42 - l__A__38)));
			local v47 = v45;
			local v48 = v46;
		else
			local v49, v50 = u3(u5[l__A__38]());
			v47 = v49;
			v48 = v50;
		end;
		u9 = l__A__38 - 1;
		if l__C__40 ~= 1 then
			if l__C__40 ~= 0 then
				local v51 = l__A__38 + l__C__40 - 2;
			else
				v51 = v47 + l__A__38;
			end;
			local v52 = 0;
			for v53 = l__A__38, v51 do
				v52 = v52 + 1;
				u5[v53] = v48[v52];
			end;
		end;
	end;
	v7[29] = function(p35)
		local l__A__54 = p35.A;
		local l__B__55 = p35.B;
		local l__C__56 = p35.C;
		local v57 = {};
		if l__B__55 ~= 1 then
			if l__B__55 ~= 0 then
				local v58 = l__A__54 + l__B__55 - 1;
			else
				v58 = u9;
			end;
			local v59 = 0;
			for v60 = l__A__54 + 1, v58 do
				v59 = v59 + 1;
				v57[#v57 + 1] = u5[v60];
			end;
			local v61 = { u5[l__A__54](unpack(v57, 1, v58 - l__A__54)) };
		else
			v61 = { u5[l__A__54]() };
		end;
		return true, v61;
	end;
	v7[30] = function(p36)
		local l__A__62 = p36.A;
		local l__B__63 = p36.B;
		if l__B__63 == 1 then
			return true;
		end;
		if l__B__63 == 0 then
			local v64 = u9;
		else
			v64 = l__A__62 + l__B__63 - 2;
		end;
		local v65 = {};
		local v66 = 0;
		for v67 = l__A__62, v64 do
			v66 = v66 + 1;
			v65[v66] = u5[v67];
		end;
		return true, v65;
	end;
	v7[31] = function(p37)
		local l__A__68 = p37.A;
		local v69 = u5[l__A__68 + 2];
		local v70 = u5[l__A__68] + v69;
		u5[l__A__68] = v70;
		if v69 > 0 then
			if not (v70 <= u5[l__A__68 + 1]) then
				return;
			end;
		else
			if u5[l__A__68 + 1] <= v70 then
				u7 = u7 + p37.sBx;
				u5[l__A__68 + 3] = v70;
			end;
			return;
		end;
		u7 = u7 + p37.sBx;
		u5[l__A__68 + 3] = v70;
	end;
	v7[32] = function(p38)
		local l__A__71 = p38.A;
		u5[l__A__71] = u5[l__A__71] - u5[l__A__71 + 2];
		u7 = u7 + p38.sBx;
	end;
	v7[33] = function(p39)
		local l__A__72 = p39.A;
		local l__B__73 = p39.B;
		local v74 = l__A__72 + 2;
		local v75 = { u5[l__A__72](u5[l__A__72 + 1], u5[l__A__72 + 2]) };
		for v76 = 1, p39.C do
			u5[v74 + v76] = v75[v76];
		end;
		if u5[l__A__72 + 3] == nil then
			u7 = u7 + 1;
			return;
		end;
		u5[l__A__72 + 2] = u5[l__A__72 + 3];
	end;
	v7[34] = function(p40)
		local l__A__77 = p40.A;
		local v78 = p40.B;
		local l__C__79 = p40.C;
		if l__C__79 == 0 then
			error("NYI: extended SETLIST");
			return;
		end;
		local v80 = (l__C__79 - 1) * 50;
		local v81 = u5[l__A__77];
		if v78 == 0 then
			v78 = u9;
		end;
		for v82 = 1, v78 do
			v81[v80 + v82] = u5[l__A__77 + v82];
		end;
	end;
	v7[35] = function(p41)

	end;
	local l__prototypes__10 = p4.prototypes;
	local l__instructions__11 = p4.instructions;
	v7[36] = function(p42)
		local v83 = l__prototypes__10[p42.Bx];
		local v84 = {};
		local u12 = {};
		function v84.__index(p43, p44)
			local v85 = u12[p44];
			return v85.segment[v85.offset];
		end;
		function v84.__newindex(p45, p46, p47)
			local v86 = u12[p46];
			v86.segment[v86.offset] = p47;
		end;
		for v87 = 1, v83.upvalues do
			local v88 = l__instructions__11[u7];
			if v88.opcode == 0 then
				u12[v87 - 1] = {
					segment = u5, 
					offset = v88.B
				};
			elseif l__instructions__11[u7].opcode == 4 then
				u12[v87 - 1] = {
					segment = p5, 
					offset = v88.B
				};
			end;
			u7 = u7 + 1;
		end;
		local v89, v90 = u4(v83, (setmetatable({}, v84)));
		u5[p42.A] = v90;
	end;
	local u13 = nil;
	local u14 = nil;
	v7[37] = function(p48)
		local l__A__91 = p48.A;
		local l__B__92 = p48.B;
		for v93 = l__A__91, l__A__91 + (l__B__92 > 0 and l__B__92 - 1 or u14) do
			u5[v93] = u13[v93 - l__A__91];
		end;
	end;
	local function u15()
		while true do
			local v94 = l__instructions__11[u7];
			u7 = u7 + 1;
			local v95, v96 = v7[v94.opcode](v94);
			if v95 then
				break;
			end;		
		end;
		return v96;
	end;
	return {
		get_stack = function()
			return u5;
		end, 
		get_IP = function()
			return u7;
		end
	}, function(...)
		local v97 = {};
		local v98 = {};
		u9 = -1;
		local v99 = {
			__index = v98
		};
		function v99.__newindex(p49, p50, p51)
			if u9 < p50 and p51 then
				u9 = p50;
			end;
			v98[p50] = p51;
		end;
		u5 = setmetatable(v97, v99);
		local v100 = { ... };
		u13 = {};
		u14 = select("#", ...) - 1;
		for v101 = 0, u14 do
			v97[v101] = v100[v101 + 1];
			u13[v101] = v100[v101 + 1];
		end;
		u8 = getfenv();
		u7 = 1;
		local v102, v103 = coroutine.resume((coroutine.create(u15)));
		if v102 then
			if v103 then
				return unpack(v103);
			else
				return;
			end;
		end;
		local l__name__104 = p4.name;
		local v105 = p4.debug.lines[u7];
		local v106 = v103:gsub("(.-:)", "");
		error((("" .. (l__name__104 and l__name__104 .. ":" or "")) .. (v105 and v105 .. ":" or "")) .. v103, 0);
	end;
end;
local v107 = {};
local function u16(p52)
	local u17 = 1;
	local function u18()
		local v108, v109, v110, v111 = p52:byte(u17, u17 + 3);
		u17 = u17 + 4;
		return v111 * 16777216 + v110 * 65536 + v109 * 256 + v108;
	end;
	local function v112()
		return u18() * 4294967296 + u18();
	end;
	local u19 = nil;
	local function u20(p53)
		if p53 then
			local v113 = p52:sub(u17, u17 + p53 - 1);
			u17 = u17 + p53;
			return v113;
		end;
		p53 = u19();
		if p53 == 0 then
			return;
		end;
		local v114 = p52:sub(u17, u17 + p53 - 1);
		u17 = u17 + p53;
		return v114;
	end;
	local u21 = nil;
	local function u22()
		local v115 = p52:byte(u17, u17);
		u17 = u17 + 1;
		return v115;
	end;
	local function u23()
		local v116 = u18();
		return (-2 * u1(v116, 32) + 1) * 2 ^ (u1(v116, 21, 31) - 1023) * ((u1(v116, 1, 20) * 4294967296 + u18()) / 4503599627370496 + 1);
	end;
	local function u24()
		local v117 = {};
		local v118 = {};
		local v119 = {};
		local v120 = {
			lines = {}
		};
		local v121 = {
			instructions = v117, 
			constants = v118, 
			prototypes = v119, 
			debug = v120, 
			name = u20(), 
			first_line = u21(), 
			last_line = u21()
		};
		if v121.name then
			v121.name = v121.name:sub(1, -2);
		end;
		v121.upvalues = u22();
		v121.arguments = u22();
		v121.varg = u22();
		v121.stack = u22();
		for v122 = 1, u21() do
			local v123 = {};
			local v124 = u18();
			local v125 = u1(v124, 1, 6);
			local v126 = u2[v125 + 1];
			v123.opcode = v125;
			v123.type = v126;
			v123.A = u1(v124, 7, 14);
			if v126 == "ABC" then
				v123.B = u1(v124, 24, 32);
				v123.C = u1(v124, 15, 23);
			elseif v126 == "ABx" then
				v123.Bx = u1(v124, 15, 32);
			elseif v126 == "AsBx" then
				v123.sBx = u1(v124, 15, 32) - 131071;
			end;
			v117[v122] = v123;
		end;
		for v127 = 1, u21() do
			local v128 = {};
			local v129 = u22();
			v128.type = v129;
			if v129 == 1 then
				v128.data = u22() ~= 0;
			elseif v129 == 3 then
				v128.data = u23();
			elseif v129 == 4 then
				v128.data = u20():sub(1, -2);
			end;
			v118[v127 - 1] = v128;
		end;
		for v130 = 1, u21() do
			v119[v130 - 1] = u24();
		end;
		local l__lines__131 = v120.lines;
		for v132 = 1, u21() do
			l__lines__131[v132] = u18();
		end;
		for v133 = 1, u21() do
			u20():sub(1, -2);
			u18();
			u18();
		end;
		for v134 = 1, u21() do
			u20();
		end;
		return v121;
	end;
	assert(u20(4) == "\027Lua", "Lua bytecode expected.");
	assert(u22() == 81, "Only Lua 5.1 is supported.");
	u22();
	if u22() ~= 0 then

	end;
	local v135 = u22();
	local v136 = u22();
	if v135 == 4 then
		u21 = u18;
	elseif v135 == 8 then
		u21 = v112;
	else
		error("Unsupported bytecode target platform");
	end;
	if v136 == 4 then
		u19 = u18;
	elseif v136 == 8 then
		u19 = v112;
	else
		error("Unsupported bytecode target platform");
	end;
	assert(u20(3) == "\004\008\000", "Unsupported bytecode target platform");
	return u24();
end;
function v107.load_bytecode(p54, p55)
	local v137, v138 = u4((u16(p54)));
	return v138;
end;
v107.utils = {
	decode_bytecode = u16, 
	create_wrapper = u4, 
	debug_bytecode = function(p56)
		return u4((u16(p56)));
	end
};
return v107;
