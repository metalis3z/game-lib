-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SurvivorRequests, time of decompilation: Fri Nov 28 21:12:46 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.GlobalTypes);
local v3 = require(l_ReplicatedStorage_0.Modules.Util);
local v4 = require(l_ReplicatedStorage_0.Modules.Actors);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Misc.CharacterHovering);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = {
	Connections = {}
};
local _ = function(v9) --[[ Line: 24 ]] --[[ Name: hasTruthy ]]
	if not v9 then
		return false;
	else
		for _, v11 in pairs(v9) do
			if v11 then
				return true;
			end;
		end;
		return false;
	end;
end;
local function _(v13) --[[ Line: 37 ]] --[[ Name: getActorInfo ]]
	-- upvalues: l_Players_0 (copy), v4 (copy)
	local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v13);
	local v15 = v4.CurrentActors[l_l_Players_0_PlayerFromCharacter_0];
	if v15 then
		return v15;
	else
		return;
	end;
end;
v8.Start = function(_) --[[ Line: 47 ]] --[[ Name: Start ]]
	-- upvalues: l_LocalPlayer_0 (copy), v8 (copy), v5 (copy), v4 (copy), l_Players_0 (copy), l_ReplicatedStorage_0 (copy), v3 (copy), v6 (copy)
	local l_Character_0 = l_LocalPlayer_0.Character;
	if not v8.Initialized then
		v8.Initialized = true;
		v5:SetConnection("SurvivorRequested", "REMOTE_EVENT", function(v19, v20) --[[ Line: 53 ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref)
			local v21 = v4.CurrentActors[l_LocalPlayer_0];
			local v22 = v4.CurrentActors[v19];
			local v23 = nil;
			if v22 and v22.Config.Requesting and v22.Config.Requesting[v20] then
				v23 = v22.Config.Requesting[v20];
			elseif v21 and v21.Config.Requests and v21.Config.Requests[v20] then
				v23 = v21.Config.Requests[v20];
			end;
			local l_Character_1 = v19.Character;
			local v25 = l_Character_1 and l_Character_1.PrimaryPart;
			if v23 and v25 then
				local v26 = script.RequestUI:Clone();
				v26.Title.Text = v23.NotificationTitle:gsub("PLAYERNAME", l_Character_1.Name);
				v26.Adornee = v25;
				v26.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
				local l_Highlight_0 = Instance.new("Highlight");
				l_Highlight_0.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
				l_Highlight_0.Adornee = l_Character_1;
				l_Highlight_0.FillColor = Color3.new(0.5, 1, 0.5);
				l_Highlight_0.OutlineColor = Color3.new(0.5, 1, 0.5);
				local v28 = {
					[v26.Title] = {
						TextTransparency = 0, 
						TextStrokeTransparency = 0.5
					}, 
					[l_Highlight_0] = {
						FillTransparency = 0.9, 
						OutlineTransparency = 0.5
					}
				};
				for v29, v30 in pairs(v28) do
					for v31, v32 in pairs(v30) do
						v29[v31] = 1;
						game.TweenService:Create(v29, TweenInfo.new(0.2), {
							[v31] = v32
						}):Play();
					end;
				end;
				task.delay(6, function() --[[ Line: 93 ]]
					-- upvalues: v28 (copy)
					for v33, v34 in pairs(v28) do
						game.Debris:AddItem(v33, 0.2);
						for v35, _ in pairs(v34) do
							game.TweenService:Create(v33, TweenInfo.new(0.2), {
								[v35] = 1
							}):Play();
						end;
					end;
				end);
			end;
		end);
	end;
	local function v71() --[[ Line: 107 ]] --[[ Name: toggleRequestFunctionality ]]
		-- upvalues: v8 (ref), l_Character_0 (copy), l_Players_0 (ref), v4 (ref), v5 (ref), l_ReplicatedStorage_0 (ref), l_LocalPlayer_0 (ref), v3 (ref), v6 (ref)
		if v8.Connections then
			for _, v38 in pairs(v8.Connections) do
				v38:Disconnect();
			end;
			table.clear(v8.Connections);
		end;
		local l_Parent_0 = l_Character_0.Parent;
		if l_Character_0 and l_Parent_0 and l_Parent_0 ~= workspace.Players.Spectating then
			local v40 = nil;
			do
				local l_v40_0 = v40;
				local function v67(v42) --[[ Line: 121 ]] --[[ Name: survivorClicked ]]
					-- upvalues: l_Players_0 (ref), v4 (ref), l_v40_0 (ref), l_Character_0 (ref), v5 (ref), l_ReplicatedStorage_0 (ref), l_LocalPlayer_0 (ref), v3 (ref)
					local l_l_Players_0_PlayerFromCharacter_1 = l_Players_0:GetPlayerFromCharacter(v42);
					local v44 = v4.CurrentActors[l_l_Players_0_PlayerFromCharacter_1] or nil;
					if v44 and not l_v40_0 then
						local l_l_Players_0_PlayerFromCharacter_2 = l_Players_0:GetPlayerFromCharacter(l_Character_0);
						l_l_Players_0_PlayerFromCharacter_1 = v4.CurrentActors[l_l_Players_0_PlayerFromCharacter_2] or nil;
						local v46 = v44.Config.Requests or {};
						l_l_Players_0_PlayerFromCharacter_2 = l_l_Players_0_PlayerFromCharacter_1 and l_l_Players_0_PlayerFromCharacter_1.Config.Requesting or {};
						local v47 = 0;
						local v48 = nil;
						for v49, _ in pairs(v46) do
							v47 = v47 + 1;
							v48 = v49;
						end;
						for v51, _ in pairs(l_l_Players_0_PlayerFromCharacter_2) do
							v47 = v47 + 1;
							v48 = v51;
						end;
						if v47 == 0 then
							return;
						elseif v47 <= 1 and v48 then
							local v53 = v5:FireServerConnection("SurvivorRequest", "REMOTE_FUNCTION", v42, v48);
							if typeof(v53) == "string" then
								require(l_ReplicatedStorage_0.Modules.Util):CreateWarning("SurvivorRequestWarning", v53);
							end;
							return;
						else
							l_v40_0 = script.RequestPrompt:Clone();
							l_v40_0.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
							l_v40_0.Background.ImageTransparency = 1;
							game.TweenService:Create(l_v40_0.Background, TweenInfo.new(0.3), {
								ImageTransparency = 0
							}):Play();
							local v54 = v3:MergeTables(l_l_Players_0_PlayerFromCharacter_2, v46);
							v54.Cancel = {
								AbilityName = "N/A", 
								NotificationTitle = "...", 
								Order = 999
							};
							local v55 = false;
							do
								local l_v55_0 = v55;
								for v57, v58 in pairs(v54) do
									local v59 = script.Choice:Clone();
									v59.Name = v57;
									v59.Text = v58.RequestTitle or v57:gsub("(%l)(%u)", "%1 %2");
									v59.LayoutOrder = tonumber(v58.Order) or 1;
									v59.Parent = l_v40_0.Choices;
									v59.TextTransparency = 1;
									game.TweenService:Create(v59, TweenInfo.new(0.15), {
										TextTransparency = 0
									}):Play();
									v59.MouseButton1Click:Connect(function() --[[ Line: 177 ]]
										-- upvalues: l_v55_0 (ref), l_v40_0 (ref), v59 (copy), v57 (copy), v5 (ref), v42 (copy), v3 (ref)
										if not l_v55_0 then
											l_v55_0 = true;
											for _, v61 in pairs(l_v40_0.Choices:GetChildren()) do
												if v61:IsA("TextButton") then
													game.TweenService:Create(v61, TweenInfo.new(0.15), {
														TextTransparency = 1, 
														Size = UDim2.new(v59.Size.X.Scale, v59.Size.X.Offset, 0, 0)
													}):Play();
												end;
											end;
											game.TweenService:Create(l_v40_0.Background, TweenInfo.new(0.15), {
												ImageTransparency = 1
											}):Play();
											game.Debris:AddItem(l_v40_0, 0.15);
											l_v40_0 = nil;
											if v57 ~= "Cancel" then
												local v62 = v5:FireServerConnection("SurvivorRequest", "REMOTE_FUNCTION", v42, v57);
												if typeof(v62) == "string" then
													v3:CreateWarning("SurvivorRequestWarning", v62);
												end;
											end;
										end;
									end);
								end;
								local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
								l_v40_0.Position = UDim2.fromOffset(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y + l_v40_0.AbsoluteSize.Y / 2);
								for _, v65 in pairs(l_v40_0.Choices:GetChildren()) do
									if v65:IsA("GuiObject") then
										local l_Size_0 = v65.Size;
										v65.Size = UDim2.new(v65.Size.X.Scale, v65.Size.X.Offset, 0, 0);
										game.TweenService:Create(v65, TweenInfo.new(0.15), {
											Size = l_Size_0
										}):Play();
									end;
								end;
							end;
						end;
					end;
				end;
				v8.Connections.SurvivorClicked = v6.Clicked:Connect(v67);
				v8.Connections.SurvivorAdded = v4.ActorAdded:Connect(function(v68) --[[ Line: 216 ]]
					-- upvalues: v8 (ref)
					v8:UpdateSurvivor(v68);
				end);
				for _, v70 in pairs(l_Parent_0:GetChildren()) do
					v8:UpdateSurvivor(v70);
				end;
			end;
		end;
	end;
	v71();
	l_Character_0:GetPropertyChangedSignal("Parent"):Connect(v71);
end;
v8.UpdateSurvivor = function(_, v73) --[[ Line: 230 ]] --[[ Name: UpdateSurvivor ]]
	-- upvalues: l_LocalPlayer_0 (copy), l_Players_0 (copy), v4 (copy), v6 (copy)
	local v74 = false;
	local v75 = false;
	local v76 = false;
	local l_Character_2 = l_LocalPlayer_0.Character;
	local l_l_Players_0_PlayerFromCharacter_3 = l_Players_0:GetPlayerFromCharacter(l_Character_2);
	local v79 = v4.CurrentActors[l_l_Players_0_PlayerFromCharacter_3] or nil;
	if typeof(v73) == "table" then
		l_Character_2 = v73;
	else
		l_l_Players_0_PlayerFromCharacter_3 = l_Players_0:GetPlayerFromCharacter(v73);
		l_Character_2 = v4.CurrentActors[l_l_Players_0_PlayerFromCharacter_3] or nil;
	end;
	local l_Customization_0 = l_LocalPlayer_0.PlayerData:WaitForChild("Settings"):WaitForChild("Customization");
	local v81 = l_Customization_0:FindFirstChild("NametagsEnabled") and l_Customization_0.NametagsEnabled.Value;
	if not v79 then
		return;
	elseif not l_Character_2 then
		return;
	else
		if l_Character_2 then
			local l_Requests_0 = l_Character_2.Config.Requests;
			local v83;
			if not l_Requests_0 then
				v83 = false;
			else
				for _, v85 in pairs(l_Requests_0) do
					if v85 then
						v83 = true;
						v74 = true;
					end;
					if v74 then
						break;
					end;
				end;
				if not v74 then
					v83 = false;
				end;
			end;
			v74 = false;
			if not v83 then
				l_Requests_0 = v79.Config.Requesting;
				if not l_Requests_0 then
					v83 = false;
				else
					for _, v87 in pairs(l_Requests_0) do
						if v87 then
							v83 = true;
							v76 = true;
						end;
						if v76 then
							break;
						end;
					end;
					if not v76 then
						v83 = false;
					end;
				end;
				v76 = false;
				v75 = not v83;
			end;
			if not v75 then
				if l_Character_2.Rig.Parent == l_LocalPlayer_0.Character.Parent then
					v6:AddHoverableCharacter(l_Character_2.Rig);
					return;
				end;
			end;
		end;
		v75 = false;
		if l_Character_2.Rig.Parent ~= l_LocalPlayer_0.Character.Parent or not v81 then
			v6:RemoveHoverableCharacter(l_Character_2.Rig);
			return;
		else
			return;
		end;
	end;
end;
v8.UpdateAll = function(_) --[[ Line: 251 ]] --[[ Name: UpdateAll ]]
	-- upvalues: l_LocalPlayer_0 (copy), v8 (copy)
	local v89 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character.Parent;
	if not v89 then
		return;
	else
		for _, v91 in pairs(v89:GetChildren()) do
			v8:UpdateSurvivor(v91);
		end;
		return;
	end;
end;
return v8;