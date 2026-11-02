-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("RunService")
local v_u_3 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_4 = v2:IsClient()
local v_u_5 = v2:IsServer()
function v_u_1.Created(_) end
function v_u_1.Destroyed(p6)
	-- upvalues: (copy) v_u_1
	v_u_1.Unequipped(p6)
end
function v_u_1.Equipped(p7)
	-- upvalues: (copy) v_u_5
	if v_u_5 then
		for _, v8 in pairs(p7.Item:GetDescendants()) do
			if v8:IsA("Motor6D") and (not v8.Part0 or v8:GetAttribute("WeldToPrimaryPart")) then
				v8:SetAttribute("WeldToPrimaryPart", true)
				local v9 = p7.Player.Character
				if v9 then
					v9 = p7.Player.Character.PrimaryPart
				end
				v8.Part0 = v9
			end
		end
	end
end
function v_u_1.Unequipped(p10)
	-- upvalues: (copy) v_u_4
	if p10.HealingThreads and not p10.Completed then
		for _, v11 in pairs(p10.HealingThreads) do
			task.cancel(v11)
		end
		p10.HealingThreads = nil
	end
	if p10.SFX then
		p10.SFX:Destroy()
	end
	if p10.UI then
		p10.UI:Destroy()
		p10.UI = nil
	end
	if p10.SpeedModifier then
		game.TweenService:Create(p10.SpeedModifier, TweenInfo.new(0.5), {
			["Value"] = 1
		}):Play()
		game.Debris:AddItem(p10.SpeedModifier, 0.5)
		p10.SpeedModifier = nil
	end
	if v_u_4 then
		require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "UsingMedkit", false)
		if p10.Item and p10.Item.Parent then
			for _, v12 in pairs(p10.Item:GetDescendants()) do
				if v12:IsA("BasePart") then
					v12.Transparency = 0
				end
			end
		end
	end
	for _, v13 in pairs(p10.BehaviorConnections or {}) do
		v13:Disconnect()
	end
	p10.BehaviorConnections = nil
end
function v_u_1.Activated(p_u_14)
	-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v_u_15 = p_u_14.Character.Humanoid.Health
	local v_u_16 = p_u_14.Character.Humanoid:GetAttribute("Overheal") or 0
	p_u_14.BehaviorConnections = { p_u_14.Character.Humanoid.HealthChanged:Connect(function(p17)
			-- upvalues: (ref) v_u_15, (ref) v_u_1, (copy) p_u_14, (ref) v_u_4
			if p17 < v_u_15 then
				v_u_1.Unequipped(p_u_14)
				if v_u_4 then
					p_u_14.Animations.Heal:Stop()
					return
				end
			else
				v_u_15 = p17
			end
		end), p_u_14.Character.Humanoid:GetAttributeChangedSignal("Overheal"):Connect(function()
			-- upvalues: (copy) p_u_14, (ref) v_u_16, (ref) v_u_1, (ref) v_u_4
			local v18 = p_u_14.Character.Humanoid:GetAttribute("Overheal") or -50
			if v18 + 5 < v_u_16 then
				v_u_1.Unequipped(p_u_14)
				if v_u_4 then
					p_u_14.Animations.Heal:Stop()
					return
				end
			else
				v_u_16 = v18
			end
		end) }
	if v_u_5 and not p_u_14.HealingThreads then
		p_u_14.SFX = require(game.ReplicatedStorage.Modules.Sounds):Play(p_u_14.Config.Sounds.Healing, {
			["Parent"] = p_u_14.Item.ItemRoot
		})
		p_u_14.HealingThreads = { task.delay(p_u_14.Config.HealTime, function()
				-- upvalues: (copy) p_u_14, (ref) v_u_3
				p_u_14.Completed = true
				v_u_3:ApplyStatus(p_u_14.Player, "Hallucination", {
					["Level"] = 1,
					["Stackable"] = true,
					["Hidden"] = false
				})
				p_u_14:Destroy()
			end) }
	elseif v_u_4 and not p_u_14.UI then
		p_u_14.Animations.Heal:Play()
		p_u_14.SpeedModifier = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(p_u_14.Player, 1, "Medkit")
		game.TweenService:Create(p_u_14.SpeedModifier, TweenInfo.new(0.5), {
			["Value"] = p_u_14.Config.HealSpeedMultiplier
		}):Play()
		require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "UsingMedkit", true)
		p_u_14.UI = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone()
		p_u_14.UI.Title.Text = "Healing"
		p_u_14.UI.Parent = p_u_14.Player.PlayerGui:FindFirstChild("TemporaryUI")
		local function v_u_27(p19, p20)
			if p19 then
				if typeof(p19) == "Instance" then
					local v21 = p19:Clone()
					v21.CanCollide = true
					v21.Parent = workspace.Map.Ingame
					v21.Velocity = p20 or Vector3.new()
					p19.Transparency = 1
				elseif typeof(p19) == "table" then
					local v22 = {}
					for v23, v24 in pairs(p19) do
						v22[v23] = v24:Clone()
						v22[v23]:ClearAllChildren()
						v22[v23].CanCollide = true
						v24.Transparency = 1
						if v23 ~= 1 then
							local v25 = Instance.new("WeldConstraint")
							v25.Parent = v22[v23]
							v25.Part1 = v22[v23]
							v25.Part0 = v22[1]
						end
					end
					for _, v26 in pairs(v22) do
						v26.Parent = workspace.Map.Ingame
					end
				end
			else
				return
			end
		end
		p_u_14.HealingThreads = { task.delay(1.666, function()
				-- upvalues: (copy) v_u_27, (copy) p_u_14
				v_u_27(p_u_14.Item.ItemRoot.Parts:FindFirstChild("syringidk0"), p_u_14.Character.PrimaryPart.CFrame.LookVector * -2)
			end), task.delay(2.533, function()
				-- upvalues: (copy) p_u_14, (copy) v_u_27
				local v28 = p_u_14.Item.ItemRoot.Parts:GetChildren()
				local v29 = p_u_14.Item.ItemRoot
				table.insert(v28, v29)
				for v30 = #v28, 1, -1 do
					local v31 = v28[v30]
					if v31 and (v31.Name == "syringidk0" or v31.Name == "bandag") then
						table.remove(v28, v30)
					end
				end
				v_u_27(v28, p_u_14.Character.PrimaryPart.CFrame.LookVector * -2)
			end) }
		local function v37(p32, p33, p34)
			local v35 = math.clamp(p33, 0, p34) / p34
			local v36 = v35 == 0 and 0 or 1 / v35
			p32.Clipping.Size = UDim2.fromScale(v35, 1)
			p32.Clipping.Top.Size = UDim2.fromScale(v36, 1)
		end
		v37(p_u_14.UI.Bar, 0, p_u_14.Config.HealTime)
		local v38 = 0
		while p_u_14.UI and p_u_14.UI.Parent do
			if p_u_14.Config.HealTime <= v38 then
				v_u_1.Unequipped(p_u_14)
			else
				v37(p_u_14.UI.Bar, v38, p_u_14.Config.HealTime)
			end
			v38 = v38 + game["Run Service"].Heartbeat:Wait()
		end
	end
end
function v_u_1.Deactivated(_) end
return v_u_1
