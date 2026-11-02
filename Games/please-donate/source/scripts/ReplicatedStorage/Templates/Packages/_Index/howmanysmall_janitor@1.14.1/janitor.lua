-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(script.RbxScriptConnection);
local v2 = require(script.Symbol);
local v3, v4 = require(script.GetPromiseLibrary)();
local v5 = v2("IndicesReference");
local v6 = {
	ClassName = "Janitor", 
	CurrentlyCleaning = true, 
	[v5] = nil
};
v6.__index = v6;
function v6.new()
	return setmetatable({
		CurrentlyCleaning = false, 
		[v5] = nil
	}, v6);
end;
function v6.Is(p1)
	local v7 = false;
	if type(p1) == "table" then
		v7 = getmetatable(p1) == v6;
	end;
	return v7;
end;
local u1 = {
	["function"] = true, 
	thread = true, 
	RBXScriptConnection = "Disconnect"
};
function v6.Add(p2, p3, p4, p5)
	if p5 then
		p2:Remove(p5);
		local v8 = p2[v5];
		if not v8 then
			v8 = {};
			p2[v5] = v8;
		end;
		v8[p5] = p3;
	end;
	local v9 = typeof(p3);
	local v10 = p4 or (u1[v9] or "Destroy");
	if v9 == "function" or v9 == "thread" then
		if v10 ~= true then
			warn(string.format("Object is a %s and as such expected `true?` for the method name and instead got %s. Traceback: %s", v9, tostring(v10), debug.traceback(nil, 2)));
		end;
	elseif not p3[v10] then
		warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring(p3), tostring(v10), debug.traceback(nil, 2)));
	end;
	p2[p3] = v10;
	return p3;
end;
function v6.AddPromise(p6, p7)
	if not v3 then
		return p7;
	end;
	if not v4.is(p7) then
		error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s)) Traceback: %s", typeof(p7), tostring(p7), debug.traceback(nil, 2)));
	end;
	if p7:getStatus() ~= v4.Status.Started then
		return p7;
	end;
	local v11 = newproxy(false);
	local v12 = p6:Add(v4.new(function(p8, p9, p10)
		if p10(function()
			p7:cancel();
		end) then
			return;
		end;
		p8(p7);
	end), "cancel", v11);
	v12:finallyCall(p6.Remove, p6, v11);
	return v12;
end;
function v6.Remove(p11, p12)
	local v13 = p11[v5];
	if v13 then
		local v14 = v13[p12];
		if v14 then
			local v15 = p11[v14];
			if v15 then
				if v15 == true then
					if type(v14) == "function" then
						v14();
					else
						task.cancel(v14);
					end;
				else
					local v16 = v14[v15];
					if v16 then
						v16(v14);
					end;
				end;
				p11[v14] = nil;
			end;
			v13[p12] = nil;
		end;
	end;
	return p11;
end;
function v6.RemoveList(p13, ...)
	local v17 = p13[v5];
	if v17 then
		local v18 = select("#", ...);
		if v18 == 1 then
			return p13:Remove(...);
		end;
		for v19 = 1, v18 do
			local v20 = v17[select(v19, ...)];
			if v20 then
				local v21 = p13[v20];
				if v21 then
					if v21 == true then
						if type(v20) == "function" then
							v20();
						else
							task.cancel(v20);
						end;
					else
						local v22 = v20[v21];
						if v22 then
							v22(v20);
						end;
					end;
					p13[v20] = nil;
				end;
				v17[v19] = nil;
			end;
		end;
	end;
	return p13;
end;
function v6.Get(p14, p15)
	local v23 = p14[v5];
	if not v23 then
		return nil;
	end;
	return v23[p15];
end;
function v6.Cleanup(p16)
	if not p16.CurrentlyCleaning then
		p16.CurrentlyCleaning = nil;
		local function v24()
			for v25, v26 in next, p16 do
				if v25 ~= v5 then
					return v25, v26;
				end;
			end;
		end;
		local v27, v28 = v24();
		while v27 and v28 do
			if v28 == true then
				if type(v27) == "function" then
					v27();
				else
					task.cancel(v27);
				end;
			else
				local v29 = v27[v28];
				if v29 then
					v29(v27);
				end;
			end;
			p16[v27] = nil;
			local v30, v31 = v24();
			v27 = v30;
			v28 = v31;		
		end;
		local v32 = p16[v5];
		if v32 then
			table.clear(v32);
			p16[v5] = {};
		end;
		p16.CurrentlyCleaning = false;
	end;
end;
function v6.Destroy(p17)
	p17:Cleanup();
	table.clear(p17);
	setmetatable(p17, nil);
end;
v6.__call = v6.Cleanup;
local u2 = v2("LinkToInstanceIndex");
function v6.LinkToInstance(p18, p19, p20)
	return p18:Add(p19.Destroying:Connect(function()
		p18:Cleanup();
	end), "Disconnect", p20 and newproxy(false) or u2);
end;
function v6.LegacyLinkToInstance(p21, p22, p23)
	local u3 = setmetatable({}, v1);
	local u4 = p22.Parent == nil;
	local u5 = nil;
	u5 = p22.AncestryChanged:Connect(function(p24, p25)
		if u3.Connected then
			p24 = nil;
			u4 = p25 == nil;
			if u4 then
				task.defer(function()
					if not u3.Connected then
						return;
					end;
					if not u5.Connected then
						p21:Cleanup();
						return;
					end;
					while u4 and u5.Connected and u3.Connected do
						task.wait();					
					end;
					if u3.Connected and u4 then
						p21:Cleanup();
					end;
				end);
			end;
		end;
	end);
	u3.Connection = u5;
	if u4 and u3.Connected then
		u4 = p22.Parent == nil;
		if u4 then
			task.defer(function()
				if not u3.Connected then
					return;
				end;
				if not u5.Connected then
					p21:Cleanup();
					return;
				end;
				while u4 and u5.Connected and u3.Connected do
					task.wait();				
				end;
				if u3.Connected and u4 then
					p21:Cleanup();
				end;
			end);
		end;
	end;
	p22 = nil;
	return p21:Add(u3, "Disconnect", p23 and newproxy(false) or u2);
end;
function v6.LinkToInstances(p26, ...)
	local v33 = v6.new();
	local v34, v35, v36 = ipairs({ ... });
	while true do
		v34(v35, v36);
		if not v34 then
			break;
		end;
		v36 = v34;
		v33:Add(p26:LinkToInstance(v35, true), "Disconnect");	
	end;
	return v33;
end;
function v6.__tostring(p27)
	return "Janitor";
end;
table.freeze(v6);
return v6;
