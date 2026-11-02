-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:24
-- Luau version 6, Types version 3
-- Time taken: 0.006712 seconds

local Parent_upvr = script.Parent
local Anim_upvr = Parent_upvr:WaitForChild("Anim")
local SoSGui_upvr = Parent_upvr:WaitForChild("SoSGui")
local tbl_upvr = {Parent_upvr:WaitForChild("OverheadSwingAnim"), Parent_upvr:WaitForChild("SlashAnim")}
local LocalPlayer_upvr = game.Players.LocalPlayer
local SpinAnim_upvr = Parent_upvr:WaitForChild("SpinAnim")
local UpSmashAnim_upvr = Parent_upvr:WaitForChild("UpSmashAnim")
local DownSmashAnim_upvr = Parent_upvr:WaitForChild("DownSmashAnim")
local AbilityRemoteEvent_upvr = Parent_upvr:WaitForChild("SoSScript"):WaitForChild("AbilityRemoteEvent")
local function onKeyDown_upvr(arg1) -- Line 74, Named "onKeyDown"
	--[[ Upvalues[1]:
		[1]: AbilityRemoteEvent_upvr (readonly)
	]]
	local string_lower_result1 = string.lower(arg1)
	if string_lower_result1 == 'q' then
		AbilityRemoteEvent_upvr:FireServer(string_lower_result1)
	elseif string_lower_result1 == 'e' then
		AbilityRemoteEvent_upvr:FireServer(string_lower_result1)
	end
end
local function onMouse1Down_upvr() -- Line 84, Named "onMouse1Down"
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	if Parent_upvr.Enabled then
		Parent_upvr.Enabled = false
		wait(0.9)
		Parent_upvr.Enabled = true
	end
end
local Debris_upvr = game:GetService("Debris")
local var22_upvw
local EquipAnim_upvr = Parent_upvr:WaitForChild("EquipAnim")
local EquipSound_upvr = Parent_upvr:WaitForChild("Handle"):WaitForChild("EquipSound")
Anim_upvr.Changed:connect(function(arg1) -- Line 37, Named "onAnimChanged"
	--[[ Upvalues[7]:
		[1]: Parent_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: SpinAnim_upvr (readonly)
		[4]: UpSmashAnim_upvr (readonly)
		[5]: DownSmashAnim_upvr (readonly)
		[6]: tbl_upvr (readonly)
		[7]: Anim_upvr (readonly)
	]]
	if arg1 == "" then
	elseif Parent_upvr.Parent then
		local Humanoid_2 = Parent_upvr.Parent:FindFirstChild("Humanoid")
		if Humanoid_2 and 0 < Humanoid_2.Health then
			if arg1 == "SpinAnim" then
				LocalPlayer_upvr.CameraMinZoomDistance = 10
				local any_LoadAnimation_result1_5 = Humanoid_2:LoadAnimation(SpinAnim_upvr)
				any_LoadAnimation_result1_5:Play(nil, nil, 1.75)
				wait(2)
				any_LoadAnimation_result1_5:Stop()
				LocalPlayer_upvr.CameraMinZoomDistance = 0.5
			elseif arg1 == "UpSmashAnim" then
				local any_LoadAnimation_result1_2 = Humanoid_2:LoadAnimation(UpSmashAnim_upvr)
				any_LoadAnimation_result1_2:Play()
				wait(0.7)
				any_LoadAnimation_result1_2:Stop()
				local any_LoadAnimation_result1_3 = Humanoid_2:LoadAnimation(DownSmashAnim_upvr)
				any_LoadAnimation_result1_3:Play()
				wait(0.325)
				any_LoadAnimation_result1_3:Stop()
			elseif arg1 == "SwingAnim" then
				local any_LoadAnimation_result1_9 = Humanoid_2:LoadAnimation(tbl_upvr[math.random(1, #tbl_upvr)])
				if any_LoadAnimation_result1_9 then
					any_LoadAnimation_result1_9:Play()
				end
			end
		end
		Anim_upvr.Value = ""
	end
end)
Parent_upvr.Equipped:connect(function(arg1) -- Line 92, Named "onEquipped"
	--[[ Upvalues[8]:
		[1]: onKeyDown_upvr (readonly)
		[2]: onMouse1Down_upvr (readonly)
		[3]: SoSGui_upvr (readonly)
		[4]: Debris_upvr (readonly)
		[5]: Parent_upvr (readonly)
		[6]: var22_upvw (read and write)
		[7]: EquipAnim_upvr (readonly)
		[8]: EquipSound_upvr (readonly)
	]]
	if arg1 then
		arg1.KeyDown:connect(onKeyDown_upvr)
		arg1.Button1Down:connect(onMouse1Down_upvr)
		local LocalPlayer = game.Players.LocalPlayer
		if LocalPlayer then
			local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
			if PlayerGui then
				SoSGui_upvr.Parent = PlayerGui
				Debris_upvr:AddItem(SoSGui_upvr, 60)
			end
		end
		if Parent_upvr.Parent then
			var22_upvw = Parent_upvr.Parent:FindFirstChild("Humanoid")
			if var22_upvw then
				local any_LoadAnimation_result1_7 = var22_upvw:LoadAnimation(EquipAnim_upvr)
				if any_LoadAnimation_result1_7 then
					EquipSound_upvr:Play()
					any_LoadAnimation_result1_7:Play(nil, nil, 1.5)
				end
			end
		end
	end
end)
Parent_upvr.Unequipped:connect(function() -- Line 120, Named "onUnequipped"
	--[[ Upvalues[2]:
		[1]: Parent_upvr (readonly)
		[2]: SoSGui_upvr (readonly)
	]]
	Parent_upvr.Enabled = true
	SoSGui_upvr.Parent = Parent_upvr
end)