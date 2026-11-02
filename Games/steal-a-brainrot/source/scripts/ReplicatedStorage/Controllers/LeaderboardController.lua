-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Workspace_0 = game:GetService("Workspace");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v5 = require(l_Packages_0.Net);
local v6 = require(l_Packages_0.FFlags);
local v7 = require(l_Utils_0.NumberUtils);
local v8 = require(l_ReplicatedStorage_0.Datas.ServerData);
local l_Map_0 = l_Workspace_0.Map;
local v10 = {};
local v11 = {};
local function v14(v12) --[[ Line: 22 ]] --[[ Name: CountryCodeToFlag ]]
	if not v12 or #v12 ~= 2 then
		return "";
	else
		local v13 = string.upper(v12);
		return utf8.char(string.byte(v13, 1) + 127462 - 65) .. utf8.char(string.byte(v13, 2) + 127462 - 65);
	end;
end;
local v15 = {};
local v16 = Color3.fromRGB(255, 213, 0);
local v17 = Color3.fromRGB(116, 116, 116);
local v18 = Color3.fromRGB(143, 87, 35);
local v19 = Color3.fromRGB(255, 255, 255);
local v20 = Color3.fromRGB(81, 158, 86);
local v21 = Color3.fromRGB(115, 152, 172);
local v22 = v5:RemoteFunction("Leaderboard/GetTopPlayers");
local v23 = v5:RemoteFunction("Leaderboard/GetTopFriends");
local v24 = v5:RemoteFunction("Leaderboard/GetDisplayNames");
local v25 = v5:RemoteEvent("Leaderboard/ReplicateUpdate");
local v26 = v5:RemoteEvent("Leaderboard/ReplicateDisplayNames");
local v27 = v5:RemoteFunction("Leaderboard/GetCountryLeaderboard");
local v28 = v5:RemoteEvent("Leaderboard/ReplicateCountryUpdate");
local function _(v29) --[[ Line: 80 ]] --[[ Name: getRankColor ]]
	-- upvalues: v16 (copy), v17 (copy), v18 (copy), v19 (copy)
	if v29 == 1 then
		return v16;
	elseif v29 == 2 then
		return v17;
	elseif v29 == 3 then
		return v18;
	else
		return v19;
	end;
end;
local function v35(v31) --[[ Line: 91 ]] --[[ Name: removeLineFromFrames ]]
	-- upvalues: v11 (copy)
	local l_v31_Attribute_0 = v31:GetAttribute("UserId");
	if not l_v31_Attribute_0 then
		return;
	else
		local v33 = v11[l_v31_Attribute_0];
		if not v33 then
			return;
		else
			local v34 = table.find(v33, v31);
			if not v34 then
				return;
			else
				table.remove(v33, v34);
				if #v33 == 0 then
					v11[l_v31_Attribute_0] = nil;
				end;
				return;
			end;
		end;
	end;
end;
local function _(v36, v37) --[[ Line: 113 ]] --[[ Name: addLineToFrames ]]
	-- upvalues: v11 (copy)
	if not v11[v37] then
		v11[v37] = {
			v36
		};
		return;
	else
		if not table.find(v11[v37], v36) then
			table.insert(v11[v37], v36);
		end;
		return;
	end;
end;
local function _(v39) --[[ Line: 121 ]] --[[ Name: getActiveDataList ]]
	local v40 = v39.ActiveTab or "Global";
	if v40 == "Friends" then
		return v39.FriendsData;
	elseif v40 == "Country" then
		return v39.CountryData;
	else
		return v39.PlayerData;
	end;
end;
local v42 = {};
local function v65(v43) --[[ Line: 134 ]] --[[ Name: updateBoard ]]
	-- upvalues: v15 (ref), v11 (copy), v16 (copy), v17 (copy), v18 (copy), v19 (copy), v14 (copy), v10 (copy), v7 (copy), v35 (copy)
	local v44 = v15[v43];
	if not v44 then
		return;
	else
		local l_Container_0 = v44.Container;
		local l_Template_0 = v44.Template;
		local v47 = v44.ActiveTab or "Global";
		local v48 = if v47 == "Friends" then v44.FriendsData else if v47 == "Country" then v44.CountryData else v44.PlayerData;
		v47 = v44.Lines or {};
		local v49 = {};
		for v50 = 1, math.min(100, #v48) do
			local v51 = v48[v50];
			local l_UserId_0 = v51.UserId;
			if not v49[l_UserId_0] then
				local v53 = v47[l_UserId_0];
				if v53 then
					v47[l_UserId_0] = nil;
				else
					local v54 = l_Template_0:Clone();
					v54.Visible = true;
					v54.Parent = l_Container_0;
					v54:SetAttribute("UserId", l_UserId_0);
					if not v11[l_UserId_0] then
						v11[l_UserId_0] = {
							v54
						};
					elseif not table.find(v11[l_UserId_0], v54) then
						table.insert(v11[l_UserId_0], v54);
					end;
					v53 = v54;
				end;
				v53.LayoutOrder = v50;
				local l_Rank_0 = v51.Rank;
				local v56 = if l_Rank_0 == 1 then v16 else if l_Rank_0 == 2 then v17 else if l_Rank_0 == 3 then v18 else v19;
				l_Rank_0 = v53:FindFirstChild("PositionLabel");
				if l_Rank_0 then
					l_Rank_0.Text = tostring(v51.Rank) .. ".";
					l_Rank_0.TextColor3 = v56;
				end;
				local l_NameLabel_0 = v53:FindFirstChild("NameLabel");
				if l_NameLabel_0 then
					l_NameLabel_0.AutoLocalize = false;
					local v58 = if v51.Country then " " .. v14(v51.Country) else "";
					l_NameLabel_0.Text = (v10[v51.UserId] or "Loading...") .. v58;
					l_NameLabel_0:SetAttribute("Flag", v58);
					l_NameLabel_0.TextColor3 = v56;
				end;
				local l_v53_FirstChild_0 = v53:FindFirstChild(v43 .. "Label");
				if l_v53_FirstChild_0 then
					local v60 = v7:ToString(math.round(v51.Value), 2);
					l_v53_FirstChild_0.Text = if v43 == "Generation" then v60 .. "/s" else v60;
					l_v53_FirstChild_0.TextColor3 = v56;
				end;
				local l_AvatarImage_0 = v53:FindFirstChild("AvatarImage");
				if l_AvatarImage_0 then
					l_AvatarImage_0.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v51.UserId);
					local l_UIStroke_0 = l_AvatarImage_0:FindFirstChild("UIStroke");
					if l_UIStroke_0 then
						l_UIStroke_0.Color = v56;
					end;
				end;
				v49[l_UserId_0] = v53;
			end;
		end;
		for _, v64 in v47 do
			v35(v64);
			v64:Destroy();
		end;
		v44.Lines = v49;
		return;
	end;
end;
local function v73(v66, v67) --[[ Line: 216 ]] --[[ Name: setActiveTab ]]
	-- upvalues: v15 (ref), v20 (copy), v21 (copy), v65 (copy)
	local v68 = v15[v66];
	if not v68 then
		return;
	else
		v68.ActiveTab = v67;
		local l_Buttons_0 = v68.Gui:WaitForChild("MainFrame"):WaitForChild("Buttons");
		local l_Global_0 = l_Buttons_0:FindFirstChild("Global");
		local l_Friends_0 = l_Buttons_0:FindFirstChild("Friends");
		local l_Country_0 = l_Buttons_0:FindFirstChild("Country");
		if l_Global_0 then
			l_Global_0.BackgroundColor3 = if v67 == "Global" then v20 else v21;
		end;
		if l_Friends_0 then
			l_Friends_0.BackgroundColor3 = if v67 == "Friends" then v20 else v21;
		end;
		if l_Country_0 then
			l_Country_0.BackgroundColor3 = if v67 == "Country" then v20 else v21;
		end;
		v65(v66);
		return;
	end;
end;
local function v85(v74) --[[ Line: 242 ]] --[[ Name: fetchFriendsLeaderboard ]]
	-- upvalues: v15 (ref), v23 (copy), v10 (copy), v65 (copy)
	local v75 = v15[v74];
	if not v75 or v75.FriendsFetched then
		return;
	else
		v75.FriendsFetched = true;
		local v76 = nil;
		local v77 = nil;
		pcall(function() --[[ Line: 249 ]]
			-- upvalues: v76 (ref), v77 (ref), v23 (ref), v74 (copy)
			local v78, v79 = v23:InvokeServer(v74);
			v76 = v78;
			v77 = v79;
		end);
		if not v76 or type(v77) ~= "table" then
			v75.FriendsFetched = nil;
			return;
		else
			table.sort(v77, function(v80, v81) --[[ Line: 258 ]]
				return (v80.Amount or 0) > (v81.Amount or 0);
			end);
			local v82 = {};
			for v83, v84 in v77 do
				v10[v84.Id] = v84.DisplayName or v84.Username;
				table.insert(v82, {
					UserId = v84.Id, 
					Value = v84.Amount or 0, 
					Rank = v83, 
					Country = v84.Country
				});
			end;
			v75.FriendsData = v82;
			if v75.ActiveTab == "Friends" then
				v65(v74);
			end;
			return;
		end;
	end;
end;
local function v92(v86) --[[ Line: 280 ]] --[[ Name: fetchCountryLeaderboard ]]
	-- upvalues: v15 (ref), v27 (copy), v65 (copy)
	local v87 = v15[v86];
	if not v87 or v87.CountryFetched then
		return;
	else
		v87.CountryFetched = true;
		local v88 = nil;
		local v89 = nil;
		pcall(function() --[[ Line: 289 ]]
			-- upvalues: v88 (ref), v89 (ref), v27 (ref), v86 (copy)
			local v90, v91 = v27:InvokeServer(v86);
			v88 = v90;
			v89 = v91;
		end);
		if type(v88) == "table" then
			v87.CountryData = v88;
			v87.CountryCode = v89;
			if v87.ActiveTab == "Country" then
				v65(v86);
			end;
		else
			v87.CountryFetched = nil;
		end;
		return;
	end;
end;
local function v95(v93, v94) --[[ Line: 304 ]] --[[ Name: refreshLeaderboard ]]
	-- upvalues: v22 (copy), v15 (ref), v65 (copy)
	if not v94 then
		pcall(function() --[[ Line: 306 ]]
			-- upvalues: v94 (ref), v22 (ref), v93 (copy)
			v94 = v22:InvokeServer(v93);
		end);
	end;
	if type(v94) == "table" then
		v15[v93].PlayerData = v94;
		if (v15[v93].ActiveTab or "Global") == "Global" then
			v65(v93);
		end;
	end;
end;
local function v97(v96) --[[ Line: 319 ]] --[[ Name: onPlayerAdded ]]
	-- upvalues: v10 (copy)
	v10[v96.UserId] = v96.DisplayName;
end;
v42.Start = function(_) --[[ Line: 324 ]] --[[ Name: Start ]]
	-- upvalues: v8 (copy), l_Players_0 (copy), v15 (ref), l_Map_0 (copy), v6 (copy), v73 (copy), v85 (copy), v92 (copy), v97 (copy), v10 (copy), v11 (copy), v25 (copy), v95 (copy), v28 (copy), v65 (copy), v26 (copy), v24 (copy)
	if v8.IsDuelsServer() or v8.IsTsunamiServer() then
		return;
	else
		local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
		v15 = {
			Generation = {
				Model = l_Map_0:WaitForChild("GenerationBoard"), 
				PlayerData = {}, 
				FriendsData = {}, 
				CountryData = {}, 
				ActiveTab = "Global", 
				Lines = {}
			}, 
			Steals = {
				Model = l_Map_0:WaitForChild("StealsBoard"), 
				PlayerData = {}, 
				FriendsData = {}, 
				CountryData = {}, 
				ActiveTab = "Global", 
				Lines = {}
			}
		};
		for v100, v101 in v15 do
			local l_Main_0 = v101.Model:WaitForChild("Main");
			local l_SurfaceGui_0 = l_Main_0:WaitForChild("SurfaceGui");
			l_SurfaceGui_0.Adornee = l_Main_0;
			l_SurfaceGui_0.Parent = l_PlayerGui_0;
			v101.Gui = l_SurfaceGui_0;
			local l_MainFrame_0 = l_SurfaceGui_0:WaitForChild("MainFrame");
			v101.Container = l_MainFrame_0:WaitForChild("ScrollingFrame");
			v101.Template = v101.Container:WaitForChild("LeaderboardTemplate");
			local l_Buttons_1 = l_MainFrame_0:WaitForChild("Buttons");
			local l_Global_1 = l_Buttons_1:FindFirstChild("Global");
			local l_Friends_1 = l_Buttons_1:FindFirstChild("Friends");
			local l_Country_1 = l_Buttons_1:FindFirstChild("Country");
			v101.ButtonsFrame = l_Buttons_1;
			v101.GlobalBtn = l_Global_1;
			v101.FriendsBtn = l_Friends_1;
			v101.CountryBtn = l_Country_1;
			v101.OriginalContainerSize = v101.Container.Size;
			if l_Global_1 then
				l_Global_1.Activated:Connect(function() --[[ Line: 376 ]]
					-- upvalues: v6 (ref), v73 (ref), v100 (copy)
					if v6:GetInstant("Leaderboard/GlobalDisabled", false) then
						return;
					else
						v73(v100, "Global");
						return;
					end;
				end);
			end;
			if l_Friends_1 then
				l_Friends_1.Activated:Connect(function() --[[ Line: 386 ]]
					-- upvalues: v6 (ref), v73 (ref), v100 (copy), v85 (ref)
					if v6:GetInstant("Leaderboard/FriendsDisabled", false) then
						return;
					else
						v73(v100, "Friends");
						task.spawn(v85, v100);
						return;
					end;
				end);
			end;
			if l_Country_1 then
				l_Country_1.Activated:Connect(function() --[[ Line: 397 ]]
					-- upvalues: v6 (ref), v73 (ref), v100 (copy), v92 (ref)
					if v6:GetInstant("Leaderboard/CountryDisabled", false) then
						return;
					else
						v73(v100, "Country");
						task.spawn(v92, v100);
						return;
					end;
				end);
			end;
		end;
		local function v120() --[[ Line: 408 ]] --[[ Name: updateFlagVisibility ]]
			-- upvalues: v6 (ref), v15 (ref), v73 (ref)
			local l_v6_Instant_0 = v6:GetInstant("Leaderboard/GlobalDisabled", false);
			local l_v6_Instant_1 = v6:GetInstant("Leaderboard/FriendsDisabled", false);
			local l_v6_Instant_2 = v6:GetInstant("Leaderboard/CountryDisabled", false);
			for v112, v113 in v15 do
				local l_GlobalBtn_0 = v113.GlobalBtn;
				local l_FriendsBtn_0 = v113.FriendsBtn;
				local l_CountryBtn_0 = v113.CountryBtn;
				if l_GlobalBtn_0 then
					l_GlobalBtn_0.Visible = not l_v6_Instant_0;
				end;
				if l_FriendsBtn_0 then
					l_FriendsBtn_0.Visible = not l_v6_Instant_1;
				end;
				if l_CountryBtn_0 then
					l_CountryBtn_0.Visible = not l_v6_Instant_2;
				end;
				local v117 = 0;
				if l_GlobalBtn_0 and not l_v6_Instant_0 then
					v117 = v117 + 1;
				end;
				if l_FriendsBtn_0 and not l_v6_Instant_1 then
					v117 = v117 + 1;
				end;
				if l_CountryBtn_0 and not l_v6_Instant_2 then
					v117 = v117 + 1;
				end;
				if v117 <= 1 then
					v113.ButtonsFrame.Visible = false;
					v113.Container.Size = UDim2.new(v113.OriginalContainerSize.X.Scale, v113.OriginalContainerSize.X.Offset, 0.9, 0);
				else
					v113.ButtonsFrame.Visible = true;
					v113.Container.Size = v113.OriginalContainerSize;
				end;
				local l_ActiveTab_0 = v113.ActiveTab;
				if l_ActiveTab_0 == "Global" and l_v6_Instant_0 or l_ActiveTab_0 == "Friends" and l_v6_Instant_1 or l_ActiveTab_0 == "Country" and l_v6_Instant_2 then
					local v119 = not l_v6_Instant_0 and "Global" or if l_v6_Instant_1 then l_v6_Instant_2 and "Global" or "Country" else "Friends";
					v73(v112, v119);
				end;
			end;
		end;
		task.spawn(v120);
		v6:OnUpdate(v120);
		for _, v122 in l_Players_0:GetPlayers() do
			task.spawn(v97, v122);
		end;
		l_Players_0.PlayerAdded:Connect(v97);
		local function v131(v123) --[[ Line: 473 ]] --[[ Name: updateNameCache ]]
			-- upvalues: v10 (ref), v11 (ref)
			if type(v123) ~= "table" then
				return;
			else
				for v124, v125 in v123 do
					local v126 = tonumber(v124);
					if v126 then
						v10[v126] = v125;
						local v127 = v11[v126];
						if type(v127) == "table" then
							for _, v129 in v127 do
								local l_NameLabel_1 = v129:FindFirstChild("NameLabel");
								if l_NameLabel_1 and l_NameLabel_1:IsA("TextLabel") then
									l_NameLabel_1.Text = v125 .. (l_NameLabel_1:GetAttribute("Flag") or "");
								end;
							end;
						end;
					end;
				end;
				return;
			end;
		end;
		v25.OnClientEvent:Connect(function(v132, v133) --[[ Line: 500 ]]
			-- upvalues: v95 (ref)
			v95(v132, v133);
		end);
		v28.OnClientEvent:Connect(function(v134, v135) --[[ Line: 504 ]]
			-- upvalues: v15 (ref), v65 (ref)
			local v136 = v15[v134];
			if not v136 then
				return;
			else
				v136.CountryData = v135;
				if v136.ActiveTab == "Country" then
					v65(v134);
				end;
				return;
			end;
		end);
		v26.OnClientEvent:Connect(v131);
		v131(v24:InvokeServer());
		for v137, v138 in v15 do
			if v138.ActiveTab == "Global" then
				task.spawn(v95, v137);
			elseif v138.ActiveTab == "Friends" then
				task.spawn(v85, v137);
			elseif v138.ActiveTab == "Country" then
				task.spawn(v92, v137);
			end;
		end;
		return;
	end;
end;
return v42;
