-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:06:57 2025 ]]
local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0.Modules.Util);
local v4 = l_RunService_0:IsClient();
local v5 = l_RunService_0:IsServer();
local function v13(v6, v7) --[[ Line: 14 ]] --[[ Name: createWarning ]]
	local l_PlayerGui_0 = v6:FindFirstChild("PlayerGui");
	local v9 = l_PlayerGui_0 and l_PlayerGui_0:FindFirstChild("TemporaryUI");
	if not v9 then
		return;
	else
		local l_MedkitWarning_0 = v9:FindFirstChild("MedkitWarning");
		if l_MedkitWarning_0 then
			l_MedkitWarning_0:Destroy();
		end;
		local v11 = game.ReplicatedStorage.Assets.UI.Warning:Clone();
		v11.Name = "MedkitWarning";
		v11.Title.Text = tostring(v7);
		v11.Parent = v9;
		local _ = v11.Size;
		v11.Size = v11.Size + UDim2.fromScale(0.025, 0.01);
		game.TweenService:Create(v11, TweenInfo.new(0.35), {
			Size = v11.Size
		}):Play();
		task.delay(3, function() --[[ Line: 35 ]]
			-- upvalues: v11 (copy)
			if v11.Parent then
				game.Debris:AddItem(v11, 1);
				game.TweenService:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					BackgroundTransparency = 1
				}):Play();
				game.TweenService:Create(v11.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					TextTransparency = 1, 
					TextStrokeTransparency = 1, 
					BackgroundTransparency = 1
				}):Play();
			end;
		end);
		return;
	end;
end;
v0.Created = function(_) --[[ Line: 45 ]] --[[ Name: Created ]]

end;
v0.Destroyed = function(v15) --[[ Line: 52 ]] --[[ Name: Destroyed ]]
	-- upvalues: v0 (copy)
	v0.Unequipped(v15);
end;
v0.Equipped = function(v16) --[[ Line: 57 ]] --[[ Name: Equipped ]]
	-- upvalues: v5 (copy)
	if v5 then
		for _, v18 in pairs(v16.Item:GetDescendants()) do
			if v18:IsA("Motor6D") and (not v18.Part0 or v18:GetAttribute("WeldToPrimaryPart")) then
				v18:SetAttribute("WeldToPrimaryPart", true);
				v18.Part0 = v16.Player.Character and v16.Player.Character.PrimaryPart;
			end;
		end;
	end;
end;
v0.Unequipped = function(v19) --[[ Line: 69 ]] --[[ Name: Unequipped ]]
	-- upvalues: v4 (copy)
	if v19.HealingThreads and not v19.Completed then
		for _, v21 in pairs(v19.HealingThreads) do
			task.cancel(v21);
		end;
		v19.HealingThreads = nil;
	end;
	if v19.SFX then
		v19.SFX:Destroy();
	end;
	if v19.UI then
		v19.UI:Destroy();
		v19.UI = nil;
	end;
	if v19.SpeedModifier then
		game.TweenService:Create(v19.SpeedModifier, TweenInfo.new(0.5), {
			Value = 1
		}):Play();
		game.Debris:AddItem(v19.SpeedModifier, 0.5);
		v19.SpeedModifier = nil;
	end;
	if v4 then
		require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "UsingMedkit", false);
		if v19.Item and v19.Item.Parent then
			for _, v23 in pairs(v19.Item:GetDescendants()) do
				if v23:IsA("BasePart") then
					v23.Transparency = 0;
				end;
			end;
		end;
	end;
	local l_pairs_0 = pairs;
	local v25 = v19.BehaviorConnections or {};
	for _, v27 in l_pairs_0(v25) do
		v27:Disconnect();
	end;
	v19.BehaviorConnections = nil;
end;
v0.Activated = function(v28) --[[ Line: 115 ]] --[[ Name: Activated ]]
	-- upvalues: v4 (copy), v3 (copy), v13 (copy), v0 (copy), v5 (copy), l_ReplicatedStorage_0 (copy), l_RunService_0 (copy)
	local l_Health_0 = v28.Character.Humanoid.Health;
	local v30 = v28.Character.Humanoid:GetAttribute("Overheal") or 0;
	if v28.Character.Name == "Veeronica" then
		if v4 then
			v3:CreateWarning("MedkitVeeronica", "You cannot use this as Veeronica, use your battery!");
		end;
		return;
	elseif v28.Character.Humanoid.MaxHealth <= l_Health_0 then
		v13(v28.Player, "Sharing is caring...");
		return;
	else
		v28.BehaviorConnections = {
			v28.Character.Humanoid.HealthChanged:Connect(function(v31) --[[ Line: 137 ]]
				-- upvalues: l_Health_0 (ref), v0 (ref), v28 (copy), v4 (ref)
				if v31 < l_Health_0 then
					v0.Unequipped(v28);
					if v4 then
						v28.Animations.Heal:Stop();
						return;
					end;
				else
					l_Health_0 = v31;
				end;
			end), 
			v28.Character.Humanoid:GetAttributeChangedSignal("Overheal"):Connect(function() --[[ Line: 148 ]]
				-- upvalues: v28 (copy), v30 (ref), v0 (ref), v4 (ref)
				local v32 = v28.Character.Humanoid:GetAttribute("Overheal") or -50;
				if v32 + 5 < v30 then
					v0.Unequipped(v28);
					if v4 then
						v28.Animations.Heal:Stop();
						return;
					end;
				else
					v30 = v32;
				end;
			end)
		};
		if v5 and not v28.HealingThreads then
			v28.SFX = require(game.ReplicatedStorage.Modules.Sounds):Play(v28.Config.Sounds.Healing, {
				Parent = v28.Item.ItemRoot
			});
			v28.HealingThreads = {
				task.delay(v28.Config.HealTime, function() --[[ Line: 167 ]]
					-- upvalues: v28 (copy), l_ReplicatedStorage_0 (ref)
					require(game.ReplicatedStorage.Modules.Util):Heal(v28.Character.Humanoid, v28.Config.HealAmount);
					local v33 = require(l_ReplicatedStorage_0.Modules.Statuses);
					local v34 = v33:PlayerHasStatus(v28.Character, "Hemmorhage");
					if v34 then
						v34.Healed = true;
						v33:RemoveStatus(v28.Character, "Hemmorhage");
					end;
					v28.Completed = true;
					v28:Destroy();
				end)
			};
		elseif v4 and not v28.UI then
			v28.Animations.Heal:Play();
			v28.SpeedModifier = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(v28.Player, 1, "Medkit");
			game.TweenService:Create(v28.SpeedModifier, TweenInfo.new(0.5), {
				Value = v28.Config.HealSpeedMultiplier
			}):Play();
			require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "UsingMedkit", true);
			v28.UI = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
			v28.UI.Title.Text = "Healing";
			v28.UI.Parent = v28.Player.PlayerGui:FindFirstChild("TemporaryUI");
			local function v44(v35, v36) --[[ Line: 202 ]] --[[ Name: createProp ]]
				if not v35 then
					return;
				elseif typeof(v35) == "Instance" then
					local v37 = v35:Clone();
					v37.CanCollide = true;
					v37.Parent = workspace.Map.Ingame;
					v37.Velocity = v36 or Vector3.new();
					v35.Transparency = 1;
					return;
				else
					if typeof(v35) == "table" then
						local v38 = {};
						for v39, v40 in pairs(v35) do
							v38[v39] = v40:Clone();
							v38[v39]:ClearAllChildren();
							v38[v39].CanCollide = true;
							v40.Transparency = 1;
							if v39 ~= 1 then
								local l_WeldConstraint_0 = Instance.new("WeldConstraint");
								l_WeldConstraint_0.Parent = v38[v39];
								l_WeldConstraint_0.Part1 = v38[v39];
								l_WeldConstraint_0.Part0 = v38[1];
							end;
						end;
						for _, v43 in pairs(v38) do
							v43.Parent = workspace.Map.Ingame;
						end;
					end;
					return;
				end;
			end;
			v28.HealingThreads = {
				task.delay(1.666, function() --[[ Line: 231 ]]
					-- upvalues: v44 (copy), v28 (copy)
					v44(v28.Item.ItemRoot.Parts:FindFirstChild("syringidk0"), v28.Character.PrimaryPart.CFrame.LookVector * -2);
				end), 
				task.delay(2.533, function() --[[ Line: 235 ]]
					-- upvalues: v28 (copy), v44 (copy)
					local l_Children_0 = v28.Item.ItemRoot.Parts:GetChildren();
					table.insert(l_Children_0, v28.Item.ItemRoot);
					for v46 = #l_Children_0, 1, -1 do
						local v47 = l_Children_0[v46];
						if v47 and (v47.Name == "syringidk0" or v47.Name == "bandag") then
							table.remove(l_Children_0, v46);
						end;
					end;
					v44(l_Children_0, v28.Character.PrimaryPart.CFrame.LookVector * -2);
				end)
			};
			local function v53(v48, v49, v50) --[[ Line: 249 ]] --[[ Name: updateBar ]]
				local v51 = math.clamp(v49, 0, v50) / v50;
				local v52 = v51 == 0 and 0 or 1 / v51;
				v48.Clipping.Size = UDim2.fromScale(v51, 1);
				v48.Clipping.Top.Size = UDim2.fromScale(v52, 1);
			end;
			v53(v28.UI.Bar, 0, v28.Config.HealTime);
			local v54 = 0;
			while v28.UI and v28.UI.Parent do
				if v28.Config.HealTime <= v54 then
					v0.Unequipped(v28);
				else
					v53(v28.UI.Bar, v54, v28.Config.HealTime);
				end;
				v54 = v54 + l_RunService_0.Heartbeat:Wait();
			end;
		end;
		return;
	end;
end;
v0.Deactivated = function(_) --[[ Line: 279 ]] --[[ Name: Deactivated ]]

end;
return v0;