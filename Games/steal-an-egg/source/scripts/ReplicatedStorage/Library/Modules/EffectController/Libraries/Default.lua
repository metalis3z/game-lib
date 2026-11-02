-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Utility = require(script.Parent.Parent.Utility.Utility)
local BoatTween = require(script.Parent.BoatTween)

return {
	CreateEffect = function(p1, p2) --[[ CreateEffect | Line: 10 | Upvalues: Utility (copy) ]]
		local v1 = p2.Object:Clone()

		v1.Parent = p2.Parent or workspace.__DEBRIS

		if p2.Position then
			v1:PivotTo(typeof(p2.Position) == "Vector3" and CFrame.new(p2.Position) or p2.Position)
		end

		if p2.Emit then
			task.delay(p2.EmitDelay, p1.Emit, p1, v1, 1)
		end

		if p2.Attach and (v1 and (p2.Parent and (p2.Parent:IsA("Part") or p2.Parent:IsA("BasePart")))) then
			if v1:IsA("Model") then
				p1:Attach(v1.PrimaryPart, p2.Parent)
			else
				p1:Attach(v1, p2.Parent)
			end
		end

		if p2.DebrisTime then
			Utility:AddItem(v1, p2.DebrisTime)
		end

		if p2.RaycastColored then
			local v4 = workspace:Raycast(p2.RaycastColored.Origin, p2.RaycastColored.Direction, Utility.RayParams)

			if not v4 then
				return
			end

			for v5, v6 in v1:GetDescendants() do
				if v6:IsA("ParticleEmitter") and v6:GetAttribute("Raycast") then
					v6.Color = ColorSequence.new(v4.Instance.Color, v4.Instance.Color)
				end
			end
		end

		return v1
	end,
	Emit = function(p1, p2, p3, p4) --[[ Emit | Line: 51 | Upvalues: TweenService (copy), RunService (copy) ]]
		for v1, v2 in p2:GetDescendants() do
			if not (p4 and p4[v2.Name]) then
				if v2:IsA("ParticleEmitter") then
					local v3 = v2:GetAttribute("EmitDuration") or 0

					if v3 < 0.05 then
						task.delay(v2:GetAttribute("EmitDelay"), function() --[[ Line: 57 | Upvalues: v2 (copy) ]]
							v2:Emit(v2:GetAttribute("EmitCount"))
						end)

						continue
					end

					local v4 = os.clock() + v3

					task.spawn(function() --[[ Line: 62 | Upvalues: v2 (copy), v4 (copy) ]]
						repeat
							v2:Emit(v2:GetAttribute("EmitCount"))
							task.wait(0.1)
						until v4 - os.clock() <= 0
					end)

					continue
				end

				if v2:IsA("PointLight") or (v2:IsA("SpotLight") or v2:IsA("SurfaceLight")) then
					TweenService:Create(v2, TweenInfo.new(p3 or 1), {
						Brightness = 0
					}):Play()

					continue
				end

				if v2:IsA("Decal") then
					TweenService:Create(v2, TweenInfo.new(p3 or 1), {
						Transparency = 1
					}):Play()

					continue
				end

				if v2:IsA("Beam") then
					local function UpdateTransparency(p1) --[[ UpdateTransparency | Line: 78 | Upvalues: v2 (copy) ]]
						v2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, p1), NumberSequenceKeypoint.new(1, p1) })
					end

					task.spawn(function() --[[ Line: 84 | Upvalues: v2 (copy), p3 (copy), TweenService (ref), UpdateTransparency (copy), RunService (ref) ]]
						local v1 = os.clock()
						local v22 = v2.Transparency.Keypoints[2].Value

						repeat
							UpdateTransparency((TweenService:GetValue(math.clamp((os.clock() - v1) / p3, v22, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)))
							RunService.Heartbeat:Wait()
						until p3 < os.clock() - v1

						UpdateTransparency(1)
					end)
				end
			end
		end
	end,
	Attach = function(p1, p2, p3, p4) --[[ Attach | Line: 100 | Upvalues: Utility (copy) ]]
		local WeldConstraint = Instance.new("WeldConstraint")

		p2.Massless = true
		p2.CanCollide = false
		WeldConstraint.Part0 = p3
		WeldConstraint.Part1 = p2
		WeldConstraint.Parent = p2

		if not p4 then
			return
		end

		Utility:AddItem(WeldConstraint, p4)
	end,
	PlaySound = function(p1, p2, p3) --[[ PlaySound | Line: 112 | Upvalues: Utility (copy) ]]
		local v1 = p2:Clone()

		v1.Parent = p3
		v1:Play()

		if not p2.Looped then
			local v3, v4

			if p2.TimeLength > 0.1 then
				v3 = p2.TimeLength

				if v3 then
					v4 = v1
				else
					v4 = v1
					v3 = 1
				end
			else
				v4 = v1
				v3 = 1
			end

			Utility:AddItem(v4, v3)
		end

		return v1
	end,
	SetScale = function(p1, p2, p3, p4) --[[ SetScale | Line: 121 ]]
		for v1, v2 in p2:GetDescendants() do
			if v2:IsA("ParticleEmitter") then
				if not (table.find(p4, v2) or table.find(p4, v2.Name)) then
					local t = {}

					for i, v in ipairs(v2.Size.Keypoints) do
						table.insert(t, NumberSequenceKeypoint.new(v.Time, v.Value * p3, v.Envelope * p3))
					end

					local v6 = NumberSequence.new(t)
					local v7 = NumberRange.new(v2.Speed.Min * p3, v2.Speed.Max * p3)
					local v8 = v2.Acceleration * p3

					v2.Size = v6
					v2.Speed = v7
					v2.Acceleration = v8
				end

				continue
			end

			if v2:IsA("Attachment") then
				v2.Position = v2.Position * p3

				continue
			end

			if v2:IsA("Beam") then
				v2.CurveSize0 = v2.CurveSize0 * p3
				v2.CurveSize1 = v2.CurveSize1 * p3
				v2.Width0 = v2.Width0 * p3
				v2.Width1 = v2.Width1 * p3
			end
		end

		p2:SetAttribute("Scale", p3)
	end,
	ScaleTo = function(p1, p2, p3, p4, p5) --[[ ScaleTo | Line: 151 | Upvalues: TweenService (copy), RunService (copy) ]]
		local v2 = p5 or {}

		if v2 then
			task.spawn(function() --[[ Line: 156 | Upvalues: p2 (copy), p4 (copy), TweenService (ref), p3 (copy), p1 (copy), v2 (ref), RunService (ref) ]]
				local v1 = os.clock()
				local v22 = p2:GetAttribute("Scale") or 1

				repeat
					p1:SetScale(p2, v22 + (p3 - v22) * TweenService:GetValue(math.clamp((os.clock() - v1) / p4, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v2)
					RunService.Heartbeat:Wait()
				until p4 < os.clock() - v1 or not p2

				if p2 then
					p1:SetScale(p2, p3, v2)
				end
			end)
		end
	end,
	AdjustSpeed = function(p1) --[[ AdjustSpeed | Line: 176 ]] end,
	Recolor = function(p1) --[[ Recolor | Line: 178 ]] end,
	CreateLighting = function(p1, p2, p3, p4) --[[ CreateLighting | Line: 180 | Upvalues: Lighting (copy), Utility (copy) ]]
		local v1 = Instance.new(p2)

		v1.Parent = Lighting

		for v2, v3 in p3 do
			if v1[v2] then
				v1[v2] = v3
			end
		end

		if p4 then
			Utility:AddItem(v1, p4)
		end

		return v1
	end,
	UpdateStatus = function(p1, p2, p3, p4) --[[ UpdateStatus | Line: 194 | Upvalues: BoatTween (copy), TweenService (copy) ]]
		for v2, v3 in typeof(p2) == "Instance" and p2:GetDescendants() or p2 do
			if not (p4 and p4[v3.Name]) then
				task.spawn(function() --[[ Line: 198 | Upvalues: v3 (copy), p3 (copy), BoatTween (ref), TweenService (ref) ]]
					if v3:IsA("ParticleEmitter") then
						v3.Enabled = p3

						return
					end

					if v3:IsA("Beam") or v3:IsA("Trail") then
						if p3 then
							v3.Enabled = true

							return
						end

						local t = {
							Time = 1,
							EasingStyle = "EntranceExpressive",
							EasingDirection = "Out",
							StepType = "RenderStepped"
						}

						t.Goal = v3:IsA("Beam") and {
							TextureSpeed = 0,
							Transparency = NumberSequence.new(1, 1)
						} or {
							Transparency = NumberSequence.new(1, 1)
						}

						local v4 = BoatTween:Create(v3, t)

						v4:Play()
						v4.Completed:Connect(function() --[[ Line: 220 | Upvalues: v4 (copy) ]]
							v4:Destroy()
						end)
					else
						if not (v3:IsA("PointLight") or v3:IsA("SpotLight")) then
							return
						end

						if p3 then
							v3.Enabled = false

							return
						end

						TweenService:Create(v3, TweenInfo.new(1), {
							Brightness = 0
						}):Play()
					end
				end)
			end
		end
	end
}