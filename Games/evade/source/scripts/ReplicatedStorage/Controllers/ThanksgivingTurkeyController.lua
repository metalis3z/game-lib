-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.AnimalController)
local v_u_3 = require(v1.Packages.FFlags)
local v4 = require(v1.Packages.Trove)
local v_u_5 = require(v1.Packages.Spr)
local v6 = require(v1.Packages.Net)
local v7 = {}
local v_u_8 = v6:RemoteEvent("ThanksgivingTurkeyService/UpdateAnimation")
local v_u_9 = v6:RemoteEvent("ThanksgivingTurkeyService/UpdateHealthBar")
local v_u_10 = v6:RemoteEvent("ThanksgivingTurkeyService/PlayAnimation")
local v_u_11 = v6:RemoteEvent("ThanksgivingTurkeyService/Despawn")
local v_u_12 = v6:RemoteEvent("ThanksgivingTurkeyService/Spawn")
local v_u_13 = v4.new()
local v_u_14 = 10
local v_u_15 = v_u_14
local v_u_16 = nil
function v7.Start(_)
	-- upvalues: (ref) v_u_16, (ref) v_u_15, (ref) v_u_14, (copy) v_u_5, (copy) v_u_2, (copy) v_u_12, (copy) v_u_13, (copy) v_u_3, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10, (copy) v_u_8
	local function v_u_18()
		-- upvalues: (ref) v_u_16, (ref) v_u_15, (ref) v_u_14, (ref) v_u_5
		if v_u_16 then
			v_u_16.Progress.Label.Text = ("%*/%*"):format(v_u_15, v_u_14)
			v_u_16.Enabled = v_u_15 > 0
			local v17 = v_u_15 / v_u_14
			v_u_5.target(v_u_16.Progress.Fill, 1, 5, {
				["Size"] = UDim2.fromScale(v17, 1)
			})
		end
	end
	v_u_12.OnClientEvent:Connect(function(p19)
		-- upvalues: (ref) v_u_13, (ref) v_u_14, (ref) v_u_3, (ref) v_u_2, (ref) v_u_16, (copy) v_u_18, (ref) v_u_15
		v_u_13:Clean()
		v_u_13:Clone(script.VFX).Parent = workspace
		v_u_14 = v_u_3:GetInstant("ThanksgivingTurkeyService/Health", 10)
		local v20 = 5
		while not v_u_2:GetAnimals()[p19] and v20 > 0 do
			v20 = v20 - task.wait()
		end
		local v21 = v_u_2:GetAnimals()[p19]
		if v21 then
			v_u_16 = v_u_13:Clone(script.HealthBar)
			local v22 = v_u_16
			assert(v22)
			v_u_16.Parent = v21.AnimalModel:FindFirstChild("OVERHEAD_ATTACHMENT", true) or v21.AnimalModel.PrimaryPart
			v_u_18()
			local v23 = v_u_2:GetAnimals()[p19]
			if v23 then
				local v24 = v23.AnimalModel:FindFirstChild("AnimalOverhead", true)
				if v24 and v24:IsA("BillboardGui") then
					v24.Enabled = v_u_15 <= 0 and true or v_u_16 == nil
				end
			end
			v_u_13:Add(function()
				-- upvalues: (ref) v_u_16
				v_u_16 = nil
			end)
		end
	end)
	v_u_11.OnClientEvent:Connect(function(p25)
		-- upvalues: (ref) v_u_13, (ref) v_u_2, (ref) v_u_15, (ref) v_u_16
		v_u_13:Clean()
		local v26 = v_u_2:GetAnimals()[p25]
		if v26 then
			local v27 = v26.AnimalModel:FindFirstChild("AnimalOverhead", true)
			if v27 and v27:IsA("BillboardGui") then
				v27.Enabled = v_u_15 <= 0 and true or v_u_16 == nil
			end
		end
		v_u_15 = 10
	end)
	v_u_9.OnClientEvent:Connect(function(p28, p29)
		-- upvalues: (ref) v_u_15, (copy) v_u_18, (ref) v_u_2, (ref) v_u_16
		v_u_15 = p29
		v_u_18()
		local v30 = v_u_2:GetAnimals()[p28]
		if v30 then
			local v31 = v30.AnimalModel:FindFirstChild("AnimalOverhead", true)
			if v31 and v31:IsA("BillboardGui") then
				v31.Enabled = v_u_15 <= 0 and true or v_u_16 == nil
			end
		end
	end)
	v_u_10.OnClientEvent:Connect(function(p32, p33)
		-- upvalues: (ref) v_u_2
		local v34 = v_u_2:GetAnimals()[p32]
		if v34 then
			local v35 = v34.AnimalModel.AnimationController
			local v36 = v35.Animator or Instance.new("Animator", v35)
			if p33 then
				p33 = script.Animations:FindFirstChild(p33)
			end
			if p33 then
				local v_u_37 = v36:LoadAnimation(p33)
				v_u_37.Looped = false
				v_u_37:Play()
				v_u_37:AdjustSpeed(p33:GetAttribute("Speed") or 1)
				v34.Collector:Add(function()
					-- upvalues: (copy) v_u_37
					if v_u_37 then
						v_u_37:Stop(0)
						v_u_37:Destroy()
					end
				end)
			end
		end
	end)
	v_u_8.OnClientEvent:Connect(function(p38, p39)
		-- upvalues: (ref) v_u_2
		local v_u_40 = v_u_2:GetAnimals()[p38]
		if v_u_40 then
			local v41 = v_u_40.AnimalModel.AnimationController
			local v42 = v41.Animator or Instance.new("Animator", v41)
			if p39 then
				p39 = script.Animations:FindFirstChild(p39)
			end
			if p39 then
				local v43 = v42:LoadAnimation(p39)
				v43:Play()
				v43:AdjustSpeed(p39:GetAttribute("Speed") or 1)
				if v_u_40.TurkeyTrack then
					v_u_40.TurkeyTrack:Stop(0)
					v_u_40.TurkeyTrack:Destroy()
				end
				v_u_40.TurkeyTrack = v43
				v_u_40.Collector:Add(function()
					-- upvalues: (copy) v_u_40
					if v_u_40.TurkeyTrack then
						v_u_40.TurkeyTrack:Stop(0)
						v_u_40.TurkeyTrack:Destroy()
					end
				end)
			elseif v_u_40.TurkeyTrack then
				v_u_40.TurkeyTrack:Stop(0)
				v_u_40.TurkeyTrack:Destroy()
			end
		else
			return
		end
	end)
end
return v7