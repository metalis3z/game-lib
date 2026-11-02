

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local u3 = require(v2:WaitForChild("Config"))
local u4 = require(v2:WaitForChild("EventsConfig"))
local function u33(p5, p6) 

	for _, v7 in ipairs(p5:GetDescendants()) do
		if v7:IsA("Trail") or (v7:IsA("ParticleEmitter") or (v7.Name:find("TrailAtt") or v7.Name:find("TrailFX"))) then
			v7:Destroy()
		end
	end
	local v8 = u3.TRAILS[p6]
	if not v8 then
		for _, v9 in ipairs(u4.Trails or {}) do
			if v9.Key == p6 then
				v8 = v9
				break
			end
		end
	end
	if p6 == "None" or not v8 then
		return
	else
		local v10 = p5:WaitForChild("HumanoidRootPart", 5)
		local v11 = p5:WaitForChild("Humanoid", 5)
		if v10 and v11 then
			local v12 = Instance.new("Attachment", v10)
			v12.Name = "TrailAtt0"
			v12.Position = Vector3.new(0, 1.5, 0)
			local v13 = Instance.new("Attachment", v10)
			v13.Name = "TrailAtt1"
			v13.Position = Vector3.new(0, -1.5, 0)
			local v14 = Instance.new("Trail")
			v14.Attachment0 = v12
			v14.Attachment1 = v13
			v14.Lifetime = 0.5
			v14.FaceCamera = true
			v14.Transparency = NumberSequence.new(0)
			v14.WidthScale = NumberSequence.new(1, 0)
			v14.LightInfluence = 0
			v14.LightEmission = 0.3
			v14.Color = v8.Color
			v14.Parent = p5
			if p6 == "EasterTrail" then
				v14.Texture = "rbxassetid://102982173039667"
				v14.TextureMode = Enum.TextureMode.Wrap
				v14.TextureLength = 3
				v14.Lifetime = 0.6
				v14.LightEmission = 0.1
				local v15 = Instance.new("Attachment", v10)
				v15.Name = "TrailFX_DropAtt"
				v15.Position = Vector3.new(0, -1, 0)
				local u16 = Instance.new("ParticleEmitter")
				u16.Name = "TrailFX_Drops"
				u16.Texture = "rbxassetid://102982173039667"
				u16.Rate = 120
				u16.Lifetime = NumberRange.new(0.5, 1.2)
				u16.Speed = NumberRange.new(2, 6)
				u16.SpreadAngle = Vector2.new(55, 55)
				u16.Rotation = NumberRange.new(0, 360)
				u16.RotSpeed = NumberRange.new(-200, 200)
				u16.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 130, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 50, 10)) })
				u16.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.6, 0.35), NumberSequenceKeypoint.new(1, 0) })
				u16.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.1), NumberSequenceKeypoint.new(1, 1) })
				u16.LightEmission = 0
				u16.Acceleration = Vector3.new(0, -20, 0)
				u16.LockedToPart = false
				u16.Enabled = false
				u16.Parent = v15
				local v17 = Instance.new("Attachment", v10)
				v17.Name = "TrailFX_SplashAtt"
				v17.Position = Vector3.new(0, -1.5, 0)
				local u18 = Instance.new("ParticleEmitter")
				u18.Name = "TrailFX_Splash"
				u18.Texture = "rbxassetid://102982173039667"
				u18.Rate = 25
				u18.Lifetime = NumberRange.new(0.6, 1)
				u18.Speed = NumberRange.new(4, 9)
				u18.SpreadAngle = Vector2.new(70, 70)
				u18.Rotation = NumberRange.new(0, 360)
				u18.RotSpeed = NumberRange.new(-90, 90)
				u18.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(230, 160, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 70, 20)) })
				u18.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.1), NumberSequenceKeypoint.new(0.5, 0.7), NumberSequenceKeypoint.new(1, 0) })
				u18.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(0.8, 0.4), NumberSequenceKeypoint.new(1, 1) })
				u18.LightEmission = 0
				u18.Acceleration = Vector3.new(0, -25, 0)
				u18.LockedToPart = false
				u18.Enabled = false
				u18.Parent = v17
				v11.Running:Connect(function(p19)

					local v20 = p19 > 1
					if u16 and u16.Parent then
						u16.Enabled = v20
					end
					if u18 and u18.Parent then
						u18.Enabled = v20
					end
				end)
				return
			elseif p6 == "EasterGoldenTrail" then
				v14.Texture = "rbxassetid://71019043397814"
				v14.TextureMode = Enum.TextureMode.Wrap
				v14.TextureLength = 2
				v14.Transparency = NumberSequence.new(0)
				v14.Lifetime = 0.9
				v14.LightEmission = 0.1
				v14.WidthScale = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1.5),
					NumberSequenceKeypoint.new(0.3, 1.1),
					NumberSequenceKeypoint.new(0.7, 0.5),
					NumberSequenceKeypoint.new(1, 0)
				})
				local v21 = Instance.new("Trail")
				v21.Name = "TrailFX_Overlay"
				v21.Attachment0 = v12
				v21.Attachment1 = v13
				v21.Lifetime = 0.5
				v21.Texture = "rbxassetid://12251459424"
				v21.TextureMode = Enum.TextureMode.Stretch
				v21.Color = ColorSequence.new(Color3.fromRGB(255, 140, 0))
				v21.FaceCamera = true
				v21.Transparency = NumberSequence.new(0)
				v21.WidthScale = NumberSequence.new(1, 0)
				v21.LightInfluence = 0
				v21.LightEmission = 1
				v21.Parent = p5
				local v22 = Instance.new("Trail")
				v22.Name = "TrailFX_Glow"
				v22.Attachment0 = v12
				v22.Attachment1 = v13
				v22.Lifetime = 0.25
				v22.Texture = "rbxassetid://12598279413"
				v22.TextureMode = Enum.TextureMode.Stretch
				v22.Color = ColorSequence.new(Color3.fromRGB(255, 180, 50))
				v22.FaceCamera = true
				v22.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) })
				v22.WidthScale = NumberSequence.new(1, 0)
				v22.LightInfluence = 0
				v22.LightEmission = 1
				v22.Parent = p5
				local v23 = Instance.new("Attachment", v10)
				v23.Name = "TrailFX_StarAtt"
				v23.Position = Vector3.new(0, -1, 0)
				local u24 = Instance.new("ParticleEmitter")
				u24.Name = "TrailFX_Stars"
				u24.Texture = "rbxassetid://10598374841"
				u24.Rate = 120
				u24.Lifetime = NumberRange.new(0.6, 1.2)
				u24.Speed = NumberRange.new(2, 6)
				u24.SpreadAngle = Vector2.new(80, 80)
				u24.Rotation = NumberRange.new(0, 360)
				u24.RotSpeed = NumberRange.new(-180, 180)
				u24.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 160, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 100, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 50, 0)) })
				u24.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(0.5, 1.4), NumberSequenceKeypoint.new(1, 0) })
				u24.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.85, 0), NumberSequenceKeypoint.new(1, 1) })
				u24.LightEmission = 1
				u24.Acceleration = Vector3.new(0, 4, 0)
				u24.LockedToPart = false
				u24.Enabled = false
				u24.Parent = v23
				local v25 = Instance.new("Attachment", v10)
				v25.Name = "TrailFX_SparkAtt"
				v25.Position = Vector3.new(0, -0.5, 0)
				local u26 = Instance.new("ParticleEmitter")
				u26.Name = "TrailFX_Sparks"
				u26.Texture = "rbxassetid://12598279413"
				u26.Rate = 180
				u26.Lifetime = NumberRange.new(0.3, 0.6)
				u26.Speed = NumberRange.new(3, 8)
				u26.SpreadAngle = Vector2.new(60, 60)
				u26.Rotation = NumberRange.new(0, 360)
				u26.RotSpeed = NumberRange.new(-360, 360)
				u26.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 255, 234)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(235, 200, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(144, 108, 0)) })
				u26.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4, 0.7), NumberSequenceKeypoint.new(1, 0) })
				u26.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0), NumberSequenceKeypoint.new(1, 1) })
				u26.LightEmission = 1
				u26.Acceleration = Vector3.new(0, 8, 0)
				u26.LockedToPart = false
				u26.Enabled = false
				u26.Parent = v25
				v11.Running:Connect(function(p27)

					local v28 = p27 > 1
					if u24 and u24.Parent then
						u24.Enabled = v28
					end
					if u26 and u26.Parent then
						u26.Enabled = v28
					end
				end)
			elseif p6 == "GalaxyTrail" then
				local v29 = Instance.new("Trail")
				v29.Name = "TrailFX_Overlay"
				v29.Attachment0 = v12
				v29.Attachment1 = v13
				v29.Lifetime = 0.45
				v29.Texture = "rbxassetid://12251459424"
				v29.TextureMode = Enum.TextureMode.Stretch
				v29.Color = ColorSequence.new(Color3.fromRGB(200, 160, 255))
				v29.FaceCamera = true
				v29.Transparency = NumberSequence.new(0)
				v29.WidthScale = NumberSequence.new(1, 0)
				v29.LightInfluence = 0
				v29.LightEmission = 1
				v29.Parent = p5
				local v30 = Instance.new("Attachment", v10)
				v30.Name = "TrailFX_PartAtt"
				local u31 = Instance.new("ParticleEmitter")
				u31.Name = "TrailFX_Particles"
				u31.Texture = "rbxassetid://12598279413"
				u31.Rate = 250
				u31.Lifetime = NumberRange.new(0.6, 1.2)
				u31.Speed = NumberRange.new(0)
				u31.LockedToPart = false
				u31.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 255)) })
				u31.Size = NumberSequence.new(1.2, 0)
				u31.Transparency = NumberSequence.new(0, 1)
				u31.LightEmission = 1
				u31.Enabled = false
				u31.Parent = v30
				v11.Running:Connect(function(p32)

					if u31 and u31.Parent then
						u31.Enabled = p32 > 1
					end
				end)
			end
		else
			return
		end
	end
end
local function u36(u34) 

	u34:GetAttributeChangedSignal("EquippedTrail"):Connect(function()

		u33(u34, u34:GetAttribute("EquippedTrail"))
	end)
	local v35 = u34:GetAttribute("EquippedTrail")
	if v35 then
		u33(u34, v35)
	end
end
v1.PlayerAdded:Connect(function(p37)

	p37.CharacterAdded:Connect(u36)
end)
for _, v38 in ipairs(v1:GetPlayers()) do
	if v38.Character then
		u36(v38.Character)
	end
	v38.CharacterAdded:Connect(u36)
end