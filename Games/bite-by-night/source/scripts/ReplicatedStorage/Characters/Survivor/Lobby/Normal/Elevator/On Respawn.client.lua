-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
game:GetService("TweenService")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("Players").LocalPlayer.PlayerGui
repeat
	task.wait()
until game:IsLoaded() and (game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
task.wait(0.01)

if script:WaitForChild("Check", 10):InvokeServer(game:GetService("Players").LocalPlayer) == true then
	script:WaitForChild("RemoteEvent", 10):FireServer(true)
	script.Parent.Parent:WaitForChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("Player Position").CFrame
else
	warn('Wo')
	
	local v_u_5 = v_u_4:WaitForChild("UI", 10):WaitForChild("Transitions"):WaitForChild("Lobby"):FindFirstChild("LobbyUIContainer") or v_u_4:WaitForChild("UI", 10):WaitForChild("UI"):WaitForChild("LobbyUIContainer", 10)
	if v_u_5:FindFirstChild("Buttons") then
		v_u_5.Buttons.Visible = true
	end
	
	warn('?')
	
	v_u_5.Visible = false
	
	local StuffToPreloaddd = {}
	for _, Value in game:GetDescendants() do 
		if Value:IsA('Animation') then
			table.insert(StuffToPreloaddd, Value);
		end
	end
	
	script:WaitForChild("RemoteEvent", 10):FireServer(false)
	v_u_3:PreloadAsync({
		workspace:WaitForChild("Lobby"),
		script:WaitForChild("Animation"),
		script:WaitForChild("ElevatorIntro"),
		script:WaitForChild("WaitAnimation")
	})
		
	warn('.')
	
	require(v1.Modules.Warp)
	
	warn('Ok.')
	
	local v6 = require(v1:WaitForChild("Modules"):WaitForChild("Cutscenes"), 1)
	
	warn('WE GO')
	
	local v7 = require(v1:WaitForChild("Modules"):WaitForChild("Maid"), 1)
	
	warn('Noo')
	
	local v_u_8 = script.Parent.Parent
	local v9 = workspace.LoadingSFX
	v9:Play()
	v_u_8:WaitForChild("HumanoidRootPart").Anchored = true
	v_u_8:WaitForChild("Humanoid").AutoRotate = false
	v_u_8:AddTag("CantMove")
	v_u_8:AddTag("Cutscene")
	game:GetService("Players").LocalPlayer:AddTag("Cutscene")
	function lerp(p10, p11, p12)
		return p10 + (p11 - p10) * p12
	end
	local v_u_13 = workspace:WaitForChild("Lobby"):WaitForChild("Elevator")
	v_u_13:PivotTo(CFrame.new(483.989, 61.528, 109.666))
	local v_u_14 = workspace:WaitForChild("Lobby"):WaitForChild("Shaft")
	v_u_14:PivotTo(CFrame.new(484.935, 277.252, 109.744))
	local v_u_15 = Instance.new("CFrameValue")
	v_u_15.Value = CFrame.new(0, 0, 0)
	local v_u_16 = Instance.new("CFrameValue")
	v_u_16.Value = CFrame.new(0, 200, 0)
	local v_u_17 = v_u_14:GetPivot()
	local v_u_18 = v_u_13:GetPivot()
	local v19 = next
	local v20, v21 = v_u_8:GetDescendants()
	for _, v22 in v19, v20, v21 do
		if v22:IsA("BasePart") then
			v22.LocalTransparencyModifier = v22.Transparency
		end
	end
	local v23 = workspace:WaitForChild("Lobby"):WaitForChild("Elevator"):WaitForChild("Elevator Doors"):WaitForChild("DoorRoot")
	v23.LDoor.DesiredAngle = 0
	v23.RDoor.DesiredAngle = 0
	local v_u_24 = workspace.CurrentCamera
	local v_u_25 = v6.ElevatorAlone
	local v_u_26 = v_u_25.CameraRig:Clone()
	v_u_26:PivotTo(workspace:FindFirstChild("Lobby")["Camera Position"].CFrame)
	v_u_26.Parent = workspace.IGNORE
	v_u_26:FindFirstChild(v_u_25.RootPart)
	local v_u_27 = v_u_26:FindFirstChild(v_u_25.CameraPart)
	v_u_24.CameraType = Enum.CameraType.Scriptable
	local v_u_28 = v_u_24.CFrame
	local _ = v_u_24.FieldOfView
	local function v29()
		-- upvalues: (copy) v_u_14, (copy) v_u_17, (copy) v_u_15, (copy) v_u_13, (copy) v_u_18, (copy) v_u_16, (copy) v_u_26, (copy) v_u_8
		v_u_14:PivotTo(v_u_17 * v_u_15.Value)
		v_u_13:PivotTo(v_u_18 * v_u_16.Value)
		v_u_26:PivotTo(workspace:FindFirstChild("Lobby")["Camera Position"].CFrame * v_u_16.Value)
		v_u_8:WaitForChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("Player Position").CFrame * v_u_16.Value
	end
	local v30 = game:GetService("RunService").Stepped:Connect(v29)
	local v31 = v_u_26:FindFirstChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(script.Animation)
	v31:Play()
	local v32 = v_u_8:WaitForChild("Humanoid"):LoadAnimation(script:WaitForChild("WaitAnimation"))
	v32:Play()
	local v33
	if game:GetService("Players").LocalPlayer:HasTag("LOADED") then
		v33 = true
	else
		local v_u_34 = false
		game:GetService("Players").LocalPlayer:AddTag("LOADED")
		game:GetService("Players").LocalPlayer:SetAttribute("LOADED", false)
		task.spawn(function()
			-- upvalues: (copy) v_u_15, (copy) v_u_4, (copy) v_u_25, (copy) v_u_13, (copy) v_u_3, (ref) v_u_34
			local v_u_35 = game:GetService("TweenService"):Create(v_u_15, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0), {
				["Value"] = CFrame.new(0, 100, 0)
			})
			v_u_35:Play()
			v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = true
			local v_u_36 = {
				v_u_25.Animation,
				game:GetService("ReplicatedStorage"),
				game:GetService("StarterGui"),
				game:GetService("Workspace")
			}
			local v37 = 0
			local v_u_38 = 0
			for _, v39 in next, v_u_36 do
				local v40 = next
				local v41, v42 = v39:GetDescendants()
				for _, v43 in v40, v41, v42 do
					if v43:IsA("Sound") or (v43:IsA("Animation") or (v43:IsA("MeshPart") or (v43:IsA("ImageLabel") or (v43:IsA("ImageButton") or (v43:IsA("Decal") or (v43:IsA("Texture") or (v43:IsA("ParticleEmitter") or v43:IsA("SurfaceAppearance")))))))) then
						v37 = v37 + 1
					end
				end
			end
			local v_u_44 = false
			local v_u_45 = false
			task.spawn(function()
				-- upvalues: (ref) v_u_15, (copy) v_u_35, (ref) v_u_44
				repeat
					v_u_15.Value = CFrame.new(0, 0, 0)
					v_u_35:Play()
					v_u_35.Completed:Wait()
				until v_u_44 == true
			end)
			v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = "Loading assets (0/" .. v37 .. ")"
			local v_u_46 = nil
			if game:GetService("RunService"):IsStudio() then
				if v_u_44 == false then
					v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = true
					v_u_13:FindFirstChild("Button").Attachment.PointLight.Enabled = true
					v_u_13:FindFirstChild("Button").Attachment.shine:Emit(1)
					v_u_46 = v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading"):WaitForChild("Button").MouseButton1Click:Once(function()
						-- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_45
						v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = false
						v_u_13:FindFirstChild("Button").Attachment.PointLight.Enabled = false
						v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = false
						v_u_45 = true
					end)
				end
			else
				task.delay(10, function()
					-- upvalues: (ref) v_u_44, (ref) v_u_4, (ref) v_u_13, (ref) v_u_46, (ref) v_u_45
					if v_u_44 == false then
						v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = true
						v_u_13:FindFirstChild("Button").Attachment.PointLight.Enabled = true
						v_u_13:FindFirstChild("Button").Attachment.shine:Emit(1)
						v_u_46 = v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading"):WaitForChild("Button").MouseButton1Click:Once(function()
							-- upvalues: (ref) v_u_4, (ref) v_u_13, (ref) v_u_45
							v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = false
							v_u_13:FindFirstChild("Button").Attachment.PointLight.Enabled = false
							v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = false
							v_u_45 = true
						end)
					end
				end)
			end
			local v_u_47 = false
			task.spawn(function()
				-- upvalues: (ref) v_u_3, (copy) v_u_36, (ref) v_u_38, (ref) v_u_47, (ref) v_u_4
				v_u_3:PreloadAsync(v_u_36, function(_, _)
					-- upvalues: (ref) v_u_38
					v_u_38 = v_u_38 + 1
				end)
				v_u_47 = true
				v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = ""
			end)
			local v48 = v_u_47
			local v49 = 0
			while true do
				if tick() - v49 > 0.1 then
					v49 = tick()
					v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = "\nLoading assets (" .. v_u_38 .. "/" .. v_u_38 + game:GetService("ContentProvider").RequestQueueSize .. ")"
				end
				task.wait()
				if v_u_45 or v48 then
					v_u_47 = true
					v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = ""
					v_u_44 = true
					v_u_35.Completed:Wait()
					if v_u_46 then
						v_u_46:Disconnect()
					end
					v_u_4:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = false
					v_u_13:FindFirstChild("Button").Attachment.PointLight.Enabled = false
					v_u_4:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = false
					v_u_35:Cancel()
					v_u_34 = true
					v33 = true
					v_u_15.Value = CFrame.new(0, -8, 0)
					
					break
				end
			end
		end)
		v33 = v_u_34
	end
	repeat
		v_u_24.CFrame = v_u_27.CFrame
		v_u_24.FieldOfView = 70
		task.wait()
	until v33 == true
	local v50 = v_u_26:FindFirstChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(v_u_25.Animation)
	repeat
		task.wait()
		warn('FUH')
	until v50.Length > 0
	v32:Stop(0.25)
	v31:Stop(0.25)
	local v_u_51 = v6.ElevatorAlone
	local v_u_52 = v7.new()
	v50:Play()
	v_u_52:Mark(v50)
	task.delay(7, v_u_26.Destroy, v_u_26)
	v9:Stop()
	workspace.LandingSFX:Play()
	local v53 = v_u_8:WaitForChild("Humanoid"):LoadAnimation(script:WaitForChild("ElevatorIntro"))
	v53:Play()
	task.spawn(function()
		-- upvalues: (copy) v_u_2, (copy) v_u_24, (copy) v_u_27, (copy) v_u_51, (copy) v_u_52
		local v_u_54 = 0.1
		v_u_52:Mark((v_u_2.PreSimulation:Connect(function(p55)
			-- upvalues: (ref) v_u_24, (ref) v_u_54, (ref) v_u_27, (ref) v_u_51
			v_u_24.CameraType = Enum.CameraType.Scriptable
			v_u_54 = v_u_54 + p55 * 60
			v_u_24.CFrame = v_u_27.CFrame
			if v_u_51.FOV then
				local v56 = v_u_54
				if v_u_51.FOV[math.ceil(v56)] then
					local v57 = v_u_54
					v_u_24.FieldOfView = v_u_51.FOV[math.ceil(v57)]
				end
			end
		end)))
	end)
	task.delay(v50.Length, function()
		-- upvalues: (copy) v_u_24, (copy) v_u_28, (copy) v_u_52
		v_u_24.CFrame = v_u_28
		v_u_24.CameraType = Enum.CameraType.Custom
		game:GetService("Players").LocalPlayer:RemoveTag("Cutscene")
		v_u_52:Sweep()
	end)
	game:GetService("TweenService"):Create(v_u_15, TweenInfo.new(0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["Value"] = CFrame.new(0, 0, 0)
	}):Play()
	game:GetService("TweenService"):Create(v_u_16, TweenInfo.new(3.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["Value"] = CFrame.new(0, 0, 0)
	}):Play()
	task.wait(4)
	v_u_15.Value = CFrame.new(0, 0, 0)
	v_u_16.Value = CFrame.new(0, 0, 0)
	v29()
	v_u_15:Destroy()
	v_u_16:Destroy()
	v30:Disconnect()
	game:GetService("TweenService"):Create(v23.LDoor, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		["DesiredAngle"] = 0.6
	}):Play()
	game:GetService("TweenService"):Create(v23.RDoor, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		["DesiredAngle"] = 0.6
	}):Play()
	task.wait(3)
	game:GetService("TweenService"):Create(v23.LDoor, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["DesiredAngle"] = 0
	}):Play()
	game:GetService("TweenService"):Create(v23.RDoor, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		["DesiredAngle"] = 0
	}):Play()
	if v53.IsPlaying then
		v53.Stopped:Wait()
	end
	v_u_8:RemoveTag("CantMove")
	v_u_8:RemoveTag("Cutscene")
	v_u_8:WaitForChild("HumanoidRootPart").Anchored = false
	v_u_8:WaitForChild("Humanoid").AutoRotate = true
	script.Ambience:Play()
	v_u_5.Parent = v_u_4:WaitForChild("UI"):WaitForChild("Transitions"):WaitForChild("Lobby")
	v_u_5.Visible = true
	v_u_4:WaitForChild("UI"):WaitForChild("Transitions"):WaitForChild("Lobby").GroupTransparency = 1
	game:GetService("TweenService"):Create(v_u_4:WaitForChild("UI"):WaitForChild("Transitions"):WaitForChild("Lobby"), TweenInfo.new(0.5), {
		["GroupTransparency"] = 0
	}):Play()
	task.delay(0.5, function()
		-- upvalues: (copy) v_u_5, (copy) v_u_4
		v_u_5.Parent = v_u_4:WaitForChild("UI"):WaitForChild("UI")
	end)
	
	v_u_3:PreloadAsync(StuffToPreloaddd);
	
	script.RemoteEvent:FireServer(true)
end