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
local v_u_12 = require(v_u_1.Shared.MapInformation)

-- Remplace l'ancien RemoteEvent Taco par Burger
local v_u_13 = v10:RemoteEvent("EventService/RainingTacos/Shoot")
local v_u_14 = script.Name
local v_u_15 = v9.new()
local _ = workspace.CurrentCamera

function v3.OnStart(_)
	local v16 = v_u_6:GetActiveEventData(v_u_14)
	assert(v16)

	-- Attribut ReplicatedStorage pour signaler l'event actif
	v_u_1:SetAttribute("RainingBurgersEvent", true)
	v_u_15:Add(function()
		v_u_1:SetAttribute("RainingBurgersEvent", nil)
		v_u_5:UpdateOST()
		v_u_7:Update()
	end)
	v_u_5:UpdateOST()
	v_u_7:Update()

	-- Clone du canon (renomme ton modele en "Cannon" ou adapte ici)
	local v_u_17 = v_u_15:Clone(script.Cannon)
	v_u_17.Parent = workspace

	-- Ambiance burger (remplace TacoAmbient par BurgerAmbient dans le script)
	local v_u_18 = script.BurgerAmbient:Clone()
	v_u_15:Add(function()
		for _, v19 in v_u_18:GetDescendants() do
			if v19:IsA("ParticleEmitter") then
				v19.Enabled = false
			end
		end
		task.wait(5)
		v_u_18:Destroy()
	end)
	v_u_18:PivotTo(v_u_12.MapCenter.CFrame + Vector3.new(0, 40, 0))
	v_u_18.Parent = workspace

	-- Springs pour l'animation du canon
	local v_u_20 = v_u_17.Top["Meshes/tacolauncher_Cube.004"]["Meshes/tacolauncher_Cube.003"]
	local v_u_21 = v_u_17.Bottom.RootPart["Meshes/tacolauncher_Cube.004"]
	local v_u_22 = v_u_8.new(0)
	v_u_22.Speed = 6.5
	v_u_22.Damper = 0.85
	local v_u_23 = v_u_8.new(0)
	v_u_23.Speed = 9
	v_u_23.Damper = 0.6

	v_u_15:Add(v_u_2.PostSimulation:Connect(function(_)
		debug.profilebegin("Raining Burgers Cannon Spring")
		v_u_20.C1 = CFrame.new(v_u_22.Position, 0, 0)
		local v24 = v_u_21
		local v25 = CFrame.Angles
		local v26 = v_u_23.Position
		v24.C1 = v25(0, 0, -math.rad(v26))
		debug.profileend()
	end))

	v_u_15:Add(v_u_13.OnClientEvent:Connect(function(p27, p_u_28)
		local v_u_29 = v_u_4:GetAnimals()[p27]
		if v_u_29 then
			-- Projectile burger (Part avec Decal burger)
			local v_u_30 = script.Burger:Clone()
			v_u_30.Parent = workspace

			task.spawn(function()
				-- Son de tir (remplace par un son burger si tu en as un)
				v_u_5:PlaySound(v_u_1.Sounds.Events["Raining Burgers"].Shoot, v_u_17:GetPivot().Position)
			end)
			task.spawn(function()
				v_u_23:Impulse(650)
				task.wait(0.05)
				v_u_22:Impulse(35)
			end)

			local v_u_31 = v_u_17.ShootPart.CFrame.Position
			local v_u_32 = nil

			-- Courbe de Bézier quadratique identique à l'original
			v_u_32 = v_u_2.PreRender:Connect(function()
				debug.profilebegin("Raining Burgers")
				local v33 = v_u_29.AnimalModel
				local v34
				if v33.PrimaryPart then
					v34 = v33.PrimaryPart.CFrame
				else
					v34 = v33:GetPivot()
				end
				local v35 = v34.Position
				local v36 = v_u_29.AnimalModel:GetExtentsSize().Y * 0.5
				local v_u_37 = v35 + Vector3.new(0, v36, 0)
				local v38 = v_u_31 + (v_u_37 - v_u_31) * 0.5 + Vector3.new(0, 60, 0)
				local v39 = 1 - (p_u_28 + 2.5 - workspace:GetServerTimeNow()) / 2.5
				local v40 = math.clamp(v39, 0, 1)
				local v41 = v_u_31
				local v42 = (1 - v40) ^ 2 * v41 + (1 - v40) * 2 * v40 * v38 + v40 ^ 2 * v_u_37
				local v43 = math.clamp(v39, 0, 1) + 0.1
				local v44 = v_u_31
				local v45 = (1 - v43) ^ 2 * v44 + (1 - v43) * 2 * v43 * v38 + v43 ^ 2 * v_u_37
				v_u_30.CFrame = CFrame.lookAt(v42, v45)

				if v39 >= 1 then
					v_u_32:Disconnect()
					task.spawn(function()
						-- Son d'impact
						v_u_5:PlaySound(v_u_1.Sounds.Events["Raining Burgers"].Hit, v_u_37)
					end)
					v_u_30:Destroy()

					-- VFX d'impact : ParticleEmitter avec l'image burger rbxassetid://77322633360169
					local v_u_46 = script.StruckVFX:Clone()
					v_u_46:PivotTo(CFrame.new(v_u_37))
					v_u_46.Anchored = false


					local v47 = Instance.new("WeldConstraint")
					v47.Part0 = v_u_46
					v47.Part1 = v_u_29.AnimalModel.PrimaryPart
					v47.Parent = v_u_46
					v_u_46.Parent = workspace
					v_u_11.emit(v_u_46)

					task.delay(3, function()
						v_u_46:Destroy()
					end)
				end
				debug.profileend()
			end)
		end
	end))
end

function v3.OnStop(_)
	v_u_15:Destroy()
end

function v3.OnLoad(_) end

return v3