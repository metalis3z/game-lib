

local u1 = _G.HDAdminMain
local _ = u1.settings
local u2 = {}
local u3 = {}
local u4 = {}
local u5 = TweenInfo.new(0.7)
local v112 = {
	["ping"] = {
		["Function"] = function(_, _) 

			local v6 = tick()
			u1.signals.GetPing:InvokeServer(math.random(1, 1000))
			local v7 = (tick() - v6) / 2 * 1000 * 1000 + 0.5
			local v8 = math.floor(v7) / 1000
			u1:GetModule("Notices"):Notice("Notice", u1.hdAdminCoreName, "Your ping is " .. v8 .. "!")
		end
	},
	["blur"] = {
		["Function"] = function(_, p9) 

			u1.blur.Size = p9[2] == 0 and 20 or (p9[2] or 20)
		end,
		["UnFunction"] = function(_, _) 

			u1.blur.Size = 0
		end
	},
	["showGuis"] = {
		["Function"] = function(_, _) 

			for v10, _ in pairs(u2) do
				v10.Enabled = true
			end
			u2 = {}
		end
	},
	["hideGuis"] = {
		["Function"] = function(_, _) 

			for _, v11 in pairs(u1.playerGui:GetChildren()) do
				if v11:IsA("ScreenGui") and (v11.Name ~= "Chat" and v11.Name ~= "HDAdminInterface") then
					if v11.Enabled == true then
						u2[v11] = true
					end
					v11.Enabled = false
				end
			end
		end
	},
	["view"] = {
		["Function"] = function(u12, u13, u14) 

			local u15 = u13[1]
			local v16 = u1:GetModule("cf"):GetHumanoid(u15)
			local u17 = math.random(1, 1000000)
			u14.clientViewingId = u17
			if u15 == u12 then
				u14.UnFunction(u12, u13, u14)
			elseif v16 then
				local u18 = math.random(1, 1000000)
				u15:SetAttribute("HDViewingId", u18)
				u1:GetModule("cf"):SetCameraSubject(v16)
				u15:GetPropertyChangedSignal("Parent"):Once(function()

					if u17 == u14.clientViewingId then
						if u15:GetAttribute("HDViewingId") == u18 then
							u14.UnFunction(u12, u13, u14)
						end
					end
				end)
				u15.CharacterAdded:Once(function()

					if u17 == u14.clientViewingId then
						if not u15.Character then
							u15.CharacterAdded:Wait()
						end
						task.wait()
						u14.Function(u12, u13, u14)
					end
				end)
			end
		end,
		["UnFunction"] = function(p19, _, p20) 

			local v21 = u1:GetModule("cf"):GetHumanoid(p19)
			if v21 then
				u1:GetModule("cf"):SetCameraSubject(v21)
				p20.clientViewingId = nil
			end
		end
	},
	["nightVision"] = {
		["Function"] = function(_, _) 

			for _, v22 in pairs(u1.players:GetChildren()) do
				local v23 = u1:GetModule("cf"):GetHead(v22)
				if v22.Name ~= u1.player.Name and v23 then
					for _, v24 in pairs(v22.Character:GetChildren()) do
						if v24:IsA("BasePart") and v24:FindFirstChild("HDNightVision") == nil then
							for v25 = 1, 6 do
								local v26 = u1.client.Assets.NightVision:Clone()
								v26.Parent = v24
								v26.Face = v25 - 1
								v26.Name = "HDAdminNightVision"
							end
						end
					end
					local v27 = u1.client.Assets.Nickname:Clone()
					v27.TextLabel.Text = v22.Name
					v27.Parent = v23
					v27.Name = "HDAdminNightVision"
				end
			end
		end,
		["UnFunction"] = function(_, _) 

			for _, v28 in pairs(u1.players:GetChildren()) do
				if v28.Character then
					for _, v29 in pairs(v28.Character:GetDescendants()) do
						if v29.Name == "HDAdminNightVision" then
							v29:Destroy()
						end
					end
				end
			end
		end
	},
	["cmdbar"] = {
		["Function"] = function(_, _) 

			u1:GetModule("CmdBar"):OpenCmdBar()
		end
	},
	["cmdbar2"] = {
		["Function"] = function(_, _) 

			u1:GetModule("cf"):CreateNewCommandMenu("cmdbar2", {}, 2)
		end
	},
	["laserEyes"] = {
		["DisplayLaser"] = function(p30, p31) 
			local v32
			if p30 then
				v32 = p30:FindFirstChild("LeftBeam")
			else
				v32 = p30
			end
			if v32 then
				v32.Enabled = p31
				p30.RightBeam.Enabled = p31
				p30.MidAttachment.GlowHit.Enabled = p31
			end
		end,
		["Activate"] = function(p33) 

			local v34 = p33.Name
			local v35 = u1:GetModule("cf"):GetHead()
			local v36 = u1:GetModule("cf"):GetHumanoid()
			local v37 = u1:GetModule("cf"):GetHRP()
			if v35 and (v36 and u1.mouseDown) then
				local v38 = v35.Parent:FindFirstChild("HDLaserTarget")
				local v39 = u1:GetModule("cf"):GetNeck()
				local v40 = v36.RigType == Enum.HumanoidRigType.R6
				v35.Parent.PrimaryPart = v37
				if v39 and v38 then
					local v41 = tick() - 1
					local v42 = v39.C0
					local v43 = v35.Parent.PrimaryPart
					local v44 = v39.C0.Position.Y
					local v45 = v38.MidAttachment2.Fire
					local v46 = v38.MidAttachment.Sparks
					local v47 = u1.audio.Sizzle
					local v48 = u1.audio.Sizzle2
					v47:Play()
					p33.DisplayLaser(v38, true)
					local v49 = 0
					local v50 = false
					while true do
						if true then
							local v51, v52 = u1:GetModule("cf"):GetMousePoint(u1.lastHitPosition)
							local v53 = CFrame.new(v52, v35.Position)
							local v54 = u1.player:DistanceFromCharacter(v53.p)
							local v55
							if v54 > 30 then
								v53 = v53 * CFrame.new(0, 0, 30 - v54)
								v55 = true
							else
								v55 = false
							end
						end
						v38.CFrame = v53
						local v56 = v35.Position
						local v57 = v38.Position
						local v58 = v57.X
						local v59 = v56.Y
						local v60 = v57.Z
						local v61 = (Vector3.new(v58, v59, v60) - v35.Position).Unit
						if v35.Parent.PrimaryPart == nil then
							v35.Parent.PrimaryPart = v35.parent.HumanoidRootPart
						end
						local v62 = CFrame.new(Vector3.new(), v43.CFrame:VectorToObjectSpace(v61))
						local v63
						if v40 then
							v63 = v62 * CFrame.new(0, 1, 0) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 3.141592653589793, 0)
						else
							v63 = v62 * CFrame.new(0, v49, 0)
						end
						if not v50 then
							v49 = v49 - (v63.Position.Y - v44)
							v63 = v63 * CFrame.new(0, v49, 0)
							v50 = true
						end
						v39.C0 = v63
						if v41 < tick() - 0.6 then
							v41 = tick()
							u1:GetModule("cf"):ReplicateEffect(p33.Name, { v53, v63 })
						end
						if v51 and (not v55 and (v51.Parent:FindFirstChild("Humanoid") or v51.Name == "Handle")) then
							v45.Enabled = true
							v46.Enabled = true
							if not v48.Playing then
								v48:Play()
							end
						else
							v45.Enabled = false
							v46.Enabled = false
							if v48.Playing then
								v48:Stop()
							end
						end
						wait()
						if not (u1.mouseDown and (u1.commandsActive[v34] and (v35 and (v35.Parent and v39)))) then
							v39.C0 = v42
							p33.DisplayLaser(v38, false)
							v45.Enabled = false
							v46.Enabled = false
							v47:Stop()
							v48:Stop()
							
						end
					end
				end
			end
			
			u1.commandsActive[v34] = nil
		end,
		["ReplicationEffect"] = function(p64, p65, p66) 

			local v67 = p65[1]
			local v68 = p65[2]
			local v69 = u1:GetModule("cf"):GetHead(p64)
			if v69 then
				local v70 = v69.Parent:FindFirstChild("HDLaserTarget")
				local u71 = u1:GetModule("cf"):GetNeck(p64)
				if v70 and u71 then
					if u3[p64] then
						u3[p64] = u3[p64] + 1
					else
						u3[p64] = 1
						u4[p64] = u71.C0
						local v72 = math.random(10, 40) - 15
						v70.CFrame = v67 * CFrame.new(0, 0, v72)
						u71.C0 = v68
						v70.MidAttachment.GlowHit.Rate = 50
						p66.DisplayLaser(v70, true)
					end
					u1.tweenService:Create(v70, u5, {
						["CFrame"] = v67
					}):Play()
					u1.tweenService:Create(u71, u5, {
						["C0"] = v68
					}):Play()
					wait(0.7)
					u3[p64] = u3[p64] - 1
					if u3[p64] <= 0 then
						p66.DisplayLaser(v70, false)
						local u73 = u4[p64]
						u71.C0 = u73
						task.delay(0.1, function()

							u71.C0 = u73
						end)
						u4[p64] = nil
						u3[p64] = nil
					end
				end
			end
		end
	},
	["warp"] = {
		["Function"] = function(_, _) 

			local v74 = 0.995
			local v75 = -0.005
			while true do
				u1.runService.RenderStepped:Wait()
				if v74 < 0.005 then
					v74 = 0.005
					v75 = 0.005
				elseif v74 > 1 then
					v74 = 1
					v75 = -0.005
				end
				u1.camera.CFrame = u1.camera.CFrame * CFrame.new(0, 0, 0, v74, 0, 0, 0, v74, 0, 0, 0, 1)
				v74 = v74 + v75
				if v74 > 1 then
					return
				end
			end
		end
	},
	["fly"] = {
		["Activate"] = function(p76) 

			u1:GetModule("FlyCommand"):Fly(p76.Name)
		end
	},
	["fly2"] = {
		["Activate"] = function(p77) 

			u1:GetModule("FlyCommand"):Fly(p77.Name)
		end
	},
	["noclip"] = {
		["Activate"] = function(p78) 

			local v79 = p78.Name
			local v80 = u1:GetModule("cf"):GetHumanoid()
			local v81 = u1:GetModule("cf"):GetHRP()
			if v80 and v81 then
				local v82 = tick()
				v81.Anchored = true
				v80.PlatformStand = true
				repeat
					wait()
					local v83 = tick() - v82
					local v84 = (u1.camera.Focus.p - u1.camera.CFrame.p).unit
					local v85 = u1:GetModule("cf"):GetNextMovement(v83, u1.commandSpeeds[v79])
					local v86 = v81.Position
					v81.CFrame = CFrame.new(v86, v86 + v84) * v85
					v82 = tick()
				until not u1.commandsActive[v79]
				if v81 and v80 then
					v81.Anchored = false
					v81.Velocity = Vector3.new()
					v80.PlatformStand = false
				end
			end
		end
	},
	["noclip2"] = {
		["Activate"] = function(p87) 

			u1:GetModule("FlyCommand"):Fly(p87.Name, true)
		end
	},
	["clip"] = {
		["Function"] = function(_, _, _) 

			u1:GetModule("cf"):DeactivateCommand("noclip")
		end
	},
	["boing"] = {
		["ExpandTime"] = 4,
		["ExpandAmount"] = 3,
		["EndBoing"] = {},
		["Function"] = function(p88, p89, p90) 

			local v91 = p89[1]
			local v92 = u1:GetModule("cf"):GetHead(v91)
			local v93 = u1:GetModule("cf"):GetHumanoid(v91)
			local v94 = v92 and v93 and (not p90.UnFunction(p88, p89, p90) and v92:FindFirstChild("Mesh"))
			if v94 then
				local v95 = v91.Character
				local v96 = {}
				for _, v97 in pairs(v95:GetChildren()) do
					if v97:IsA("Accessory") then
						table.insert(v96, v97)
						v97.Parent = nil
					end
				end
				local v98 = v94.Scale
				local v99 = u1.tweenService
				local v100 = TweenInfo.new(p90.ExpandTime, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
				local v101 = {}
				local v102 = v98.X
				local v103 = v98.Y * p90.ExpandAmount
				local v104 = v98.Z
				v101.Scale = Vector3.new(v102, v103, v104)
				v99:Create(v94, v100, v101):Play()
				local v105 = Instance.new("BindableEvent")
				p90.EndBoing[v91] = v105
				u1:GetModule("cf"):WaitForEvent(v105, v93.Died, v91.CharacterAdded)
				p90.EndBoing[v91] = nil
				v105:Destroy()
				if v94 then
					local v106 = u1.tweenService:Create(v94, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
						["Scale"] = v98
					})
					v106:Play()
					v106.Completed:Wait()
				end
				for _, v107 in pairs(v96) do
					if v95 then
						v107.Parent = v95
					else
						v107:Destroy()
					end
				end
			end
		end,
		["UnFunction"] = function(_, p108, p109) 
			local v110 = p108[1]
			local v111 = p109.EndBoing[v110]
			if v111 then
				v111:Fire()
				return true
			end
		end
	}
}
for v113, v114 in pairs(v112) do
	v114.Name = v113
end
return v112