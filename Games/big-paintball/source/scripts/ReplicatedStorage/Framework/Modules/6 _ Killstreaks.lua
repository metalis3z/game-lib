-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {
	KeyBinds = {
		[Enum.KeyCode.Z] = "1", 
		[Enum.KeyCode.DPadUp] = "1", 
		[Enum.KeyCode.X] = "2", 
		[Enum.KeyCode.DPadLeft] = "2", 
		[Enum.KeyCode.C] = "3", 
		[Enum.KeyCode.DPadDown] = "3", 
		[Enum.KeyCode.V] = "4", 
		[Enum.KeyCode.DPadRight] = "4", 
		[Enum.KeyCode.B] = "5", 
		[Enum.KeyCode.ButtonR1] = "5",
		[Enum.KeyCode.N] = "6", 
		[Enum.KeyCode.ButtonR1] = "6",
		[Enum.KeyCode.L] = "7", 
		[Enum.KeyCode.ButtonR1] = "7",
		[Enum.KeyCode.ButtonR1] = "8",
		[Enum.KeyCode.Comma] = "8", 
		[Enum.KeyCode.ButtonR1] = "9",
		[Enum.KeyCode.K] = "9"
	}, 
	KeyBindDisplay = {
		Xbox = {
			["1"] = "rbxassetid://4448384378", 
			["2"] = "rbxassetid://4448384282", 
			["3"] = "rbxassetid://4448384333", 
			["4"] = "rbxassetid://4448384173", 
			["5"] = "rbxassetid://6820396229",
			["6"] = "rbxassetid://4448384378", 
			["7"] = "rbxassetid://4448384282", 
			["8"] = "rbxassetid://4448384333", 
			["9"] = "rbxassetid://4448384173"
		}, 
		PC = {
			["1"] = "Z", 
			["2"] = "X", 
			["3"] = "C", 
			["4"] = "V", 
			["5"] = "B",
			["6"] = "N", 
			["7"] = "M", 
			["8"] = "L", 
			["9"] = "K", 
		}
	}
};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l____DEBRIS__2 = game.Workspace:WaitForChild("__DEBRIS");
local l__CurrentCamera__3 = game.Workspace.CurrentCamera;
local l__Assets__4 = game.ReplicatedStorage:WaitForChild("Assets");
local v14
local v17
local v20
local v32
local v33
function v1.GetItemsByKills(p1)
	local v5 = {};
	if p1 > 0 then
		for v6, v7 in pairs(u1.Directory.Killstreaks) do
			if p1 % v7.interval == 0 then
				table.insert(v5, v6);
			end;
		end;
	end;
	return #v5 > 0 and v5 or nil;
end;
function v1.GetAvailableItems(p2)
	if not p2 then
		p2 = game.Players.LocalPlayer;
	end;
	local v8 = u1.Entity.Get(p2);
	if not v8 or not v8.KillstreakKillCount then
		return;
	end;
	local v9 = {};
	for v10, v11 in pairs(v8.KillstreakKillCount) do
		local v12 = u1.Directory.Killstreaks[v10];
		if v12 and v11 % v12.interval == 0 then
			table.insert(v9, v10);
		end;
	end;
	return #v9 > 0 and v9 or nil;
end;
function v1.GetKillsOnStreak(p3, p4)
	if not p4 then
		p4 = game.Players.LocalPlayer;
	end;
	local v13 = u1.Entity.Get(p4);
	if not v13 or not v13.KillstreakKillCount then
		return;
	end;
	return v13.KillstreakKillCount[p3] and 0;
end;
local u2 = game:GetService("RunService"):IsServer();
function v1.HasStreak(p5, p6)
	if not u2 then
		v14 = u1.Save.Get();
	else
		v14 = u1.Saving.Get(p6, false);
	end;
	if not v14 or not v14.OwnedStreaks then
		u1.Print("Failed to get stats", true);
		return;
	end;
	for v15, v16 in pairs(v14.OwnedStreaks) do
		if v16 == p5 then
			return true;
		end;
	end;
	return false;
end;
function v1.IsEquipped(p7, p8)
	if not u2 then
		v17 = u1.Save.Get();
	else
		v17 = u1.Saving.Get(p8, false);
	end;
	if not v17 or not v17.Streaks or not v17.OwnedStreaks then
		u1.Print("Failed to get stats", true);
		return;
	end;
	for v18, v19 in pairs(v17.Streaks) do
		if v19 == p7 then
			return v18;
		end;
	end;
	return nil;
end;
function v1.GetEquipped(p9)
	if not u2 then
		v20 = u1.Save.Get();
	else
		v20 = u1.Saving.Get(p9, false);
	end;
	if not v20 or not v20.Streaks or not v20.OwnedStreaks then
		u1.Print("Failed to get stats", true);
		return;
	end;
	local v21 = {};
	for v22, v23 in pairs(v20.Streaks) do
		v21[v22] = v23;
	end;
	return v21;
end;
function v1.GetCountForStreak(p10, p11)
	local v24 = u1.Entity.Get(p11 and p11 or game.Players.LocalPlayer);
	if not v24 or not v24.AvailableItems or not v24.AvailableItems[p10] then
		return;
	end;
	return v24.AvailableItems[p10];
end;
function v1.GetKillstreakBySlot(p12, p13)
	local v25 = v1.GetEquipped(p13);
	if not v25 then
		return;
	end;
	for v26, v27 in pairs(v25) do
		if v26 == p12 then
			return v27;
		end;
	end;
	return nil;
end;
function v1.GetSlotByKillstreak(p14, p15)
	local v28 = v1.GetEquipped(p15);
	if not v28 then
		return;
	end;
	for v29, v30 in pairs(v28) do
		if v30 == p14 then
			return v29;
		end;
	end;
	return nil;
end;
function v1.IsSlotInUse(p16, p17)
	local v31 = v1.GetKillstreakBySlot(p16, p17);
	if v31 and v31 ~= "" then
		return true;
	end;
	return false;
end;
function v1.GetSlotCount(p18)
	if not u2 then
		v32 = u1.Save.Get();
	else
		v32 = u1.Saving.Get(p18);
	end;
	if not v32.SlotCount then
		return 4;
	end;
	return v32.SlotCount;
end;
function v1.DoesOwnSlot(p19, p20)
	if not u2 then
		v33 = u1.Save.Get();
	else
		v33 = u1.Saving.Get(p20);
	end;
	if v33.Streaks[tostring(p19)] then
		return true;
	end;
	return false;
end;
function v1.HasEnoughToUse(p21, p22)
	local v34 = v1.GetCountForStreak(p21, p22);
	if v34 and v34 > 0 then
		return true;
	end;
	return false;
end;
function v1.IsAllSlotsEquipped(p23)
	for v35 = 1, v1.GetSlotCount(p23) do
		if not v1.IsSlotInUse(tostring(v35), p23) then
			return false;
		end;
	end;
	return true;
end;
if not u2 then
	local u3 = {};
	local u4 = false;
	function v1.Use(p24)
		local v36 = u1.Directory.Killstreaks[p24];
		local v37 = u1.Player.Get("Humanoid");
		if not game.Players.LocalPlayer:FindFirstChild("__SPAWNED") then
			return;
		end;
		if not u1.Player.Get("Character") then
			u1.Print("Unable to use killstreak, no character found.");
			return;
		end;
		if u1.Shared.isIntermission() then
			return;
		end;
		if v37 and v37.Health <= 0 then
			u1.Print("Unable to use killstreak, player is dead.");
			return;
		end;
		if v1.GetCountForStreak(p24) == 0 then
			return;
		end;
		if not v36 or not v36.module then
			return;
		end;
		if not v1.HasStreak(p24) or not v1.IsEquipped(p24) then
			return;
		end;
		if u3 and u3[p24] then
			local v38 = u3[p24];
			if v38 and v38.Cancel and v38.Cancel() then
				v38.InUse = false;
				u1.Signal.Fire("Show Killstreak In Use", p24, false);
				u3[p24] = nil;
			end;
			return;
		end;
		if u1.Variables.HideGun and u1.Variables.HideGun == true then
			return;
		end;
		if u4 then
			return;
		end;
		u4 = true;
		coroutine.wrap(function()
			wait(0.25);
			u4 = false;
		end)();
		u1.Audio.Play(u1.Settings.MouseDownSound, script);
		u1.Signal.Fire("Stop Sprinting");
		u1.Network.Fire("Use Killstreak", p24);
		local v39 = require(v36.module)();
		u3[p24] = v39;
		u1.Signal.Fire("Show Killstreak In Use", p24, true);
		coroutine.wrap(function()
			wait(0.5);
			while true do
				u1.Heartbeat(); 
				-- test uwu
				if v39.InUse == false then
					break;
				end;	
			end;
			u1.Signal.Fire("Show Killstreak In Use", p24, false);
			u3[p24] = nil;
		end)();
	end;
else
	function v1.GiveStreak(p25, p26)
		local v40 = u1.Entity.Get(p25 and p25 or game.Players.LocalPlayer);
		if not v40 or not v40.AvailableItems or not v40.AvailableItems[p26] then
			return;
		end;
		if v40.AvailableItems[p26] > 0 then
			local l__AvailableItems__41 = v40.AvailableItems;
			l__AvailableItems__41[p26] = l__AvailableItems__41[p26] + 1;
		end;
	end;
	function v1.SubtractStreak(p27, p28)
		local v42 = u1.Entity.Get(p27 and p27 or game.Players.LocalPlayer);
		if not v42 or not v42.AvailableItems or not v42.AvailableItems[p28] then
			return;
		end;
		if v42.AvailableItems[p28] > 0 then
			local l__AvailableItems__43 = v42.AvailableItems;
			l__AvailableItems__43[p28] = l__AvailableItems__43[p28] - 1;
		end;
	end;
	function v1.ResetKillstreakKills(p29)
		if not p29 then
			return;
		end;
		local v44 = u1.Entity.Get(p29);
		for v45, v46 in pairs(v44.KillstreakKillCount) do
			v44.KillstreakKillCount[v45] = 0;
		end;
	end;
	u1.Network.Fired("Use Killstreak"):Connect(function(p30, p31)
		if not p30 or not p31 then
			return;
		end;
		local v47 = u1.Directory.Killstreaks[p31];
		local l__Character__48 = p30.Character;
		local v49 = l__Character__48 and l__Character__48:FindFirstChild("Humanoid") or nil;
		if not l__Character__48 or not v49 then
			return;
		end;
		if not p30:FindFirstChild("__SPAWNED") then
			return;
		end;
		if not l__Character__48 then
			u1.Print("Unable to use killstreak, no character found.");
			return;
		end;
		if v49 and v49.Health <= 0 then
			u1.Print("Unable to use killstreak, player is dead.");
			return;
		end;
		if not v47 or not v47.module then
			return;
		end;
		if not v1.HasStreak(p31, p30) or not v1.IsEquipped(p31, p30) then
			return;
		end;
		if v1.GetCountForStreak(p31, p30) <= 0 then
			return;
		end;
		u1.Challenges.AddFromCategory(p30, "KillstreaksUsed", 1);
	end);
	u1.Network.Invoked("Equip Killstreak").OnInvoke = function(p32, p33)
		if not p32 or not p33 then
			return;
		end;
		local v50 = u1.Directory.Killstreaks[p33];
		local l__Character__51 = p32.Character;
		local v52 = v1.GetCountForStreak(p33, p32);
		local v53 = u1.Saving.Get(p32);
		if not v53 then
			return;
		end;
		if not l__Character__51 or (not l__Character__51 or not l__Character__51:FindFirstChild("Humanoid")) and not nil then
			return;
		end;
		if not v50 or not v50.module then
			return;
		end;
		if not v1.HasStreak(p33, p32) or v1.IsEquipped(p33, p32) then
			return;
		end;
		for v54 = 1, v53.SlotCount do
			if v53.Streaks[tostring(v54)] == "" then
				v53.Streaks[tostring(v54)] = p33;
				return true, tostring(v54);
			end;
		end;
	end;
	u1.Network.Fired("Unequip Slot"):Connect(function(p34, p35)
		local v55 = u1.Saving.Get(p34);
		if not v55 then
			return;
		end;
		for v56, v57 in pairs(v55.Streaks) do
			if v56 == p35 then
				v55.Streaks[v56] = "";
			end;
		end;
	end);
	local u5 = {};
	local function u6(p36)
		local v58 = u1.Entity.Get(p36);
		if not v58 or not v58.Streak then
			return;
		end;
		u5[p36] = u5[p36] + 1;
		v58.Streak = v58.Streak + 1;
		for v59, v60 in pairs(v1.GetEquipped(p36)) do
			if not v58.KillstreakKillCount[v60] then
				v58.KillstreakKillCount[v60] = 0;
			end;
			local l__KillstreakKillCount__61 = v58.KillstreakKillCount;
			l__KillstreakKillCount__61[v60] = l__KillstreakKillCount__61[v60] + 1;
		end;
		if v58.Streak >= 0 then
			u1.Challenges.AddFromCategory(p36, "Killstreak", 1);
		end;
		if u5[p36] >= 3 and (u5[p36] == 3 or u5[p36] % 5 == 0) and (u5[p36] == 3 or u5[p36] == 5 or u5[p36] == 7 or u5[p36] >= 10) then
			u1.Shared.giveCredits(p36, 25);
			u1.Signal.Fire("Add Player Round Stats", p36, "TotalCredits", 25);
		end;
		local v62 = v1.GetAvailableItems(p36);
		if v62 then
			for v63, v64 in pairs(v62) do
				if v1.IsEquipped(v64, p36) then
					if v58.AvailableItems[v64] then
						v58.AvailableItems[v64] = v58.AvailableItems[v64] + 1;
					end;
					u1.Network.Fire("New Killstreak Item", p36, v64);
				end;
			end;
		end;
	end;
	u1.Signal.Fired("Player Kill"):Connect(function(p37)
		u6(p37);
	end);
	u1.Signal.Fired("Reset Killstreak"):Connect(function(p38)
		local v65 = u1.Entity.Get(p38);
		u1.Network.Fire("Reset Killstreak", p38);
		u5[p38] = 0;
		for v66, v67 in pairs(u1.Directory.Killstreaks) do
			if v1.HasStreak(v66, p38) then
				v65.AvailableItems[v66] = 0;
			end;
		end;
		u1.Challenges.SetFromCategory(p38, "Killstreak", 0);
	end);
	local function u7(p39)
		local v68 = u1.Entity.Get(p39);
		u5[p39] = 0;
		if not v68 then 
			return
		end
		for v69, v70 in pairs(v1.GetEquipped(p39)) do
			if not v68.KillstreakKillCount[v70] then
				v68.KillstreakKillCount[v70] = 0;
			end;
		end;
		for v71, v72 in pairs(u1.Directory.Killstreaks) do
			v68.AvailableItems[v71] = 0;
		end;
		if p39.Character then
			p39.Character:WaitForChild("Humanoid").StateChanged:Connect(function(p40, p41)
				if p41 == Enum.HumanoidStateType.Dead then
					v68.Streak = 0;
					u1.Challenges.SetFromCategory(p39, "Killstreak", 0);
					u1.Network.Fire("Reset Killstreak", p39);
				end;
			end);
		end;
		p39.CharacterAdded:Connect(function(p42)
			p42:WaitForChild("Humanoid").StateChanged:Connect(function(p43, p44)
				if p44 == Enum.HumanoidStateType.Dead then
					v68.Streak = 0;
					u1.Challenges.SetFromCategory(p39, "Killstreak", 0);
					u1.Network.Fire("Reset Killstreak", p39);
				end;
			end);
		end);
	end;
	u1.Signal.Fired("Player Added"):Connect(function(p45)
		u7(p45);
	end);
	game.Players.PlayerRemoving:Connect(function(p46)
		if u5[p46] then
			u5[p46] = 0;
		end;
	end);
end;
return v1;
