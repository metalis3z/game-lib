-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_5 = require(game.ReplicatedStorage.Modules.Util)
local v_u_6 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_7 = require(game.ReplicatedStorage.Modules.Statuses)
function v1.Created(p8, p_u_9)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if v_u_2:IsServer() then
		local v10 = Instance.new("Model", workspace.Map.Ingame)
		v10.Name = p_u_9.Player.Name .. "BloodOrbContainer"
		p_u_9.Behavior.Blood = 0
		p_u_9.Behavior.BloodOrbs = {}
		p_u_9.Behavior.BloodContainer = v10
		task.spawn(function()
			-- upvalues: (copy) p_u_9
			while p_u_9.Behavior.BloodOrbs and (p_u_9 and (p_u_9.Rig and p_u_9.Rig.PrimaryPart)) do
				for v11, v12 in ipairs(p_u_9.Behavior.BloodOrbs) do
					if (v12.Position - p_u_9.Rig.PrimaryPart.Position).Magnitude <= p_u_9.Config.BloodOrbCollectRange then
						p_u_9.Behavior.Collect(p_u_9, v12)
						table.remove(p_u_9.Behavior.BloodOrbs, v11)
					end
				end
				task.wait()
			end
		end)
	elseif v_u_2:IsClient() then
		if game.Players.LocalPlayer == p_u_9.Player then
			task.spawn(function()
				-- upvalues: (copy) p_u_9
				local v13 = workspace.Map.Ingame:WaitForChild(p_u_9.Player.Name .. "BloodOrbContainer", 6)
				if v13 then
					local v14 = p_u_9.Config.BloodOrbHighlightTemplate
					if v14 then
						v14 = p_u_9.Config.BloodOrbHighlightTemplate:Clone()
					end
					if not v14 then
						v14 = Instance.new("Highlight")
						v14.FillTransparency = 0.9
						v14.FillColor = Color3.fromRGB(68, 0, 0)
					end
					v14.Parent = v13
				else
					warn("[G666]:", "no blood orb container")
				end
			end)
			return
		end
		p_u_9.OrbTransparencyConnection = v_u_3:GetInstanceAddedSignal((("%*BloodOrb"):format(p8.Player.Name))):Connect(function(p_u_15)
			task.defer(function()
				-- upvalues: (copy) p_u_15
				p_u_15.LocalTransparencyModifier = 0.8
				for _, v16 in ipairs(p_u_15:GetDescendants()) do
					if v16:IsA("Trail") or (v16:IsA("Beam") or v16:IsA("ParticleEmitter")) then
						v16.Enabled = false
					elseif v16:IsA("Decal") or v16:IsA("Texture") then
						v16.Transparency = 0.9
					elseif v16:IsA("BasePart") then
						p_u_15.LocalTransparencyModifier = 0.8
					end
				end
			end)
		end)
	end
end
function v1.Destroyed(_, p17)
	-- upvalues: (copy) v_u_2
	if v_u_2:IsServer() then
		for _, v18 in ipairs(p17.Behavior.BloodOrbs or {}) do
			v18:Destroy()
		end
		p17.Behavior.BloodOrbs = nil
		while workspace.Map.Ingame:FindFirstChild(p17.Player.Name .. "BloodOrbContainer") do
			workspace.Map.Ingame[p17.Player.Name .. "BloodOrbContainer"]:Destroy()
		end
	elseif v_u_2:IsClient() then
		local _ = game.Players.LocalPlayer == p17.Player
		if p17.OrbTransparencyConnection then
			p17.OrbTransparencyConnection:Disconnect()
		end
	end
end
local v25 = {
	["Carving Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = 2,
		["Callback"] = function(p_u_19)
			-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_7
			if game["Run Service"]:IsServer() then
				p_u_19.AbilitiesDisabled = true
				task.delay(0.4, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_19
					v_u_4:Play(p_u_19.Config.Sounds.Swing, {
						["Parent"] = p_u_19.Rig.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
						["Volume"] = 0.25
					})
				end)
				task.delay(0.35, function()
					-- upvalues: (ref) v_u_6, (copy) p_u_19, (ref) v_u_5, (ref) v_u_4, (ref) v_u_7
					local v20 = v_u_6
					local v21 = p_u_19.Player
					local v24 = {
						["Size"] = Vector3.new(6, 10, 10),
						["CFrameOffset"] = CFrame.new(0, 0, -8.25),
						["Damage"] = p_u_19.Config.SlashDamage,
						["Time"] = 0.4,
						["Knockback"] = 2,
						["HitMultiple"] = true,
						["Connections"] = {
							["Hit"] = function(p22, p23)
								-- upvalues: (ref) v_u_5, (ref) v_u_4, (ref) p_u_19, (ref) v_u_7
								v_u_5:CreateSpeedMultiplier(p22, 1.5, "HitSpeedBonus", 1.25)
								if p23 then
									v_u_4:Play(p_u_19.Config.Sounds.Hit, {
										["Parent"] = p_u_19.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.25
									})
								end
								v_u_7:ApplyStatus(p22, "Hemmorhage", {
									["Killer"] = p_u_19
								})
							end
						}
					}
					v20:CreateHitbox(v21, v24)
				end)
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_19
					p_u_19.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_19.Animations.SlashNormal:Play(0.175)
			end
		end
	}
}
v1.Abilities = v25
function v1.SpawnBloodOrb(p26, p27)
	-- upvalues: (copy) v_u_2
	local v28 = v_u_2:IsServer()
	assert(v28, "what are you doing")
	local v29 = p26.Config.BloodOrbTemplate:Clone()
	v29.Parent = p26.Behavior.BloodContainer
	v29.Name = ("%*BloodOrb"):format(p26.Player.Name)
	v29.CollisionGroup = "Items"
	v29:SetNetworkOwner(p26.Player)
	for _, v30 in ipairs(v29:GetDescendants()) do
		if v30:IsA("BasePart") then
			v30:SetNetworkOwner(p26.Player)
		end
	end
	v29.CFrame = CFrame.new(p27)
	v29:AddTag((("%*BloodOrb"):format(p26.Player.Name)))
	local v31 = Instance.new("BodyPosition", v29)
	v31.P = (1 / 0)
	v31.MaxForce = Vector3.new(1000000, 1000000, 1000000)
	v31.D = 300
	local v32 = math.random(-3.1, 3.1)
	local v33 = math.random
	v31.Position = p27 + Vector3.new(v32, 1.1, v33(-3.1, 3.1))
	p26.Behavior.BloodOrbs = p26.Behavior.BloodOrbs or {}
	local v34 = p26.Behavior.BloodOrbs
	table.insert(v34, v29)
end
function v1.GiveBlood(p35, p36)
	local v37 = p35.Behavior
	local v38 = p35.Behavior.Blood + p36
	v37.Blood = math.clamp(v38, 0, 100)
	if p35.Behavior.Blood == 100 then
		p35:IncrementCharges("Blood Hunt", 1, 1)
	end
end
function v1.CollectOrb(p39, p40)
	p39.Behavior.GiveBlood(p39, p39.Config.BloodOrbGive)
	p40:Destroy()
end
return v1
