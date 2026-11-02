---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("CollectionService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("RunService")
local v_u_3 = game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v4 = {
	["Duration"] = {
		["Default"] = 600
	}
}
local v_u_5 = require(v_u_1.Controllers.ConfirmationController)
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Controllers.SoundController)
local v_u_8 = require(v_u_1.Shared.SharedEventUtils)
local v_u_9 = require(v_u_1.Packages.CreateTween)
local v_u_10 = require(v_u_1.Datas.Animals)
require(v_u_1.Utils.TimeUtils)
local v_u_11 = require(v_u_1.Packages.Trove)
local v12 = require(v_u_1.Packages.Net)
local v_u_13 = require(v_u_1.Packages.Spr)
local v_u_14 = require(v_u_1.Shared.VFX)
local v_u_15 = v12:RemoteEvent("EventService/FatSammy/PlaySpawnSequence")
local v_u_16 = v12:RemoteEvent("EventService/FatSammy/PlayEatAnimation")
local v_u_17 = v12:RemoteEvent("EventService/FatSammy/Delivery")
local v_u_18 = script.Name
local v_u_19 = v_u_3.LocalPlayer
local v_u_20 = workspace.Events.FatSammy.Model
local v_u_21 = v_u_20.Sammy
local v_u_22 = v_u_21.AnimationController.Animator
local v_u_23 = false
local v_u_24 = v_u_11.new()
function v4.OnStart(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_18, (copy) v_u_11, (copy) v_u_24, (ref) v_u_23, (copy) v_u_8, (copy) v_u_22, (copy) v_u_16, (copy) v_u_7, (copy) v_u_1, (copy) v_u_21, (copy) v_u_15, (copy) v_u_14, (copy) v_u_9
	local v25 = v_u_6:GetActiveEventData(v_u_18)
	assert(v25)
	local v_u_26 = v_u_11.new()
	v_u_24:Add(function()
		-- upvalues: (ref) v_u_23, (copy) v_u_26
		while v_u_23 do
			task.wait()
		end
		v_u_26:Destroy()
	end)
	local v27 = v_u_8.loadAnimation(v_u_26, v_u_22, script.Idle)
	local v_u_28 = v_u_8.loadAnimation(v_u_26, v_u_22, script.PointUp)
	local v_u_29 = v_u_8.loadAnimation(v_u_26, v_u_22, script.PoseToBeam)
	local v_u_30 = v_u_8.loadAnimation(v_u_26, v_u_22, script.BeamLoop)
	local v_u_31 = v_u_8.loadAnimation(v_u_26, v_u_22, script.BeamResume)
	local v_u_32 = v_u_8.loadAnimation(v_u_26, v_u_22, script.Eat)
	v_u_26:Add(v_u_28:GetMarkerReachedSignal("Freeze"):Connect(function()
		-- upvalues: (copy) v_u_28
		v_u_28:AdjustSpeed(0)
	end))
	v27.Looped = true
	v27:Play()
	v_u_24:Add(v_u_16.OnClientEvent:Connect(function()
		-- upvalues: (ref) v_u_23, (copy) v_u_32, (ref) v_u_7, (ref) v_u_1, (ref) v_u_21
		if not v_u_23 then
			v_u_32:AdjustWeight(1)
			v_u_32:Play()
			task.wait(0.1)
			v_u_7:PlaySound(v_u_1.Sounds.Events.FatSammy.Eat, v_u_21:GetPivot().Position)
		end
	end))
	v_u_24:Add(v_u_15.OnClientEvent:Connect(function(p33)
		-- upvalues: (ref) v_u_11, (ref) v_u_23, (copy) v_u_28, (copy) v_u_32, (ref) v_u_7, (ref) v_u_1, (ref) v_u_21, (ref) v_u_14, (ref) v_u_9, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31
		local v_u_34 = v_u_11.new()
		v_u_23 = true
		v_u_34:Add(function()
			-- upvalues: (ref) v_u_23
			v_u_23 = false
		end)
		local v35 = task.delay
		local v36 = p33 + 11 - workspace:GetServerTimeNow()
		v_u_34:Add(v35(math.max(v36, 0), function()
			-- upvalues: (copy) v_u_34
			v_u_34:Destroy()
		end))
		v_u_28:Play()
		v_u_32:AdjustWeight(0)
		local v37 = p33 + 5.5 - workspace:GetServerTimeNow()
		if math.max(v37, 0) >= 4.5 then
			v_u_7:PlaySound(v_u_1.Sounds.Events.FatSammy.Charge, v_u_21:GetPivot().Position, false)
		end
		local v38 = task.wait
		local v39 = p33 + 0.5 - workspace:GetServerTimeNow()
		v38((math.max(v39, 0)))
		local v40 = v_u_14.copy(script.Absorb, v_u_21.Taco.CFrame, v_u_21.Taco)
		v_u_34:Add(v40)
		v_u_14.weldPosition(v40, v_u_21.Taco)
		v_u_14.enable(v40)
		local v41 = v_u_14.copy(script.Orb, v_u_21.Taco.CFrame, v_u_21.Taco)
		v_u_34:Add(v41)
		v_u_14.weldPosition(v41, v_u_21.Taco)
		v_u_14.enable(v41)
		local v_u_42 = Instance.new("Model")
		v_u_34:Add(v_u_42)
		v41.Parent = v_u_42
		v_u_42.Parent = v_u_21.Taco
		local v43 = Instance.new("NumberValue")
		v_u_34:Add(v43)
		v43.Value = 0.1
		v_u_42:ScaleTo(0.1)
		v43.Changed:Connect(function(p44)
			-- upvalues: (copy) v_u_42
			v_u_42:ScaleTo(p44)
		end)
		local v45 = v_u_9
		local v46 = TweenInfo.new
		local v47 = p33 + 5 - workspace:GetServerTimeNow()
		local v48 = v45(v43, v46(math.max(v47, 0), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			["Value"] = 1
		})
		local v49 = task.wait
		local v50 = p33 + 5 - workspace:GetServerTimeNow()
		v49((math.max(v50, 0)))
		v48:Cancel()
		v48:Destroy()
		v_u_42:ScaleTo(1)
		v_u_14.disable(v40)
		v_u_29:Play()
		local v51 = task.wait
		local v52 = p33 + 5.5 - workspace:GetServerTimeNow()
		v51((math.max(v52, 0)))
		local v53 = v_u_34:Clone(script.Beam)
		v53.Parent = workspace
		v_u_14.enable(v53)
		local v54 = v53.att0
		local v55 = v53.att0.WorldPosition
		v_u_34:Add(v54)
		v54.Parent = workspace.Terrain
		v54.WorldCFrame = v41.att1.WorldCFrame
		for _, v56 in v53.beams:GetChildren() do
			if v56:IsA("Beam") then
				v56.Attachment1 = v41.att1
			end
		end
		local v57 = v_u_14.copy(script.Burst, v_u_21.Taco.CFrame, workspace)
		v_u_34:Add(v57)
		v_u_14.emit(v57)
		v_u_28:Stop()
		v_u_30:Play()
		v_u_14.disable(v41)
		local v58 = v_u_9
		local v59 = TweenInfo.new
		local v60 = p33 + 6.5 - workspace:GetServerTimeNow()
		v58(v54, v59(math.max(v60, 0), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			["Position"] = v55
		})
		local v61 = p33 + 6.5 - workspace:GetServerTimeNow()
		local v62 = math.max(v61, 0) >= 0.5 and v_u_7:PlaySound(v_u_1.Sounds.Events.FatSammy.Shot, nil, false)
		if v62 then
			v62.Parent = v54
		end
		local v63 = task.wait
		local v64 = p33 + 6.5 - workspace:GetServerTimeNow()
		v63((math.max(v64, 0)))
		v_u_14.disable(v54)
		for _, v65 in v53.beams:GetChildren() do
			if v65:IsA("Beam") then
				local v66 = v_u_9
				local v67 = TweenInfo.new
				local v68 = p33 + 7.7 - workspace:GetServerTimeNow()
				v66(v65, v67(math.max(v68, 0), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					["Width0"] = 0,
					["Width1"] = 0
				})
			end
		end
		local v69 = task.wait
		local v70 = p33 + 7.3 - workspace:GetServerTimeNow()
		v69((math.max(v70, 0)))
		v_u_31:Play()
		task.delay(0.5, function()
			-- upvalues: (ref) v_u_30
			v_u_30:Stop()
		end)
	end))
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_24
	v_u_24:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_21, (copy) v_u_20, (copy) v_u_13, (copy) v_u_3, (copy) v_u_19, (copy) v_u_5, (ref) v_u_23, (copy) v_u_10, (copy) v_u_17
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	local function v74()
		-- upvalues: (ref) v_u_21, (ref) v_u_20, (ref) v_u_13
		local v71 = v_u_21:GetAttribute("ScaleAlpha") or 0
		local v72 = math.lerp(1, 2, v71)
		v_u_21:PivotTo(v_u_20.SammySpawnPosition:GetPivot())
		v_u_13.target(v_u_20.SammyBelly.Upper.Motor, 0.8, 1.5, {
			["C0"] = CFrame.new(0, v72 * -0.454, v72 * 0.445),
			["C1"] = CFrame.new(0, 0, (1 - v71) * 0.445 * v72)
		})
		v_u_13.target(v_u_20.SammyBelly.Bottom.Motor, 0.8, 1.5, {
			["C0"] = CFrame.new(0, v72 * 0.433, v72 * 0.951),
			["C1"] = CFrame.new(0, 0, (1 - v71) * 0.951 * v72)
		})
		v_u_13.target(v_u_21, 0.8, 1.5, {
			["Scale"] = v72
		})
		v_u_13.target(v_u_20.SammyBelly, 0.8, 1.5, {
			["Scale"] = math.lerp(0.45, 0.667, v71) * v72
		})
		for _, v73 in v_u_20.SammyArms:GetChildren() do
			v_u_13.target(v73, 0.8, 1.5, {
				["Scale"] = math.lerp(0.6, 1, v71) * v72
			})
		end
	end
	v_u_21:GetAttributeChangedSignal("ScaleAlpha"):Connect(v74)
	task.spawn(v74)
	local v_u_75 = false
	workspace.Events.FatSammy.Model.DeliveryHitbox.Touched:Connect(function(p76)
		-- upvalues: (ref) v_u_3, (ref) v_u_19, (ref) v_u_5, (ref) v_u_75, (ref) v_u_23, (ref) v_u_10, (ref) v_u_17
		if p76.Name == "HumanoidRootPart" then
			local v77 = v_u_3:GetPlayerFromCharacter(p76.Parent)
			if v77 then
				if v77 == v_u_19 then
					if v_u_5:IsInPrompt() or (v_u_75 or v_u_23) then
						return
					else
						local v78 = v77:GetAttribute("StealingIndex")
						if v78 then
							v_u_75 = true
							task.delay(0.5, function()
								-- upvalues: (ref) v_u_75
								v_u_75 = false
							end)
							local v79 = v_u_10[v78].Rarity
							if v79 ~= "OG" and (v79 ~= "Admin" and (v79 ~= "Spooky" and (v79 ~= "Taco" and (v79 ~= "Secret" and (v79 ~= "Brainrot God" and v79 ~= "Mythic"))))) and v79 ~= "Festive" or v_u_5:Show((("Are you sure you want to give this %* Brainrot to Sammy?"):format(v79))) then
								v_u_17:FireServer()
							end
						else
							return
						end
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	end)
end
return v4
