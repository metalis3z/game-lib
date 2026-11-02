-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("Players").LocalPlayer
local v_u_3 = v_u_2.Character
local v_u_4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp")).Client("Input")
local v_u_5 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Keybinds"))
task.spawn(function()
	repeat
		local v6 = pcall(function()
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
		end)
		task.wait(1)
	until v6
end)
local v_u_7 = false
local v_u_8 = false
v1.InputBegan:Connect(function(p9, p10)
	-- upvalues: (copy) v_u_5, (ref) v_u_8, (copy) v_u_2, (ref) v_u_7, (copy) v_u_4
	if p10 then
		return
	elseif table.find(v_u_5.Run, p9.KeyCode) then
		v_u_8 = true
		if v_u_2:GetAttribute("HoldToRun") then
			v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
		else
			v_u_7 = not v_u_7
			v_u_4:Fire(true, { v_u_7, Enum.KeyCode.LeftShift.Value })
		end
	elseif table.find(v_u_5.Q, p9.KeyCode) then
		v_u_4:Fire(true, { "Ability", 1 })
		return
	elseif table.find(v_u_5.E, p9.KeyCode) then
		v_u_4:Fire(true, { "Ability", 2 })
		return
	elseif table.find(v_u_5.Flashlight, p9.KeyCode) then
		v_u_4:Fire(true, { "Flashlight" })
	elseif table.find(v_u_5.Crouch, p9.KeyCode) then
		v_u_4:Fire(true, { "Crouch" })
	end
end)
v1.InputEnded:Connect(function(p11, _)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_4, (ref) v_u_8
	if table.find(v_u_5.Run, p11.KeyCode) then
		if v_u_2:GetAttribute("HoldToRun") then
			v_u_4:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
		end
		v_u_8 = false
	elseif table.find(v_u_5.Q, p11.KeyCode) then
		v_u_4:Fire(true, { "Ability", 1 })
	end
end)
local v_u_12 = false
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Sprint.Button.MouseButton1Down:Connect(function()
	-- upvalues: (ref) v_u_12, (copy) v_u_2, (ref) v_u_7, (copy) v_u_4
	v_u_12 = true
	if v_u_2:GetAttribute("HoldToRun") then
		v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
	else
		v_u_7 = not v_u_7
		v_u_4:Fire(true, { v_u_7, Enum.KeyCode.LeftShift.Value })
	end
end)
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Sprint.Button.MouseButton1Up:Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (ref) v_u_12
	if v_u_2:GetAttribute("HoldToRun") then
		v_u_4:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
	end
	v_u_12 = false
end)
game:GetService("Players").LocalPlayer.PlayerGui.UI.UI:WaitForChild("MobileOverlay").Holder.Crouch.Button.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_4
	v_u_4:Fire(true, { "Crouch" })
end)
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_2, (ref) v_u_8, (ref) v_u_12, (copy) v_u_3, (copy) v_u_4, (ref) v_u_7
	if v_u_2:GetAttribute("HoldToRun") and (v_u_8 or v_u_12) and (v_u_3:GetAttribute("CanRun") and (not v_u_3:HasTag("Battery") and (not v_u_3:GetAttribute("Ragdoll") and (v_u_3:GetAttribute("Stamina") or 0) > 0))) then
		if not v_u_3:GetAttribute("Running") then
			v_u_4:Fire(true, { true, Enum.KeyCode.LeftShift.Value })
			v_u_3:SetAttribute("Running", true)
			return
		end
	elseif v_u_2:GetAttribute("HoldToRun") or (not v_u_3:GetAttribute("CanRun") or (v_u_3:HasTag("Battery") or (v_u_3:GetAttribute("Ragdoll") or (v_u_3:GetAttribute("Stamina") or 0) <= 0))) then
		if v_u_3:GetAttribute("Running") then
			v_u_4:Fire(true, { false, Enum.KeyCode.LeftShift.Value })
			v_u_3:SetAttribute("Running", false)
		end
		v_u_7 = false
		v_u_8 = false
	elseif v_u_7 ~= v_u_3:GetAttribute("Running") then
		v_u_4:Fire(true, { v_u_7, Enum.KeyCode.LeftShift.Value })
		v_u_3:SetAttribute("Running", v_u_7)
		return
	end
end)