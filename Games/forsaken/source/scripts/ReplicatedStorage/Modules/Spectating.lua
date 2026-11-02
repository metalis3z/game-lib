-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.Modules.Sounds)
require(v3.Initializer)
local v_u_5 = require(v3.Modules.Network)
local v_u_6 = require(v3.Systems.Player.UI.SidebarHandler)
local v_u_7 = TweenInfo.new(0.25)
local v_u_49 = {
	["CurrentIndx"] = 1,
	["CurrentHumanoid"] = nil,
	["Spectating"] = false,
	["Connections"] = {
		["HealthConnection"] = nil,
		["DeathConnection"] = nil
	},
}
v_u_49["Toggle"] = function(_, p8)
	-- upvalues: (copy) v_u_6, (copy) v_u_49, (copy) v_u_2, (copy) v_u_1, (copy) v_u_7
	workspace:FindFirstChild("Ragdolls")
	local v9 = game.Players.LocalPlayer
	local v10 = v9.Character
	if v10 then
		v10 = v10:FindFirstChild("Humanoid")
	end
	local v11 = v_u_6.Sidebars.Sidebar.Buttons.Spectate
	if v10 then
		if v9.Character.Parent ~= workspace.Players.Spectating then
			p8 = false
		end
		if not p8 then
			for v_u_12, v_u_13 in v_u_49.Connections do
				pcall(function()
					-- upvalues: (copy) v_u_13, (ref) v_u_2, (copy) v_u_12
					v_u_13:Disconnect()
					if v_u_2:IsStudio() then
						print((("[%*]: Removed event: %* from Spectating."):format(script, v_u_12)))
					end
				end)
				v_u_49.Connections[v_u_12] = nil
			end
		end
		v_u_49.UI.Visible = p8
		workspace.CurrentCamera.CameraSubject = v10
		v_u_1:Create(v11.Inverted, v_u_7, {
			["ImageTransparency"] = p8 and 0 or 1
		}):Play()
		v_u_1:Create(v11.InvertedIcon, v_u_7, {
			["ImageTransparency"] = p8 and 0 or 1
		}):Play()
		v_u_1:Create(v11.PulloutHolder.PulloutFrame.Inverted, v_u_7, {
			["ImageTransparency"] = p8 and 0 or 1
		}):Play()
		v_u_1:Create(v11.PulloutHolder.PulloutFrame.Title, v_u_7, {
			["TextColor3"] = p8 and Color3.new() or Color3.new(1, 1, 1)
		}):Play()
		v_u_49.Spectating = p8
	end
end
v_u_49["Start"] = function(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_49, (copy) v_u_5, (copy) v_u_4, (copy) v_u_1, (copy) v_u_7, (copy) v_u_6
	if v_u_2:IsClient() then
		local v_u_14 = game.Players.LocalPlayer
		v_u_49.UI = script.Spectate:Clone()
		v_u_49.UI.Visible = false
		v_u_49.UI.Parent = v_u_14.PlayerGui:WaitForChild("MainUI")
		local function v18(p15)
			-- upvalues: (ref) v_u_5
			local v_u_16 = { "Name", "DisplayName", "UserId" }
			p15.Changed:Connect(function(p17)
				-- upvalues: (copy) v_u_16, (ref) v_u_5
				if table.find(v_u_16, p17) then
					v_u_5:FireServerConnection("UpdateHeartbeatAsync", "REMOTE_EVENT", 53643)
				end
			end)
		end
		local function v_u_41(p19)
			-- upvalues: (copy) v_u_14, (ref) v_u_49, (copy) v_u_41
			if v_u_14.Character.Parent == workspace.Players.Spectating then
				local v20 = v_u_49
				v20.CurrentIndx = v20.CurrentIndx + p19
				local function v26(p_u_21)
					-- upvalues: (ref) v_u_49, (ref) v_u_41
					pcall(function()
						-- upvalues: (ref) v_u_49
						v_u_49.Connections.HealthConnection:Disconnect()
					end)
					pcall(function()
						-- upvalues: (ref) v_u_49
						v_u_49.Connections.DeathConnection:Disconnect()
					end)
					pcall(function()
						-- upvalues: (ref) v_u_49
						v_u_49.Connections.GoneConnection:Disconnect()
					end)
					local _ = p_u_21.Parent
					if p_u_21.Health > 0 then
						v_u_49.Connections.DeathConnection = p_u_21.Died:Once(function()
							-- upvalues: (ref) v_u_49, (copy) p_u_21, (ref) v_u_41
							task.delay(3, function()
								-- upvalues: (ref) v_u_49, (ref) p_u_21, (ref) v_u_41
								if v_u_49.CurrentHumanoid == p_u_21 and v_u_49.UI.Visible then
									v_u_41(1)
								end
							end)
						end)
						v_u_49.Connections.GoneConnection = p_u_21.AncestryChanged:Once(function(_, _)
							-- upvalues: (ref) v_u_41
							v_u_41(1)
						end)
					end
					v_u_49.Connections.HealthConnection = p_u_21:GetPropertyChangedSignal("Health"):Connect(function()
						-- upvalues: (copy) p_u_21, (ref) v_u_49
						local v22 = p_u_21
						if v22 then
							local v23 = v22.Health / v22.MaxHealth
							local v24 = v_u_49.UI.Health
							local v25 = v23 * 100
							v24.Text = ("%*%%"):format((math.round(v25)))
							v_u_49.UI.Health.TextColor3 = Color3.fromHSV(v23 / 3, 1, 1)
						end
					end)
				end
				local v27 = {}
				for _, v28 in pairs(workspace.Players.Killers:GetChildren()) do
					local v29 = v28:FindFirstChild("Humanoid")
					if v29 and (v29.Parent and v29.Health > 0) then
						table.insert(v27, v28)
					end
				end
				for _, v30 in pairs(workspace.Players.Survivors:GetChildren()) do
					local v31 = v30:FindFirstChild("Humanoid")
					if v31 and (v31.Parent and v31.Health > 0) then
						table.insert(v27, v30)
					end
				end
				local v32 = v27[v_u_49.CurrentIndx % #v27 + 1]
				local v33
				if v32 then
					v33 = v32:FindFirstChild("Humanoid")
				else
					v33 = v32
				end
				if v33 then
					v_u_49.CurrentHumanoid = v33
					local v34 = v32:GetAttribute("Username") or v32.Name
					local v35 = v32:GetAttribute("ActorDisplayName") or v32.Name
					local v36 = v32:GetAttribute("SkinNameDisplay")
					local v37 = ("%* %*"):format(v35, (v36 == nil or v36 == "") and "" or (("(%*)"):format(v36) or ""))
					v_u_49.UI.Username.Text = v34
					v_u_49.UI.ActorName.Text = v37
					if v_u_49.UI.Visible then
						workspace.CurrentCamera.CameraSubject = v33
					end
					if v33 then
						local v38 = v33.Health / v33.MaxHealth
						local v39 = v_u_49.UI.Health
						local v40 = v38 * 100
						v39.Text = ("%*%%"):format((math.round(v40)))
						v_u_49.UI.Health.TextColor3 = Color3.fromHSV(v38 / 3, 1, 1)
					end
					v26(v33)
				end
			end
		end
		for v_u_42, v_u_43 in { v_u_49.UI.Next, v_u_49.UI.Back } do
			v_u_43.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_4, (copy) v_u_41, (copy) v_u_42
				v_u_4:Play("click")
				v_u_41(v_u_42 == 1 and 1 or -1)
			end)
			v_u_43.MouseEnter:Connect(function()
				-- upvalues: (ref) v_u_4, (ref) v_u_1, (copy) v_u_43, (ref) v_u_7
				v_u_4:Play("tick")
				v_u_1:Create(v_u_43, v_u_7, {
					["Size"] = UDim2.fromScale(0.25, 1.05)
				}):Play()
			end)
			v_u_43.MouseLeave:Connect(function()
				-- upvalues: (ref) v_u_4, (ref) v_u_1, (copy) v_u_43, (ref) v_u_7
				v_u_4:Play("tick")
				v_u_1:Create(v_u_43, v_u_7, {
					["Size"] = UDim2.fromScale(0.2, 1)
				}):Play()
			end)
		end
		v_u_6.Sidebars.Sidebar.Buttons.Spectate.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_6, (ref) v_u_4, (ref) v_u_49, (copy) v_u_41
			if not v_u_6.MenusHidden then
				v_u_4:Play("select")
				v_u_49:Toggle(not v_u_49.Spectating)
				if not v_u_49.Spectating == false then
					v_u_41(0)
				end
			end
		end)
		v_u_49.UI.Username.Changed:Connect(function(p44)
			-- upvalues: (ref) v_u_49, (ref) v_u_5
			if p44 == "Text" then
				local v45 = v_u_49.UI.Username.Text
				local v46 = v_u_49.CurrentHumanoid
				if v46 then
					v46 = v_u_49.CurrentHumanoid.Parent
				end
				local v47
				if v46 then
					v47 = v46:GetAttribute("Username")
				else
					v47 = v46
				end
				local v48
				if v46 then
					v48 = game.Players:GetPlayerFromCharacter(v46)
				else
					v48 = v46
				end
				if v46 then
					if v48 and v47 then
						if v47 ~= v45 then
							v_u_5:FireServerConnection("UpdateHeartbeatAsync", "REMOTE_EVENT", 53643)
							return
						end
					elseif v48 and not v47 then
						v_u_5:FireServerConnection("UpdateHeartbeatAsync", "REMOTE_EVENT", 53643)
					end
				end
			else
				return
			end
		end)
		game.Players.PlayerAdded:Connect(v18)
	end
end
return v_u_49
