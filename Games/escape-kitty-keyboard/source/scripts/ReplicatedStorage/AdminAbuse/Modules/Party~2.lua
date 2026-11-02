

local u1 = game:GetService("RunService")
local u2 = game:GetService("Players")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("Lighting")
local u5 = CFrame.new(0, 20, -50)
local u6 = nil
local u7 = nil
local u8 = nil
local u43 = {
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
			u6:Disconnect()
			u6 = nil
		end
		if u7 then
			u7:Destroy()
			u7 = nil
		end
		if u8 then
			u8:Destroy()
			u8 = nil
		end
	end,
	["Fire"] = function(p9) 

		p9:Stop()
		local v10 = u2.LocalPlayer
		if v10 then
			local u11 = v10.Character or v10.CharacterAdded:Wait()
			local u12 = u11:WaitForChild("HumanoidRootPart", 30)
			if u12 then
				local v13 = workspace.CurrentCamera
				if not v13 then
					workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
					v13 = workspace.CurrentCamera
				end
				if v13 then
					local v14 = u3:FindFirstChild("Spotlight")
					if v14 and v14:IsA("Model") then
						local v15 = v14:Clone()
						for _, v16 in ipairs(v15:GetDescendants()) do
							if v16:IsA("BasePart") then
								v16.Anchored = true
								v16.CanCollide = false
								v16.CanQuery = false
								v16.Massless = true
							end
						end
						v15.Parent = v13
						u7 = v15
						local v17 = Instance.new("ColorCorrectionEffect")
						v17.Name = "ConcertColorCorrection"
						v17.Brightness = 0.05
						v17.Contrast = 0.25
						v17.Saturation = 0.35
						v17.TintColor = Color3.fromRGB(255, 255, 255)
						v17.Parent = u4
						u8 = v17
						local v18 = v15:GetPivot()
						local u19 = {}
						local u20 = {}
						local u21 = {}
						for _, v22 in ipairs(v15:GetDescendants()) do
							if v22:IsA("BasePart") then
								if v22.Name == "Part" then
									local v23 = v22:FindFirstChild("Attachment")
									if v23 and v23:IsA("Attachment") then
										local v24 = {
											["part"] = v22,
											["partOffset"] = v18:ToObjectSpace(v22.CFrame),
											["attachment"] = v23,
											["attachmentBasePosition"] = v23.Position,
											["randomOffset"] = math.random() * 100,
											["speed"] = math.random(80, 140) / 100
										}
										table.insert(u20, v24)
									end
								elseif v22.Name == "Particle" then
									local v25 = {
										["part"] = v22,
										["partOffset"] = v18:ToObjectSpace(v22.CFrame)
									}
									table.insert(u19, v25)
								end
							elseif v22:IsA("Beam") then
								local v26 = {
									["beam"] = v22,
									["colorOffset"] = math.random()
								}
								table.insert(u21, v26)
							end
						end
						u6 = u1.RenderStepped:Connect(function()

							if u11.Parent and u12.Parent then
								local v27 = workspace.CurrentCamera
								if v27 then
									if u7 and u7.Parent ~= v27 then
										u7.Parent = v27
									end
									for _, v28 in ipairs(u20) do
										if not v28.part.Parent then
											u43:Stop()
											return
										end
									end
									for _, v29 in ipairs(u19) do
										if not v29.part.Parent then
											u43:Stop()
											return
										end
									end
									local v30 = os.clock()
									local v31 = CFrame.new(v27.CFrame.Position) * u5
									for _, v32 in ipairs(u20) do
										v32.part.CFrame = v31 * v32.partOffset
										local v33 = (v30 + v32.randomOffset) * 1.5 * v32.speed
										local v34 = math.sin(v33) * 30
										local v35 = v33 * 0.7
										local v36 = math.sin(v35) * 30
										v32.attachment.Position = v32.attachmentBasePosition + Vector3.new(v34, 0, v36)
									end
									local v37 = CFrame.new(u12.Position)
									for _, v38 in ipairs(u19) do
										v38.part.CFrame = v37 * v38.partOffset
									end
									for _, v39 in ipairs(u21) do
										if v39.beam.Parent then
											local v40 = (v30 * 0.12 + v39.colorOffset) % 1
											local v41 = Color3.fromHSV(v40, 1, 1)
											v39.beam.Color = ColorSequence.new(v41)
										end
									end
									if u8 and u8.Parent then
										local v42 = v30 * 0.12 * 0.5 % 1
										u8.TintColor = Color3.fromHSV(v42, 0.25, 1)
									end
								end
							else
								u43:Stop()
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
return u43