

local u1 = _G.HDAdminMain
local u2 = {
	["custom"] = u1.gui.MainFrame.Pages.Settings.Custom
}
local u3 = u1.settings.AppThemes
local v4 = 6.1 / #u3
local u5 = u2.custom["AB ThemeSelection"]
local u6 = true
local function u22(p7, p8) 

	if p7 == nil then
		for _, v9 in pairs(u3) do
			if v9[1] == u1.pdata.AppTheme then
				p7 = v9[1]
				p8 = v9[2]
				break
			end
		end
	end
	if p7 then
		local v10 = {}
		for _, v11 in pairs(u1.gui:GetDescendants()) do
			if v11:IsA("BoolValue") and v11.Name == "Theme" then
				local v12 = v11.Parent
				table.insert(v10, v12)
			end
		end
		for _, v13 in pairs(v10) do
			local v14
			if v13.Theme.Value then
				local v15, v16, v17 = Color3.toHSV(p8)
				v14 = Color3.fromHSV(v15, v16, v17 * 1.35)
			else
				v14 = p8
			end
			if v13:IsA("TextLabel") then
				local v18, v19, v20 = Color3.toHSV(p8)
				v14 = Color3.fromHSV(v18, v19, v20 * 2)
				v13.TextColor3 = v14
			else
				v13.BackgroundColor3 = v14
			end
			if v13:IsA("ImageButton") or v13:IsA("ImageLabel") then
				v13.ImageColor3 = v14
			end
		end
		for _, v21 in pairs(u5:GetChildren()) do
			if v21:IsA("TextButton") then
				if v21.Name == p7 then
					v21.BorderSizePixel = 1
				else
					v21.BorderSizePixel = 0
				end
			end
		end
	end
end
local v23 = {}
for _, v24 in pairs(u3) do
	local u25 = v24[1]
	local u26 = v24[2]
	local v27 = u5.ThemeTemplate:Clone()
	v27.Name = u25
	v27.UIAspectRatioConstraint.AspectRatio = v4
	v27.BackgroundColor3 = u26
	v27.MouseButton1Down:Connect(function()

		if u6 then
			u6 = false
			local v28 = { "AppTheme", u25 }
			u1.signals.ChangeSetting:InvokeServer(v28)
			u22(u25, u26)
			u6 = true
		end
	end)
	v27.Visible = true
	v27.Parent = u5
end
local function u37() 

	for _, v29 in pairs(u2.custom:GetChildren()) do
		local v30 = v29.Name
		local v31 = string.sub(v30, 5)
		if v29:FindFirstChild("SettingValue") then
			v29.SettingName.TextLabel.Text = v31 .. ":"
			local v32 = u1.pdata[v31]
			v29.SettingValue.TextBox.Text = tostring(v32)
			local v33 = nil
			local v34 = nil
			if string.sub(v31, 1, 5) == "Error" then
				v33 = "Error"
				v34 = 6
			elseif string.sub(v31, 1, 6) == "Notice" then
				v33 = "Notice"
				v34 = 7
			end
			if v33 then
				local v35 = u1.audio[v33]
				local v36 = string.sub(v31, v34)
				if v36 == "SoundId" then
					v32 = "rbxassetid://" .. v32
				end
				v35[v36] = v32
			end
		end
	end
	u22()
end
for _, u38 in pairs(u2.custom:GetChildren()) do
	local v39 = u38.Name
	local u40 = string.sub(v39, 5)
	if u38:FindFirstChild("SettingValue") then
		local u41 = true
		local u42 = u38.SettingValue.TextBox
		local u43 = u38.SettingValue.TextLabel
		u38.SettingValue.TextBox.FocusLost:connect(function(_)

			if u41 then
				local v44 = u38.SettingValue.TextBox.Text
				u41 = false
				u42.Visible = false
				u43.Visible = true
				u43.Text = "Loading..."
				local v45 = { u40, v44 }
				local v46 = u1.signals.ChangeSetting:InvokeServer(v45)
				task.wait(0.1)
				if v46 == "Success" then
					u37()
					local v47 = u40
					local v48 = string.sub(v47, 1, 5)
					local v49 = v48 ~= "Error" and v48 ~= "Alert" and "Notice" or v48
					if u40 == "Prefix" then
						u1:GetModule("PageCommands"):CreateCommands()
					end
					local v50 = "Successfully changed \'" .. u40 .. "\' to \'" .. v44 .. "\'"
					if v49 == "Alert" then
						u1:GetModule("cf"):CreateNewCommandMenu("settings", { "Settings Alert", v50 }, 8, true)
					else
						u1:GetModule("Notices"):Notice(v49, "Settings", v50)
					end
				else
					u43.Text = v46
					wait(1)
				end
				u42.Visible = true
				u43.Visible = false
				local v51 = u38.SettingValue.TextBox
				local v52 = u1.pdata[u40]
				v51.Text = tostring(v52)
				u41 = true
			end
		end)
	end
end
u37()
local u53 = u2.custom["AX Restore"]
local u54 = u53.Loading
local u55 = 0
u53.MouseButton1Down:Connect(function()

	if u55 < 2 then
		local v56, v57, v58 = Color3.toHSV(u53.BackgroundColor3)
		u54.BackgroundColor3 = Color3.fromHSV(v56, v57, v58 * 0.5)
		u54.Visible = true
		if u55 == 0 then
			u55 = 1
			u54.Blocker.Visible = false
			u54.TextLabel.Text = "Confirm?"
			wait(1)
		elseif u55 == 1 then
			u55 = 2
			u54.Blocker.Visible = true
			u54.TextLabel.Text = "Loading..."
			local v59 = u1.signals.RestoreDefaultSettings:InvokeServer()
			if v59 == "Success" then
				u37()
				u1:GetModule("PageCommands"):CreateCommands()
				local v60 = u1:GetModule("cf"):FormatNotice("RestoreDefaultSettings")
				u1:GetModule("Notices"):Notice("Notice", v60[1], v60[2])
			else
				u53.TextLabel.Text = v59
			end
			wait(1)
		end
		u55 = 0
		u54.Visible = false
		u54.Blocker.Visible = false
	end
end)
local v61 = u2.custom["AA Space"]
local v62 = u2.custom["AZ Space"]
u2.custom.CanvasSize = UDim2.new(0, 0, 0, v62.AbsolutePosition.Y - v61.AbsolutePosition.Y + v62.AbsoluteSize.Y * 1)
return v23