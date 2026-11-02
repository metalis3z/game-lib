-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
local v2 = game:GetService("Players")
local v3 = game:GetService("SoundService")
local v_u_4 = game:GetService("MarketplaceService")
local v5 = v3.Musics
local v_u_6 = v5.Lobby
local v_u_7 = v5.Running
local v_u_8 = v3.Game.Lava
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = v2.LocalPlayer
local v_u_12 = v_u_11:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("AreaNotf")
local v13 = game.Workspace:WaitForChild("GameFolder")
local v_u_14 = v13:WaitForChild("Rarities")
local v_u_15 = v13:WaitForChild("Heights")
local v_u_16 = v13:WaitForChild("VIPDoors")
function v_u_1.DeleteVIPDoors(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_11
	if v_u_16 and v_u_11:GetAttribute("VIP") then
		v_u_16:Destroy()
	end
end
function v_u_1.VIPDoorFunction(_, p17)
	-- upvalues: (copy) v_u_11, (copy) v_u_4
	local v_u_18 = false
	p17.Touched:Connect(function(p19)
		-- upvalues: (ref) v_u_18, (ref) v_u_11, (ref) v_u_4
		if v_u_18 then
			return
		else
			local v20 = v_u_11.Character
			if v20 and (p19.Parent and p19.Parent == v20) then
				v_u_18 = true
				v_u_4:PromptGamePassPurchase(v_u_11, 1694602214)
				task.wait(1)
				v_u_18 = false
			end
		end
	end)
end
function v_u_1.GetArea(_, p21)
	-- upvalues: (copy) v_u_14
	local v22 = v_u_14:GetChildren()
	table.sort(v22, function(p23, p24)
		return p23.Position.Z < p24.Position.Z
	end)
	for _, v25 in v22 do
		if p21.Z <= v25.Position.Z then
			return v25
		end
	end
end
function v_u_1.GetHeights(_, p26)
	-- upvalues: (copy) v_u_15
	local v27 = v_u_15.Main:GetChildren()
	table.sort(v27, function(p28, p29)
		return p28:GetPivot().Position.Z < p29:GetPivot().Position.Z
	end)
	for v30, v31 in v27 do
		if p26.Z <= v31:GetPivot().Position.Z + v31:GetExtentsSize().Z / 2 then
			return { v31, v27[v30 - 1] }
		end
	end
	return { v27[#v27] }
end
function v_u_1.Init(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_11, (copy) v_u_16, (copy) v_u_6, (copy) v_u_7, (copy) v_u_15, (copy) v_u_8, (copy) v_u_14, (ref) v_u_9, (ref) v_u_10, (copy) v_u_12
	v_u_1:DeleteVIPDoors()
	v_u_11:GetAttributeChangedSignal("VIP"):Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1:DeleteVIPDoors()
	end)
	for _, v32 in v_u_16:GetChildren() do
		v_u_1:VIPDoorFunction(v32)
	end
	v_u_16.ChildAdded:Connect(function(p33)
		-- upvalues: (ref) v_u_1
		v_u_1:VIPDoorFunction(p33)
	end)
	workspace:GetAttributeChangedSignal("OnEvent"):Connect(function()
		-- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_11, (ref) v_u_1
		if workspace:GetAttribute("OnEvent") then
			v_u_6:Stop()
			v_u_7:Stop()
			return
		else
			local v34 = v_u_11.Character
			if v34 then
				if v_u_1:GetArea(v34:GetPivot().Position) then
					v_u_7:Play()
					v_u_6:Stop()
				else
					v_u_6:Play()
					v_u_7:Stop()
				end
			else
				v_u_6:Play()
				v_u_7:Stop()
				return
			end
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_1, (ref) v_u_15, (ref) v_u_8, (ref) v_u_14, (ref) v_u_9, (ref) v_u_6, (ref) v_u_7, (ref) v_u_10, (ref) v_u_12
		while task.wait(0.1) do
			local v35 = v_u_11.Character
			if v35 then
				local v36 = v_u_1:GetArea(v35:GetPivot().Position)
				local v37 = v_u_1:GetHeights(v35:GetPivot().Position)
				for _, v38 in v_u_15.Main:GetChildren() do
					v38:WaitForChild("Lava").Transparency = table.find(v37, v38) and 0.99 or 1
				end
				local v39 = v_u_8
				local v40 = (v35:GetPivot().Position.Z - v_u_14.Common.Position.Z) / 2
				v39.Volume = 10 / math.clamp(v40, 10, 100) * (v_u_8:GetAttribute("Volume") or 0) * (v_u_8:GetAttribute("Client") or 1)
				if v35:FindFirstChild("Humanoid") and v35.Humanoid.Health <= 0 then
					v36 = nil
				end
				if v_u_9 ~= v36 then
					if not workspace:GetAttribute("OnEvent") then
						if v36 then
							if not v_u_9 then
								v_u_7:Play()
								v_u_6:Stop()
							end
						else
							v_u_6:Play()
							v_u_7:Stop()
						end
					end
					v_u_9 = v36
					if v36 then
						if v_u_10 then
							task.cancel(v_u_10)
							v_u_10 = nil
						end
						v_u_12.Text = v36.Name .. " Area"
						if v36.Name == "Secret" or (v36.Name == "Celestial" or v36.Name == "Godly") then
							v_u_12.UIStroke.Color = v36.Name == "Godly" and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 255, 255)
							v_u_12.UIGradient.Color = v_u_12[v36.Name].UIGradient.Color
							v_u_12.UIStroke.UIGradient.Color = v_u_12[v36.Name].UIStroke.UIGradient.Color
							v_u_12.UIGradient.Enabled = true
							v_u_12.UIStroke.UIGradient.Enabled = true
						else
							v_u_12.UIStroke.Color = Color3.fromRGB(0, 0, 0)
							v_u_12.UIGradient.Enabled = false
							v_u_12.UIStroke.UIGradient.Enabled = false
						end
						v_u_10 = task.delay(5, function()
							-- upvalues: (ref) v_u_12
							v_u_12.Text = ""
						end)
					end
				end
			end
		end
	end)
end
return v_u_1
