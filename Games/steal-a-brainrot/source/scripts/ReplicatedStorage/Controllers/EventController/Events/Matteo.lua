---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v3 = {}
local v_u_4 = v_u_1.Models.Events.Matteo
local v_u_5 = require(v_u_1.Packages.Net)
local v6 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v_u_7 = require(v_u_1.Shared.TweenPivot)
local v_u_8 = require(v_u_1.Shared.ShakePresets)
local v_u_9 = require(v_u_1.Packages.Synchronizer)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.EventController)
local v_u_12 = script.Name
local v_u_13 = v6.new()
local _ = workspace.CurrentCamera
function v3.OnStart(_)
	-- upvalues: (copy) v_u_11, (copy) v_u_12, (copy) v_u_1, (copy) v_u_10, (copy) v_u_13, (copy) v_u_8, (copy) v_u_9, (copy) v_u_4, (copy) v_u_7, (copy) v_u_2, (copy) v_u_5
	local v_u_14 = v_u_11:GetActiveEventData(v_u_12)
	assert(v_u_14)
	local v_u_15 = workspace:GetServerTimeNow()
	v_u_1:SetAttribute("MatteoEvent", true)
	v_u_10:UpdateOST()
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_10
		v_u_1:SetAttribute("MatteoEvent", nil)
		v_u_10:UpdateOST()
	end)
	local v_u_16 = false
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_16
		v_u_16 = true
	end)
	local v17 = v_u_14.startedAt + 10 - v_u_15
	v_u_13:Add(task.delay(v17, function()
		-- upvalues: (copy) v_u_14, (copy) v_u_15, (ref) v_u_8, (ref) v_u_13, (ref) v_u_9, (ref) v_u_4, (ref) v_u_16, (ref) v_u_7, (ref) v_u_2, (ref) v_u_5
		local v18 = v_u_14.startedAt + 14 - v_u_15
		if v18 > 0 then
			local v_u_19 = v_u_8.Bump:Clone()
			v_u_13:Add(v_u_19)
			v_u_19.Sustain = true
			v_u_13:Add(v_u_8.BindShakeToCamera(v_u_19, workspace.CurrentCamera))
			v_u_19:Start()
			v_u_13:Add(task.delay(v18, function()
				-- upvalues: (copy) v_u_19
				v_u_19:StopSustain()
			end))
			v_u_13:Add(function()
				-- upvalues: (ref) v_u_8
				local v20 = v_u_8.Bump:Clone()
				v20.Sustain = true
				local v21 = v_u_8.BindShakeToCamera(v20, workspace.CurrentCamera)
				v20:Start()
				task.wait(4)
				v20:StopSustain()
				task.wait(2)
				v20:Destroy()
				v21()
			end)
		end
		local v22 = v_u_9:Wait("MatteoEvent")
		local v23 = v22:Get("IsRainbow")
		local v24 = v_u_14.startedAt + 15 - v_u_15
		local v25
		if v23 then
			v25 = {
				v_u_4.RainbowTrees.Tree1,
				v_u_4.RainbowTrees.Tree2,
				v_u_4.RainbowTrees.Tree3,
				v_u_4.RainbowTrees.Tree4,
				v_u_4.RainbowTrees.Tree5
			}
		else
			v25 = {
				v_u_4.NormalTrees.Tree1,
				v_u_4.NormalTrees.Tree2,
				v_u_4.NormalTrees.Tree3,
				v_u_4.NormalTrees.Tree4,
				v_u_4.NormalTrees.Tree5
			}
		end
		local v_u_26 = script.WindParts:Clone()
		v_u_26.Parent = workspace
		v_u_13:Add(function()
			-- upvalues: (copy) v_u_26
			for _, v27 in v_u_26:GetDescendants() do
				if v27:IsA("ParticleEmitter") then
					v27.Enabled = false
				end
			end
			task.wait(5)
			v_u_26:Destroy()
		end)
		local v_u_28 = {}
		local v_u_29 = {}
		for v_u_30, v31 in v22:Get("TreePositions") do
			local v32 = Random.new(v31.X * 100 // 1 + v31.Z * 100 // 1)
			local v33 = v32:NextInteger(1, #v25)
			local v34 = v32:NextNumber(0, 6.283185307179586)
			local v_u_35 = v_u_13:Extend()
			v_u_28[v_u_30] = v_u_35
			local v_u_36 = v25[v33]:Clone()
			local v37 = v_u_36:GetExtentsSize()
			local v_u_38 = CFrame.new(v31) * CFrame.new(0, -v37.Y * 0.5, 0) * CFrame.Angles(0, v34, 0)
			local v39 = CFrame.new(v31) * CFrame.new(0, v37.Y * 0.485, 0) * CFrame.Angles(0, v34, 0)
			local v_u_40 = v_u_35:Clone(v_u_4.SpawnVFX)
			v_u_40.CFrame = CFrame.new(v31) * CFrame.Angles(0, v34, 0)
			v_u_40.Parent = workspace
			v_u_35:Add(function()
				-- upvalues: (ref) v_u_16, (ref) v_u_7, (copy) v_u_36, (copy) v_u_38
				task.wait()
				if v_u_16 then
					local v41 = v_u_7(v_u_36, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), v_u_38 * CFrame.new(0, -1, 0))
					v41:Play()
					v41.Completed:Wait()
					v_u_36:Destroy()
				else
					v_u_36:Destroy()
				end
			end)
			if v24 <= 1 then
				v_u_36:PivotTo(v39)
				v_u_40:Destroy()
			else
				v_u_36:PivotTo(v_u_38)
				v_u_35:Add(v_u_7(v_u_36, TweenInfo.new(v24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v39)):Play()
				v_u_35:Add(task.delay(v24 - 1, function()
					-- upvalues: (copy) v_u_40, (copy) v_u_35
					v_u_40.ParticleEmitter.Enabled = false
					task.wait(1)
					v_u_35:Remove(v_u_40)
				end))
			end
			if v23 then
				for _, v42 in v_u_36:GetChildren() do
					if v42.Name ~= "Handle" then
						v42:AddTag("RainbowModel")
					end
				end
			end
			v_u_36.Parent = workspace
			local v43 = v_u_2.LocalPlayer.Character
			if (v33 == 1 or (v33 == 2 or v33 == 3)) and not (v43 and v43:GetAttribute("Matteo_CollectedTree")) then
				local v_u_44 = v_u_35:Clone(v_u_4.ProximityPart)
				table.insert(v_u_29, v_u_44)
				v_u_44.ProximityPrompt.Enabled = false
				v_u_35:Add(task.delay(v24 - 1, function()
					-- upvalues: (copy) v_u_44
					v_u_44.ProximityPrompt.Enabled = true
				end))
				v_u_44:PivotTo(CFrame.new(v31) * CFrame.new(0, 3, 0))
				v_u_44.Parent = workspace
				v_u_35:Add(v_u_44.ProximityPrompt.Triggered:Connect(function()
					-- upvalues: (ref) v_u_5, (copy) v_u_30, (copy) v_u_29
					if v_u_5:Invoke("EventService/Matteo/CollectTree", v_u_30) then
						for _, v45 in v_u_29 do
							v45:Destroy()
						end
						table.clear(v_u_29)
					end
				end))
			end
		end
		v22:OnDictionaryRemoved("TreePositions", function(_, p46)
			-- upvalues: (copy) v_u_28
			local v47 = v_u_28[p46]
			if v47 then
				v47:Destroy()
				v_u_28[p46] = nil
			end
		end)
	end))
end
function v3.OnStop(_)
	-- upvalues: (copy) v_u_13
	v_u_13:Destroy()
end
function v3.OnLoad(_) end
return v3
