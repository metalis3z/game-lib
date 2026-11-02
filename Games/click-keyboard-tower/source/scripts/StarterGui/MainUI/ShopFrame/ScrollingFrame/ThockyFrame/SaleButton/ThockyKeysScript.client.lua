-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("Players")
local v_u_2 = game:GetService("MarketplaceService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = v1.LocalPlayer
local v_u_6 = script.Parent
local v_u_7 = v_u_6:WaitForChild("TextLabel")
local v_u_8 = v3:WaitForChild("SoundPackChanged")
local v_u_9 = v3:FindFirstChild("GlobalKeyToggled")
if not v_u_9 then
	v_u_9 = Instance.new("BindableEvent")
	v_u_9.Name = "GlobalKeyToggled"
	v_u_9.Parent = v3
end
v_u_7.TextScaled = true
v_u_7.TextWrapped = true
v_u_7.TextXAlignment = Enum.TextXAlignment.Center
v_u_7.TextYAlignment = Enum.TextYAlignment.Center
v_u_7.Font = Enum.Font.FredokaOne
local function v_u_11(p10)
	-- upvalues: (copy) v_u_4, (copy) v_u_6
	v_u_4:Create(v_u_6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundColor3"] = p10
	}):Play()
end
local v12, v13 = pcall(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	return v_u_2:UserOwnsGamePassAsync(v_u_5.UserId, 1509057629)
end)
if v12 and v13 then
	v_u_7.Text = "Turn On"
	v_u_6:SetAttribute("Owned", true)
	v_u_6:SetAttribute("Claimed", false)
	v_u_11(Color3.fromRGB(60, 180, 75))
else
	v_u_7.Text = "\238\128\130 99"
	v_u_6:SetAttribute("Owned", false)
	v_u_6:SetAttribute("Claimed", false)
	v_u_11(Color3.fromRGB(60, 180, 75))
end
v_u_6.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_5, (copy) v_u_8, (copy) v_u_7, (copy) v_u_11, (ref) v_u_9
	if not v_u_6:GetAttribute("Busy") then
		v_u_6:SetAttribute("Busy", true)
		local v14 = v_u_6:GetAttribute("Owned")
		local v15 = v_u_6:GetAttribute("Claimed")
		if v14 then
			if v15 then
				v_u_8:Fire("Clicky")
				v_u_7.Text = "Turn On"
				v_u_6:SetAttribute("Owned", true)
				v_u_6:SetAttribute("Claimed", false)
				v_u_11(Color3.fromRGB(60, 180, 75))
				v_u_9:Fire("None")
			else
				v_u_8:Fire("Thocky")
				v_u_7.Text = "Turn Off"
				v_u_6:SetAttribute("Owned", true)
				v_u_6:SetAttribute("Claimed", true)
				v_u_11(Color3.fromRGB(200, 50, 50))
				v_u_9:Fire("Thocky")
			end
		else
			v_u_2:PromptGamePassPurchase(v_u_5, 1509057629)
		end
		v_u_6:SetAttribute("Busy", false)
	end
end)
v_u_2.PromptGamePassPurchaseFinished:Connect(function(p16, p17, p18)
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_6, (copy) v_u_11
	if p16 == v_u_5 and (p17 == 1509057629 and p18) then
		v_u_7.Text = "Turn On"
		v_u_6:SetAttribute("Owned", true)
		v_u_6:SetAttribute("Claimed", false)
		v_u_11(Color3.fromRGB(60, 180, 75))
	end
end)
v_u_9.Event:Connect(function(p19)
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_11
	if p19 ~= "Thocky" and v_u_6:GetAttribute("Claimed") then
		v_u_7.Text = "Turn On"
		v_u_6:SetAttribute("Owned", true)
		v_u_6:SetAttribute("Claimed", false)
		v_u_11(Color3.fromRGB(60, 180, 75))
	end
end)
task.defer(function()
	-- upvalues: (copy) v_u_6
	for _, v20 in ipairs(v_u_6:GetDescendants()) do
		if v20:IsA("TextLabel") then
			local v21 = v20.Text
			v20.Text = v21 .. " "
			v20.Text = v21
		end
	end
end)
