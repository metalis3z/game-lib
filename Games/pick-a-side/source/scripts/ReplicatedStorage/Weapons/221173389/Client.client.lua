-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:50
-- Luau version 6, Types version 3
-- Time taken: 0.004239 seconds

local mouse_upvr = game:GetService("Players").LocalPlayer:GetMouse()
local Parent_upvr = script.Parent
local Remote_upvr = Parent_upvr:WaitForChild("Remote")
local tbl_upvr = {}
local UserInputType_upvr = Enum.UserInputType
local var6_upvw
local var7_upvw
function playAnimation(arg1, ...) -- Line 11
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: Parent_upvr (readonly)
	]]
	if tbl_upvr[arg1] then
		tbl_upvr[arg1]:Play()
	else
		local SOME = Parent_upvr:FindFirstChild(arg1)
		if SOME and Parent_upvr.Parent and Parent_upvr.Parent:FindFirstChild("Humanoid") then
			tbl_upvr[arg1] = Parent_upvr.Parent.Humanoid:LoadAnimation(SOME)
			playAnimation(arg1, ...)
		end
	end
end
function stopAnimation(arg1) -- Line 23
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	if tbl_upvr[arg1] then
		tbl_upvr[arg1]:Stop()
	end
end
function inputBegan(arg1) -- Line 29
	--[[ Upvalues[3]:
		[1]: UserInputType_upvr (readonly)
		[2]: Remote_upvr (readonly)
		[3]: mouse_upvr (readonly)
	]]
	if arg1.UserInputType == UserInputType_upvr.MouseButton1 or arg1.UserInputType == UserInputType_upvr.Touch or arg1.KeyCode == Enum.KeyCode.ButtonR2 then
		Remote_upvr:FireServer("LeftDown", mouse_upvr.Hit.p)
	end
end
function inputEnded(arg1) -- Line 35
	--[[ Upvalues[2]:
		[1]: UserInputType_upvr (readonly)
		[2]: Remote_upvr (readonly)
	]]
	if arg1.UserInputType == UserInputType_upvr.MouseButton1 or arg1.UserInputType == UserInputType_upvr.Touch or arg1.KeyCode == Enum.KeyCode.ButtonR2 then
		Remote_upvr:FireServer("LeftUp")
	end
end
function onRemote(arg1, ...) -- Line 41
	if arg1 == "PlayAnimation" then
		playAnimation(...)
	elseif arg1 == "StopAnimation" then
		stopAnimation(...)
	end
end
local UserInputService_upvr = game:GetService("UserInputService")
function onEquip() -- Line 49
	--[[ Upvalues[4]:
		[1]: var6_upvw (read and write)
		[2]: UserInputService_upvr (readonly)
		[3]: var7_upvw (read and write)
		[4]: mouse_upvr (readonly)
	]]
	var6_upvw = UserInputService_upvr.InputBegan:connect(inputBegan)
	var7_upvw = UserInputService_upvr.InputEnded:connect(inputEnded)
	mouse_upvr.Icon = "rbxasset://textures/GunCursor.png"
end
function onUnequip() -- Line 56
	--[[ Upvalues[4]:
		[1]: var6_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: tbl_upvr (readonly)
		[4]: mouse_upvr (readonly)
	]]
	if var6_upvw then
		var6_upvw:disconnect()
		var6_upvw = nil
	end
	if var7_upvw then
		var7_upvw:disconnect()
		var7_upvw = nil
	end
	for _, v in pairs(tbl_upvr) do
		v:Stop()
	end
	mouse_upvr.Icon = ""
end
Parent_upvr.Equipped:connect(onEquip)
Parent_upvr.Unequipped:connect(onUnequip)
Remote_upvr.OnClientEvent:connect(onRemote)