-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("Players").LocalPlayer
local v_u_3 = v_u_2.Character
local v4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp"))
local v_u_5 = v4.Client("Input")
local v_u_6 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Keybinds"))
local v_u_7 = v4.Client("Reset")
task.spawn(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_7
	v_u_3:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
		-- upvalues: (ref) v_u_3, (ref) v_u_7
		if v_u_3.Humanoid.Health == 0 then
			v_u_7:Fire(true)
		end
	end)
end)
task.spawn(function()
	repeat
		local v8 = pcall(function()
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
		end)
		task.wait(1)
	until v8
end)
local v_u_9 = false
local v_u_10 = false
v1.InputBegan:Connect(function(p11, p12)
	-- upvalues: (copy) v_u_6, (ref) v_u_10, (copy) v_u_2, (ref) v_u_9, (copy) v_u_5
	if p12 then
		return
	elseif table.find(v_u_6.Run, p11.KeyCode) then
		v_u_10 = true
		if v_u_2:GetAttribute("HoldToRun") then
			v_u_5:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
		else
			v_u_9 = not v_u_9
			v_u_5:Fire(true, { v_u_9, Enum.KeyCode.LeftShift.Value })
		end
	elseif table.find(v_u_6.Flashlight, p11.KeyCode) then
		v_u_5:Fire(true, { "Flashlight" })
	elseif table.find(v_u_6.Crouch, p11.KeyCode) then
		v_u_5:Fire(true, { "Crouch" })
	end
end)
v1.InputEnded:Connect(function(p13, _)
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_5, (ref) v_u_10
	if table.find(v_u_6.Run, p13.KeyCode) then
		if v_u_2:GetAttribute("HoldToRun") then
			v_u_5:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
		end
		v_u_10 = false
	end
end)
local v_u_14 = false
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Sprint.Button.MouseButton1Down:Connect(function()
	-- upvalues: (ref) v_u_14, (copy) v_u_2, (ref) v_u_9, (copy) v_u_5
	v_u_14 = true
	if v_u_2:GetAttribute("HoldToRun") then
		v_u_5:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
	else
		v_u_9 = not v_u_9
		v_u_5:Fire(true, { v_u_9, Enum.KeyCode.LeftShift.Value })
	end
end)
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Sprint.Button.MouseButton1Up:Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (ref) v_u_14
	if v_u_2:GetAttribute("HoldToRun") then
		v_u_5:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
	end
	v_u_14 = false
end)
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Crouch.Button.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:Fire(true, { "Crouch" })
end)
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_2, (ref) v_u_10, (ref) v_u_14, (copy) v_u_3, (copy) v_u_5, (ref) v_u_9
	if v_u_2:GetAttribute("HoldToRun") and (v_u_10 or v_u_14) and (v_u_3:GetAttribute("CanRun") and (not v_u_3:HasTag("Battery") and (not v_u_3:GetAttribute("Ragdoll") and (v_u_3:GetAttribute("Stamina") or 0) > 0))) then
		if not v_u_3:GetAttribute("Running") then
			v_u_5:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
			v_u_3:SetAttribute("Running", true)
			return
		end
	elseif v_u_2:GetAttribute("HoldToRun") or (not v_u_3:GetAttribute("CanRun") or (v_u_3:HasTag("Battery") or (v_u_3:GetAttribute("Ragdoll") or (v_u_3:GetAttribute("Stamina") or 0) <= 0))) then
		if v_u_3:GetAttribute("Running") then
			v_u_5:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
			v_u_3:SetAttribute("Running", false)
		end
		v_u_9 = false
		v_u_10 = false
	elseif v_u_9 ~= v_u_3:GetAttribute("Running") then
		v_u_5:Fire(true, { v_u_9, Enum.KeyCode.LeftShift.Value })
		v_u_3:SetAttribute("Running", v_u_9)
		return
	end
end)