-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l____DEBRIS__2 = game.Workspace:WaitForChild("__DEBRIS");
local l__CurrentCamera__3 = game.Workspace.CurrentCamera;
local l__Assets__4 = game.ReplicatedStorage:WaitForChild("Assets");
function v1.GetPlayer(p1)
	local v5 = u1.Saving.Get(p1, false);
	if not v5 or not v5.Challenges then
		return;
	end;
	return v5.Challenges;
end;
function v1.Get(p2)
	if not u1.Directory.Challenges[p2] then
		return nil;
	end;
	return u1.Directory.Challenges[p2];
end;
function v1.Add(p3, p4, p5)
	local v6 = u1.Saving.Get(p3);
	if not v6 or not v6.Challenges then
		return;
	end;
	for v7, v8 in pairs(v6.Challenges) do
		if v8[1] == p4 then
			v8[2] = v8[2] + p5;
		end;
	end;
end;
function v1.Set(p6, p7, p8)
	local v9 = u1.Saving.Get(p6);
	if not v9 or not v9.Challenges then
		return;
	end;
	for v10, v11 in pairs(v9.Challenges) do
		if v11[1] == p7 then
			v11[2] = p8;
		end;
	end;
end;
function v1.SetFromCategory(p9, p10, p11)
	local v12 = u1.Saving.Get(p9);
	if not v12 or not v12.Challenges then
		return;
	end;
	for v13, v14 in pairs(v12.Challenges) do
		if v1.Get(v14[1]).Stat == p10 then
			v14[2] = p11;
		end;
	end;
end;
function v1.AddFromCategory(p12, p13, p14)
	local v15 = u1.Saving.Get(p12);
	if not v15 or not v15.Challenges then
		return;
	end;
	for v16, v17 in pairs(v15.Challenges) do
		if v1.Get(v17[1]).Stat == p13 then
			v17[2] = v17[2] + p14;
		end;
	end;
end;
function v1.Has(p15, p16)
	local v18 = u1.Saving.Get(p15, false);
	if not v18 or not v18.Challenges then
		u1.Print("Failed to get stats", true);
		return;
	end;
	for v19, v20 in pairs(v18.Challenges) do
		if v20[1] == p16 then
			return true;
		end;
	end;
	return false;
end;
function v1.HasType(p17, p18)
	local v21 = u1.Saving.Get(p17, false);
	if not v21 or not v21.Challenges then
		u1.Print("Failed to get stats", true);
		return;
	end;
	for v22, v23 in pairs(v21.Challenges) do
		if v1.Get(v23[1]).Stat == p18 then
			return true;
		end;
	end;
	return false;
end;
function v1.New(p19, p20)
	local v24 = u1.Saving.Get(p19);
	local v25 = v1.Get(p20);
	if not v24 or not v24.Challenges then
		u1.Print("Failed to get stats", true);
		return false;
	end;
	if not v25 then
		return false;
	end;
	if #v24.Challenges >= 3 then
		return false;
	end;
	if v1.HasType(p19, v25.Stat) then
		return false;
	end;
	if v24.Level < 15 and v25.Reward == 3 then
		return false;
	end;
	table.insert(v24.Challenges, { p20, 0, v25.Requirement, u1.Functions.GenerateUID() });
	return true;
end;
function v1.Remove(p21, p22)
	local v26 = u1.Saving.Get(p21);
	if not v26 or not v26.Challenges then
		u1.Print("Failed to get stats", true);
		return;
	end;
	for v27, v28 in pairs(v26.Challenges) do
		if v28[4] == p22 then
			table.remove(v26.Challenges, v27);
		end;
	end;
end;
local u2 = Random.new();
function v1.RandomId()
	local v29 = {};
	for v30, v31 in pairs(u1.Directory.Challenges) do
		table.insert(v29, v30);
	end;
	return v29[u2:NextInteger(1, #v29)];
end;
game.Players.PlayerAdded:Connect(function(p23)
	coroutine.wrap(function()
		local v32 = u1.Saving.Get(p23);
		while p23 and p23.Parent == game.Players do
			wait(0.1);
			local v33 = v1.GetPlayer(p23);
			if v33 then
				for v34, v35 in pairs(v33) do
					if v1.Get(v35[1]) == nil then
						v1.Remove(p23, v35[4]);
					end;
				end;
			end;
			if v33 then
				for v36, v37 in pairs(v33) do
					if v37[3] <= v37[2] then
						local v38 = v1.Get(v37[1]);
						u1.Stars.Give(p23, v38.Reward);
						u1.Network.Fire("Challenge Completed", p23, v38);
						v37[2] = 0;
						v1.Remove(p23, v37[4]);
					end;
				end;
			end;
			if v32 and v32.Challenges and #v32.Challenges < 3 then
				local v39 = 0;
				while true do
					local v40 = v1.New(p23, v1.RandomId());
					v39 = v39 + 1;
					u1.Functions.Wait(0.01);
					if v40 then
						break;
					end;
					if v39 > 5 then
						break;
					end;				
				end;
			end;		
		end;
	end)();
end);
for v41, v42 in pairs(game.Players:GetPlayers()) do
	coroutine.wrap(function()
		local v43 = u1.Saving.Get(v42);
		while v42 and v42.Parent == game.Players do
			wait(0.1);
			local v44 = v1.GetPlayer(v42);
			if v44 then
				for v45, v46 in pairs(v44) do
					if v1.Get(v46[1]) == nil then
						v1.Remove(v42, v46[4]);
					end;
				end;
			end;
			if v44 then
				for v47, v48 in pairs(v44) do
					if v48[3] <= v48[2] then
						local v49 = v1.Get(v48[1]);
						u1.Stars.Give(v42, v49.Reward);
						u1.Network.Fire("Challenge Completed", v42, v49);
						v48[2] = 0;
						v1.Remove(v42, v48[4]);
					end;
				end;
			end;
			if v43 and v43.Challenges and #v43.Challenges < 3 then
				local v50 = 0;
				while true do
					local v51 = v1.New(v42, v1.RandomId());
					v50 = v50 + 1;
					u1.Functions.Wait(0.01);
					if v51 then
						break;
					end;
					if v50 > 5 then
						break;
					end;				
				end;
			end;		
		end;
	end)();
end;
return v1;
