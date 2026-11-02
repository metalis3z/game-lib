-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("AnalyticsService")
local v_u_1 = {
	["CurrentActors"] = {},
	["ActorAdded"] = nil
}
local v_u_2 = game:GetService("RunService")
v_u_2:IsClient()
local v_u_3 = v_u_2:IsServer()
local v_u_4 = require(game.ReplicatedStorage.Modules.Network)
local v_u_5 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_6 = require(game.ReplicatedStorage.Modules.Util)
local v_u_7 = require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication)
local v_u_8 = {
	["Killer"] = "Slasher",
	["Survivor"] = "Noob"
}
local v_u_9 = {
	Idle = "rbxassetid://129638189384850", 
	Walk = "rbxassetid://132899354288967", 
	Run = "rbxassetid://121839826674487", 
	InjuredIdle = "rbxassetid://84007749866979", 
	InjuredWalk = "rbxassetid://80983308429137", 
	InjuredRun = "rbxassetid://89269917717313"
}
function v_u_1.__len(p10)
	-- upvalues: (copy) v_u_1
	local v11 = 0
	for _, v12 in pairs(v_u_1.CurrentActors) do
		local v13 = v12.Rig
		if v13 then
			v13 = v12.Rig:FindFirstChild("Humanoid")
		end
		if p10.ActorName == v12.ActorName and (v13 and v13.Health > 0) then
			v11 = v11 + 1
		end
	end
	return v11
end
function v_u_1.CreateActor(_, p_u_14, p15, p16, p17)
	-- upvalues: (copy) v_u_1, (copy) v_u_8, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_7, (copy) v_u_2, (copy) v_u_6
	if not p16 then
		p16, p17 = v_u_1:GetEquippedActorInfo(p_u_14, p15)
	end
	print(p16)
	local v18
	if typeof(p16) == "Instance" and p16:IsA("Folder") then
		v18 = p16
	else
		local v19 = game.ReplicatedStorage.Assets:FindFirstChild((("%*s"):format((tostring(p15)))))
		v18 = not v19 or v19:FindFirstChild((tostring(p16)))
		if not v18 then
			local v20 = v_u_8[p15]
			v18 = v19:FindFirstChild((tostring(v20)))
		end
	end
	if not v18 or (not p_u_14.Character or (not p_u_14.Character.PrimaryPart or (p_u_14.Character.Humanoid.Health <= 0 or v_u_1.CurrentActors[p_u_14]))) then
		return
	end
	local v21 = v_u_1
	local v_u_22 = setmetatable({
		["Cache"] = {},
		["Cooldowns"] = {},
		["AbilityDisablers"] = {}
	}, v21)
	v_u_22.Player = p_u_14
	v_u_22.Folder = v18
	v_u_22.ActorType = p15
	v_u_22.ActorName = p16
	v_u_22.ActorSkin = p17
	v_u_1:ApplySkinDataToActorInfo(v_u_22)
	function v_u_22.IncrementCharges(_, p_u_23, p24, p25)
		-- upvalues: (ref) v_u_3, (copy) v_u_22, (ref) v_u_4, (copy) p_u_14
		if v_u_3 then
			local v_u_26 = v_u_22 and v_u_22.Behavior.Abilities
			if v_u_26 then
				v_u_26 = v_u_22.Behavior.Abilities[p_u_23]
			end
			if v_u_26 then
				if v_u_26.CurrentCharges then
					local v27 = v_u_26.CurrentCharges + p24
					local v28 = tonumber(p25) or (1 / 0)
					v_u_26.CurrentCharges = math.clamp(v27, 0, v28)
					local v29 = nil
					if v_u_26.Recharge and (v_u_26.CurrentCharges < v_u_26.Charges and not v_u_26.RechargeStartTime) then
						v_u_26.RechargeStartTime = tick()
						v_u_26.CurrentRechargeThread = task.delay(v_u_26.Recharge, function()
							-- upvalues: (copy) v_u_26, (ref) v_u_22, (copy) p_u_23
							v_u_26.CurrentRechargeThread = nil
							v_u_26.RechargeStartTime = nil
							v_u_22:IncrementCharges(p_u_23, 1, v_u_26.Charges)
						end)
						v29 = true
					elseif v_u_26.RechargeStartTime and v_u_26.CurrentCharges >= v_u_26.Charges then
						pcall(task.cancel, v_u_26.CurrentRechargeThread)
						v_u_26.CurrentRechargeThread = nil
						v_u_26.RechargeStartTime = nil
						v_u_26.ElapsedRecharge = nil
						v29 = false
					end
					v_u_4:FireClientConnection(p_u_14, "UpdateAbilityCharges", "REMOTE_EVENT", p_u_23, v_u_26.CurrentCharges, v29)
				end
			else
				return
			end
		else
			warn((("attempt to add charges to %* on client!"):format((tostring(p_u_23)))))
			return
		end
	end
	function v_u_22.CanUseAbility(_, p30)
		-- upvalues: (copy) v_u_22
		local v31 = v_u_22.Player
		local v32 = v_u_22.Config
		local v33 = v_u_22
		if v33 then
			v33 = v_u_22.Behavior
		end
		local v34 = v_u_22
		if v34 then
			v34 = v_u_22.Cooldowns
		end
		local v35 = v33.Abilities[p30]
		if v31 and (v32 and (v33 and (v34 and v35))) then
			if v34.CANT_ATTACK then
				return
			elseif v35.CurrentCharges and (v35.CurrentCharges <= 0 and not (v35.ChargesOptional or (v35.ChargesDisabled or workspace:GetAttribute("ChargesDisabled")))) then
				return
			else
				if not workspace:GetAttribute("CooldownsDisabled") then
					if v_u_22.DisabledAbilities and v_u_22.DisabledAbilities[p30] then
						return
					end
					if v_u_22.AbilitiesDisabled then
						return
					end
					if v_u_22:IsOnCooldown(p30) then
						return
					end
				end
				for _, v36 in pairs(v_u_22.AbilityDisablers) do
					if v36 then
						return
					end
				end
				if v31 and v31.Character then
					if v31.Character:GetAttribute("Ragdolling") then
						return
					elseif v31.Character:GetAttribute("AbilitiesDisabled") then
						return
					elseif not v31.Character:GetAttribute("UsingAnimations") then
						if not v31.Character:FindFirstChildOfClass("Tool") then
							return true
						end
					end
				else
					return
				end
			end
		else
			return
		end
	end
	function v_u_22.PlayVoiceline(_, p37, p38)
		-- upvalues: (ref) v_u_5, (copy) v_u_22
		v_u_5:PlayVoiceline(v_u_22, p37, p38)
	end
	for _, v39 in pairs(v_u_22.Behavior.Abilities or {}) do
		if v39.Charges then
			v39.CurrentCharges = v39.Charges
		end
	end
	function v_u_22.IsOnCooldown(_, p40)
		-- upvalues: (copy) v_u_22
		local v41 = v_u_22
		if v41 then
			v41 = v_u_22.Cooldowns
		end
		if v41[p40] and workspace:GetServerTimeNow() < v41[p40] then
			return v41[p40] - workspace:GetServerTimeNow()
		else
			return false
		end
	end
	function v_u_22.SetCooldownOf(_, p42, p43)
		-- upvalues: (copy) v_u_22, (ref) v_u_4, (copy) p_u_14
		local v44 = v_u_22
		if v44 then
			v44 = v_u_22.Cooldowns
		end
		local v45 = v_u_22 and v_u_22.Behavior.Abilities
		if v45 then
			v45 = v_u_22.Behavior.Abilities[p42]
		end
		if v45 then
			if tonumber(p43) and (p43 ~= 0 and not workspace:GetAttribute("CooldownsDisabled")) then
				local v46
				if p43 < 0 and v44[p42] then
					v46 = v44[p42] - workspace:GetServerTimeNow() + p43 or p43
				else
					v46 = p43
				end
				v44[p42] = workspace:GetServerTimeNow() + v46
			else
				v44[p42] = nil
			end
			v_u_4:FireClientConnection(p_u_14, "UpdateAbilityCooldown", "REMOTE_EVENT", p42, p43)
		end
	end
	local v_u_47 = {}
	function v_u_22.DisableAbilities(_, p_u_48, p_u_49, p50)
		-- upvalues: (copy) v_u_22, (copy) v_u_47
		v_u_22.AbilityDisablers[p_u_48] = p_u_49
		if p50 then
			if v_u_47[p_u_48] then
				pcall(task.cancel, v_u_47[p_u_48])
				v_u_47[p_u_48] = nil
			end
			v_u_47[p_u_48] = task.delay(p50, function()
				-- upvalues: (ref) v_u_22, (copy) p_u_48, (copy) p_u_49
				v_u_22.AbilityDisablers[p_u_48] = not p_u_49
			end)
		end
	end
	function v_u_22.PivotTo(_, p51)
		-- upvalues: (ref) v_u_3, (copy) v_u_22, (ref) v_u_7
		local v52 = v_u_3
		assert(v52, "Do not.")
		v_u_22.Rig:PivotTo(p51)
		require(game.ServerScriptService.Server.Miscellaneous.CharacterReplication)
		local v53 = v_u_22.ClientV or v_u_22.Rig.PrimaryPart.AssemblyLinearVelocity
		v_u_22.SerializedCF = v_u_7.Serialize(p51, v53)
		v_u_22.ClientCF = p51
		v_u_22.ClientV = v53
		v_u_22.LastClientCFUpdateTime = tick()
		local v54 = v_u_22.Player and (v_u_22.Rig:HasTag("Replicating") and v_u_22.Rig:FindFirstChild("QueryHitbox"))
		if v54 then
			v54.CollisionConnector.Enabled = false
			v54.Anchored = true
			v54.CFrame = p51
		end
	end
	function v_u_22.GetPivot(_, p55)
		-- upvalues: (ref) v_u_3, (copy) v_u_22, (ref) v_u_2, (copy) p_u_14
		local v56 = v_u_3
		assert(v56, "Do not.")
		local v57 = v_u_22.Rig
		if v57 then
			v57 = v57.PrimaryPart
		end
		if v57 then
			if not workspace:GetAttribute("ExperimentalHitboxes") then
				return v57.CFrame
			end
			if not v_u_22.LastClientCFUpdateTime or (not v_u_22.ClientCF or (not v_u_22.ClientV or tick() - v_u_22.LastClientCFUpdateTime >= 0.35)) then
				--print("CLIENTCF", v_u_22.ClientCF)
				--print("CLIENTV", v_u_22.ClientV)
				--print("TICKDIFF", v_u_22.LastClientCFUpdateTime and tick() - v_u_22.LastClientCFUpdateTime or nil)
				return v57.CFrame
			end
			local v58 = v_u_22.ClientCF
			local v59 = v_u_22.ClientV
			if p55 then
				local v60 = tick() - v_u_22.LastClientCFUpdateTime
				local v61
				if v_u_2:IsStudio() then
					v61 = 0.05
				else
					local v62 = p_u_14:GetNetworkPing()
					v61 = math.clamp(v62, 0, 0.145)
				end
				v58 = v58 + v59 * (v61 + v60)
			end
			return v58
		end
	end
	v_u_6:PreloadAssets(v_u_22.Config)
	if v_u_22.Behavior.GetRig then
		v_u_22.Rig = v_u_22.Behavior:GetRig(v_u_22)
		v_u_22.RigName = v_u_22.Rig.Name
	else
		local v63
		if v_u_22.Rig then
			v63 = v_u_22.Rig:Clone() or nil
		else
			v63 = nil
		end
		v_u_22.Rig = v63
	end
	if not v_u_22.Rig then
		p_u_14:LoadCharacter()
		return
	end
	if not v_u_22.Rig:FindFirstChild("Humanoid") then
		local v64 = Instance.new("Humanoid")
		v64.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		v64.Parent = v_u_22.Rig
		Instance.new("Animator").Parent = v64
	end
	local v65 = game.ReplicatedStorage.Assets.Skins[("%*s"):format(p15)]:FindFirstChild(p16)
	if v65 then
		v65 = v65:FindFirstChild((tostring(p17)))
	end
	if v65 then
		v65 = require(v65.Config)
	end
	local v66 = p_u_14.Character
	if v66 then
		v66 = p_u_14.Character.PrimaryPart
	end
	local v_u_67 = v_u_22.Rig.Humanoid
	v_u_67.JumpHeight = 0
	v_u_67.JumpPower = 0
	v_u_67.MaxSlopeAngle = 65
	v_u_67.BreakJointsOnDeath = false
	v_u_67.HipHeight = v_u_22.Config.HipHeight or 0
	v_u_67.WalkSpeed = v_u_22.Config.Speed or 16
	v_u_67.MaxHealth = v_u_22.Config.Health or 100
	v_u_67.Health = v_u_67.MaxHealth
	v_u_67:SetAttribute("BaseSpeed", v_u_67.WalkSpeed)
	v_u_22.Rig.Name = v18.Name
	v_u_22.Rig:SetAttribute("Username", p_u_14.Name)
	v_u_22.Rig:SetAttribute("SkinName", (tostring(p17)))
	v_u_22.Rig:SetAttribute("SkinNameDisplay", v65 and v65.DisplayName or "")
	local v68 = v_u_22.Rig
	local v69 = v_u_22.Config.DisplayName
	v68:SetAttribute("ActorDisplayName", (tostring(v69)))
	if workspace:GetAttribute("ExperimentalReplication") then
		v_u_22.Rig:AddTag("Replicating")
	end
	if v66 then
		v_u_22.Rig:SetPrimaryPartCFrame(v66.CFrame)
	end
	if v_u_22.Config.DirectionalMovementDisabled then
		v_u_22.Rig:SetAttribute("DirectionalMovementDisabled", true)
	end
	if v_u_22.Config.Sounds and v_u_22.Config.Sounds.Ambience then
		v_u_5:Play(v_u_22.Config.Sounds.Ambience, {
			["Parent"] = v_u_22.Rig.PrimaryPart,
			["Looped"] = true
		})
	end
	v_u_67.Died:Once(function()
		-- upvalues: (copy) v_u_22, (ref) v_u_5, (copy) p_u_14, (ref) v_u_1
		local v70 = v_u_22.Rig.PrimaryPart
		if v70 then
			(v_u_5:Play("deadJ" .. p_u_14.Name, {
				["Parent"] = v70
			}) or v_u_5:Play("dead", {
				["Parent"] = v70
			})):SetAttribute("Bypassable", true)
		end
		v_u_5:PlayVoiceline(v_u_22, "Died", {
			["Priority"] = 10
		})
		v_u_1:CleanupActorFromPlayer(p_u_14)
	end)
	require(game.ReplicatedStorage.Modules.Maps):GenerateKillerScene(v_u_22.Rig, "Intro")
	local v_u_71 = v_u_22.RigName and v_u_22.Config[("Expressions%*"):format(v_u_22.RigName)] or v_u_22.Config.Expressions
	if v_u_71 and not v_u_22.Rig.Head:FindFirstChild("face") then
		local v72 = v_u_22.Rig:FindFirstChild("ExpressionHolder", true) or game.ReplicatedStorage.Assets.Instances.ExpressionHolder:Clone()
		if not v72.Parent then
			v72.Parent = v_u_22.Rig
			v72.CFrame = v_u_22.Rig.Head.CFrame * CFrame.new(0, 0, -0.005)
			local v73 = Instance.new("WeldConstraint")
			v73.Part0 = v_u_22.Rig.Head
			v73.Part1 = v72
			v73.Parent = v72
		end
		local v_u_74 = v72:FindFirstChildOfClass("Decal") or Instance.new("Decal")
		if not v_u_74.Parent then
			v_u_74.Parent = v72
		end
		v_u_74.Name = "Expression"
		local v_u_75 = nil
		function v_u_22.ChangeExpression(_, p76, p77)
			-- upvalues: (ref) v_u_71, (copy) v_u_22, (ref) v_u_75, (copy) v_u_74, (copy) v_u_67
			local v78 = not (v_u_22.RigName and v_u_22.Config[("Expressions%*"):format(v_u_22.RigName)]) and v_u_22.Config
			if v78 then
				v78 = v_u_22.Config.Expressions
			end
			v_u_71 = v78
			if v_u_22.Rig.Parent then
				if v_u_71 and v_u_71[p76] then
					if v_u_75 then
						task.cancel(v_u_75)
					end
					if p76 == "Default" then
						v_u_74.Texture = v_u_67.Health <= v_u_67.MaxHealth / 2 and v_u_71.Injured or v_u_71.Default
					else
						v_u_74.Texture = v_u_71[p76]
					end
					pcall(v_u_22.Behavior.onExpressionChanged, v_u_22.Behavior, v_u_22, p76, p77)
					if p77 then
						v_u_75 = task.delay(p77, function()
							-- upvalues: (ref) v_u_67, (ref) v_u_71, (ref) v_u_74, (ref) v_u_22
							local v79 = v_u_67.Health <= v_u_67.MaxHealth / 2
							if v_u_71 then
								v_u_74.Texture = v79 and v_u_71.Injured or v_u_71.Default
							end
							pcall(v_u_22.Behavior.onExpressionChanged, v_u_22.Behavior, v_u_22, v79 and "Injured" or "Default", nil)
						end)
					end
				end
			else
				return
			end
		end
		v_u_74.Texture = v_u_71.Default or ""
		local v_u_80 = v_u_67.Health
		v_u_67.HealthChanged:Connect(function(p81)
			-- upvalues: (copy) v_u_22, (ref) v_u_75, (ref) v_u_80, (ref) v_u_71, (ref) v_u_5
			if p81 <= 0 then
				v_u_22:ChangeExpression("Dead")
				function v_u_22.ChangeExpression() end
				if v_u_75 then
					pcall(task.cancel, v_u_75)
				end
				v_u_75 = nil
			elseif p81 < v_u_80 and v_u_71.Hurt then
				v_u_22:ChangeExpression("Hurt", 0.75)
			elseif v_u_80 + 20 < p81 and v_u_71.Happy then
				v_u_22:ChangeExpression("Happy", 0.75)
			else
				v_u_22:ChangeExpression("Default")
			end
			if v_u_80 - p81 >= 15 then
				v_u_5:PlayVoiceline(v_u_22, "Injured", {
					["Priority"] = 5
				})
			end
			v_u_80 = p81
		end)
	else
		function v_u_22.ChangeExpression(_, _, _) end
	end
	for _, v82 in pairs(workspace.Players:GetChildren()) do
		if v82.Name:find(p15) then
			v_u_22.Rig.Parent = v82
			break
		end
	end
	task.spawn(function()
		-- upvalues: (copy) v_u_22, (ref) v_u_6
		for v83, v84 in pairs(v_u_22.Config.Animations) do
			if tostring(v83):find("Execution") and typeof(v84) == "table" then
				v_u_22.Cache[("%*Anim"):format(v83)] = v_u_6:LoadAnimationFromID(v_u_22.Rig, v84.KillerRig, true)
			end
		end
	end)
	task.spawn(function()
		-- upvalues: (copy) v_u_22, (ref) v_u_5
		if v_u_22.Config.Voicelines and v_u_22.Config.Voicelines.Idle then
			while task.wait(math.random(10, 25)) and (v_u_22 and (v_u_22.Rig and v_u_22.Rig.PrimaryPart)) do
				if not v_u_22.Rig.PrimaryPart:FindFirstChild("VoicelineSFX") then
					v_u_5:PlayVoiceline(v_u_22, "Idle", {
						["Priority"] = 0
					})
				end
			end
		end
	end)
	if p_u_14.Character then
		p_u_14.Character:Destroy()
	end
	p_u_14.Character = v_u_22.Rig
	v_u_6:FixCharacter(v_u_22.Rig, (("%*s"):format(p15)))
	v_u_6:AddHitboxes(v_u_22, (("%*s"):format(p15)))
	local v85 = v_u_6:CopyTable(v_u_22)
	v85.Information = nil
	v85.Behavior = nil
	v85.Config = nil
	v_u_4:FireAllClientConnection("ActorCreated", "REMOTE_EVENT", v85)
	for _, v86 in pairs({ "Created", "CreatedPost" }) do
		if v_u_22.Behavior[v86] then
			v_u_22.Behavior[v86](v_u_22.Behavior, v_u_22)
		end
	end
	v_u_6:SetSpeedCap(p_u_14, "Sprinting", (v_u_22.Config.SprintSpeed or 26) / v_u_67:GetAttribute("BaseSpeed"))
	v_u_1.CurrentActors[p_u_14] = v_u_22
	v_u_1.__actorCreated:Fire(v_u_22)
	return v_u_22
end
function v_u_1.CleanupActorFromPlayer(_, p87)
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	local v88 = v_u_1.CurrentActors[p87]
	if v88 then
		if v88.Behavior and v88.Behavior.Destroyed then
			v88.Behavior:Destroyed(v88)
		end
		v_u_4:FireAllClientConnection("ActorDestroyed", "REMOTE_EVENT", p87)
		v_u_1.__actorDestroyed:Fire(v88)
		if p87.Character then
			p87.Character:RemoveTag("Replicating")
		end
		v_u_1.CurrentActors[p87] = nil
	end
end
function v_u_1.GetEquippedActorInfo(_, p89, p90)
	local v91 = p89:FindFirstChild("PlayerData")
	if v91 then
		v91 = v91:FindFirstChild("Equipped")
	end
	local v92 = v91 and v91:FindFirstChild(p90) and (v91[p90].Value or "") or ""
	if v91 then
		v91 = v91:FindFirstChild("Skins")
	end
	return v92, v91 and v91:FindFirstChild(v92) and (v91[v92].Value or "") or ""
end
function v_u_1.GetAmountOfLivingActorsOfClass(_, p93)
	-- upvalues: (copy) v_u_1
	local v94 = 0
	for _, v95 in pairs(v_u_1.CurrentActors) do
		if v95.Config and v95.Config.Class == p93 then
			v94 = v94 + 1
		end
	end
	return v94
end
function v_u_1.ApplySkinDataToActorInfo(_, p96)
	-- upvalues: (copy) v_u_6, (copy) v_u_9
	local v97 = game["Run Service"]:IsServer()
	local v98 = p96.Folder
	local v99 = p96.ActorType
	local v100 = p96.ActorName
	local v101 = p96.ActorSkin
	p96.Config = v_u_6:CopyTable(require(v98.Config))
	p96.Behavior = v_u_6:CopyTable(require(v98.Behavior))
	if v97 then
		p96.Rig = p96.Config.Rig
	end
	for v102, v103 in pairs(v_u_9) do
		if not p96.Config.Animations[v102] then
			p96.Config.Animations[v102] = v103
		end
	end
	local v104 = game.ReplicatedStorage.Assets.Skins:FindFirstChild(tostring(v99) .. "s")
	if v104 then
		v104 = v104:FindFirstChild(v100)
	end
	if v101 then
		if v104 then
			v104 = v104:FindFirstChild(v101)
		end
	else
		v104 = v101
	end
	p96.SkinFolder = v104
	if v104 then
		local v105 = v104:FindFirstChild("Config")
		if v105 then
			v105 = require(v104.Config)
		end
		local v106 = v104:FindFirstChild("Behavior")
		if v106 then
			v106 = require(v104.Behavior)
		end
		if v97 then
			if v105 then
				v97 = v105.Rig
			else
				v97 = v105
			end
		end
		local v107 = v_u_6:MergeTables(p96.Config, v105, { "DisplayName", "TextInteractions" })
		local v108 = v_u_6:MergeTables(p96.Behavior, v106)
		p96.Config = v107
		p96.Behavior = v108
		p96.SkinFolder = v104
		if v97 then
			p96.Rig = v97
		end
		return v104
	end
end
function v_u_1.CreateChatInteraction(_, p_u_109, p110, p_u_111)
	-- upvalues: (copy) v_u_1, (copy) v_u_6
	if typeof(p_u_109) == "Instance" then
		p_u_109 = v_u_1.CurrentActors[p_u_109] or v_u_1.CurrentActors[game.Players:GetPlayerFromCharacter(p_u_109)]
	end
	if typeof(p_u_111) == "Instance" then
		p_u_111 = v_u_1.CurrentActors[p_u_111] or v_u_1.CurrentActors[game.Players:GetPlayerFromCharacter(p_u_111)]
	end
	if p_u_109 then
		local v112 = p_u_109.Config.TextInteractions
		if v112 then
			local v113 = string.split(p110, "/")
			for _, v114 in pairs(v113) do
				local v115 = "%*%*"
				local v116
				if p_u_111 then
					local v117 = p_u_111.ActorSkin
					v116 = tostring(v117):gsub(p_u_111.ActorName, "") or ""
				else
					v116 = ""
				end
				v112 = v112[v115:format(v116, v114)] or (v112[v114] or v112.Regular)
				if not v112 then
					return
				end
			end
			local v_u_118 = v112[math.random(#v112)]
			if v_u_118 then
				if typeof(v_u_118) == "table" then
					task.spawn(function()
						-- upvalues: (copy) v_u_118, (ref) p_u_109, (ref) p_u_111, (ref) v_u_6
						for _, v119 in pairs(v_u_118) do
							local v120 = nil
							local v121 = string.split(v119, " ")
							if v121[1]:find(":") then
								if v121[1]:find(p_u_109.ActorName) then
									v120 = p_u_109.Rig
								elseif p_u_111 and v121[1]:find(p_u_111.ActorName) then
									v120 = p_u_111.Rig
								end
								table.remove(v121, 1)
							end
							v_u_6:DisplayBubble(v120, table.concat(v121, " "))
							local v122 = task.wait
							local v123 = #v121 / 2 + v119:len()
							v122((math.clamp(v123, 1, 4)))
						end
					end)
				else
					v_u_6:DisplayBubble(p_u_109.Rig, v_u_118)
				end
			end
		end
	else
		return
	end
end
function v_u_1.IncrementActorStats(_, p_u_124, p_u_125)
	-- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_4
	if workspace:GetAttribute("ServerType") == "VIP" then
		return
	elseif typeof(p_u_124) == "Instance" or p_u_124:IsA("Player") then
		local v126 = ({
			["Support"] = {
				["Money"] = 8,
				["EXP"] = 12,
				["KillerChance"] = 0.5
			},
			["Offensive"] = {
				["Money"] = 5,
				["EXP"] = 15,
				["KillerChance"] = 0.75
			},
			["Survivalist"] = {
				["Money"] = 3,
				["EXP"] = 12,
				["KillerChance"] = 0.25
			},
			["VeryDifficultKillerAction"] = {
				["Money"] = 20,
				["EXP"] = 60
			},
			["DifficultKillerAction"] = {
				["Money"] = 12,
				["EXP"] = 36
			},
			["RegularKillerAction"] = {
				["Money"] = 8,
				["EXP"] = 24
			},
			["EasyKillerAction"] = {
				["Money"] = 4,
				["EXP"] = 12
			}
		})[p_u_125.RewardType]
		if v126 then
			local v127 = v126.Money
			p_u_125.Money = tonumber(v127) or p_u_125.Money
			local v128 = v126.EXP
			p_u_125.EXP = tonumber(v128) or p_u_125.EXP
		end
		task.spawn(function()
			-- upvalues: (copy) p_u_125, (ref) v_u_1, (copy) p_u_124, (ref) v_u_6, (ref) v_u_4
			local v129 = false
			if p_u_125.EXP then
				local v130 = v_u_1.CurrentActors[p_u_124]
				local v131
				if v130 then
					v131 = v130.Folder
				else
					v131 = v130
				end
				if v131 then
					local v132 = p_u_124:FindFirstChild("PlayerData")
					local v133
					if v132 then
						v133 = v132:FindFirstChild("Purchased")
					else
						v133 = v132
					end
					if v133 then
						local v134 = "%*s"
						if v130 then
							v130 = v130.ActorType
						end
						v133 = v133:FindFirstChild((v134:format((tostring(v130)))))
					end
					if v133 then
						local v135 = p_u_124:GetAttribute("EXPMultiplier") or 1
						local v136 = v132:FindFirstChild("EXPBoostTime", true)
						if v136 and v136.Value > 0 then
							v135 = v135 + 0.25
						end
						local v137 = p_u_125.EXP
						if tonumber(v137) then
							local v138 = p_u_125
							v138.EXP = v138.EXP * v135
						end
						local v139 = v133:FindFirstChild(v131.Name)
						if v139 then
							local v140 = v139.Value
							local v141 = p_u_125.EXP
							v139.Value = v140 + tonumber(v141)
							v129 = true
						end
					end
				end
			end
			v_u_6:AddToPlayerStat(p_u_124, "Money", p_u_125.Money)
			v_u_6:AddToPlayerStat(p_u_124, "KillerChance", p_u_125.KillerChance)
			local v142 = p_u_125.Action
			if typeof(v142) == "string" then
				local v143 = p_u_125.Action
				local v144 = tostring(v143)
				local v145 = {}
				local v146 = p_u_125.Money
				if v146 then
					local v147 = p_u_125.Money
					v146 = ("%*$"):format((tostring(v147)))
				end
				local v148
				if v129 and p_u_125.EXP then
					local v149 = p_u_125.EXP
					v148 = ("%* EXP"):format((tostring(v149))) or nil
				else
					v148 = nil
				end
				v145 = {v146, v148}
				v_u_4:FireClientConnection(p_u_124, "SendNotif", "REMOTE_EVENT", ("+ %*: %*"):format(table.concat(v145, " & "), v144), "Objective")
			end
		end)
	end
end
function v_u_1.CreateCutsceneActor(_, p150, p151)
	-- upvalues: (copy) v_u_6
	local v152 = p150.Config.Animations[p151]
	if v152 then
		local v153 = p150.Rig:Clone()
		v153:RemoveTag("Replicating")
		local v154 = { "KillerRig", "CameraRig" }
		for _, v155 in ipairs(v153:GetChildren()) do
			if v155:GetAttribute("Hitbox") then
				v155:Destroy()
			end
		end
		local v_u_156 = (p150.SkinFolder and p150.SkinFolder:FindFirstChild((("%*CameraRig"):format(p151))) or (p150.Folder:FindFirstChild((("%*CameraRig"):format(p151))) or p150.SkinFolder and p150.SkinFolder:FindFirstChild("CameraRig") or (p150.Folder:FindFirstChild("CameraRig") or game.ReplicatedStorage.Assets.Instances.CameraRig))):Clone()
		game.Debris:AddItem(v153, 30)
		game.Debris:AddItem(v_u_156, 30)
		v153:WaitForChild("HumanoidRootPart").Anchored = true
		v_u_156:WaitForChild(v_u_156:GetAttribute("RootName") or "HumanoidRootPart").Anchored = true
		v153:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0))
		v_u_156:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0))
		v153.Name = p150.Player.Name .. "ActorRig"
		v_u_156.Name = p150.Player.Name .. "CameraRig"
		v153.Parent = workspace.Misc
		v_u_156.Parent = workspace.Misc
		local v_u_157 = {}
		for _, v158 in pairs(v154) do
			local v159 = v152[v158]
			local v160 = v152[("%*Loop"):format(v158)]
			if v159 then
				v_u_157[v158] = v_u_6:LoadAnimationFromID(v158:find("Killer") and v153 and v153 or v_u_156, v159, true)
			end
			if v160 then
				v_u_157[("%*Loop"):format(v158)] = v_u_6:LoadAnimationFromID(v158:find("Killer") and v153 and v153 or v_u_156, v160, true)
			end
		end
		task.spawn(function()
			-- upvalues: (copy) v_u_156
			local v161 = workspace.CurrentCamera
			local v162 = v_u_156:FindFirstChild(v_u_156:GetAttribute("CameraName") or "CameraPart")
			while v_u_156.Parent do
				if v162 then
					v161.CameraType = Enum.CameraType.Scriptable
					v161.CFrame = v162.CFrame
				end
				task.wait()
			end
			local v163 = game.Players.LocalPlayer
			local v164 = v163.Character
			if v164 then
				v164 = v163.Character:FindFirstChild("Humanoid")
			end
			if v164 then
				v161.CameraSubject = v164
			end
			v161.CameraType = Enum.CameraType.Custom
		end)
		task.delay(v_u_157.CameraRig.Length - 0.1, function()
			-- upvalues: (copy) v_u_157
			for v165, v166 in pairs(v_u_157) do
				if not v165:find("Loop") then
					if v_u_157[("%*Loop"):format(v165)] then
						v_u_157[("%*Loop"):format(v165)]:Play(0)
						v166:Stop()
					else
						v166:AdjustSpeed(0)
					end
				end
			end
		end)
		for _, v167 in pairs(v_u_157) do
			v167:Play(0)
		end
		return v153, v_u_156, v_u_157
	end
end
function v_u_1.Start(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_4
	if v_u_3 then
		local v168 = require(game.ServerScriptService.Server.Miscellaneous.CharacterReplication)
		game.Players.PlayerRemoving:Connect(function(p169)
			-- upvalues: (ref) v_u_1
			v_u_1:CleanupActorFromPlayer(p169)
		end)
		v_u_4:SetConnection("UpdCF", "UREMOTE_EVENT", v168.Received)
	end
	for v170, v171 in pairs({
		["__actorCreated"] = "ActorAdded",
		["__actorDestroyed"] = "ActorRemoved"
	}) do
		v_u_1[v170] = Instance.new("BindableEvent")
		v_u_1[v170].Name = v170
		v_u_1[v170].Parent = script
		v_u_1[v171] = v_u_1[v170].Event
	end
end
return v_u_1
