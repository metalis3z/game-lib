---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v3 = {}
local v_u_4 = require(v_u_1.Controllers.AnimalController)
local v_u_5 = require(v_u_1.Controllers.SoundController)
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Controllers.CycleController)
local v_u_8 = require(v_u_1.Packages.Spring)
local v9 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v10 = require(v_u_1.Packages.Net)
local v_u_11 = require(v_u_1.Shared.VFX)
local v_u_12 = v10:RemoteEvent("EventService/GUIGUI/Shoot")
local v_u_13 = script.Name
local v_u_14 = v9.new()
local _ = workspace.CurrentCamera
function v3.OnStart(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_13, (copy) v_u_1, (copy) v_u_14, (copy) v_u_5, (copy) v_u_7, (copy) v_u_8, (copy) v_u_2, (copy) v_u_12, (copy) v_u_4, (copy) v_u_11
	local v15 = v_u_6:GetActiveEventData(v_u_13)
	assert(v15)
	v_u_1:SetAttribute("GUIGUIEvent", true)
	v_u_14:Add(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_7
		v_u_1:SetAttribute("GUIGUIEvent", nil)
		v_u_5:UpdateOST()
		v_u_7:Update()
	end)
	v_u_5:UpdateOST()
	v_u_7:Update()
	local v_u_16 = v_u_14:Clone(script.Cannon)
	v_u_16.Parent = workspace
	local v_u_17 = script.TacoAmbient:Clone()
	v_u_14:Add(function()
		-- upvalues: (copy) v_u_17
		for _, v18 in v_u_17:GetDescendants() do
			if v18:IsA("ParticleEmitter") then
				v18.Enabled = false
			end
		end
		task.wait(5)
		v_u_17:Destroy()
	end)
	v_u_17.Parent = workspace
	local v_u_19 = v_u_16.Top["Meshes/tacolauncher_Cube.004"]["Meshes/tacolauncher_Cube.003"]
	local v_u_20 = v_u_16.Bottom.RootPart["Meshes/tacolauncher_Cube.004"]
	local v_u_21 = v_u_8.new(0)
	v_u_21.Speed = 6.5
	v_u_21.Damper = 0.85
	local v_u_22 = v_u_8.new(0)
	v_u_22.Speed = 9
	v_u_22.Damper = 0.6
	v_u_14:Add(v_u_2.PostSimulation:Connect(function(_)
		-- upvalues: (copy) v_u_19, (copy) v_u_21, (copy) v_u_20, (copy) v_u_22
		debug.profilebegin("Raining Tacos Cannon Spring")
		v_u_19.C1 = CFrame.new(v_u_21.Position, 0, 0)
		local v23 = v_u_20
		local v24 = CFrame.Angles
		local v25 = v_u_22.Position
		v23.C1 = v24(0, 0, -math.rad(v25))
		debug.profileend()
	end))
	v_u_14:Add(v_u_12.OnClientEvent:Connect(function(p26, p_u_27)
		-- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_1, (copy) v_u_16, (copy) v_u_22, (copy) v_u_21, (ref) v_u_2, (ref) v_u_11
		local v_u_28 = v_u_4:GetAnimals()[p26]
		if v_u_28 then
			local v_u_29 = script.Taco:Clone()
			v_u_29.Parent = workspace
			task.spawn(function()
				-- upvalues: (ref) v_u_5, (ref) v_u_1, (ref) v_u_16
				v_u_5:PlaySound(v_u_1.Sounds.Events["GUIGUI"].Shoot, v_u_16:GetPivot().Position)
			end)
			task.spawn(function()
				-- upvalues: (ref) v_u_22, (ref) v_u_21
				v_u_22:Impulse(650)
				task.wait(0.05)
				v_u_21:Impulse(35)
			end)
			local v_u_30 = v_u_16.ShootPart.CFrame.Position
			local v_u_31 = nil
			v_u_31 = v_u_2.PreRender:Connect(function()
				-- upvalues: (copy) v_u_28, (copy) v_u_30, (copy) p_u_27, (copy) v_u_29, (ref) v_u_31, (ref) v_u_5, (ref) v_u_1, (ref) v_u_11
				debug.profilebegin("GUIGUI")
				local v32 = v_u_28.AnimalModel
				local v33
				if v32.PrimaryPart then
					v33 = v32.PrimaryPart.CFrame
				else
					v33 = v32:GetPivot()
				end
				local v34 = v33.Position
				local v35 = v_u_28.AnimalModel:GetExtentsSize().Y * 0.5
				local v_u_36 = v34 + Vector3.new(0, v35, 0)
				local v37 = v_u_30 + (v_u_36 - v_u_30) * 0.5 + Vector3.new(0, 60, 0)
				local v38 = 1 - (p_u_27 + 2.5 - workspace:GetServerTimeNow()) / 2.5
				local v39 = math.clamp(v38, 0, 1)
				local v40 = v_u_30
				local v41 = (1 - v39) ^ 2 * v40 + (1 - v39) * 2 * v39 * v37 + v39 ^ 2 * v_u_36
				local v42 = math.clamp(v38, 0, 1) + 0.1
				local v43 = v_u_30
				local v44 = (1 - v42) ^ 2 * v43 + (1 - v42) * 2 * v42 * v37 + v42 ^ 2 * v_u_36
				v_u_29.CFrame = CFrame.lookAt(v41, v44)
				if v38 >= 1 then
					v_u_31:Disconnect()
					task.spawn(function()
						-- upvalues: (ref) v_u_5, (ref) v_u_1, (copy) v_u_36
						v_u_5:PlaySound(v_u_1.Sounds.Events["GUIGUI"].Hit, v_u_36)
					end)
					v_u_29:Destroy()
					local v_u_45 = script.StruckVFX:Clone()
					v_u_45:PivotTo(CFrame.new(v_u_36))
					v_u_45.Anchored = false
					local v46 = Instance.new("WeldConstraint")
					v46.Part0 = v_u_45
					v46.Part1 = v_u_28.AnimalModel.PrimaryPart
					v46.Parent = v_u_45
					v_u_45.Parent = workspace
					v_u_11.emit(v_u_45)
					task.delay(3, function()
						-- upvalues: (copy) v_u_45
						v_u_45:Destroy()
					end)
				end
				debug.profileend()
			end)
		end
	end))
end
function v3.OnStop(_)
	-- upvalues: (copy) v_u_14
	v_u_14:Destroy()
end
function v3.OnLoad(_) end
return v3
