-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = script:WaitForChild("BattlePasses");
local _ = script:WaitForChild("MysteryBoxes");
local _ = script:WaitForChild("ShopData");
local l_Generic_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("Generic");
local l_EventList_0 = script:WaitForChild("EventList");
local v6 = {
	Inactive = "Inactive", 
	PreUpdate = "PreUpdate", 
	PreLiveEvent = "PreLiveEvent", 
	Active = "Active", 
	PostUpdate = "PostUpdate"
};
local Valentines2023 = require(l_EventList_0:WaitForChild("Valentines2023"));
local l_script_Attribute_0 = script:GetAttribute("CurrentEventState");
v0.GetCurrentEvent = function(_) --[[ Line: 52 ]] --[[ Name: GetCurrentEvent ]]
	-- upvalues: Valentines2023 (copy)
	return Valentines2023;
end;
v0.GetCurrentItemPack = function(_) --[[ Line: 57 ]] --[[ Name: GetCurrentItemPack ]]
	return nil;
end;
v0.GetEventState = function(_) --[[ Line: 62 ]] --[[ Name: GetEventState ]]
	-- upvalues: l_script_Attribute_0 (ref)
	return l_script_Attribute_0;
end;
v0.IsInState = function(_, v13) --[[ Line: 67 ]] --[[ Name: IsInState ]]
	-- upvalues: v6 (copy), l_script_Attribute_0 (ref)
	if not v6[v13] then
		warn("Invalid event state: ", v13);
		return false;
	else
		return l_script_Attribute_0 == v13;
	end;
end;
v0.IsEventActive = function(_) --[[ Line: 76 ]] --[[ Name: IsEventActive ]]
	-- upvalues: l_script_Attribute_0 (ref), v6 (copy), Valentines2023 (copy)
	local v15 = false;
	if l_script_Attribute_0 == v6.Active then
		v15 = Valentines2023 ~= nil;
	end;
	return v15;
end;
v0.AreItemsCurrentlyPurchasable = function(_) --[[ Line: 81 ]] --[[ Name: AreItemsCurrentlyPurchasable ]]
	-- upvalues: v0 (copy)
	return v0:IsInState("Active") or v0:IsInState("PostUpdate");
end;
v0.GetEventName = function(_) --[[ Line: 86 ]] --[[ Name: GetEventName ]]
	-- upvalues: Valentines2023 (copy)
	if Valentines2023 then
		return Valentines2023.Name;
	else
		return nil;
	end;
end;
v0.GetEventTitle = function(_) --[[ Line: 95 ]] --[[ Name: GetEventTitle ]]
	-- upvalues: Valentines2023 (copy)
	if not Valentines2023 then
		return nil;
	else
		return Valentines2023.Name .. Valentines2023.Year;
	end;
end;
v0.GetEventCurrency = function(_) --[[ Line: 103 ]] --[[ Name: GetEventCurrency ]]
	-- upvalues: Valentines2023 (copy)
	if not Valentines2023 then
		return nil;
	else
		return Valentines2023.Currency;
	end;
end;
v0.GetEventKey = function(_) --[[ Line: 112 ]] --[[ Name: GetEventKey ]]
	-- upvalues: Valentines2023 (copy)
	if not Valentines2023 then
		return nil;
	else
		return Valentines2023.KeyName;
	end;
end;
v0.GetEventRemotes = function(_) --[[ Line: 121 ]] --[[ Name: GetEventRemotes ]]
	-- upvalues: l_Generic_0 (copy)
	return l_Generic_0;
end;
v0.GetBattlePass = function(_) --[[ Line: 126 ]] --[[ Name: GetBattlePass ]]
	-- upvalues: Valentines2023 (copy)
	return Valentines2023.BattlePass;
end;
v0.GetMysteryBoxData = function(_) --[[ Line: 132 ]] --[[ Name: GetMysteryBoxData ]]
	-- upvalues: Valentines2023 (copy)
	if not Valentines2023.MysteryBox then
		return nil;
	else
		return Valentines2023.MysteryBox;
	end;
end;
v0.GetShopItems = function(_) --[[ Line: 140 ]] --[[ Name: GetShopItems ]]
	-- upvalues: Valentines2023 (copy)
	if not Valentines2023.ShopItems then
		return {};
	else
		return Valentines2023.ShopItems;
	end;
end;
v0.GetCurrencyDevProducts = function(_) --[[ Line: 148 ]] --[[ Name: GetCurrencyDevProducts ]]
	-- upvalues: Valentines2023 (copy)
	local v26 = Valentines2023 and Valentines2023.DevProducts;
	if not v26 then
		return {};
	else
		return v26;
	end;
end;
v0.GetLeaderboardInfo = function(_) --[[ Line: 157 ]] --[[ Name: GetLeaderboardInfo ]]
	-- upvalues: Valentines2023 (copy)
	return Valentines2023.Leaderboards;
end;
v0.GetLeaderboardStatus = function(_) --[[ Line: 163 ]] --[[ Name: GetLeaderboardStatus ]]
	-- upvalues: Valentines2023 (copy)
	local v29 = math.floor((workspace:GetServerTimeNow()));
	local v30 = nil;
	local v31 = nil;
	local l_PauseStartTime_0 = Valentines2023.Leaderboards.Points.PauseStartTime;
	local l_PauseEndTime_0 = Valentines2023.Leaderboards.Points.PauseEndTime;
	local l_LeaderboardEndTime_0 = Valentines2023.Leaderboards.Points.LeaderboardEndTime;
	local v35 = nil;
	if v29 < l_PauseStartTime_0 then
		v30 = false;
		v31 = l_PauseStartTime_0 - v29;
		v35 = "pausingSoon";
	elseif l_PauseStartTime_0 <= v29 and v29 < l_PauseEndTime_0 then
		v30 = true;
		v31 = l_PauseEndTime_0 - v29;
		v35 = "paused";
	elseif l_PauseEndTime_0 <= v29 and v29 <= l_LeaderboardEndTime_0 then
		v30 = false;
		v31 = l_LeaderboardEndTime_0 - v29;
		v35 = "endingSoon";
	elseif l_LeaderboardEndTime_0 <= v29 then
		v35 = "ended";
		v31 = 0;
	end;
	return v35, v31;
end;
v0.IsLiveEventLaunch = function(_) --[[ Line: 197 ]] --[[ Name: IsLiveEventLaunch ]]
	-- upvalues: Valentines2023 (copy)
	if not Valentines2023 then
		return nil;
	elseif Valentines2023.LiveLaunchEvent ~= nil then
		return true;
	else
		return false;
	end;
end;
v0.GetLiveEventTimeLeft = function(_) --[[ Line: 210 ]] --[[ Name: GetLiveEventTimeLeft ]]
	-- upvalues: v0 (copy), Valentines2023 (copy)
	if not v0:IsLiveEventLaunch() then
		warn("Not live event!");
		return nil;
	else
		local l_UnixTimestamp_0 = DateTime.now().UnixTimestamp;
		return Valentines2023.LiveLaunchEvent - l_UnixTimestamp_0;
	end;
end;
v0.OnEventStarted = function(_, v40) --[[ Line: 223 ]] --[[ Name: OnEventStarted ]]
	-- upvalues: v0 (copy), l_Generic_0 (copy)
	if v0:IsLiveEventLaunch() then
		if not v0:IsEventActive() then
			l_Generic_0.LiveEventStarted.Event:Connect(v40);
			return true;
		else
			v40();
			return true;
		end;
	elseif v0:IsEventActive() then
		v40();
		return true;
	else
		return false;
	end;
end;
v0.IsLeaderboardActive = function(_) --[[ Line: 240 ]] --[[ Name: IsLeaderboardActive ]]
	-- upvalues: Valentines2023 (copy), v0 (copy)
	if not Valentines2023.Leaderboards then
		return false;
	else
		local l_v0_LeaderboardStatus_0, _ = v0:GetLeaderboardStatus();
		if l_v0_LeaderboardStatus_0 == "pausingSoon" or l_v0_LeaderboardStatus_0 == "endingSoon" then
			return true;
		else
			return false;
		end;
	end;
end;
script:GetAttributeChangedSignal("CurrentEventState"):Connect(function() --[[ Line: 253 ]]
	-- upvalues: l_script_Attribute_0 (ref)
	l_script_Attribute_0 = script:GetAttribute("CurrentEventState");
end);
if Valentines2023 then
	table.freeze(Valentines2023);
end;
return v0; 