-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local u1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("Debris")
local u5 = u1.LocalPlayer:WaitForChild("PlayerGui")
local v6 = v2:WaitForChild("Remotes"):WaitForChild("AdminAnnounce")
local u7 = v2:WaitForChild("NotificationFrame")
local function u12(p8) -- name: getGradients
	local v9 = {}
	for _, v10 in ipairs(p8:GetDescendants()) do
		if v10:IsA("UIGradient") then
			local v11 = {
				["obj"] = v10,
				["original"] = v10.Transparency
			}
			table.insert(v9, v11)
		end
	end
	return v9
end
local function u16(p13) -- name: getAllVisuals
	local v14 = {}
	for _, v15 in ipairs(p13:GetDescendants()) do
		if v15:IsA("UIStroke") then
			table.insert(v14, {
				["prop"] = "Transparency",
				["obj"] = v15
			})
		elseif v15:IsA("TextLabel") or v15:IsA("TextButton") then
			table.insert(v14, {
				["prop"] = "TextTransparency",
				["obj"] = v15
			})
			if v15.BackgroundTransparency < 1 then
				table.insert(v14, {
					["prop"] = "BackgroundTransparency",
					["obj"] = v15
				})
			end
		elseif v15:IsA("ImageLabel") or v15:IsA("ImageButton") then
			table.insert(v14, {
				["prop"] = "ImageTransparency",
				["obj"] = v15
			})
			if v15.BackgroundTransparency < 1 then
				table.insert(v14, {
					["prop"] = "BackgroundTransparency",
					["obj"] = v15
				})
			end
		elseif v15:IsA("Frame") and v15.BackgroundTransparency < 1 then
			table.insert(v14, {
				["prop"] = "BackgroundTransparency",
				["obj"] = v15
			})
		end
	end
	if p13:IsA("Frame") and p13.BackgroundTransparency < 1 then
		table.insert(v14, {
			["prop"] = "BackgroundTransparency",
			["obj"] = p13
		})
	end
	return v14
end
local function u43(p17, p18, u19, p20) -- name: showAnnouncement
	-- upvalues: (copy) u5, (copy) u7, (copy) u1, (copy) u16, (copy) u12, (copy) u4, (copy) u3
	local v21 = u5:FindFirstChild("AdminAnnounce")
	if v21 then
		v21 = v21:FindFirstChild("MainFrame")
	end
	if v21 then
		local u22 = u7:Clone()
		local v23 = u22:FindFirstChild("Avatar")
		if v23 and (v23:IsA("ImageLabel") and u19) then
			local v24, v25 = pcall(function()
				-- upvalues: (ref) u1, (copy) u19
				return u1:GetUserThumbnailAsync(u19, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			end)
			if v24 and v25 then
				v23.Image = v25
			end
		end
		local v26 = u22:FindFirstChild("Text")
		if v26 then
			v26.RichText = true
			local v27 = p18 or "Admin"
			if p20 then
				v27 = v27 .. "\238\128\128" or v27
			end
			v26.Text = "<font color=\"rgb(85,170,255)\"><b>" .. v27 .. "</b></font> : " .. p17
		end
		local u28 = u16(u22)
		local u29 = u12(u22)
		local v30 = {}
		for v31, v32 in ipairs(u28) do
			v30[v31] = v32.obj[v32.prop]
			v32.obj[v32.prop] = 1
		end
		local u33 = NumberSequence.new(1)
		for _, v34 in ipairs(u29) do
			v34.obj.Transparency = u33
		end
		u22.Parent = v21
		local v35 = Instance.new("Sound")
		v35.SoundId = "rbxassetid://98797174600699"
		v35.Volume = 0.4
		v35.Parent = u5
		v35:Play()
		u4:AddItem(v35, 5)
		local v36 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		for v37, v38 in ipairs(u28) do
			u3:Create(v38.obj, v36, {
				[v38.prop] = v30[v37]
			}):Play()
		end
		for _, v39 in ipairs(u29) do
			v39.obj.Transparency = v39.original
		end
		task.delay(10, function()
			-- upvalues: (copy) u28, (ref) u3, (copy) u29, (copy) u33, (copy) u22
			local v40 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			for _, v41 in ipairs(u28) do
				u3:Create(v41.obj, v40, {
					[v41.prop] = 1
				}):Play()
			end
			for _, v42 in ipairs(u29) do
				v42.obj.Transparency = u33
			end
			task.delay(0.5, function()
				-- upvalues: (ref) u22
				if u22 and u22.Parent then
					u22:Destroy()
				end
			end)
		end)
	else
		warn("[AdminAnnounce] AdminAnnounce/MainFrame introuvable dans PlayerGui")
	end
end
v6.OnClientEvent:Connect(function(p44)
	-- upvalues: (copy) u43
	if type(p44) == "table" and p44.text then
		u43(p44.text, p44.senderName, p44.senderUserId, p44.isOwner)
	end
end)