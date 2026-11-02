-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ServerStorage");
local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
local l_CollectionService_0 = game:GetService("CollectionService");
local v9 = require(game.ReplicatedStorage.Modules.AchievementUtil);
local v10 = require(script.Classes.VoidRushUI);
local v11 = {};
local v12 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v13 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v14 = require(game.ReplicatedStorage.Modules.Statuses);
local v15 = require(game.ReplicatedStorage.Modules.Sounds);
local v16 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
local v17 = require(l_ReplicatedStorage_0.Modules.Projectiles);
local v18 = require(l_ReplicatedStorage_0.Modules.Network);
local v19 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(l_ReplicatedStorage_0.Modules.Device);
local _ = require(l_ReplicatedStorage_0.Modules.Items);
local _ = require(l_ReplicatedStorage_0.Modules.Misc.RadialImage);
local v23 = require(game.ReplicatedStorage.Modules.Actors);
if l_RunService_0:IsServer() then
	local _ = require(l_ServerScriptService_0.Server.Systems.Core.ActorHandler);
end;
local l_StunProtectionVFX_0 = l_ReplicatedStorage_0.Assets.UI.StunProtectionVFX;
local function _(v26, v27, v28) --[[ Line: 35 ]] --[[ Name: reward ]]
	-- upvalues: v23 (copy)
	v23:IncrementActorStats(v26.Player, {
		Action = v28, 
		RewardType = v27 .. "KillerAction"
	});
end;
v11.Created = function(_, v31) --[[ Line: 42 ]] --[[ Name: Created ]]
	-- upvalues: l_RunService_0 (copy), v19 (copy), v18 (copy), l_ReplicatedStorage_0 (copy), v14 (copy), v9 (copy), l_Players_0 (copy), l_CollectionService_0 (copy), v10 (copy)
	if l_RunService_0:IsServer() then
		v31.Behavior.VoidstarEnabled = true;
		v31.Behavior.VoidRushCombo = 0;
		if not v31.Cache then
			v31.Cache = {};
		end;
		v31.Cache.Animations = {
			VoidRush = {}
		};
		for v32, v33 in pairs(v31.Config.Animations.VoidRush) do
			v31.Cache.Animations.VoidRush[v32] = v19:LoadAnimationFromID(v31.Rig, v33);
		end;
		v31.Cache.Animations.Observant = v19:LoadAnimationFromID(v31.Rig, v31.Config.Animations.ObservantTeleport);
		v31.Cache.Trails = {};
		for _, v35 in ipairs(v31.Rig:GetDescendants()) do
			if v35:IsA("Trail") then
				table.insert(v31.Cache.Trails, v35);
			end;
		end;
		v18:SetConnection(("%*ObservantTeleport"):format(v31.Player.Name), "REMOTE_EVENT", function(v36, v37) --[[ Line: 64 ]]
			-- upvalues: v31 (copy)
			local l_Map_0 = workspace.Map.Ingame:FindFirstChild("Map");
			if not l_Map_0 then
				return;
			elseif v36 ~= v31.Player or not v37:IsDescendantOf(l_Map_0) or not v37:IsA("Model") or not v37.Name:find("Generator") then
				v36:Kick("\n\nForsakenCheatKiller 100:\nInvalid Connection Arguments [ObservantTeleport]\n");
				return;
			elseif (v37:GetPivot().Position - v31.Rig.PrimaryPart.Position).Magnitude < v31.Config.ObservantMinDistance then
				return;
			else
				if v31.Behavior.Observing and v31:CanUseAbility("Observant") then
					v31.Behavior.ObservantUse(v31, v37);
				end;
				return;
			end;
		end);
		local v39 = {
			TOOKDAMAGE = {}, 
			KILLED = {}
		};
		v18:SetConnection(("%*CloneEvent"):format(v31.Player.Name), "REMOTE_EVENT", function(v40, v41) --[[ Line: 86 ]]
			-- upvalues: l_ReplicatedStorage_0 (ref), v39 (copy), v14 (ref), v31 (copy), v19 (ref), v9 (ref)
			local v42 = require(l_ReplicatedStorage_0.Modules.StatusEffects.KillerExclusive.Hallucination.HallucinationClass.FakeNoli);
			if not v39[v41] then
				v40:Kick("\n\nForsakenCheatKiller 150:\nInvalid Connection Arguments [CloneEvent]\n");
			end;
			local v43 = v39[v41] or {};
			local l_Character_0 = v40.Character;
			local v45 = l_Character_0 and l_Character_0.PrimaryPart;
			local v46 = v14:PlayerHasStatus(v40, "Hallucination");
			local v47 = v46 and v46.Level >= v42.ApplyAt;
			local v48 = v43[v40] and tick() - v43[v40] < v31.Config.StabCooldown - 0.2;
			if l_Character_0 and v45 and v47 and not v48 then
				v43[v40] = tick();
				if v41 == "TOOKDAMAGE" then
					v19:ApplyDamage(v40.Character, v31.Config.HallucinationCloneDamage);
					local v49 = math.clamp(v46.Data.Duration - v46.TimePast + v31.Config.HallucinationCloneExtension, 0, 20);
					warn(v49);
					v14:ApplyStatus(v40, "Hallucination", {
						Level = v46.Level, 
						Duration = v49, 
						Killer = v31
					});
					return;
				elseif v41 == "KILLED" then
					local _ = workspace.Hitboxes:FindFirstChild(v40.Name .. "Hitbox");
					v14:RemoveStatus(v40, "Hallucination");
					v9:IncrementAchievementProgress(v31.Player, "NoliPranked");
				end;
			end;
		end);
		if not l_RunService_0:IsStudio() then
			v31:SetCooldownOf("Observant", v31.Config.ObservantC00ldown);
		end;
		task.spawn(function() --[[ Line: 127 ]]
			-- upvalues: v31 (copy)
			local v51 = nil;
			local v52 = nil;
			v31.Behavior.FakeGenerators = {};
			repeat
				task.wait(1);
				v52 = workspace.Map.Ingame:FindFirstChild("Map");
				v51 = v52 and v52:FindFirstChild("GeneratorPositions");
			until v51 and v51:FindFirstChildOfClass("CFrameValue") or not v31 or not v31.Behavior.FakeGenerators;
			local v53 = v31 and v31.Behavior.FakeGenerators;
			if not v52 or not v53 then
				return;
			else
				local v54 = {};
				for _, v56 in ipairs(v51:GetChildren()) do
					if v56:IsA("CFrameValue") then
						table.insert(v54, v56);
					end;
				end;
				if #v54 < 1 then
					return;
				else
					for _ = 1, math.min(#v54, 2) do
						local v58 = math.random(1, #v54);
						local v59 = v54[v58];
						local v60 = script.FakeGenerator:Clone();
						v60:SetPrimaryPartCFrame(v59.Value);
						v60.Parent = v52;
						v60.Remotes.BE.Event:Connect(function(v61, v62) --[[ Line: 162 ]]
							-- upvalues: v31 (ref)
							local v63 = require(game.ReplicatedStorage.Modules.Statuses);
							local v64 = v63:PlayerHasStatus(v61, "Hallucination");
							v63:ApplyStatus(v61, "Hallucination", {
								Level = math.clamp((v64 and v64.Level or 0) + (v62 >= 100 and 3 or 1), 1, 3), 
								Duration = 15, 
								Killer = v31
							});
						end);
						for _, v66 in ipairs(v60.Scripts:GetChildren()) do
							if v66:IsA("BaseScript") then
								v66.Enabled = true;
							end;
						end;
						table.insert(v53, v60);
						table.remove(v54, v58);
						v59:Destroy();
					end;
					return;
				end;
			end;
		end);
		return;
	else
		if l_RunService_0:IsClient() and l_Players_0.LocalPlayer == v31.Player then
			local function _(v67) --[[ Line: 187 ]] --[[ Name: getFailMsg ]]
				-- upvalues: v31 (copy)
				return v31.Config.VoidRushStopMessages[v67];
			end;
			local v69 = v31.Player.Name .. "GenHighlight";
			v31.GeneratorHighlights = {};
			v31.GenConnection = l_CollectionService_0:GetInstanceAddedSignal(v69):Connect(function(v70) --[[ Line: 194 ]]
				-- upvalues: v31 (copy)
				if v70.ClassName ~= "Highlight" then
					return;
				else
					for v71, v72 in pairs(v31.Config.ObservantKillerProperties) do
						v70[v71] = v72;
					end;
					return;
				end;
			end);
			v18:SetConnection(("%*VoidRushUpdateUI"):format(v31.Player.Name), "REMOTE_EVENT", function(v73) --[[ Line: 203 ]]
				-- upvalues: v10 (ref), v31 (copy)
				local v74 = v73 == "Create" and v10.new(v31) or v31.Behavior.VoidRushUI;
				if not v74 then
					warn("Noli client had no UI");
					return;
				else
					v74.Counter = (v74.Counter or 0) + 1;
					local v75 = nil;
					if v73 == "Create" then
						v31.Behavior.VoidRushUI = v74;
						v74.Blinking = false;
						v74:TweenRadial(v31.Config.VoidRushChargeLength, 0, 1);
						v74:SetText("Charge Void Rush by holding down");
						return;
					elseif v73 == "ChargeFail" then
						v74.Blinking = false;
						v74:SetText(v31.Config.VoidRushStopMessages.FailedToCharge);
						v74:FadeOut(2, false);
						return;
					elseif v73 == "Dash" then
						v74.BlinkSpeed = 0.25;
						v74.Blinking = true;
						v74:TweenRadial(v31.Config.VoidRushDashLength, 1, 0);
						v74:SetText("Release the Void Rush button to cancel");
						return;
					elseif v73 == "Hit" then
						v74.Blinking = false;
						local l_Counter_0 = v74.Counter;
						v74:SetText(v31.Config.VoidRushStopMessages.Hit);
						v74:TweenRadial(v31.Config.VoidRushHitEndlag, 0, 1);
						task.delay(v31.Config.VoidRushHitEndlag, function() --[[ Line: 234 ]]
							-- upvalues: v74 (copy), l_Counter_0 (copy), v31 (ref)
							if v74 and l_Counter_0 == v74.Counter then
								v74:TweenRadial(v31.Config.VoidRushComboWindow, 1, 0);
							end;
						end);
						return;
					elseif v73 == "WindowMiss" then
						v74.Blinking = false;
						v74:SetText(v31.Config.VoidRushStopMessages.WindowMissed);
						v74:FadeOut(2, false);
						return;
					elseif v73:match("Miss_") then
						v74.Blinking = false;
						v75 = v73:sub(6, v73:len());
						v73 = "Miss";
						v74:SetText(v31.Config.VoidRushStopMessages[v75]);
						v74:FadeOut(2, v75 == "HitLarge");
						return;
					else
						warn("Invalid server subroutine string", v73);
						return;
					end;
				end;
			end);
			v18:SetConnection(("%*ObservantTeleport"):format(v31.Player.Name), "REMOTE_EVENT", function() --[[ Line: 257 ]]
				-- upvalues: v31 (copy)
				v31.Behavior.RevertObservance(v31);
			end);
		end;
		return;
	end;
end;
v11.Destroyed = function(_, v78) --[[ Line: 264 ]] --[[ Name: Destroyed ]]
	-- upvalues: l_RunService_0 (copy), v18 (copy), l_Players_0 (copy)
	if l_RunService_0:IsServer() then
		v78.Behavior.RevertObservance(v78, false);
		v78.Behavior.ToggleGeneratorAura(v78, false);
		v18:RemoveConnection(("%*ObservantTeleport"):format(v78.Player.Name), "REMOTE_EVENT");
		v18:RemoveConnection(("%*CloneEvent"):format(v78.Player.Name), "REMOTE_EVENT");
		local l_ipairs_0 = ipairs;
		local v80 = v78.Behavior.FakeGenerators or {};
		for _, v82 in l_ipairs_0(v80) do
			v82:Destroy();
		end;
		v78.Behavior.FakeGenerators = nil;
		return;
	else
		if l_RunService_0:IsClient() and l_Players_0.LocalPlayer == v78.Player then
			v18:RemoveConnection(("%*VoidRushUpdateUI"):format(v78.Player.Name), "REMOTE_EVENT");
			v18:RemoveConnection(("%*ObservantTeleport"):format(v78.Player.Name), "REMOTE_EVENT");
			if v78.Behavior.VoidRushUI then
				v78.Behavior.VoidRushUI:Destroy();
			end;
			if v78.GenConnection then
				v78.GenConnection:Disconnect();
			end;
			v78.Behavior.RevertObservance(v78);
		end;
		return;
	end;
end;
v11.OnIntroduction = function(_, v84, v85, v86) --[[ Line: 293 ]] --[[ Name: OnIntroduction ]]
	-- upvalues: v12 (copy), v19 (copy), l_Players_0 (copy)
	v12:SetCustomLighting(v84.Config.IntroLighting);
	local v87 = {};
	if v85:FindFirstChild("Right Arm") and v85["Right Arm"]:FindFirstChild("TentacleBase") then
		for _, v89 in ipairs(v85["Right Arm"].TentacleBase:GetDescendants()) do
			if (v89:IsA("ParticleEmitter") or v89:IsA("Beam")) and v89.Enabled then
				table.insert(v87, v89);
				v89.Enabled = false;
			end;
		end;
	end;
	if v85:FindFirstChild("Voidstar") then
		v85.Voidstar:Destroy();
	end;
	if v85:FindFirstChild("FakeCrown") then
		v85.FakeCrown.Transparency = 0;
		if v85:FindFirstChild("VoidstarCrown") then
			v85.VoidstarCrown:Destroy();
		end;
	else
		local l_VoidstarCrown_0 = v85:FindFirstChild("VoidstarCrown");
		if l_VoidstarCrown_0 then
			local v91 = v85.VoidstarCrown:Clone();
			v91.Name = "FakeCrown";
			v91.Parent = v85;
			local v92 = Instance.new("Motor6D", v91);
			v92.C0 = v84.Config.IntroCrownOffset or CFrame.new(0, 0.75, 0);
			v92.Part0 = v85.Head;
			v92.Part1 = v91;
			l_VoidstarCrown_0:Destroy();
		end;
	end;
	local l_KillerCutsceneBackground_0 = workspace.Misc:FindFirstChild("KillerCutsceneBackground");
	local v94 = true;
	task.spawn(function() --[[ Line: 342 ]]
		-- upvalues: v94 (ref), l_KillerCutsceneBackground_0 (copy)
		while v94 do
			for v95, v96 in pairs(l_KillerCutsceneBackground_0.Voidstars:GetChildren()) do
				v96.CFrame = v96.CFrame * CFrame.Angles(0, v95 % 2 == 0 and 0.0225 or -0.0225, 0);
			end;
			task.wait();
		end;
	end);
	task.spawn(function() --[[ Line: 352 ]]
		-- upvalues: v94 (ref), l_KillerCutsceneBackground_0 (copy)
		while v94 do
			local l_Skybox_0 = l_KillerCutsceneBackground_0.Skybox;
			l_Skybox_0.CFrame = l_Skybox_0.CFrame * CFrame.Angles(0, 0.004363323129985824, 0);
			task.wait();
		end;
	end);
	local l_v19_FOVMultiplier_0 = v19:CreateFOVMultiplier(l_Players_0.LocalPlayer, 0.375, "NoliIntroScene", v86);
	task.delay(1.98, function() --[[ Line: 361 ]]
		-- upvalues: l_v19_FOVMultiplier_0 (copy)
		l_v19_FOVMultiplier_0.Value = 0.275;
	end);
	task.delay(v86, function() --[[ Line: 365 ]]
		-- upvalues: v94 (ref), v87 (copy), v85 (copy), v12 (ref)
		v94 = false;
		for _, v100 in ipairs(v87) do
			v100.Enabled = true;
		end;
		v85:Destroy();
		v12:SetAsCurrentLighting();
	end);
end;
v11.OnVictory = function(_, v102, v103, v104, v105) --[[ Line: 379 ]] --[[ Name: OnVictory ]]
	-- upvalues: v12 (copy), l_RunService_0 (copy), v19 (copy), l_TweenService_0 (copy), l_Players_0 (copy)
	if v102 == "Start" then
		v12:SetCustomLighting(v103.Config.OutroLighting);
		local l_OutroFrameData_0 = v103.Config.OutroFrameData;
		local l_VictoryKillerTrack_0 = v103.Cache.VictoryKillerTrack;
		local l_VictoryCameraTrack_0 = v103.Cache.VictoryCameraTrack;
		local v109 = {};
		local function v113(v110) --[[ Line: 390 ]] --[[ Name: cacheParticles ]]
			-- upvalues: v109 (copy)
			for _, v112 in ipairs(v110:GetDescendants()) do
				if v112:IsA("ParticleEmitter") then
					v109[v112.Name] = v112;
				end;
			end;
		end;
		local l_ScreenGui_0 = Instance.new("ScreenGui");
		l_ScreenGui_0.Name = "NoliOutroOverlay";
		l_ScreenGui_0.ResetOnSpawn = false;
		l_ScreenGui_0.IgnoreGuiInset = true;
		l_ScreenGui_0.Parent = game.Players.LocalPlayer.PlayerGui;
		l_VictoryKillerTrack_0.Stopped:Once(function() --[[ Line: 407 ]]
			-- upvalues: v104 (copy)
			if v104 then
				v104:PivotTo(v104:GetPivot() + Vector3.new(0, -20, 0, 0));
			end;
		end);
		for _, v116 in ipairs(v104:GetDescendants()) do
			if v116:IsA("Sound") then
				v116:Destroy();
			end;
		end;
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
		local v118 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 423 ]]
			-- upvalues: l_VictoryCameraTrack_0 (copy), l_OutroFrameData_0 (copy)
			local v117 = math.ceil((l_VictoryCameraTrack_0.TimePosition + 0.001) * 60);
			if l_OutroFrameData_0.CameraFOV and l_OutroFrameData_0.CameraFOV[v117] then
				workspace.CurrentCamera.FieldOfView = l_OutroFrameData_0.CameraFOV[v117] or l_OutroFrameData_0.CameraFOV[#l_OutroFrameData_0.CameraFOV];
			end;
		end);
		if not v19:GetSettingValue("EpilepsyMode") then
			local v122 = l_VictoryKillerTrack_0:GetMarkerReachedSignal("EmitParticle"):Connect(function(v119) --[[ Line: 433 ]]
				-- upvalues: v109 (copy)
				local v120 = v109[v119];
				local l_v120_Attribute_0 = v120:GetAttribute("EmitCount");
				if not l_v120_Attribute_0 then
					v120.Enabled = not v120.Enabled;
					return;
				else
					v120:Emit(l_v120_Attribute_0);
					return;
				end;
			end);
			task.delay(v105, function() --[[ Line: 444 ]]
				-- upvalues: v122 (copy)
				v122:Disconnect();
			end);
		end;
		task.spawn(function() --[[ Line: 451 ]]
			-- upvalues: v113 (copy)
			local v123 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
			if v123 then
				v113(v123.Map.ExplosionGround);
			end;
		end);
		task.spawn(function() --[[ Line: 458 ]]
			-- upvalues: v103 (copy), v113 (copy)
			local v124 = workspace.Misc:WaitForChild(v103.Player.Name .. "CameraRig", 3);
			if v124 then
				v113(v124);
			end;
		end);
		task.delay(3.22, function() --[[ Line: 466 ]]
			-- upvalues: v19 (ref), l_ScreenGui_0 (copy), v104 (copy), l_TweenService_0 (ref)
			if not v19:GetSettingValue("EpilepsyMode") then
				local v125 = Instance.new("Frame", l_ScreenGui_0);
				v125.Size = UDim2.new(10, 0, 10, 0);
				v125.AnchorPoint = Vector2.new(0.5, 0.5);
				v125.Position = UDim2.new(0.5, 0, 0.5, 0);
				v125.BackgroundTransparency = 1;
				v125.BackgroundColor3 = Color3.new(0, 0, 0);
				local l_Highlight_0 = Instance.new("Highlight");
				l_Highlight_0.FillTransparency = 1;
				l_Highlight_0.OutlineTransparency = 1;
				l_Highlight_0.OutlineColor = Color3.new(0.4, 0, 1);
				l_Highlight_0.Parent = v104;
				game.Debris:AddItem(l_Highlight_0, 3);
				local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
				l_ColorCorrectionEffect_0.Parent = game.Lighting;
				l_ColorCorrectionEffect_0.Name = "NoliBoomCC";
				game.Debris:AddItem(l_ColorCorrectionEffect_0, 3);
				local v128 = l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					TintColor = Color3.fromRGB(125, 66, 155), 
					Brightness = -0.1, 
					Contrast = 0.5
				});
				v128:Play();
				l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, true, 0), {
					OutlineTransparency = 0.1
				}):Play();
				task.wait(0.65);
				v19:ApplyCameraShake(0.2, 1.2);
				v128:Pause();
				l_ColorCorrectionEffect_0.Contrast = 1;
				l_ColorCorrectionEffect_0.Brightness = 2.8;
				l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(70, 0, 155);
				l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Brightness = -0.6, 
					TintColor = Color3.new(0.623529, 0.623529, 0.623529), 
					Contrast = -0.5
				}):Play();
				task.wait(1.1);
				if not v125 then
					return;
				else
					l_TweenService_0:Create(v125, TweenInfo.new(0.2), {
						BackgroundTransparency = 0, 
						BackgroundColor3 = Color3.new(0, 0, 0)
					}):Play();
				end;
			end;
		end);
		task.delay(v105, function() --[[ Line: 516 ]]
			-- upvalues: v118 (copy)
			v118:Disconnect();
		end);
		return;
	else
		if v102 == "End" then
			l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
			v12:SetAsCurrentLighting();
			if l_Players_0.LocalPlayer.PlayerGui:FindFirstChild("NoliOutroOverlay") then
				l_Players_0.LocalPlayer.PlayerGui.NoliOutroOverlay:Destroy();
			end;
			local v129 = game.Lighting:WaitForChild("NoliBoomCC", 9);
			if v129 then
				v129:Destroy();
			end;
		end;
		return;
	end;
end;
v11.OnExecution = function(_, v131, v132) --[[ Line: 535 ]] --[[ Name: OnExecution ]]
	-- upvalues: v16 (copy)
	local l_Rig_0 = v131.Rig;
	v131.Behavior.DisableVoidstar(v131);
	v131.Behavior.ToggleTendril(v131, true);
	task.delay(4.2, function() --[[ Line: 541 ]]
		-- upvalues: v131 (copy)
		v131.Behavior.EnableVoidstar(v131);
		v131.Behavior.ToggleTendril(v131, false);
	end);
	if v131.VoidstarVisibleThread then
		task.cancel(v131.VoidstarVisibleThread);
		v131.VoidstarVisibleThread = nil;
	end;
	task.delay(2.4, function() --[[ Line: 553 ]]
		-- upvalues: v16 (ref), v132 (copy), l_Rig_0 (copy)
		v16.AddProfile(v132, {
			Velocity = Vector3.new(0, 50, 0, 0), 
			KillEffects = {
				HeadSquash = true
			}
		});
		local l_Head_0 = v132:FindFirstChild("Head");
		local l_Humanoid_0 = v132:FindFirstChild("Humanoid");
		if l_Humanoid_0 then
			l_Humanoid_0.BreakJointsOnDeath = false;
			l_Humanoid_0.Health = 0;
			if l_Head_0 then
				l_Head_0:Destroy();
			end;
			for _, v137 in ipairs(l_Rig_0.Voidstar.Crush:GetChildren()) do
				if v137:IsA("ParticleEmitter") then
					v137.Enabled = true;
				end;
			end;
			task.delay(0.125, function() --[[ Line: 574 ]]
				-- upvalues: l_Rig_0 (ref)
				for _, v139 in ipairs(l_Rig_0.Voidstar.Crush:GetChildren()) do
					if v139:IsA("ParticleEmitter") then
						v139.Enabled = false;
					end;
				end;
			end);
		end;
	end);
end;
v11.Abilities = {
	Stab = {
		LayoutOrder = 1, 
		Icon = "rbxassetid://130161235577806", 
		KeybindType = "MainAbility", 
		Callback = function(v140, _) --[[ Line: 591 ]] --[[ Name: Callback ]]
			-- upvalues: l_RunService_0 (copy), v15 (copy), v13 (copy), v19 (copy), v14 (copy)
			if l_RunService_0:IsServer() then
				v140:PlayVoiceline("Stab", {
					Priority = 1
				});
				v140.AbilitiesDisabled = true;
				task.delay(v140.Config.StabEndlag, function() --[[ Line: 600 ]]
					-- upvalues: v140 (copy)
					v140.AbilitiesDisabled = false;
				end);
				v15:Play(v140.Config.Sounds.Swing, {
					Parent = v140.Rig.PrimaryPart, 
					PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
					Volume = 0.25, 
					RollOffMaxDistance = 25
				});
				v140.Behavior.DisableVoidstar(v140);
				v140.Behavior.ToggleTendril(v140, true);
				task.delay(v140.Config.StabWindup, function() --[[ Line: 610 ]]
					-- upvalues: v13 (ref), v140 (copy), v19 (ref), v15 (ref), v14 (ref)
					local _ = v13:CreateHitbox(v140.Player, {
						Size = Vector3.new(4.5, 6, 7.5, 0), 
						CFrameOffset = CFrame.new(0, 0, -2.25), 
						Damage = v140.Config.StabDamage, 
						Time = v140.Config.StabLinger, 
						Knockback = 2, 
						HitMultiple = false, 
						ExecuteOnKill = true, 
						Connections = {
							Hit = function(v142, v143) --[[ Line: 622 ]] --[[ Name: Hit ]]
								-- upvalues: v19 (ref), v140 (ref), v15 (ref), v14 (ref)
								v19:CreateSpeedMultiplier(v142, 1.5, "HitSpeedBonus", 1.25);
								if v143 then
									v140:PlayVoiceline("StabHit", {
										Priority = 2
									});
									v15:Play(v140.Config.Sounds.Hit, {
										Parent = v140.Rig.PrimaryPart, 
										PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
										Volume = 0.3, 
										RollOffMaxDistance = 25
									});
								end;
								v14:RemoveStatus(v142, "Hallucination");
							end
						}
					});
				end);
				v140.VoidstarVisibleThread = task.delay(v140.Config.StabEndlag, function() --[[ Line: 634 ]]
					-- upvalues: v140 (copy)
					v140.Behavior.EnableVoidstar(v140);
					v140.Behavior.ToggleTendril(v140, false);
				end);
				return;
			else
				if l_RunService_0:IsClient() then
					v140.Animations.Stab:Play(0.175);
				end;
				return;
			end;
		end
	}, 
	VoidRush = {
		LayoutOrder = 2, 
		Icon = "rbxassetid://110747688363796", 
		KeybindType = "AltAbility1", 
		FlavorText = "[Hold]", 
		Toggle = true, 
		Callback = function(v145, v146) --[[ Line: 656 ]] --[[ Name: Callback ]]
			-- upvalues: v15 (copy), l_RunService_0 (copy), v19 (copy), v18 (copy), v9 (copy), v13 (copy), l_TweenService_0 (copy), v14 (copy), v23 (copy), v16 (copy), l_ReplicatedStorage_0 (copy)
			local l_Behavior_0 = v145.Behavior;
			local v148 = ("%*VoidRushCollision"):format(v145.Player.Name);
			local v149 = ("%*VoidRushCancel"):format(v145.Player.Name);
			local v150 = ("%*VoidRushUpdateUI"):format(v145.Player.Name);
			local function v155(v151) --[[ Line: 664 ]] --[[ Name: playSound ]]
				-- upvalues: v145 (copy), v15 (ref)
				local l_Sounds_0 = v145.Config.Sounds;
				local v153 = l_Sounds_0[("VoidRush%*"):format(v151)] or l_Sounds_0[v151];
				if v153 then
					local v154 = {
						Parent = v145.Rig.PrimaryPart, 
						PlaybackSpeed = Random.new():NextNumber() / 20 + 0.975, 
						Volume = 0.7, 
						RollOffMaxDistance = 50
					};
					if typeof(v153) == "table" then
						v154 = {
							Parent = v145.Rig.PrimaryPart, 
							PlaybackSpeed = 1, 
							RollOffMaxDistance = 80, 
							Volume = 0.77
						};
					end;
					return v15:Play(v153, v154);
				else
					return;
				end;
			end;
			if l_RunService_0:IsServer() then
				local function v158(v156, v157) --[[ Line: 681 ]] --[[ Name: giveEndlag ]]
					-- upvalues: v145 (copy), v19 (ref)
					v145.AbilitiesDisabled = true;
					v19:CreateSpeedMultiplier(v145.Rig, 0.6, "VoidRushEndlag", v156 + (v157 and v145.Config.VoidRushComboWindow or 0), true);
					if not v157 then
						task.delay(v156, function() --[[ Line: 686 ]]
							-- upvalues: v145 (ref)
							v145.AbilitiesDisabled = false;
						end);
					end;
				end;
				local function _(v159) --[[ Line: 692 ]] --[[ Name: updateLocalUI ]]
					-- upvalues: v18 (ref), v145 (copy), v150 (copy)
					v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", v159);
				end;
				local l_VoidRush_0 = v145.Cache.Animations.VoidRush;
				v145.AbilitiesDisabled = true;
				v145.Behavior.DisableVoidstar(v145);
				v145.Behavior.ToggleTendril(v145, true);
				task.spawn(function() --[[ Line: 703 ]]
					-- upvalues: l_Behavior_0 (copy), v18 (ref), v145 (copy), v150 (copy), l_VoidRush_0 (copy), v155 (copy), v19 (ref), v149 (copy), l_RunService_0 (ref), v15 (ref), v9 (ref), v13 (ref), v148 (copy), l_TweenService_0 (ref), v14 (ref), v23 (ref), v16 (ref), v158 (copy)
					if not l_Behavior_0.Endlag then
						l_Behavior_0.Endlag = nil;
						v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", "Create");
						local v162 = 0;
						local v163 = false;
						l_VoidRush_0.StartCharge:Play(0.15);
						l_VoidRush_0.LoopCharge:Play(0.2);
						v145.StartSound = v155("Start");
						v155("Loop");
						v145:PlayVoiceline("VoidRushStart", {
							Priority = 2
						});
						local l_v19_SpeedMultiplier_0 = v19:CreateSpeedMultiplier(v145.Rig, v145.Config.VoidRushChargingSpeed, "VoidRushCharging", v145.Config.VoidRushChargeLength);
						v145.Rig:SetAttribute("VoidRushState", "Charging");
						v18:SetConnection(v149, "REMOTE_EVENT", function() --[[ Line: 725 ]]
							-- upvalues: v163 (ref)
							v163 = true;
						end);
						v145.Behavior.VoidRushCombo = 0;
						repeat
							v162 = v162 + l_RunService_0.Heartbeat:Wait();
							if v145.Rig:GetAttribute("Stunned") then
								v163 = true;
							end;
						until v145.Config.VoidRushChargeLength <= v162 or v163;
						v18:RemoveConnection(v149);
						l_VoidRush_0.StartCharge:Stop();
						l_VoidRush_0.LoopCharge:Stop();
						l_v19_SpeedMultiplier_0:Destroy();
						if v163 then
							v145:SetCooldownOf("VoidRush", v145.Config.VoidRushC00ldown / 16);
							v145.Rig:SetAttribute("VoidRushState", "ChargingCancelled");
							l_VoidRush_0.CancelCharge:Play(0.15);
							v145:PlayVoiceline("VoidRushCancel", {
								Priority = 3
							});
							v155("Cancel");
							v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", "ChargeFail");
							task.delay(0.2, function() --[[ Line: 755 ]]
								-- upvalues: v145 (ref)
								v145.Behavior.EnableVoidstar(v145);
								v145.Behavior.ToggleTendril(v145, false);
								v145.AbilitiesDisabled = false;
								v145.DisabledAbilities = nil;
								v145.Rig:SetAttribute("VoidRushState", nil);
							end);
							if v145.StartSound then
								v145.StartSound:Destroy();
							end;
							return;
						else
							--[[ close >= 1 ]]
						end;
					end;
					if not v19:IsAlive(v145 and v145.Rig) then
						return;
					else
						if v145.StartSound then
							v145.StartSound:Destroy();
						end;
						if v145.WindowSound then
							v145.WindowSound:Destroy();
						end;
						v145.VoidRushChargingSound = v15:Play(v145.Config.Sounds.VoidRushDashLoop, {
							Parent = v145.Rig.PrimaryPart, 
							RollOffMaxDistance = 50, 
							Volume = 0.75
						});
						v145:PlayVoiceline("VoidRushDash", {
							Priority = 3
						});
						local l_VoidRushDashSpeed_0 = v145.Config.VoidRushDashSpeed;
						local v166 = l_Behavior_0.Endlag and "Combo" or "Init";
						local l_VoidRushDashLength_0 = v145.Config.VoidRushDashLength;
						local l_VoidRushHallucinationLevel_0 = v145.Config.VoidRushHallucinationLevel;
						local l_v19_SpeedMultiplier_1 = v19:CreateSpeedMultiplier(v145.Rig, l_VoidRushDashSpeed_0 / v145.Config.Speed, "VoidRushDash");
						local function v172() --[[ Line: 786 ]] --[[ Name: stopDashAnimations ]]
							-- upvalues: l_VoidRush_0 (ref)
							for _, v171 in ipairs({
								"StartDashInit", 
								"LoopDashCombo", 
								"LoopDashInit", 
								"StartDashCombo"
								}) do
								if l_VoidRush_0[v171] then
									l_VoidRush_0[v171]:Stop();
								end;
							end;
						end;
						v172();
						l_VoidRush_0[("StartDash%*"):format(v166)]:Play(0.05);
						l_VoidRush_0[("LoopDash%*"):format(v166)]:Play(0.05);
						v155("Dash" .. tostring(l_Behavior_0.Endlag and 2 or 1));
						if l_Behavior_0.EndlagComboThread then
							task.cancel(l_Behavior_0.EndlagComboThread);
							l_Behavior_0.EndlagComboThread = nil;
						end;
						local l_Behavior_1 = v145.Behavior;
						l_Behavior_1.VoidRushCombo = l_Behavior_1.VoidRushCombo + 1;
						l_Behavior_0.Endlag = nil;
						if v145.Behavior.VoidRushCombo == 5 then
							v9:IncrementAchievementProgress(v145.Player, "NoliCombo");
						end;
						l_Behavior_1 = false;
						local v174 = nil;
						local v175 = nil;
						local v176 = nil;
						local v177 = nil;
						local v178 = nil;
						local v179 = nil;
						local v180 = nil;
						v180 = v145.Rig:GetAttributeChangedSignal("Stunned"):Once(function() --[[ Line: 813 ]]
							-- upvalues: v177 (ref)
							v177 = true;
						end);
						local v181 = nil;
						v181 = v13:CreateHitbox(v145.Player, {
							Size = Vector3.new(6, 6, 4, 0), 
							Damage = v145.Config.VoidRushBaseDamage, 
							CFrameOffset = CFrame.new(0, 0, -2), 
							Time = l_VoidRushDashLength_0, 
							Knockback = 6, 
							HitMultiple = true, 
							ExecuteOnKill = false, 
							Connections = {
								Hit = function(v182) --[[ Line: 824 ]] --[[ Name: Hit ]]
									-- upvalues: l_Behavior_1 (ref), v19 (ref), v174 (ref), v9 (ref), v145 (ref), v181 (ref), v179 (ref)
									if l_Behavior_1 then
										return;
									else
										local l_v19_EntityType_0, v184 = v19:GetEntityType(v182);
										if l_v19_EntityType_0 then
											l_Behavior_1 = true;
											v174 = v182;
											if v174:GetAttribute("GuestCharging") then
												v9:IncrementAchievementProgress(v145.Player, "NoliCar");
												v9:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(v174), "NoliCar");
											end;
											if v181 then
												v181:Cancel();
												return;
											end;
										elseif v184 == "Building" then
											l_Behavior_1 = true;
											v179 = v182;
											if v181 then
												v181:Cancel();
											end;
										end;
										return;
									end;
								end, 
								Ended = function() --[[ Line: 856 ]] --[[ Name: Ended ]]
									-- upvalues: v175 (ref)
									v175 = true;
								end
							}
						});
						local v185 = require(game.ReplicatedStorage.Modules.Network);
						local _ = v185:SetConnection(v148, "REMOTE_EVENT", function(v186, v187) --[[ Line: 864 ]]
							-- upvalues: v145 (ref), v176 (ref), v178 (ref)
							if v186 ~= v145.Player then
								v186:Kick("not slick at all");
								return;
							else
								v176 = v187;
								v178 = true;
								return;
							end;
						end);
						v19:CreateSpeedMultiplier(v145.Rig, 1, "VoidRushEndlag", 0);
						v19:CreateSpeedMultiplier(v145.Rig, 1, "VoidRushCharging", 0);
						v145.Rig:SetAttribute("VoidRushState", "Dashing");
						v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", "Dash");
						task.spawn(function() --[[ Line: 885 ]]
							-- upvalues: v174 (ref), v175 (ref), v177 (ref), v176 (ref), v178 (ref), v179 (ref), v145 (ref), l_v19_SpeedMultiplier_1 (copy), v185 (copy), v148 (ref), v181 (ref), l_TweenService_0 (ref), v14 (ref), l_VoidRushHallucinationLevel_0 (copy), v23 (ref), v19 (ref), v155 (ref), l_VoidRush_0 (ref), v18 (ref), v150 (ref), v16 (ref), v13 (ref), l_Behavior_0 (ref), v158 (ref), v172 (copy)
							repeat
								task.wait();
							until v174 or v175 or v177 or v176 or v178 or v179 or not v145.Rig.PrimaryPart;
							local v189 = v175 and "Timeout" or v177 and "Stunned" or v176 and "Crashed" or v179 and "NonChar" or "Cancelled";
							l_v19_SpeedMultiplier_1:Destroy();
							v185:RemoveConnection(v148, "REMOTE_EVENT");
							v181:Cancel();
							if v145.VoidRushChargingSound then
								local l_VoidRushChargingSound_0 = v145.VoidRushChargingSound;
								v145.VoidRushChargingSound = nil;
								l_TweenService_0:Create(l_VoidRushChargingSound_0, TweenInfo.new(0.4), {
									PlaybackSpeed = 0, 
									Volume = l_VoidRushChargingSound_0.Volume / 5
								}):Play();
								game.Debris:AddItem(l_VoidRushChargingSound_0, 0.5);
							end;
							if v174 then
								local v191 = v14:PlayerHasStatus(v174, "Hallucination");
								if v191 and v191.Data and v191.Data.Level >= l_VoidRushHallucinationLevel_0 then
									v14:RemoveStatus(v174, "Hallucination");
									v145:SetCooldownOf("VoidRush", v145.Config.VoidRushC00ldown);
									v23:IncrementActorStats(v145.Player, {
										Action = "Slammed Survivor with Void Rush", 
										RewardType = "Regular" .. "KillerAction"
									});
									v19:SetUpCutscene(v145.Rig, v174, CFrame.new(0, 0.01, 0));
									v155("Cutscene");
									v19:GiveInvincible(v145.Rig, "Slam");
									local l_CutsceneKillerRig_0 = l_VoidRush_0.CutsceneKillerRig;
									l_CutsceneKillerRig_0:Play(0);
									l_CutsceneKillerRig_0.TimePosition = 0;
									local v193 = v19:LoadAnimationFromID(v174, v145.Config.Animations.VoidRushVictimRig, true);
									v193:Play(0.05);
									v193.TimePosition = l_CutsceneKillerRig_0.TimePosition;
									v145.Rig:SetAttribute("VoidRushState", "HitLarge");
									v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", "Miss_HitLarge");
									task.spawn(function() --[[ Line: 941 ]]
										-- upvalues: v174 (ref), v145 (ref), v16 (ref), v13 (ref)
										v174.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
										task.wait(0.5);
										v145:PlayVoiceline("Slam", {
											Priority = 4
										});
										if v174 then
											v16.AddProfile(v174, {
												Velocity = Vector3.new(0, -5, 0, 0)
											});
											local _ = v13:CreateHitbox(v145.Player, {
												Size = Vector3.new(4, 4, 4, 0), 
												CFrame = v174.PrimaryPart.CFrame, 
												Damage = v145.Config.VoidRushSlamDamage + (v145.Behavior.VoidRushCombo or 0) * v145.Config.VoidRushComboDamage, 
												Time = 0.1, 
												Knockback = 0, 
												HitMultiple = true, 
												PredictVelocity = false, 
												ExecuteOnKill = false, 
												Connections = {}
											});
											local v195 = RaycastParams.new();
											v195.FilterDescendantsInstances = workspace.Players:GetDescendants();
											v195.FilterType = Enum.RaycastFilterType.Exclude;
											local l_Position_0 = v145.Rig.PrimaryPart.Position;
											local v197 = v145.Rig.PrimaryPart.CFrame.LookVector * 2;
											local v198 = workspace:Raycast(l_Position_0, v197, v195);
											v174:SetPrimaryPartCFrame(v174.PrimaryPart.CFrame + v197 * (v198 and v198.Distance or v197.Magnitude) / 2);
											v174.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
											v174.PrimaryPart.Anchored = false;
											v16.EnableRagdoll(v174, 1.75);
										end;
										v145.Behavior.EnableVoidstar(v145);
										v145.Behavior.ToggleTendril(v145, false);
									end);
									task.delay(0.5 + v145.Config.VoidRushCutsceneLength, function() --[[ Line: 984 ]]
										-- upvalues: v145 (ref), v19 (ref)
										v145.Rig:SetAttribute("VoidRushState", nil);
										v145.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
										v145.Rig.PrimaryPart.Anchored = false;
										task.wait(0.5);
										v19:RemoveInvincible(v145.Rig, "Slam");
										v145.AbilitiesDisabled = false;
										v145.DisabledAbilities = nil;
									end);
									if l_Behavior_0.Endlag then
										v145:SetCooldownOf("VoidRush", v145.Config.VoidRushC00ldown);
									end;
								else
									local l_VoidRushHitEndlag_0 = v145.Config.VoidRushHitEndlag;
									local l_VoidRushComboWindow_0 = v145.Config.VoidRushComboWindow;
									v23:IncrementActorStats(v145.Player, {
										Action = "Hit player with Void Rush", 
										RewardType = "Easy" .. "KillerAction"
									});
									v145.Rig:SetAttribute("VoidRushState", "Hit");
									v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", "Hit");
									v145:SetCooldownOf("VoidRush", l_VoidRushHitEndlag_0);
									v14:ApplyStatus(v174, "Hallucination", {
										Duration = v145.Config.VoidRushHallucinationDuration, 
										Level = l_VoidRushHallucinationLevel_0, 
										Killer = v145
									});
									v19:CreateSpeedMultiplier(v174, 1.5, "HitSpeedBonus", 1.25);
									v158(l_VoidRushHitEndlag_0, true);
									l_Behavior_0.Endlag = true;
									v145.WindowSound = v155("Window");
									l_VoidRush_0.WeakHit:Play(0);
									v145:PlayVoiceline("VoidRushWeakHit", {
										Priority = 4
									});
									v155("WeakHit" .. tostring((math.clamp(v145.Behavior.VoidRushCombo, 1, 5))));
									v145.AbilitiesDisabled = false;
									v145.DisabledAbilities = {
										Stab = true, 
										Nova = true, 
										Observant = true
									};
									l_Behavior_0.EndlagComboThread = task.delay(l_VoidRushHitEndlag_0 + l_VoidRushComboWindow_0, function() --[[ Line: 1037 ]]
										-- upvalues: l_Behavior_0 (ref), v145 (ref), v18 (ref), v150 (ref)
										l_Behavior_0.Endlag = nil;
										v145.AbilitiesDisabled = false;
										v145:SetCooldownOf("VoidRush", v145.Config.VoidRushC00ldown);
										v145.Behavior.EnableVoidstar(v145);
										v145.Behavior.ToggleTendril(v145, false);
										v145.DisabledAbilities = nil;
										v145.Rig:SetAttribute("VoidRushState", nil);
										v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", "WindowMiss");
									end);
								end;
							elseif v175 or v177 or v176 or v178 or v179 then
								v158(v145.Config.VoidRushMissEndlag);
								task.delay(v145.Config.VoidRushMissEndlag, function() --[[ Line: 1054 ]]
									-- upvalues: v145 (ref)
									v145.Behavior.EnableVoidstar(v145);
									v145.Behavior.ToggleTendril(v145, false);
								end);
								v145:SetCooldownOf("VoidRush", v145.Config.VoidRushC00ldown);
								v145.DisabledAbilities = nil;
								v145.Rig:SetAttribute("VoidRushState", v189);
								local v201 = "Miss_" .. v189;
								v18:FireClientConnection(v145.Player, v150, "REMOTE_EVENT", v201);
								if l_VoidRush_0["EndDash" .. v189] then
									l_VoidRush_0["EndDash" .. v189]:Play();
								else
									l_VoidRush_0.EndDash:Play();
								end;
								v155("Miss" .. v189);
								v145:PlayVoiceline("VoidRushMiss" .. v189, {
									Priority = 3
								});
							end;
							v172();
						end);
						return;
					end;
				end);
				return {
					SentTick = not l_Behavior_0.Endlag and tick()
				};
			else
				if l_RunService_0:IsClient() then
					local v202 = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
					local v203 = v146 and v146.SentTick;
					local function _() --[[ Line: 1088 ]] --[[ Name: getState ]]
						-- upvalues: v145 (copy)
						return v145.Rig:GetAttribute("VoidRushState");
					end;
					v18:FireConnection("DisableSprinting", "VoidRushCharging", true);
					if v203 then
						local v205 = false;
						v202.StaminaCap = v202.Stamina + 1;
						while l_RunService_0.Heartbeat:Wait() do
							if not v145.HeldAbilities.VoidRush and not v205 then
								v205 = true;
								v18:FireServerConnection(v149, "REMOTE_EVENT");
							elseif v145.Rig:GetAttribute("VoidRushState") ~= "Charging" then
								break;
							end;
						end;
					end;
					if v145.Rig:GetAttribute("VoidRushState") == "ChargingCancelled" then
						v18:FireConnection("DisableSprinting", "VoidRushCharging", false);
						v202.StaminaCap = nil;
						v145.HeldAbilities.VoidRush = nil;
						return;
					else
						local v206 = 0;
						local v207 = false;
						local l_LookVector_0 = workspace.CurrentCamera.CFrame.LookVector;
						local l_Unit_0 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z).Unit;
						local v210 = Vector3.new(0, 0, 0, 0);
						v18:FireConnection("DisableSprinting", "VoidRushCharging", true);
						v202.StaminaCap = v202.Stamina + 1;
						do
							local l_v206_0, l_v207_0, l_l_Unit_0_0, l_v210_0 = v206, v207, l_Unit_0, v210;
							l_RunService_0:BindToRenderStep("VoidRushCharging", Enum.RenderPriority.Character.Value + 1, function(v215) --[[ Line: 1140 ]]
								-- upvalues: l_v206_0 (ref), v145 (copy), l_v207_0 (ref), v18 (ref), v148 (copy), l_v210_0 (ref), l_l_Unit_0_0 (ref), l_TweenService_0 (ref)
								l_v206_0 = l_v206_0 + v215;
								if l_v206_0 >= 0.3 and v145.Rig.PrimaryPart.Velocity.Magnitude <= v145.Config.VoidRushDashSpeed / 3.5 then
									if not l_v207_0 then
										l_v207_0 = true;
										v18:FireServerConnection(v148, "REMOTE_EVENT", v145.HeldAbilities.VoidRush);
									end;
									return;
								else
									local l_SpeedMultipliers_0 = v145.Rig:FindFirstChild("SpeedMultipliers");
									local v217 = l_SpeedMultipliers_0 and l_SpeedMultipliers_0:FindFirstChild("VoidRushDash");
									if v217 then
										local v218 = v145.Config.VoidRushDashSpeed / v145.Config.Speed;
										local v219 = v215 * (v145.HeldAbilities.VoidRush and 1 or -3) * 2 * v218;
										v217.Value = math.clamp(v217.Value + v219, 0, v218);
									end;
									local l_LookVector_1 = workspace.CurrentCamera.CFrame.LookVector;
									l_v210_0 = Vector3.new(l_LookVector_1.X, 0, l_LookVector_1.Z).Unit;
									local v221 = l_v210_0 - l_l_Unit_0_0;
									local l_Magnitude_0 = v221.Magnitude;
									if l_Magnitude_0 > 0 then
										local l_VoidRushInitialTurnDuration_0 = v145.Config.VoidRushInitialTurnDuration;
										local v224 = v145.Config.VoidRushInitialTurnMult * l_TweenService_0:GetValue((l_VoidRushInitialTurnDuration_0 - l_v206_0) / l_VoidRushInitialTurnDuration_0, Enum.EasingStyle.Sine, Enum.EasingDirection.In) + 1;
										local v225 = v145.Config.VoidRushTurnSpeed * v215 * v224;
										if l_Magnitude_0 <= v225 then
											l_l_Unit_0_0 = l_v210_0;
										else
											l_l_Unit_0_0 = l_l_Unit_0_0 + v221.Unit * v225;
										end;
										l_l_Unit_0_0 = l_l_Unit_0_0.Unit;
									end;
									v145.Rig.Humanoid:Move(l_l_Unit_0_0);
									return;
								end;
							end);
							while v145 and v145.Rig and v145.Rig:GetAttribute("VoidRushState") == "Dashing" do
								l_RunService_0.Heartbeat:Wait();
							end;
							v145.HeldAbilities.VoidRush = nil;
							v202.StaminaCap = nil;
							v18:FireConnection("DisableSprinting", "VoidRushCharging", false);
							l_RunService_0:UnbindFromRenderStep("VoidRushCharging");
						end;
					end;
				end;
				return;
			end;
		end
	}, 
	Nova = {
		LayoutOrder = 3, 
		Icon = "rbxassetid://70669903126039", 
		KeybindType = "AltAbility2", 
		Callback = function(v226, v227) --[[ Line: 1206 ]] --[[ Name: Callback ]]
			-- upvalues: l_RunService_0 (copy), v19 (copy), v15 (copy), v17 (copy), v18 (copy)
			local _ = v226.Behavior;
			if l_RunService_0:IsServer() then
				if v226.Behavior.Voidstar then
					v226.AbilitiesDisabled = true;
					task.delay(0.2, function() --[[ Line: 1213 ]]
						-- upvalues: v226 (copy)
						v226.AbilitiesDisabled = false;
					end);
					v226:SetCooldownOf("Nova", v226.Config.NovaCooldown);
					v226.Behavior.DetonateVoidstar(v226, v226.Behavior.Voidstar, true);
					v226.Behavior.Voidstar = nil;
					v226:PlayVoiceline("NovaDetonate", {
						Priority = 4
					});
					return "Detonate";
				else
					local l_NovaWindup_0 = v226.Config.NovaWindup;
					local _ = v19:CreateSpeedMultiplier(v226.Rig, v226.Config.NovaWindupSpeed, "NovaWindupSlowness", l_NovaWindup_0 + 0.3, true);
					v226.AbilitiesDisabled = true;
					v226:SetCooldownOf("Nova", l_NovaWindup_0 + 0.2);
					v15:Play(v226.Config.Sounds.Nova, {
						Parent = v226.Rig.PrimaryPart, 
						RollOffMaxDistance = 50
					});
					v226:PlayVoiceline("Nova", {
						Priority = 3
					});
					task.delay(l_NovaWindup_0, function() --[[ Line: 1237 ]]
						-- upvalues: v226 (copy), v19 (ref), v17 (ref), l_RunService_0 (ref)
						if v226.Rig:GetAttribute("Stunned") then
							v226.AbilitiesDisabled = false;
							return;
						else
							v226.Behavior.DisableVoidstar(v226);
							local l_PrimaryPart_0 = v226.Rig.PrimaryPart;
							if not l_PrimaryPart_0 then
								return;
							else
								local l_NovaProjectileSpeed_0 = v226.Config.NovaProjectileSpeed;
								local v233 = l_PrimaryPart_0.CFrame + Vector3.new(0, (v226.Rig.Humanoid.HipHeight + l_PrimaryPart_0.Size.Y / 2) / 2, 0);
								local _ = (v226.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
								local l_Unit_1 = ((if v226.Player:GetAttribute("Device") == "Mobile" then v19:GetPlayerMousePosition(v226.Player, true) else v19:GetPlayerMousePosition(v226.Player)) - v226.Rig.PrimaryPart.Position).Unit;
								local v236 = v226.Config.NovaProjectile:Clone();
								v236.RootPriority = -2;
								local v237 = RaycastParams.new();
								v237.RespectCanCollide = true;
								v237.CollisionGroup = "Killers";
								v237.FilterType = Enum.RaycastFilterType.Exclude;
								v237.FilterDescendantsInstances = {
									workspace.Players, 
									v236
								};
								local v238 = {
									Size = Vector3.new(3.5, 3.5, 3.5, 0), 
									Damage = 0
								};
								local v239 = vector.create(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15));
								local v248 = {
									Owner = v226.Player, 
									HitboxConfig = v238, 
									Lifetime = 4, 
									InitialCFrame = v233, 
									InitialVelocity = l_Unit_1 * l_NovaProjectileSpeed_0, 
									Model = v236, 
									CastParams = v237, 
									Callbacks = {
										HitHuman = function(v240, _) --[[ Line: 1294 ]] --[[ Name: HitHuman ]]
											-- upvalues: v226 (ref)
											v226.Behavior.DetonateVoidstar(v226, v240, false, true);
										end, 
										HitOther = function(v242, v243) --[[ Line: 1297 ]] --[[ Name: HitOther ]]
											-- upvalues: v226 (ref)
											local v244 = math.deg((math.acos((Vector3.new(0, 1, 0, 0):Dot(v243.Normal))))) < v226.Config.NovaFloorAngle;
											v226.Behavior.DetonateVoidstar(v226, v242, v244);
										end, 
										Validate = function(_, v246) --[[ Line: 1302 ]] --[[ Name: Validate ]]
											local v247 = v246 and v246.Instance;
											if v247 and v247.Transparency > 0.9 then
												return false;
											else
												return true;
											end;
										end
									}, 
									ClientCallbackData = {
										OnHeartbeat = {
											Rotation = {
												rotation = v239
											}
										}
									}
								};
								local v249 = v17.new(v248);
								v249:Launch();
								v226.Behavior.Voidstar = v249;
								task.delay(0.2, function() --[[ Line: 1324 ]]
									-- upvalues: v226 (ref)
									v226.AbilitiesDisabled = false;
								end);
								local v250 = nil;
								local _ = nil;
								v250 = l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 1332 ]]
									-- upvalues: v249 (copy), v226 (ref), v250 (ref)
									if not v249 or v249.State ~= "Running" then
										if v249 then
											v249:Destroy();
										end;
										v226:SetCooldownOf("Nova", v226.Config.NovaCooldown);
										v226.Behavior.Voidstar = nil;
										v250:Disconnect();
										v226.Behavior.EnableVoidstar(v226);
										v226.Behavior.ToggleTendril(v226, false);
										return;
									else
										return;
									end;
								end);
								return;
							end;
						end;
					end);
					return "Throw";
				end;
			else
				if l_RunService_0:IsClient() then
					if v227 == "Detonate" then
						v226.Animations.NovaDet:Play(0.175);
						return;
					else
						v226.Animations.NovaThrow:Play(0.175);
						v18:FireConnection("DisableSprinting", "Nova", true);
						task.delay(v226.Config.NovaWindup, function() --[[ Line: 1363 ]]
							-- upvalues: v18 (ref)
							v18:FireConnection("DisableSprinting", "Nova", false);
						end);
					end;
				end;
				return;
			end;
		end
	}, 
	Observant = {
		LayoutOrder = 4, 
		Icon = "rbxassetid://86665948552323", 
		KeybindType = "AltAbility3", 
		Callback = function(v253, v254) --[[ Line: 1375 ]] --[[ Name: Callback ]]
			-- upvalues: l_RunService_0 (copy), v15 (copy), v18 (copy), v19 (copy), l_TweenService_0 (copy)
			if l_RunService_0:IsServer() then
				if v253.Behavior.Observing then
					v253:PlayVoiceline("ObservantOff", {
						Priority = 4
					});
					v15:Play(v253.Config.Sounds.ObservantOff, {
						Parent = v253.Rig.PrimaryPart
					});
					v253.Behavior.RevertObservance(v253, false);
					v253.Behavior.ToggleGeneratorAura(v253, false);
					return {
						Result = false
					};
				else
					v253:PlayVoiceline("ObservantOn", {
						Priority = 4
					});
					if not workspace:FindFirstChild("Map") or not workspace.Map:FindFirstChild("Ingame") or not workspace.Map.Ingame:FindFirstChild("Map") then
						return;
					else
						v253.Behavior.ToggleObservantVFX(v253, true);
						v253.Behavior.ToggleGeneratorAura(v253, true);
						v15:Play(v253.Config.Sounds.ObservantOn, {
							Parent = v253.Rig.PrimaryPart
						});
						v253.Behavior.Observing = true;
						v253.DisabledAbilities = {
							VoidRush = true, 
							Nova = true, 
							Stab = true
						};
						v253.AbilitiesDisabled = true;
						if v253.ObservantConnection then
							v253.ObservantConnection:Disconnect();
							v253.ObservantConnection = nil;
						end;
						v253.ObservantConnection = v253.Rig:GetAttributeChangedSignal("Stunned"):Connect(function() --[[ Line: 1409 ]]
							-- upvalues: v253 (copy), v18 (ref)
							if v253.Rig:GetAttribute("Stunned") then
								v253.Behavior.RevertObservance(v253, false);
								v253.Behavior.ToggleGeneratorAura(v253, false);
								v18:FireClientConnection(v253.Player, ("%*ObservantTeleport"):format(v253.Player.Name), "REMOTE_EVENT");
							end;
						end);
						v19:CreateSpeedMultiplier(v253.Rig, v253.Config.ObservantSpeed, "NoliObserving");
						task.delay(0.5, function() --[[ Line: 1419 ]]
							-- upvalues: v253 (copy)
							v253.AbilitiesDisabled = false;
						end);
						return {
							Result = true
						};
					end;
				end;
			else
				if l_RunService_0:IsClient() then
					if not v254 then
						return;
					else
						v253.Behavior.Observing = v254.Result;
						if v253.Behavior.Observing then
							v18:FireConnection("DisableSprinting", "NoliObserving", true);
							v253.Animations.ObservantStart:Play(0.15);
							v253.Animations.ObservantLoop:Play();
							local v255 = RaycastParams.new();
							v255.FilterDescendantsInstances = {};
							v255.FilterType = Enum.RaycastFilterType.Include;
							local v256 = {};
							v256.__index = v256;
							v256.new = function(v257, v258) --[[ Line: 1445 ]] --[[ Name: new ]]
								-- upvalues: v256 (copy), l_TweenService_0 (ref), v19 (ref), v253 (copy)
								local v259 = setmetatable({}, v256);
								local l_Size_0 = v258.Size;
								v259.GarbageConnections = {};
								v259.IsHovering = false;
								v259.Generator = v257;
								v259.Billboard = v258;
								v259.Button = v258.ImageButton;
								v259.EnterTween = l_TweenService_0:Create(v258, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
									Size = UDim2.new(l_Size_0.X.Scale * 1.2, l_Size_0.X.Offset * 1.2, l_Size_0.Y.Scale * 1.2, l_Size_0.Y.Offset * 1.2)
								});
								v259.LeaveTween = l_TweenService_0:Create(v258, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Size = l_Size_0
								});
								if not v19:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) or not v253.Config.isScreamerSensitive then
									v259.Button:SetAttribute("Spritesheet", v253.Config.ScreamerSpritesheet or "NoliLaugh");
									v259.Button:SetAttribute("TimeScale", 0.35);
									v259.Button:AddTag("Spritesheet");
								elseif v19:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) and v253.Config.isScreamerSensitive then
									v259.Button.Image = v253.Config.SensitiveScreamerImage or "rbxassetid://89949595020859";
								end;
								v259.Button.MouseEnter:Connect(function() --[[ Line: 1465 ]]
									-- upvalues: v259 (copy)
									v259:OnMouseEntered();
								end);
								v259.Button.MouseLeave:Connect(function() --[[ Line: 1468 ]]
									-- upvalues: v259 (copy)
									v259:OnMouseLeft();
								end);
								v259.Button.MouseButton1Down:Connect(function() --[[ Line: 1471 ]]
									-- upvalues: v259 (copy)
									v259:OnClicked();
								end);
								table.insert(v259.GarbageConnections, v258.AncestryChanged:Connect(function() --[[ Line: 1475 ]]
									-- upvalues: v259 (copy)
									v259:Destroy();
								end));
								table.insert(v259.GarbageConnections, v257.AncestryChanged:Connect(function() --[[ Line: 1478 ]]
									-- upvalues: v259 (copy)
									v259:Destroy();
								end));
								return v259;
							end;
							v256.OnMouseEntered = function(v261) --[[ Line: 1484 ]] --[[ Name: OnMouseEntered ]]
								if v261.IsHovering then
									return;
								else
									v261.IsHovering = true;
									v261.EnterTween:Play();
									v261.Button:SetAttribute("TimeScale", 1);
									return;
								end;
							end;
							v256.OnMouseLeft = function(v262) --[[ Line: 1490 ]] --[[ Name: OnMouseLeft ]]
								if not v262.IsHovering then
									return;
								else
									v262.IsHovering = false;
									v262.LeaveTween:Play();
									v262.Button:SetAttribute("TimeScale", 0.35);
									return;
								end;
							end;
							v256.OnClicked = function(v263) --[[ Line: 1496 ]] --[[ Name: OnClicked ]]
								-- upvalues: v18 (ref), v253 (copy)
								v18:FireServerConnection(("%*ObservantTeleport"):format(v253.Player.Name), "REMOTE_EVENT", v263.Generator);
							end;
							v256.Destroy = function(v264) --[[ Line: 1499 ]] --[[ Name: Destroy ]]
								local l_ipairs_1 = ipairs;
								local v266 = v264.GarbageConnections or {};
								for _, v268 in l_ipairs_1(v266) do
									v268:Disconnect();
								end;
								if v264.Billboard then
									v264.Billboard:Destroy();
								end;
								table.clear(v264);
							end;
							local function v272(v269) --[[ Line: 1507 ]] --[[ Name: addGenerator ]]
								-- upvalues: v253 (copy), v256 (copy), v255 (copy)
								local v270 = v253.Config.ObservantTeleportButton:Clone();
								v270.Parent = v253.Player.PlayerGui;
								v270.Adornee = v269;
								local v271 = v256.new(v269, v270);
								v253.Behavior.Generators[v269] = {
									Button = v271, 
									Instance = v269
								};
								v255:AddToFilter(v269);
							end;
							v253.Behavior.Generators = {};
							v253.Behavior.AddedGeneratorConnection = workspace.Map.Ingame.Map.ChildAdded:Connect(function(v273) --[[ Line: 1521 ]]
								-- upvalues: v272 (copy)
								if v273.Name == "Generator" or v273.Name == "FakeGenerator" then
									v272(v273);
								end;
							end);
							for _, v275 in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
								if v275.Name == "Generator" or v275.Name == "FakeGenerator" then
									v272(v275);
								end;
							end;
							l_RunService_0:BindToRenderStep("ObservantTeleportValidation", 1, function() --[[ Line: 1534 ]]
								-- upvalues: v253 (copy), l_RunService_0 (ref)
								local l_pairs_0 = pairs;
								local v277 = v253.Behavior.Generators or {};
								for v278, v279 in l_pairs_0(v277) do
									if not v253.Behavior.Generators then
										l_RunService_0:UnbindFromRenderStep("ObservantTeleportValidation");
										return;
									else
										local function _(v280, v281, v282) --[[ Line: 1541 ]] --[[ Name: changeProp ]]
											if v280[v281] ~= v282 then
												v280[v281] = v282;
											end;
										end;
										local v284 = (v278:GetPivot().Position - v253.Rig.PrimaryPart.Position).Magnitude < v253.Config.ObservantMinDistance;
										local l_Button_0 = v279.Button.Button;
										local l_Highlight_1 = v278:FindFirstChildOfClass("Highlight");
										local v287 = v284 and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop;
										if l_Highlight_1.DepthMode ~= v287 then
											l_Highlight_1.DepthMode = v287;
										end;
										if l_Button_0:GetAttribute("Paused") ~= v284 then
											l_Button_0:SetAttribute("Paused", v284);
											if v284 then
												v279.Button:OnMouseLeft();
											end;
										end;
										v287 = v284 and Color3.new(0.4, 0.4, 0.4) or Color3.new(1, 1, 1);
										if l_Button_0.ImageColor3 ~= v287 then
											l_Button_0.ImageColor3 = v287;
										end;
										v287 = not v284;
										if l_Button_0.Interactable ~= v287 then
											l_Button_0.Interactable = v287;
										end;
									end;
								end;
							end);
							return;
						else
							v253.Behavior.RevertObservance(v253, false);
						end;
					end;
				end;
				return;
			end;
		end
	}
};
v11.ObservantUse = function(v288, v289) --[[ Line: 1580 ]] --[[ Name: ObservantUse ]]
	-- upvalues: v15 (copy), l_StunProtectionVFX_0 (copy), l_ReplicatedStorage_0 (copy), v14 (copy), v19 (copy), v18 (copy)
	if v289 then
		local v290 = v289:FindFirstChild("Positions") and v289.Positions:GetChildren() and v289.Positions.Center.CFrame or v289:GetPivot();
		v288.Cache.Animations.Observant:Play();
		v288.Behavior.ToggleGeneratorAura(v288, false, v289);
		v288.AbilitiesDisabled = true;
		local v291 = v288.Behavior.ObservantWindupVFX(v288);
		local function v296() --[[ Line: 1595 ]] --[[ Name: destroyVFX ]]
			-- upvalues: v291 (copy)
			local l_ipairs_2 = ipairs;
			local v293 = v291 or {};
			for _, v295 in l_ipairs_2(v293) do
				v295:Destroy();
			end;
		end;
		local v297 = v15:Play(v288.Config.Sounds.ObservantTeleportChannel, {
			Parent = v288.Rig.PrimaryPart, 
			RollOffMaxDistance = 45
		});
		local v298 = nil;
		do
			local l_v298_0 = v298;
			local v308 = task.delay(v288.Config.ObservantTeleportWindup, function() --[[ Line: 1605 ]]
				-- upvalues: v296 (copy), v288 (copy), l_StunProtectionVFX_0 (ref), v290 (copy), l_ReplicatedStorage_0 (ref), v14 (ref), l_v298_0 (ref)
				v296();
				local v300 = nil;
				v288.Rig:SetAttribute("StunnedDisabled", true);
				v300 = l_StunProtectionVFX_0.StunProtection:Clone();
				v300.Parent = v288.Rig.PrimaryPart;
				task.delay(1.5, function() --[[ Line: 1615 ]]
					-- upvalues: v288 (ref), v300 (ref)
					v288.Rig:SetAttribute("StunnedDisabled", nil);
					v300.Spawn.Enabled = false;
					game.Debris:AddItem(v300, v300.Spawn.Lifetime.Max);
				end);
				v288.Behavior.Teleport(v288, v290);
				v288:PlayVoiceline("Teleport", {
					Priority = 5
				});
				local v301 = require(l_ReplicatedStorage_0.Modules.Actors);
				for _, v303 in pairs(v301.CurrentActors) do
					if v303.ActorType == "Survivor" and v303.Rig and v303.Rig.PrimaryPart then
						local l_Magnitude_1 = (v290.Position - v303.Rig.PrimaryPart.Position).Magnitude;
						for v305, v306 in ipairs(v288.Config.ObservantStatusThresholds) do
							if l_Magnitude_1 < v306 then
								local v307 = v305 - 1;
								if v307 > 0 then
									v14:ApplyStatus(v303.Rig, "Hallucination", {
										Level = v307, 
										Duration = v288.Config.ObservantStatusDuration, 
										Killer = v288
									});
									break;
								else
									break;
								end;
							end;
						end;
					end;
				end;
				l_v298_0:Disconnect();
			end);
			l_v298_0 = v288.Rig:GetAttributeChangedSignal("Stunned"):Connect(function() --[[ Line: 1651 ]]
				-- upvalues: v288 (copy), l_v298_0 (ref), v308 (copy), v296 (copy), v297 (copy)
				if v288.Rig:GetAttribute("Stunned") then
					if l_v298_0 then
						l_v298_0:Disconnect();
					end;
					task.cancel(v308);
					v296();
					if v297 then
						v297:Destroy();
					end;
				end;
			end);
			v19:CreateSpeedMultiplier(v288.Rig, 0, "ObservantTeleporting", v288.Config.ObservantTeleportWindup + v288.Config.ObservantTeleportEndlag, true);
			v288.Behavior.RevertObservance(v288, true);
			v18:FireClientConnection(v288.Player, ("%*ObservantTeleport"):format(v288.Player.Name), "REMOTE_EVENT");
		end;
	end;
end;
v11.DetonateVoidstar = function(v309, v310, v311, v312) --[[ Line: 1673 ]] --[[ Name: DetonateVoidstar ]]
	-- upvalues: l_RunService_0 (copy), v13 (copy), v19 (copy), l_Debris_0 (copy), l_TweenService_0 (copy), v23 (copy), l_Players_0 (copy), v18 (copy)
	assert(l_RunService_0:IsServer(), "what are you doing");
	assert(v310, "no voidstar :(");
	assert(v310.State == "Running", "voidstar is already go boom boom");
	assert(v309, "use dot notation when calling");
	v309.Behavior.VoidstarExplosionVFX(v309, v310.PreviousCFrame);
	local v313 = v309.Config.NovaExplosionRadius / (v311 and 1.5 or 1);
	local l_PreviousCFrame_0 = v310.PreviousCFrame;
	local v315 = v309.Config.NovaExplosionKnockback or 440;
	local _ = v13:CreateHitbox(v309.Player, {
		Size = Vector3.new(1, 1, 1, 0) * v313, 
		CFrame = l_PreviousCFrame_0, 
		Damage = v309.Config.NovaExplosionDamage, 
		Time = 0.1, 
		HitMultiple = true, 
		Knockback = 0, 
		ExecuteOnKill = false, 
		PredictVelocity = false, 
		Shape = Enum.PartType.Ball, 
		Connections = {
			Hit = function(v316) --[[ Line: 1704 ]] --[[ Name: Hit ]]
				-- upvalues: v19 (ref), l_PreviousCFrame_0 (copy), v312 (copy), v313 (copy), l_Debris_0 (ref), v315 (copy), l_TweenService_0 (ref), v309 (copy), v23 (ref)
				local l_PrimaryPart_1 = v316.PrimaryPart;
				local l_v19_Actor_0 = v19:GetActor(v316);
				local v319 = l_v19_Actor_0 and l_v19_Actor_0.GetPivot and l_v19_Actor_0:GetPivot() or v316.PrimaryPart.CFrame;
				local l_Magnitude_2 = (l_PreviousCFrame_0.Position - v319.Position).Magnitude;
				local v321 = v312 and 1.35 or math.clamp(1 - l_Magnitude_2 / v313, 0, 1);
				local v322 = Instance.new("BodyPosition", l_PrimaryPart_1);
				l_Debris_0:AddItem(v322, 0.35);
				v322.Position = l_PreviousCFrame_0.Position;
				v322.MaxForce = Vector3.new(10000, 7000, 10000, 0);
				v322.P = v315 * 1500 * (v321 / 2 + 0.5);
				v322.D = 1200 - v315;
				task.delay(0.35, function() --[[ Line: 1720 ]]
					-- upvalues: l_PrimaryPart_1 (copy)
					if l_PrimaryPart_1 then
						local l_l_PrimaryPart_1_0 = l_PrimaryPart_1;
						l_l_PrimaryPart_1_0.AssemblyLinearVelocity = l_l_PrimaryPart_1_0.AssemblyLinearVelocity / 1000;
					end;
				end);
				local v324 = 0.5 + v321;
				local l_v19_SpeedMultiplier_3 = v19:CreateSpeedMultiplier(v316, 0.4 - v321 / 4, "VoidstarExplosion", v324);
				l_TweenService_0:Create(l_v19_SpeedMultiplier_3, TweenInfo.new(v324), {
					Value = 1
				}):Play();
				v23:IncrementActorStats(v309.Player, {
					Action = "Hit Survivor with Nova", 
					RewardType = "Easy" .. "KillerAction"
				});
			end
		}
	});
	for _, v328 in ipairs(l_Players_0:GetPlayers()) do
		local v329 = v328.Character and v328.Character.PrimaryPart and v328.Character.PrimaryPart.Position;
		local v330 = v329 and (v310.PreviousCFrame.Position - v329).Magnitude;
		local v331 = v309.Config.NovaExplosionRadius * 2;
		if v330 and v330 < v331 then
			v18:FireClientConnection(v328, "ApplyCameraShake", "REMOTE_EVENT", math.clamp(v331 - v330, 0, v331) / v331 * 0.5, 0.7);
		end;
	end;
	v310:Destroy();
end;
v11.RevertObservance = function(v332, v333) --[[ Line: 1750 ]] --[[ Name: RevertObservance ]]
	-- upvalues: l_RunService_0 (copy), v19 (copy), v18 (copy)
	if l_RunService_0:IsServer() then
		v332.Behavior.ToggleObservantVFX(v332, false);
		if not v332.Behavior.Observing then
			return;
		else
			if v332.ObservantConnection then
				v332.ObservantConnection:Disconnect();
				v332.ObservantConnection = nil;
			end;
			l_RunService_0:UnbindFromRenderStep("ObservantTeleportValidation");
			v332.Behavior.Observing = false;
			v332:SetCooldownOf("Observant", v332.Config.ObservantC00ldown / (not v333 and 2 or 1));
			v332.DisabledAbilities = nil;
			v332.AbilitiesDisabled = true;
			v19:CreateSpeedMultiplier(v332.Rig, 1, "NoliObserving", 0);
			task.delay(v333 and v332.Config.ObservantTeleportWindup + v332.Config.ObservantTeleportEndlag or 0.5, function() --[[ Line: 1778 ]]
				-- upvalues: v332 (copy)
				v332.AbilitiesDisabled = false;
			end);
			return;
		end;
	else
		if l_RunService_0:IsClient() then
			if not v332.Behavior.Generators then
				return;
			else
				v332.Animations.ObservantStart:Stop(0.15);
				v332.Animations.ObservantLoop:Stop(0.15);
				local l_pairs_1 = pairs;
				local v335 = v332.Behavior.Generators or {};
				for _, v337 in l_pairs_1(v335) do
					if v337.Button then
						v337.Button:Destroy();
					end;
				end;
				table.clear(v332.Behavior.Generators);
				v332.Behavior.Generators = nil;
				if v332.Behavior.AddedGeneratorConnection then
					v332.Behavior.AddedGeneratorConnection:Disconnect();
				end;
				v18:FireConnection("DisableSprinting", "NoliObserving", false);
			end;
		end;
		return;
	end;
end;
v11.VoidstarExplosionVFX = function(v338, v339) --[[ Line: 1809 ]] --[[ Name: VoidstarExplosionVFX ]]
	-- upvalues: v19 (copy), v15 (copy)
	local l_Explosion_0 = v338.Config.NovaProjectile:FindFirstChild("Explosion");
	if l_Explosion_0 and l_Explosion_0.ClassName == "Attachment" then
		local v341 = l_Explosion_0:Clone();
		v341.Parent = workspace.Terrain;
		v341.WorldCFrame = v339;
		v19:EmitParticles(v341);
		v15:Play(v338.Config.Sounds.Explosion, {
			Parent = v341, 
			RollOffMaxDistance = 60
		});
		game.Debris:AddItem(v341, 6);
	end;
end;
v11.Teleport = function(v342, v343) --[[ Line: 1827 ]] --[[ Name: Teleport ]]
	-- upvalues: l_Debris_0 (copy), v19 (copy)
	local v344 = typeof(v343) == "Vector3" and CFrame.new(v343) or v343;
	local function v348(v345) --[[ Line: 1832 ]] --[[ Name: findGroundPosition ]]
		local v346 = RaycastParams.new();
		v346.CollisionGroup = "Killers";
		v346.FilterDescendantsInstances = {
			workspace.Map.Ingame
		};
		v346.FilterType = Enum.RaycastFilterType.Include;
		v346.RespectCanCollide = true;
		local v347 = workspace:Raycast(v345, Vector3.new(0, -10, 0, 0), v346);
		return v347 and v347.Position or v345 - Vector3.new(0, 10, 0, 0);
	end;
	local l_ObservantTeleportVFX_0 = v342.Config.ObservantTeleportVFX;
	if l_ObservantTeleportVFX_0 then
		if l_ObservantTeleportVFX_0:FindFirstChild("In") then
			local v350 = l_ObservantTeleportVFX_0.In:Clone();
			v350.Position = v348(v342.Rig.PrimaryPart.Position) + Vector3.new(0, 0.05999999865889549, 0, 0);
			v350.Parent = workspace.Map.Ingame;
			l_Debris_0:AddItem(v350, 6);
			v19:EmitParticles(v350);
		end;
		if l_ObservantTeleportVFX_0:FindFirstChild("Out") then
			local v351 = v342.Config.ObservantTeleportVFX.Out:Clone();
			v351.Position = v348(v344.Position) + Vector3.new(0, 0.05999999865889549, 0, 0);
			v351.Parent = workspace.Map.Ingame;
			l_Debris_0:AddItem(v351, 6);
			v19:EmitParticles(v351);
		end;
	end;
	local l_ipairs_3 = ipairs;
	local v353 = v342.Cache.Trails or {};
	for _, v355 in l_ipairs_3(v353) do
		v355.Enabled = false;
		v355:Clear();
	end;
	v342.Rig.PrimaryPart.CFrame = v344;
	l_ipairs_3 = ipairs;
	v353 = v342.Cache.Trails or {};
	for _, v357 in l_ipairs_3(v353) do
		v357.Enabled = true;
	end;
end;
v11.ObservantWindupVFX = function(v358) --[[ Line: 1880 ]] --[[ Name: ObservantWindupVFX ]]
	-- upvalues: l_TweenService_0 (copy)
	local v359 = {};
	local v360 = {};
	local v361 = {
		Glitch1 = 0.25, 
		Glitch2 = 0.75, 
		Star = 1.06
	};
	if v358.Rig:FindFirstChild("Noli") then
		for _, v363 in ipairs(v358.Config.ObservantTeleportVFX.BodyParts:GetChildren()) do
			if v363:IsA("ParticleEmitter") then
				for _, v365 in ipairs(v358.Rig.Noli:GetChildren()) do
					if v365:IsA("BasePart") then
						local v366 = v363:Clone();
						v366.Parent = v365;
						v366.Enabled = false;
						table.insert(v360, v366);
						v359[v366.Name] = v359[v366.Name] or {};
						table.insert(v359[v366.Name], v366);
					end;
				end;
			end;
		end;
	end;
	for v367, v368 in pairs(v361) do
		task.delay(v368, function() --[[ Line: 1906 ]]
			-- upvalues: v359 (copy), v367 (copy)
			local l_ipairs_4 = ipairs;
			local v370 = v359[v367] or {};
			for _, v372 in l_ipairs_4(v370) do
				if not v372 or not v372.Parent then
					return;
				else
					v372.Enabled = true;
				end;
			end;
		end);
	end;
	local v373 = v358.Config.ObservantTeleportVFX.BodyParts.Highlight:Clone();
	v373.Parent = v358.Rig;
	v373.Enabled = true;
	l_TweenService_0:Create(v373, TweenInfo.new(v358.Config.ObservantTeleportWindup, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		FillTransparency = 3
	}):Play();
	table.insert(v360, v373);
	return v360;
end;
v11.ToggleObservantVFX = function(v374, v375) --[[ Line: 1924 ]] --[[ Name: ToggleObservantVFX ]]
	if not v374.Rig.PrimaryPart then
		return;
	else
		local v376 = v374.Rig:FindFirstChild("Noli") and v374.Rig.Noli:FindFirstChild("Glow");
		local v377 = v376 and v376:FindFirstChild("HalluMouth");
		local v378 = v376 and v376:FindFirstChild("HalluEye");
		if v377 and v378 then
			v377:FindFirstChildOfClass("Beam").Enabled = v375;
			v378:FindFirstChildOfClass("Beam").Enabled = v375;
		end;
		return;
	end;
end;
v11.ToggleGeneratorAura = function(v379, v380, v381) --[[ Line: 1938 ]] --[[ Name: ToggleGeneratorAura ]]
	-- upvalues: l_RunService_0 (copy), v15 (copy), l_TweenService_0 (copy)
	assert(l_RunService_0:IsServer(), "what are you doing");
	local l_Map_1 = workspace.Map.Ingame:FindFirstChild("Map");
	local v383 = ("%*NoliWarning"):format(v379.Player.Name);
	local v384 = ("%*NoliAura"):format(v379.Player.Name);
	if not l_Map_1 then
		return;
	else
		for _, v386 in ipairs(l_Map_1:GetChildren()) do
			if v386.Name == "Generator" or v386.Name == "FakeGenerator" then
				if v380 then
					local v387 = v379.Config.ObservantWarningTemplate:Clone();
					v387.Name = v383;
					v387.CFrame = v386:GetPivot();
					v387.Parent = v386;
					local v388 = v379.Config.ObservantHighlightTemplate:Clone();
					v388.Parent = v386;
					v388.Name = v384;
					v388:AddTag(v379.Player.Name .. "GenHighlight");
					v15:Play(v379.Config.Sounds.ObservantGeneratorStart, {
						Parent = v387, 
						Name = "AuraWarningSound", 
						RollOffMaxDistance = 30
					});
					v15:Play(v379.Config.Sounds.ObservantGeneratorLoop, {
						Parent = v387, 
						Name = "AuraWarningSound", 
						Looped = true, 
						RollOffMaxDistance = 30
					});
				else
					local v389 = v381 == v386;
					local l_v386_FirstChild_0 = v386:FindFirstChild(v383);
					local l_v386_FirstChild_1 = v386:FindFirstChild(v384);
					if not l_v386_FirstChild_0 or not l_v386_FirstChild_1 then
						warn("nope");
					else
						l_v386_FirstChild_0.Name = l_v386_FirstChild_0.Name .. "_Done";
						l_v386_FirstChild_1.Name = l_v386_FirstChild_1.Name .. "_Done";
						while l_v386_FirstChild_0:FindFirstChild("AuraWarningSound") do
							l_v386_FirstChild_0.AuraWarningSound:Destroy();
						end;
						v15:Play(v379.Config.Sounds[v389 and "ObservantGeneratorWarning" or "ObservantGeneratorEnd"], {
							Parent = l_v386_FirstChild_0, 
							Name = "AuraDisappear", 
							RollOffMaxDistance = 45
						});
						if v389 then
							task.spawn(function() --[[ Line: 1985 ]]
								-- upvalues: v379 (copy), v383 (copy), v386 (copy), l_v386_FirstChild_1 (copy)
								local v392 = v379.Config.ObservantIncomingTemplate:Clone();
								v392.Name = v383 .. "Incoming";
								v392.CFrame = v386:GetPivot();
								v392.Parent = v386;
								game.Debris:AddItem(v392, 5);
								task.wait(v379.Config.ObservantTeleportWindup);
								for _, v394 in ipairs(v392:GetDescendants()) do
									if v394:IsA("ParticleEmitter") then
										v394.Enabled = false;
									end;
								end;
								l_v386_FirstChild_1:Destroy();
							end);
						else
							l_TweenService_0:Create(l_v386_FirstChild_1, TweenInfo.new(0.7), {
								FillTransparency = 1, 
								OutlineTransparency = 1
							}):Play();
							game.Debris:AddItem(l_v386_FirstChild_1, 1);
						end;
						for _, v396 in ipairs(l_v386_FirstChild_0:GetDescendants()) do
							if v396:IsA("ParticleEmitter") then
								v396.Enabled = false;
							end;
						end;
						game.Debris:AddItem(l_v386_FirstChild_0, 5);
					end;
				end;
			end;
		end;
		return;
	end;
end;
v11.ToggleTendril = function(v397, v398) --[[ Line: 2021 ]] --[[ Name: ToggleTendril ]]
	local l_TentacleBase_0 = v397.Rig["Right Arm"]:FindFirstChild("TentacleBase");
	if l_TentacleBase_0 then
		for _, v401 in ipairs(l_TentacleBase_0:GetDescendants()) do
			if v401:IsA("Beam") or v401:IsA("ParticleEmitter") or v401:IsA("Trail") then
				v401.Enabled = v398;
			end;
		end;
	end;
end;
v11.EnableVoidstar = function(v402) --[[ Line: 2032 ]] --[[ Name: EnableVoidstar ]]
	-- upvalues: v19 (copy), v15 (copy)
	assert(v402, "must pass killerInfo as argument");
	if v402.Behavior.VoidstarEnabled then
		return;
	else
		v402.Behavior.VoidstarEnabled = true;
		local l_Rig_1 = v402.Rig;
		local v404 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
		if v404 then
			v404.Transparency = 0;
			v404.Main.Main.Enabled = true;
			v19:EmitParticles(v19:MergeTables({
				v404.Appear1, 
				v404.Appear2
			}, v404.AppearT:GetChildren()));
			v15:Play(v402.Config.Sounds.VoidstarEnable, {
				Parent = v404, 
				Volume = 0.2, 
				RollOffMaxDistance = 13
			});
		end;
		return;
	end;
end;
v11.DisableVoidstar = function(v405) --[[ Line: 2050 ]] --[[ Name: DisableVoidstar ]]
	assert(v405, "must pass killerInfo as argument");
	if not v405.Behavior.VoidstarEnabled then
		return;
	else
		v405.Behavior.VoidstarEnabled = false;
		local l_Rig_2 = v405.Rig;
		local v407 = l_Rig_2 and l_Rig_2:FindFirstChild("Voidstar");
		if v407 then
			v407.Main.Main.Enabled = false;
			v407.Main.Main:Clear();
			v407.Transparency = 1;
		end;
		return;
	end;
end;
return v11;