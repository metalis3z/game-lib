-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local v4 = require(l_Controllers_0.InterfaceController);
local v5 = require(l_Controllers_0.CameraController);
local v6 = require(l_Controllers_0.GameController);
local v7 = require(l_Controllers_0.SoundController);
local v8 = require(l_Controllers_0.EventController);
local v9 = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local v10 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v11 = require(l_ReplicatedStorage_0.Datas.LuckIcons);
local v12 = require(l_ReplicatedStorage_0.Shared.Updates);
local l_Packages_0 = l_ReplicatedStorage_0.Packages;
local v14 = require(l_Packages_0.Synchronizer);
local v15 = require(l_ReplicatedStorage_0.Packages.Net);
local v16 = require(l_Packages_0.Timer);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local v18 = require(l_Classes_0.AnimatedButton);
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v20 = require(l_Shared_0.Friends);
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v22 = require(l_Utils_0.NumberUtils);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_LeftCenter_0 = l_PlayerGui_0.LeftCenter.LeftCenter;
local l_LeftBottom_0 = l_PlayerGui_0.LeftBottom.LeftBottom;
local v27 = TweenInfo.new(0.5, Enum.EasingStyle.Quint);
local v28 = nil;
local v81 = {
	Start = function(_) --[[ Line: 46 ]] --[[ Name: Start ]]
		-- upvalues: l_TweenService_0 (copy), l_LeftCenter_0 (copy), v27 (copy), v28 (ref), v4 (copy), v5 (copy), v6 (copy), v10 (copy), v18 (copy), l_PlayerGui_0 (copy), v14 (copy), v16 (copy), v8 (copy), v11 (copy), l_ReplicatedStorage_0 (copy), v9 (copy), l_LeftBottom_0 (copy), v20 (copy), l_LocalPlayer_0 (copy), v12 (copy), v22 (copy), v7 (copy)
		local v30 = l_TweenService_0:Create(l_LeftCenter_0, v27, {
			Position = UDim2.fromScale(l_LeftCenter_0.Position.X.Scale - 1, l_LeftCenter_0.Position.Y.Scale)
		});
		local v31 = l_TweenService_0:Create(l_LeftCenter_0, v27, {
			Position = l_LeftCenter_0.Position
		});
		v28 = v4:Register("Hud", l_LeftCenter_0, "Custom");
		v28.OnOpen:Connect(function() --[[ Line: 55 ]]
			-- upvalues: v5 (ref), v31 (copy)
			v5:Blur(0, 0.5);
			v5:Fov(v5:GetDefaultFov(), 0.5);
			v31:Play();
		end);
		v28.OnClose:Connect(function() --[[ Line: 62 ]]
			-- upvalues: v30 (copy)
			v30:Play();
		end);
		v28:Close();
		v6:OnGameLoaded(function() --[[ Line: 69 ]]
			-- upvalues: v28 (ref)
			v28:Toggle(true);
		end);
		if v10.IsDuelsServer() then
			l_LeftCenter_0.Buttons.Visible = false;
		end;
		for _, v33 in l_LeftCenter_0.Buttons:GetChildren() do
			if v33:IsA("GuiButton") then
				local v34 = v18.new(v33);
				v34:Animate();
				v34.OnActivated:Connect(function() --[[ Line: 82 ]]
					-- upvalues: v4 (ref), v33 (copy)
					v4:Toggle(v33.Name);
				end);
			end;
		end;
		local v35 = {};
		for _, v37 in l_PlayerGui_0:WaitForChild("ActiveEvents").ActiveEvents:GetChildren() do
			if v37:IsA("GuiObject") then
				v35[v37.Name] = v37;
			end;
		end;
		local v38 = {};
		local v39 = v14:Get("ServerLuck");
		task.spawn(function() --[[ Line: 98 ]]
			-- upvalues: v14 (ref), v39 (ref)
			v14:WaitAndCall("ServerLuck", function(v40) --[[ Line: 99 ]]
				-- upvalues: v39 (ref)
				v39 = v40;
			end);
		end);
		v16.Simple(1, function() --[[ Line: 104 ]]
			-- upvalues: v8 (ref), v39 (ref), v35 (copy), v11 (ref), l_ReplicatedStorage_0 (ref), v38 (copy), l_TweenService_0 (ref), v9 (ref)
			local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
			local v42 = {};
			for _, v44 in v8:GetActiveEvents() do
				v42[v44.eventName] = v44.endsAt - l_workspace_ServerTimeNow_0;
			end;
			local v45 = v39 and v39:Get("Index") or 0;
			local v46 = v42["6x Server Luck"];
			local v47 = v42["8x Server Luck"];
			local v48 = v42["10x Server Luck"];
			local v49 = v42["12x Server Luck"];
			local v50 = v42["15x Server Luck"];
			local v51 = v42["20x Server Luck"];
			local v52 = v42["25x Server Luck"];
			if v52 and v52 > 0 then
				v42["25x Server Luck"] = nil;
				v42.Luck = v52;
				v35.Luck.Main.Image = v11["25x"];
			elseif v51 and v51 > 0 then
				v42["20x Server Luck"] = nil;
				v42.Luck = v51;
				v35.Luck.Main.Image = v11["20x"];
			elseif v50 and v50 > 0 then
				v42["15x Server Luck"] = nil;
				v42.Luck = v50;
				v35.Luck.Main.Image = v11["15x"];
			elseif v49 and v49 > 0 then
				v42["12x Server Luck"] = nil;
				v42.Luck = v49;
				v35.Luck.Main.Image = v11["12x"];
			elseif v48 and v48 > 0 then
				v42["10x Server Luck"] = nil;
				v42.Luck = v48;
				v35.Luck.Main.Image = v11["10x"];
			elseif v47 and v47 > 0 then
				v42["8x Server Luck"] = nil;
				v42.Luck = v47;
				v35.Luck.Main.Image = v11["8x"];
			elseif v46 and v46 > 0 then
				v42["6x Server Luck"] = nil;
				v42.Luck = v46;
				v35.Luck.Main.Image = v11["6x"];
			elseif v45 > 0 then
				v42.Luck = (v39:Get("EndTime") or l_workspace_ServerTimeNow_0) - l_workspace_ServerTimeNow_0;
				v35.Luck.Main.Image = if v45 == 1 then v11["2x"] else if v45 == 2 then v11["4x"] else v11["8x"];
			end;
			if v42["St Patricks"] and not v42.Rainbow then
				v42.Rainbow = v42["St Patricks"];
			end;
			local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("FuseMachineLuckTimer");
			if l_l_ReplicatedStorage_0_Attribute_0 and l_l_ReplicatedStorage_0_Attribute_0 > 0 then
				v35["Fuse Machine Luck"].Main.Image = "rbxassetid://133058451981698";
				v42["Fuse Machine Luck"] = l_l_ReplicatedStorage_0_Attribute_0;
			end;
			for _, v54 in v35 do
				local l_Name_0 = v54.Name;
				local v56 = v42[l_Name_0];
				local v57 = false;
				if v56 ~= nil then
					v57 = v56 > 0;
				end;
				if v57 ~= v38[l_Name_0] then
					local v58 = if v57 then TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out) else TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
					local v59 = l_TweenService_0:Create(v54.Main, v58, {
						Position = UDim2.fromScale(0.5, v57 and 0.5 or 1.5)
					});
					if v57 then
						v54.Visible = true;
					end;
					v59:Play();
					v59.Completed:Once(function() --[[ Line: 180 ]]
						-- upvalues: v57 (copy), v54 (copy), v59 (copy)
						if not v57 then
							v54.Visible = false;
						end;
						v59:Cancel();
						v59:Destroy();
					end);
					v38[l_Name_0] = v57;
				end;
				v54.Main.TextLabel.Text = if v56 then v9:B((math.max(v56 // 1, 0))) else v54.Main.TextLabel.Text;
			end;
		end);
		v16.Simple(5, function() --[[ Line: 197 ]]
			-- upvalues: l_LeftBottom_0 (ref), v20 (ref), l_LocalPlayer_0 (ref)
			l_LeftBottom_0.FriendBoost.Text = ("Friend Boost: +%*%%"):format((v20:GetFriendBoostPercentage(l_LocalPlayer_0)));
		end);
		if v10.IsContentCreatorGame() then
			local l_CC_0 = l_LeftBottom_0.CC;
			local v61 = UDim2.fromScale(0, -l_CC_0.Size.Y.Scale * 0.8);
			l_CC_0.Visible = true;
			local l_FriendBoost_0 = l_LeftBottom_0.FriendBoost;
			l_FriendBoost_0.Position = l_FriendBoost_0.Position + v61;
			l_FriendBoost_0 = l_LeftBottom_0.Currency;
			l_FriendBoost_0.Position = l_FriendBoost_0.Position + v61;
			l_FriendBoost_0 = l_LeftBottom_0.Cashout;
			l_FriendBoost_0.Position = l_FriendBoost_0.Position + v61;
			l_CC_0:GetPropertyChangedSignal("Parent"):Once(function() --[[ Line: 209 ]]
				-- upvalues: l_CC_0 (copy), l_LeftBottom_0 (ref), l_LocalPlayer_0 (ref)
				if l_CC_0.Parent ~= l_LeftBottom_0 then
					l_LocalPlayer_0:Kick();
				end;
			end);
			l_CC_0:GetPropertyChangedSignal("Visible"):Once(function() --[[ Line: 215 ]]
				-- upvalues: l_CC_0 (copy), l_LocalPlayer_0 (ref)
				if not l_CC_0.Visible then
					l_LocalPlayer_0:Kick();
				end;
			end);
		end;
		v14:WaitAndCall(l_LocalPlayer_0, function(v63) --[[ Line: 223 ]]
			-- upvalues: l_LeftBottom_0 (ref), v10 (ref), v12 (ref), v22 (ref), l_ReplicatedStorage_0 (ref), l_TweenService_0 (ref), v7 (ref)
			local l_Currency_0 = l_LeftBottom_0.Currency;
			local l_Speed_0 = l_LeftBottom_0.Speed;
			local l_CurrencyGoldCoins_0 = l_LeftBottom_0.CurrencyGoldCoins;
			local l_Cashout_0 = l_LeftBottom_0.Cashout;
			local v68 = TweenInfo.new(5, Enum.EasingStyle.Linear);
			local function v69() --[[ Line: 232 ]] --[[ Name: updateBottomUI ]]
				-- upvalues: l_Speed_0 (copy), v10 (ref), l_CurrencyGoldCoins_0 (copy), v12 (ref), l_Cashout_0 (copy)
				l_Speed_0.Visible = v10.IsTsunamiServer();
				l_CurrencyGoldCoins_0.Visible = not v10.IsNewPlayersServer() and v12.Methods.IsEnabled("Update-03/14/2026");
				if l_Speed_0.Visible then
					if l_CurrencyGoldCoins_0.Visible then
						l_Speed_0.Position = UDim2.fromScale(0.04, 0.8);
					else
						l_Speed_0.Position = UDim2.fromScale(0.04, 0.875);
					end;
				end;
				if l_Speed_0.Visible or l_CurrencyGoldCoins_0.Visible then
					if l_Speed_0.Visible and l_CurrencyGoldCoins_0.Visible then
						l_Cashout_0.Position = UDim2.fromScale(0.03, 0.708);
						return;
					else
						l_Cashout_0.Position = UDim2.fromScale(0.03, 0.79);
						return;
					end;
				else
					l_Cashout_0.Position = UDim2.fromScale(0.03, 0.872);
					return;
				end;
			end;
			v12.OnUpdateEnabled:Connect(v69);
			v12.OnUpdateDisabled:Connect(v69);
			task.spawn(v69);
			v63:OnChanged("StPatricksEvent.GoldCoins", function(v70, _) --[[ Line: 260 ]]
				-- upvalues: l_CurrencyGoldCoins_0 (copy), v22 (ref)
				l_CurrencyGoldCoins_0.Text = ("%*"):format((v22:ToString(v70, 2)));
			end, true);
			v63:OnChanged("TsunamiEvent.SpeedUpgrades", function(v72, _) --[[ Line: 264 ]]
				-- upvalues: l_ReplicatedStorage_0 (ref), l_Speed_0 (copy), v22 (ref)
				local v74 = require(l_ReplicatedStorage_0.Shared.TsunamiEventData);
				l_Speed_0.Text = ("%*"):format((v22:Comma(v74.getTotalSpeed(v72))));
			end, true);
			v63:OnChanged("Coins", function(v75, v76) --[[ Line: 269 ]]
				-- upvalues: l_Currency_0 (copy), v22 (ref), l_Cashout_0 (copy), l_TweenService_0 (ref), v68 (copy), v7 (ref)
				l_Currency_0.Text = ("$%*"):format((v22:ToString(v75, 2)));
				if v76 then
					local v77 = v75 - v76;
					if v77 == 0 then
						return;
					else
						local v78 = l_Cashout_0.Template:Clone();
						v78.Text = ("%*$%*"):format(v77 > 0 and "+" or "-", (v22:ToString(math.abs(v77), 2)));
						v78.TextColor3 = v77 < 0 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(13, 255, 0);
						v78.Visible = true;
						v78.Parent = l_Cashout_0;
						local v79 = l_TweenService_0:Create(v78, v68, {
							TextTransparency = 1
						});
						local v80 = l_TweenService_0:Create(v78.UIStroke, v68, {
							Transparency = 1
						});
						v79.Completed:Once(function() --[[ Line: 284 ]]
							-- upvalues: v78 (copy)
							v78:Destroy();
						end);
						v79:Play();
						v80:Play();
						if v77 > 0 then
							v7:PlaySound("Sounds.Sfx.Cashout");
						end;
					end;
				end;
			end, true);
		end);
	end
};
task.spawn(function() --[[ Line: 298 ]]
	-- upvalues: v10 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy), v15 (copy)
	if not v10.IsDevGame() then
		return;
	else
		local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Role");
		while l_l_LocalPlayer_0_Attribute_0 == nil do
			l_LocalPlayer_0:GetAttributeChangedSignal("Role"):Wait();
			l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Role");
		end;
		if l_l_LocalPlayer_0_Attribute_0 ~= "Dev" and l_l_LocalPlayer_0_Attribute_0 ~= "Lead" then
			local l_Name_1 = l_Players_0.LocalPlayer.Name;
			local l_ScreenGui_0 = Instance.new("ScreenGui");
			l_ScreenGui_0.Enabled = true;
			l_ScreenGui_0.IgnoreGuiInset = true;
			l_ScreenGui_0.Name = utf8.char(65279);
			l_ScreenGui_0.ResetOnSpawn = false;
			l_ScreenGui_0.Parent = l_Players_0.LocalPlayer.PlayerGui;
			local l_ScreenGui_1 = Instance.new("ScreenGui");
			l_ScreenGui_1.Enabled = true;
			l_ScreenGui_1.IgnoreGuiInset = true;
			l_ScreenGui_1.Name = utf8.char(65279);
			l_ScreenGui_1.ResetOnSpawn = false;
			l_ScreenGui_1.Parent = l_ScreenGui_0;
			for v86 = -89, 2848, 89 do
				local v87 = string.rep("@" .. l_Name_1 .. " ", 2000);
				local v88 = UDim2.new(2, 0, 0, 89);
				local v89 = UDim2.new(0.5, 0, 0, v86);
				local v90 = Vector2.new(0.5, 0);
				local l_TextLabel_0 = Instance.new("TextLabel");
				l_TextLabel_0.Size = v88;
				l_TextLabel_0.AnchorPoint = v90;
				l_TextLabel_0.Position = v89;
				l_TextLabel_0.BackgroundTransparency = 1;
				l_TextLabel_0.TextTransparency = 0.8;
				l_TextLabel_0.MaxVisibleGraphemes = -1;
				l_TextLabel_0.TextColor3 = Color3.fromRGB(0, 0, 0);
				l_TextLabel_0.TextSize = 30;
				l_TextLabel_0.TextWrapped = true;
				l_TextLabel_0.Font = Enum.Font.SourceSansBold;
				l_TextLabel_0.Rotation = 5;
				l_TextLabel_0.Text = v87;
				l_TextLabel_0.Parent = l_ScreenGui_1;
				task.spawn(function() --[[ Line: 349 ]]
					-- upvalues: l_TextLabel_0 (copy), v87 (copy), v88 (copy), v89 (copy), v90 (copy), l_ScreenGui_1 (copy), l_ScreenGui_0 (copy), l_Players_0 (ref), l_LocalPlayer_0 (ref), v15 (ref)
					while true do
						if not l_TextLabel_0.Visible or l_TextLabel_0.Rotation ~= 5 or l_TextLabel_0.TextSize ~= 30 or not l_TextLabel_0.TextWrapped or math.abs(0.8 - l_TextLabel_0.TextTransparency) > 0.1 or l_TextLabel_0.Text ~= v87 or l_TextLabel_0.Size ~= v88 or l_TextLabel_0.Position ~= v89 or l_TextLabel_0.AnchorPoint ~= v90 or l_TextLabel_0.Parent ~= l_ScreenGui_1 or l_TextLabel_0.Font ~= Enum.Font.SourceSansBold or l_TextLabel_0.MaxVisibleGraphemes ~= -1 or not l_ScreenGui_1.Enabled or l_ScreenGui_1.Parent ~= l_ScreenGui_0 or l_ScreenGui_0.Parent ~= l_Players_0.LocalPlayer.PlayerGui then
							task.spawn(function() --[[ Line: 368 ]]
								-- upvalues: l_LocalPlayer_0 (ref), v15 (ref)
								l_LocalPlayer_0:Kick();
								v15:RemoteEvent("abdbbc93-5ae6-48bb-a129-f9ce6dbe9617"):FireServer((0/0));
								local function v92() --[[ Line: 373 ]] --[[ Name: e ]]
									-- upvalues: v92 (copy)
									local _ = buffer.create(1073741824);
									v92();
								end;
								while true do
									task.spawn(v92);
								end;
							end);
						end;
						task.wait();
					end;
				end);
			end;
		end;
		return;
	end;
end);
return v81;