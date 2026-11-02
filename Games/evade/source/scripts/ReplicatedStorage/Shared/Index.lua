local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v2 = require(l_Packages_0.Synchronizer);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v4 = require(l_ReplicatedStorage_0.Datas.Index);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local v6 = require(l_Datas_0.Animals);

local v10 = {
	CanShowInIndex = function(_, v8) --[[ Line: 17 ]] --[[ Name: CanShowInIndex ]]
		-- upvalues: v6 (copy)
		local v9 = v6[v8];
		if not v9 then
			return false;
		elseif v9.IsEnabled and not v9.IsEnabled() then
			return false;
		elseif v9.HideFromIndex then
			return false;
		else
			return true;
		end;
	end
};

v10.IsComplete = function(_, v12, v13) --[[ Line: 34 ]] --[[ Name: IsComplete ]]
	-- upvalues: v2 (copy), v4 (copy), v6 (copy), v10 (copy)
	local v14 = v2:Get(v12);
	if not v14 then
		return false;
	else
		local v15 = v14:Get("Index");
		local v16 = 0;
		local v17 = 0;
		local v18 = v13 and v4[v13];
		if v18 and v18.DisableIndex then
			return false;
		else
			local v19 = v18 and v18.Index;
			if v19 then
				for v20, v21 in v19 do
					if not v21.IgnoreIndexCounter then
						v17 = v17 + 1;
					end;
					local v22 = v15[v20];
					if v22 then
						local _ = nil;
						if if not v18 or v18.IsMutation then v22[v13] else next(v22) ~= nil then
							v16 = v16 + 1;
						end;
					end;
				end;
				local l_v17_0 = v17;
				local v25 = v18 and v18.CompletitionPercent or v13 == "Default" and 0.75 or 1;
				if v25 ~= 1 then
					l_v17_0 = math.max(math.ceil(l_v17_0 * v25), 1);
				end;
				return l_v17_0 <= v16;
			else
				for v26 in v6 do
					if v10:CanShowInIndex(v26) then
						v17 = v17 + 1;
						local v27 = v15[v26];
						if v27 and v27[v13 and v13 or "Default"] then
							v16 = v16 + 1;
						end;
					end;
				end;
				local l_v17_1 = v17;
				local v29 = v18 and v18.CompletitionPercent or v13 == "Default" and 0.75 or 1;
				if v29 ~= 1 then
					l_v17_1 = math.max(math.ceil(l_v17_1 * v29), 1);
				end;
				return l_v17_1 <= v16;
			end;
		end;
	end;
end;

v10.GetIndexAnimals = function(_, v31, v32) --[[ Line: 113 ]] --[[ Name: GetIndexAnimals ]]
	-- upvalues: v2 (copy), v4 (copy), v6 (copy), v10 (copy)
	local v33 = v2:Get(v31);
	if not v33 then
		return nil;
	else
		local v34 = v33:Get("Index");
		local v35 = v32 and v4[v32];
		local v36 = v35 and v35.Index;
		if v36 then
			local v37 = 0;
			local v38 = 0;
			local v39 = 0;
			for v40, v41 in v36 do
				v39 = v39 + 1;
				if not v41.IgnoreIndexCounter then
					v38 = v38 + 1;
				end;
				local v42 = v34[v40];
				if v42 then
					local _ = nil;
					if if not v35 or v35.IsMutation then v42[v32] else next(v42) ~= nil then
						v37 = v37 + 1;
					end;
				end;
			end;
			local l_v38_0 = v38;
			local v45 = v35 and v35.CompletitionPercent or v32 == "Default" and 0.75 or 1;
			if v45 ~= 1 then
				l_v38_0 = math.max(math.ceil(l_v38_0 * v45), 1);
			end;
			return v37, l_v38_0, v39;
		else
			local v46 = 0;
			local v47 = 0;
			local v48 = 0;
			for v49, _ in v6 do
				if v10:CanShowInIndex(v49) then
					v48 = v48 + 1;
					v47 = v47 + 1;
					local v51 = v34[v49];
					if v51 then
						local v52 = v51[v32 and v32 or "Default"];
						if v52 and v52 > 0 then
							v46 = v46 + 1;
						end;
					end;
				end;
			end;
			local l_v47_0 = v47;
			local v54 = v35 and v35.CompletitionPercent or v32 == "Default" and 0.75 or 1;
			if v54 ~= 1 then
				l_v47_0 = math.max(math.ceil(l_v47_0 * v54), 1);
			end;
			return v46, l_v47_0, v48;
		end;
	end;
end;

v10.GetMultipliers = function(_, v56) --[[ Line: 192 ]] --[[ Name: GetMultipliers ]]
	-- upvalues: v2 (copy), v10 (copy), v4 (copy)
	local v57 = 0;
	if v2:Get(v56) then
		local v58 = 0 + (v10:IsComplete(v56) == true and 1 or 0);
		for v59, v60 in v4 do
			if not v60.LimitedMutation and v60.IsMutation then
				v58 = v58 + (v10:IsComplete(v56, v59) == true and 1 or 0);
			end;
		end;
		v57 = v57 + v58 * 0.5;
	end;
	return v57;
end;

return v10;