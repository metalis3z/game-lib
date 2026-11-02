spawn(function()
	local rotacoLlaoGdpU = nil
	rotacoLlaoGdpU = game.ReplicatedStorage.Remote[string.reverse("rotacoLlaoGdpU")]
	local v13 = game:GetService("RunService")
	local v14 = script
	local v15 = v14.Parent
	local v16 = v15.Locater
	v15 = workspace.CurrentCamera
	v14 = nil
	local v17
	local v18
	local v19
	local v20
	local v21
	local v22
	local v23 = game
	local v24 = v23.Players
	local v25 = v24.LocalPlayer
	v24 = true
	v23 = true
	local v28 = game:GetService("TweenService")
	local v30 = v15.ViewportSize.Y
	local v31 = script
	local v32 = v31.Parent
	local v33 = v32.AbsoluteSize
	local v364 = v33.Y
	local v34 = v30 - v364
	if v34 ~= 0 then
		v30 = UDim2.new
		v364 = 1
		v33 = 0
		v32 = 1
		v31 = v34
		v16.Size = UDim2.new(v364, v33, v32, v31)
		v16.Position = UDim2.new(0, 0, 0, -v34)
	end
	local visableBool = true
	local function updShowGoalLocator()
		v16.Visible = visableBool
	end
	script.UpdShowGoals.Event:connect(function(p7)
		visableBool = p7
		updShowGoalLocator()
	end)
	script.UpdEnabled.Event:connect(function(p8)
		visableBool = p8
		updShowGoalLocator()
	end)
	rotacoLlaoGdpU.OnClientEvent:connect(function(p1, p2, p3, p4, p5) --v363 = UpdGoalLocator 
		local v43 = v15
		v16.CurrentCamera = v43
		local v320 = v19
		if not v320 then
			v19 = Instance.new("Part")
			v19.Anchored = true
			v19.Material = Enum.Material.Neon
			v19.Parent = v16
			v19.Name = "Line"
			Instance.new("SpecialMesh", v19).MeshType = "Cylinder"
		end
		local v47 = v20
		if not v47 then
			v20 = Instance.new("Part")
			v20.Anchored = true
			v20.Material = Enum.Material.Neon
			v20.Parent = v16
			v20.Name = "Ball"
			v20.Shape = "Ball"
			v20.Size = Vector3.new(0.5, 0.5, 0.5)
		end
		local v56 = v16:FindFirstChild("NextLine")
		if v56 then
			v16.NextLine:Destroy()
		end
		v18 = p2
		v14 = p1
		v17 = p3
		v21 = p4
		v22 = p5
		local v57 = v18
		if v57 then
			v57 = v17
			if v57 then
				v57 = v21
				if v57 then
					local v54 = "Part"
					local v58 = Instance.new(v54)
					v58.Anchored = true
					v58.Material = Enum.Material.Neon
					v58.Parent = v16
					v58.Name = "NextLine"
					local v63 = Color3.new(1, 1, 1)
					local v64 = v22
					if v64 then
						v64 = v22.Border
						v63 = v64.ImageColor3
					end
					v58.Color = v63
					local v65 = "SpecialMesh"
					Instance.new(v65, v58).MeshType = "Cylinder"
					local function updateNextLocator_1()
						local test = v21
						local test2 = v14
						if test2 ~= nil and test ~= nil then
							local v74 = (test2.Position - test.Position).magnitude
							v58.Size = Vector3.new(v74, 0.2, 0.2)
							v58.CFrame = ((CFrame.new(test.Position, test2.Position)) * CFrame.Angles(0, -1.5707963267949, 0)) * CFrame.new(-(v74) * 0.5, 0, 0)
						end
					end
					updateNextLocator_1()
					task.spawn(function()
						repeat task.wait() until v14 ~= nil and v21 ~= nil
						v14:GetPropertyChangedSignal("Position"):Connect(updateNextLocator_1)
						v21:GetPropertyChangedSignal("Position"):Connect(updateNextLocator_1)
					end)
				end
				local v58 = v18
				local v63 = false
				local updateNextLocator_1 = v18
				local v67 = updateNextLocator_1.Touched
				v67:connect(function(p6)
					local v112 = v63
					if not v112 then
						v112 = v58
						if v112 == v18 then
							v112 = p6.Parent
							local v115 = v112:FindFirstChild("Humanoid")
							if v115 then
								v115 = game.Players
								local v120 = game
								local v121 = v120.Players
								if v115:GetPlayerFromCharacter(p6.Parent) == v121.LocalPlayer then
									if p6.Parent:FindFirstChild("HumanoidRootPart") then
										local v126 = v18
										v120 = (v18.Size.X) * v126.Size.X
										v121 = v120 + (v18.Size.Z) * v18.Size.Z
										local v128 = math.sqrt(v121)
										local v129 = v18
										v120 = (v128) * v128 + v18.Size.Z + v129.Size.Z
										local v160 = p6.Position
										local v163 = v160 - v18.Position
										if math.sqrt(v120) >= v163.magnitude then
											v63 = true
											v163 = 0.05
											v160 = function()
												v63 = false
											end
											delay(v163, v160)
											--v8.PressedMapButton:FireServer(v18)
											local v138, v139 = v17:GetDescendants()
											for v123, v126 in next, v138, v139 do
												local v141 = v126:IsA("ImageLabel")
												if v141 then
													v141 = Color3.new
													v129 = 0.498039
													v126.ImageColor3 = v141(v129, 0.498039, 0.498039)
												end
											end
										end
									end
								end
							end
						end
					end
				end)
			end
		end
		local v171 = p1 ~= nil and p1.Name ~= "ExitRegion" and p1.Parent:WaitForChild("Light").BrickColor.Color or Color3.new(1, 1, 1)
		v19.Color = v171
		v20.Color = v171
		local c = v16:FindFirstChild("NextLine")
		if c then
			c.Color = Color3.fromRGB(245, 205, 48)
		end
		local v235 = v14
		if v235 then
			spawn(function()
				local v241 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
				while true do
					if v14 ~= nil then
						local v242 = v14
						--print(v242)
						local v245 = type(v242)
						if v245 == "table" then
							local v311 = 10000000
							local v246
							local v247 = 1
							for v247 = v247, #v242, 1 do
								local v255 = v25.Character.HumanoidRootPart.Position - v242[v247].Position.magnitude
								if v245 >= v255 then
									local v312 = v255
									v246 = v247
								end
							end
							v242 = v242[v246]
						end
						local v246 = v16
						if v246.Visible then
							if v23 then
								if v19 then
									if v20 then
										local v249 = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
										local v248 = v249.CFrame
										local v249 = CFrame.new
										local v247 = 0
										local v255 = 0
										local v254 = -5
										local v256 = v249(v247, v255, v254)
										v246 = (v248) * v256
										local v317 = v246.p
										v248 = v25
										v246 = v248.Character
										if v246 then
											v248 = v25
											v246 = v248.Character
											v256 = "Torso"
											local v257 = v246:FindFirstChild(v256)
											if v257 then
												v248 = v25.Character
												v257 = v248.Torso
												local v318 = v257.Position
											end
										end
										if v242 ~= nil then
											local v258 = v242.Position
											v248 = v317 - v258
											local  v257 = v248.magnitude
											v258 = v257 - 6
											v248 = math.clamp
											v257 = v248(v258, 0, v257)
											local v265 = Vector3.new(v257, 0.2, 0.2)
											local v253 = v317
											local v252 = -1.5707963267949
											local v251 = 0
											local v276 = ((CFrame.new(v242.Position, v253)) * CFrame.Angles(0, v252, v251)) * CFrame.new(-(v257) * 0.5, 0, 0)
											local v302 = (CFrame.new(v242.Position, v317)) * CFrame.new(0, 0, -v257)
											local v286 = v19.Position
											local v303 = v276.p
											if 16 >= (v19.Position - v303).magnitude then
												v286 = v19
												v303 = v241
												v28:Create(v286, v303, {
													Size = v265, CFrame = v276
												}):Play()
												v28:Create(v20, v241, {
													CFrame = v302
												}):Play()
											else
												v19.Size = v265
												v19.CFrame = v276
												v20.CFrame = v302
											end
										end
									end
								end
							end
						end
					end
					wait(0.05)
				end
			end)
		end
	end)
end)
