---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("TweenService")
game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.AnimalController)
local v_u_7 = require(v_u_1.Controllers.EffectController)
local v_u_8 = require(v_u_1.Controllers.SoundController)
local v_u_9 = require(v_u_1.Controllers.EventController)
local v_u_10 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.Observers)
local v11 = require(v_u_1.Packages.Trove)
local v12 = require(v_u_1.Packages.Net)
local v_u_13 = require(v_u_1.Shared.VFX)
local v_u_14 = script.Name
local v_u_15 = v12:RemoteEvent("EventService/Snow/Hit")
local v_u_16 = v11.new()
function v5.OnStart(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_14, (copy) v_u_1, (copy) v_u_16, (copy) v_u_13, (copy) v_u_4, (copy) v_u_7, (copy) v_u_10, (copy) v_u_8
	local v17 = v_u_9:GetActiveEventData(v_u_14)
	assert(v17)
	v_u_1:SetAttribute("Snow", true)
	v_u_16:Add(function()
		-- upvalues: (ref) v_u_1
		v_u_1:SetAttribute("Snow", nil)
	end)
	local v18 = v17.startedAt + 4 - workspace:GetServerTimeNow()
	local v_u_19 = v_u_16:Clone(script.SnowWeather)
	v_u_13.disable(v_u_19)
	v_u_19.Parent = workspace
	v_u_16:Add(task.delay(v18, function()
		-- upvalues: (ref) v_u_4, (ref) v_u_16, (ref) v_u_13, (copy) v_u_19
		local v_u_20 = v_u_4:FindFirstChild("Atmosphere")
		if v_u_20 then
			v_u_20.Parent = script
			v_u_16:Add(function()
				-- upvalues: (copy) v_u_20, (ref) v_u_4
				v_u_20.Parent = v_u_4
			end)
		end
		v_u_16:Clone(script.AtmosphereSnow).Parent = v_u_4
		local v_u_21 = v_u_4:FindFirstChild("Cartoon")
		if v_u_21 then
			v_u_21.Parent = script
			v_u_16:Add(function()
				-- upvalues: (copy) v_u_21, (ref) v_u_4
				v_u_21.Parent = v_u_4
			end)
		end
		v_u_16:Clone(script.SkySnow).Parent = v_u_4
		v_u_13.enable(v_u_19)
	end))
	v_u_7:Run("Snow", "GrassRecolor")
	v_u_16:Add(function()
		-- upvalues: (ref) v_u_7
		v_u_7:Stop("Snow", "GrassRecolor")
	end)
	v_u_10:Update()
	v_u_8:UpdateOST()
	v_u_8:UpdateAmbience()
end
function v5.OnStop(_)
	-- upvalues: (copy) v_u_16
	v_u_16:Destroy()
end
function v5.OnLoad(_)
	-- upvalues: (copy) v_u_15, (copy) v_u_6, (copy) v_u_8, (copy) v_u_1, (copy) v_u_13, (copy) v_u_3, (copy) v_u_16, (copy) v_u_2
	v_u_15.OnClientEvent:Connect(function(p22)
		-- upvalues: (ref) v_u_6, (ref) v_u_8, (ref) v_u_1, (ref) v_u_13
		local v23
		if type(p22) == "string" then
			local v24 = v_u_6:GetAnimals()[p22]
			if not v24 then
				return
			end
			local v25 = v24.AnimalModel
			local v26
			if v25.PrimaryPart then
				v26 = v25.PrimaryPart.CFrame
			else
				v26 = v25:GetPivot()
			end
			local v27 = v26.Position
			local v28 = v24.AnimalModel:GetExtentsSize().Y * 0.5
			v23 = v27 + Vector3.new(0, v28, 0)
			p22 = v24.AnimalModel.PrimaryPart
		else
			v23 = p22:GetPivot().Position
		end
		v_u_8:PlaySound(v_u_1.Sounds.Events.Snow.Burst, v23)
		local v_u_29 = script.StruckVFX:Clone()
		v_u_29:PivotTo(CFrame.new(v23))
		v_u_29.Anchored = false
		local v30 = Instance.new("WeldConstraint")
		v30.Part0 = v_u_29
		v30.Part1 = p22
		v30.Parent = v_u_29
		v_u_29.Parent = workspace
		v_u_13.emit(v_u_29)
		task.delay(3, function()
			-- upvalues: (copy) v_u_29
			v_u_29:Destroy()
		end)
	end)
	local function v_u_37(p_u_31)
		-- upvalues: (ref) v_u_3
		task.wait(math.random() * 0.8)
		local v_u_32 = p_u_31:GetPivot() * CFrame.new(0, 10, 0)
		local v_u_33 = Instance.new("CFrameValue")
		v_u_33.Value = p_u_31:GetPivot()
		local v_u_35 = v_u_33.Changed:Connect(function(p34)
			-- upvalues: (copy) p_u_31
			p_u_31:PivotTo(p34)
		end)
		local v36 = v_u_3:Create(v_u_33, TweenInfo.new(1.2), {
			["Value"] = v_u_32
		})
		v36:Play()
		v36.Completed:Connect(function()
			-- upvalues: (copy) v_u_35, (copy) v_u_33, (copy) p_u_31, (copy) v_u_32
			v_u_35:Disconnect()
			v_u_33:Destroy()
			p_u_31:PivotTo(v_u_32)
		end)
	end
	v_u_16:Add(v_u_2:GetInstanceAddedSignal("SnowPile"):Connect(function(p38)
		-- upvalues: (copy) v_u_37
		if p38:IsA("Model") then
			task.spawn(v_u_37, p38)
		end
	end))
	for _, v39 in v_u_2:GetTagged("SnowPile") do
		if v39:IsA("Model") then
			task.spawn(v_u_37, v39)
		end
	end
end
return v5
