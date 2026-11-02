---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("ServerScriptService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.EffectController)
local v_u_6 = require(v_u_1.Controllers.AnimalController)
local v_u_7 = require(v_u_1.Controllers.SoundController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Controllers.EventController)
local v_u_10 = require(v_u_1.Controllers.EventController.ClientEventUtils)
require(v_u_1.Packages.CreateTween)
local v_u_11 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
local v12 = require(v_u_1.Packages.Trove)
local v13 = require(v_u_1.Packages.Net)
local v_u_14 = require(v_u_1.Shared.VFX)
require(v_u_1.Shared.Snapshot)
local v_u_15 = script.Name
local v_u_16 = v13:RemoteEvent("EventService/Water/Burst")
local v_u_17 = v12.new()
local v_u_18 = {}
local function v_u_36()
	-- upvalues: (copy) v_u_17, (copy) v_u_3, (copy) v_u_11
	local v19 = v_u_17:Extend()
	local v_u_20 = table.create(4)
	v19:Add(function()
		-- upvalues: (copy) v_u_20
		table.clear(v_u_20)
	end)
	local v_u_21 = 0
	v19:Add(v_u_3.PreRender:Connect(function(p22)
		-- upvalues: (ref) v_u_21, (copy) v_u_20
		debug.profilebegin("Water Event")
		v_u_21 = v_u_21 + p22
		for v23, v24 in v_u_20 do
			if v24.target and v24.targetAttachment then
				v24.beam.First.Enabled = true
				v24.beam.Second.Enabled = true
				local v25 = v_u_21 - v23 + 1
				local v26 = math.clamp(v25, 0, 1)
				local v27 = v24.beam.WorldPosition
				v24.targetAttachment.Position = v27 + (v24.target:GetPivot().Position - v27) * v26
			end
		end
		debug.profileend()
	end))
	v19:Add(v_u_11.observeTag("WaterPlayerVFX", function(p_u_28)
		-- upvalues: (copy) v_u_20, (ref) v_u_11
		local v_u_29 = script.PlayerVFX.Beam:Clone()
		v_u_29.Parent = p_u_28
		local v_u_30 = script.PlayerVFX.Torso:Clone()
		v_u_30.Parent = p_u_28
		local v_u_31 = p_u_28:GetAttribute("WaterIndex")
		v_u_20[v_u_31] = {
			["beam"] = v_u_29,
			["target"] = nil
		}
		local v_u_35 = v_u_11.observeTag("WaterPlayerVFX", function(p32)
			-- upvalues: (copy) p_u_28, (copy) v_u_29, (ref) v_u_20
			if p32 == p_u_28 then
				return nil
			end
			if p32:GetAttribute("WaterIndex") ~= p_u_28:GetAttribute("WaterIndex") % 4 + 1 then
				return nil
			end
			local v_u_33 = Instance.new("Attachment")
			v_u_33.Position = v_u_29.WorldPosition
			v_u_33.Parent = workspace.Terrain
			local v34 = v_u_20[p_u_28:GetAttribute("WaterIndex")]
			v34.target = p32
			v34.beam.First.Attachment0 = v_u_33
			v34.beam.Second.Attachment0 = v_u_33
			v34.targetAttachment = v_u_33
			return function()
				-- upvalues: (copy) v_u_33
				v_u_33:Destroy()
			end
		end)
		return function()
			-- upvalues: (copy) v_u_30, (copy) v_u_29, (copy) v_u_35, (ref) v_u_20, (copy) v_u_31
			v_u_30:Destroy()
			v_u_29:Destroy()
			v_u_35()
			v_u_20[v_u_31] = nil
		end
	end))
end
local function v_u_57()
	-- upvalues: (copy) v_u_17, (copy) v_u_11, (copy) v_u_18, (copy) v_u_3
	local v_u_37 = {}
	v_u_17:Add(v_u_11.observeTag("WaterShark", function(p_u_38)
		-- upvalues: (ref) v_u_18, (copy) v_u_37
		local v39 = p_u_38:GetAttribute("SharkType") or "Orcalero Orcala"
		local v40 = script[v39]
		local v_u_41 = v40:Clone()
		v_u_41.PrimaryPart.Anchored = true
		v_u_41.Parent = p_u_38
		local v42
		if v40 == script["Orcalero Orcala"] then
			v42 = script.OrcaleroSwim
		else
			v42 = script.TralaleroSwim
		end
		local v43
		if v40 == script["Orcalero Orcala"] then
			v43 = script.OrcaleroAttack
		else
			v43 = script.TralaleroAttack
		end
		local v_u_44 = v_u_41.AnimationController.Animator:LoadAnimation(v42)
		v_u_44.Priority = Enum.AnimationPriority.Action
		local v_u_45 = v_u_41.AnimationController.Animator:LoadAnimation(v43)
		v_u_45.Priority = Enum.AnimationPriority.Action4
		v_u_45.Looped = false
		v_u_44:Play()
		local function v_u_46()
			-- upvalues: (copy) v_u_44, (copy) v_u_45
			v_u_44:Stop(0)
			v_u_44:Destroy()
			v_u_45:Stop(0)
			v_u_45:Destroy()
		end
		local v_u_47 = p_u_38:GetAttributeChangedSignal("Attack"):Connect(function()
			-- upvalues: (copy) v_u_45
			v_u_45:Play()
		end)
		v_u_18[p_u_38.Name] = v_u_41
		local v48 = v_u_37
		table.insert(v48, p_u_38)
		return function()
			-- upvalues: (ref) v_u_37, (copy) p_u_38, (copy) v_u_47, (copy) v_u_41, (ref) v_u_18, (ref) v_u_46
			local v49 = table.find(v_u_37, p_u_38)
			if v49 then
				table.remove(v_u_37, v49)
			end
			v_u_47:Disconnect()
			v_u_41:Destroy()
			v_u_18[p_u_38.Name] = nil
			local v50 = v_u_46
			if type(v50) == "function" then
				v_u_46()
				v_u_46 = nil
			end
		end
	end))
	v_u_17:Add(v_u_3.PreRender:Connect(function(_)
		-- upvalues: (copy) v_u_37, (ref) v_u_18
		debug.profilebegin("WaterEvent:Update Sharks")
		local v51 = {}
		local v52 = {}
		for _, v53 in v_u_37 do
			local v54 = v_u_18[v53.Name]
			if v54 then
				local v55 = v54.PrimaryPart
				table.insert(v51, v55)
				local v56 = v53.CFrame
				table.insert(v52, v56)
			end
		end
		workspace:BulkMoveTo(v51, v52, Enum.BulkMoveMode.FireCFrameChanged)
		debug.profileend()
	end))
end
function v4.OnStart(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_15, (copy) v_u_1, (copy) v_u_17, (copy) v_u_5, (copy) v_u_8, (copy) v_u_7, (copy) v_u_57, (copy) v_u_11, (copy) v_u_3, (copy) v_u_36
	local v58 = v_u_9:GetActiveEventData(v_u_15)
	assert(v58)
	v_u_1:SetAttribute("WaterEvent", true)
	v_u_17:Add(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_15, (ref) v_u_8, (ref) v_u_7
		v_u_1:SetAttribute("WaterEvent", nil)
		v_u_5:Activate("Blink")
		v_u_5:Stop(v_u_15, "GrassRecolor")
		v_u_8:Update()
		v_u_7:UpdateOST()
		v_u_7:UpdateAmbience()
	end)
	v_u_17:Add(task.delay(v58.startedAt + 4 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_5, (ref) v_u_17, (ref) v_u_15, (ref) v_u_8, (ref) v_u_7, (ref) v_u_57, (ref) v_u_11, (ref) v_u_3
		v_u_5:Activate("Blink")
		local v59 = v_u_17:Add(Instance.new("ColorCorrectionEffect"))
		v59.Brightness = 0.15
		v59.Contrast = 0.1
		v59.Saturation = -0.1
		v59.TintColor = Color3.fromRGB(113, 186, 234)
		v59.Parent = workspace.CurrentCamera
		v_u_17:Clone(script.Water).Parent = workspace
		v_u_5:Run(v_u_15, "GrassRecolor")
		v_u_8:Update()
		v_u_7:UpdateOST()
		v_u_7:UpdateAmbience()
		v_u_57()
		v_u_17:Add(v_u_11.observeCharacters(function(_, p_u_60)
			-- upvalues: (ref) v_u_11
			return v_u_11.observeChildren(p_u_60, function(p61)
				-- upvalues: (ref) v_u_11, (copy) p_u_60
				if p61.Name ~= "UpperTorso" then
					return nil
				end
				local v_u_62 = {}
				for _, v63 in script.PlayerBubbles:GetChildren() do
					local v64 = v63:Clone()
					v64.Parent = p61
					table.insert(v_u_62, v64)
				end
				local v_u_69 = v_u_11.observeChildren(p_u_60, function(p_u_65)
					-- upvalues: (copy) v_u_62
					if not p_u_65:IsA("Humanoid") then
						return nil
					end
					local v_u_68 = p_u_65:GetPropertyChangedSignal("MoveDirection"):Connect(function()
						-- upvalues: (copy) p_u_65, (ref) v_u_62
						local v66 = p_u_65.MoveDirection ~= Vector3.new(0, 0, 0)
						for _, v67 in v_u_62 do
							v67.Enabled = v66
						end
					end)
					return function()
						-- upvalues: (copy) v_u_68
						v_u_68:Disconnect()
					end
				end)
				return function()
					-- upvalues: (copy) v_u_62, (copy) v_u_69
					for _, v70 in v_u_62 do
						v70:Destroy()
					end
					table.clear(v_u_62)
					v_u_69()
				end
			end)
		end))
		v_u_17:Add(function()
			workspace.Gravity = 196.2
		end)
		v_u_17:Add(v_u_3.PostSimulation:Connect(function(_)
			debug.profilebegin("Water:Gravity")
			workspace.Gravity = 29.429999999999996
			debug.profileend()
		end))
	end))
	v_u_17:Add(task.spawn(function()
		-- upvalues: (ref) v_u_36
		v_u_36()
	end))
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_17
	v_u_17:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_16, (copy) v_u_6, (copy) v_u_18, (copy) v_u_10, (copy) v_u_14, (copy) v_u_7, (copy) v_u_1
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	v_u_16.OnClientEvent:Connect(function(p71, p72)
		-- upvalues: (ref) v_u_6, (ref) v_u_18, (ref) v_u_10, (ref) v_u_14, (ref) v_u_7, (ref) v_u_1
		local v73 = v_u_6:GetAnimals()[p72]
		if v73 then
			local v74 = v_u_18[p71]
			if v74 then
				v74.Parent:SetAttribute("Attack", not v74.Parent:GetAttribute("Attack"))
			end
			local v_u_75 = script.Burst:Clone()
			v_u_75.CFrame = CFrame.new(v_u_10.getAnimalPosition(p72, {
				["top"] = true
			}))
			v_u_75.Anchored = false
			local v76 = Instance.new("WeldConstraint")
			v76.Part0 = v_u_75
			v76.Part1 = v73.AnimalModel.PrimaryPart
			v76.Parent = v_u_75
			v_u_75.Parent = workspace
			v_u_14.emit(v_u_75)
			v_u_7:PlaySound(v_u_1.Sounds.Events.Water["Brainrot Hit"], v_u_75.Position)
			task.delay(3, function()
				-- upvalues: (copy) v_u_75
				v_u_75:Destroy()
			end)
		end
	end)
end
return v4
