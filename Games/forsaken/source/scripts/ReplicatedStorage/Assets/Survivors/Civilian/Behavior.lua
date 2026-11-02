local v0 = {}
local v1 = require(game.ReplicatedStorage.Modules.Sounds)
local v2 = require(game.ReplicatedStorage.Modules.Util)
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v4 = require(game.ReplicatedStorage.Modules.Statuses)
local v5 = require(game.ReplicatedStorage.Modules.Network)
local function inMemoriam(duration)
	if game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam") then
		return
	end

	duration = duration or 3
	local ui = script.InMemoriam:Clone()


	local quotes = {
		"DOD.",
		"Died of Death.",
		"Sadly passed away of Death.",
		"Was diagnosed with Death.",
		"They were a good civilian, sadly Died of Death.",
		"Is no longer with us, the cause is Death.",
		"Death wanted them to Die.",
		"Rest in peace, Dying of Death is unfortunate.",
		"Contracted a severe case of death.",
		"You'll be missed."
	}


	ui.Quote.Text = quotes[math.random(1, #quotes)]


	ui.Username.Text = game.Players.LocalPlayer.Name


	ui.Shedletsky.ImageTransparency = 1
	ui.Quote.TextTransparency = 1
	ui.Username.TextTransparency = 1


	ui.Parent = game.Players.LocalPlayer.PlayerGui.TemporaryUI
	game.Debris:AddItem(ui, duration)


	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://1838457617"
	sound.Volume = 0.3
	sound.PlayOnRemove = false
	sound.Parent = ui
	sound:Play()


	for _, soundGroup in pairs(game.SoundService:GetChildren()) do
		if soundGroup:IsA("SoundGroup") and soundGroup.Volume > 0 then
			local originalVolume = soundGroup.Volume
			soundGroup.Volume = 0
			ui.AncestryChanged:Connect(function(_, parent)
				if not parent then
					soundGroup.Volume = originalVolume
				end
			end)
		end
	end


	task.delay(0.5, function()
		local tweenInfo = TweenInfo.new(0.75)
		game.TweenService:Create(ui.Shedletsky, tweenInfo, { ImageTransparency = 0 }):Play()
		game.TweenService:Create(ui.Quote, tweenInfo, { TextTransparency = 0 }):Play()
		game.TweenService:Create(ui.Username, tweenInfo, { TextTransparency = 0 }):Play()
	end)
end
local function v17(v14, v15)
	if v15.Name == "1x1x1x1Zombie" then
		v4:ApplyStatus(v14.Rig, "Speed", {
			Stackable = true,
			MaxLevel = 3,
			Level = v14.Config.ZombieKillSpeedLevel,
			Duration = v14.Config.ZombieKillSpeedDuration
		})
		return true
	else
		return
	end
end
local function explodeShockwave(shockwavePart, v22)

	if v22.Config.ExplosionTemplate and v22.Config.ExplosionTemplate:IsA("BasePart") then
		local explosionClone = v22.Config.ExplosionTemplate:Clone()
		explosionClone.CFrame = shockwavePart.CFrame
		explosionClone.Parent = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") or workspace

		v1:Play(v22.Config.Sounds.RevolverHit, {
			Parent = explosionClone,
			RollOffMaxDistance = 60,
			Volume = 1
		})

		local emitters = {}
		for i = 1, 5 do
			local emitter = explosionClone:FindFirstChild("Explosion" .. i)
			if emitter and emitter:IsA("ParticleEmitter") then
				emitter.Enabled = true
				emitter.Rate = 0
				emitters[i] = emitter
			end
		end

		task.defer(function()
			if emitters[1] then emitters[1].Rate = 10 end
			if emitters[2] then emitters[2].Rate = 8 end
			if emitters[3] then emitters[3].Rate = 90 end
			if emitters[4] then emitters[4].Rate = 1 end
			if emitters[5] then emitters[5].Rate = 1 end
		end)

		task.delay(0.45, function()
			for _, emitter in pairs(emitters) do
				if emitter then emitter.Rate = 0 end
			end
		end)

		task.delay(3, function()
			explosionClone:Destroy()
		end)
	end

	local explosionDamage = v22.ExplosionDamage or 50

	v3:CreateHitbox(v22.Player, {
		Size = Vector3.new(13.5, 10, 13.5),
		CFrame = function()
			return shockwavePart.CFrame
		end,
		Damage = explosionDamage,
		Time = 0.04,
		Knockback = 0,
		HitMultiple = true,
		PredictVelocity = false,
		Connections = {
			Hit = function(target)
				v17(v22, target)
				v4:ApplyStatus(target, "Stunned", {
					Stackable = false,
					Level = 1,
					Duration = v22.Config.RevolverStunDuration
				})
			end
		}
	})
end
local function fadeOutShockwave(v25)
	for _, desc in pairs(v25:GetDescendants()) do
		if desc:IsA("BasePart") then
			desc.Transparency = 1
		elseif desc:IsA("ParticleEmitter") or desc:IsA("Trail") then
			desc.Enabled = false
		end
	end
end
v0.Abilities = {
	Punch = {
		LayoutOrder = 1,
		KeybindType = "AltAbility1",
		Icon = "rbxassetid://97428323453639",
		Callback = function(v6, _)

			if game["Run Service"]:IsServer() then
				v6.AbilitiesDisabled = true;
				task.delay(v6.Config.PunchWindupTime * 3, function()

					v6.AbilitiesDisabled = false;
				end);
				for _, v9 in pairs(v6.Rig:GetChildren()) do
					if v9.Name:find("Sword") and not v9:GetAttribute("Ignored") then
						v9.Transparency = 1;
					end;
				end;
				for _, v11 in pairs(v6.Rig.Sword:GetChildren()) do
					if v11:IsA("ParticleEmitter") or v11:IsA("Light") or v11:IsA("Highlight") then
						v11.Enabled = true;
					end;
				end;
				task.delay(v6.Config.PunchWindupTime + 0.3, function()

					for _, v13 in pairs(v6.Rig:GetChildren()) do
						if v13.Name:find("Sword") then
							game.TweenService:Create(v13, TweenInfo.new(0.5), {
								Transparency = 1
							}):Play();
						end;
					end;
					task.wait(0.3);
					for _, v15 in pairs(v6.Rig.Sword:GetChildren()) do
						if v15:IsA("ParticleEmitter") or v15:IsA("Light") or v15:IsA("Highlight") then
							v15.Enabled = false;
						end;
					end;
				end);
				v1:Play(v6.Config.Sounds.Unsheath, {
					Parent = v6.Rig.Sword
				});
				if not v6.TotalTimesStunned then
					v6.TotalTimesStunned = 0;
				end;
				task.delay(v6.Config.PunchWindupTime, function()

					v1:Play(v6.Config.Sounds.Slash, {
						Parent = v6.Rig.Sword
					});
					local _ = v3:CreateHitbox(v6.Player, {
						Size = Vector3.new(5, 6, 8),
						CFrameOffset = CFrame.new(0, 0, -2.25),
						Damage = v6.Config.SlashDamage,
						Time = 0.3,
						Knockback = 8,
						HitMultiple = false,
						Connections = {
							Hit = function(v16)

								v4:ApplyStatus(v16, "Stunned", {
									Duration = v6.Config.SlashStunTime
								});
								v1:Play(v6.Config.Sounds.Hit, {
									Parent = v6.Rig.Sword
								});
								v1:PlayVoiceline(v6, "SlashHit", {
									Priority = 1
								});
								v6:ChangeExpression("StunnedKiller", 4);
								local l_v6_0 = v6;
								l_v6_0.TotalTimesStunned = l_v6_0.TotalTimesStunned + 1;
								if v6.TotalTimesStunned == 3 then
									require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v6.Player, "ShedletskyStunner");
								end;
								if tostring(v16.Parent) == "Killers" then
									require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v6.Player, {
										Action = "Punched Killer as Civilian",
										RewardType = "Offensive"
									});
								end;
							end
						}
					});
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v6.Animations.Slash:Play(0.1);
					v5:FireConnection("DisableSprinting", "ShedletskySlash", true);
					local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v6.Rig, 0.01, "StunningKiller");
					task.delay(v6.Config.PunchWindupTime + 0.75, function()

						v5:FireConnection("DisableSprinting", "ShedletskySlash", false);
						l_v2_SpeedMultiplier_0:Destroy();
					end);
				end;
				return;
			end;
		end
	},
	Revolver = {
		LayoutOrder = 2,
		Icon = "rbxassetid://112065267803856",
		KeybindType = "AltAbility2",
		Callback = function(v22)
			if game["Run Service"]:IsServer() then
				v22.AbilitiesDisabled = true
				if v22.Rig:FindFirstChild("Revolver") then
					v22.Rig.Revolver.Transparency = 0
				end

				v1:Play(v22.Config.Sounds.RevolverActivate, {
					Parent = v22.Rig.PrimaryPart,
					PlaybackSpeed = Random.new():NextNumber(0.975, 1.025),
					RollOffMaxDistance = 65,
					Volume = 0.75
				})

				task.delay(0.9, function()
					if v22.Rig:GetAttribute("Stunned") then return end

					local killers = workspace.Players:FindFirstChild("Killers")
					local survivors = workspace.Players:FindFirstChild("Survivors")
					local soloMode = false

					if killers and survivors then
						local killdroidCount = 0
						for _, killer in ipairs(killers:GetChildren()) do
							if killer:IsA("Model") and killer.Name == "Killdroid" then
								killdroidCount += 1
							end
						end

						local survivorCount = 0
						for _, survivor in ipairs(survivors:GetChildren()) do
							if survivor:IsA("Model") then
								survivorCount += 1
							end
						end

						if killdroidCount == 1 and survivorCount == 1 then
							soloMode = true
						end
					end

					local revolverCooldown = soloMode and 15 or 30
					v22.Config.RevolverCooldown = revolverCooldown
					v22.ExplosionDamage = soloMode and 125 or 50

					v1:Play(v22.Config.Sounds.RevolverShoot, {
						Parent = v22.Rig.PrimaryPart,
						PlaybackSpeed = Random.new():NextNumber(0.975, 1.025),
						Volume = 1
					})

					local v25 = v22.Config.ShockwaveTemplate:Clone()
					local primary = v25.PrimaryPart
					v25.Parent = workspace.Map.Ingame
					v25:SetPrimaryPartCFrame(v22.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, 2))

					local hitboxSize = Vector3.new(4.5, 3, 4.5)
					local bulletSpeed = v22.Config.BulletSpeed

					local goal = primary.CFrame * CFrame.new(0, 0, -bulletSpeed * v22.Config.BulletLifetime)
					game.Debris:AddItem(v25, v22.Config.BulletLifetime)

					local tween = game.TweenService:Create(primary, TweenInfo.new(v22.Config.BulletLifetime, Enum.EasingStyle.Linear), {
						CFrame = goal
					})
					tween:Play()

					local hasExploded = false
					local activeProjectileHitbox
					activeProjectileHitbox = v3:CreateHitbox(v22.Player, {
						Size = hitboxSize,
						CFrame = function()
							return primary.CFrame
						end,
						Damage = 0,
						Time = v22.Config.BulletLifetime,
						Knockback = 5,
						HitMultiple = false,
						PredictVelocity = false,
						Connections = {
							Hit = function(hitPlayer)
								if hasExploded then return end
								hasExploded = true
								v1:Play(v22.Config.Sounds.RevolverTauntHit, {
									Parent = v22.Rig.PrimaryPart,
									Volume = 1
								})
								explodeShockwave(primary, v22)
								if activeProjectileHitbox and activeProjectileHitbox.Cancel then
									activeProjectileHitbox:Cancel()
									activeProjectileHitbox = nil
								end
								if v25 and v25.Parent then
									fadeOutShockwave(v25)
								end
							end
						}
					})

					local raycastParams = RaycastParams.new()
					raycastParams.FilterDescendantsInstances = {v22.Rig, v25}
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					raycastParams.IgnoreWater = true

					local connection
					connection = game:GetService("RunService").Heartbeat:Connect(function()
						if hasExploded then
							connection:Disconnect()
							return
						end
						local origin = primary.Position
						local direction = primary.CFrame.LookVector * 2
						local result = workspace:Raycast(origin, direction, raycastParams)
						if result and result.Instance and (not result.Instance:IsA("BasePart") or result.Instance.Transparency < 1) then
							hasExploded = true
							explodeShockwave(primary, v22)
							if activeProjectileHitbox and activeProjectileHitbox.Cancel then
								activeProjectileHitbox:Cancel()
								activeProjectileHitbox = nil
							end
							if v25 and v25.Parent == workspace.Map.Ingame then
								fadeOutShockwave(v25)
							end
							connection:Disconnect()
						end
					end)
				end)

				task.delay(2.2, function()
					if v22.Rig:FindFirstChild("Revolver") then
						game.TweenService:Create(
							v22.Rig.Revolver,
							TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{ Transparency = 1 }
						):Play()
					end
					v22.AbilitiesDisabled = false
				end)
			else
				if game["Run Service"]:IsClient() then
					v22.Animations.MassInfection:Play(0.175)
					v2:CreateSpeedMultiplier(v22.Player, 0.01, "MassInfection", 2, true)
				end
			end
		end
	}
}
v0.CreatedPost = function(_, characterData)
	if game["Run Service"]:IsClient() and characterData.Rig == game.Players.LocalPlayer.Character then
		local humanoid = characterData.Rig:WaitForChild("Humanoid", 2)
		humanoid.HealthChanged:Connect(function(health)
			if health <= 0 then
				inMemoriam(3)
			end
		end)

		local root = characterData.Rig.PrimaryPart
		if root then
			root:GetPropertyChangedSignal("Anchored"):Connect(function()
				if root.Anchored then
					inMemoriam(10)
				else
					if humanoid and humanoid.Health > 0 then
						local mem = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam")
						while mem do
							mem:Destroy()
							mem = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("InMemoriam")
						end
					end
				end
			end)
		end
	end
end
return v0