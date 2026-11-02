local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v3 = {}
require(v_u_1.Controllers.AnimalController)
local v_u_4 = require(v_u_1.Controllers.EffectController)
local v_u_5 = require(v_u_1.Controllers.SoundController)
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Controllers.CycleController)
local v_u_8 = require(v_u_1.Packages.FFlags)
require(v_u_1.Shared.ShakePresets)
local v_u_9 = require(v_u_1.Packages.Observers)
require(v_u_1.Shared.TweenPivot)
local v_u_10 = require(v_u_1.Datas.ServerData)
local v_u_11 = require(v_u_1.Utils.MathUtils)
local v12 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v13 = require(v_u_1.Packages.Net)
local v_u_14 = require(v_u_1.Shared.VFX)
local v_u_15 = script["Svinina Bombardino"]
local v_u_16 = script["Bombardiro Crocodilo"]
local v_u_17 = v13:RemoteEvent("EventService/Bombardiro Crocodilo/SpawnBomb")
local v_u_18 = v13:RemoteEvent("EventService/Bombardiro Crocodilo/Explode")
local v_u_19 = script.Name
local v_u_20 = v12.new()
local _ = workspace.CurrentCamera
local v_u_21 = {}
function v3.OnStart(_)
	local v22 = v_u_6:GetActiveEventData(v_u_19)
	assert(v22)
	workspace:GetServerTimeNow()
	v_u_1:SetAttribute("BombardiroCrocodiloEvent", true)
	v_u_20:Add(function()
		v_u_1:SetAttribute("BombardiroCrocodiloEvent", nil)
	end)
	v_u_20:Add(task.delay(v22.startedAt + 8 - workspace:GetServerTimeNow(), function()
		local v23 = v_u_20:Clone(script.Planesbg)
		v_u_14.enable(v23)
		v23.Parent = workspace
		v_u_1:SetAttribute("BombardiroCrocodiloEventSoundTrack", true)
		v_u_5:UpdateOST()
		v_u_20:Add(function()
			v_u_1:SetAttribute("BombardiroCrocodiloEventSoundTrack", nil)
			v_u_5:UpdateOST()
			v_u_4:Activate("Blink")
		end)
	end))
	v_u_5:UpdateOST()
	v_u_7:Update()
	local v24 = v_u_20:Extend()
	local v_u_25 = table.create(3)
	v24:Add(function()
		table.clear(v_u_25)
	end)
	local v_u_26 = 0
	v24:Add(v_u_2.PreRender:Connect(function(p27)
		debug.profilebegin("Bombardiro Event")
		v_u_26 = v_u_26 + p27
		for v28, v29 in v_u_25 do
			if v29.target and v29.targetAttachment then
				v29.beam.First.Enabled = true
				v29.beam.Second.Enabled = true
				local v30 = v_u_26 - v28 + 1
				local v31 = math.clamp(v30, 0, 1)
				local v32 = v29.beam.WorldPosition
				v29.targetAttachment.Position = v32 + (v29.target:GetPivot().Position - v32) * v31
			end
		end
		debug.profileend()
	end))
	v24:Add(v_u_9.observeTag("BombardiroCrocodiloPlayerVFX", function(p_u_33)
		local v_u_34 = script.PlayerVFX.Beam:Clone()
		v_u_34.Parent = p_u_33
		local v_u_35 = script.PlayerVFX.Torso:Clone()
		v_u_35.Parent = p_u_33
		local v_u_36 = p_u_33:GetAttribute("BombardiroIndex")
		v_u_25[v_u_36] = {
			["beam"] = v_u_34,
			["target"] = nil
		}
		local v_u_40 = v_u_9.observeTag("BombardiroCrocodiloPlayerVFX", function(p37)
			if p37 == p_u_33 then
				return nil
			end
			if p37:GetAttribute("BombardiroIndex") ~= p_u_33:GetAttribute("BombardiroIndex") % 3 + 1 then
				return nil
			end
			local v_u_38 = Instance.new("Attachment")
			v_u_38.Position = v_u_34.WorldPosition
			v_u_38.Parent = workspace.Terrain
			local v39 = v_u_25[p_u_33:GetAttribute("BombardiroIndex")]
			v39.target = p37
			v39.beam.First.Attachment0 = v_u_38
			v39.beam.Second.Attachment0 = v_u_38
			v39.targetAttachment = v_u_38
			return function()
				v_u_38:Destroy()
			end
		end)
		return function()
			v_u_35:Destroy()
			v_u_34:Destroy()
			v_u_40()
			v_u_25[v_u_36] = nil
		end
	end))
	local v_u_41 = {}
	v_u_20:Add(v_u_9.observeTag("BombardiroPlane", function(p_u_42)
		local v_u_43 = v_u_16:Clone()
		v_u_43.PrimaryPart.Anchored = true
		for _, v44 in v_u_43["Svinina Bombardino"]:GetChildren() do
			if v44.Name ~= "RootPart" then
				v44.Transparency = 1
			end
		end
		if v_u_8:GetInstant("Optimisation.HumanoidBrainrotModels", v_u_10.IsNewPlayersServer()) then
			local v45 = v_u_43:FindFirstChild("AnimationController")
			if v45 then
				v45:Destroy()
			end
			local v46 = Instance.new("Humanoid", v_u_43)
			Instance.new("Animator", v46)
			v46.Name = "AnimationController"
			v46.EvaluateStateMachine = false
			v46.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			v46.PlatformStand = true
			v46.Parent = v_u_43
		end
		v_u_43.Parent = p_u_42
		local v_u_48 = task.delay(5, function()
			for _, v47 in v_u_43["Svinina Bombardino"]:GetChildren() do
				if v47.Name ~= "RootPart" then
					v47.Transparency = 0
				end
			end
		end)
		v_u_21[p_u_42.Name] = v_u_43
		local v49 = v_u_41
		table.insert(v49, p_u_42)
		return function()
			local v50 = table.find(v_u_41, p_u_42)
			if v50 then
				table.remove(v_u_41, v50)
			end
			v_u_43:Destroy()
			v_u_21[p_u_42.Name] = nil
			if coroutine.status(v_u_48) == "suspended" then
				pcall(task.cancel, v_u_48)
			end
		end
	end))
	v_u_20:Add(v_u_2.PreRender:Connect(function(_)
		debug.profilebegin("Bombardiro Crocodilo:BulkMoveTo")
		local v51 = {}
		local v52 = {}
		for _, v53 in v_u_41 do
			local v54 = v_u_21[v53.Name]
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
function v3.OnStop(_)
	v_u_20:Destroy()
end
function v3.OnLoad(_)
	local function v_u_60(p57, p58)
		local v_u_59 = script[p58 or "Explosion"]:Clone()
		v_u_59.CFrame = p57
		v_u_59.Parent = workspace
		v_u_14.emit(v_u_59)
		task.delay(5, function()
			v_u_59:Destroy()
		end)
	end
	v_u_17.OnClientEvent:Connect(function(p61, p_u_62, p63)
		local v64 = v_u_21[p61]
		if v64 and v64:FindFirstChild("Svinina Bombardino") then
			for _, v_u_65 in v64["Svinina Bombardino"]:GetChildren() do
				if v_u_65.Name ~= "RootPart" then
					v_u_65.Transparency = 1
					task.delay(1, function()
						v_u_65.Transparency = 0
					end)
				end
			end
		end
		local v_u_66 = v_u_15:Clone()
		v_u_66.PrimaryPart.Anchored = true
		v_u_66:PivotTo(CFrame.new(p_u_62))
		local v67 = v_u_1.Sounds.Events["Bombardiro Crocodilo"].DroppingBomb:Clone()
		v67.Parent = v_u_66
		v_u_66.Parent = workspace
		v67:Play()
		local v_u_68 = 0
		local v_u_69 = v_u_11.calculateTimeToGround(p_u_62.y, p63.y)
		local v_u_70 = nil
		v_u_70 = v_u_2.PostSimulation:Connect(function(p71)
			debug.profilebegin("Bombardiro Crocodilo:Bomb")
			v_u_68 = v_u_68 + p71
			local v72 = v_u_68 / v_u_69
			local v73 = v_u_66
			local v74 = CFrame.new
			local v75 = p_u_62
			local v76 = v_u_11.simulateGravity(v_u_68)
			v73:PivotTo(v74(v75 - vector.create(0, v76, 0)) * CFrame.Angles(-v_u_68 * 3.141592653589793 * 2, 0, 0))
			debug.profileend()
			if v72 >= 1 then
				v_u_70:Disconnect()
				for _, v77 in v_u_66:GetDescendants() do
					if v77:IsA("BasePart") then
						v77.Transparency = 1
					elseif v77:IsA("ParticleEmitter") then
						v77:Destroy()
					end
				end
				task.wait(3)
				v_u_66:Destroy()
			end
		end)
	end)
	v_u_18.OnClientEvent:Connect(function(p78, p79)
		local v80 = v_u_60
		if typeof(p78) ~= "CFrame" then
			p78 = CFrame.new(p78)
		end
		v80(p78, p79)
	end)
end
return v3