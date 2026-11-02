-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	type = function(p1)
		return function(p2)
			local v2 = type(p2);
			if v2 == p1 then
				return true;
			end;
			return false, string.format("%s expected, got %s", p1, v2);
		end;
	end, 
	typeof = function(p3)
		return function(p4)
			local v3 = typeof(p4);
			if v3 == p3 then
				return true;
			end;
			return false, string.format("%s expected, got %s", p3, v3);
		end;
	end, 
	any = function(p5)
		if p5 ~= nil then
			return true;
		end;
		return false, "any expected, got nil";
	end
};
v1.boolean = v1.typeof("boolean");
v1.thread = v1.typeof("thread");
v1.callback = v1.typeof("function");
v1["function"] = v1.callback;
v1.none = v1.typeof("nil");
v1.nil = v1.none;
v1.string = v1.typeof("string");
v1.table = v1.typeof("table");
v1.userdata = v1.type("userdata");
function v1.number(p6)
	local v4 = typeof(p6);
	if v4 ~= "number" then
		return false, string.format("number expected, got %s", v4);
	end;
	if p6 == p6 then
		return true;
	end;
	return false, "unexpected NaN value";
end;
function v1.nan(p7)
	local v5 = typeof(p7);
	if v5 ~= "number" then
		return false, string.format("number expected, got %s", v5);
	end;
	if p7 ~= p7 then
		return true;
	end;
	return false, "unexpected non-NaN value";
end;
v1.Axes = v1.typeof("Axes");
v1.BrickColor = v1.typeof("BrickColor");
v1.CatalogSearchParams = v1.typeof("CatalogSearchParams");
v1.CFrame = v1.typeof("CFrame");
v1.Color3 = v1.typeof("Color3");
v1.ColorSequence = v1.typeof("ColorSequence");
v1.ColorSequenceKeypoint = v1.typeof("ColorSequenceKeypoint");
v1.DateTime = v1.typeof("DateTime");
v1.DockWidgetPluginGuiInfo = v1.typeof("DockWidgetPluginGuiInfo");
v1.Enum = v1.typeof("Enum");
v1.EnumItem = v1.typeof("EnumItem");
v1.Enums = v1.typeof("Enums");
v1.Faces = v1.typeof("Faces");
v1.Instance = v1.typeof("Instance");
v1.NumberRange = v1.typeof("NumberRange");
v1.NumberSequence = v1.typeof("NumberSequence");
v1.NumberSequenceKeypoint = v1.typeof("NumberSequenceKeypoint");
v1.PathWaypoint = v1.typeof("PathWaypoint");
v1.PhysicalProperties = v1.typeof("PhysicalProperties");
v1.Random = v1.typeof("Random");
v1.Ray = v1.typeof("Ray");
v1.RaycastParams = v1.typeof("RaycastParams");
v1.RaycastResult = v1.typeof("RaycastResult");
v1.RBXScriptConnection = v1.typeof("RBXScriptConnection");
v1.RBXScriptSignal = v1.typeof("RBXScriptSignal");
v1.Rect = v1.typeof("Rect");
v1.Region3 = v1.typeof("Region3");
v1.Region3int16 = v1.typeof("Region3int16");
v1.TweenInfo = v1.typeof("TweenInfo");
v1.UDim = v1.typeof("UDim");
v1.UDim2 = v1.typeof("UDim2");
v1.Vector2 = v1.typeof("Vector2");
v1.Vector2int16 = v1.typeof("Vector2int16");
v1.Vector3 = v1.typeof("Vector3");
v1.Vector3int16 = v1.typeof("Vector3int16");
function v1.literal(...)
	local v6 = select("#", ...);
	if v6 == 1 then
		local u1 = ...;
		return function(p8)
			if p8 == u1 then
				return true;
			end;
			return false, string.format("expected %s, got %s", tostring(u1), tostring(p8));
		end;
	end;
	local v7 = {};
	for v8 = 1, v6 do
		v7[v8] = v1.literal((select(v8, ...)));
	end;
	return v1.union(table.unpack(v7, 1, v6));
end;
v1.exactly = v1.literal;
function v1.keyOf(p9)
	local v9 = {};
	local v10 = 0;
	for v11 in pairs(p9) do
		v10 = v10 + 1;
		v9[v10] = v11;
	end;
	return v1.literal(table.unpack(v9, 1, v10));
end;
function v1.valueOf(p10)
	local v12 = {};
	local v13 = 0;
	for v14, v15 in pairs(p10) do
		v13 = v13 + 1;
		v12[v13] = v15;
	end;
	return v1.literal(table.unpack(v12, 1, v13));
end;
function v1.integer(p11)
	local v16, v17 = v1.number(p11);
	if not v16 then
		return false, v17 and "";
	end;
	if p11 % 1 == 0 then
		return true;
	end;
	return false, string.format("integer expected, got %s", p11);
end;
function v1.numberMin(p12)
	return function(p13)
		local v18, v19 = v1.number(p13);
		if not v18 then
			return false, v19 and "";
		end;
		if p12 <= p13 then
			return true;
		end;
		return false, string.format("number >= %s expected, got %s", p12, p13);
	end;
end;
function v1.numberMax(p14)
	return function(p15)
		local v20, v21 = v1.number(p15);
		if not v20 then
			return false, v21;
		end;
		if p15 <= p14 then
			return true;
		end;
		return false, string.format("number <= %s expected, got %s", p14, p15);
	end;
end;
function v1.numberMinExclusive(p16)
	return function(p17)
		local v22, v23 = v1.number(p17);
		if not v22 then
			return false, v23 and "";
		end;
		if p16 < p17 then
			return true;
		end;
		return false, string.format("number > %s expected, got %s", p16, p17);
	end;
end;
function v1.numberMaxExclusive(p18)
	return function(p19)
		local v24, v25 = v1.number(p19);
		if not v24 then
			return false, v25 and "";
		end;
		if p19 < p18 then
			return true;
		end;
		return false, string.format("number < %s expected, got %s", p18, p19);
	end;
end;
v1.numberPositive = v1.numberMinExclusive(0);
v1.numberNegative = v1.numberMaxExclusive(0);
function v1.numberConstrained(p20, p21)
	assert(v1.number(p20));
	assert(v1.number(p21));
	local u2 = v1.numberMin(p20);
	local u3 = v1.numberMax(p21);
	return function(p22)
		local v26, v27 = u2(p22);
		if not v26 then
			return false, v27 and "";
		end;
		local v28, v29 = u3(p22);
		if v28 then
			return true;
		end;
		return false, v29 and "";
	end;
end;
function v1.numberConstrainedExclusive(p23, p24)
	assert(v1.number(p23));
	assert(v1.number(p24));
	local u4 = v1.numberMinExclusive(p23);
	local u5 = v1.numberMaxExclusive(p24);
	return function(p25)
		local v30, v31 = u4(p25);
		if not v30 then
			return false, v31 and "";
		end;
		local v32, v33 = u5(p25);
		if v32 then
			return true;
		end;
		return false, v33 and "";
	end;
end;
function v1.match(p26)
	assert(v1.string(p26));
	return function(p27)
		local v34, v35 = v1.string(p27);
		if not v34 then
			return false, v35;
		end;
		if string.match(p27, p26) ~= nil then
			return true;
		end;
		return false, string.format("%q failed to match pattern %q", p27, p26);
	end;
end;
function v1.optional(p28)
	assert(v1.callback(p28));
	return function(p29)
		if p29 == nil then
			return true;
		end;
		local v36, v37 = p28(p29);
		if v36 then
			return true;
		end;
		return false, string.format("(optional) %s", v37 and "");
	end;
end;
function v1.tuple(...)
	local u6 = { ... };
	return function(...)
		local v38 = { ... };
		local v39, v40, v41 = ipairs(u6);
		while true do
			v39(v40, v41);
			if not v39 then
				break;
			end;
			v41 = v39;
			local v42, v43 = v40(v38[v39]);
			if v42 == false then
				return false, string.format("Bad tuple index #%s:\n\t%s", v39, v43 and "");
			end;		
		end;
		return true;
	end;
end;
function v1.keys(p30)
	assert(v1.callback(p30));
	return function(p31)
		local v44, v45 = v1.table(p31);
		if v44 == false then
			return false, v45 and "";
		end;
		for v46 in pairs(p31) do
			local v47, v48 = p30(v46);
			if v47 == false then
				return false, string.format("bad key %s:\n\t%s", tostring(v46), v48 and "");
			end;
		end;
		return true;
	end;
end;
function v1.values(p32)
	assert(v1.callback(p32));
	return function(p33)
		local v49, v50 = v1.table(p33);
		if v49 == false then
			return false, v50 and "";
		end;
		for v51, v52 in pairs(p33) do
			local v53, v54 = p32(v52);
			if v53 == false then
				return false, string.format("bad value for key %s:\n\t%s", tostring(v51), v54 and "");
			end;
		end;
		return true;
	end;
end;
function v1.map(p34, p35)
	assert(v1.callback(p34));
	assert(v1.callback(p35));
	local u7 = v1.keys(p34);
	local u8 = v1.values(p35);
	return function(p36)
		local v55, v56 = u7(p36);
		if not v55 then
			return false, v56 and "";
		end;
		local v57, v58 = u8(p36);
		if v57 then
			return true;
		end;
		return false, v58 and "";
	end;
end;
function v1.set(p37)
	return v1.map(p37, v1.literal(true));
end;
local u9 = v1.keys(v1.integer);
function v1.array(p38)
	assert(v1.callback(p38));
	local u10 = v1.values(p38);
	return function(p39)
		local v59, v60 = u9(p39);
		if v59 == false then
			return false, string.format("[array] %s", v60 and "");
		end;
		local v61 = 0;
		local v62, v63, v64 = ipairs(p39);
		while true do
			v62(v63, v64);
			if not v62 then
				break;
			end;
			v64 = v62;
			v61 = v61 + 1;		
		end;
		for v65 in pairs(p39) do
			if v65 < 1 then
				return false, string.format("[array] key %s must be sequential", tostring(v65));
			end;
			if v61 < v65 then
				return false, string.format("[array] key %s must be sequential", tostring(v65));
			end;
		end;
		local v66, v67 = u10(p39);
		if v66 then
			return true;
		end;
		return false, string.format("[array] %s", v67 and "");
	end;
end;
function v1.strictArray(...)
	local v68 = { ... };
	assert(v1.array(v1.callback)(v68));
	return function(p40)
		local v69, v70 = u9(p40);
		if v69 == false then
			return false, string.format("[strictArray] %s", v70 and "");
		end;
		if #v68 < #p40 then
			return false, string.format("[strictArray] Array size exceeds limit of %d", #v68);
		end;
		for v71, v72 in pairs(v68) do
			local v73, v74 = v72(p40[v71]);
			if not v73 then
				return false, string.format("[strictArray] Array index #%d - %s", v71, v74);
			end;
		end;
		return true;
	end;
end;
u9 = v1.array;
u9 = u9(v1.callback);
function v1.union(...)
	local v75 = { ... };
	assert(u9(v75));
	return function(p41)
		local v76, v77, v78 = ipairs(v75);
		while true do
			v76(v77, v78);
			if not v76 then
				break;
			end;
			v78 = v76;
			if v77(p41) then
				return true;
			end;		
		end;
		return false, "bad type for union";
	end;
end;
v1.some = v1.union;
function v1.intersection(...)
	local v79 = { ... };
	assert(u9(v79));
	return function(p42)
		local v80, v81, v82 = ipairs(v79);
		while true do
			v80(v81, v82);
			if not v80 then
				break;
			end;
			v82 = v80;
			local v83, v84 = v81(p42);
			if not v83 then
				return false, v84 and "";
			end;		
		end;
		return true;
	end;
end;
v1.every = v1.intersection;
u9 = v1.map;
u9 = u9(v1.any, v1.callback);
function v1.interface(p43)
	assert(u9(p43));
	return function(p44)
		local v85, v86 = v1.table(p44);
		if v85 == false then
			return false, v86 and "";
		end;
		for v87, v88 in pairs(p43) do
			local v89, v90 = v88(p44[v87]);
			if v89 == false then
				return false, string.format("[interface] bad value for %s:\n\t%s", tostring(v87), v90 and "");
			end;
		end;
		return true;
	end;
end;
function v1.strictInterface(p45)
	assert(u9(p45));
	return function(p46)
		local v91, v92 = v1.table(p46);
		if v91 == false then
			return false, v92 and "";
		end;
		for v93, v94 in pairs(p45) do
			local v95, v96 = v94(p46[v93]);
			if v95 == false then
				return false, string.format("[interface] bad value for %s:\n\t%s", tostring(v93), v96 and "");
			end;
		end;
		for v97 in pairs(p46) do
			if not p45[v97] then
				return false, string.format("[interface] unexpected field %q", tostring(v97));
			end;
		end;
		return true;
	end;
end;
u9 = function(p47, p48)
	assert(v1.string(p47));
	local v98 = nil;
	if p48 ~= nil then
		v98 = v1.children(p48);
	end;
	return function(p49)
		local v99, v100 = v1.Instance(p49);
		if not v99 then
			return false, v100 and "";
		end;
		if p49.ClassName ~= p47 then
			return false, string.format("%s expected, got %s", p47, p49.ClassName);
		end;
		if v98 then
			local v101, v102 = v98(p49);
			if not v101 then
				return false, v102;
			end;
		end;
		return true;
	end;
end;
v1.instanceOf = u9;
u9 = v1.instanceOf;
v1.instance = u9;
u9 = function(p50, p51)
	assert(v1.string(p50));
	local v103 = nil;
	if p51 ~= nil then
		v103 = v1.children(p51);
	end;
	return function(p52)
		local v104, v105 = v1.Instance(p52);
		if not v104 then
			return false, v105 and "";
		end;
		if not p52:IsA(p50) then
			return false, string.format("%s expected, got %s", p50, p52.ClassName);
		end;
		if v103 then
			local v106, v107 = v103(p52);
			if not v106 then
				return false, v107;
			end;
		end;
		return true;
	end;
end;
v1.instanceIsA = u9;
u9 = function(p53)
	assert(v1.Enum(p53));
	return function(p54)
		local v108, v109 = v1.EnumItem(p54);
		if not v108 then
			return false, v109;
		end;
		if p54.EnumType == p53 then
			return true;
		end;
		return false, string.format("enum of %s expected, got enum of %s", tostring(p53), tostring(p54.EnumType));
	end;
end;
v1.enum = u9;
u9 = v1.tuple;
u9 = u9(v1.callback, v1.callback);
function v1.wrap(p55, p56)
	assert(u9(p55, p56));
	return function(...)
		assert(p56(...));
		return p55(...);
	end;
end;
u9 = function(p57)
	return function(...)
		assert(p57(...));
	end;
end;
v1.strict = u9;
u9 = v1.map;
u9 = u9(v1.string, v1.callback);
function v1.children(p58)
	assert(u9(p58));
	return function(p59)
		local v110, v111 = v1.Instance(p59);
		if not v110 then
			return false, v111 and "";
		end;
		local v112 = {};
		local v113, v114, v115 = ipairs(p59:GetChildren());
		while true do
			v113(v114, v115);
			if not v113 then
				break;
			end;
			v115 = v113;
			local l__Name__116 = v114.Name;
			if p58[l__Name__116] then
				if v112[l__Name__116] then
					return false, string.format("Cannot process multiple children with the same name %q", l__Name__116);
				end;
				v112[l__Name__116] = v114;
			end;		
		end;
		for v117, v118 in pairs(p58) do
			local v119, v120 = v118(v112[v117]);
			if not v119 then
				return false, string.format("[%s.%s] %s", p59:GetFullName(), v117, v120 and "");
			end;
		end;
		return true;
	end;
end;
return v1;
