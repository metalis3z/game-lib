

local v1 = {}
local u2 = _G.HDAdminMain
local u3 = u2.gui.Notices
local u4 = u3.Template
local u5 = true
local u6 = {}
local u7 = {}
local u8 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u9 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u10 = TweenInfo.new(0.625, Enum.EasingStyle.Back, Enum.EasingDirection.In)
local function u15(_) 

	for v11, v12 in pairs(u7) do
		if not v12.Complete.Value then
			local v13 = u8
			local v14
			if v11 == 1 then
				v14 = u4.Position + UDim2.new(0, -v12.Size.X.Offset, 0, 0)
			else
				local _ = u7[v11 - 1]
				v14 = UDim2.new(v12.Position.X.Scale, v12.Position.X.Offset, v12.Position.Y.Scale, u4.Position.Y.Offset - (v11 - 1) * (u4.Size.Y.Offset * 1.07))
			end
			if v14.Y.Offset > v12.Position.Y.Offset then
				v13 = u9
			end
			if v14 then
				u2.tweenService:Create(v12, v13, {
					["Position"] = v14
				}):Play()
			end
		end
	end
end
local function u20(p16) 

	if p16:FindFirstChild("Complete") and not p16.Complete.Value then
		p16.Complete.Value = true
		for v17, v18 in pairs(u7) do
			if v18 == p16 then
				table.remove(u7, v17)
				local v19 = u2.tweenService:Create(p16, u10, {
					["Position"] = p16.Position + UDim2.new(0, p16.Size.X.Offset - 0, 0, 0)
				})
				v19:Play()
				v19.Completed:Wait()
				p16:Destroy()
			end
		end
	end
	u15()
end
local function u28() 

	if u5 then
		u5 = false
		while true do
			wait()
			if #u6 > 0 then
				local u21 = u6[1]
				local v22 = u21:GetAttribute("CustomAudio")
				u21.Parent = u3
				if v22 then
					u2.audio[v22]:Play()
				elseif u21.NoticeType.Value == "Error" then
					u2.audio.Error:Play()
				else
					u2.audio.Notice:Play()
				end
				local v23 = u7
				table.insert(v23, 1, u21)
				if u21.Countdown.Value < 900 then
					spawn(function()

						if u21.Countdown.Value > 0 then
							local v24 = os.time()
							repeat
								wait()
							until os.time() ~= v24
							local v25 = u21.Desc.Text
							for v26 = 1, u21.Countdown.Value do
								if not u21:FindFirstChild("Desc") or u21.Desc.Text == "Teleporting..." then
									break
								end
								u21.Desc.Text = v25 .. " (" .. u21.Countdown.Value + 1 - v26 .. ")"
								wait(1)
							end
						else
							local v27 = tick()
							repeat
								wait(0.1)
							until tick() - v27 >= 7
						end
						u20(u21)
					end)
				end
				u15(true)
				wait(0.5)
				table.remove(u6, 1)
			end
			if #u6 < 1 then
				u5 = true
				goto l2
			end
		end
	else
		::l2::
		return
	end
end
function v1.Notice(_, u29, u30, u31, u32) 

	if not (u2.pdata and u2.pdata.SetupData) then
		repeat
			wait(0.1)
		until u2.pdata and u2.pdata.SetupData
	end
	if u2.settings.DisableAllNotices ~= true then
		task.defer(function()

			local v33 = u2.gui:FindFirstChild("MainFrame")
			if v33 then
				local v34 = v33.AbsoluteSize.X * 0.75
				local v35 = u4.AbsoluteSize
				local v36 = v34 * (v35.Y / v35.X)
				local v37 = v36 / 6
				u4.Position = UDim2.new(1, 0, 1, -v36)
				u4.Size = UDim2.new(0, v34, 0, v36)
				u4.Title.TextSize = v37
				u4.Desc.UITextSizeConstraint.MaxTextSize = v37
				u4.Desc.TextSize = v37
				local u38 = u4:Clone()
				u38.Visible = true
				u38.Title.Text = u30
				u38.Desc.Text = u31
				u38.NoticeType.Value = u29
				local v39 = u32
				if type(v39) == "table" then
					local u40 = true
					local v41 = u32[1]
					if v41 == "ShowSpecificPage" then
						u38.Countdown.Value = 20
						u38.TextButton.MouseButton1Down:Connect(function()

							local v42
							if u40 then
								u40 = false
								v42 = true
							else
								v42 = nil
							end
							if v42 then
								u2:GetModule("GUIs"):ShowSpecificPage(u32[2], u32[3])
								u20(u38)
							end
						end)
					elseif v41 == "OpenCommands" then
						local u43 = u32[2]
						u38.TextButton.MouseButton1Down:Connect(function()

							u2:GetModule("GUIs"):ShowSpecificPage("Commands", "Commands", true)
							u2:GetModule("PageCommands"):SetSearchText(u43)
							u20(u38)
						end)
					elseif v41 == "Teleport" then
						u38.Countdown.Value = 25
						u38.TextButton.MouseButton1Down:Connect(function()

							local v44
							if u40 then
								u40 = false
								v44 = true
							else
								v44 = nil
							end
							if v44 then
								u2.teleportService:Teleport(u32[2])
								u38.Desc.Text = "Teleporting..."
							end
						end)
					elseif v41 == "PM" then
						u38.Countdown.Value = 999
						u38.TextButton.MouseButton1Down:Connect(function()

							local v45
							if u40 then
								u40 = false
								v45 = true
							else
								v45 = nil
							end
							if v45 then
								u2:GetModule("cf"):CreateNewCommandMenu("privateMessage", { u32[2], u32[3] }, 4)
								u20(u38)
							end
						end)
					elseif v41 == "CallFunctionOnClick" then
						local u46 = u32[2]
						if u46 then
							u38.TextButton.MouseButton1Down:Connect(function()

								local v47
								if u40 then
									u40 = false
									v47 = true
								else
									v47 = nil
								end
								if v47 then
									u46()
									u20(u38)
								end
							end)
						end
					elseif v41 == "CallFunctionSpecialOnClick" then
						local u48 = u32[2]
						u38:SetAttribute("CustomAudio", "Prompt")
						if u48 then
							u38.Countdown.Value = 60
							u38.TextButton.MouseButton1Down:Connect(function()

								local v49
								if u40 then
									u40 = false
									v49 = true
								else
									v49 = nil
								end
								if v49 then
									u48()
									u20(u38)
								end
							end)
						end
					elseif v41 == "CallFunctionWithTime" then
						local v50 = u32[2]
						local u51 = u32[3]
						u38:SetAttribute("CustomAudio", "Prompt")
						u38.Countdown.Value = v50
						if u51 then
							u38.TextButton.MouseButton1Down:Connect(function()

								local v52
								if u40 then
									u40 = false
									v52 = true
								else
									v52 = nil
								end
								if v52 then
									u51()
									u20(u38)
								end
							end)
						end
					end
				end
				u38.CloseX.MouseButton1Down:Connect(function()

					u20(u38)
				end)
				local v53 = u6
				table.insert(v53, u38)
				u28()
			end
		end)
	end
end
return v1