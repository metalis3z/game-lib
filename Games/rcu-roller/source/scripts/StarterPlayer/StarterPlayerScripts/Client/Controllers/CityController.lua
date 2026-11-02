-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:19
-- Luau version 6, Types version 3
-- Time taken: 0.005730 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "CityController";
	_colors = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local CollectionService_upvr = game:GetService("CollectionService")
local var10_upvw
local var11_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local City_upvr = workspace.Game.Cutscenes.City
local MainUI_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local CurrentCamera_upvr = workspace.CurrentCamera
local TweenService_upvr = game:GetService("TweenService")
function any_CreateController_result1.unlockedAnimation(arg1) -- Line 41
	--[[ Upvalues[11]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: LocalPlayer_upvr (readonly)
		[6]: var11_upvw (read and write)
		[7]: MainUI_upvr (readonly)
		[8]: CurrentCamera_upvr (readonly)
		[9]: City_upvr (readonly)
		[10]: TweenService_upvr (readonly)
		[11]: ReplicatedStorage_upvr (readonly)
	]]
	var5_upvw:preloadSounds({"Unlock Padlock", "Unlock Hackers Basement", "City Light"})
	var6_upvw:transition()
	task.wait(0.5)
	var6_upvw:hideHUD(true)
	if var7_upvw:getCurrentMap() ~= "City" then
		var10_upvw.print("\xC4r inte i City, k\xF6r RequestStreamAroundAsync")
		LocalPlayer_upvr:RequestStreamAroundAsync(var11_upvw[7].cframe.Position)
		var10_upvw.getHRP(LocalPlayer_upvr).CFrame = var11_upvw[7].cframe
	end
	MainUI_upvr.Enabled = false
	CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
	CurrentCamera_upvr.CFrame = City_upvr:WaitForChild("Cam", 5).CFrame
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(6.5), {
		CFrame = City_upvr.Cam2.CFrame;
	}):Play()
	task.wait(2)
	task.spawn(function() -- Line 66
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:setLights(true, true)
	end)
	task.wait(4.5)
	local clone_upvr = ReplicatedStorage_upvr.Assets.Other.Key:Clone()
	clone_upvr.Parent = workspace.Debris
	clone_upvr:PivotTo(City_upvr.Key.CFrame)
	CurrentCamera_upvr.CFrame = City_upvr.LockCam.CFrame
	TweenService_upvr:Create(CurrentCamera_upvr, TweenInfo.new(6.5), {
		CFrame = City_upvr.LockCam2.CFrame;
	}):Play()
	local CFrameValue_upvr_2 = Instance.new("CFrameValue")
	CFrameValue_upvr_2.Value = clone_upvr:GetPivot()
	CFrameValue_upvr_2.Changed:Connect(function() -- Line 80
		--[[ Upvalues[2]:
			[1]: clone_upvr (readonly)
			[2]: CFrameValue_upvr_2 (readonly)
		]]
		clone_upvr:PivotTo(CFrameValue_upvr_2.Value)
	end)
	local CFrameValue_upvr = Instance.new("CFrameValue")
	CFrameValue_upvr.Value = City_upvr.Lock.Metal:GetPivot()
	CFrameValue_upvr.Changed:Connect(function() -- Line 86
		--[[ Upvalues[2]:
			[1]: City_upvr (copied, readonly)
			[2]: CFrameValue_upvr (readonly)
		]]
		City_upvr.Lock.Metal:PivotTo(CFrameValue_upvr.Value)
	end)
	task.wait(1)
	TweenService_upvr:Create(CFrameValue_upvr_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Value = City_upvr.Key2.CFrame;
	}):Play()
	task.wait(1)
	TweenService_upvr:Create(CFrameValue_upvr_2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Value = CFrameValue_upvr_2.Value * CFrame.Angles(0, 0, math.pi);
	}):Play()
	task.wait(0.5)
	var5_upvw:play("Unlock Padlock", {
		volume = 0.8;
	})
	task.delay(0.1, function() -- Line 101
		--[[ Upvalues[2]:
			[1]: var6_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
		]]
		var6_upvw:createNotification("Custom", "<font color=\"#ffffff\"><stroke color=\"#000000\" thickness=\"3\">You have unlocked the <font color=\"#62eb23\">Hacker Basement<font color=\"#ffffff\">!</stroke></font>", 4, true)
		var5_upvw:play("Unlock Hackers Basement", {
			volume = 0.8;
		})
	end)
	TweenService_upvr:Create(CFrameValue_upvr_2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Value = CFrameValue_upvr_2.Value * CFrame.Angles(0, 0, math.pi);
	}):Play()
	TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(0.5), {
		Value = CFrameValue_upvr.Value * CFrame.Angles(0.8726646259971648, 0, 0);
	}):Play()
	task.wait(1)
	TweenService_upvr:Create(CFrameValue_upvr_2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Value = City_upvr.Key.CFrame;
	}):Play()
	task.wait(0.5)
	local NumberValue_upvr = Instance.new("NumberValue")
	NumberValue_upvr.Value = City_upvr.Lock:GetScale()
	NumberValue_upvr.Changed:Connect(function() -- Line 118
		--[[ Upvalues[2]:
			[1]: NumberValue_upvr (readonly)
			[2]: City_upvr (copied, readonly)
		]]
		if NumberValue_upvr.Value <= 0 then
		else
			City_upvr.Lock:ScaleTo(NumberValue_upvr.Value)
		end
	end)
	TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Value = 1e-07;
	}):Play()
	for _, v in City_upvr.HackerDoor:GetChildren() do
		TweenService_upvr:Create(v, TweenInfo.new(1), {
			Transparency = 1;
		}):Play()
	end
	task.wait(2)
	var6_upvw:transition()
	task.wait(0.5)
	var6_upvw:hideHUD(false)
	MainUI_upvr.Enabled = true
	CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
	clone_upvr:Destroy()
	CFrameValue_upvr_2:Destroy()
	CFrameValue_upvr:Destroy()
	NumberValue_upvr:Destroy()
	arg1:unlockHackerDoor()
end
function any_CreateController_result1.unlockHackerDoor(arg1) -- Line 150
	--[[ Upvalues[1]:
		[1]: City_upvr (readonly)
	]]
	local HackerDoor = City_upvr:FindFirstChild("HackerDoor")
	if HackerDoor then
		HackerDoor:Destroy()
	end
	local Lock = City_upvr:FindFirstChild("Lock")
	if Lock then
		Lock:Destroy()
	end
end
function any_CreateController_result1.setLights(arg1, arg2, arg3) -- Line 162
	--[[ Upvalues[2]:
		[1]: CollectionService_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	local any_GetTagged_result1_2 = CollectionService_upvr:GetTagged("CityLights")
	if not any_GetTagged_result1_2 or not next(any_GetTagged_result1_2) then
	else
		for i_2, v_2 in any_GetTagged_result1_2[1]:GetDescendants() do
			if v_2:IsA("BasePart") then
				if not arg1._colors[v_2] then
					arg1._colors[v_2] = v_2.Color
				end
				local targetColor
				if not arg2 or not arg1._colors[v_2] then
					targetColor = Color3.fromRGB(0, 0, 0)
				else
					targetColor = arg1._colors[v_2]
				end
				v_2.Color = targetColor
			elseif v_2:IsA("PointLight") or v_2:IsA("SurfaceLight") or v_2:IsA("SpotLight") then
				v_2.Enabled = arg2
			end
			if arg3 then
				task.wait(0.01)
				if i_2 % 4 == 0 then
					var5_upvw:play("City Light", {
						volume = 0.35;
						playbackSpeed = Random.new():NextNumber(0.9, 1.05);
					})
				end
			end
		end
	end
end
function any_CreateController_result1.setDependingOnActivated(arg1) -- Line 191
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local var65
	if 6 > #var4_upvw:getData().lightSwitches then
		var65 = false
	else
		var65 = true
	end
	arg1:setLights(var65)
	if var65 then
		arg1:unlockHackerDoor()
	end
end
function any_CreateController_result1.descendantAdded(arg1) -- Line 202
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	local any_GetTagged_result1_3 = CollectionService_upvr:GetTagged("CityLights")
	if not any_GetTagged_result1_3 or not next(any_GetTagged_result1_3) then
	else
		any_GetTagged_result1_3[1].DescendantAdded:Connect(function() -- Line 208
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:setDependingOnActivated()
		end)
	end
end
function any_CreateController_result1.waitForUnlock(arg1) -- Line 213
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	local _7 = var11_upvw[7]
	if _7.unlocksAt < os.time() then
	else
		while true do
			Knit_upvr.listenToUpdate:Wait()
			if _7.unlocksAt + 1 < os.time() then break end
		end
	end
end
function any_CreateController_result1.KnitStart(arg1) -- Line 224
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 225
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		arg1:waitForUnlock()
		arg1:setDependingOnActivated()
		arg1:descendantAdded()
	end)
end
local var70_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 235
	--[[ Upvalues[9]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var70_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var10_upvw (read and write)
		[9]: var11_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("MapController")
	var70_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.List.Maps)
end
return any_CreateController_result1