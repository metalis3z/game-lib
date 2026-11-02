

local u1 = game:GetService("Players")
local u2 = game:GetService("Workspace")
local u3 = game:GetService("RunService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4.Shared:WaitForChild("AdminAbuseDoorConfig"))
local u6 = nil
local u7 = 0
local u8 = false
local v9 = {
	["isActive"] = function() 

		return u8
	end,
	["cancel"] = function() 

		u7 = u7 + 1
		if u6 and u6.Parent then
			u6:Destroy()
		end
		u6 = nil
	end
}
local function u13(p10) 

	local v11 = os.clock() + p10
	while true do
		local v12 = u2:FindFirstChild("AdminAbuseDoors")
		if not (v12 and v12:IsA("Folder")) then
			v12 = nil
		end
		if v12 then
			return v12
		end
		task.wait(0.05)
		if v11 <= os.clock() then
			return nil
		end
	end
end
local function u45(p14) 
	local v15 = p14:FindFirstChild("LeftWall")
	local v16 = p14:FindFirstChild("RightWall")
	if not (v15 and (v15:IsA("Model") and (v16 and v16:IsA("Model")))) then
		return nil, nil
	end
	local v17 = v15:GetPivot()
	local v18 = v16:GetPivot()
	local v19 = (v17.Position + v18.Position) / 2
	local v20 = CFrame.new(v19) * CFrame.Angles(v17:ToOrientation())
	local v21 = v15:GetExtentsSize()
	local v22 = v16:GetExtentsSize()
	local v23 = v21.Y
	local v24 = v22.Y
	local v25 = math.max(v23, v24)
	local v26 = v21.X + v22.X + (v17.Position - v18.Position).Magnitude
	local v27 = v21.Z
	local v28 = v22.Z
	local v29 = math.max(v27, v28)
	local v30 = Vector3.new(v26, v25, v29)
	local v31 = v20.Position
	local v32 = v30.Y * 0.27
	local v33 = v31 + Vector3.new(0, v32, 0)
	local v34 = p14:FindFirstChild("StartTransitionCamera")
	if v34 and v34:IsA("BasePart") then
		local v35 = CFrame.lookAt(v34.Position, v33)
		return v35, v35 * CFrame.new(0, 0, -25)
	end
	local v36 = v30.X
	local v37 = v30.Z
	local v38 = math.max(v36, v37) * 0.62 + 5.25
	local v39 = v38 * 2.05 + 5
	local v40 = v30.Y * 0.3
	local v41 = v30.Y * 0.36
	local v42 = v20.LookVector
	local v43 = v20.Position - v42 * v38 + Vector3.new(0, v40, 0)
	local v44 = v20.Position - v42 * v39 + Vector3.new(0, v41, 0)
	return CFrame.lookAt(v44, v33), CFrame.lookAt(v43, v33)
end
local function u49(p46) 

	local v47 = Instance.new("ScreenGui")
	v47.Name = "AdminAbuseTransition"
	v47.IgnoreGuiInset = true
	v47.DisplayOrder = 1000000
	v47.ResetOnSpawn = false
	v47.Parent = p46
	u6 = v47
	local v48 = Instance.new("Frame")
	v48.Size = UDim2.fromScale(1, 1)
	v48.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v48.BorderSizePixel = 0
	v48.BackgroundTransparency = 1
	v48.Parent = v47
	return v48
end
function v9.play(u50, u51) 

	local v52
	if u51 then
		v52 = u51.skip
	else
		v52 = u51
	end
	local u53 = v52 == true
	u7 = u7 + 1
	local u54 = u7
	u8 = true
	task.spawn(function()

		if u53 then
			local u55 = u54
			local u56 = u50
			if u55 == u7 and u56 then
				task.defer(function()

					if u55 == u7 then
						local v57, v58 = pcall(u56)
						if not v57 then
							warn("[AdminAbuse Transition] onBlack: ", v58)
						end
					end
				end)
			end
			u8 = false
			return
		else
			local u59 = u2.CurrentCamera
			if u59 then
				local u60 = u1.LocalPlayer
				if u60 then
					local v61 = u60:FindFirstChildOfClass("PlayerGui") or u60:WaitForChild("PlayerGui", 5)
					if v61 then
						local u62 = u5.TransitionBlackIn
						local v63 = u5.TransitionBlackHold
						local u64 = u5.TransitionBlackOut
						local u65 = u5.TransitionApproachSeconds
						local u66 = u5.TransitionShakeTail
						local u67 = u62 + v63
						local u68 = u67 + u64
						local u69 = u67 + u65
						local u70 = u5.DoorOpenDuration
						local u71 = u59.CameraType
						local u72 = u59.CameraSubject
						local u73 = u49(v61)
						local v74
						if u51 and u51.skipDoor then
							v74 = nil
						else
							v74 = u13(6) or nil
						end
						local u75, u76
						if v74 then
							u75, u76 = u45(v74)
						else
							u75 = nil
							u76 = nil
						end
						local u77
						if u75 == nil then
							u77 = false
						else
							u77 = u76 ~= nil
						end
						local u78 = Instance.new("Sound")
						u78.SoundId = "rbxassetid://104296862300351"
						u78.Looped = true
						u78.Volume = 1.8
						u78.Parent = workspace.CurrentCamera or u60:WaitForChild("PlayerGui")
						local u79 = Random.new()
						local u80 = 0
						local u81 = false
						local u82 = 0
						local v83 = u54
						local u84 = "AdminAbuseTransition_" .. tostring(v83)
						local function u87() 

							u8 = false
							u3:UnbindFromRenderStep(u84)
							if u6 and u6.Parent then
								u6:Destroy()
							end
							u6 = nil
							u59.CameraType = Enum.CameraType.Custom
							local v85 = u60.Character
							if v85 then
								v85 = v85:FindFirstChildOfClass("Humanoid")
							end
							if v85 then
								u59.CameraSubject = v85
							end
							if u78.Playing then
								u78:Stop()
								local u86 = Instance.new("Sound")
								u86.SoundId = "rbxassetid://126580113174759"
								u86.Volume = 2
								u86.Parent = u60:WaitForChild("PlayerGui")
								u86:Play()
								task.delay(5, function()

									u86:Destroy()
									u78:Destroy()
								end)
							else
								u78:Destroy()
							end
						end
						local u88 = nil
						u3:BindToRenderStep(u84, Enum.RenderPriority.Camera.Value + 1, function(p89)

							if u54 == u7 then
								if u59.CameraType ~= Enum.CameraType.Scriptable then
									u59.CameraType = Enum.CameraType.Scriptable
									u59.CameraSubject = nil
									if u88 then
										u59.CFrame = u88
									end
								end
								u80 = u80 + p89
								if u80 < u62 then
									local v90 = u80 / u62
									local v91 = u73
									local v92 = 3.141592653589793 * math.clamp(v90, 0, 1)
									v91.BackgroundTransparency = 1 - -(math.cos(v92) - 1) / 2
								elseif u80 < u67 then
									u73.BackgroundTransparency = 0
								elseif u80 < u68 then
									local v93 = (u80 - u67) / u64
									local v94 = u73
									local v95 = 3.141592653589793 * math.clamp(v93, 0, 1)
									v94.BackgroundTransparency = -(math.cos(v95) - 1) / 2
								else
									u73.BackgroundTransparency = 1
								end
								if u77 then
									local v96 = u75
									local v97 = u76
									if u80 < u62 then
										return
									end
									if u80 < u67 then
										u59.CameraType = Enum.CameraType.Scriptable
										u59.CameraSubject = nil
										u59.CFrame = v96
										u59.Focus = v96
									elseif u80 < u69 then
										u59.CameraType = Enum.CameraType.Scriptable
										u59.CameraSubject = nil
										local v98 = (u80 - u67) / u65
										local v99 = 3.141592653589793 * math.clamp(v98, 0, 1)
										local v100 = v96:Lerp(v97, -(math.cos(v99) - 1) / 2)
										u59.CFrame = v100
										u59.Focus = v100
									else
										u59.CameraType = Enum.CameraType.Scriptable
										u59.CameraSubject = nil
										if not u81 then
											u81 = true
											u78:Play()
											if u50 then
												local v101, v102 = pcall(u50)
												if not v101 then
													warn("[AdminAbuse Transition] onBlack: ", v102)
												end
											end
										end
										u82 = u82 + p89
										local v103 = u82 / u70
										local v104 = math.clamp(v103, 0, 1)
										local v105 = (u82 - u70 * 0.08) / (u70 * 0.92 + u66)
										local v106 = (1 - math.clamp(v105, 0, 1)) * 0.36
										local v107 = v104 * 3.141592653589793
										local v108 = v106 * (math.sin(v107) * 0.6 + 0.4)
										local v109 = CFrame.Angles(u79:NextNumber(-0.024, 0.024) * v108 * 3.5, u79:NextNumber(-0.028, 0.028) * v108 * 3.5, u79:NextNumber(-0.016, 0.016) * v108 * 3.5)
										local v110 = v97 * CFrame.new(u79:NextNumber(-1, 1) * v108 * 0.44, u79:NextNumber(-1, 1) * v108 * 0.36, u79:NextNumber(-1, 1) * v108 * 0.44) * v109
										u59.CFrame = v110
										u59.Focus = v110
										if u82 >= u70 + u66 + 1 then
											if u54 == u7 then
												u87()
											end
										elseif u82 >= u70 + u66 then
											u59.CFrame = v97
											u59.Focus = v97
											if u78.Playing then
												u78:Stop()
											end
										end
									end
								elseif u68 <= u80 and not u81 then
									u81 = true
									if u50 then
										local v111, v112 = pcall(u50)
										if not v111 then
											warn("[AdminAbuse Transition] onBlack: ", v112)
										end
									end
									if u54 == u7 then
										u87()
									end
								end
								u88 = u59.CFrame
							else
								u59.CameraType = u71
								u59.CameraSubject = u72
								u3:UnbindFromRenderStep(u84)
								if u78 then
									u78:Destroy()
								end
							end
						end)
					else
						local u113 = u54
						local u114 = u50
						if u113 == u7 then
							if not u114 then
								return
							end
							task.defer(function()

								if u113 == u7 then
									local v115, v116 = pcall(u114)
									if not v115 then
										warn("[AdminAbuse Transition] onBlack: ", v116)
									end
								end
							end)
						end
					end
				else
					local u117 = u54
					local u118 = u50
					if u117 == u7 then
						if not u118 then
							return
						end
						task.defer(function()

							if u117 == u7 then
								local v119, v120 = pcall(u118)
								if not v119 then
									warn("[AdminAbuse Transition] onBlack: ", v120)
								end
							end
						end)
					end
					return
				end
			else
				local u121 = u54
				local u122 = u50
				if u121 == u7 then
					if not u122 then
						return
					end
					task.defer(function()

						if u121 == u7 then
							local v123, v124 = pcall(u122)
							if not v123 then
								warn("[AdminAbuse Transition] onBlack: ", v124)
							end
						end
					end)
				end
				return
			end
		end
	end)
end
return v9