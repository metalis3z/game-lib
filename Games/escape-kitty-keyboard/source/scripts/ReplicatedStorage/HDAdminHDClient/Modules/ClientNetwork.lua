

local u1 = _G.HDAdminMain
local _ = u1.gui.CustomTopBar
local u2 = true
local v3 = {}
for _, u4 in pairs(u1.signals:GetChildren()) do
	if u4:IsA("RemoteEvent") then
		u4.OnClientEvent:Connect(function(p5)

			if not u1.initialized then
				u1.client.Signals.Initialized.Event:Wait()
			end
			if u4.Name == "ChangeStat" then
				local v6 = p5[1]
				local v7 = p5[2]
				u1.pdata[v6] = v7
				return
			end
			if u4.Name == "InsertStat" then
				local v8 = p5[1]
				local v9 = p5[2]
				local v10 = u1.pdata[v8]
				table.insert(v10, v9)
				return
			end
			if u4.Name == "RemoveStat" then
				local v11 = p5[1]
				local v12 = p5[2]
				for v13, v14 in pairs(u1.pdata[v11]) do
					if tostring(v14) == tostring(v12) then
						table.remove(u1.pdata[v11], v13)
						return
					end
				end
				return
			end
			if u4.Name == "BecomeControlled" then
				local v15 = p5[1]
				local v16 = u1.player
				local v17 = v16.PlayerScripts
				local v18 = require(v17:WaitForChild("PlayerModule", 3))
				if v18 then
					v18 = v18:GetControls()
				end
				local v19 = v16.Character
				local v20 = v19
				if v20 then
					v20 = v19:FindFirstChild("Animate")
				end
				if v18 then
					if v15 then
						if v20 then
							v20.Enabled = false
						end
						v18:Disable()
						return
					end
					v18:Enable()
					if v20 then
						v20.Enabled = true
						return
					end
				end
			elseif u4.Name == "ViewPlayer" then
				local v21 = p5[1]
				local v22 = u1:GetModule("cf"):GetHumanoid(v21)
				if v22 then
					u1:GetModule("cf"):SetCameraSubject(v22)
				end
				local v23 = u1.player.Character
				if v23 then
					v23 = v23:FindFirstChild("Animate")
				end
				if v23 then
					v23.Enabled = false
					task.wait()
					v23.Enabled = true
					return
				end
			else
				if u4.Name == "SetResetButtonCallbackEnabled" then
					local v24 = game:GetService("StarterGui")
					local v25 = game:GetService("RunService")
					for _ = 1, 100 do
						if pcall(v24.SetCore, v24, "ResetButtonCallback", p5) then
							return
						end
						v25.Heartbeat:Wait()
					end
					return
				end
				if u4.Name == "ForceChat" then
					u1.textChatService:WaitForChild("TextChannels").RBXGeneral:SendAsync(p5)
					return
				end
				if u4.Name == "JoinGroup" then
					local u26 = p5[1]
					local v27 = p5[2]
					local u28 = game:GetService("GroupService")
					u1:GetModule("Notices"):Notice("Notice", u1.hdAdminCoreName, v27)
					local v29, v30 = pcall(function()

						return u28:PromptJoinAsync(u26)
					end)
					if v29 and v30 ~= Enum.GroupMembershipStatus.None then
						u1.signals.JoinGroup:FireServer()
						u1:GetModule("Notices"):Notice("Notice", u1.hdAdminCoreName, "Successfully joined!")
						return
					end
				else
					if u4.Name == "UndoCommand" then
						u1:GetModule("PageCommands"):UpdateRunCommandIndicator(unpack(p5))
						return
					end
					if u4.Name == "ForceBubbleChat" then
						local v31 = p5[1]
						if v31 then
							v31 = v31.Character
						end
						local v32 = p5[2]
						if v31 and v32 then
							u1.textChatService:DisplayBubble(v31, v32)
							return
						end
					else
						if u4.Name == "SystemMessage" then
							u1.textChatService:WaitForChild("TextChannels").RBXGeneral:DisplaySystemMessage(p5)
							return
						end
						if u4.Name == "Notice" or u4.Name == "Error" then
							u1:GetModule("Notices"):Notice(u4.Name, p5[1], p5[2], p5[3])
							return
						end
						if u4.Name == "ShowPage" then
							local v33 = p5[1]
							local v34 = p5[2]
							u1:GetModule("GUIs"):ShowSpecificPage(v33, v34, nil, nil, nil, u2)
							if u2 then
								u2 = false
								return
							end
						elseif u4.Name == "UpdateIceBlock" then
							local v35 = p5[1]
							local v36 = p5[2]
							if v35 and v36 then
								v35.CFrame = v36.CFrame * CFrame.new(0, 0.8, 0)
								return
							end
						else
							if u4.Name == "ShowCommands" then
								u1:GetModule("PageCommands"):SetSearchText(p5[1])
								task.wait()
								u1:GetModule("GUIs"):ShowSpecificPage("Commands", "Commands", p5[2], nil, p5[3])
								return
							end
							if u4.Name == "ShowBannedUser" then
								u1:GetModule("GUIs"):ShowSpecificPage("Moderation", "Banland")
								if type(p5) == "table" then
									u1:GetModule("cf"):ShowBannedUser(p5)
									return
								end
							else
								if u4.Name == "SetCameraSubject" then
									u1:GetModule("cf"):SetCameraSubject(p5)
									return
								end
								if u4.Name == "ChartsHttpNotice" then
									if p5 == true then
										u1:GetModule("Notices"):Notice("Notice", u1.hdAdminCoreName, "Your game was successfully added to the HD Admin Charts!")
									else
										local v37 = { "CallFunctionOnClick", function()

												u1:GetModule("cf"):CreateNewCommandMenu("purchase", nil, 15)
											end }
										u1:GetModule("Notices"):Notice("Error", u1.hdAdminCoreName, "HttpService disabled: Unable to join HD Admin Charts. Click to add.", v37)
									end
								end
								if u4.Name == "Clear" then
									u1:GetModule("Messages"):ClearMessageContainer()
									return
								end
								if u4.Name == "ShowWarning" then
									u1:GetModule("cf"):ShowWarning(p5)
									return
								end
								if u4.Name == "UpdateBanland" then
									u1:GetModule("PageModeration"):CreateBanland()
									return
								end
								if u4.Name == "Message" then
									u1:GetModule("Messages"):Message(p5)
									return
								end
								if u4.Name == "Hint" then
									u1:GetModule("Messages"):Hint(p5)
									return
								end
								if u4.Name == "GlobalAnnouncement" then
									u1:GetModule("Messages"):GlobalAnnouncement(p5)
									return
								end
								if u4.Name == "SetCoreGuiEnabled" then
									u1.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType[p5[1]], p5[2])
									return
								end
								if u4.Name == "CreateLog" then
									u1:GetModule("cf"):CreateNewCommandMenu(p5[1], p5[2], 5)
									return
								end
								if u4.Name == "CreateAlert" then
									u1:GetModule("cf"):CreateNewCommandMenu("alert", p5, 8, true)
									return
								end
								if u4.Name == "PromptGamepass" then
									u1:GetModule("cf"):PromptGamepass(u1.player, p5)
									return
								end
								if u4.Name == "UpdatePageBoostStatus" then
									u1:GetModule("PageBooster"):UpdateBoostStatus(p5[1], p5[2])
									return
								end
								if u4.Name == "CheckOffer" then
									if u1.pdata.Rank < 4 or p5 then
										u1:GetModule("PageBooster"):CheckOffer(p5)
										return
									end
								else
									if u4.Name == "CreateBanMenu" then
										u1:GetModule("cf"):CreateNewCommandMenu("banMenu", p5, 6)
										return
									end
									if u4.Name == "CreateEmotesMenu" then
										u1:GetModule("cf"):CreateNewCommandMenu("emotes", nil, 16)
										return
									end
									if u4.Name == "CreatePollMenu" then
										u1:GetModule("cf"):CreateNewCommandMenu("pollMenu", p5, 9)
										return
									end
									if u4.Name == "CreateMenu" then
										u1:GetModule("cf"):CreateNewCommandMenu(p5.MenuName, p5.Data, p5.TemplateId)
										return
									end
									if u4.Name == "CreateCommandMenu" then
										local v38 = p5[1]
										local v39 = p5[2]
										local v40 = p5[3]
										u1:GetModule("cf"):CreateNewCommandMenu(v38, v39, v40)
										return
									end
									if u4.Name == "RankChanged" then
										u1:GetModule("cf"):RankChangedUpdater()
										return
									end
									if u4.Name == "PlaySoundInstance" then
										if p5 then
											p5:Play()
											return
										end
									else
										if u4.Name == "AddEmoteDetail" then
											local v41 = u1:GetModule("cf"):GetEmotes()
											local v42 = p5.id
											local v43 = tostring(v42)
											local v44 = false
											for _, v45 in v41 do
												local v46 = v45.id
												if tostring(v46) == v43 then
													v44 = true
													break
												end
											end
											if not v44 then
												table.insert(v41, p5)
											end
											u1:GetModule("cf"):RegisterEmoteId(v42)
											return
										end
										if u4.Name == "ExecuteClientCommand" then
											local v47 = p5[1]
											local v48 = p5[2]
											local v49 = p5[3]
											local v50 = p5[4].UnFunction and "UnFunction" or "Function"
											local v51 = u1:GetModule("ClientCommands")[v49]
											local v52 = v51 and v51[v50]
											if v52 then
												v52(v47, v48, v51)
												return
											end
										elseif u4.Name == "ReplicationEffectClientCommand" then
											local v53 = p5[1]
											local v54 = p5[2]
											local v55 = p5[3]
											local v56 = u1:GetModule("ClientCommands")[v53]
											local v57 = v56 and v56.ReplicationEffect
											if v57 then
												v57(v54, v55, v56)
												return
											end
										elseif u4.Name == "ActivateClientCommand" then
											local v58 = p5[1]
											local v59 = p5[2]
											local v60 = p5[3]
											local v61
											if v59 then
												if v59.Speed == 0 then
													v61 = nil
												else
													v61 = v59.Speed or nil
												end
											else
												v61 = v59
											end
											if v61 then
												u1.commandSpeeds[v58] = v61
												local v62 = u1.gui:FindFirstChild("CommandMenufly")
												u1:GetModule("cf"):DestroyCommandMenuFrame(v62)
											end
											if u1.commandSpeeds[v58] then
												for v63, _ in pairs(u1.commandSpeeds) do
													if v63 ~= v58 then
														u1:GetModule("cf"):DeactivateCommand(v63)
													end
												end
											end
											u1.commandsAllowedToUse[v58] = true
											u1:GetModule("cf"):ActivateClientCommand(v58, v59)
											local v64 = nil
											local v65 = nil
											for v66, v67 in pairs(u1.commandsWithMenus) do
												v64 = v67[v58]
												if v64 then
													v65 = tonumber(v66:match("%d+"))
													break
												end
											end
											if v64 then
												u1:GetModule("cf"):CreateNewCommandMenu(v58, v64, v65, nil, v60)
												return
											end
										else
											if u4.Name == "DeactivateClientCommand" then
												u1:GetModule("cf"):DeactivateCommand(p5[1])
												return
											end
											if u4.Name == "FadeInIcon" then
												return
											end
											if u4.Name == "ChangeMainVariable" then
												u1[p5[1]] = p5
												return
											end
											if u4.Name == "BindAudioEmitter" then
												local v68 = p5[1]
												local v69 = p5[2]
												if not v68 then
													return
												end
												local u70 = Instance.new("AudioListener")
												u70.Name = "HDAudioListener"
												u70.Parent = workspace.Camera
												local v71 = Instance.new("AudioDeviceOutput")
												v71.Parent = u70
												local v72 = Instance.new("Wire")
												v72.Parent = v71
												v72.SourceInstance = u70
												v72.TargetInstance = v71
												local v73 = Instance.new("Wire")
												v73.Parent = u70
												v73.SourceInstance = u70
												v73.TargetInstance = v68
												local u74 = false
												local function v75() 

													if not u74 then
														u74 = true
														u70:Destroy()
													end
												end
												v68.Destroying:Once(v75)
												v69:Play()
												v69.Ended:Once(v75)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)
	elseif u4:IsA("RemoteFunction") then
		function u4.OnClientInvoke(p76) 

			if not u1.initialized then
				u1.client.Signals.Initialized.Event:Wait()
			end
			if u4.Name == "GetLocalDate" then
				return os.date("*t", p76)
			end
		end
	end
end
return v3