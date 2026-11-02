

local u1 = game:GetService("RunService")
local u2 = game:GetService("Players")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("Lighting")
local u5 = CFrame.new(0, 20, -50)
local u6 = nil
local u40 = {
	["MaxDurationSeconds"] = 1200,
	["DefaultDurationSeconds"] = 600,
	["NeedsDuration"] = true,
	["RequiresRespawnRefire"] = true,
	["SkipDoorTransition"] = true,
	["Sounds"] = {
		"rbxassetid://140074993424765",
		"rbxassetid://142376088",
		"rbxassetid://5410080857",
		"rbxassetid://127447678350704",
		"rbxassetid://7024280102",
		"rbxassetid://7024245182"
	},
	["Stop"] = function(_) 

		if u6 then
			if u6.connection then
				u6.connection:Disconnect()
			end
			if u6.model then
				u6.model:Destroy()
			end
			if u6.colorCorrection then
				u6.colorCorrection:Destroy()
			end
			u6 = nil
		end
	end,
	["Fire"] = function(p7) 

		p7:Stop()
		local v8 = u2.LocalPlayer
		if v8 then
			local u9 = v8.Character or v8.CharacterAdded:Wait()
			local u10 = u9:WaitForChild("HumanoidRootPart", 30)
			if u10 then
				local v11 = workspace.CurrentCamera
				if not v11 then
					workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
					v11 = workspace.CurrentCamera
				end
				if v11 then
					local v12 = u3:FindFirstChild("Spotlight")
					if v12 and v12:IsA("Model") then
						local v13 = v12:Clone()
						for _, v14 in ipairs(v13:GetDescendants()) do
							if v14:IsA("BasePart") then
								v14.Anchored = true
								v14.CanCollide = false
								v14.CanQuery = false
								v14.Massless = true
							end
						end
						v13.Parent = v11
						local v15 = Instance.new("ColorCorrectionEffect")
						v15.Name = "ConcertColorCorrection"
						v15.Brightness = 0.05
						v15.Contrast = 0.25
						v15.Saturation = 0.35
						v15.TintColor = Color3.fromRGB(255, 255, 255)
						v15.Parent = u4
						local u16 = {
							["model"] = v13,
							["colorCorrection"] = v15
						}
						u6 = u16
						local v17 = v13:GetPivot()
						local u18 = {}
						local u19 = {}
						local u20 = {}
						for _, v21 in ipairs(v13:GetDescendants()) do
							if v21:IsA("BasePart") then
								if v21.Name == "Part" then
									local v22 = v21:FindFirstChild("Attachment")
									if v22 and v22:IsA("Attachment") then
										local v23 = {
											["part"] = v21,
											["partOffset"] = v17:ToObjectSpace(v21.CFrame),
											["attachment"] = v22,
											["attachmentBasePosition"] = v22.Position,
											["randomOffset"] = math.random() * 100,
											["speed"] = math.random(80, 140) / 100
										}
										table.insert(u19, v23)
									end
								elseif v21.Name == "Particle" then
									local v24 = {
										["part"] = v21,
										["partOffset"] = v17:ToObjectSpace(v21.CFrame)
									}
									table.insert(u18, v24)
								end
							elseif v21:IsA("Beam") then
								local v25 = {
									["beam"] = v21,
									["colorOffset"] = math.random()
								}
								table.insert(u20, v25)
							end
						end
						u16.connection = u1.RenderStepped:Connect(function()

							if u6 == u16 then
								if u9.Parent and u10.Parent then
									local v26 = workspace.CurrentCamera
									if v26 then
										if u16.model and u16.model.Parent ~= v26 then
											u16.model.Parent = v26
										end
										local v27 = os.clock()
										local v28 = CFrame.new(v26.CFrame.Position) * u5
										for _, v29 in ipairs(u19) do
											v29.part.CFrame = v28 * v29.partOffset
											local v30 = (v27 + v29.randomOffset) * 1.5 * v29.speed
											local v31 = math.sin(v30) * 30
											local v32 = v30 * 0.7
											local v33 = math.sin(v32) * 30
											v29.attachment.Position = v29.attachmentBasePosition + Vector3.new(v31, 0, v33)
										end
										local v34 = CFrame.new(u10.Position)
										for _, v35 in ipairs(u18) do
											v35.part.CFrame = v34 * v35.partOffset
										end
										for _, v36 in ipairs(u20) do
											if v36.beam.Parent then
												local v37 = (v27 * 0.12 + v36.colorOffset) % 1
												local v38 = Color3.fromHSV(v37, 1, 1)
												v36.beam.Color = ColorSequence.new(v38)
											end
										end
										if u16.colorCorrection and u16.colorCorrection.Parent then
											local v39 = v27 * 0.12 * 0.5 % 1
											u16.colorCorrection.TintColor = Color3.fromHSV(v39, 0.25, 1)
										end
									end
								else
									u40:Stop()
									return
								end
							else
								if u16.connection then
									u16.connection:Disconnect()
								end
								return
							end
						end)
					else
						warn("[AdminAbuse Party] Mod\195\168le \"Spotlight\" introuvable dans ReplicatedStorage")
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
	end
}
return u40