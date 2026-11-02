-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	MAXSTACK = 250, 
	ttisnumber = function(p1, p2)
		if not p2 then
			return false;
		end;
		return type(p2.value) == "number";
	end, 
	nvalue = function(p3, p4)
		return p4.value;
	end, 
	setnilvalue = function(p5, p6)
		p6.value = nil;
	end, 
	setsvalue = function(p7, p8, p9)
		p8.value = p9;
	end
};
v1.setnvalue = v1.setsvalue;
v1.sethvalue = v1.setsvalue;
v1.setbvalue = v1.setsvalue;
function v1.numadd(p10, p11, p12)
	return p11 + p12;
end;
function v1.numsub(p13, p14, p15)
	return p14 - p15;
end;
function v1.nummul(p16, p17, p18)
	return p17 * p18;
end;
function v1.numdiv(p19, p20, p21)
	return p20 / p21;
end;
function v1.nummod(p22, p23, p24)
	return p23 % p24;
end;
function v1.numpow(p25, p26, p27)
	return p26 ^ p27;
end;
function v1.numunm(p28, p29)
	return -p29;
end;
function v1.numisnan(p30, p31)
	return not p31 == p31;
end;
v1.NO_JUMP = -1;
v1.BinOpr = {
	OPR_ADD = 0, 
	OPR_SUB = 1, 
	OPR_MUL = 2, 
	OPR_DIV = 3, 
	OPR_MOD = 4, 
	OPR_POW = 5, 
	OPR_CONCAT = 6, 
	OPR_NE = 7, 
	OPR_EQ = 8, 
	OPR_LT = 9, 
	OPR_LE = 10, 
	OPR_GT = 11, 
	OPR_GE = 12, 
	OPR_AND = 13, 
	OPR_OR = 14, 
	OPR_NOBINOPR = 15
};
v1.UnOpr = {
	OPR_MINUS = 0, 
	OPR_NOT = 1, 
	OPR_LEN = 2, 
	OPR_NOUNOPR = 3
};
function v1.getcode(p32, p33, p34)
	return p33.f.code[p34.info];
end;
local u1 = require(script.Parent.LuaP);
function v1.codeAsBx(p35, p36, p37, p38, p39)
	return p35:codeABx(p36, p37, p38, p39 + u1.MAXARG_sBx);
end;
function v1.setmultret(p40, p41, p42)
	p40:setreturns(p41, p42, luaY.LUA_MULTRET);
end;
function v1.hasjumps(p43, p44)
	return p44.t ~= p44.f;
end;
function v1.isnumeral(p45, p46)
	local v2 = false;
	if p46.k == "VKNUM" then
		v2 = false;
		if p46.t == p45.NO_JUMP then
			v2 = p46.f == p45.NO_JUMP;
		end;
	end;
	return v2;
end;
function v1._nil(p47, p48, p49, p50)
	if p48.lasttarget < p48.pc then
		if p48.pc == 0 then
			if p48.nactvar <= p49 then
				return;
			end;
		else
			local v3 = p48.f.code[p48.pc - 1];
			if u1:GET_OPCODE(v3) == "OP_LOADNIL" then
				local v4 = u1:GETARG_B(v3);
				if u1:GETARG_A(v3) <= p49 and p49 <= v4 + 1 then
					if v4 < p49 + p50 - 1 then
						u1:SETARG_B(v3, p49 + p50 - 1);
					end;
					return;
				end;
			end;
		end;
	end;
	p47:codeABC(p48, "OP_LOADNIL", p49, p49 + p50 - 1, 0);
end;
function v1.jump(p51, p52)
	p52.jpc = p51.NO_JUMP;
	return p51:concat(p52, p51:codeAsBx(p52, "OP_JMP", 0, p51.NO_JUMP), p52.jpc);
end;
function v1.ret(p53, p54, p55, p56)
	p53:codeABC(p54, "OP_RETURN", p55, p56 + 1, 0);
end;
function v1.condjump(p57, p58, p59, p60, p61, p62)
	p57:codeABC(p58, p59, p60, p61, p62);
	return p57:jump(p58);
end;
local u2 = require(script.Parent.LuaX);
function v1.fixjump(p63, p64, p65, p66)
	local v5 = p66 - (p65 + 1);
	assert(p66 ~= p63.NO_JUMP);
	if u1.MAXARG_sBx < math.abs(v5) then
		u2:syntaxerror(p64.ls, "control structure too long");
	end;
	u1:SETARG_sBx(p64.f.code[p65], v5);
end;
function v1.getlabel(p67, p68)
	p68.lasttarget = p68.pc;
	return p68.pc;
end;
function v1.getjump(p69, p70, p71)
	local v6 = u1:GETARG_sBx(p70.f.code[p71]);
	if v6 == p69.NO_JUMP then
		return p69.NO_JUMP;
	end;
	return p71 + 1 + v6;
end;
function v1.getjumpcontrol(p72, p73, p74)
	local v7 = p73.f.code[p74 - 1];
	if p74 >= 1 and u1:testTMode(u1:GET_OPCODE(v7)) ~= 0 then
		return v7;
	end;
	return p73.f.code[p74];
end;
function v1.need_value(p75, p76, p77)
	while p77 ~= p75.NO_JUMP do
		if u1:GET_OPCODE((p75:getjumpcontrol(p76, p77))) ~= "OP_TESTSET" then
			return true;
		end;
		p77 = p75:getjump(p76, p77);	
	end;
	return false;
end;
function v1.patchtestreg(p78, p79, p80, p81)
	local v8 = p78:getjumpcontrol(p79, p80);
	if u1:GET_OPCODE(v8) ~= "OP_TESTSET" then
		return false;
	end;
	if p81 ~= u1.NO_REG and p81 ~= u1:GETARG_B(v8) then
		u1:SETARG_A(v8, p81);
	else
		u1:SET_OPCODE(v8, "OP_TEST");
		u1:SETARG_A(v8, (u1:GETARG_B(v8)));
		u1:SETARG_B(v8, 0);
	end;
	return true;
end;
function v1.removevalues(p82, p83, p84)
	while p84 ~= p82.NO_JUMP do
		p82:patchtestreg(p83, p84, u1.NO_REG);
		p84 = p82:getjump(p83, p84);	
	end;
end;
function v1.patchlistaux(p85, p86, p87, p88, p89, p90)
	while p87 ~= p85.NO_JUMP do
		if p85:patchtestreg(p86, p87, p89) then
			p85:fixjump(p86, p87, p88);
		else
			p85:fixjump(p86, p87, p90);
		end;
		p87 = p85:getjump(p86, p87);	
	end;
end;
function v1.dischargejpc(p91, p92)
	p91:patchlistaux(p92, p92.jpc, p92.pc, u1.NO_REG, p92.pc);
	p92.jpc = p91.NO_JUMP;
end;
function v1.patchlist(p93, p94, p95, p96)
	if p96 == p94.pc then
		p93:patchtohere(p94, p95);
		return;
	end;
	assert(p96 < p94.pc);
	p93:patchlistaux(p94, p95, p96, u1.NO_REG, p96);
end;
function v1.patchtohere(p97, p98, p99)
	p97:getlabel(p98);
	p98.jpc = p97:concat(p98, p98.jpc, p99);
end;
function v1.concat(p100, p101, p102, p103)
	if p103 == p100.NO_JUMP then
		return p102;
	end;
	if p102 == p100.NO_JUMP then
		return p103;
	end;
	local v9 = p102;
	local v10 = p100:getjump(p101, v9);
	while v10 ~= p100.NO_JUMP do
		v9 = v10;
		v10 = p100:getjump(p101, v9);	
	end;
	p100:fixjump(p101, v9, p103);
	return p102;
end;
function v1.checkstack(p104, p105, p106)
	local v11 = p105.freereg + p106;
	if p105.f.maxstacksize < v11 then
		if p104.MAXSTACK <= v11 then
			u2:syntaxerror(p105.ls, "function or expression too complex");
		end;
		p105.f.maxstacksize = v11;
	end;
end;
function v1.reserveregs(p107, p108, p109)
	p107:checkstack(p108, p109);
	p108.freereg = p108.freereg + p109;
end;
function v1.freereg(p110, p111, p112)
	if not u1:ISK(p112) and p111.nactvar <= p112 then
		p111.freereg = p111.freereg - 1;
		assert(p112 == p111.freereg);
	end;
end;
function v1.freeexp(p113, p114, p115)
	if p115.k == "VNONRELOC" then
		p113:freereg(p114, p115.info);
	end;
end;
function v1.addk(p116, p117, p118, p119)
	local v12 = p117.h[p118.value];
	local l__f__13 = p117.f;
	if p116:ttisnumber(v12) then
		return p116:nvalue(v12);
	end;
	local v14 = {};
	p116:setnvalue(v14, p117.nk);
	p117.h[p118.value] = v14;
	luaY:growvector(p117.L, l__f__13.k, p117.nk, l__f__13.sizek, nil, u1.MAXARG_Bx, "constant table overflow");
	l__f__13.k[p117.nk] = p119;
	p117.nk = p117.nk + 1;
	return p117.nk;
end;
function v1.stringK(p120, p121, p122)
	local v15 = {};
	p120:setsvalue(v15, p122);
	return p120:addk(p121, v15, v15);
end;
function v1.numberK(p123, p124, p125)
	local v16 = {};
	p123:setnvalue(v16, p125);
	return p123:addk(p124, v16, v16);
end;
function v1.boolK(p126, p127, p128)
	local v17 = {};
	p126:setbvalue(v17, p128);
	return p126:addk(p127, v17, v17);
end;
function v1.nilK(p129, p130)
	local v18 = {};
	local v19 = {};
	p129:setnilvalue(v19);
	p129:sethvalue(v18, p130.h);
	return p129:addk(p130, v18, v19);
end;
function v1.setreturns(p131, p132, p133, p134)
	if p133.k == "VCALL" then
		u1:SETARG_C(p131:getcode(p132, p133), p134 + 1);
		return;
	end;
	if p133.k == "VVARARG" then
		u1:SETARG_B(p131:getcode(p132, p133), p134 + 1);
		u1:SETARG_A(p131:getcode(p132, p133), p132.freereg);
		v1:reserveregs(p132, 1);
	end;
end;
function v1.setoneret(p135, p136, p137)
	if p137.k == "VCALL" then
		p137.k = "VNONRELOC";
		p137.info = u1:GETARG_A(p135:getcode(p136, p137));
		return;
	end;
	if p137.k == "VVARARG" then
		u1:SETARG_B(p135:getcode(p136, p137), 2);
		p137.k = "VRELOCABLE";
	end;
end;
function v1.dischargevars(p138, p139, p140)
	local l__k__20 = p140.k;
	if l__k__20 == "VLOCAL" then
		p140.k = "VNONRELOC";
		return;
	end;
	if l__k__20 == "VUPVAL" then
		p140.info = p138:codeABC(p139, "OP_GETUPVAL", 0, p140.info, 0);
		p140.k = "VRELOCABLE";
		return;
	end;
	if l__k__20 == "VGLOBAL" then
		p140.info = p138:codeABx(p139, "OP_GETGLOBAL", 0, p140.info);
		p140.k = "VRELOCABLE";
		return;
	end;
	if l__k__20 ~= "VINDEXED" then
		if l__k__20 == "VVARARG" or l__k__20 == "VCALL" then
			p138:setoneret(p139, p140);
			return;
		else
			return;
		end;
	end;
	p138:freereg(p139, p140.aux);
	p138:freereg(p139, p140.info);
	p140.info = p138:codeABC(p139, "OP_GETTABLE", 0, p140.info, p140.aux);
	p140.k = "VRELOCABLE";
end;
function v1.code_label(p141, p142, p143, p144, p145)
	p141:getlabel(p142);
	return p141:codeABC(p142, "OP_LOADBOOL", p143, p144, p145);
end;
function v1.discharge2reg(p146, p147, p148, p149)
	p146:dischargevars(p147, p148);
	local l__k__21 = p148.k;
	if l__k__21 == "VNIL" then
		p146:_nil(p147, p149, 1);
	elseif l__k__21 == "VFALSE" or l__k__21 == "VTRUE" then
		if p148.k == "VTRUE" then
			local v22 = 1;
		else
			v22 = 0;
		end;
		p146:codeABC(p147, "OP_LOADBOOL", p149, v22, 0);
	elseif l__k__21 == "VK" then
		p146:codeABx(p147, "OP_LOADK", p149, p148.info);
	elseif l__k__21 == "VKNUM" then
		p146:codeABx(p147, "OP_LOADK", p149, p146:numberK(p147, p148.nval));
	elseif l__k__21 == "VRELOCABLE" then
		u1:SETARG_A(p146:getcode(p147, p148), p149);
	else
		if l__k__21 ~= "VNONRELOC" then
			local v23 = true;
			if p148.k ~= "VVOID" then
				v23 = p148.k == "VJMP";
			end;
			assert(v23);
			return;
		end;
		if p149 ~= p148.info then
			p146:codeABC(p147, "OP_MOVE", p149, p148.info, 0);
		end;
	end;
	p148.info = p149;
	p148.k = "VNONRELOC";
end;
function v1.discharge2anyreg(p150, p151, p152)
	if p152.k ~= "VNONRELOC" then
		p150:reserveregs(p151, 1);
		p150:discharge2reg(p151, p152, p151.freereg - 1);
	end;
end;
function v1.exp2reg(p153, p154, p155, p156)
	p153:discharge2reg(p154, p155, p156);
	if p155.k == "VJMP" then
		p155.t = p153:concat(p154, p155.t, p155.info);
	end;
	if p153:hasjumps(p155) then
		local v24 = p153.NO_JUMP;
		local v25 = p153.NO_JUMP;
		if p153:need_value(p154, p155.t) or p153:need_value(p154, p155.f) then
			v24 = p153:code_label(p154, p156, 0, 1);
			v25 = p153:code_label(p154, p156, 1, 0);
			p153:patchtohere(p154, p155.k == "VJMP" and p153.NO_JUMP or p153:jump(p154));
		end;
		local v26 = p153:getlabel(p154);
		p153:patchlistaux(p154, p155.f, v26, p156, v24);
		p153:patchlistaux(p154, p155.t, v26, p156, v25);
	end;
	p155.f = p153.NO_JUMP;
	p155.t = p153.NO_JUMP;
	p155.info = p156;
	p155.k = "VNONRELOC";
end;
function v1.exp2nextreg(p157, p158, p159)
	p157:dischargevars(p158, p159);
	p157:freeexp(p158, p159);
	p157:reserveregs(p158, 1);
	p157:exp2reg(p158, p159, p158.freereg - 1);
end;
function v1.exp2anyreg(p160, p161, p162)
	p160:dischargevars(p161, p162);
	if p162.k == "VNONRELOC" then
		if not p160:hasjumps(p162) then
			return p162.info;
		end;
		if p161.nactvar <= p162.info then
			p160:exp2reg(p161, p162, p162.info);
			return p162.info;
		end;
	end;
	p160:exp2nextreg(p161, p162);
	return p162.info;
end;
function v1.exp2val(p163, p164, p165)
	if p163:hasjumps(p165) then
		p163:exp2anyreg(p164, p165);
		return;
	end;
	p163:dischargevars(p164, p165);
end;
function v1.exp2RK(p166, p167, p168)
	p166:exp2val(p167, p168);
	local l__k__27 = p168.k;
	if l__k__27 == "VKNUM" or l__k__27 == "VTRUE" or l__k__27 == "VFALSE" or l__k__27 == "VNIL" then
		if p167.nk <= u1.MAXINDEXRK then
			if p168.k == "VNIL" then
				p168.info = p166:nilK(p167);
			else
				p168.info = p168.k == "VKNUM" and p166:numberK(p167, p168.nval) or p166:boolK(p167, p168.k == "VTRUE");
			end;
			p168.k = "VK";
			return u1:RKASK(p168.info);
		end;
	elseif l__k__27 == "VK" and p168.info <= u1.MAXINDEXRK then
		return u1:RKASK(p168.info);
	end;
	return p166:exp2anyreg(p167, p168);
end;
function v1.storevar(p169, p170, p171, p172)
	local l__k__28 = p171.k;
	if l__k__28 == "VLOCAL" then
		p169:freeexp(p170, p172);
		p169:exp2reg(p170, p172, p171.info);
		return;
	end;
	if l__k__28 == "VUPVAL" then
		p169:codeABC(p170, "OP_SETUPVAL", p169:exp2anyreg(p170, p172), p171.info, 0);
	elseif l__k__28 == "VGLOBAL" then
		p169:codeABx(p170, "OP_SETGLOBAL", p169:exp2anyreg(p170, p172), p171.info);
	elseif l__k__28 == "VINDEXED" then
		p169:codeABC(p170, "OP_SETTABLE", p171.info, p171.aux, (p169:exp2RK(p170, p172)));
	else
		assert(0);
	end;
	p169:freeexp(p170, p172);
end;
function v1._self(p173, p174, p175, p176)
	p173:exp2anyreg(p174, p175);
	p173:freeexp(p174, p175);
	local l__freereg__29 = p174.freereg;
	p173:reserveregs(p174, 2);
	p173:codeABC(p174, "OP_SELF", l__freereg__29, p175.info, p173:exp2RK(p174, p176));
	p173:freeexp(p174, p176);
	p175.info = l__freereg__29;
	p175.k = "VNONRELOC";
end;
function v1.invertjump(p177, p178, p179)
	local v30 = p177:getjumpcontrol(p178, p179.info);
	local v31 = false;
	if u1:testTMode(u1:GET_OPCODE(v30)) ~= 0 then
		v31 = false;
		if u1:GET_OPCODE(v30) ~= "OP_TESTSET" then
			v31 = u1:GET_OPCODE(v30) ~= "OP_TEST";
		end;
	end;
	assert(v31);
	if u1:GETARG_A(v30) == 0 then
		local v32 = 1;
	else
		v32 = 0;
	end;
	u1:SETARG_A(v30, v32);
end;
function v1.jumponcond(p180, p181, p182, p183)
	if p182.k == "VRELOCABLE" then
		local v33 = p180:getcode(p181, p182);
		if u1:GET_OPCODE(v33) == "OP_NOT" then
			p181.pc = p181.pc - 1;
			if p183 then
				local v34 = 0;
			else
				v34 = 1;
			end;
			return p180:condjump(p181, "OP_TEST", u1:GETARG_B(v33), 0, v34);
		end;
	end;
	p180:discharge2anyreg(p181, p182);
	p180:freeexp(p181, p182);
	if p183 then
		local v35 = 1;
	else
		v35 = 0;
	end;
	return p180:condjump(p181, "OP_TESTSET", u1.NO_REG, p182.info, v35);
end;
function v1.goiftrue(p184, p185, p186)
	p184:dischargevars(p185, p186);
	local l__k__36 = p186.k;
	if l__k__36 == "VK" or l__k__36 == "VKNUM" or l__k__36 == "VTRUE" then
		local v37 = p184.NO_JUMP;
	elseif l__k__36 == "VFALSE" then
		v37 = p184:jump(p185);
	elseif l__k__36 == "VJMP" then
		p184:invertjump(p185, p186);
		v37 = p186.info;
	else
		v37 = p184:jumponcond(p185, p186, false);
	end;
	p186.f = p184:concat(p185, p186.f, v37);
	p184:patchtohere(p185, p186.t);
	p186.t = p184.NO_JUMP;
end;
function v1.goiffalse(p187, p188, p189)
	p187:dischargevars(p188, p189);
	local l__k__38 = p189.k;
	if l__k__38 == "VNIL" or l__k__38 == "VFALSE" then
		local v39 = p187.NO_JUMP;
	elseif l__k__38 == "VTRUE" then
		v39 = p187:jump(p188);
	elseif l__k__38 == "VJMP" then
		v39 = p189.info;
	else
		v39 = p187:jumponcond(p188, p189, true);
	end;
	p189.t = p187:concat(p188, p189.t, v39);
	p187:patchtohere(p188, p189.f);
	p189.f = p187.NO_JUMP;
end;
function v1.codenot(p190, p191, p192)
	p190:dischargevars(p191, p192);
	local l__k__40 = p192.k;
	if l__k__40 == "VNIL" or l__k__40 == "VFALSE" then
		p192.k = "VTRUE";
	elseif l__k__40 == "VK" or l__k__40 == "VKNUM" or l__k__40 == "VTRUE" then
		p192.k = "VFALSE";
	elseif l__k__40 == "VJMP" then
		p190:invertjump(p191, p192);
	elseif l__k__40 == "VRELOCABLE" or l__k__40 == "VNONRELOC" then
		p190:discharge2anyreg(p191, p192);
		p190:freeexp(p191, p192);
		p192.info = p190:codeABC(p191, "OP_NOT", 0, p192.info, 0);
		p192.k = "VRELOCABLE";
	else
		assert(0);
	end;
	p192.f = p192.t;
	p192.t = p192.f;
	p190:removevalues(p191, p192.f);
	p190:removevalues(p191, p192.t);
end;
function v1.indexed(p193, p194, p195, p196)
	p195.aux = p193:exp2RK(p194, p196);
	p195.k = "VINDEXED";
end;
function v1.constfolding(p197, p198, p199, p200)
	local v41 = nil;
	local v42 = nil;
	if not p197:isnumeral(p199) or not p197:isnumeral(p200) then
		return false;
	end;
	v41 = p199.nval;
	v42 = p200.nval;
	if p198 == "OP_ADD" then
		local v43 = p197:numadd(v41, v42);
	elseif p198 == "OP_SUB" then
		v43 = p197:numsub(v41, v42);
	elseif p198 == "OP_MUL" then
		v43 = p197:nummul(v41, v42);
	elseif p198 == "OP_DIV" then
		if v42 == 0 then
			return false;
		end;
		v43 = p197:numdiv(v41, v42);
	elseif p198 == "OP_MOD" then
		if v42 == 0 then
			return false;
		end;
		v43 = p197:nummod(v41, v42);
	elseif p198 == "OP_POW" then
		v43 = p197:numpow(v41, v42);
	elseif p198 == "OP_UNM" then
		v43 = p197:numunm(v41);
	else
		if p198 == "OP_LEN" then
			return false;
		end;
		assert(0);
		v43 = 0;
	end;
	if p197:numisnan(v43) then
		return false;
	end;
	p199.nval = v43;
	return true;
end;
function v1.codearith(p201, p202, p203, p204, p205)
	if p201:constfolding(p203, p204, p205) then
		return;
	end;
	if p203 ~= "OP_UNM" then
		local v44 = p203 ~= "OP_LEN" and p201:exp2RK(p202, p205) or 0;
	else
		v44 = 0;
	end;
	local v45 = p201:exp2RK(p202, p204);
	if v44 < v45 then
		p201:freeexp(p202, p204);
		p201:freeexp(p202, p205);
	else
		p201:freeexp(p202, p205);
		p201:freeexp(p202, p204);
	end;
	p204.info = p201:codeABC(p202, p203, 0, v45, v44);
	p204.k = "VRELOCABLE";
end;
function v1.codecomp(p206, p207, p208, p209, p210, p211)
	local v46 = p206:exp2RK(p207, p210);
	local v47 = p206:exp2RK(p207, p211);
	p206:freeexp(p207, p211);
	p206:freeexp(p207, p210);
	if p209 == 0 and p208 ~= "OP_EQ" then
		v47 = v46;
		v46 = v47;
		p209 = 1;
	end;
	p210.info = p206:condjump(p207, p208, p209, v46, v47);
	p210.k = "VJMP";
end;
function v1.prefix(p212, p213, p214, p215)
	local v48 = {
		t = p212.NO_JUMP, 
		f = p212.NO_JUMP, 
		k = "VKNUM", 
		nval = 0
	};
	if p214 == "OPR_MINUS" then
		if not p212:isnumeral(p215) then
			p212:exp2anyreg(p213, p215);
		end;
		p212:codearith(p213, "OP_UNM", p215, v48);
		return;
	end;
	if p214 == "OPR_NOT" then
		p212:codenot(p213, p215);
		return;
	end;
	if p214 ~= "OPR_LEN" then
		assert(0);
		return;
	end;
	p212:exp2anyreg(p213, p215);
	p212:codearith(p213, "OP_LEN", p215, v48);
end;
function v1.infix(p216, p217, p218, p219)
	if p218 == "OPR_AND" then
		p216:goiftrue(p217, p219);
		return;
	end;
	if p218 == "OPR_OR" then
		p216:goiffalse(p217, p219);
		return;
	end;
	if p218 == "OPR_CONCAT" then
		p216:exp2nextreg(p217, p219);
		return;
	end;
	if p218 == "OPR_ADD" or p218 == "OPR_SUB" or p218 == "OPR_MUL" or p218 == "OPR_DIV" or p218 == "OPR_MOD" or p218 == "OPR_POW" then
		if not p216:isnumeral(p219) then
			p216:exp2RK(p217, p219);
			return;
		end;
	else
		p216:exp2RK(p217, p219);
	end;
end;
v1.arith_op = {
	OPR_ADD = "OP_ADD", 
	OPR_SUB = "OP_SUB", 
	OPR_MUL = "OP_MUL", 
	OPR_DIV = "OP_DIV", 
	OPR_MOD = "OP_MOD", 
	OPR_POW = "OP_POW"
};
v1.comp_op = {
	OPR_EQ = "OP_EQ", 
	OPR_NE = "OP_EQ", 
	OPR_LT = "OP_LT", 
	OPR_LE = "OP_LE", 
	OPR_GT = "OP_LT", 
	OPR_GE = "OP_LE"
};
v1.comp_cond = {
	OPR_EQ = 1, 
	OPR_NE = 0, 
	OPR_LT = 1, 
	OPR_LE = 1, 
	OPR_GT = 0, 
	OPR_GE = 0
};
function v1.posfix(p220, p221, p222, p223, p224)
	if p222 == "OPR_AND" then
		assert(p223.t == p220.NO_JUMP);
		p220:dischargevars(p221, p224);
		p224.f = p220:concat(p221, p224.f, p223.f);
		p223.k = p224.k;
		p223.info = p224.info;
		p223.aux = p224.aux;
		p223.nval = p224.nval;
		p223.t = p224.t;
		p223.f = p224.f;
		return;
	end;
	if p222 == "OPR_OR" then
		assert(p223.f == p220.NO_JUMP);
		p220:dischargevars(p221, p224);
		p224.t = p220:concat(p221, p224.t, p223.t);
		p223.k = p224.k;
		p223.info = p224.info;
		p223.aux = p224.aux;
		p223.nval = p224.nval;
		p223.t = p224.t;
		p223.f = p224.f;
		return;
	end;
	if p222 ~= "OPR_CONCAT" then
		local v49 = p220.arith_op[p222];
		if v49 then
			p220:codearith(p221, v49, p223, p224);
			return;
		else
			local v50 = p220.comp_op[p222];
			if v50 then
				p220:codecomp(p221, v50, p220.comp_cond[p222], p223, p224);
				return;
			else
				assert(0);
				return;
			end;
		end;
	end;
	p220:exp2val(p221, p224);
	if p224.k ~= "VRELOCABLE" or u1:GET_OPCODE(p220:getcode(p221, p224)) ~= "OP_CONCAT" then
		p220:exp2nextreg(p221, p224);
		p220:codearith(p221, "OP_CONCAT", p223, p224);
		return;
	end;
	assert(p223.info == u1:GETARG_B(p220:getcode(p221, p224)) - 1);
	p220:freeexp(p221, p223);
	u1:SETARG_B(p220:getcode(p221, p224), p223.info);
	p223.k = "VRELOCABLE";
	p223.info = p224.info;
end;
function v1.fixline(p225, p226, p227)
	p226.f.lineinfo[p226.pc - 1] = p227;
end;
function v1.code(p228, p229, p230, p231)
	local l__f__51 = p229.f;
	p228:dischargejpc(p229);
	luaY:growvector(p229.L, l__f__51.code, p229.pc, l__f__51.sizecode, nil, luaY.MAX_INT, "code size overflow");
	l__f__51.code[p229.pc] = p230;
	luaY:growvector(p229.L, l__f__51.lineinfo, p229.pc, l__f__51.sizelineinfo, nil, luaY.MAX_INT, "code size overflow");
	l__f__51.lineinfo[p229.pc] = p231;
	p229.pc = p229.pc + 1;
	return p229.pc;
end;
function v1.codeABC(p232, p233, p234, p235, p236, p237)
	assert(u1:getOpMode(p234) == u1.OpMode.iABC);
	local v52 = true;
	if u1:getBMode(p234) == u1.OpArgMask.OpArgN then
		v52 = p236 == 0;
	end;
	assert(v52);
	local v53 = true;
	if u1:getCMode(p234) == u1.OpArgMask.OpArgN then
		v53 = p237 == 0;
	end;
	assert(v53);
	return p232:code(p233, u1:CREATE_ABC(p234, p235, p236, p237), p233.ls.lastline);
end;
function v1.codeABx(p238, p239, p240, p241, p242)
	local v54 = true;
	if u1:getOpMode(p240) ~= u1.OpMode.iABx then
		v54 = u1:getOpMode(p240) == u1.OpMode.iAsBx;
	end;
	assert(v54);
	assert(u1:getCMode(p240) == u1.OpArgMask.OpArgN);
	return p238:code(p239, u1:CREATE_ABx(p240, p241, p242), p239.ls.lastline);
end;
function v1.setlist(p243, p244, p245, p246, p247)
	local v55 = math.floor((p246 - 1) / u1.LFIELDS_PER_FLUSH) + 1;
	if p247 == luaY.LUA_MULTRET then
		local v56 = 0;
	else
		v56 = p247;
	end;
	assert(p247 ~= 0);
	if v55 <= u1.MAXARG_C then
		p243:codeABC(p244, "OP_SETLIST", p245, v56, v55);
	else
		p243:codeABC(p244, "OP_SETLIST", p245, v56, 0);
		p243:code(p244, u1:CREATE_Inst(v55), p244.ls.lastline);
	end;
	p244.freereg = p245 + 1;
end;
return function(p248)
	luaY = p248;
	return v1;
end;
