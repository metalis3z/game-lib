-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("Debris")
local u5 = v1.LocalPlayer
local u6 = require(v2:WaitForChild("Config"))
local v7 = v2:WaitForChild("Remotes")
local v8 = v7:WaitForChild("SpaceZoneEnter")
local v9 = v7:WaitForChild("SpaceZoneLeave")
local u10 = false
local function u36(p11) -- name: playTransformEffect
	-- upvalues: (copy) u5, (copy) u4, (copy) u3
	local v12 = u5.Character
	if v12 then
		local u13 = v12:FindFirstChild("HumanoidRootPart")
		if u13 then
			if p11 then
				local v14 = Instance.new("Sound")
				v14.SoundId = p11.ID
				v14.Volume = p11.Volume
				v14.Parent = workspace
				v14:Play()
				u4:AddItem(v14, 6)
			end
			local u15 = 8
			local u16 = 0.5
			local u17 = 45
			task.delay(0, function()
				-- upvalues: (copy) u13, (copy) u15, (copy) u16, (ref) u3, (copy) u17
				if u13 and u13.Parent then
					local u18 = Instance.new("BillboardGui")
					u18.Size = UDim2.new(u15, 0, u15, 0)
					u18.StudsOffset = Vector3.new(0, 0, 0)
					u18.AlwaysOnTop = true
					u18.Adornee = u13
					u18.Parent = u13
					local v19 = Instance.new("ImageLabel")
					v19.Image = "rbxassetid://9509570418"
					v19.BackgroundTransparency = 1
					v19.Size = UDim2.new(1, 0, 1, 0)
					v19.ImageTransparency = 0
					v19.Parent = u18
					local v20 = TweenInfo.new(u16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					u3:Create(u18, v20, {
						["Size"] = UDim2.new(u17, 0, u17, 0)
					}):Play()
					local v21 = u3:Create(v19, v20, {
						["ImageTransparency"] = 1
					})
					v21:Play()
					v21.Completed:Connect(function()
						-- upvalues: (copy) u18
						u18:Destroy()
					end)
				end
			end)
			local u22 = 6
			local u23 = 0.6
			local u24 = 35
			task.delay(0.12, function()
				-- upvalues: (copy) u13, (copy) u22, (copy) u23, (ref) u3, (copy) u24
				if u13 and u13.Parent then
					local u25 = Instance.new("BillboardGui")
					u25.Size = UDim2.new(u22, 0, u22, 0)
					u25.StudsOffset = Vector3.new(0, 0, 0)
					u25.AlwaysOnTop = true
					u25.Adornee = u13
					u25.Parent = u13
					local v26 = Instance.new("ImageLabel")
					v26.Image = "rbxassetid://9509570418"
					v26.BackgroundTransparency = 1
					v26.Size = UDim2.new(1, 0, 1, 0)
					v26.ImageTransparency = 0
					v26.Parent = u25
					local v27 = TweenInfo.new(u23, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					u3:Create(u25, v27, {
						["Size"] = UDim2.new(u24, 0, u24, 0)
					}):Play()
					local v28 = u3:Create(v26, v27, {
						["ImageTransparency"] = 1
					})
					v28:Play()
					v28.Completed:Connect(function()
						-- upvalues: (copy) u25
						u25:Destroy()
					end)
				end
			end)
			local u29 = 4
			local u30 = 0.7
			local u31 = 25
			task.delay(0.24, function()
				-- upvalues: (copy) u13, (copy) u29, (copy) u30, (ref) u3, (copy) u31
				if u13 and u13.Parent then
					local u32 = Instance.new("BillboardGui")
					u32.Size = UDim2.new(u29, 0, u29, 0)
					u32.StudsOffset = Vector3.new(0, 0, 0)
					u32.AlwaysOnTop = true
					u32.Adornee = u13
					u32.Parent = u13
					local v33 = Instance.new("ImageLabel")
					v33.Image = "rbxassetid://9509570418"
					v33.BackgroundTransparency = 1
					v33.Size = UDim2.new(1, 0, 1, 0)
					v33.ImageTransparency = 0
					v33.Parent = u32
					local v34 = TweenInfo.new(u30, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					u3:Create(u32, v34, {
						["Size"] = UDim2.new(u31, 0, u31, 0)
					}):Play()
					local v35 = u3:Create(v33, v34, {
						["ImageTransparency"] = 1
					})
					v35:Play()
					v35.Completed:Connect(function()
						-- upvalues: (copy) u32
						u32:Destroy()
					end)
				end
			end)
		end
	else
		return
	end
end
local function v38() -- name: setSpaceGravity
	-- upvalues: (ref) u10, (copy) u36, (copy) u6, (copy) u5
	u10 = true
	workspace.Gravity = 78.48
	u36(u6.SOUNDS.EFFECT1)
	local v37 = u5.Character
	if v37 then
		v37 = v37:FindFirstChildOfClass("Humanoid")
	end
	if v37 then
		v37.JumpPower = 125
		v37.JumpHeight = 30
	end
end
local function v41() -- name: restoreGravity
	-- upvalues: (ref) u10, (copy) u36, (copy) u6, (copy) u5
	local v39 = u10
	u10 = false
	workspace.Gravity = 196.2
	if v39 then
		u36(u6.SOUNDS.EFFECT2)
	end
	local v40 = u5.Character
	if v40 then
		v40 = v40:FindFirstChildOfClass("Humanoid")
	end
	if v40 then
		v40.JumpPower = 50
		v40.JumpHeight = 7.2
	end
end
v8.OnClientEvent:Connect(v38)
v9.OnClientEvent:Connect(v41)
u5.CharacterAdded:Connect(function()
	-- upvalues: (ref) u10, (copy) u36, (copy) u6, (copy) u5
	local v42 = u10
	u10 = false
	workspace.Gravity = 196.2
	if v42 then
		u36(u6.SOUNDS.EFFECT2)
	end
	local v43 = u5.Character
	if v43 then
		v43 = v43:FindFirstChildOfClass("Humanoid")
	end
	if v43 then
		v43.JumpPower = 50
		v43.JumpHeight = 7.2
	end
end)