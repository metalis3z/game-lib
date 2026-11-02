-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if script.Parent:FindFirstChildOfClass("Humanoid") then
	local function v_u_7()
		if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial ~= Enum.Material.Air then
			if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Carpet then
				local v_u_1 = script.Steps:FindFirstChild("carpet"):GetChildren()[math.random(1, #script.Steps:FindFirstChild("carpet"):GetChildren())]:Clone()
				v_u_1.Parent = script.Parent:FindFirstChild("Torso")
				v_u_1.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
				if script.Parent:GetAttribute("Crouching") == true then
					v_u_1.Volume = v_u_1.Volume / 2
				end
				if not v_u_1.IsLoaded then
					v_u_1.Loaded:Wait()
				end
				v_u_1:Play()
				task.delay(v_u_1.TimeLength, function()
					-- upvalues: (copy) v_u_1
					v_u_1:Destroy()
				end)
				return
			end
			if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Foil then
				local v_u_2 = script.Steps:FindFirstChild("inflatable"):GetChildren()[math.random(1, #script.Steps:FindFirstChild("inflatable"):GetChildren())]:Clone()
				v_u_2.Parent = script.Parent:FindFirstChild("Torso")
				v_u_2.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
				if script.Parent:GetAttribute("Crouching") == true then
					v_u_2.Volume = v_u_2.Volume / 2
				end
				if not v_u_2.IsLoaded then
					v_u_2.Loaded:Wait()
				end
				v_u_2:Play()
				task.delay(v_u_2.TimeLength, function()
					-- upvalues: (copy) v_u_2
					v_u_2:Destroy()
				end)
				return
			end
			if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.DiamondPlate or (script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Metal or script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.CorrodedMetal) then
				local v_u_3 = script.Steps:FindFirstChild("metal"):GetChildren()[math.random(1, #script.Steps:FindFirstChild("metal"):GetChildren())]:Clone()
				v_u_3.Parent = script.Parent:FindFirstChild("Torso")
				v_u_3.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
				if script.Parent:GetAttribute("Crouching") == true then
					v_u_3.Volume = v_u_3.Volume / 2
				end
				if not v_u_3.IsLoaded then
					v_u_3.Loaded:Wait()
				end
				v_u_3:Play()
				task.delay(v_u_3.TimeLength, function()
					-- upvalues: (copy) v_u_3
					v_u_3:Destroy()
				end)
				return
			end
			if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Concrete then
				local v_u_4 = script.Steps:FindFirstChild("metal"):GetChildren()[math.random(1, #script.Steps:FindFirstChild("metal"):GetChildren())]:Clone()
				v_u_4.Parent = script.Parent:FindFirstChild("Torso")
				v_u_4.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
				if script.Parent:GetAttribute("Crouching") == true then
					v_u_4.Volume = v_u_4.Volume / 2
				end
				if not v_u_4.IsLoaded then
					v_u_4.Loaded:Wait()
				end
				v_u_4:Play()
				task.delay(v_u_4.TimeLength, function()
					-- upvalues: (copy) v_u_4
					v_u_4:Destroy()
				end)
				return
			end
			if script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Grass or (script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Ground or (script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.LeafyGrass or script.Parent:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Mud)) then
				local v_u_5 = script.Steps:FindFirstChild("grass").walking:GetChildren()[math.random(1, #script.Steps:FindFirstChild("grass").walking:GetChildren())]:Clone()
				v_u_5.Parent = script.Parent:FindFirstChild("Torso")
				v_u_5.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
				if script.Parent:GetAttribute("Crouching") == true then
					v_u_5.Volume = v_u_5.Volume / 2
				end
				if not v_u_5.IsLoaded then
					v_u_5.Loaded:Wait()
				end
				v_u_5:Play()
				task.delay(v_u_5.TimeLength, function()
					-- upvalues: (copy) v_u_5
					v_u_5:Destroy()
				end)
				return
			end
			local v_u_6 = script.Steps:FindFirstChild("misc"):GetChildren()[math.random(1, #script.Steps:FindFirstChild("misc"):GetChildren())]:Clone()
			v_u_6.Parent = script.Parent:FindFirstChild("Torso")
			v_u_6.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
			if script.Parent:GetAttribute("Crouching") == true then
				v_u_6.Volume = v_u_6.Volume / 2
			end
			if not v_u_6.IsLoaded then
				v_u_6.Loaded:Wait()
			end
			v_u_6:Play()
			task.delay(v_u_6.TimeLength, function()
				-- upvalues: (copy) v_u_6
				v_u_6:Destroy()
			end)
		end
	end
	script.Parent:FindFirstChildOfClass("Humanoid"):WaitForChild("Animator").AnimationPlayed:Connect(function(p8)
		-- upvalues: (copy) v_u_7
		local v_u_9 = p8:GetMarkerReachedSignal("Step"):Connect(function()
			-- upvalues: (ref) v_u_7
			if not script.Parent:HasTag("UNDETECTABLE") then
				v_u_7()
			end
		end)
		local v_u_10 = p8:GetMarkerReachedSignal("Step2"):Connect(function()
			-- upvalues: (ref) v_u_7
			if not script.Parent:HasTag("INVIS") then
				v_u_7()
			end
		end)
		p8.Stopped:Once(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_10
			v_u_9:Disconnect()
			v_u_10:Disconnect()
		end)
	end)
end