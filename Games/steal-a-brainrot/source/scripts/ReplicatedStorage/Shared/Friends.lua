-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v5 = require(l_Packages_0.Signal);
local v6 = require(l_Packages_0.Debounce);
local v7 = require(l_ReplicatedStorage_0.Packages.Promise);
local l_FriendMain_0 = script:WaitForChild("FriendMain");
local v9 = {};
local v10 = {
	OnFriendsUpdate = v5.new()
};
local function v17(v11) --[[ Line: 23 ]] --[[ Name: OnPlayerAdded ]]
	-- upvalues: v9 (copy), l_Players_0 (copy)
	v9[v11] = v9[v11] or {};
	local v12 = v9[v11];
	for _, v14 in l_Players_0:GetPlayers() do
		if v14 ~= v11 then
			local l_status_0, l_result_0 = pcall(function() --[[ Line: 30 ]]
				-- upvalues: v11 (copy), v14 (copy)
				return v11:IsFriendsWithAsync(v14.UserId);
			end);
			if l_status_0 and l_result_0 then
				v9[v14] = v9[v14] or {};
				if not table.find(v12, v14) then
					table.insert(v12, v14);
				end;
				if not table.find(v9[v14], v11) then
					table.insert(v9[v14], v11);
				end;
			end;
		end;
	end;
end;
local function v22(v18) --[[ Line: 48 ]] --[[ Name: OnPlayerRemoving ]]
	-- upvalues: v9 (copy)
	for v19, v20 in v9 do
		if v19 ~= v18 then
			local v21 = table.find(v20, v18);
			if v21 then
				table.remove(v20, v21);
			end;
		end;
	end;
	v9[v18] = nil;
end;
v10.GetFriendBoostPercentage = function(_, v24) --[[ Line: 64 ]] --[[ Name: GetFriendBoostPercentage ]]
	-- upvalues: v10 (copy)
	if not v24 then
		return 0;
	else
		return math.clamp(v10:GetAmountOfFriendsOnline(v24), 0, 3) * 10;
	end;
end;
v10.GetFriendBoostModifier = function(_, v26) --[[ Line: 69 ]] --[[ Name: GetFriendBoostModifier ]]
	-- upvalues: v10 (copy)
	if not v26 then
		return 0;
	else
		return math.clamp(v10:GetAmountOfFriendsOnline(v26), 0, 3) / 10;
	end;
end;
v10.GetAmountOfFriendsOnline = function(_, v28) --[[ Line: 74 ]] --[[ Name: GetAmountOfFriendsOnline ]]
	-- upvalues: v9 (copy)
	local v29 = v9[v28];
	return v29 and #v29 or 0;
end;
local v30 = {};
local v31 = {};
v10.GetOnlineFriends = function(_, v33) --[[ Line: 81 ]] --[[ Name: GetOnlineFriends ]]
	-- upvalues: l_RunService_0 (copy), l_Players_0 (copy), v30 (copy), v31 (copy), v7 (copy)
	if v33 == nil then
		assert(l_RunService_0:IsClient());
		v33 = l_Players_0.LocalPlayer;
	end;
	assert(v33);
	local l_UnixTimestamp_0 = DateTime.now().UnixTimestamp;
	if v30[v33] == nil or l_UnixTimestamp_0 - (v31[v33] or 0) >= 600 or v30[v33]:getStatus() == v7.Status.Rejected then
		v31[v33] = l_UnixTimestamp_0;
		local l_v30_0 = v30;
		local v36 = v7.try(function() --[[ Line: 108 ]]
			-- upvalues: v33 (ref)
			return v33:GetFriendsOnlineAsync(200);
		end);
		l_v30_0[v33] = v36;
	end;
	return v30[v33]:await();
end;
l_Players_0.PlayerRemoving:Connect(function(v37) --[[ Line: 116 ]]
	-- upvalues: v30 (copy), v31 (copy)
	v30[v37] = nil;
	v31[v37] = nil;
end);
v10.HasFriendInGameAsync = function(_, v39) --[[ Line: 121 ]] --[[ Name: HasFriendInGameAsync ]]
	-- upvalues: l_Players_0 (copy)
	for _, v41 in l_Players_0:GetPlayers() do
		if v41 ~= v39 then
			local l_status_1, l_result_1 = pcall(function() --[[ Line: 127 ]]
				-- upvalues: v39 (copy), v41 (copy)
				return v39:IsFriendsWithAsync(v41.UserId);
			end);
			if l_status_1 and l_result_1 then
				return true;
			end;
		end;
	end;
	return false;
end;
v10.GetInGameFriends = function(_, v45) --[[ Line: 139 ]] --[[ Name: GetInGameFriends ]]
	-- upvalues: v9 (copy)
	return v9[v45] or {};
end;
v10.Start = function(_) --[[ Line: 143 ]] --[[ Name: Start ]]
	-- upvalues: l_RunService_0 (copy), l_FriendMain_0 (copy), v6 (copy), l_Players_0 (copy), v9 (copy), v17 (copy), v22 (copy), v10 (copy), l_StarterGui_0 (copy)
	if l_RunService_0:IsServer() then
		l_FriendMain_0.OnServerEvent:Connect(function(v47, v48, v49) --[[ Line: 147 ]]
			-- upvalues: v6 (ref), l_Players_0 (ref), v9 (ref), l_FriendMain_0 (ref)
			if v6(("Friends/Check/%*"):format(v47.Name), 0.1) then
				return;
			elseif v48 == true then
				if not v49 or typeof(v49) ~= "Instance" or not v49:IsDescendantOf(l_Players_0) or v49 == v47 then
					return;
				else
					local v50 = v9[v47];
					if not v50 then
						return;
					else
						local v51 = v9[v49];
						if not v51 then
							return;
						elseif not v47:IsFriendsWithAsync(v49.UserId) then
							return;
						else
							if not table.find(v50, v49) then
								table.insert(v50, v49);
							end;
							if not table.find(v51, v47) then
								table.insert(v51, v47);
							end;
							l_FriendMain_0:FireClient(v47, v50);
							l_FriendMain_0:FireClient(v49, v51);
							return;
						end;
					end;
				end;
			else
				l_FriendMain_0:FireClient(v47, v9[v47] or {});
				return;
			end;
		end);
		l_Players_0.PlayerAdded:Connect(v17);
		l_Players_0.PlayerRemoving:Connect(v22);
		for _, v53 in l_Players_0:GetPlayers() do
			task.spawn(v17, v53);
		end;
		return;
	else
		local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
		l_FriendMain_0.OnClientEvent:Connect(function(v55) --[[ Line: 196 ]]
			-- upvalues: v9 (ref), l_LocalPlayer_0 (copy), v10 (ref)
			v9[l_LocalPlayer_0] = v55;
			v10.OnFriendsUpdate:Fire();
		end);
		while true do
			local l_status_2, _ = pcall(function() --[[ Line: 202 ]]
				-- upvalues: l_StarterGui_0 (ref), l_FriendMain_0 (ref)
				return l_StarterGui_0:GetCore("PlayerFriendedEvent").Event:Connect(function(v56) --[[ Line: 203 ]]
					-- upvalues: l_FriendMain_0 (ref)
					l_FriendMain_0:FireServer(true, v56);
				end);
			end);
			if not l_status_2 then
				task.wait(0.1);
			else
				break;
			end;
		end;
		l_FriendMain_0:FireServer();
		task.spawn(function() --[[ Line: 216 ]]
			-- upvalues: l_FriendMain_0 (ref)
			while task.wait(15) do
				l_FriendMain_0:FireServer();
			end;
		end);
		return;
	end;
end;
v10:Start();
return v10;