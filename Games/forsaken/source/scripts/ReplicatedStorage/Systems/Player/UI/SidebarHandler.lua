-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_2 = require(game.ReplicatedStorage.Modules.Util)
local v_u_3 = require(game.ReplicatedStorage.Modules.Misc.TableUtils)
local v_u_4 = TweenInfo.new(0.25)
local v_u_5 = {
	["SidebarMenus"] = {},
	["Sidebars"] = {
		["Sidebar"] = script.Sidebar,
		["Bottombar"] = script.Bottombar
	}
}
v_u_5.__index = v_u_5
function v_u_5.CreateSidebarMenu(p6, p7, p8, p9)
	-- upvalues: (copy) v_u_5
	local v10 = game.Players.LocalPlayer
	local v11 = v_u_5
	local v12 = setmetatable({}, v11)
	v12.Menu = p8:Clone()
	v12.Menu.Visible = false
	v12.Menu.Size = UDim2.fromScale()
	v12.Menu.Parent = v10.PlayerGui.MainUI
	v12.SidebarButton = v_u_5.Sidebars[p9 and "Bottombar" or "Sidebar"].Buttons:FindFirstChild(p7)
	local v13 = Instance.new("BindableEvent")
	v13.Parent = v12.Menu
	v12.Toggled = v13.Event
	v12.__toggleEvent = v13
	for _, v_u_14 in pairs(v12.Menu:GetDescendants()) do
		if v_u_14:IsA("ScrollingFrame") then
			v_u_14:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				-- upvalues: (copy) v_u_14
				v_u_14.ScrollBarThickness = v_u_14.AbsoluteSize.X / 44
			end)
		end
	end
	p6.SidebarMenus[p7] = v12
	return v12
end
function v_u_5.ToggleMenu(p15, p16)
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_4
	if v_u_5.TogglingMenus then
		return
	elseif v_u_5.MenusHidden and p15.SidebarButton then
		return
	elseif not (p16 and p15.Menu.Visible) then
		v_u_5.TogglingMenus = true
		v_u_1:Play("select")
		local v17 = p15.Menu.Visible
		local v18 = false
		for _, v_u_19 in pairs(v_u_5.SidebarMenus) do
			if v_u_19.Menu ~= p15.Menu or v17 then
				v18 = v_u_19.Menu ~= p15.Menu and v_u_19.Menu.Visible and true or v18
				if v_u_19.Menu.Visible then
					v_u_19.__toggleEvent:Fire(false)
					game.TweenService:Create(v_u_19.Menu, v_u_4, {
						["Size"] = UDim2.new(1, -20, 0, 0)
					}):Play()
					if v_u_19.SidebarButton then
						game.TweenService:Create(v_u_19.SidebarButton.Inverted, v_u_4, {
							["ImageTransparency"] = 1
						}):Play()
						game.TweenService:Create(v_u_19.SidebarButton.InvertedIcon, v_u_4, {
							["ImageTransparency"] = 1
						}):Play()
						game.TweenService:Create(v_u_19.SidebarButton.PulloutHolder.PulloutFrame.Inverted, v_u_4, {
							["ImageTransparency"] = 1
						}):Play()
						game.TweenService:Create(v_u_19.SidebarButton.PulloutHolder.PulloutFrame.Title, v_u_4, {
							["TextColor3"] = Color3.new(1, 1, 1)
						}):Play()
					end
					task.delay(0.25, function()
						-- upvalues: (copy) v_u_19
						v_u_19.Menu.Visible = false
					end)
				end
			end
		end
		task.delay(0.3 + (v18 and 0.125 or 0), function()
			-- upvalues: (ref) v_u_5
			v_u_5.TogglingMenus = nil
		end)
		if v18 then
			task.wait(0.125)
			if v_u_5.MenusHidden then
				return
			end
		end
		if not v17 then
			p15.__toggleEvent:Fire(true)
			p15.Menu.Visible = true
			game.TweenService:Create(p15.Menu, v_u_4, {
				["Size"] = UDim2.new(1, -20, 1, -20)
			}):Play()
			if p15.SidebarButton then
				game.TweenService:Create(p15.SidebarButton.Inverted, v_u_4, {
					["ImageTransparency"] = 0
				}):Play()
				game.TweenService:Create(p15.SidebarButton.InvertedIcon, v_u_4, {
					["ImageTransparency"] = 0
				}):Play()
				game.TweenService:Create(p15.SidebarButton.PulloutHolder.PulloutFrame.Inverted, v_u_4, {
					["ImageTransparency"] = 0
				}):Play()
				game.TweenService:Create(p15.SidebarButton.PulloutHolder.PulloutFrame.Title, v_u_4, {
					["TextColor3"] = Color3.new()
				}):Play()
			end
		end
	end
end
function v_u_5.ToggleSidebarButtons(_, p20)
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	v_u_5.MenusHidden = not p20
	for _, v21 in v_u_5.Sidebars do
		v21.Visible = p20
	end
	if not p20 then
		for _, v_u_22 in pairs(v_u_5.SidebarMenus) do
			game.TweenService:Create(v_u_22.Menu, v_u_4, {
				["Size"] = UDim2.new(1, -20, 0, 0)
			}):Play()
			if v_u_22.SidebarButton then
				game.TweenService:Create(v_u_22.SidebarButton.Inverted, v_u_4, {
					["ImageTransparency"] = 1
				}):Play()
				game.TweenService:Create(v_u_22.SidebarButton.InvertedIcon, v_u_4, {
					["ImageTransparency"] = 1
				}):Play()
				game.TweenService:Create(v_u_22.SidebarButton.PulloutHolder.PulloutFrame.Inverted, v_u_4, {
					["ImageTransparency"] = 1
				}):Play()
				game.TweenService:Create(v_u_22.SidebarButton.PulloutHolder.PulloutFrame.Title, v_u_4, {
					["TextColor3"] = Color3.new(1, 1, 1)
				}):Play()
			end
			task.delay(0.25, function()
				-- upvalues: (copy) v_u_22
				v_u_22.Menu.Visible = false
			end)
		end
	end
end
function v_u_5.Start(_)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_3, (copy) v_u_4, (copy) v_u_1
	local v23 = game.Players.LocalPlayer
	v23:FindFirstChild("PlayerData")
	v_u_5.Sidebars.Sidebar.Parent = v23.PlayerGui:WaitForChild("MainUI")
	v_u_5.Sidebars.Bottombar.Parent = v_u_5.Sidebars.Sidebar
	v_u_2:CreateMoneyDisplay(v_u_5.Sidebars.Sidebar.Money)
	for _, v_u_24 in pairs(v_u_3.Extend(v_u_5.Sidebars.Sidebar.Buttons:GetChildren(), v_u_5.Sidebars.Bottombar.Buttons:GetChildren())) do
		if v_u_24:IsA("Frame") then
			task.spawn(function()
				-- upvalues: (ref) v_u_5, (copy) v_u_24
				local v25 = tick()
				repeat
					task.wait()
				until v_u_5.SidebarMenus[v_u_24.Name] or tick() >= v25 + 10
				local v_u_26 = v_u_5.SidebarMenus[v_u_24.Name]
				if v_u_26 then
					v_u_24.Button.MouseButton1Click:Connect(function()
						-- upvalues: (copy) v_u_26
						v_u_26:ToggleMenu()
					end)
				end
			end)
			local v_u_27 = v_u_24.Parent.Parent.Name == "Bottombar"
			local v_u_28 = script[v_u_27 and "BottomPulloutHolder" or "PulloutHolder"]:Clone()
			local v29
			if v_u_27 then
				v29 = v_u_5.Sidebars.Bottombar.Pullouts or v_u_24
			else
				v29 = v_u_24
			end
			v_u_28.Parent = v29
			local v_u_30 = v_u_28.PulloutFrame
			v_u_30.Title.Text = v_u_24.Name
			v_u_24.MouseEnter:Connect(function()
				-- upvalues: (copy) v_u_24, (ref) v_u_4, (copy) v_u_27, (copy) v_u_28, (copy) v_u_30, (ref) v_u_1
				if v_u_24.Button.ImageTransparency <= 0.1 then
					game.TweenService:Create(v_u_24, v_u_4, {
						["Size"] = UDim2.fromScale(1.05, v_u_27 and 1.15 or 0.25)
					}):Play()
					if v_u_27 then
						game.TweenService:Create(v_u_28, v_u_4, {
							["Position"] = UDim2.fromScale(0.65, 0.85),
							["Size"] = UDim2.fromScale(0.35, 0.75)
						}):Play()
						game.TweenService:Create(v_u_30.Display, v_u_4, {
							["ImageTransparency"] = 0
						}):Play()
						game.TweenService:Create(v_u_30.Title, v_u_4, {
							["TextTransparency"] = 0
						}):Play()
					else
						game.TweenService:Create(v_u_30, v_u_4, {
							["Position"] = UDim2.new(0.225, v_u_30.Title.AbsoluteSize.X ^ 1.03, 0.5, 0)
						}):Play()
					end
					v_u_1:Play("hover")
				end
			end)
			v_u_24.MouseLeave:Connect(function()
				-- upvalues: (copy) v_u_24, (ref) v_u_4, (copy) v_u_27, (copy) v_u_28, (copy) v_u_30, (ref) v_u_1
				game.TweenService:Create(v_u_24, v_u_4, {
					["Size"] = UDim2.fromScale(1, v_u_27 and 1 or 0.2)
				}):Play()
				if v_u_27 then
					game.TweenService:Create(v_u_28, v_u_4, {
						["Position"] = UDim2.fromScale(0.65, 1),
						["Size"] = UDim2.fromScale(0.15, 0.45)
					}):Play()
					game.TweenService:Create(v_u_30.Display, v_u_4, {
						["ImageTransparency"] = 1
					}):Play()
					game.TweenService:Create(v_u_30.Title, v_u_4, {
						["TextTransparency"] = 1
					}):Play()
				else
					game.TweenService:Create(v_u_30, v_u_4, {
						["Position"] = UDim2.fromScale(0, 0.5)
					}):Play()
				end
				if v_u_24.Button.ImageTransparency <= 0.1 then
					v_u_1:Play("hoverEnd")
				end
			end)
		end
	end
end
return v_u_5
