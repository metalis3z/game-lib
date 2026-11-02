-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("ContextActionService")
local v4 = v1.LocalPlayer
local v5 = v4.Character or v4.CharacterAdded:Wait()
local v_u_6 = v5:WaitForChild("HumanoidRootPart")
local v_u_7 = v5:WaitForChild("Humanoid")
local v_u_8 = workspace.CurrentCamera
local v_u_9 = script.Parent
uis = game:GetService("UserInputService")
ismobile = uis.TouchEnabled
v_u_9.Visible = ismobile
local v_u_10 = {
	["OFF"] = "rbxasset://textures/ui/mouseLock_off@2x.png",
	["ON"] = "rbxasset://textures/ui/mouseLock_on@2x.png"
}
local v_u_11 = false
local v_u_12 = CFrame.new(1.7, 0, 0)
local v_u_13 = CFrame.new(-1.7, 0, 0)
v_u_9.Image = v_u_10.OFF
v_u_11 = false
function ShiftLock()
	-- upvalues: (ref) v_u_11, (copy) v_u_2, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10, (copy) v_u_6, (copy) v_u_8, (copy) v_u_12, (copy) v_u_13
	if v_u_11 then
		v_u_7.AutoRotate = true
		v_u_9.Image = v_u_10.OFF
		v_u_8.CFrame = v_u_8.CFrame * v_u_13
		pcall(function()
			-- upvalues: (ref) v_u_11
			v_u_11:Disconnect()
			v_u_11 = nil
		end)
	else
		v_u_11 = v_u_2.RenderStepped:Connect(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_9, (ref) v_u_10, (ref) v_u_6, (ref) v_u_8, (ref) v_u_12
			v_u_7.AutoRotate = false
			v_u_9.Image = v_u_10.ON
			local v14 = v_u_6
			local v15 = v_u_8
			local v16 = CFrame.new
			local v17 = v_u_6.Position
			local v18 = v15.CFrame.LookVector.X * 900000
			local v19 = v_u_6.Position.Y
			local v20 = v15.CFrame.LookVector.Z * 900000
			v14.CFrame = v16(v17, (Vector3.new(v18, v19, v20)))
			v_u_8.CFrame = v_u_8.CFrame * v_u_12
		end)
	end
end
v3:BindAction("ShiftLOCK", ShiftLock, false, "On")
v3:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))
v_u_9.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_11, (copy) v_u_2, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10, (copy) v_u_6, (copy) v_u_8, (copy) v_u_12, (copy) v_u_13
	if v_u_11 then
		v_u_7.AutoRotate = true
		v_u_9.Image = v_u_10.OFF
		v_u_8.CFrame = v_u_8.CFrame * v_u_13
		pcall(function()
			-- upvalues: (ref) v_u_11
			v_u_11:Disconnect()
			v_u_11 = nil
		end)
	else
		v_u_11 = v_u_2.RenderStepped:Connect(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_9, (ref) v_u_10, (ref) v_u_6, (ref) v_u_8, (ref) v_u_12
			v_u_7.AutoRotate = false
			v_u_9.Image = v_u_10.ON
			local v21 = v_u_6
			local v22 = v_u_8
			local v23 = CFrame.new
			local v24 = v_u_6.Position
			local v25 = v22.CFrame.LookVector.X * 900000
			local v26 = v_u_6.Position.Y
			local v27 = v22.CFrame.LookVector.Z * 900000
			v21.CFrame = v23(v24, (Vector3.new(v25, v26, v27)))
			v_u_8.CFrame = v_u_8.CFrame * v_u_12
		end)
	end
end)
return {}
