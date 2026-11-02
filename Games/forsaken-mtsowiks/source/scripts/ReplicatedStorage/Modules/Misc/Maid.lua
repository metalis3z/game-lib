-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Maid, time of decompilation: Fri Nov 28 21:06:30 2025 ]]
local v0 = {
	ClassName = "Maid"
};
v0.new = function() --[[ Line: 12 ]] --[[ Name: new ]]
	-- upvalues: v0 (copy)
	return (setmetatable({
		_tasks = {}
	}, v0));
end;
v0.isMaid = function(v1) --[[ Line: 18 ]] --[[ Name: isMaid ]]
	local v2 = false;
	if type(v1) == "table" then
		v2 = v1.ClassName == "Maid";
	end;
	return v2;
end;
v0.__index = function(v3, v4) --[[ Line: 24 ]] --[[ Name: __index ]]
	-- upvalues: v0 (copy)
	if v0[v4] then
		return v0[v4];
	else
		return v3._tasks[v4];
	end;
end;
v0.__newindex = function(v5, v6, v7) --[[ Line: 41 ]] --[[ Name: __newindex ]]
	-- upvalues: v0 (copy)
	if v0[v6] ~= nil then
		error(("'%s' is reserved"):format((tostring(v6))), 2);
	end;
	local l__tasks_0 = v5._tasks;
	local v9 = l__tasks_0[v6];
	if v9 == v7 then
		return;
	else
		l__tasks_0[v6] = v7;
		if v9 then
			if type(v9) == "function" then
				v9();
				return;
			elseif typeof(v9) == "RBXScriptConnection" then
				v9:Disconnect();
				return;
			elseif typeof(v9) == "thread" then
				task.cancel(v9);
				return;
			elseif v9.Destroy then
				v9:Destroy();
			end;
		end;
		return;
	end;
end;
v0.GiveTask = function(v10, v11) --[[ Line: 71 ]] --[[ Name: GiveTask ]]
	if not v11 then
		error("Task cannot be false or nil", 2);
	end;
	local v12 = #v10._tasks + 1;
	v10[v12] = v11;
	if type(v11) == "table" and not v11.Destroy then
		warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback());
	end;
	return v12;
end;
v0.Add = function(v13, v14) --[[ Line: 89 ]] --[[ Name: Add ]]
	v13:GiveTask(v14);
end;
v0.GivePromise = function(v15, v16) --[[ Line: 91 ]] --[[ Name: GivePromise ]]
	if not v16:IsPending() then
		return v16;
	else
		local v17 = v16:resolved();
		local v18 = v15:GiveTask(v17);
		v17:Finally(function() --[[ Line: 100 ]]
			-- upvalues: v15 (copy), v18 (copy)
			v15[v18] = nil;
		end);
		return v17;
	end;
end;
v0.DoCleaning = function(v19) --[[ Line: 109 ]] --[[ Name: DoCleaning ]]
	local l__tasks_1 = v19._tasks;
	for v21, v22 in pairs(l__tasks_1) do
		if typeof(v22) == "RBXScriptConnection" then
			l__tasks_1[v21] = nil;
			v22:Disconnect();
		end;
	end;
	local v23, v24 = next(l__tasks_1);
	while v24 ~= nil do
		l__tasks_1[v23] = nil;
		if type(v24) == "function" then
			v24();
		elseif typeof(v24) == "RBXScriptConnection" then
			v24:Disconnect();
		elseif typeof(v24) == "thread" then
			v24.cancel(v24);
		elseif v24.Destroy then
			v24:Destroy();
		end;
		local v25, v26 = next(l__tasks_1);
		v23 = v25;
		v24 = v26;
	end;
end;
v0.Destroy = v0.DoCleaning;
return v0;