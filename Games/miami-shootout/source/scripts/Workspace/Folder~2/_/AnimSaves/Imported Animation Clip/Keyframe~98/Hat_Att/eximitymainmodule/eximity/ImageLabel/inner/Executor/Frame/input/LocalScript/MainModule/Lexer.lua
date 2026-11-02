-- Decompiled with the Synapse X Luau decompiler.

local l__coroutine_yield__1 = coroutine.yield;
local function v1(p1)
	return l__coroutine_yield__1(p1, p1);
end;
local function v2(p2)
	return l__coroutine_yield__1("number", p2);
end;
local function v3(p3)
	return l__coroutine_yield__1("string", p3);
end;
local function v4(p4)
	return l__coroutine_yield__1("comment", p4);
end;
local u2 = {
	["and"] = true, 
	break = true, 
	["do"] = true, 
	["else"] = true, 
	elseif = true, 
	["end"] = true, 
	false = true, 
	["for"] = true, 
	["function"] = true, 
	["if"] = true, 
	["in"] = true, 
	["local"] = true, 
	nil = true, 
	not = true, 
	["while"] = true, 
	["or"] = true, 
	["repeat"] = true, 
	return = true, 
	["then"] = true, 
	true = true, 
	self = true, 
	["until"] = true
};
local u3 = {
	assert = true, 
	collectgarbage = true, 
	error = true, 
	_G = true, 
	gcinfo = true, 
	getfenv = true, 
	getmetatable = true, 
	ipairs = true, 
	loadstring = true, 
	newproxy = true, 
	next = true, 
	pairs = true, 
	pcall = true, 
	print = true, 
	rawequal = true, 
	rawget = true, 
	rawset = true, 
	select = true, 
	setfenv = true, 
	setmetatable = true, 
	tonumber = true, 
	tostring = true, 
	type = true, 
	unpack = true, 
	_VERSION = true, 
	xpcall = true, 
	delay = true, 
	elapsedTime = true, 
	require = true, 
	spawn = true, 
	tick = true, 
	time = true, 
	typeof = true, 
	UserSettings = true, 
	wait = true, 
	warn = true, 
	game = true, 
	Enum = true, 
	script = true, 
	shared = true, 
	workspace = true, 
	Axes = true, 
	BrickColor = true, 
	CFrame = true, 
	Color3 = true, 
	ColorSequence = true, 
	ColorSequenceKeypoint = true, 
	Faces = true, 
	Instance = true, 
	NumberRange = true, 
	NumberSequence = true, 
	NumberSequenceKeypoint = true, 
	PhysicalProperties = true, 
	Random = true, 
	Ray = true, 
	Rect = true, 
	Region3 = true, 
	Region3int16 = true, 
	TweenInfo = true, 
	UDim = true, 
	UDim2 = true, 
	Vector2 = true, 
	Vector3 = true, 
	Vector3int16 = true, 
	next = true, 
	os = true, 
	debug = true, 
	math = true, 
	coroutine = true, 
	string = true, 
	table = true
};
local v5 = { { "^[%a_][%w_]*", function(p5)
			if u2[p5] then
				return l__coroutine_yield__1("keyword", p5);
			end;
			if u3[p5] then
				return l__coroutine_yield__1("builtin", p5);
			end;
			return l__coroutine_yield__1("iden", p5);
		end }, { "^%s+", function(p6)
			return l__coroutine_yield__1("space", p6);
		end }, { "^0x[%da-fA-F]+", v2 }, { "^%d+%.?%d*[eE][%+%-]?%d+", v2 }, { "^%d+%.?%d*", v2 }, { "^(['\"])%1", v3 }, { "^(['\"])(\\*)%2%1", v3 }, { "^(['\"]).-[^\\](\\*)%2%1", v3 }, { "^(['\"]).-.*", v3 }, { "^%[(=*)%[.-%]%1%]", v3 }, { "^%[%[.-.*", v3 }, { "^%-%-%[(=*)%[.-%]%1%]", v4 }, { "^%-%-%[%[.-.*", v4 }, { "^%-%-.-\n", v4 }, { "^%-%-.-.*", v4 }, { "^==", v1 }, { "^~=", v1 }, { "^<=", v1 }, { "^>=", v1 }, { "^%.%.%.", v1 }, { "^%.%.", v1 }, { "^.", v1 } };
local l__type__4 = type;
local l__string_find__5 = string.find;
local l__string_sub__6 = string.sub;
local u7 = #v5;
local u8 = {};
local l__coroutine_wrap__9 = coroutine.wrap;
function u8.scan(p7)
	return l__coroutine_wrap__9(function(p8)
		local u10 = 1;
		local u11 = #p7;
		local u12 = 0;
		local function v6(p9)
			while p9 do
				local v7 = l__type__4(p9);
				if v7 == "table" then
					p9 = l__coroutine_yield__1("", "");
					for v8 = 1, #p9 do
						local v9 = p9[v8];
						p9 = l__coroutine_yield__1(v9[1], v9[2]);
					end;
				elseif v7 == "string" then
					local v10, v11 = l__string_find__5(p7, p9, u10);
					if v10 then
						local v12 = l__string_sub__6(p7, v10, v11);
						u10 = v11 + 1;
						p9 = l__coroutine_yield__1("", v12);
					else
						p9 = l__coroutine_yield__1("", "");
						u10 = u11 + 1;
					end;
				else
					p9 = l__coroutine_yield__1(u12, u10);
				end;			
			end;
		end;
		v6(p8);
		u12 = 1;
		while not (u11 < u10) do
			for v13 = 1, u7 do
				local v14 = v5[v13];
				local v15 = { l__string_find__5(p7, v14[1], u10) };
				local v16 = v15[1];
				local v17 = v15[2];
				if v16 then
					local v18 = l__string_sub__6(p7, v16, v17);
					u10 = v17 + 1;
					u8.finished = u11 < u10;
					if v18:find("\n") then
						local v19, v20 = v18:gsub("\n", {});
						u12 = u12 + v20;
					end;
					v6((v14[2](v18, v15)));
					break;
				end;
			end;		
		end;
		while true do
			v6(l__coroutine_yield__1());		
		end;
	end);
end;
return u8;
