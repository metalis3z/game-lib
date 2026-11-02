local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v3 = {}
local v_u_4 = require(v_u_1.Controllers.AnimalController)
local v_u_5 = require(v_u_1.Controllers.EffectController)
local v_u_6 = require(v_u_1.Controllers.SoundController)
local v_u_7 = require(v_u_1.Controllers.EventController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Packages.Synchronizer)
local v_u_9 = require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.Observers)
require(v_u_1.Shared.TweenPivot)
local v_u_10 = require(v_u_1.Shared.MapInformation)
local v11 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v_u_12 = require(v_u_1.Packages.Net):RemoteEvent("EventService/NyanCats/Struck")
local v_u_13 = script.Name
local v_u_14 = v11.new()
local v_u_15 = workspace.CurrentCamera
function v3.OnStart(_)
	local v_u_16 = v_u_7:GetActiveEventData(v_u_13)
	assert(v_u_16)
	v_u_1:SetAttribute("NyanCatsEvent", true)
	v_u_14:Add(function()
		v_u_1:SetAttribute("NyanCatsEvent", nil)
	end)
	v_u_5:Run(v_u_13, "Space")
	v_u_5:Activate("Blink")
	v_u_14:Add(function()
		v_u_5:Activate("Blink")
	end)
	v_u_6:UpdateOST()
	v_u_8:Update()
	v_u_14:Add(function()
		v_u_5:Stop(v_u_13, "Space")
	end)
	local function v_u_31(p17, p18, p19)
		local v20 = p17 / 10
		local v21 = math.ceil(v20)
		local v22 = (p17 % 10 + 1) / 10
		local v23 = (p18 or 0) + v21 + v22 * 3.141592653589793 * 2
		local v24 = v_u_10.MapCenter.Position
		local v25 = v21 * 15 + 35
		local v26 = v24 + vector.create(0, v25, 0)
		local v27 = math.cos(v23) * 270 * 0.5
		if not p19 then
			local v28 = os.clock() * 6
			p19 = math.sin(v28) * 1.5
		end
		local v29 = math.sin(v23) * 420 * 0.5
		local v30 = vector.create(v27, p19, v29)
		return CFrame.lookAt(v26 + v30, v26)
	end
	local v_u_32 = table.create(30)
	for v33 = 1, 30 do
		local v34 = v_u_14:Clone(script.NyanCat)
		v34.Parent = workspace
		local v_u_35 = v34.AnimationController.Animator:LoadAnimation(script.Animation)
		v_u_35.Looped = true
		v_u_35:Play()
		v_u_14:Add(function()
			v_u_35:Stop(0)
			v_u_35:Destroy()
		end)
		local v36 = {
			["model"] = v34,
			["scale"] = v34:GetScale(),
			["rootPart"] = v34.RootPart,
			["state"] = {
				["type"] = "hovering"
			},
			["visualState"] = {
				["cframe"] = v_u_31(v33)
			}
		}
		v_u_32[v33] = v36
	end
	local v_u_37 = table.create(30)
	local v_u_38 = table.create(30)
	v_u_14:Add(v_u_2.PostSimulation:Connect(function(p39)
		debug.profilebegin("Nyan Cats")
		local v40 = workspace:GetServerTimeNow()
		local v41 = (v40 - v_u_16.startedAt) * 10
		local v42 = math.rad(v41)
		local v43 = v40 * 6
		local v44 = math.sin(v43) * 1.5
		for v45, v46 in v_u_32 do
			local v47 = nil
			if v46.state.type == "hovering" then
				v46.visualState.startCFrame = nil
				v47 = v_u_31(v45, v42, v44)
			elseif v46.state.type == "follow" or v46.state.type == "restore" then
				local v48 = v46.state.type == "restore"
				if v46.visualState.lastState ~= v46.state.type then
					v46.visualState.timer = 0
					v46.visualState.startCFrame = v46.visualState.cframe
					v46.visualState.lastState = v46.state.type
					local v49 = v46.visualState
					local v50 = v46.visualState.cframe
					local v51
					if v48 then
						v51 = CFrame.new(0, 100, 0)
					else
						v51 = CFrame.new(0, 40, -100)
					end
					v49.p1 = v50 * v51
				end
				local v52 = v46.visualState
				v52.timer = v52.timer + p39
				local v53 = v46.state.lerpTime or 3
				local v54
				if v48 then
					v54 = v_u_31(v45, v42, v44).Position
				else
					v54 = v46.state.value
				end
				local v55 = v46.visualState.timer / v53
				local v56 = math.clamp(v55, 0, 1)
				local v57 = v46.visualState.startCFrame.Position
				local v58 = v46.visualState.p1.Position
				local v59 = (1 - v56) ^ 2 * v57 + (1 - v56) * 2 * v56 * v58 + v56 ^ 2 * v54
				local v60 = CFrame.lookAt(v59, v54 + Vector3.new(0.000001, 0.000001, 0.000001))
				local v61 = CFrame.Angles
				local v62 = v46.visualState.timer / (v53 * 0.5)
				v47 = v60 * v61(0, -1.5707963267948966 * math.clamp(v62, 0, 1), 0)
				local v63
				if v48 then
					local v64 = v46.scale
					v63 = math.lerp(0.5, v64, v56)
				else
					local v65 = v46.scale
					v63 = math.lerp(v65, 0.5, v56)
				end
				v46.model:ScaleTo(v63)
				if v48 and v56 >= 1 then
					v46.state = {
						["type"] = "hovering"
					}
				end
			end
			v46.visualState.cframe = v47
			v_u_37[v45] = v46.rootPart
			v_u_38[v45] = v47
		end
		workspace:BulkMoveTo(v_u_37, v_u_38, Enum.BulkMoveMode.FireCFrameChanged)
		debug.profileend()
	end))
	v_u_14:Add(v_u_12.OnClientEvent:Connect(function(p_u_66, p67, p68)
		local v_u_69 = v_u_4:GetAnimals()[p67]
		if v_u_69 then
			local v_u_70 = p68 + 3 - workspace:GetServerTimeNow()
			local v77 = v_u_2.PreRender:Connect(function()
				debug.profilebegin("Update Nycan Cat Follow Target")
				local v71 = v_u_32[p_u_66]
				local v72 = {
					["type"] = "follow"
				}
				local v73 = v_u_69.AnimalModel
				local v74
				if v73.PrimaryPart then
					v74 = v73.PrimaryPart.CFrame
				else
					v74 = v73:GetPivot()
				end
				local v75 = v74.Position
				local v76 = v_u_69.AnimalModel:GetExtentsSize().Y * 0.5
				v72.value = v75 + Vector3.new(0, v76, 0)
				v72.lerpTime = v_u_70
				v71.state = v72
				debug.profileend()
			end)
			task.wait(v_u_70)
			v77:Disconnect()
			v_u_32[p_u_66].state = {
				["type"] = "restore"
			}
			local v78 = v_u_69.AnimalModel
			local v79
			if v78.PrimaryPart then
				v79 = v78.PrimaryPart.CFrame
			else
				v79 = v78:GetPivot()
			end
			local v80 = v79.Position
			local v81 = v_u_69.AnimalModel:GetExtentsSize().Y * 0.5
			local v_u_82 = v80 + Vector3.new(0, v81, 0)
			task.spawn(function()
				v_u_6:PlaySound(v_u_1.Sounds.Events["Nyan Cats"].Hit, v_u_82)
			end)
			local v_u_83 = script.StruckVFX:Clone()
			v_u_83:PivotTo(CFrame.new(v_u_82))
			v_u_83.Anchored = false
			local v84 = Instance.new("WeldConstraint")
			v84.Part0 = v_u_83
			v84.Part1 = v_u_69.AnimalModel.PrimaryPart
			v84.Parent = v_u_83
			v_u_83.Parent = workspace
			for _, v_u_85 in v_u_83:GetDescendants() do
				if v_u_85:IsA("ParticleEmitter") then
					task.delay(v_u_85:GetAttribute("EmitDelay") or 0, function()
						v_u_85:Emit(v_u_85:GetAttribute("EmitCount"))
					end)
				end
			end
			task.delay(3, function()
				v_u_83:Destroy()
			end)
			if (v_u_15.CFrame.Position - v_u_82).Magnitude <= 70 then
				local v_u_86 = v_u_9.Bump:Clone()
				v_u_14:Add(v_u_86)
				v_u_86.Sustain = true
				v_u_14:Add(v_u_9.BindShakeToCamera(v_u_86, v_u_15))
				v_u_86:Start()
				v_u_14:Add(task.delay(0.3, function()
					v_u_86:StopSustain()
				end))
			end
		end
	end))
end
function v3.OnStop(_)
	v_u_14:Destroy()
end
function v3.OnLoad(_) end
return v3