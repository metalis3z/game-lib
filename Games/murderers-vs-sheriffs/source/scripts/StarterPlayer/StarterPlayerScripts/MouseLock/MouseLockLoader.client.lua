-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


local v1 = script.Parent.Parent
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = v1:WaitForChild("MouseLock")
local v4 = v1:WaitForChild("PlayerModule")
local v_u_5 = v4:WaitForChild("CameraModule"):WaitForChild("MouseLockController")
script.CameraOffset.Parent = v_u_5
script.CursorImage.Parent = v_u_5
script.BoundKeys.Parent = v_u_5
local v_u_6 = require(v4).cameras
local function v_u_8()
	v_u_6.activeMouseLockController = require(v_u_5).new()
	local v7 = v_u_6.activeMouseLockController:GetBindableToggleEvent()
	if v7 then
		v7:Connect(function()
			v_u_6:OnMouseLockToggled()
		end)
	end
end
function triggerMouseLock(p9)
	local v10 = v_u_6.activeMouseLockController.isMouseLocked
	local v11 = p9 == true
	local v12 = p9 == false
	local v13 = p9 == nil
	if v11 and not v10 then
		v_u_6.activeMouseLockController:OnMouseLockToggled()
	elseif v12 and v10 then
		v_u_6.activeMouseLockController:OnMouseLockToggled()
	elseif v13 then
		v_u_6.activeMouseLockController:OnMouseLockToggled()
	end
	v_u_3:SetAttribute("Enabled", v_u_6.activeMouseLockController.isMouseLocked)
	return v_u_6.activeMouseLockController.isMouseLocked
end
(function()
	if v_u_2.TouchEnabled and v_u_6.activeMouseController == nil then
		v_u_8()
	end
	v_u_3:SetAttribute("Enabled", false)
	v_u_3.OnInvoke = triggerMouseLock
	v_u_6.activeMouseLockController:GetBindableToggleEvent():Connect(function()
		script.Parent.MouseLockToggled:Fire(v_u_6.activeMouseLockController.isMouseLocked)
	end)
end)()
