-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.EncryptedAssetsController)
local v_u_8 = require(v_u_1.Controllers.AnimalController)
local v_u_9 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.CameraController)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.EventController)
local v_u_12 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.SharedEventUtils)
local v_u_13 = require(v_u_1.Packages.CreateTween)
local v_u_14 = require(v_u_1.Shared.TweenPivot)
local v_u_15 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)
local v_u_16 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v17 = require(v_u_1.Packages.Net)
local v_u_18 = require(v_u_1.Shared.VFX)
local v_u_19 = workspace.Sounds.IndonesiaEvent
local _ = v4.LocalPlayer
local _ = workspace.CurrentCamera
local v_u_20 = script.Name
local v_u_21 = v17:RemoteEvent((("EventService/%*/Burst"):format(v_u_20)))
local _ = workspace.RenderedMovingAnimals
local v_u_22 = v_u_16.new()
function v6.OnStart(_)
	-- upvalues: (copy) v_u_19, (copy) v_u_11, (copy) v_u_20, (copy) v_u_22, (copy) v_u_9, (copy) v_u_12, (copy) v_u_10, (copy) v_u_15, (copy) v_u_18, (copy) v_u_1, (copy) v_u_14, (copy) v_u_13, (copy) v_u_7
	v_u_19:Play()
	local v_u_23 = v_u_11:GetActiveEventData(v_u_20)
	assert(v_u_23)
	v_u_22:Add(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_12, (ref) v_u_10
		v_u_9:Activate("Blink")
		v_u_12:Update()
		v_u_10:UpdateOST()
	end)
	local v_u_24 = v_u_22:Clone(script.Map)
	v_u_24.Parent = workspace
	v_u_22:Add(v_u_15.observeTag("HideInIndonesia", function(p_u_25)
		local v_u_26 = p_u_25.Parent
		p_u_25.Parent = script
		return function()
			-- upvalues: (copy) p_u_25, (copy) v_u_26
			pcall(function()
				-- upvalues: (ref) p_u_25, (ref) v_u_26
				p_u_25.Parent = v_u_26
			end)
		end
	end, { workspace, script }))
	v_u_22:Add(v_u_15.observeTag("HideInIndonesiaTransparency", function(p_u_27)
		p_u_27.Transparency = 1
		return function()
			-- upvalues: (copy) p_u_27
			p_u_27.Transparency = 0
		end
	end, { workspace }))
	v_u_9:Activate("Blink")
	v_u_12:Update()
	v_u_10:UpdateOST()
	v_u_9:Run("IndonesiaEvent", "GrassRecolor")
	v_u_9:Run("IndonesiaEvent", "WallRecolor")
	v_u_9:Run("IndonesiaEvent", "WallBottomRecolor")
	v_u_22:Add(function()
		-- upvalues: (ref) v_u_9
		v_u_9:Stop("IndonesiaEvent", "GrassRecolor")
		v_u_9:Stop("IndonesiaEvent", "WallRecolor")
		v_u_9:Stop("IndonesiaEvent", "WallBottomRecolor")
	end)
	v_u_18.enable(v_u_24.MapVFX.Waterfall)
	local v_u_28 = v_u_23.startedAt + 13 - workspace:GetServerTimeNow()
	task.spawn(function()
		-- upvalues: (copy) v_u_28, (ref) v_u_10, (ref) v_u_1, (copy) v_u_24
		if v_u_28 > 10 then
			v_u_10:PlaySound(v_u_1.Sounds.Events.Indonesia.Activating, v_u_24.MapVFX.Waterfall.indonesiawaterfall.Position, false)
		end
	end)
	local v29 = v_u_24.Flood:GetPivot()
	v_u_24.Flood:PivotTo(v29 - Vector3.new(0, 3, 0))
	v_u_22:Add(v_u_14(v_u_24.Flood, TweenInfo.new(v_u_28, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), v29)):Play()
	v_u_22:Add(task.delay(v_u_23.startedAt + 87.78999999999999 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_1, (ref) v_u_12, (ref) v_u_10, (ref) v_u_22
		v_u_1:SetAttribute("IndonesiaEventPart2", true)
		v_u_12:Update()
		v_u_10:UpdateOST()
		v_u_22:Add(function()
			-- upvalues: (ref) v_u_1, (ref) v_u_12, (ref) v_u_10
			v_u_1:SetAttribute("IndonesiaEventPart2", nil)
			v_u_12:Update()
			v_u_10:UpdateOST()
		end)
	end))
	v_u_22:Add(task.delay(v_u_28, function()
		-- upvalues: (ref) v_u_18, (copy) v_u_24, (ref) v_u_1, (ref) v_u_22
		v_u_18.disable(v_u_24.MapVFX.Waterfall)
		v_u_1:SetAttribute("IndonesiaEventAmbience", true)
		v_u_22:Add(function()
			-- upvalues: (ref) v_u_1
			v_u_1:SetAttribute("IndonesiaEventAmbience", nil)
		end)
	end))
	v_u_22:Add(task.spawn(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_13, (ref) v_u_7, (copy) v_u_23, (ref) v_u_22
		v_u_19.Volume = 0
		v_u_13(v_u_19, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			["Volume"] = 1
		})
		v_u_7:WaitForAssetId("rbxassetid://119158848540465")
		v_u_19.SoundId = ""
		v_u_19.SoundId = "rbxassetid://119158848540465"
		while not v_u_19.IsLoaded do
			task.wait()
		end
		v_u_19.TimePosition = 62 + (workspace:GetServerTimeNow() - v_u_23.startedAt)
		v_u_19:Play()
		v_u_22:Add(function()
			-- upvalues: (ref) v_u_19
			v_u_19:Stop()
		end)
	end))
end
function v6.OnStop(_)
	-- upvalues: (copy) v_u_22
	v_u_22:Destroy()
end
function v6.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_19, (copy) v_u_15, (copy) v_u_16, (copy) v_u_22, (copy) v_u_3, (copy) v_u_21, (copy) v_u_8, (copy) v_u_18, (copy) v_u_5, (copy) v_u_10, (copy) v_u_1
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_19, (ref) v_u_2
		v_u_7:WaitForAssetId("rbxassetid://119158848540465")
		v_u_19.SoundId = "rbxassetid://119158848540465"
		v_u_2:PreloadAsync({ v_u_19 })
	end)
	v_u_15.observeTag("IndonesiaCanoe", function(p30)
		-- upvalues: (ref) v_u_16, (ref) v_u_22, (ref) v_u_3, (ref) v_u_19
		local v31 = v_u_16.new()
		local v32 = v31:Clone(script.Canoe)
		local v33 = v32.PrimaryPart
		v32.Parent = p30
		local v34 = Instance.new("Weld")
		v34.Part0 = v33
		v34.Part1 = p30
		v34.C0 = CFrame.Angles(0, 3.141592653589793, 0)
		v34.Parent = v33
		local v_u_35 = v32["Bambu Bambu Sahur"].AnimationController.Animator:LoadAnimation(script.BambuDance);
		(v31 or v_u_22):Add(function()
			-- upvalues: (copy) v_u_35
			v_u_35:Stop(0)
			v_u_35:Destroy()
		end)
		v_u_35.Looped = true
		v_u_35:Play()
		v31:Add(v_u_3.PreRender:Connect(function()
			-- upvalues: (ref) v_u_19, (copy) v_u_35
			local v36 = v_u_19.PlaybackLoudness / 1000
			local v37 = math.clamp(v36, 0, 1)
			v_u_35:AdjustSpeed((math.lerp(1.3, 2, v37)))
		end))
		return v31:WrapClean()
	end, { workspace })
	v_u_21.OnClientEvent:Connect(function(p38)
		-- upvalues: (ref) v_u_8, (ref) v_u_22, (ref) v_u_18, (ref) v_u_5, (ref) v_u_10, (ref) v_u_1
		local v39 = v_u_8:GetAnimals()[p38]
		if v39 then
			local v40 = v39.AnimalModel
			local v41
			if v40 then
				v41 = v40.PrimaryPart
			else
				v41 = v40
			end
			local v42 = v39.Instance
			local v43
			if v42 then
				v43 = v42.PrimaryPart
			else
				v43 = v42
			end
			if v43 and v41 then
				local v44 = v_u_22:Clone(script.Burst)
				v44:PivotTo(v43.CFrame * CFrame.new(0, (v44.Size.Y + v40:GetExtentsSize().Y) / 2, 0))
				v44.Parent = v42
				local v45 = Instance.new("WeldConstraint")
				v45.Part0 = v44
				v45.Part1 = v39.AnimalModel.PrimaryPart
				v45.Parent = v44
				v_u_18.emit(v44)
				v_u_5:AddItem(v44, 5)
				v_u_10:PlaySound(v_u_1.Sounds.Events.Indonesia.BrainrotHit, v43.CFrame.Position, false)
			end
		else
			return
		end
	end)
end
return v6
