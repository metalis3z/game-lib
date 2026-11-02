-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = script.Parent
local v_u_5 = v_u_4:WaitForChild("TextLabel")
local v_u_6 = v2:WaitForChild("SoundPackChanged")
local v7 = v2:WaitForChild("GetDailyCreamyStatus")
local v_u_8 = v2:WaitForChild("MarkCreamyUnlocked")
local v9 = v2:WaitForChild("MarkCreamyStarted")
local v_u_10 = v2:FindFirstChild("GlobalKeyToggled")
if not v_u_10 then
	v_u_10 = Instance.new("BindableEvent")
	v_u_10.Name = "GlobalKeyToggled"
	v_u_10.Parent = v2
end
v_u_5.TextScaled = true
v_u_5.TextWrapped = true
v_u_5.TextXAlignment = Enum.TextXAlignment.Center
v_u_5.TextYAlignment = Enum.TextYAlignment.Center
v_u_5.Font = Enum.Font.FredokaOne
local function v_u_12(p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	v_u_3:Create(v_u_4, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundColor3"] = p11
	}):Play()
end
local function v_u_16(p13)
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_12
	local v14 = v_u_5
	local v15 = p13 / 60
	v14.Text = ("Unlock in %dm %ds"):format(math.floor(v15), p13 % 60)
	v_u_4:SetAttribute("Locked", true)
	v_u_4:SetAttribute("Claimed", false)
	v_u_4.AutoButtonColor = false
	v_u_12(Color3.fromRGB(80, 80, 80))
end
local v17 = v7:InvokeServer()
local v18
if v17 then
	v18 = v17.alreadyUnlocked
else
	v18 = v17
end
local v19 = v17 and v17.remaining or 600
if v18 then
	v_u_5.Text = "Turn On"
	v_u_4:SetAttribute("Locked", false)
	v_u_4:SetAttribute("Claimed", false)
	v_u_4.AutoButtonColor = true
	v_u_12(Color3.fromRGB(60, 180, 75))
else
	local v_u_20 = time() + v19
	v_u_16(v19)
	v9:FireServer()
	local v_u_21 = nil
	v_u_21 = v1.Heartbeat:Connect(function()
		-- upvalues: (copy) v_u_20, (copy) v_u_16, (copy) v_u_5, (copy) v_u_4, (copy) v_u_12, (ref) v_u_21, (copy) v_u_8
		local v22 = v_u_20 - time()
		if v22 > 0 then
			v_u_16((math.floor(v22)))
		else
			v_u_5.Text = "Turn On"
			v_u_4:SetAttribute("Locked", false)
			v_u_4:SetAttribute("Claimed", false)
			v_u_4.AutoButtonColor = true
			v_u_12(Color3.fromRGB(60, 180, 75))
			if v_u_21 then
				v_u_21:Disconnect()
				v_u_21 = nil
			end
			v_u_8:FireServer()
		end
	end)
end
v_u_4.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_12, (ref) v_u_10
	if v_u_4:GetAttribute("Locked") then
		return
	elseif v_u_4:GetAttribute("Claimed") then
		v_u_6:Fire("Clicky")
		v_u_5.Text = "Turn On"
		v_u_4:SetAttribute("Locked", false)
		v_u_4:SetAttribute("Claimed", false)
		v_u_4.AutoButtonColor = true
		v_u_12(Color3.fromRGB(60, 180, 75))
		v_u_10:Fire("None")
	else
		v_u_6:Fire("Creamy")
		v_u_5.Text = "Turn Off"
		v_u_4:SetAttribute("Locked", false)
		v_u_4:SetAttribute("Claimed", true)
		v_u_4.AutoButtonColor = true
		v_u_12(Color3.fromRGB(200, 50, 50))
		v_u_10:Fire("Creamy")
	end
end)
v_u_10.Event:Connect(function(p23)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_12
	if p23 ~= "Creamy" and v_u_4:GetAttribute("Claimed") then
		v_u_5.Text = "Turn On"
		v_u_4:SetAttribute("Locked", false)
		v_u_4:SetAttribute("Claimed", false)
		v_u_4.AutoButtonColor = true
		v_u_12(Color3.fromRGB(60, 180, 75))
	end
end)
task.defer(function()
	-- upvalues: (copy) v_u_4
	for _, v24 in ipairs(v_u_4:GetDescendants()) do
		if v24:IsA("TextLabel") then
			local v25 = v24.Text
			v24.Text = v25 .. " "
			v24.Text = v25
		end
	end
end)
