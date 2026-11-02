

local v1 = {}
local u2 = _G.HDAdminMain
local v3 = u2.loadModule
local u4 = v3("cf")
local u5 = v3("Credits")
local u6 = v3("Updates")
local v7 = u2.gui.MainFrame.Pages
local u8 = v7.About
local _ = u8.Info
local u9 = u8.Updates
local u10 = u8.Credits
local u11 = u8.Soon.Info
local u12 = v7.Home.About.Notice
task.defer(function()

	local v13 = u2:GetModule("VERSION")
	local v14 = v13.getAppVersion()
	local v15 = v13.getLatestVersion()
	local v16 = v13.isUpToDate()
	local v17 = u2.pdata.LastCheckedVersion
	local v18 = u2:GetModule("cf"):WaitForLoadedRank()
	local v19 = v17 == v15
	local v20
	if v16 then
		v20 = ("\226\156\133  <b>%*</b> - Your HD Admin is up-to-date!"):format(v14)
	else
		v20 = ("\226\154\160\239\184\143  <b>%*</b> - Your HD Admin requires updating"):format(v14)
	end
	local v21
	if v16 then
		v21 = Color3.fromRGB(85, 255, 127)
	else
		v21 = Color3.fromRGB(255, 83, 83)
	end
	local v22 = u11.VersionInfo
	local v23 = u2:GetModule("TopbarIcons").Dashboard
	v22.TextLabel.Text = v20
	v22.BackgroundColor3 = v21
	v22.UIStroke.Color = v21
	if not v19 and (v18 and (v18 >= 1 and (u2.userInputService.KeyboardEnabled and v23))) then
		local u24 = u2:GetModule("Signal").new()
		v23:notify(u24)
		u12.Visible = true
		u8:GetPropertyChangedSignal("Visible"):Once(function()

			u24:Fire()
			u12.Visible = false
			u2.signals.UpdateSavedVersion:FireServer()
		end)
	end
	if not v16 and v18 == 5 then
		task.delay(2, function()

			local v25 = { "CallFunctionOnClick", function()

					u2:GetModule("GUIs"):ShowSpecificPage("About", "Soon")
				end }
			u2:GetModule("Notices"):Notice("Notice", u2.hdAdminCoreName, "A new version of HD Admin is available. Enable AutoUpdate to benefit from the latest changes.", v25)
		end)
	end
end)
function v1.UpdateRankName(_) 
 end
function v1.UpdateProfileIcon(_) 
 end
local u26 = u9.Template
u26.Visible = false
function v1.CreateUpdates(_) 

	u4:ClearPage(u9)
	local v27 = 0
	for _, v28 in pairs(u6) do
		v27 = v27 + #v28
		local v29 = 0
		for v30, v31 in pairs(v28) do
			local v32 = u26:Clone()
			if v30 == 1 then
				v29 = v31[1]
				v32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v32.TextLabel.Text = v31[2]
				v32.BackgroundTransparency = 0.93
			else
				v32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v32.BackgroundTransparency = 1
				if v30 % 2 == 0 then
					v32.BackgroundTransparency = v32.BackgroundTransparency - 0.01
				end
				v32.TextLabel.Text = v31[1]
				if os.time() - 907200 < v29 then
					v32.New.Visible = true
					v32.TextLabel.Position = UDim2.new(0.16, 0, 0.15, 0)
					v32.TextLabel.Size = UDim2.new(0.8, 0, 0.7, 0)
				end
			end
			v32.Visible = true
			v32.Parent = u9
		end
	end
	u9.CanvasSize = UDim2.new(0, 0, 0, v27 * u26.AbsoluteSize.Y)
end
local u33 = u10.Template
u33.Visible = false
function v1.UpdateContributors(_) 

	local v34 = {}
	for v35, v36 in pairs(u2.infoOnAllCommands.Contributors) do
		table.insert(v34, { v35, v36 })
	end
	table.sort(v34, function(p37, p38)
		return p37[2] > p38[2]
	end)
	for _, v39 in pairs(v34) do
		local v40 = {
			v39[1],
			{ "Commands: " .. v39[2] }
		}
		local v41 = u5[3]
		table.insert(v41, v40)
	end
end
function v1.CreateCredits(_) 

	u4:ClearPage(u10)
	local v42 = 0
	for _, v43 in pairs(u5) do
		local v44 = 6
		for v45, v46 in pairs(v43) do
			local v47
			if v45 == 1 then
				v47 = u26:Clone()
				v44 = v46[1]
				v47.BackgroundTransparency = 0.93
				v47.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v47.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				v47.TextLabel.Text = v46[2]
				v47.Parent = u10
			else
				v47 = u33:Clone()
				v47.Parent = u10
				v47.UIAspectRatioConstraint.AspectRatio = v44
				v47.BackgroundTransparency = 1
				if v45 % 2 == 0 then
					v47.BackgroundTransparency = v47.BackgroundTransparency - 0.01
				end
				v47.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v47.PlrName.Text = v46[1]
				v47.PlayerImage.Image = u4:GetUserImage(u4:GetUserId(v46[1]))
				local v48 = v47.PlayerImage.AbsoluteSize.Y
				v47.PlayerImage.Size = UDim2.new(0, v48, 1, 0)
				for v49 = 1, 3 do
					local v50 = v47:FindFirstChild("Desc" .. v49)
					if v50 then
						local v51 = v46[2][v49]
						if v51 then
							v50.Text = v51
						else
							v50.Text = ""
						end
						local v52 = v48 * 1.15
						local v53, v54, v55
						if v44 <= 5 then
							v53 = (v49 - 1) * 0.25 + 0.33
							v54 = 0.255
							v55 = 0.31
						else
							v53 = (v49 - 1) * 0.25 + 0.36
							v54 = 0.26
							v55 = 0.32
						end
						v50.Position = UDim2.new(0, v52, v53, 0)
						v50.Size = UDim2.new(0.75, 0, v54, 0)
						v47.PlrName.Position = UDim2.new(0, v52, v47.PlrName.Position.Y.Scale, v47.PlrName.Position.Y.Offset)
						v47.PlrName.Size = UDim2.new(0.75, 0, v55, 0)
					end
				end
			end
			v47.Name = "Label"
			v47.Visible = true
			v42 = v42 + v47.AbsoluteSize.Y
		end
	end
	u10.CanvasSize = UDim2.new(0, 0, 0, v42)
end
return v1