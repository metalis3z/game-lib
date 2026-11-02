-- Decompiled by Krnl

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = require(v1.Modules.Hitboxes)
local v_u_5 = require(v1.Modules.Ragdolls)
local v_u_6 = require(v1.Modules.Sounds)
local v_u_7 = require(v1.Modules.Util)
local v_u_8 = {}
--v_u_8.Voidstars = {}
v_u_8.__index = v_u_8
--function removeNils(array)
--	local result = {}
--	for _, value in ipairs(array) do
--		table.insert(result, value)
--	end
--	return result
--end
function v_u_8.new(p9, p_u_10)
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_7, (copy) v_u_2, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	if p_u_10.Voidstars == nil then
		p_u_10.Voidstars = {}
	end
	if #p_u_10.Voidstars >= 3 then
		p_u_10.Voidstars[1].value = true
		--print(v_u_8.Voidstars[1])
	end
	local v11 = {
		["instance"] = p9:Clone(),
		["killerInfo"] = p_u_10,
		["killerRig"] = p_u_10.Rig,
		["survivorsNearby"] = {},
		["connections"] = {},
		["detonated"] = {
			value = false
		},
		["ready"] = false,
		["threshold"] = 0,
		["thresholdGain"] = 0.25,
		["maxThreshold"] = 1,
		["survivorException"] = nil
	}
	local v12 = v_u_8
	local v_u_13 = setmetatable(v11, v12)
	v_u_13.instance.CollisionGroup = "Default"
	v_u_13.instance.CFrame = v_u_13.killerRig:GetPivot()
	v_u_13.instance.Parent = workspace.Misc
	local v_u_14 = 0
	v_u_13:InsertConnection(v_u_3.Heartbeat:Connect(function(p15)
		-- upvalues: (copy) v_u_13, (ref) v_u_14, (ref) v_u_7, (copy) p_u_10
		if not v_u_13.ready or v_u_13.detonated.value then
			return
		end
		if v_u_14 < 0.25 then
			v_u_14 = v_u_14 + p15
			return
		end
		v_u_14 = 0
		print("Update")
		local v16 = v_u_13
		v16.threshold = v16.threshold - v_u_13.thresholdGain / 2
		local v17 = v_u_13
		local v18 = v_u_13.threshold
		v17.threshold = math.max(0, v18)
		local v19 = v_u_7:GetClosestPlayerFromPosition(v_u_13.instance.Position, {
			["MaxDistance"] = p_u_10.Config.ImplantDetectRadius,
			["PlayerSelection"] = "Survivors",
			["ReturnTable"] = true
		})
		for _, v20 in pairs(v19) do
			local v21 = v20.Player
			local v22 = v20.Distance
			if v_u_13.survivorException and v21 == v_u_13.survivorException then
				print("Skipped", v21.Name, "due to them being an exception (Implant Injection)")
			else
				if v22 <= p_u_10.Config.ImplantDetonateRadius then
					local v23 = v_u_13
					v23.threshold = v23.threshold + v_u_13.thresholdGain
					local v24 = v_u_13
					local v25 = v_u_13.threshold
					local v26 = v_u_13.maxThreshold
					v24.threshold = math.min(v25, v26)
					if v_u_13.threshold >= v_u_13.maxThreshold then
						v_u_13.detonated.value = true
						break
					end
				end
				print("Player nearby", v21.Name)
				v_u_7:RevealPlayerAuraTo(p_u_10.Player, v21, 5)
			end
		end
		print("Threshold", v_u_13.threshold)
		v_u_13.survivorsNearby = v19
	end))
	task.spawn(function()
		-- upvalues: (copy) v_u_13, (ref) v_u_2, (ref) v_u_4, (copy) p_u_10, (ref) v_u_5, (ref) v_u_7, (ref) v_u_6
		repeat
			task.wait()
		until v_u_13.detonated.value == true
		v_u_2:Create(v_u_13.instance, TweenInfo.new(0.15), {
			["Transparency"] = 0
		}):Play()
		--task.wait(0.1)
		v_u_4:CreateHitbox(p_u_10.Player, {
			["CFrame"] = v_u_13.instance.CFrame,
			["Size"] = Vector3.new(27.5, 27.5, 27.5),
			["PredictVelocity"] = false,
			["HitMultiple"] = true,
			["Damage"] = function(p27)
				-- upvalues: (ref) v_u_13
				local v28 = (v_u_13.instance.Position - p27.PrimaryPart.Position).Magnitude
				print(v28, "- Damage Function (Distance)")
				print(30 - v28 / 3, "- Damage Function (Final Damage)")
				return 30 - v28 / 3
			end,
			["Knockback"] = function(p_u_29)
				-- upvalues: (ref) v_u_13, (ref) v_u_5
				local v30 = (v_u_13.instance.Position - p_u_29.PrimaryPart.Position).Magnitude
				print(v30, "- Knockback Function (Distance)")
				if v30 <= 12 then
					print("Ragdoll")
					v_u_5:Enable(p_u_29)
					task.delay(1, function()
						-- upvalues: (ref) v_u_5, (copy) p_u_29
						v_u_5:Disable(p_u_29)
					end)
				end
				local v31 = v30 - 27.5
				return math.abs(v31)
			end
		})
		v_u_7:EmitParticlesFromAttachment(v_u_13.instance.Explosion)
		v_u_6:Play(p_u_10.Config.Sounds.Explosion, {
			["Volume"] = 0.35,
			["Parent"] = v_u_13.instance
		})
		task.delay(1, function()
			v_u_2:Create(v_u_13.instance, TweenInfo.new(0.25), {Transparency = 1}):Play()
		end)
		task.delay(2.5, function()
			v_u_8.Destroy(v_u_13, p_u_10)
		end)
	end)
	table.insert(p_u_10.Voidstars, v_u_13.detonated)
	task.spawn(function()
		repeat
			wait()
		until p_u_10.Rig == nil or p_u_10.Rig.Parent == nil
		if v_u_13.instance and v_u_13.instance.Parent ~= nil then
			v_u_13.instance:Destroy()
		end
	end)
	return v_u_13
end
function v_u_8.Implant(p32)
	-- upvalues: (copy) v_u_2
	p32.killerInfo.AbilitiesDisabled = true;
	p32.instance.Anchored = true
	p32.instance.CanCollide = false
	p32.instance.Transparency = 0.7
	p32.killerRig.Voidstar.Transparency = 1
	p32.instance.CFrame = p32.killerRig:GetPivot() * CFrame.new(0, -3, -2.5)
	task.wait(0.5)
	v_u_2:Create(p32.killerRig.Voidstar, TweenInfo.new(0.35), {
		["Transparency"] = 0
	}):Play()
	p32.killerInfo.AbilitiesDisabled = false
	p32.ready = true
	p32.killerRig.Voidstar.Transparency = 0
end
function v_u_8.ImplantInside(p_u_33, p_u_34)
	-- upvalues: (copy) v_u_7, (copy) v_u_6
	p_u_33.killerInfo.AbilitiesDisabled = true;
	p_u_33.survivorException = p_u_34
	p_u_33.instance.Anchored = true
	p_u_33.instance.CanCollide = false
	p_u_33.instance.Transparency = 1
	p_u_34.PrimaryPart.Anchored = true
	p_u_33.killerRig:PivotTo(p_u_34.PrimaryPart.CFrame)
	p_u_34.PrimaryPart:PivotTo(p_u_34.PrimaryPart:GetPivot())
	p_u_33.killerRig.PrimaryPart.Anchored = true
	local v35 = v_u_7:LoadAnimationFromID(p_u_34, p_u_33.killerInfo.Config.Animations.ImplantAttackVictim, true)
	p_u_33.killerInfo.Cache.ImplantAttackNoli:Play(0)
	v35:Play(0)
	v_u_6:Play(p_u_33.killerInfo.Config.Sounds.ImplantInject, {
		["Volume"] = 0.3,
		["Parent"] = p_u_33.killerRig.PrimaryPart
	})
	task.wait(0.5)
	p_u_33.instance.Anchored = false
	p_u_33.instance.Transparency = 0
	p_u_33.killerRig.Voidstar.Transparency = 1
	p_u_33.instance.CFrame = p_u_34.PrimaryPart.CFrame * CFrame.new(0, 0, -0.5)
	local v36 = Instance.new("WeldConstraint")
	v36.Part0 = p_u_34.PrimaryPart
	v36.Part1 = p_u_33.instance
	v36.Parent = p_u_34.PrimaryPart
	task.delay(0.8, function()
		-- upvalues: (copy) p_u_34
		task.wait(0.25)
		p_u_34.PrimaryPart.Anchored = false
	end)
	task.delay(1.2, function()
		-- upvalues: (copy) p_u_33
		p_u_33.killerRig.PrimaryPart.Anchored = false
		p_u_33.killerRig.Voidstar.Transparency = 0
	end)
	task.wait(1.5)
	p_u_33.killerInfo.AbilitiesDisabled = false
	p_u_33.ready = true
end
function v_u_8.Throw(p37, p38)
	-- upvalues: (copy) v_u_2
	p37.instance.Anchored = false
	--p37.instance:SetNetworkOwner(nil)
	p37.instance.CanCollide = true
	p37.instance.Transparency = 0.25
	p37.killerRig.Voidstar.Transparency = 1
	local v39 = p37.killerRig.PrimaryPart.CFrame * CFrame.new(0, 0, -1)
	p37.instance.CFrame = v39
	p37.instance.AssemblyLinearVelocity = CFrame.lookAt(v39.Position, (v39 * CFrame.new(0, 4, -5)).Position).LookVector * (p38 * 1.35)
	local v40 = RaycastParams.new()
	v40.FilterDescendantsInstances = { workspace.Map, workspace:FindFirstChild("StudioAssets") }
	v40.FilterType = Enum.RaycastFilterType.Include
	v40.RespectCanCollide = true
	local v41
	while true do
		v41 = workspace:Raycast(p37.instance.Position, Vector3.new(0, -0.8, 0), v40)
		if v41 then
			print(v41)
			break
		end
		task.wait()
	end
	print(v41.Instance)
	print(v41.Distance)
	p37.instance.Anchored = true
	p37.instance.CanCollide = false
	v_u_2:Create(p37.instance, TweenInfo.new(0.25), {
		["Transparency"] = 0.7
	}):Play()
	task.wait(0.5)
	p37.ready = true
	v_u_2:Create(p37.killerRig.Voidstar, TweenInfo.new(0.5), {
		["Transparency"] = 0
	}):Play()
	print("Voidstar landed on ground")
end
function v_u_8.InsertConnection(p42, p43)
	local v44 = p42.connections
	table.insert(v44, p43)
end
function v_u_8.Destroy(p45, killerInfo)
	for _, v46 in pairs(p45.connections) do
		v46:Disconnect()
	end
	if p45.instance and p45.instance.Parent then
		p45.instance:Destroy()
	end
	table.remove(killerInfo.Voidstars, table.find(killerInfo.Voidstars, p45.detonated))
	table.clear(p45)
end
return v_u_8