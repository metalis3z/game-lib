-- Decomplie by Fayple Studios (Join for Best Games Files) https://discord.gg/p3MdGT5Nzc




local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Asserts__3 = require(l__ReplicatedStorage__2.UserGenerated.Lang.Asserts);
local l__ClientEventUtils__4 = require(l__ReplicatedStorage__2.Controllers.EventController.ClientEventUtils);
local l__CountryFlagIcons__5 = require(l__ReplicatedStorage__2.Shared.Flags.CountryFlagIcons);
local l__FastFlags__6 = require(l__ReplicatedStorage__2.UserGenerated.FastFlags);
local l__HudController__7 = require(l__ReplicatedStorage__2.Controllers.HudController);
local l__Net__8 = require(l__ReplicatedStorage__2.Packages.Net);
local l__Observers__9 = require(l__ReplicatedStorage__2.Packages.Observers);
local l__ReplicatorClient__10 = require(l__ReplicatedStorage__2.Packages.ReplicatorClient);
local l__Trove__11 = require(l__ReplicatedStorage__2.Packages.Trove);
local l__Traits__12 = require(l__ReplicatedStorage__2.Datas.Traits);
local u1 = l__Net__8:RemoteEvent("LiveSoccerEvent/Burst");
local u2 = l__Net__8:RemoteEvent("LiveSoccerEvent/MiniEvent");
local u3 = l__ReplicatorClient__10.get("LiveSoccerMatches");
local u4 = l__FastFlags__6.Replicated("LiveSoccerEvent.ScoreBoardHidden", l__Asserts__3.Boolean, false);
local u5 = {};
local function u10(p6) --[[ Line: 64 ]]
	local v7 = DateTime.fromUnixTimestamp(p6):ToLocalTime();
	local v8 = v7.Hour >= 12 and "PM" or "AM";
	local v9 = v7.Hour % 12;
	return string.format("%d:%02d %s", v9 == 0 and 12 or v9, v7.Minute, v8);
end;
local function u23(p11) --[[ Line: 88 ]]
	local displayMatches = {};
	for _, m in p11 do
		if m.status == "live" or m.status == "halftime" or m.status == "upcoming" then
			table.insert(displayMatches, m);
		end;
	end;
	return displayMatches;
end;
return {
	Start = function(_) --[[ Name: Start, Line 125 ]]
		-- upvalues: u1 (copy), l__ClientEventUtils__4 (copy), l__ReplicatedStorage__2 (copy), u2 (copy), l__HudController__7 (copy), u5 (copy), l__FastFlags__6 (copy), l__Asserts__3 (copy), l__Traits__12 (copy), l__Observers__9 (copy), l__Trove__11 (copy), l__Players__1 (copy), l__CountryFlagIcons__5 (copy), u10 (copy), u3 (copy), u23 (copy), u4 (copy)
		u1.OnClientEvent:Connect(function(p24, p25) --[[ Line: 126 ]]
			-- upvalues: l__ClientEventUtils__4 (ref), l__ReplicatedStorage__2 (ref)
			local burstVfx = l__ReplicatedStorage__2.Vfx.LiveSoccerBursts[p25];
			if burstVfx then
				l__ClientEventUtils__4.playBurst(burstVfx, p24, { l__ReplicatedStorage__2.Sounds.Events.LiveSoccer.Burst });
			end;
		end);
		u2.OnClientEvent:Connect(function(p26, p27) --[[ Line: 134 ]]
			-- upvalues: l__HudController__7 (ref), u5 (ref), l__FastFlags__6 (ref), l__Asserts__3 (ref), l__Traits__12 (ref)
			local v28 = l__HudController__7;
			local v29 = "LiveSoccer";
			local v30 = u5[p26];
			if v30 == nil then
				v30 = l__FastFlags__6.Replicated("LiveSoccerEvent.FlagIconOverride." .. p26, l__Asserts__3.String, "");
				u5[p26] = v30;
			end;
			local v31 = v30:Get();
			if v31 == "" then
				local v32 = l__Traits__12[p26];
				v31 = not v32 and "" or v32.Icon;
			end;
			v28:ShowFakeEvent(v29, p27, v31);
		end);
		l__Observers__9.observeTag("SoccerScoreBoard", function(u33) --[[ Line: 138 ]]
			-- upvalues: l__Trove__11 (ref), l__Players__1 (ref), u5 (ref), l__FastFlags__6 (ref), l__Asserts__3 (ref), l__CountryFlagIcons__5 (ref), u10 (ref), u3 (ref), u23 (ref), u4 (ref)
			local v34 = l__Trove__11.new();
			local l__Main__14 = u33.Main;
			local l__SoccerScoreBoard__15 = l__Main__14.SoccerScoreBoard;
			l__SoccerScoreBoard__15.Adornee = l__Main__14;
			l__SoccerScoreBoard__15.Parent = l__Players__1.LocalPlayer.PlayerGui;
			v34:Add(l__SoccerScoreBoard__15);
			local l__Container__16 = l__SoccerScoreBoard__15.Container;
			local l__Template__17 = l__Container__16.UIListLayout.Template;
			local l__Upcoming__18 = l__Container__16.Upcoming;
			local l__LiveNow__19 = l__Container__16.LiveNow;
			l__Template__17.Visible = false;
			l__Upcoming__18.Visible = false;
			l__LiveNow__19.Visible = false;
			for _, v35 in l__Container__16:GetChildren() do
				if v35.Name == "Match" then
					v35:Destroy();
				end;
			end;
			local u36 = v34:Extend();
			local u37 = {};
			local u38 = false;
			local function u48(p39, p40) --[[ Line: 165 ]]
				-- upvalues: u5 (ref), l__FastFlags__6 (ref), l__Asserts__3 (ref), l__CountryFlagIcons__5 (ref), u10 (ref)
				p39.Country1.Text = p40.homeName;
				p39.Country2.Text = p40.awayName;
				local l__Country1Flag__20 = p39.Country1Flag;
				local l__homeName__21 = p40.homeName;
				local v41 = u5[l__homeName__21];
				if v41 == nil then
					v41 = l__FastFlags__6.Replicated("LiveSoccerEvent.FlagIconOverride." .. l__homeName__21, l__Asserts__3.String, "");
					u5[l__homeName__21] = v41;
				end;
				local v42 = v41:Get();
				if v42 == "" then
					local v43 = l__CountryFlagIcons__5.Normal[l__homeName__21];
					v42 = not v43 and "" or `rbxassetid://{v43}`;
				end;
				l__Country1Flag__20.Image = v42;
				local l__Country2Flag__22 = p39.Country2Flag;
				local l__awayName__23 = p40.awayName;
				local v44 = u5[l__awayName__23];
				if v44 == nil then
					v44 = l__FastFlags__6.Replicated("LiveSoccerEvent.FlagIconOverride." .. l__awayName__23, l__Asserts__3.String, "");
					u5[l__awayName__23] = v44;
				end;
				local v45 = v44:Get();
				if v45 == "" then
					local v46 = l__CountryFlagIcons__5.Normal[l__awayName__23];
					v45 = not v46 and "" or `rbxassetid://{v46}`;
				end;
				l__Country2Flag__22.Image = v45;
				local l__status__24 = p40.status;
				local v47 = l__status__24 == "live" and true or l__status__24 == "halftime";
				p39.Timer.Visible = v47;
				p39.Score.Visible = v47;
				p39.Time.Visible = not v47;
				if v47 then
					p39.Timer.Text = tostring(p40.matchMinute);
					p39.Score.Text = string.format("%d - %d", p40.homeScore, p40.awayScore);
				else
					p39.Time.Text = u10(p40.startUtcSeconds);
				end;
			end;
			local function u73() --[[ Line: 184 ]]
				-- upvalues: u38 (ref), u36 (copy), u3 (ref), u23 (ref), u37 (copy), l__Upcoming__18 (copy), l__Container__16 (copy), l__LiveNow__19 (copy), l__Template__17 (copy), u48 (copy)
				if u38 then
				else
					u36:Clean();
					local v49 = u3:TryIndex({ "matches" });
					local v50 = not v49 and {} or u23(v49);
					if #v50 == 0 then
						for v51, v52 in u37 do
							v52:Destroy();
							u37[v51] = nil;
						end;
						local v53 = u36:Clone(l__Upcoming__18);
						v53.Text = "No Live Matches";
						v53.LayoutOrder = 0;
						v53.Visible = true;
						v53.Parent = l__Container__16;
					else
						table.sort(v50, function(p54, p55) --[[ Line: 206 ]]
							if p54.startUtcSeconds == p55.startUtcSeconds then
								return p54.matchId < p55.matchId;
							else
								return p54.startUtcSeconds < p55.startUtcSeconds;
							end;
						end);
						local v56 = os.time();
						local v57 = 1;
						local v58 = 0;
						local v59 = {};
						while v57 <= #v50 do
							local l__startUtcSeconds__25 = v50[v57].startUtcSeconds;
							local v60 = {};
							local v61 = false;
							while v57 <= #v50 and v50[v57].startUtcSeconds == l__startUtcSeconds__25 do
								local v62 = v50[v57];
								table.insert(v60, v62);
								local l__status__26 = v62.status;
								v61 = (l__status__26 == "live" and true or l__status__26 == "halftime") and true or v61;
								v57 = v57 + 1;
							end;
							if v61 then
								local v63 = u36:Clone(l__LiveNow__19);
								v63.Visible = true;
								v63.LayoutOrder = v58;
								v63.Parent = l__Container__16;
							else
								local v64 = u36:Clone(l__Upcoming__18);
								local v65 = math.max(l__startUtcSeconds__25 - v56, 0);
								local v66 = math.floor(v65 / 3600);
								local v67 = math.floor(v65 % 3600 / 60);
								local v68;
								if v66 > 0 then
									v68 = string.format("STARTING IN: %dh %dm", v66, v67);
								else
									v68 = string.format("STARTING IN: %dm", v67);
								end;
								v64.Text = v68;
								v64.Visible = true;
								v64.LayoutOrder = v58;
								v64.Parent = l__Container__16;
							end;
							v58 = v58 + 1;
							for _, v69 in v60 do
								v59[v69.matchId] = true;
								local v70 = u37[v69.matchId];
								if not v70 then
									v70 = l__Template__17:Clone();
									v70.Visible = true;
									v70.Parent = l__Container__16;
									u37[v69.matchId] = v70;
								end;
								v70.LayoutOrder = v58;
								v58 = v58 + 1;
								u48(v70, v69);
							end;
						end;
						for v71, v72 in u37 do
							if not v59[v71] then
								v72:Destroy();
								u37[v71] = nil;
							end;
						end;
					end;
				end;
			end;
			local function v75() --[[ Line: 268 ]]
				-- upvalues: u38 (ref), u4 (ref), l__SoccerScoreBoard__15 (copy), u33 (copy), u73 (copy)
				u38 = u4:Get();
				l__SoccerScoreBoard__15.Enabled = not u38;
				for _, v74 in u33:GetDescendants() do
					if v74:IsA("BasePart") then
						v74.LocalTransparencyModifier = u38 and 1 or 0;
					end;
				end;
				if not u38 then
					u73();
				end;
			end;
			local u76 = u4.Changed:Connect(v75);
			v34:Add(function() --[[ Line: 282 ]]
				-- upvalues: u76 (copy)
				u76:Disconnect();
			end);
			v34:Add(u3:Listen({ "matches" }, u73));
			v34:Add(task.spawn(function() --[[ Line: 287 ]]
				-- upvalues: u73 (copy)
				while true do
					u73();
					task.wait(1);
				end;
			end));
			v75();
			return v34:WrapClean();
		end, { workspace });
	end
};