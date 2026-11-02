-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	LUA_SIGNATURE = "\027Lua", 
	LUA_TNUMBER = 3, 
	LUA_TSTRING = 4, 
	LUA_TNIL = 0, 
	LUA_TBOOLEAN = 1, 
	LUA_TNONE = -1, 
	LUAC_VERSION = 81, 
	LUAC_FORMAT = 0, 
	LUAC_HEADERSIZE = 12, 
	make_setS = function(p1)
		return function(p2, p3)
			if not p2 then
				return 0;
			end;
			p3.data = p3.data .. p2;
			return 0;
		end, {
			data = ""
		};
	end, 
	ttype = function(p4, p5)
		local v2 = type(p5.value);
		if v2 == "number" then
			return p4.LUA_TNUMBER;
		end;
		if v2 == "string" then
			return p4.LUA_TSTRING;
		end;
		if v2 == "nil" then
			return p4.LUA_TNIL;
		end;
		if v2 == "boolean" then
			return p4.LUA_TBOOLEAN;
		end;
		return p4.LUA_TNONE;
	end, 
	from_double = function(p6, p7)
		local v3 = 0;
		if p7 < 0 then
			v3 = 1;
			p7 = -p7;
		end;
		local v4, v5 = math.frexp(p7);
		if p7 == 0 then
			local v6 = 0;
			local v7 = 0;
		elseif p7 == (1 / 0) then
			v6 = 0;
			v7 = 2047;
		else
			v6 = (v4 * 2 - 1) * 4503599627370496;
			v7 = v5 + 1022;
		end;
		p7 = math.floor(v6);
		local v8 = p7 % 256;
		local v9 = string.char(v8);
		p7 = (p7 - v8) / 256;
		local v10 = p7 % 256;
		local v11 = string.char(v10);
		p7 = (p7 - v10) / 256;
		local v12 = p7 % 256;
		local v13 = string.char(v12);
		p7 = (p7 - v12) / 256;
		local v14 = p7 % 256;
		local v15 = string.char(v14);
		p7 = (p7 - v14) / 256;
		local v16 = p7 % 256;
		local v17 = string.char(v16);
		p7 = (p7 - v16) / 256;
		local v18 = p7 % 256;
		local v19 = string.char(v18);
		p7 = (p7 - v18) / 256;
		local v20 = v7 * 16 + p7;
		local v21 = v20 % 256;
		local v22 = string.char(v21);
		p7 = (v20 - v21) / 256;
		local v23 = v3 * 128 + p7;
		local v24 = v23 % 256;
		local v25 = string.char(v24);
		p7 = (v23 - v24) / 256;
		return ((((((("" .. v9) .. v11) .. v13) .. v15) .. v17) .. v19) .. v22) .. v25;
	end, 
	from_int = function(p8, p9)
		p9 = math.floor(p9);
		if p9 < 0 then
			p9 = 4294967296 + p9;
		end;
		p9 = math.floor(p9 / 256);
		p9 = math.floor(p9 / 256);
		p9 = math.floor(p9 / 256);
		p9 = math.floor(p9 / 256);
		return ((("" .. string.char(p9 % 256)) .. string.char(p9 % 256)) .. string.char(p9 % 256)) .. string.char(p9 % 256);
	end, 
	DumpBlock = function(p10, p11, p12)
		if p12.status == 0 then
			p12.status = p12.write(p11, p12.data);
		end;
	end, 
	DumpChar = function(p13, p14, p15)
		p13:DumpBlock(string.char(p14), p15);
	end, 
	DumpInt = function(p16, p17, p18)
		p16:DumpBlock(p16:from_int(p17), p18);
	end, 
	DumpNumber = function(p19, p20, p21)
		p19:DumpBlock(p19:from_double(p20), p21);
	end, 
	DumpString = function(p22, p23, p24)
		if p23 == nil then
			p22:DumpInt(0, p24);
			return;
		end;
		p23 = p23 .. "\000";
		p22:DumpInt(#p23, p24);
		p22:DumpBlock(p23, p24);
	end
};
local u1 = require(script.Parent.LuaP);
function v1.DumpCode(p25, p26, p27)
	local l__sizecode__26 = p26.sizecode;
	p25:DumpInt(l__sizecode__26, p27);
	for v27 = 0, l__sizecode__26 - 1 do
		p25:DumpBlock(u1:Instruction(p26.code[v27]), p27);
	end;
end;
function v1.DumpConstants(p28, p29, p30)
	local l__sizek__28 = p29.sizek;
	p28:DumpInt(l__sizek__28, p30);
	for v29 = 0, l__sizek__28 - 1 do
		local v30 = p29.k[v29];
		local v31 = p28:ttype(v30);
		p28:DumpChar(v31, p30);
		if v31 ~= p28.LUA_TNIL then
			if v31 == p28.LUA_TBOOLEAN then
				if v30.value then
					local v32 = 1;
				else
					v32 = 0;
				end;
				p28:DumpChar(v32, p30);
			elseif v31 == p28.LUA_TNUMBER then
				p28:DumpNumber(v30.value, p30);
			elseif v31 == p28.LUA_TSTRING then
				p28:DumpString(v30.value, p30);
			end;
		end;
	end;
	local l__sizep__33 = p29.sizep;
	p28:DumpInt(l__sizep__33, p30);
	for v34 = 0, l__sizep__33 - 1 do
		p28:DumpFunction(p29.p[v34], p29.source, p30);
	end;
end;
function v1.DumpDebug(p31, p32, p33)
	if p33.strip then
		local v35 = 0;
	else
		v35 = p32.sizelineinfo;
	end;
	p31:DumpInt(v35, p33);
	for v36 = 0, v35 - 1 do
		p31:DumpInt(p32.lineinfo[v36], p33);
	end;
	if p33.strip then
		local v37 = 0;
	else
		v37 = p32.sizelocvars;
	end;
	p31:DumpInt(v37, p33);
	for v38 = 0, v37 - 1 do
		p31:DumpString(p32.locvars[v38].varname, p33);
		p31:DumpInt(p32.locvars[v38].startpc, p33);
		p31:DumpInt(p32.locvars[v38].endpc, p33);
	end;
	if p33.strip then
		local v39 = 0;
	else
		v39 = p32.sizeupvalues;
	end;
	p31:DumpInt(v39, p33);
	for v40 = 0, v39 - 1 do
		p31:DumpString(p32.upvalues[v40], p33);
	end;
end;
function v1.DumpFunction(p34, p35, p36, p37)
	local v41 = p35.source;
	if v41 == p36 or p37.strip then
		v41 = nil;
	end;
	p34:DumpString(v41, p37);
	p34:DumpInt(p35.lineDefined, p37);
	p34:DumpInt(p35.lastlinedefined, p37);
	p34:DumpChar(p35.nups, p37);
	p34:DumpChar(p35.numparams, p37);
	p34:DumpChar(p35.is_vararg, p37);
	p34:DumpChar(p35.maxstacksize, p37);
	p34:DumpCode(p35, p37);
	p34:DumpConstants(p35, p37);
	p34:DumpDebug(p35, p37);
end;
function v1.DumpHeader(p38, p39)
	local v42 = p38:header();
	assert(#v42 == p38.LUAC_HEADERSIZE);
	p38:DumpBlock(v42, p39);
end;
function v1.header(p40)
	return p40.LUA_SIGNATURE .. string.char(p40.LUAC_VERSION, p40.LUAC_FORMAT, 1, 4, 4, 4, 8, 0);
end;
function v1.dump(p41, p42, p43, p44, p45, p46)
	local v43 = {
		L = p42, 
		write = p44, 
		data = p45, 
		strip = p46, 
		status = 0
	};
	p41:DumpHeader(v43);
	p41:DumpFunction(p43, nil, v43);
	v43.write(nil, v43.data);
	return v43.status;
end;
return v1;
