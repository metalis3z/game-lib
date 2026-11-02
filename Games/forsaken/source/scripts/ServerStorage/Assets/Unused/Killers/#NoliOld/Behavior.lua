--061game.ReplicatedStorage.Assets.Killers["#NoliRework"].Behavior

-- Decompiled by Krnl

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("Debris")
local v7 = {
	["enableBezierPreview"] = true
}
local v_u_8 = require(v1.Modules.Schematics.Lighting)
local v_u_9 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_10 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_11 = require(game.ReplicatedStorage.Modules.Sounds)
require(v1.Modules.Ragdolls)
local v_u_12 = require(v1.Modules.Network)
local v_u_13 = require(game.ReplicatedStorage.Modules.Util)
local v14 = require(v1.Modules.Device)
local v_u_14 = require(script.VoidstarClass)
local UserInputService = game:GetService("UserInputService")
local tap = false

local isTouching = false
local touchStartTime = 0
local touchStartPosition = nil

UserInputService.TouchStarted:Connect(function(input, processed)
	if processed then return end
	isTouching = true
	touchStartTime = tick()
	touchStartPosition = input.Position
end)

UserInputService.TouchEnded:Connect(function(input, processed)
	if processed then return end
	isTouching = false
	local duration = tick() - touchStartTime
	local distance = (input.Position - touchStartPosition).Magnitude
	if duration < 0.3 and distance < 20 then
		tap = true
		task.wait()
		tap = false
	end
end)
local function v23(v15, v16, v59) --[[ Line: 24 ]] --[[ Name: waitForInput ]]
	-- upvalues: v_u_2 (copy)
	local v17 = nil;
	local v18 = nil;
	if v16 then
		task.delay(v16, function() --[[ Line: 29 ]]
			-- upvalues: v17 (ref), v18 (ref)
			if v17 == nil then
				print("waitForInput timed out");
				v18:Disconnect();
				v18 = nil;
				v17 = Enum.KeyCode.A;
			end;
		end);
	end;
	for i, v in ipairs(v15) do
		if typeof(v) == "RBXScriptSignal" then
			local connection
			connection = v:Connect(function(...)
				v17 = ...;
				connection:Disconnect();
				print("detected input");
				return;
			end)
		elseif typeof(v) == "boolean" then
			print("boolean")
			while v59.Rig.Parent ~= nil do
				--print(tostring(v) .. " " .. tostring(game:GetService("RunService"):IsClient()))
				task.wait()
				if v59.HeldAbilities.Stab ~= nil then
					v17 = "boolean"
					print("detected input");
					return
				end
			end
		elseif typeof(v) == "table" then
			print("table")
			game.ReplicatedStorage.Modules.Network:WaitForChild("RemoteEvent").OnClientEvent:Connect(function(...)
				print({...})
				for ind, val in ipairs({...}) do
					if val == v[i] then
						v17 = {...}
						print("detected input");
						return
					end
				end
			end)
		end
	end
	v18 = v_u_2.InputBegan:Connect(function(v19, v20) --[[ Line: 39 ]]
		-- upvalues: v15 (copy), v17 (ref), v18 (ref)
		if v20 then
			return;
		else
			for _, v22 in pairs(v15) do
				if v19.KeyCode == v22 or v19.UserInputType == v22 then
					v17 = v19;
					v18:Disconnect();
					print("detected input");
					return;
				end;
			end;
			return;
		end;
	end);
	repeat
		task.wait();
	until v17 ~= nil;
end;
function v7.Created(_, p_u_15)
	-- upvalues: (copy) v_u_4, (copy) v_u_13
	if v_u_4:IsServer() then
		task.spawn(function()
			-- upvalues: (copy) p_u_15, (ref) v_u_13
			if not p_u_15.Cache then
				p_u_15.Cache = {}
			end
			p_u_15.Cache.ImplantAttackNoli = v_u_13:LoadAnimationFromID(p_u_15.Rig, p_u_15.Config.Animations.ImplantAttackNoli)
			p_u_15.Cache.StardrivenAttackNoli = v_u_13:LoadAnimationFromID(p_u_15.Rig, p_u_15.Config.Animations.StardrivenCharge2HitNoli)
			p_u_15.Cache.StardrivenNormalHit = v_u_13:LoadAnimationFromID(p_u_15.Rig, p_u_15.Config.Animations.StardrivenCharge1Hit)
		end)
	end
end
function v7.OnIntroduction(_, p16, p_u_17, p18)
	-- upvalues: (copy) v_u_8, (copy) v_u_13, (copy) v_u_5
	v_u_8:SetCustomLighting(p16.Config.IntroLighting)
	p_u_17.FakeCrown.Transparency = 0
	p_u_17.Voidstar.Transparency = 1
	p_u_17.VoidstarCrown.Transparency = 1
	local v_u_19 = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
	local v_u_20 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_20, (copy) v_u_19
		while v_u_20 do
			for v21, v22 in pairs(v_u_19.Voidstars:GetChildren()) do
				v22.CFrame = v22.CFrame * CFrame.Angles(0, v21 % 2 == 0 and 0.0225 or -0.0225, 0)
			end
			task.wait()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_20, (copy) v_u_19
		while v_u_20 do
			local v23 = v_u_19.Skybox
			v23.CFrame = v23.CFrame * CFrame.Angles(0, 0.004363323129985824, 0)
			task.wait()
		end
	end)
	local v_u_24 = v_u_13:CreateFOVMultiplier(v_u_5.LocalPlayer, 0.375, "NoliIntroScene", p18)
	task.delay(1.98, function()
		-- upvalues: (copy) v_u_24
		v_u_24.Value = 0.275
	end)
	task.delay(p18, function()
		-- upvalues: (ref) v_u_20, (copy) p_u_17, (ref) v_u_8
		v_u_20 = false
		p_u_17.FakeCrown.Transparency = 1
		p_u_17.VoidstarCrown.Transparency = 0
		p_u_17.Voidstar.Transparency = 0
		v_u_8:SetAsCurrentLighting()
	end)
end
function v7.OnExecution(_, p25, p_u_26)
	-- upvalues: (copy) v_u_12
	local v_u_27 = p25.Rig
	v_u_27["Right Arm"].TentacleBase.Beam.Enabled = false
	v_u_27["Right Arm"].TentacleBase.Beam.Enabled = true
	v_u_27.Voidstar.Transparency = 1
	task.delay(2.2, function()
		-- upvalues: (copy) v_u_27
		v_u_27.Voidstar.Transparency = 0
	end)
	task.delay(1.97, function()
		v_u_27["Right Arm"].TentacleBase.Beam.Enabled = false
	end)
	v_u_12:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", p_u_26, workspace:GetServerTimeNow() + 2.425, (("%*|%*|%*"):format((Vector3.new(0, 400, 0)).X, (Vector3.new(0, 400, 0)).Y, (Vector3.new(0, 400, 0)).Z)))
	task.delay(2.4, function()
		-- upvalues: (copy) p_u_26, (copy) v_u_27
		local v28 = p_u_26:FindFirstChild("Head")
		local v29 = p_u_26:FindFirstChild("Humanoid")
		if v29 then
			v29.BreakJointsOnDeath = false
			v29.Health = 0
			if v28 then
				v28:Destroy()
			end
			v_u_13:EmitParticlesFromAttachment(v_u_27.Voidstar.Crush)
		end
	end)
end
local v_u_97 = {
	Stab = {
		LayoutOrder = 1, 
		Icon = "rbxassetid://135239660832992", 
		KeybindType = "MainAbility", 
		Callback = function(v55) --[[ Line: 182 ]] --[[ Name: Callback ]]
			-- upvalues: v_u_4 (copy), v_u_11 (copy), v_u_9 (copy), v_u_13 (copy)
			if v_u_4:IsServer() then
				v55.AbilitiesDisabled = true;
				v_u_11:Play(v55.Config.Sounds.Swing, {
					Parent = v55.Rig.PrimaryPart, 
					PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
					Volume = 0.25
				});
				task.delay(0.5, function() --[[ Line: 189 ]]
					-- upvalues: v_u_9 (ref), v55 (copy), v_u_13 (ref), v_u_11 (ref)
					v55.Rig["Right Arm"].TentacleBase.Beam.Enabled = true
					local _ = v_u_9:CreateHitbox(v55.Player, {
						Size = Vector3.new(4.5, 6, 9, 0), 
						CFrameOffset = CFrame.new(0, 0, -2.5), 
						Damage = v55.Config.StabDamage, 
						Time = 0.2, 
						Knockback = 2, 
						HitMultiple = false, 
						ExecuteOnKill = true, 
						Connections = {
							Hit = function(v56, v57) --[[ Line: 201 ]] --[[ Name: Hit ]]
								-- upvalues: v_u_13 (ref), v_u_11 (ref), v55 (ref)
								v_u_13:CreateSpeedMultiplier(v56, 1.5, "HitSpeedBonus", 1.25);
								if v57 then
									v_u_11:Play(v55.Config.Sounds.Hit, {
										Parent = v55.Rig.PrimaryPart, 
										PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
										Volume = 0.25
									});
								end;
							end
						}
					});
				end);
				local changed = false
				v55.Rig["Right Arm"].TentacleBase.Beam.Changed:Connect(function()
					changed = true
				end)
				task.delay(1.65, function() --[[ Line: 212 ]]
					-- upvalues: v55 (copy)
					v55.AbilitiesDisabled = false;
				end);
				task.delay(1.1, function()
					if changed == false then
						v55.Rig["Right Arm"].TentacleBase.Beam.Enabled = false
					end
				end)
				return;
			else
				if v_u_4:IsClient() then
					v55.Animations.Stab:Play(0.175);
				end;
				return;
			end;
		end
	}, 
	Stardriven = {
		LayoutOrder = 2, 
		Icon = "rbxassetid://77714746717084", 
		KeybindType = "AltAbility1", 
		Callback = function(v59) --[[ Line: 228 ]] --[[ Name: Callback ]]
			-- upvalues: v_u_4 (copy), v_u_12 (copy), v_u_9 (copy), v_u_10 (copy), v_u_13 (copy), v14 (copy), v_u_2 (copy), v23 (copy), v_u_3 (copy)
			local l_Rig_0 = v59.Rig;
			local l_Config_0 = v59.Config;
			local l_Animations_0 = v59.Animations;
			if v_u_4:IsServer() then
				v59.AbilitiesDisabled = true;
				local v63 = 2;
				l_Rig_0["Right Arm"].TentacleBase.Beam.Enabled = true
				v_u_12:SetConnection("NoliOnDash", "REMOTE_EVENT", function(_) --[[ Line: 237 ]]
					-- upvalues: l_Config_0 (copy), v63 (ref), v_u_9 (ref), v59 (copy), v_u_10 (ref), v_u_13 (ref), v_u_12 (ref), l_Rig_0 (copy)
					local v65 = l_Config_0.StardrivenTokenData[v63];
					v63 = v63 - 1;
					local hit = false
					v_u_9:CreateHitbox(v59.Player, {
						Size = Vector3.new(4, 4, 7, 0), 
						CFrameOffset = CFrame.new(0, 0, -5), 
						Time = v65.Lifetime + 0.1, 
						Knockback = 0.5, 
						HitMultiple = false, 
						Damage = v65.Damage, 
						Connections = {
							Hit = function(v66, v67) --[[ Line: 250 ]] --[[ Name: Hit ]]
								-- upvalues: v59 (ref), l_Config_0 (ref), v_u_10 (ref), v_u_13 (ref), v63 (ref), v_u_12 (ref), l_Rig_0 (ref)
								hit = true
								if v67 then
									local l_v59_0 = v59;
									local v69 = {
										Duration = l_Config_0.StardrivenHallucinationDuration
									};
									v_u_10:ApplyStatus(v66, "Hallucination", v_u_13:MergeTables({
										Level = 1, 
										Hidden = true, 
										Stackable = true,
										Killer = v59
									}, v69));
									print(v63);
									if v63 == 1 then
										--task.delay(0.42, function()
										--	l_Rig_0["Right Arm"].TentacleBase.Beam.Enabled = false
										--end)
										v_u_12:FireClientConnection(v59.Player, "NoliStardrivenHit", "REMOTE_EVENT", "Normal");
										print("a");
										--v59.AbilitiesDisabled = false;
										return;
									else
										v59.AbilitiesDisabled = true
										l_Rig_0["Right Arm"].TentacleBase.Beam.Enabled = false
										v_u_12:FireClientConnection(v59.Player, "NoliStardrivenHit", "REMOTE_EVENT", "Slam");
										print("b");
										l_Rig_0.HumanoidRootPart.Anchored = true;
										v66.HumanoidRootPart.Anchored = true;
										l_Rig_0:SetAttribute("Invincible", true);
										v66:SetPrimaryPartCFrame(l_Rig_0.PrimaryPart.CFrame);
										l_v59_0 = v_u_13:LoadAnimationFromID(v66, l_Config_0.Animations.StardrivenCharge2HitVictim, true);
										v59.Cache.StardrivenAttackNoli:Play(0);
										l_v59_0:Play(0);
										task.delay(l_v59_0.Length - 0.1, function() --[[ Line: 279 ]]
											-- upvalues: v66 (copy)
											v66.HumanoidRootPart.Anchored = false;
										end);
										task.delay(v59.Cache.StardrivenAttackNoli.Length - 0.1, function() --[[ Line: 282 ]]
											-- upvalues: l_Rig_0 (ref)
											l_Rig_0.HumanoidRootPart.Anchored = false;
											v59.AbilitiesDisabled = false;
											l_Rig_0:SetAttribute("Invincible", false);
										end);
									end;
								end;
							end
						}
					});
					if v63 == 0 then
						if hit == false then
							v59.AbilitiesDisabled = false;
						end
					end
				end);
				return;
			else
				local v70 = 2;
				local v71 = 0;
				local l_v14_PlayerDevice_0 = v14:GetPlayerDevice();
				local l_StardrivenTendrilStart_0 = l_Animations_0.StardrivenTendrilStart;
				l_StardrivenTendrilStart_0:Play(0, 1, 1);
				task.wait(l_StardrivenTendrilStart_0.Length - 0.1);
				local l_StardrivenTendrilLoop_0 = l_Animations_0.StardrivenTendrilLoop;
				l_StardrivenTendrilLoop_0:Play(0, 1, 1);
				local v75 = v59.Config.StardrivenBar:Clone();
				v75.Outline.Fill.UIGradient.Offset = Vector2.new(0, 0);
				v75.Outline.Fill.UIGradient.Rotation = -75
				v75.Parent = v59.Player.PlayerGui:FindFirstChild("TemporaryUI");
				local l_v_u_13_SpeedMultiplier_0 = v_u_13:CreateSpeedMultiplier(l_Rig_0, 0.5, "StardrivenChargeSlowness");
				task.spawn(function() --[[ Line: 320 ]]
					-- upvalues: v75 (copy), v71 (ref)
					while v75.Visible do
						v75.Outline.Fill.UIGradient.Offset = Vector2.new(math.clamp(v71, 0, 1), 0);
						v75.Outline.Fill.UIGradient.Rotation = math.clamp(v71, -75, 75);
						print("ok");
						task.wait();
					end;
				end);
				if l_v14_PlayerDevice_0 == "PC" then
					v75.Title.Text = "Charge Stardriven (M2)";
					repeat
						if v_u_2:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
							v71 = v71 + 0.035;
							print(v71);
						end;
						task.wait();
					until v71 >= 1;
				elseif l_v14_PlayerDevice_0 == "Mobile" then
					v75.Title.Text = "Charge Stardriven (Touch)";
					repeat
						if isTouching then
							v71 = v71 + 0.035;
							print(v71);
						end;
						task.wait();
					until v71 >= 1;
				end
				v75.Visible = false;
				v75:Destroy();
				v71 = 1;
				local function v_u_93() --[[ Line: 347 ]] --[[ Name: dash ]]
					-- upvalues: v23 (ref), l_v_u_13_SpeedMultiplier_0 (copy), v70 (ref), l_Animations_0 (copy), v59 (copy), v_u_13 (ref), l_Rig_0 (copy), v_u_3 (ref), v_u_12 (ref), l_StardrivenTendrilLoop_0 (copy)
					v23({
						Enum.UserInputType.MouseButton1,
						tap
					}, nil, v59);
					l_v_u_13_SpeedMultiplier_0.Value = 1;
					local v77 = if v70 == 2 then l_Animations_0.StardrivenCharge1Start else l_Animations_0.StardrivenCharge2Start;
					local v78 = if v70 == 2 then l_Animations_0.StardrivenCharge1Loop else l_Animations_0.StardrivenCharge2Loop;
					v77:Play(0, 1, 1);
					v78:Play(0.125, 1, 1);
					local v79 = v59.Config.StardrivenTokenData[v70];
					local v_u_90 = v_u_13:ApplyVelocity(l_Rig_0, v79.Distance / 2, true, 0.1);
					v_u_3:Create(v_u_90, TweenInfo.new(0.1), {
						LineVelocity = v79.Distance
					}):Play();
					v_u_12:SetConnection("NoliStardrivenHit", "REMOTE_EVENT", function(v_u_91) --[[ Line: 376 ]]
						-- upvalues: v_u_90 (ref), l_Animations_0 (ref)
						v_u_90:Destroy();
						v_u_90 = nil;
						if v_u_91 == "Normal" then
							l_Animations_0.StardrivenCharge1Hit:Play(0);
						end;
					end);
					v_u_12:FireServerConnection("NoliOnDash", "REMOTE_EVENT");
					v70 = v70 - 1;
					task.wait(v79.Lifetime);
					l_v_u_13_SpeedMultiplier_0.Value = 0.5;
					local v_u_92 = nil;
					if v_u_90 then
						v_u_92 = v_u_3:Create(v_u_90, TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							LineVelocity = 0
						});
						v_u_92:Play();
					end;
					v78:Stop(0.125);
					if v70 == 0 then
						l_v_u_13_SpeedMultiplier_0:Destroy();
						l_StardrivenTendrilLoop_0:Stop(0.125);
					end;
					if v_u_92 then
						v_u_92.Completed:Wait();
						if v_u_90 then
							v_u_90:Destroy();
						end
					end;
				end;
				v_u_93();
				wait(0.2)
				v_u_93();
				return;
			end;
		end
	},
	["Implant"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://88651731892734",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_53, _)
			print(p_u_53.Animations)
			-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_14, (copy) v_u_9, (copy) v_u_13, (copy) v_u_2, (copy) v_u_3, (copy) v_u_6
			local v_u_54 = p_u_53.Rig
			local _ = p_u_53.Config
			local v_u_55 = p_u_53.Animations
			if v_u_4:IsServer() then
				v_u_12:SetConnection(("%*NoliImplant"):format(p_u_53.Player.Name), "REMOTE_EVENT", function(p56, p57, p58)
					-- upvalues: (copy) p_u_53, (ref) v_u_14, (copy) v_u_54, (ref) v_u_9, (ref) v_u_12
					
					if p56 == p_u_53.Player then
						local v59 = v_u_14.new(v_u_54.Voidstar, p_u_53)
						if p57 == "Normal" then
							local v_u_60 = false
							local v_u_61 = nil
							local v62 = v_u_9
							local v63 = p_u_53.Player
							local v66 = {
								["Damage"] = 15,
								["Knockback"] = 0,
								["HitMultiple"] = false,
								["Size"] = Vector3.new(7, 7, 7),
								["CFrameOffset"] = CFrame.new(0, 0, -3),
								["Time"] = 0.05,
								["Connections"] = {
									["Hit"] = function(p64, p65)
										-- upvalues: (ref) v_u_60, (ref) v_u_61
										if p65 then
											v_u_60 = true
											v_u_61 = p64
										end
									end
								}
							}
							v62:CreateHitbox(v63, v66)
							task.wait(0.05)
							if v_u_60 then
								v_u_12:FireClientConnection(p56, "PlayNoliImplantAnimation", "REMOTE_EVENT", nil)
								v59:ImplantInside(v_u_61)
							else
								v_u_12:FireClientConnection(p56, "PlayNoliImplantAnimation", "REMOTE_EVENT", "Implant")
								task.delay(0.35, v59.Implant, v59)
							end
						else
							p_u_53.AbilitiesDisabled = true;
							v_u_12:FireClientConnection(p56, "PlayNoliImplantAnimation", "REMOTE_EVENT", "ImplantThrow")
							p_u_53:SetCooldownOf("Implant", p_u_53.Config.ImplantCooldown)
							p_u_53.AbilitiesDisabled = false
							v59:Throw(p58)
							return
						end
					else
						return
					end
				end)
			else
				local v_u_67 = p_u_53.Animations.ImplantThrowLoop
				local v68 = v_u_13:CreateSpeedMultiplier(v_u_54, 0, "PlacingNoliTrap")
				local v69 = 0.2
				local v70 = 10
				local v71 = false
				local v72 = nil
				local v73 = false
				local v74 = 1.5
				while true do
					task.wait(v69)
					if not v_u_2:IsKeyDown(Enum.KeyCode.E) and p_u_53.HeldAbilities.Implant == nil then
						print("broke")
						break
					end
					v73 = true
					v69 = 0.1
					v_u_54.HumanoidRootPart.ImplantLine.Enabled = true
					local _ = v_u_54.HumanoidRootPart.ImplantLineStart
					local v75 = v_u_54.HumanoidRootPart.ImplantLineEnd
					if v70 >= 75 then
						v71 = true
					elseif v70 <= 10 then
						v71 = false
					end
					local v76 = v70 + (v71 and -5 or 5)
					v70 = math.clamp(v76, 10, 75)
					local v77 = v75.Position.X
					local v78 = v75.Position.Y
					local v79 = -v70
					local v_u_90 = Vector3.new(v77, v78, v79)
					v72 = v72 or v75.Position
					v_u_3:Create(v75, TweenInfo.new(0.1), {
						["Position"] = v_u_90
					}):Play()
					v_u_67:Play(0.1)
				end
				if v72 then
					v_u_54.HumanoidRootPart.ImplantLineEnd.Position = v72
					v_u_54.HumanoidRootPart.ImplantLine.Enabled = false
				end
				v_u_12:SetConnection("PlayNoliImplantAnimation", "REMOTE_EVENT", function(p81)
					-- upvalues: (copy) v_u_55, (copy) v_u_67, (ref) v_u_12
					if v_u_55[p81] then
						v_u_67:Stop(0)
						v_u_55[p81]:Play(0)
					end
					v_u_12:RemoveConnection("PlayNoliImplantAnimation")
				end)
				if v73 then
					v_u_12:FireServerConnection(("%*NoliImplant"):format(p_u_53.Player.Name), "REMOTE_EVENT", "Dash", v70)
					v74 = 1
				else
					v_u_12:FireServerConnection(("%*NoliImplant"):format(p_u_53.Player.Name), "REMOTE_EVENT", "Normal", 0)
				end
				v_u_6:AddItem(v68, v74)
			end
		end
	},
	["Hallucination"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://107117927290267",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_82)
			-- upvalues: (copy) v_u_13, (copy) v_u_11, (copy) v_u_10
			if game["Run Service"]:IsServer() then
				p_u_82.AbilitiesDisabled = true
				local v_u_83 = p_u_82.Rig
				local v_u_94 = v_u_83.HumanoidRootPart
				local v_u_95 = v_u_13:GetClosestPlayerFromPosition(v_u_94.Position, {
					["MaxDistance"] = p_u_82.Config.HallucinationMaxDistance,
					["PlayerSelection"] = "Survivors",
					["OverrideUndetectable"] = true,
					["ReturnTable"] = true
				})
				v_u_11:Play(p_u_82.Config.Sounds.Hallucination, {
					["Volume"] = 0.35,
					["Parent"] = v_u_94
				})
				task.delay(1.583, function()
					-- upvalues: (copy) v_u_83
					v_u_83.Voidstar.Transparency = 1
					task.delay(1.284, function()
						-- upvalues: (ref) v_u_83
						v_u_83.Voidstar.Transparency = 0
					end)
				end)
				for _, v_u_96 in pairs(v_u_95) do
					v_u_13:RevealPlayerAuraTo(p_u_82.Player, v_u_96.Player, p_u_82.Config.HallucinationAuraRevealDuration)
					v_u_10:ApplyStatus(v_u_96.Player, "Hallucination", {
						["Level"] = math.random(1, 3),
						["Duration"] = p_u_82.Config.HallucinationDuration,
						["Hidden"] = true,
						Killer = p_u_82
					})
				end
				task.delay(1.65, function()
					-- upvalues: (copy) p_u_82
					p_u_82.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_82.Animations.Hallucination:Play(0.175)
			end
		end
	}
}
v7.Abilities = v_u_97
return v7

