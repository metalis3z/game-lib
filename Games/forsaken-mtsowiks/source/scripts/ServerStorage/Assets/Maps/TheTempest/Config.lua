-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = CFrame.Angles(0, 0.017453292519943295, 0)
local v_u_4 = {}
local v27 = {
	["DisplayName"] = "The Tempest",
	["Description"] = "its pretty dark here lol",
	["Ambience"] = "rbxassetid://130358080744449",
	["AmbienceProperties"] = {
		["Volume"] = 0.5
	},
	["ClientCreated"] = function(p_u_5)
		-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
		local v6 = v_u_4
		local v7 = v_u_1.Stepped
		local function v9(_, _)
			-- upvalues: (copy) p_u_5, (ref) v_u_3
			local v8 = p_u_5.Map.Sky
			v8.CFrame = v8.CFrame * v_u_3
		end
		table.insert(v6, v7:Connect(v9))
		p_u_5.Connections = v6
		local v10 = script:GetDescendants()
		local v_u_11 = {}
		for _, v12 in pairs(v10) do
			if v12:IsA("ParticleEmitter") then
				local v13 = v12:Clone()
				v13.Parent = p_u_5.Map.Lightning
				table.insert(v_u_11, v13)
			end
		end
		task.spawn(function()
			-- upvalues: (copy) p_u_5, (ref) v_u_2, (copy) v_u_11, (ref) v_u_4
			while true do
				local v14 = math.random(2)
				p_u_5.Map.Lightning[("Lightning%*"):format(v14)]:Play()
				for _, v_u_15 in pairs(workspace.Map.Ingame.Map:GetChildren()) do
					if v_u_15:IsA("SurfaceLight") then
						task.spawn(function()
							-- upvalues: (ref) v_u_2, (copy) v_u_15, (ref) v_u_11
							v_u_2:Create(v_u_15, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								["Brightness"] = 40
							}):Play()
							local v16 = v_u_11[math.random(#v_u_11)]
							for _ = 1, math.random(1, 10) do
								v16:Clear()
								v16:Emit(1)
							end
							task.wait(0.1)
							v_u_2:Create(v_u_15, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
								["Brightness"] = 0
							}):Play()
						end)
					end
				end
				task.wait(math.random(7.5, 15))
				if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Parent.Name == "Spectating" or p_u_5.Map.Parent == nil then
					for _, v17 in v_u_4 do
						v17:Disconnect()
					end
					return
				end
			end
		end)
	end,
	["Created"] = function(p_u_18)
		local v_u_19 = 0
		p_u_18.Connection = game["Run Service"].Heartbeat:Connect(function(p20)
			-- upvalues: (copy) p_u_18, (ref) v_u_19
			if p_u_18.Map.Parent then
				v_u_19 = v_u_19 + p20
				if v_u_19 >= 0.25 then
					for _, v21 in pairs(p_u_18.Map.ToxicWater:GetChildren()) do
						local v22 = workspace:GetPartBoundsInBox(v21.CFrame, v21.Size)
						for _, v23 in pairs(v22) do
							local v24 = v23:FindFirstAncestorOfClass("Model")
							local v25
							if v24 then
								v25 = v24:FindFirstChild("Humanoid")
							else
								v25 = v24
							end
							if v25 then
								require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(v24, "Poisoned", {
									["Level"] = 1,
									["Duration"] = 8
								})
							end
						end
					end
				end
			else
				p_u_18.Connection:Disconnect()
			end
		end)
	end,
	["Destroyed"] = function(p26)
		if p26.Connection then
			p26.Connection:Disconnect()
		end
		for i, v in ipairs(p26.Connections) do
			v:Disconnect()
		end
	end
}
return v27
