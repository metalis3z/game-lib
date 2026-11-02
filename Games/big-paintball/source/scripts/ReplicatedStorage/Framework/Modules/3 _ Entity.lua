-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = game:GetService("RunService"):IsServer();
local u3 = {};
local u4 = {};
local u5 = {};
function u3.Add(p1, p2)
	if not p2 then
		p2 = {};
	end;
	if u2 and p2.replicate == nil then
		p2.replicate = true;
	elseif p2.replicate == nil then
		p2.replicate = false;
	end;
	p2.sub = p2.sub ~= nil and p2.sub or false;
	if type(p1) == "table" and #p1 >= 1 then
		local v1 = {};
		for v2, v3 in ipairs(p1) do
			table.insert(v1, u3.Create(v3, p2));		
		end;
		return v1;
	end;
	if not p1 then
		return u1.Print("First arg is nil/missing (object)", true);
	end;
	if u4[p1] then
		return u1.Print("Ignored attempt to overwrite existing entity (" .. p1.Name .. ")", true);
	end;
	local v5 = {};
	local v6 = Instance.new("BindableEvent");
	v5.Changed = v6.Event;
	local v7 = Instance.new("BindableEvent");
	v5.Cleared = v7.Event;
	if u2 then
		v5._INTERNAL = {
			networkHash = 1, 
			replicate = p2.replicate, 
			sub = p2.sub
		};
		if p2.sub then
			local function v8(p3)
				if p3 and p3.Parent and p1 then
					local v9 = u1.Functions.CloneTable(p2);
					v9.sub = false;
					local u6 = u3.Add(p3, v9);
					for v10, v11 in pairs(v5) do
						if v10 ~= "_INTERNAL" and v10 ~= "Cleared" and v10 ~= "Changed" then
							if type(v11) == "table" then
								u6[v10] = u1.Functions.CloneTable(v11);
							else
								u6[v10] = v11;
							end;
						end;
					end;
					v5.Changed:Connect(function(p4, p5)
						if u6[p4] == nil and p5 ~= nil then
							if type(p5) ~= "table" then
								u6[p4] = p5;
								return;
							end;
						else
							return;
						end;
						u6[p4] = u1.Functions.CloneTable(p5);
					end);
				end;
			end;
			for v12, v13 in ipairs(p1:GetChildren()) do
				v8(v13);			
			end;
			p1.ChildAdded:Connect(function(p6)
				v8(p6);
			end);
		end;
		if p2.whitelist then
			local v15 = {};
			for v16, v17 in ipairs(p2.whitelist) do
				if v17 and type(v17) == "userdata" and v17.Parent and v17.ClassName == "Player" then
					table.insert(v15, v17);
				end;			
			end;
			v5._INTERNAL.whitelist = v15;
		end;
		if p2.blacklist then
			local v19 = {};
			for v20, v21 in ipairs(p2.blacklist) do
				if v21 and type(v21) == "userdata" and v21.Parent and v21.ClassName == "Player" then
					table.insert(v19, v21);
				end;			
			end;
			if #v19 >= 1 then
				v5._INTERNAL.blacklist = v19;
			end;
		end;
	end;
	u4[p1] = v5;
	u5[p1] = {
		Changed = v6, 
		Cleared = v7
	};
	return u4[p1];
end;
local u7 = {};
function u3.Clear(p7)
	if u4[p7] and u5[p7] then
		local v23 = u5[p7];
		v23.Cleared:Fire();
		u4[p7] = nil;
		for v24, v25 in ipairs(v23) do
			v25:Destroy();		
		end;
		u5[p7] = nil;
		table.insert(u7, p7);
	end;
end;
function u3.Get(p8, p9)
	return u4[p8];
end;
function u3.Edit(p10, p11, p12)
	p12 = p12 ~= nil and p12 or false;
	if not p11 or #p11 == 0 then
		u1.Print("Settings empty or nil", true);
		return;
	end;
	local v28 = u3.Get(p10);
	if v28 then
		if p12 then
			v28._INTERNAL = p11;
		else
			for v29, v30 in pairs(p11) do
				v28._INTERNAL[v29] = v30;
			end;
		end;
		v28._INTERNAL.networkHash = v28._INTERNAL.networkHash;
	end;
end;
function u3.GetAll()
	return u4;
end;
coroutine.wrap(function()
	while true do
		local v31 = 0;
		for v32, v33 in pairs(u4) do
			if (v31 + 1) % 200 == 0 then
				u1.Services.RunService.Heartbeat:Wait();
			end;
			if not v33 or not v33.Parent then
				u3.Clear(v33);
			end;		
		end;
		u1.Services.RunService.Heartbeat:Wait();	
	end;
end)();
if u2 then
	u1.Network.Fired("Grab All Entities"):Connect(function(p13)
		local v37 = {};
		for v38, v39 in pairs(u4) do
			local v40 = u1.Functions.CloneTable(v39, true);
			v40.Changed = nil;
			v40.Cleared = nil;
			table.insert(v37, { v38, v40 });
		end;
		u1.Network.Fire("Entity Updates", p13, v37);
	end);
	local u8 = {};
	coroutine.wrap(function()
		while true do
			local u9 = {};
			local function v41(p14, p15, p16)
				p16 = p16 or {};
				local l___INTERNAL__42 = p15._INTERNAL;
				l___INTERNAL__42.networkHash = l___INTERNAL__42.networkHash + 1;
				local v43 = u1.Functions.CloneTable(p15, true);
				v43.Changed = nil;
				v43.Cleared = nil;
				table.insert(u9, { p14, v43, p16 });
				u8[p14] = v43;
				for v44, v45 in ipairs(p16) do
					u5[p14].Changed:Fire(v45, p15[v45]);				
				end;
			end;
			local v47 = 0;
			for v48, v49 in pairs(u4) do
				if (v47 + 1) % 100 == 0 then
					u1.Services.RunService.Heartbeat:Wait();
				end;
				if v49._INTERNAL.replicate then
					local v53 = u8[v48] or {};
					local v54 = {};
					for v55, v56 in pairs(v49) do
						if v55 ~= "Changed" and v55 ~= "Cleared" and v55 ~= "_INTERNAL" then
							local v57 = v53[v55];
							if v57 == nil then
								table.insert(v54, v55);
							elseif type(v56) == "table" and type(v57) == "table" then
								if not u1.Functions.CompareTable(v56, v57) then
									table.insert(v54, v55);
								end;
							elseif v56 ~= v57 then
								table.insert(v54, v55);
							end;
						end;
					end;
					if #v54 >= 1 then
						v41(v48, v49, v54);
					end;
				end;			
			end;
			if #u9 >= 1 then
				coroutine.wrap(function()
					u1.Network.FireAll("Entity Updates", u9);
				end)();
			end;
			if #u7 >= 1 then
				coroutine.wrap(function()
					u7 = {};
					u1.Network.FireAll("Entity Clear Updates", (u1.Functions.CloneTable(u7, true)));
				end)();
			end;
			u1.Services.RunService.Heartbeat:Wait();		
		end;
	end)();
end;
if not u2 then
	local function u10(p17)
		local l___INTERNAL__58 = p17._INTERNAL;
		local l__LocalPlayer__59 = game.Players.LocalPlayer;
		if l___INTERNAL__58.whitelist and not u1.Functions.SearchArray(l___INTERNAL__58.whitelist, l__LocalPlayer__59) then
			return false;
		end;
		if l___INTERNAL__58.blacklist and u1.Functions.SearchArray(l___INTERNAL__58.blacklist, l__LocalPlayer__59) then
			return false;
		end;
		return true;
	end;
	u1.Network.Fired("Entity Updates"):Connect(function(p18)
		for v60, v61 in ipairs(p18) do
			local v63, v64, v65 = unpack(v61);
			if not u4[v63] or u4[v63]._INTERNAL.networkHash <= v64._INTERNAL.networkHash then
				if not u10(v64) then
					if u4[v63] then
						u3.Clear(v63);
					end;
				else
					if not u4[v63] then
						u3.Add(v63);
					end;
					for v66, v67 in pairs(v64) do
						u4[v63][v66] = v67;
					end;
					if v65 then
						local v68 = u5[v63];
						for v69, v70 in ipairs(v65) do
							v68.Changed:Fire(v70, v64[v70]);						
						end;
					end;
				end;
			else
				u1.Print("Failed to apply new entity info from packet", true);
			end;		
		end;
	end);
	u1.Network.Fired("Entity Clear Updates"):Connect(function(p19)
		for v72, v73 in ipairs(p19) do
			if u4[v73] then
				u3.Clear(v73);
			end;		
		end;
	end);
	coroutine.wrap(function()
		while true do
			u1.Network.Fire("Grab All Entities");
			wait(60);		
		end;
	end)();
end;
return u3;
