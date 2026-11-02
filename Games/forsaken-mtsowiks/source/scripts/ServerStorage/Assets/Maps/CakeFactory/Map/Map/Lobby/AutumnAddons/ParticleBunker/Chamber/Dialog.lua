-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5
-- Decompiled on 2025-11-10 16:37:59
-- Luau version 6, Types version 3
-- Time taken: 0.041069 seconds

local module_upvr = {
	__isTransition = false;
}
local Players_upvr = game:GetService("Players")
local TweenService_upvr = game:GetService("TweenService")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets", 15)
local var6_upvr = Assets
if var6_upvr then
	var6_upvr = require(Assets.EventStorage["2025_MASQUERADE"].POIs.Chamber)
end
local function _(arg1, arg2, arg3) -- Line 14
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local any_Create_result1_upvr_4 = TweenService_upvr:Create(arg1, arg2, arg3)
	any_Create_result1_upvr_4:Play()
	any_Create_result1_upvr_4.Completed:Once(function() -- Line 18
		--[[ Upvalues[1]:
			[1]: any_Create_result1_upvr_4 (readonly)
		]]
		any_Create_result1_upvr_4:Destroy()
	end)
	return any_Create_result1_upvr_4
end
local function _() -- Line 24
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	local Character = LocalPlayer_upvr.Character
	local var12 = Character
	if var12 then
		var12 = Character.Parent
		if var12 then
			if Character.Parent.Name == "Spectating" then
				var12 = false
			else
				var12 = true
			end
		end
	end
	return var12
end
local function v24_upvr(arg1) -- Line 29, Named "v24"
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: Players_upvr (readonly)
	]]
	if LocalPlayer_upvr.Character and LocalPlayer_upvr.Character.Parent.Name ~= "Spectating" then
		print("CANNOT PROCEED AS THE PARENT IS NOT SPECTATING, CURRENT PARRENT NAME:", LocalPlayer_upvr.Character.Parent.Name)
	else
		for _, v in Players_upvr:GetPlayers() do
			local Character_4 = v.Character
			if Character_4 then
				for _, v_2 in Character_4:GetDescendants() do
					local var28
					if v_2:IsA("BasePart") then
						var28("hidden", v_2.Transparency)
						if arg1 then
							var28 = 1
						else
							var28 = v_2:GetAttribute("hidden")
							if not var28 then
								var28 = 0
							end
						end
						v_2.Transparency = var28
					else
						var28 = "ParticleEmitter"
						if v_2:IsA(var28) then
							v_2.Enabled = not arg1
						end
					end
				end
			end
		end
	end
end
local CurrentCamera_upvr = workspace.CurrentCamera
local cframe_upvr = CFrame.new(-3540.639, -391.125, 314.59)
local function v36_upvr() -- Line 53, Named "v36"
	--[[ Upvalues[7]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: CurrentCamera_upvr (readonly)
		[4]: v24_upvr (readonly)
		[5]: TweenService_upvr (readonly)
		[6]: var6_upvr (readonly)
		[7]: cframe_upvr (readonly)
	]]
	local Character_5 = LocalPlayer_upvr.Character
	if not Character_5 then
		module_upvr.__isTransition = false
	else
		LocalPlayer_upvr.PlayerGui:WaitForChild("MainUI").Enabled = false
		CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
		v24_upvr(true)
		local any_Create_result1_upvr = TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(1.5), {
			CFrame = script.Parent.DialogPart.CFrame;
		})
		any_Create_result1_upvr:Play()
		any_Create_result1_upvr.Completed:Once(function() -- Line 71
			--[[ Upvalues[1]:
				[1]: any_Create_result1_upvr (readonly)
			]]
			any_Create_result1_upvr:Destroy()
		end)
		task.wait(0.5)
		local ScreenGui_upvw = Instance.new("ScreenGui")
		ScreenGui_upvw.IgnoreGuiInset = true
		ScreenGui_upvw.Name = "BlackScreen"
		local Frame = Instance.new("Frame")
		Frame.BackgroundColor3 = Color3.new(0, 0, 0)
		Frame.Parent = ScreenGui_upvw
		Frame.Size = UDim2.fromScale(1, 1)
		Frame.Transparency = 1
		ScreenGui_upvw.Parent = LocalPlayer_upvr.PlayerGui
		local any_Create_result1_upvr_2 = TweenService_upvr:Create(Frame, TweenInfo.new(1), {
			BackgroundTransparency = 0;
		})
		any_Create_result1_upvr_2:Play()
		any_Create_result1_upvr_2.Completed:Once(function() -- Line 92
			--[[ Upvalues[1]:
				[1]: any_Create_result1_upvr_2 (readonly)
			]]
			any_Create_result1_upvr_2:Destroy()
		end)
		any_Create_result1_upvr_2.Completed:Wait()
		CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
		v24_upvr(false)
		local Character_2 = LocalPlayer_upvr.Character
		if Character_2 and Character_2.Parent and Character_2.Parent.Name ~= "Spectating" then
			module_upvr.__isTransition = false
			ScreenGui_upvw:Destroy()
			return
		end
		if not var6_upvr:CreateLocation() then
			warn(`[{script:GetFullName()}]: Failed to create chamber, breaking out!`)
			module_upvr.__isTransition = false
			ScreenGui_upvw:Destroy()
			return
		end
		Character_5:PivotTo(cframe_upvr)
		local var41 = CurrentCamera_upvr
		var41.CFrame *= CFrame.Angles(0.5235987755982988, math.pi, 0)
		task.wait(0.5)
		local any_Create_result1_upvr_3 = TweenService_upvr:Create(Frame, TweenInfo.new(1), {
			BackgroundTransparency = 1;
		})
		any_Create_result1_upvr_3:Play()
		any_Create_result1_upvr_3.Completed:Once(function() -- Line 120
			--[[ Upvalues[1]:
				[1]: any_Create_result1_upvr_3 (readonly)
			]]
			any_Create_result1_upvr_3:Destroy()
		end)
		any_Create_result1_upvr_3.Completed:Once(function() -- Line 124
			--[[ Upvalues[1]:
				[1]: ScreenGui_upvw (read and write)
			]]
			ScreenGui_upvw:Destroy()
		end)
		LocalPlayer_upvr.PlayerGui.MainUI.Enabled = true
		module_upvr.__isTransition = false
	end
end
module_upvr.Config = {
	FacePlayer = false;
	PlayIdleOutsideOfDialog = false;
	VoiceSFX = "rbxassetid://115666848570683";
	Poses = {
		Idle = "rbxassetid://180435571";
	};
	Actions = {
		Wave = "rbxassetid://128777973";
	};
}
function module_upvr.Interacted(arg1) -- Line 145
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: v36_upvr (readonly)
	]]
	if module_upvr.__isTransition then return end
	if module_upvr.SpokenToBefore then
		task.spawn(v36_upvr)
	else
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "All event skins have been added to the normal shop. but you wanna enter anyway?";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Sure bruh";
		}, {
			Choice = "Nah im good bruh";
		}}), {function() -- Line 165
			--[[ Upvalues[2]:
				[1]: module_upvr (copied, readonly)
				[2]: v36_upvr (copied, readonly)
			]]
			module_upvr.__isTransition = true
			task.spawn(v36_upvr)
		end, function() -- Line 170
		end})
	end
end
return module_upvr