--[[

    aimee was here fuck you local mf [2023]
    WRITTEN BY ME, AIMEE. YOU DICKWAD
    Developed with a keyboard and pixie dust.
    
--]]

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = "new"
local v2 = Instance.new("DataStoreOptions");
v2:SetExperimentalFeatures({
	v2 = true
});
local v3 = game:GetService('DataStoreService'):GetDataStore("BanPlayer" .. v1, nil, v2);
local l__RunService__4 = game:GetService("RunService");
local u2 = {};
local u3 = game:GetService('DataStoreService'):GetOrderedDataStore("BanRecent" .. v1, nil, v2);
function u2.Ban(p1, p2, p3)
	if type(p1) == "userdata" and p1.ClassName == "Player" then
		p1 = p1.UserId;
	end;
	p2 = p2 and 1;
	p3 = p3 and "Automated";
	if u2.IsBanned(p1) == false then
		local v5 = u2.GetProfile(p1, true);
		if v5 then
			table.insert(v5.History, 1, {
				type = "Ban", 
				moderator = p2, 
				reason = p3, 
				date = os.time()
			});
			u2.UpdateProfile(p1, {
				History = v5.History, 
				Bans = v5.Bans + 1, 
				IsBanned = true
			});
			wait(1);
			local v6 = u1.Datastore.Set(u3, u1.HttpService:JSONEncode({
				t = "Ban", 
				m = p2, 
				v = p1
			}), os.time());
			if v6 then
				u1.Signal.Fire("Banned Player", p1);
				local v7 = game.Players:GetPlayerByUserId(p1);
				if v7 then
					v7:Kick("Please rejoin.");
					u1.Network.FireAll("Chat Msg", v7.DisplayName .. " was banned.", Color3.fromRGB(255, 60, 60));
				end;
			end;
			pcall(function()
				u1.MessagingService:PublishAsync("Player Banned", p1);
			end);
			if v6 then
				u1.Print("Successfully banned [bold]" .. p1 .. "[/bold]", true);
				return true;
			end;
			u1.Print("May have failed to ban [bold]" .. p1 .. "[/bold]", true);
		else
			u1.Print("Player doesn't have profile ([bold]" .. p1 .. "[/bold])", true);
		end;
	else
		u1.Print("Player is already banned ([bold]" .. p1 .. "[/bold])", true);
	end;
	return false;
end;
function u2.Warn(p4, p5, p6)
	if type(p4) == "userdata" and p4.ClassName == "Player" then
		p4 = p4.UserId;
	end;
	p5 = p5 and 1;
	p6 = p6 and "Automated";
	if u2.IsBanned(p4) == false and u2.IsWarned(p4) == false then
		local v8 = u2.GetProfile(p4, true);
		if v8 then
			table.insert(v8.History, 1, {
				type = "Warn", 
				moderator = p5, 
				reason = p6, 
				date = os.time()
			});
			u2.UpdateProfile(p4, {
				History = v8.History, 
				Warns = v8.Warns + 1, 
				WarnTick = os.time(), 
				IsWarned = true
			});
			wait(1);
			local v9 = u1.Datastore.Set(u3, u1.HttpService:JSONEncode({
				t = "Warn", 
				m = p5, 
				v = p4
			}), os.time());
			local v10 = game.Players:GetPlayerByUserId(p4);
			if v9 then
				u1.Signal.Fire("Warned Player", p4);
				local v11 = game.Players:GetPlayerByUserId(p4);
				if v11 then
					v11:Kick("Please rejoin.");
					u1.Network.FireAll("Chat Msg", v11.DisplayName .. " was banned.", Color3.fromRGB(255, 60, 60));
				end;
			end;
			pcall(function()
				u1.MessagingService:PublishAsync("Player Banned", p4);
			end);
			if v9 then
				u1.Print("Successfully warned [bold]" .. p4 .. "[/bold]", true);
				return true;
			end;
			u1.Print("May have failed to warn [bold]" .. p4 .. "[/bold]", true);
		else
			u1.Print("Player doesn't have profile ([bold]" .. p4 .. "[/bold])", true);
		end;
	else
		u1.Print("Player is already warned or banned ([bold]" .. p4 .. "[/bold])", true);
	end;
	return false;
end;
function u2.Clear(p7, p8, p9)
	if type(p7) == "userdata" and p7.ClassName == "Player" then
		p7 = p7.UserId;
	end;
	p8 = p8 or 1;
	p9 = p9 or "Automated";
	if u2.IsBanned(p7) == true or u2.IsWarned(p7) == true then
		local v12 = u2.GetProfile(p7, true);
		if v12 then
			table.insert(v12.History, 1, {
				type = "Unban", 
				moderator = p8, 
				reason = p9, 
				date = os.time()
			});
			u2.UpdateProfile(p7, {
				History = v12.History, 
				Unbans = v12.Unbans + 1, 
				IsBanned = false, 
				IsWarned = false
			});
			wait(1);
			if u1.Datastore.Set(u3, u1.HttpService:JSONEncode({
				t = "Unban", 
				m = p8, 
				v = p7
				}), os.time()) then
				u1.Print("Successfully cleared [bold]" .. p7 .. "[/bold]", true);
				return true;
			end;
			u1.Print("May have failed to clear [bold]" .. p7 .. "[/bold]", true);
		else
			u1.Print("Player doesn't have profile ([bold]" .. p7 .. "[/bold])", true);
		end;
	else
		u1.Print("Player is cleared already ([bold]" .. p7 .. "[/bold])", true);
	end;
	return false;
end;
function u2.IsBanned(p10)
	if type(p10) == "userdata" and p10.ClassName == "Player" then
		p10 = p10.UserId;
	end;
	local v13 = u2.GetProfile(p10);
	if not v13 then
		return false;
	end;
	return v13.IsBanned;
end;
local u4 = u1.Settings.WarnTime or 259200;
function u2.IsWarned(p11)
	if type(p11) == "userdata" and p11.ClassName == "Player" then
		p11 = p11.UserId;
	end;
	local v14 = u2.GetProfile(p11);
	if v14 then
		local v15 = u4 - (os.time() - v14.WarnTick);
		local v16 = u1.Functions.TimeString(v15);
		if v14.IsWarned and v15 > 0 then
			return true, v16;
		end;
	end;
	return false;
end;
function u2.HasProfile(p12)
	return u2.GetProfile(p12) ~= nil;
end;
local u5 = {};
local u6 = {};
function u2.GetProfile(p13, p14)
	if type(p13) == "userdata" and p13.ClassName == "Player" then
		p13 = p13.UserId;
	end;
	if p14 == nil then

	end;
	local v17 = game.Players:GetPlayerByUserId(p13);
	if u5[p13] and u6[p13] and not p14 and os.clock() - u6[p13] <= 60 then
		return u5[p13];
	end;
	local v18 = u1.Datastore.Get(v3, p13);
	if v18 and not u5[p13] then
		u5[p13] = v18;
		u6[p13] = os.clock();
	end;
	return v18;
end;
function u2.UpdateProfile(p15, p16)
	if type(p15) == "userdata" and p15.ClassName == "Player" then
		p15 = p15.UserId;
	end;
	local v19 = game.Players:GetPlayerByUserId(p15);
	local v20 = nil;
	local v21 = nil;
	local v22 = nil;
	local v23 = nil;
	local v24 = nil;
	if v19 then
		v24 = u1.Saving.Get(v19);
		if v24 then
			v20 = v19.AccountAge;
			v21 = tostring(v19.MembershipType);
			v22 = u1.Gamepasses.OwnsAmount(v19);
			v23 = os.time();
		end;
	end;
	u1.Datastore.Update(v3, p15, function(p17)
		if v24 then
			p17.AccountAge = v20;
			p17.Membership = v21;
			p17.Gamepasses = v22;
			p17.LastUpdate = v23;
			p17.Paid = v24.PaidPlayer;
			p17.RobuxSpent = v24.RobuxSpent;
		end;
		if p17.IsWarned and u4 <= os.time() - p17.WarnTick then
			p17.IsWarned = false;
			p17.WarnTick = 0;
		end;
		if p16 then
			for v25, v26 in pairs(p16) do
				p17[v25] = v26;
			end;
		end;
		u5[p15] = p17;
		u6[p15] = os.clock();
		return p17;
	end);
end;
function u2.CreateProfile(p18)
	local v27 = nil;
	if type(p18) == "userdata" and p18.ClassName == "Player" then
		p18 = p18.UserId;
	end;
	local v28 = game.Players:GetPlayerByUserId(p18);
	v27 = u1.Saving.Get(v28);
	if not v28 or not v27 then
		return;
	end;
	local v29 = {
		History = {}, 
		IsBanned = false, 
		IsWarned = false, 
		WarnTick = 0, 
		Bans = 0, 
		Warns = 0, 
		Unbans = 0, 
		AccountAge = v28.AccountAge, 
		Membership = tostring(v28.MembershipType), 
		Gamepasses = u1.Gamepasses.OwnsAmount(v28), 
		LastUpdate = os.time(), 
		Paid = v27.PaidPlayer, 
		RobuxSpent = v27.RobuxSpent
	};
	u1.Datastore.Set(v3, v28.UserId, v29);
	u5[p18] = v29;
	u6[p18] = os.clock();
	return v29;
end;
local u7 = {};
local u8 = {};
function u2.GetRecentList(p19)
	if u7[p19] and os.clock() - u8[p19] >= 60 then
		return u7[p19];
	end;
	local v30 = {};
	local v31 = u3:GetSortedAsync(false, 100);
	local v32 = 1;
	while true do
		local v33 = {};
		for v34, v35 in ipairs((v31:GetCurrentPage())) do
			local v36 = u1.HttpService:JSONDecode(v35.key);
			local l__value__37 = v35.value;
			table.insert(v33, v34, {
				d = l__value__37, 
				tp = os.time() - l__value__37, 
				t = v36.t, 
				m = v36.m, 
				v = v36.v
			});
		end;
		u7[v32] = v33;
		u8[v32] = os.clock();
		if v32 == p19 then
			v30 = v33;
		end;
		if v31.IsFinished then
			break;
		end;
		if v32 == p19 then
			return v30;
		end;
		v31:AdvanceToNextPageAsync();
		v32 = v32 + 1;	
	end;
	return v30;
end;
local u9 = u1.Settings.AdminsBannable and false;
local u10 = Random.new();
local u11 = l__RunService__4:IsStudio();
function TrackPlayer(p20)
	coroutine.wrap(function()
		while true do
			if not u1.Saving.IsLoaded(p20) then

			else
				break;
			end;
			if p20 then

			else
				break;
			end;
			u1.Heartbeat();		
		end;
		if not p20 then
			return;
		end;
		while true do
			if p20 then

			else
				break;
			end;
			if game.Players:FindFirstChild(p20.Name) then

			else
				break;
			end;
			local v38 = u2.GetProfile(p20.UserId) or u2.CreateProfile(p20.UserId);
			if u1.Admins.IsAdmin(p20) then
				if u9 then
					local v39 = u2.IsWarned(p20.UserId);
					if not u2.IsBanned(p20.UserId) then
						if v39 then
							local v40 = false;
							if v39 then
								if 0 < u4 - (os.time() - v38.WarnTick) then
									v40 = true;
								end;
							else
								v40 = true;
							end;
							if v40 then
								p20:Kick("Please rejoin.");
							end;
						end;
					else
						local v40 = false;
						if v39 then
							if 0 < u4 - (os.time() - v38.WarnTick) then
								v40 = true;
							end;
						else
							v40 = true;
						end;
						if v40 then
							p20:Kick("Please rejoin.");
						end;
					end;
				end;
			else
				local v39 = u2.IsWarned(p20.UserId);
				if not u2.IsBanned(p20.UserId) then
					if v39 then
						local v40 = false;
						if v39 then
							if 0 < u4 - (os.time() - v38.WarnTick) then
								v40 = true;
							end;
						else
							v40 = true;
						end;
						if v40 then
							p20:Kick("Please rejoin.");
						end;
					end;
				else
					local v40 = false;
					if v39 then
						if 0 < u4 - (os.time() - v38.WarnTick) then
							v40 = true;
						end;
					else
						v40 = true;
					end;
					if v40 then
						p20:Kick("Please rejoin.");
					end;
				end;
			end;
			wait(90 * u10:NextNumber(0.5, 1));
			if p20 then
				if game.Players:FindFirstChild(p20.Name) then
					if not u11 then
						u2.UpdateProfile(p20.UserId);
					end;
				end;
			end;		
		end;
	end)();
end;
for v41, v42 in ipairs(game.Players:GetPlayers()) do
	TrackPlayer(v42);
end;
game.Players.PlayerAdded:Connect(function(p21)
	TrackPlayer(p21);
end);
coroutine.wrap(function()
	(function()
		local v43, v44 = pcall(function()
			return u1.MessagingService:SubscribeAsync("Player Banned", function(p22)
				if p22 then
					for v45, v46 in ipairs(game.Players:GetPlayers()) do
						if v46 and v46.UserId == p22 then
							v46:Kick("Please rejoin.");
							u1.Network.FireAll("Chat Msg", v46.DisplayName .. " was banned.", Color3.fromRGB(255, 60, 60));
							return;
						end;
					end;
				end;
			end);
		end);
		if not v43 then
			u1.Print("Failed to connect to live _L.Bans updates.", true);
		end;
	end)();
end)();
return u2;
