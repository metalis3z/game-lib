-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local u2 = game:GetService("UserInputService")
local u3 = game:GetService("CollectionService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4:WaitForChild("ClientState"))
local u6 = v1.LocalPlayer
local u7 = u6:WaitForChild("PlayerGui")
local v8 = v4:WaitForChild("Remotes")
local u9 = v8:WaitForChild("TikfinityAction")
local u10 = v8:WaitForChild("TikfinitySaveBinds")
local u11 = v8:WaitForChild("TikfinityLoadBinds")
local u12 = v4:FindFirstChild("TikfinityModules")
local u13 = {
	["Explode"] = 7,
	["Chicken"] = 3,
	["Jail"] = 5,
	["Ragdoll"] = 3,
	["Turtle"] = 5,
	["Tiny"] = 5,
	["Invisible"] = 5,
	["Disco"] = 5,
	["Blur"] = 5,
	["Earthquake"] = 4
}
local u14 = false
local u15 = {}
local u16 = {}
local u17 = {}
local u18 = {}
local function u21(p19) -- name: getUI
	-- upvalues: (ref) u18, (copy) u3, (copy) u7
	if not (u18[p19] and u18[p19].Parent) then
		for _, v20 in ipairs(u3:GetTagged(p19)) do
			if v20:IsDescendantOf(u7) then
				u18[p19] = v20
				return v20
			end
		end
		u18[p19] = nil
	end
	return u18[p19]
end
local u22 = false
local function u26() -- name: updateBinds
	-- upvalues: (ref) u17, (copy) u21
	u17 = {}
	local v23 = u21("TikfinityScroll")
	if v23 then
		for _, v24 in ipairs(v23:GetChildren()) do
			if v24:IsA("Frame") and v24:FindFirstChild("TextBox") then
				local v25 = v24.TextBox.Text:upper()
				if v25 ~= "" then
					u17[v25] = v24.Name
				end
			end
		end
	end
end
local function u31() -- name: saveBindsToServer
	-- upvalues: (copy) u21, (copy) u10
	local v27 = u21("TikfinityScroll")
	if v27 then
		local v28 = {}
		for _, v29 in ipairs(v27:GetChildren()) do
			if v29:IsA("Frame") and v29:FindFirstChild("TextBox") then
				local v30 = v29.TextBox.Text:upper()
				if v30 ~= "" then
					v28[v29.Name] = v30
				end
			end
		end
		u10:FireServer(v28)
	end
end
local function u37() -- name: loadBindsFromServer
	-- upvalues: (copy) u21, (copy) u11, (copy) u26
	local v32 = u21("TikfinityScroll")
	if v32 then
		local v33, v34 = pcall(function()
			-- upvalues: (ref) u11
			return u11:InvokeServer()
		end)
		if v33 and type(v34) == "table" then
			for _, v35 in ipairs(v32:GetChildren()) do
				if v35:IsA("Frame") and v35:FindFirstChild("TextBox") then
					local v36 = v34[v35.Name]
					if v36 and type(v36) == "string" then
						v35.TextBox.Text = v36
					end
				end
			end
			u26()
		end
	else
		return
	end
end
local function u40() -- name: connectScrollBinds
	-- upvalues: (ref) u22, (copy) u21, (copy) u37, (copy) u26, (copy) u31
	if u22 then
		return
	else
		local v38 = u21("TikfinityScroll")
		if v38 then
			u22 = true
			u37()
			for _, v39 in ipairs(v38:GetChildren()) do
				if v39:IsA("Frame") and v39:FindFirstChild("TextBox") then
					v39.TextBox.FocusLost:Connect(function()
						-- upvalues: (ref) u26, (ref) u31
						u26()
						u31()
					end)
				end
			end
		end
	end
end
local function u46(p41) -- name: processQueue
	-- upvalues: (copy) u16, (copy) u15, (ref) u14, (copy) u12, (copy) u6, (copy) u9, (copy) u13
	if not u16[p41] then
		u16[p41] = true
		while (u15[p41] or 0) > 0 do
			u15[p41] = u15[p41] - 1
			if u14 then
				local u42 = u12
				if u42 then
					u42 = u12:FindFirstChild(p41)
				end
				if u42 then
					task.spawn(function()
						-- upvalues: (copy) u42, (ref) u6
						local v43, v44 = pcall(function()
							-- upvalues: (ref) u42, (ref) u6
							require(u42).Run(u6)
						end)
						if not v43 then
							warn("[Tikfinity] Erreur module local : " .. v44)
						end
					end)
				else
					u9:FireServer(p41)
				end
			end
			local v45 = u13[p41] or 3
			task.wait(v45)
		end
		u16[p41] = false
	end
end
u2.InputBegan:Connect(function(p47, p48)
	-- upvalues: (ref) u14, (ref) u17, (copy) u15, (copy) u46
	if not p48 and u14 then
		local v49 = p47.UserInputType == Enum.UserInputType.Keyboard and u17[p47.KeyCode.Name:upper()]
		if v49 then
			u15[v49] = (u15[v49] or 0) + 1
			task.spawn(u46, v49)
		end
	end
end)
local function v51(u50) -- name: setupToggle
	-- upvalues: (ref) u14
	u50.MouseButton1Click:Connect(function()
		-- upvalues: (ref) u14, (copy) u50
		u14 = not u14
		u50.BackgroundColor3 = u14 and Color3.fromRGB(85, 255, 127) or Color3.fromRGB(255, 85, 85)
		u50.Text = u14 and "Tikfinity : ON" or "Tikfinity : OFF"
	end)
end
local u52 = u22
local u53 = u18
local u54 = u14
for _, u55 in ipairs(u3:GetTagged("TikfinityToggle")) do
	u55.MouseButton1Click:Connect(function()
		-- upvalues: (ref) u54, (copy) u55
		u54 = not u54
		u55.BackgroundColor3 = u54 and Color3.fromRGB(85, 255, 127) or Color3.fromRGB(255, 85, 85)
		u55.Text = u54 and "Tikfinity : ON" or "Tikfinity : OFF"
	end)
end
u3:GetInstanceAddedSignal("TikfinityToggle"):Connect(v51)
local function v58(p56) -- name: onOpenBtnAdded
	-- upvalues: (copy) u2, (copy) u21, (copy) u5
	if u2.KeyboardEnabled then
		p56.MouseButton1Click:Connect(function()
			-- upvalues: (ref) u21, (ref) u5
			local v57 = u21("TikfinityModal")
			if v57 then
				u5:ToggleModal(v57)
			end
		end)
	else
		p56.Visible = false
	end
end
for _, v59 in ipairs(u3:GetTagged("TikfinityOpenBtn")) do
	if u2.KeyboardEnabled then
		v59.MouseButton1Click:Connect(function()
			-- upvalues: (copy) u21, (copy) u5
			local v60 = u21("TikfinityModal")
			if v60 then
				u5:ToggleModal(v60)
			end
		end)
	else
		v59.Visible = false
	end
end
u3:GetInstanceAddedSignal("TikfinityOpenBtn"):Connect(v58)
local function v63(p61) -- name: onCloseBtnAdded
	-- upvalues: (copy) u21, (copy) u5
	p61.MouseButton1Click:Connect(function()
		-- upvalues: (ref) u21, (ref) u5
		local v62 = u21("TikfinityModal")
		if v62 and u5.ActiveModal == v62 then
			u5:CloseCurrentModal()
		end
	end)
end
for _, v64 in ipairs(u3:GetTagged("TikfinityCloseBtn")) do
	v64.MouseButton1Click:Connect(function()
		-- upvalues: (copy) u21, (copy) u5
		local v65 = u21("TikfinityModal")
		if v65 and u5.ActiveModal == v65 then
			u5:CloseCurrentModal()
		end
	end)
end
u3:GetInstanceAddedSignal("TikfinityCloseBtn"):Connect(v63)
task.spawn(function()
	-- upvalues: (copy) u40
	task.wait(2)
	u40()
end)
u6.CharacterAdded:Connect(function()
	-- upvalues: (ref) u53, (ref) u52, (copy) u40
	u53 = {}
	u52 = false
	task.wait(1)
	u40()
end)