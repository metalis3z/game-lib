-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("StarterPlayer")
local _ = v_u_2.LocalPlayer
local v_u_6 = require(v5.StarterPlayerScripts.Controllers.PermissionController)
local v_u_7 = require(v1.Registries.PermissionRegistries.PermissionNodesEnumsType)
local v_u_8 = require(v1:WaitForChild("CmdrClient"))
local v_u_9 = require(v1.Icon)
task.spawn(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_7, (copy) v_u_4, (copy) v_u_3, (copy) v_u_9, (copy) v_u_8
	if v_u_6:HasPermissionNode(v_u_2.LocalPlayer, v_u_7.VIEW_COMMAND_BAR_PERMISSION) or v_u_4:IsStudio() then
		if v_u_3.TouchEnabled then
			local v10 = v_u_9.new()
			v10:setImage("rbxassetid://6039299999")
			v10:setLeft()
			local v_u_11 = false
			v10.selected:Connect(function(_)
				-- upvalues: (ref) v_u_11, (ref) v_u_8
				v_u_11 = true
				v_u_8:Show()
			end)
			v10.deselected:Connect(function(_)
				-- upvalues: (ref) v_u_11, (ref) v_u_8
				v_u_11 = false
				v_u_8:Hide()
			end)
		end
		v_u_8:SetActivationKeys({ Enum.KeyCode.F2 })
	end
end)
return {}
