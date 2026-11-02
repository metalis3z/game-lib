local l_EventInfoService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType"));
local l_Events_0 = l_Remotes_0:WaitForChild("Events");
local function _(v5) --[[ Line: 8 ]] --[[ Name: didEventStart ]]
	return v5.EventStartInfo ~= nil;
end;
local function v16(v7) --[[ Line: 12 ]] --[[ Name: StartEvent ]]
	-- upvalues: l_EventInfoService_0 (copy), l_Sync_0 (copy)
	local l_l_EventInfoService_0_Event_0 = l_EventInfoService_0:GetEvent(v7);
	local l_EventStartInfo_0 = l_l_EventInfoService_0_Event_0.EventStartInfo;
	if l_EventStartInfo_0 then
		if l_EventStartInfo_0.Items then
			for v10, v11 in l_EventStartInfo_0.Items do
				for v12, v13 in v11 do
					l_Sync_0[v10][v12] = v13;
				end;
			end;
		end;
		if l_EventStartInfo_0.ShopData then
			for v14, v15 in l_EventStartInfo_0.ShopData do
				l_Sync_0.NewShop[v14] = v15;
			end;
		end;
	end;
	l_EventInfoService_0:_StartEvent(l_l_EventInfoService_0_Event_0);
end;
(function() --[[ Line: 33 ]] --[[ Name: onInitialize ]]
	-- upvalues: l_Events_0 (copy), l_EventInfoService_0 (copy), v16 (copy)
	for v17, v18 in (l_Events_0:WaitForChild("GetEvents"):InvokeServer()) do
		l_EventInfoService_0:RegisterEvent(v17, v18);
		if v18.EventStartInfo ~= nil then
			v16(v17);
		end;
	end;
	l_Events_0:WaitForChild("EventChanged").OnClientEvent:Connect(function(v19, v20) --[[ Line: 43 ]]
		-- upvalues: l_EventInfoService_0 (ref), v16 (ref)
		local l_l_EventInfoService_0_Event_1 = l_EventInfoService_0:GetEvent(v19);
		if not l_l_EventInfoService_0_Event_1 then
			l_EventInfoService_0:RegisterEvent(v19, v20);
			if v20.EventStartInfo ~= nil then
				v16(v19);
			end;
			return;
		elseif not (l_l_EventInfoService_0_Event_1.EventStartInfo ~= nil) and v20.EventStartInfo ~= nil then
			l_EventInfoService_0:RegisterEvent(v19, v20);
			v16(v19);
			return;
		else
			l_EventInfoService_0:RegisterEvent(v19, v20);
			return;
		end;
	end);
	l_EventInfoService_0.Initialized = true;
end)();