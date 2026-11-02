--credit to prince games studio
local Assets = game:GetService("ReplicatedStorage").Assets
local SpiralTrail = require(game.ReplicatedStorage.ClientModules.SpiralTrail)

return {
	Play = function(p1, p2) --[[ Play | Line: 9 | Upvalues: Assets (copy), SpiralTrail (copy) ]]
		local v1 = Assets.LevelUp.LevelUpEffect:Clone()
		local v2 = Assets.LevelUp.Highlight:Clone()
		local v3 = Assets.LevelUp.PoofEffect:Clone()

		v1:PivotTo(p2.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = v1
		WeldConstraint.Part1 = p2.HumanoidRootPart
		WeldConstraint.Parent = v1
		v1.Parent = p2
		v3.Parent = p2.HumanoidRootPart
		v2.Parent = p2

		local t = { 510, 470, 268 }

		local function lerp(p1, p2, p3) --[[ lerp | Line: 31 ]]
			return p1 + (p2 - p1) * p3
		end

		task.spawn(function() --[[ Line: 35 | Upvalues: SpiralTrail (ref), v1 (copy) ]]
			SpiralTrail.Init(v1, {
				Size = 0.2,
				Offset = 4,
				Time = 0.4,
				Frequency = 1,
				Radius = 2,
				Color = Color3.fromRGB(255, 243, 115)
			})
		end)

		local v4 = 0

		task.spawn(function() --[[ Line: 48 | Upvalues: v4 (ref), t (copy), v2 (copy) ]]
			while v4 < 1.6 do
				v4 = v4 + game:GetService("RunService").Heartbeat:Wait()

				local v3 = (math.sin((math.rad(tick() * 720))) + 1) / 2

				v2.FillColor = Color3.fromRGB(t[1], t[2], t[3]):Lerp(Color3.fromRGB(255, 235, 134), v3)
				v2.FillTransparency = (math.sin((math.rad(tick() * 360))) + 1) / 2 * 0.3 * (v4 / 1.6 * 0.1) + 0.7
				v2.OutlineTransparency = v3
			end

			game.TweenService:Create(v2, TweenInfo.new(1), {
				FillTransparency = 1,
				OutlineTransparency = 1
			}):Play()
		end)

		for v5, v6 in v3:GetChildren() do
			if v6:IsA("ParticleEmitter") then
				v6:Emit(v6:GetAttribute("EmitCount") or 1)

				if v6.Name ~= "Glow2" then
					v6.Enabled = true
					task.delay(0.9, function() --[[ Line: 75 | Upvalues: v6 (copy) ]]
						v6.Enabled = false
					end)
				end
			end
		end

		for v7, v8 in v1:GetDescendants() do
			if v8:IsA("ParticleEmitter") then
				v8.Enabled = true
				v8:Emit(v8:GetAttribute("EmitCount") or 1)
				task.delay(0.9, function() --[[ Line: 86 | Upvalues: v8 (copy) ]]
					v8.Enabled = false
				end)
			end
		end

		game.Debris:AddItem(v1, 2)
		game.Debris:AddItem(v3, 2)
		game.Debris:AddItem(v2, 2)
	end
}