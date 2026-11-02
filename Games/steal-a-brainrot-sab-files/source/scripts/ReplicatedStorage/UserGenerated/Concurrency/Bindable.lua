
--!native
local function v1(v0)
	warn((("%*\nStack Begin\n%*Stack End"):format(tostring(v0), (debug.traceback(nil, 3)))));
end;
local function v3(v2, ...)
	return xpcall(v2, v1, ...);
end;
local function v11(v4, v5)
	local v6 = false;
	local v7 = 1;
	local v8 = #v4;
	while v7 <= v8 do
		local v9 = v7 + (v8 - v7) // 2;
		local v10 = v4[v9].Pr - v5.Pr;
		if v10 > 0 then
			v8 = v9 - 1;
		elseif v10 < 0 then
			v7 = v9 + 1;
		else
			v6 = true;
			v7 = v9 + 1;
		end;
	end;
	return v6 and v7 or -v7;
end;
local function v19(v12, v13)
	local v14 = false;
	local v15 = 1;
	local v16 = #v12;
	while v15 <= v16 do
		local v17 = v15 + (v16 - v15) // 2;
		local v18 = v12[v17].Pr - v13.Pr;
		if v18 > 0 then
			v16 = v17 - 1;
		elseif v18 < 0 then
			v15 = v17 + 1;
		else
			v14 = true;
			v16 = v17 - 1;
		end;
	end;
	return v14 and v15 or -v15;
end;
local function _(v20, v21)
	local v22 = math.abs((v11(v20, v21)));
	table.insert(v20, v22, v21);
	return v22;
end;
local function v28(v24, v25)
	local v26 = v19(v24, v25);
	if v26 > 0 then
		for v27 = v26, #v24 do
			if v24[v27] == v25 then
				table.remove(v24, v27);
				return true;
			end;
		end;
	end;
	return false;
end;
local v33 = table.freeze({
	IsConnected = function(v29)
		return v29.Ow ~= nil;
	end, 
	Disconnect = function(v30)
		local l_Ow_0 = v30.Ow;
		if l_Ow_0 ~= nil then
			v30.Ow = nil;
			if not v28(l_Ow_0.Cs, v30) then
				warn("Bindable disconnection failure");
			end;
		end;
	end, 
	GetPriority = function(v32)
		return v32.Pr;
	end
});
local v34 = table.freeze({
	__index = v33
});
local function _(v35, v36, v37)
	return (setmetatable({
		Ow = v35, 
		Cb = v36, 
		Pr = v37
	}, v34));
end;
local function v41(v39)
	local v40 = false;
	if type(v39) == "table" then
		v40 = getmetatable(v39) == v34;
	end;
	return v40;
end;
local function v44(v42)
	local v43 = false;
	if type(v42) == "table" then
		v43 = getmetatable(v42) == v34;
	end;
	if not v43 then
		error("Connection", 2);
	end;
	return v42;
end;
local v92 = table.freeze({
	Fire = function(v45, ...)
		local l_Cs_0 = v45.Cs;
		local v47 = 1;
		while v47 <= #l_Cs_0 do
			local v48 = l_Cs_0[v47];
			task.spawn(v48.Cb, ...);
			if l_Cs_0[v47] == v48 then
				v47 = v47 + 1;
			end;
		end;
	end, 
	FireAndWait = function(v49, ...)
		local v50 = {};
		local l_Cs_1 = v49.Cs;
		local v52 = 1;
		while v52 <= #l_Cs_1 do
			local v53 = l_Cs_1[v52];
			table.insert(v50, (task.spawn(v53.Cb, ...)));
			if l_Cs_1[v52] == v53 then
				v52 = v52 + 1;
			end;
		end;
		for _, v55 in pairs(v50) do
			while coroutine.status(v55) ~= "dead" do
				task.wait();
			end;
		end;
	end, 
	FireSync = function(v56, ...)
		local l_Cs_2 = v56.Cs;
		local v58 = 1;
		while v58 <= #l_Cs_2 do
			local v59 = l_Cs_2[v58];
			v3(v59.Cb, ...);
			if l_Cs_2[v58] == v59 then
				v58 = v58 + 1;
			end;
		end;
	end, 
	Invoke = function(v60, ...)
		local l_Cs_3 = v60.Cs;
		if #l_Cs_3 >= 1 then
			return l_Cs_3[1].Cb(...);
		else
			error("Invoke");
			return;
		end;
	end, 
	Connect = function(v62, v63, v64)
		local v65 = true;
		if v64 ~= nil then
			v65 = false;
			if type(v64) == "number" then
				v65 = v64 == v64;
			end;
		end;
		assert(v65);
		local v66 = v64 or 1e999;
		v65 = setmetatable({
			Ow = v62, 
			Cb = v63, 
			Pr = v66
		}, v34);
		if v66 == 1e999 then
			table.insert(v62.Cs, v65);
			return v65;
		else
			local l_Cs_4 = v62.Cs;
			table.insert(l_Cs_4, math.abs((v11(l_Cs_4, v65))), v65);
			return v65;
		end;
	end, 
	Wait = function(v68)
		local v69 = nil;
		local v70 = nil;
		local function v73(...)
			v69 = table.pack(...);
			local l_v70_0 = v70;
			local l_Ow_1 = l_v70_0.Ow;
			if l_Ow_1 ~= nil then
				l_v70_0.Ow = nil;
				if not v28(l_Ow_1.Cs, l_v70_0) then
					warn("Bindable disconnection failure");
				end;
			end;
		end;
		assert(true);
		local v74 = setmetatable({
			Ow = v68, 
			Cb = v73, 
			Pr = 1e999
		}, v34);
		table.insert(v68.Cs, v74);
		v70 = v74;
		while not v69 do
			if not (v70.Ow ~= nil) then
				error("Disconnected");
			end;
			task.wait();
		end;
		return table.unpack(v69);
	end, 
	Once = function(v75, v76, v77)
		local v78 = nil;
		local function v81(...)
			local l_v78_0 = v78;
			local l_Ow_2 = l_v78_0.Ow;
			if l_Ow_2 ~= nil then
				l_v78_0.Ow = nil;
				if not v28(l_Ow_2.Cs, l_v78_0) then
					warn("Bindable disconnection failure");
				end;
			end;
			return v76(...);
		end;
		local v82 = true;
		if v77 ~= nil then
			v82 = false;
			if type(v77) == "number" then
				v82 = v77 == v77;
			end;
		end;
		assert(v82);
		local v83 = v77 or 1e999;
		v82 = setmetatable({
			Ow = v75, 
			Cb = v81, 
			Pr = v83
		}, v34);
		if v83 == 1e999 then
			table.insert(v75.Cs, v82);
		else
			local l_Cs_5 = v75.Cs;
			table.insert(l_Cs_5, math.abs((v11(l_Cs_5, v82))), v82);
		end;
		v78 = v82;
		return v78;
	end, 
	DisconnectAll = function(v85)
		local l_Cs_6 = v85.Cs;
		for v87 = #l_Cs_6, 1, -1 do
			local v88 = l_Cs_6[v87];
			local l_Ow_3 = v88.Ow;
			if l_Ow_3 ~= nil then
				v88.Ow = nil;
				if not v28(l_Ow_3.Cs, v88) then
					warn("Bindable disconnection failure");
				end;
			end;
		end;
	end, 
	GetSize = function(v90)
		return #v90.Cs;
	end, 
	IsEmpty = function(v91)
		return #v91.Cs == 0;
	end
});
local v93 = table.freeze({
	__index = v92
});
return table.freeze({
	new = function(_)
		local v95 = {
			Cs = {}
		};
		return (table.freeze((setmetatable(v95, v93))));
	end, 
	IsA = function(v96)
		local v97 = false;
		if type(v96) == "table" then
			v97 = getmetatable(v96) == v93;
		end;
		return v97;
	end, 
	Assert = function(v98)
		local v99 = false;
		if type(v98) == "table" then
			v99 = getmetatable(v98) == v93;
		end;
		if not v99 then
			error("Bindable", 2);
		end;
		return v98;
	end, 
	IsAConnection = v41, 
	AssertConnection = v44
});