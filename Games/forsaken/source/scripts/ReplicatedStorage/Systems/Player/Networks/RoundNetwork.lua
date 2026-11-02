-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_122 = {}
v_u_122["Start"] = function(_)
	-- upvalues: (copy) v_u_122
	local v_u_1 = require(game.ReplicatedStorage.Modules.Util)
	local v_u_2 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	local v3 = require(game.ReplicatedStorage.Modules.Network)
	local v_u_4 = game.ReplicatedStorage.Modules.Gamemodes
	local v_u_5 = game.Players.LocalPlayer
	local v_u_6 = workspace.CurrentCamera
	v3:SetConnection("PreHandleGamemode", "REMOTE_EVENT", function(p7)
		-- upvalues: (copy) v_u_1
		if p7 == "Init" then
			v_u_1:FadeIn({
				["Time"] = 0.25
			})
		end
	end)
	v3:SetConnection("HandleGamemode", "REMOTE_EVENT", function(p8, ...)
		-- upvalues: (copy) v_u_4, (ref) v_u_122
		if p8 == "Init" then
			local v9, v10 = unpack({ ... })
			v_u_122.CurrentSession = require(v_u_4[v9]).Init(v10)
		elseif v_u_122.CurrentSession then
			if p8 == "Destroy" then
				v_u_122.CurrentSession:Destroy(...)
				v_u_122.CurrentSession = nil
				return
			end
		else
			warn((("[%*]: Couldn\'t do anything with the information (%*) passed to client!"):format(script, (tostring(p8)))))
		end
	end)
	v3:SetConnection("ReplicateMapCreation", "REMOTE_EVENT", function(p11)
		local v_u_12 = require(p11)
		local v_u_13 = {
			["Map"] = p11.Parent,
			["Config"] = v_u_12
		}
		if v_u_12.ClientCreated then
			local v14, v15 = pcall(function()
				-- upvalues: (copy) v_u_12, (copy) v_u_13
				return v_u_12.ClientCreated(v_u_13)
			end)
			if not v14 then
				warn((("[%*/ReplicateMapCreation]: There was an issue with calling .ClientCreated() on %* due to: %*"):format(script, p11.Parent.Name, v15)))
			end
		end
	end)
	v3:SetConnection("LastSurvivor", "REMOTE_EVENT", function(_)
		-- upvalues: (copy) v_u_1
		v_u_1:ToggleResetButton(false)
	end)
	v3:SetConnection("PlayWinnerCutscene", "REMOTE_EVENT", function(p_u_16, p_u_17)
		-- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_2, (copy) v_u_6
		local v_u_18 = {}
		v_u_1:FadeIn({
			["Time"] = 0.5
		})
		task.wait(0.75)
		v_u_5.PlayerGui.MainUI.Enabled = false
		v_u_5.PlayerGui.TemporaryUI.Enabled = false
		local v19 = 3
		local v_u_20 = nil
		if p_u_16 == "Killers" then
			local v_u_21 = p_u_17[1]
			local v22 = v_u_21 and v_u_21.Config
			if v22 then
				v22 = v_u_21.Config.Animations.Victory
			end
			if v22 then
				v_u_2.isInCutscene = true
				local v23, v24, v25 = require(game.ReplicatedStorage.Modules.Actors):CreateCutsceneActor(v_u_21, "Victory")
				local v26 = v25.CameraRig.Length
				v19 = v_u_21.Config.ForcedOutroTime or v26
				table.insert(v_u_18, v23)
				table.insert(v_u_18, v24)
				task.spawn(function()
					-- upvalues: (ref) v_u_2
					local v27 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5)
					if v27 then
						v27 = v27:WaitForChild("Lighting", 5)
					end
					if v27 then
						v_u_2:SetCustomLighting(v27)
					end
				end)
				task.spawn(function()
					-- upvalues: (copy) v_u_21
					local v28 = require(game.ReplicatedStorage.Modules.Sounds)
					v28:Play(v_u_21.Config.Sounds.Victory)
					local v29 = v_u_21.Config.Sounds.VictoryTheme
					local v30 = typeof(v29) == "table"
					if v29 then
						if game["Run Service"]:IsStudio() then
							print((("[%*]: Playing new victory theme for: %*"):format(script, v_u_21)))
						end
						local v31
						if v30 then
							v31 = v29.ID or v29
						else
							v31 = v29
						end
						v28:PlayTheme(v31, v30 and v29.Properties or {
							["Priority"] = 20,
							["Looped"] = false,
							["TweenTime"] = 0.05
						}):SetAttribute("DeloadOnDeath", true)
					end
					v28:PlayVoiceline(v_u_21, "Victory", {
						["Priority"] = 10,
						["Parent"] = workspace:FindFirstChild("Sounds") or workspace.Misc
					})
				end)
				if not v_u_21.Cache then
					v_u_21.Cache = {}
				end
				v_u_21.Cache.VictoryKillerTrack = v25.KillerRig
				v_u_21.Cache.VictoryCameraTrack = v25.CameraRig
				v_u_20 = v_u_21.SkinFolder and (v_u_21.SkinFolder:FindFirstChild("Behavior") and require(v_u_21.SkinFolder.Behavior).OnVictory) and require(v_u_21.SkinFolder.Behavior) or require(v_u_21.Folder.Behavior)
				if v_u_20.OnVictory then
					v_u_20:OnVictory("Start", v_u_21, v23, v26)
				end
			end
		elseif p_u_16 == "Survivors" then
			--if workspace:GetAttribute("Testing") then
			--	return
			--end
			local v_u_32 = workspace:GetAttribute("Testing") and workspace.StudioAssets.SurvivorWinArea or workspace.Map.Lobby.SurvivorWinArea
			local v_u_33 = require(game.ReplicatedStorage.Modules.Schematics.SurvivorWinAnims)
			local v34 = math.random(1, #v_u_33)
			local v_u_35 = math.clamp(v34, 1, (1 / 0))
			local v_u_36 = { v_u_32.SurvivorTable.Tabletop.Position }
			local v_u_37 = nil
			local v_u_38 = nil
			local function v_u_43()
				-- upvalues: (ref) v_u_37, (copy) v_u_36, (copy) v_u_32, (ref) v_u_38
				if v_u_37 then
					local v39 = Vector3.new()
					for _, v40 in pairs(v_u_36) do
						v39 = v39 + v40
					end
					local v41 = v39 / #v_u_36
					local v42 = CFrame.lookAt(v_u_32.SurvivorWinCam.Position, v41)
					if v_u_38 then
						v_u_38:Cancel()
					end
					v_u_37.CFrame = v42 * CFrame.Angles(0, 0, 0.4363323129985824)
					v_u_38 = game.TweenService:Create(v_u_37, TweenInfo.new(3), {
						["CFrame"] = v42
					})
					v_u_38:Play()
				end
			end
			local v_u_44 = Instance.new("NumberValue")
			v_u_44.Name = "CutsceneFOV"
			v_u_44.Value = 5
			v_u_44.Parent = v_u_32
			game.TweenService:Create(v_u_44, TweenInfo.new(4), {
				["Value"] = 37.5
			}):Play()
			table.insert(v_u_18, v_u_44)
			v_u_5:SetAttribute("FOVMultipliersDisabled", true)
			local v_u_45 = nil
			v_u_45 = game["Run Service"].RenderStepped:Connect(function(_)
				-- upvalues: (copy) v_u_44, (ref) v_u_45, (ref) v_u_5, (ref) v_u_6
				if v_u_44.Parent then
					v_u_6.FieldOfView = v_u_44.Value
				else
					v_u_45:Disconnect()
					v_u_45 = nil
					v_u_5:SetAttribute("FOVMultipliersDisabled", nil)
				end
			end)
			task.spawn(function()
				-- upvalues: (ref) v_u_37, (copy) v_u_32, (copy) v_u_18, (ref) v_u_6, (ref) v_u_5
				v_u_37 = Instance.new("Part")
				v_u_37.Name = "TemporaryCamera"
				v_u_37.Anchored = true
				v_u_37.Transparency = 1
				v_u_37.CFrame = v_u_32.SurvivorWinCam.CFrame
				v_u_37.Parent = v_u_32
				local v46 = v_u_18
				local v47 = v_u_37
				table.insert(v46, v47)
				while v_u_37.Parent do
					v_u_6.CameraType = Enum.CameraType.Scriptable
					v_u_6.CFrame = v_u_37.CFrame
					task.wait()
				end
				local v48 = v_u_5.Character
				if v48 then
					v48 = v_u_5.Character:FindFirstChild("Humanoid")
				end
				if v48 then
					v_u_6.CameraSubject = v48
				end
				v_u_6.CameraType = Enum.CameraType.Custom
			end)
			for v49, v50 in pairs(p_u_17) do
				local v_u_51 = v_u_32.SurvivorPositions:FindFirstChild(v49)
				local v_u_52 = v50.Rig
				if v_u_52 then
					v_u_52 = v50.Rig:Clone()
				end
				if v_u_51 and (v_u_52 and v_u_52.PrimaryPart) then
					task.spawn(function()
						-- upvalues: (copy) v_u_52, (copy) v_u_51, (copy) v_u_32, (copy) v_u_18, (copy) v_u_36, (copy) v_u_43, (ref) v_u_35, (copy) v_u_33, (ref) v_u_1
						v_u_52:SetPrimaryPartCFrame(v_u_51.CFrame)
						v_u_52.PrimaryPart.Anchored = true
						v_u_52.Parent = v_u_32
						local v53 = v_u_18
						local v54 = v_u_52
						table.insert(v53, v54)
						for _, v55 in pairs(v_u_52:GetDescendants()) do
							if v55:IsA("Audio") or (v55:IsA("ParticleEmitter") or (v55:IsA("Light") or (v55:IsA("Beam") or v55:IsA("Highlight")))) then
								v55:Destroy()
							end
						end
						local v56 = v_u_36
						local v57 = v_u_51.Position
						table.insert(v56, v57)
						v_u_43()
						v_u_35 = v_u_35 + 1
						local v58 = v_u_33[v_u_35 % #v_u_33 + 1]
						if v58 then
							v58 = v_u_1:LoadAnimationFromID(v_u_52, v58)
						end
						if v58 then
							v58:Play(0)
							v58.Looped = true
							v58.Priority = Enum.AnimationPriority.Action4
						end
					end)
				end
			end
		end
		v_u_1:FadeOut({
			["Time"] = 0.75
		})
		local v_u_59 = script.EndScreen:Clone()
		v_u_59.Parent = v_u_5.PlayerGui
		local v60 = script.WinnerTitle:Clone()
		v60.Parent = v_u_59
		local v61 = #p_u_17 > 1 and ("The %* won."):format(p_u_16)
		if not v61 then
			if #p_u_17 == 1 and p_u_16 == "Survivors" then
				v61 = "The last survivor won."
			elseif #p_u_17 == 1 then
				local v62 = #p_u_16 - 1
				v61 = ("The %* won."):format((string.sub(p_u_16, 0, v62))) or "Nobody won."
			else
				v61 = "Nobody won."
			end
		end
		v60.Text = v61
		v60.TextTransparency = 1
		v60.Usernames.TextTransparency = 1
		v_u_59.Main.MainTitle.Text = v60.Text
		game.TweenService:Create(v60, TweenInfo.new(0.3), {
			["TextTransparency"] = 0
		}):Play()
		game.TweenService:Create(v60.Usernames, TweenInfo.new(0.3), {
			["TextTransparency"] = 0.45
		}):Play()
		for v63, v64 in pairs(p_u_17) do
			if v63 == 1 then
				local v65 = v60.Usernames
				local v66 = v64.Username
				v65.Text = tostring(v66)
			elseif #p_u_17 >= 3 then
				if v63 == #p_u_17 then
					local v67 = v60.Usernames
					local v68 = v60.Usernames.Text
					local v69 = v64.Username
					v67.Text = ("%*, and %*"):format(v68, (tostring(v69)))
				else
					local v70 = v60.Usernames
					local v71 = v60.Usernames.Text
					local v72 = v64.Username
					v70.Text = ("%*, %*"):format(v71, (tostring(v72)))
				end
			elseif #p_u_17 == 2 then
				local v73 = v60.Usernames
				local v74 = v60.Usernames.Text
				local v75 = v64.Username
				v73.Text = ("%* and %*"):format(v74, (tostring(v75)))
			else
				local v76 = v60.Usernames
				local v77 = v64.Username
				v76.Text = ("%*"):format((tostring(v77)))
			end
		end
		require(game.ReplicatedStorage.Modules.Stats)
		local v78 = game.ReplicatedStorage:WaitForChild("FinalRoundStats", 10)
		local v_u_79 = v78
		if v_u_79 then
			v_u_79 = v_u_1:ValueBaseToTable(v78)
		end
		if v_u_79 then
			local function v_u_87(p80)
				-- upvalues: (ref) v_u_1
				local v81 = nil
				local v82 = p80.ConvertToDisplay
				local v83 = tostring(v82)
				if v83:find("<CLOCKTIME>") then
					local v84 = v_u_1
					local v85 = p80.Value
					v81 = v84:FormatTime(tonumber(v85), "Clock")
				elseif v83:find("<VALUE>") then
					v81 = v83:gsub("<VALUE>", p80.Value)
				end
				if not v81 then
					local v86 = p80.Value
					v81 = tostring(v86)
				end
				return v81
			end
			for v88, v89 in pairs(v_u_79.Round) do
				local v90 = v_u_59.Main.RoundStats:FindFirstChild(v88, true) or script.Stat:Clone()
				if v90.Parent then
					v90.Text = v_u_87(v89)
				else
					v90.Text = ("%*: <b>%*</b>"):format(v88, (v_u_87(v89)))
					v90.LayoutOrder = #v88
					v90.Parent = v_u_59.Main.RoundStats
				end
			end
			local function v99(p91)
				-- upvalues: (copy) v_u_79, (copy) v_u_59, (copy) v_u_87
				for v92, v93 in pairs(v_u_79.Players) do
					if tostring(v92) == tostring(p91) then
						for _, v94 in pairs(v_u_59.Main.PlayerStats:GetChildren()) do
							if v94:IsA("GuiObject") and v94.Name ~= "Header" then
								v94:Destroy()
							end
						end
						if v93.Info and v93.Info.RenderImage then
							local v95 = v_u_59.Main.PlayerCardHolder.CardContainer
							v95.CharacterRender.Image = v93.Info.RenderImage
							v95.Splatter.Visible = v93.Stats["Time Alive"]
							v95.CharacterRender.ImageColor3 = v93.Stats["Time Alive"] and Color3.fromRGB(155, 0, 0) or Color3.fromRGB(255, 255, 255)
						end
						for v96, v97 in pairs(v93.Stats or {}) do
							local v98 = script.Stat:Clone()
							v98.Text = ("%*: <b>%*</b>"):format(v96, (v_u_87(v97)))
							v98.LayoutOrder = #v96
							v98.Parent = v_u_59.Main.PlayerStats
						end
						return
					end
				end
			end
			v99(v_u_5.Name)
			local v100 = {}
			for v101, _ in pairs(v_u_79.Players) do
				local v102 = tostring(v101)
				table.insert(v100, v102)
			end
			local v103 = Instance.new("StringValue")
			v103.Parent = v_u_59
			v103:SetAttribute("Options", table.concat(v100, "|"))
			require(game.ReplicatedStorage.Systems.Player.UI.Menus.Settings.Templates.String):CreateSettingUI(v103, v_u_59.Main.PlayerStats.Header.PlayerDropdown, v99).Instance.DropdownFrame.ChosenValue.Title.Text = v_u_5.Name
		end
		local v_u_104 = {}
		for _, v105 in pairs(v_u_59:GetDescendants()) do
			if v105:IsA("TextLabel") then
				v_u_104[v105] = {
					["TextTransparency"] = v105.TextTransparency,
					["Position"] = v105.Position
				}
				v105.TextTransparency = 1
				v105.Position = v105.Position - UDim2.fromOffset(0, 10)
			elseif v105:IsA("Frame") then
				v_u_104[v105] = {
					["BackgroundTransparency"] = v105.BackgroundTransparency,
					["Position"] = v105.Position
				}
				v105.BackgroundTransparency = 1
			elseif v105:IsA("ImageButton") or v105:IsA("ImageLabel") then
				v_u_104[v105] = {
					["ImageTransparency"] = v105.ImageTransparency,
					["Position"] = v105.Position
				}
				v105.ImageTransparency = 1
			end
		end
		task.delay(v19 + 0.5, function()
			-- upvalues: (copy) v_u_104
			for v106, v107 in pairs(v_u_104) do
				game.TweenService:Create(v106, TweenInfo.new(0.3), v107):Play()
			end
		end)
		task.delay(v19, function()
			-- upvalues: (copy) v_u_59
			local v108 = v_u_59:FindFirstChild("Main")
			if v108 then
				game.TweenService:Create(v108.MainTitle.Underline, TweenInfo.new(1.5), {
					["Size"] = UDim2.new(3, 0, 0, 2)
				}):Play()
			end
		end)
		local v_u_109 = false
		local function v_u_116()
			-- upvalues: (ref) v_u_109, (copy) v_u_59, (copy) v_u_18, (ref) v_u_1, (ref) v_u_5, (ref) v_u_20, (copy) p_u_16, (copy) p_u_17
			if not v_u_109 then
				v_u_109 = true
				game.Debris:AddItem(v_u_59, 0.5)
				for _, v110 in pairs(v_u_18) do
					game.Debris:AddItem(v110, 0.5)
				end
				v_u_1:FadeIn({
					["Time"] = 0.5,
					["Yield"] = true
				})
				task.wait(0.25)
				v_u_1:FadeOut({
					["Time"] = 0.5
				})
				v_u_5.PlayerGui.MainUI.Enabled = true
				v_u_5.PlayerGui.TemporaryUI.Enabled = true
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
				local v111 = workspace.CurrentCamera
				local v112 = v_u_5.Character
				if v112 then
					v112 = v_u_5.Character:FindFirstChild("Humanoid")
				end
				v111.CameraSubject = v112
				local v113 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
				v113.isInCutscene = false
				v113:SetDefaultLighting()
				if v_u_20 and v_u_20.OnVictory then
					v_u_20:OnVictory("End")
					if p_u_16 == "Killers" then
						local v114 = p_u_17[1]
						local v115 = require(game.ReplicatedStorage.Modules.Sounds)
						if v114.Config.Sounds.VictoryTheme then
							v115:StopTheme(v114.Config.Sounds.VictoryTheme)
						end
					end
				end
			end
		end
		local v_u_117 = v_u_59.Main.Return
		v_u_117.MouseButton1Click:Connect(v_u_116)
		task.spawn(function()
			-- upvalues: (copy) v_u_117, (ref) v_u_109, (copy) v_u_116
			local v118 = v_u_117:WaitForChild("Timer")
			local v119 = 0
			while v_u_117.Parent and not v_u_109 do
				v119 = v119 + game["Run Service"].Heartbeat:Wait()
				local v120 = 25 - v119
				local v121 = math.clamp(v120, 0, 25)
				v118.Text = math.round(v121)
				if v119 >= 25 then
					v_u_116()
				end
			end
		end)
	end)
end
return v_u_122
