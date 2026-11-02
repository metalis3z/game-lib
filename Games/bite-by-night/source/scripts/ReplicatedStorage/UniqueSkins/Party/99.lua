-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v2 = game:GetService("ServerStorage")
local v3 = game:GetService("ReplicatedStorage")
game:GetService("Players")
local v_u_4 = require(v2.Modules.Abilities.Ability)
require(v2.Modules.Types)
require(v3.Modules.Warp)
local v_u_5 = require(v3.Modules.Maid)
require(game:GetService("ServerStorage").Modules.General.Fighter)
require(v2.Modules["Hitbox Settings"])
require(v2.Modules.General.PlayerData)
local v_u_6 = require(v3.Modules.BezierProjectileUtil)
local v_u_7 = require(v3.Modules.VFXHandler)
function v1.new()
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_7, (copy) v_u_6
	local v_u_8 = v_u_4.new("Party", "HitPassive", script.Name)
	v_u_8.Icon = "rbxassetid://0"
	v_u_8.Keybind = ""
	function v_u_8.OnSpawn(p_u_9)
		-- upvalues: (copy) v_u_8, (ref) v_u_5, (ref) v_u_7, (ref) v_u_6
		v_u_8.Cooldown = 0
		v_u_8:ResetCooldown(p_u_9)
		require(script.LoadHat).Load(p_u_9)
		local v_u_10 = v_u_5.new()
		v_u_10:Mark(p_u_9.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			-- upvalues: (copy) p_u_9, (ref) v_u_7, (ref) v_u_6, (copy) v_u_10
			if p_u_9.Humanoid.Health <= 0 then
				local v13 = {
					["root"] = p_u_9.RootPart.CFrame,
					["projectile"] = script:WaitForChild("Trail"),
					["onHit"] = function(p11, _)
						-- upvalues: (ref) v_u_7
						local v12 = script:WaitForChild("Explosion"):Clone()
						v12.Parent = workspace.IGNORE
						v12.CFrame = CFrame.new(p11)
						task.wait(0.01)
						v12.Firework.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
						v12.Firework:Play()
						task.delay(1, v12.Destroy, v12)
						v_u_7.doEmitCount(v12)
					end,
					["count"] = 1,
					["spreadRadius"] = 10,
					["YOffset"] = 10,
					["startHeight"] = 0,
					["duration"] = 0.4,
					["arcHeight"] = 0,
					["evenlySpaced"] = false,
					["rotate"] = true,
					["spawnDelay"] = 0,
					["lifetime"] = 1
				}
				for _ = 1, 25 do
					v13.duration = Random.new():NextNumber(0.1, 0.5)
					v13.lifetime = 1
					v_u_6.SpawnProjectiles(v13)
				end
				for _, v14 in p_u_9.Character:GetDescendants() do
					if v14:IsA("BasePart") then
						v14.Transparency = 1
						v14.Anchored = true
					end
				end
				local v_u_15 = script.Confetti:Clone()
				v_u_15.CFrame = p_u_9.RootPart.CFrame
				v_u_15.Parent = workspace.IGNORE
				task.delay(0.1, function()
					-- upvalues: (copy) v_u_15
					for _, v16 in v_u_15:GetDescendants() do
						if v16:IsA("Sound") then
							v16:Play()
						elseif v16:IsA("ParticleEmitter") then
							v16:Emit(10)
						end
					end
				end)
				task.delay(10, v_u_15.Destroy, v_u_15)
				v_u_10:Sweep()
				v_u_10:Destroy()
			end
		end))
		v_u_10:Mark(p_u_9.Character:GetPropertyChangedSignal("Parent"):Connect(function()
			-- upvalues: (copy) p_u_9, (copy) v_u_10
			if p_u_9.Character.Parent == nil then
				v_u_10:Sweep()
				v_u_10:Destroy()
			end
		end))
	end
	function v_u_8.AbilityFunc(p17, p18)
		-- upvalues: (ref) v_u_7, (ref) v_u_6
		local v21 = {
			["root"] = p17.RootPart.CFrame,
			["projectile"] = script:WaitForChild("Trail"),
			["onHit"] = function(p19, _)
				-- upvalues: (ref) v_u_7
				local v20 = script:WaitForChild("Explosion"):Clone()
				v20.Parent = workspace.IGNORE
				v20.CFrame = CFrame.new(p19)
				task.wait(0.01)
				v20.Firework.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
				v20.Firework:Play()
				task.delay(2, v20.Destroy, v20)
				v_u_7.doEmitCount(v20)
			end,
			["count"] = 1,
			["spreadRadius"] = 10,
			["YOffset"] = 10,
			["startHeight"] = 0,
			["duration"] = 0.4,
			["arcHeight"] = 0,
			["evenlySpaced"] = false,
			["rotate"] = true,
			["spawnDelay"] = 0,
			["lifetime"] = 2
		}
		for _ = 1, 25 do
			v21.duration = Random.new():NextNumber(0.1, 0.5)
			v_u_6.SpawnProjectiles(v21)
		end
		local v_u_22 = script.Confetti:Clone()
		if p18 then
			v_u_22.CFrame = p18.RootPart.CFrame
		end
		v_u_22.Parent = workspace.IGNORE
		task.delay(0.1, function()
			-- upvalues: (copy) v_u_22
			for _, v23 in v_u_22:GetDescendants() do
				if v23:IsA("Sound") then
					v23:Play()
				elseif v23:IsA("ParticleEmitter") then
					v23:Emit(10)
				end
			end
		end)
		task.delay(10, v_u_22.Destroy, v_u_22)
	end
	return v_u_8
end
return v1