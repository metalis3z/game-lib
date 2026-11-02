-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-14 02:28:00
-- Luau version 6, Types version 3
-- Time taken: 0.096945 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
local Players_upvr = game:GetService("Players")
local module = {}
local SoundController_upvr = require(ReplicatedStorage_upvr.Controllers.SoundController)
local Observers_upvr = require(ReplicatedStorage_upvr.Packages.Observers)
local Trove_upvr = require(ReplicatedStorage_upvr.Packages.Trove)
local Net = require(ReplicatedStorage_upvr.Packages.Net)
local Name_upvr = script.Name
local any_new_result1_2_upvr = Trove_upvr.new()
local any_new_result1_4_upvr = Trove_upvr.new()
local var12_upvw = false
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Include
RaycastParams_new_result1_upvr.FilterDescendantsInstances = {workspace.Map}
local function _(arg1, arg2, arg3) -- Line 68, Named "loadAnimation"
	--[[ Upvalues[1]:
		[1]: any_new_result1_4_upvr (readonly)
	]]
	local any_LoadAnimation_result1_upvr_2 = arg1:LoadAnimation(arg2)
	local var18 = arg3
	if not var18 then
		var18 = any_new_result1_4_upvr
	end
	var18:Add(function() -- Line 70
		--[[ Upvalues[1]:
			[1]: any_LoadAnimation_result1_upvr_2 (readonly)
		]]
		any_LoadAnimation_result1_upvr_2:Stop(0)
		any_LoadAnimation_result1_upvr_2:Destroy()
	end)
	return any_LoadAnimation_result1_upvr_2
end
local CurrentCamera_upvr = workspace.CurrentCamera
local ProximityPromptService_upvr = game:GetService("ProximityPromptService")
local cframe_upvr = CFrame.new(0, 1000, 100000)
local Lighting_upvr = game:GetService("Lighting")
local function startTrainTravel_upvr(arg1) -- Line 78, Named "startTrainTravel"
	--[[ Upvalues[11]:
		[1]: var12_upvw (read and write)
		[2]: ReplicatedStorage_upvr (readonly)
		[3]: Trove_upvr (readonly)
		[4]: CurrentCamera_upvr (readonly)
		[5]: ProximityPromptService_upvr (readonly)
		[6]: any_new_result1_2_upvr (readonly)
		[7]: TweenService_upvr (readonly)
		[8]: Players_upvr (readonly)
		[9]: cframe_upvr (readonly)
		[10]: Lighting_upvr (readonly)
		[11]: RunService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if var12_upvw then
	else
		var12_upvw = true
		ReplicatedStorage_upvr:SetAttribute("InTrainTravelCutscene", true)
		local var28_upvw = false
		local any_new_result1_3_upvr = Trove_upvr.new()
		local ColorCorrectionEffect_upvr = Instance.new("ColorCorrectionEffect")
		ColorCorrectionEffect_upvr.Parent = CurrentCamera_upvr
		ProximityPromptService_upvr.Enabled = false
		any_new_result1_2_upvr:Add(function() -- Line 94
			--[[ Upvalues[1]:
				[1]: ProximityPromptService_upvr (copied, readonly)
			]]
			ProximityPromptService_upvr.Enabled = true
		end)
		local function fade_upvr(arg1_2, arg2, isAdd) -- Line 100, Named "fade"
			--[[ Upvalues[4]:
				[1]: TweenService_upvr (copied, readonly)
				[2]: ColorCorrectionEffect_upvr (readonly)
				[3]: var28_upvw (read and write)
				[4]: any_new_result1_2_upvr (copied, readonly)
			]]
			local tbl_2 = {}
			local var38
			if arg1_2 == "Out" then
				var38 = Color3.new(0, 0, 0)
			else
				var38 = Color3.new(1, 1, 1)
			end
			tbl_2.TintColor = var38
			local any_Create_result1_upvr_2 = TweenService_upvr:Create(ColorCorrectionEffect_upvr, TweenInfo.new(1), tbl_2)
			any_Create_result1_upvr_2:Play()
			if arg2 ~= nil then
				local func = any_Create_result1_upvr_2.Completed:Connect(function(arg1_4) -- Line 108
						--[[ Upvalues[1]:
							[1]: arg2 (readonly)
						]]
					if arg1_4 ~= Enum.PlaybackState.Cancelled then
						arg2(arg1_4)
					end
				end)
				
				if isAdd ~= false then 
					any_new_result1_2_upvr:Add(func)
				end
			end
			if false then
				any_new_result1_2_upvr:Add(function() -- Line 120
					--[[ Upvalues[1]:
						[1]: any_Create_result1_upvr_2 (readonly)
					]]
					any_Create_result1_upvr_2:Cancel()
					any_Create_result1_upvr_2:Destroy()
				end)
			end
		end
		local var42_upvw = false
		local var43_upvw = false
		local function resetCamera_upvr() -- Line 129, Named "resetCamera"
			--[[ Upvalues[4]:
				[1]: var42_upvw (read and write)
				[2]: var43_upvw (read and write)
				[3]: CurrentCamera_upvr (copied, readonly)
				[4]: Players_upvr (copied, readonly)
			]]
			local var44
			if var42_upvw or not var43_upvw then
			else
				var42_upvw = true
				var44 = Enum.CameraType.Custom
				CurrentCamera_upvr.CameraType = var44
				var44 = Players_upvr.LocalPlayer
				var44 = var44.Character
				if var44 then
					var44 = var44.Character:FindFirstChildOfClass("Humanoid")
				end
				if var44 ~= nil then
					CurrentCamera_upvr.CameraSubject = var44
				end
			end
		end
		any_new_result1_2_upvr:Add(function() -- Line 145
			--[[ Upvalues[10]:
				[1]: var12_upvw (copied, read and write)
				[2]: var28_upvw (read and write)
				[3]: fade_upvr (readonly)
				[4]: any_new_result1_3_upvr (readonly)
				[5]: var42_upvw (read and write)
				[6]: var43_upvw (read and write)
				[7]: CurrentCamera_upvr (copied, readonly)
				[8]: Players_upvr (copied, readonly)
				[9]: ReplicatedStorage_upvr (copied, readonly)
				[10]: ColorCorrectionEffect_upvr (readonly)
			]]
			var28_upvw = true
			fade_upvr("Out", function() -- Line 149				
				
				task.spawn(function()
					--any_new_result1_3_upvr:Clean()
				end)
				
				ReplicatedStorage_upvr.Sounds.Events["North Pole"].TrainLoop:Stop()
				var42_upvw = true
				local var48 = Enum.CameraType.Custom
				CurrentCamera_upvr.CameraType = var48
				var48 = Players_upvr.LocalPlayer
				var48 = var48.Character
				if var48 then
					var48 = var48:FindFirstChildOfClass("Humanoid")
				end
				if var48 ~= nil then
					CurrentCamera_upvr.CameraSubject = var48
				end
					
				ReplicatedStorage_upvr:SetAttribute("InTrainTravelCutscene", nil)
				fade_upvr("In", function() -- Line 155
					--[[ Upvalues[1]:
						[1]: ColorCorrectionEffect_upvr (copied, readonly)
					]]
					ColorCorrectionEffect_upvr:Destroy()
				end)
			end, false)
		end)
		local Road = script.Road
		local clone_2_upvr = any_new_result1_3_upvr:Clone(script.BrainrotExpress)
		clone_2_upvr.Parent = CurrentCamera_upvr
		local var53 = Road.End.Position.Z - Road.Start.Position.Z
		local var54_upvr = arg1 * 260
		
		local clone_7 = any_new_result1_3_upvr:Clone(Road)
		clone_7:PivotTo(cframe_upvr * CFrame.new(0, 0, -(var53 * (1))))
		clone_7.Parent = CurrentCamera_upvr
		
		task.spawn(function()
			local cf = Instance.new("Vector3Value")
			cf.Value = Vector3.zero
			
			cf:GetPropertyChangedSignal("Value"):Connect(function()
				clone_7:PivotTo(cframe_upvr * CFrame.new(cf.Value))
			end)
			
			game.Debris:AddItem(clone_7, arg1 + 2)
			game.Debris:AddItem(clone_2_upvr, arg1 + 2)
			
			local target = Vector3.new(0, 0, 250 * arg1)
			local tween = game.TweenService:Create(cf, TweenInfo.new((cf.Value - target).Magnitude / 80, Enum.EasingStyle.Linear), {Value = target})
			tween:Play()
			tween.Completed:Wait()
			cf:Destroy()
		end)
		
		local clone_15_upvr = any_new_result1_3_upvr:Clone(script.SnowyAtmosphere)
		fade_upvr("Out", function() -- Line 177
			--[[ Upvalues[14]:
				[1]: var43_upvw (read and write)
				[2]: clone_15_upvr (readonly)
				[3]: Lighting_upvr (copied, readonly)
				[4]: CurrentCamera_upvr (copied, readonly)
				[5]: any_new_result1_3_upvr (readonly)
				[6]: resetCamera_upvr (readonly)
				[7]: arg1 (readonly)
				[8]: RunService_upvr (copied, readonly)
				[9]: cframe_upvr (copied, readonly)
				[10]: var54_upvr (readonly)
				[11]: clone_2_upvr (readonly)
				[12]: any_new_result1_2_upvr (copied, readonly)
				[13]: ReplicatedStorage_upvr (copied, readonly)
				[14]: fade_upvr (readonly)
			]]
			var43_upvw = true
			clone_15_upvr.Parent = Lighting_upvr
			CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
			any_new_result1_3_upvr:Add(resetCamera_upvr)
			local os_clock_result1_upvr = os.clock()
			local var61_upvr = os_clock_result1_upvr + arg1
			local function v2() -- Line 188
				--[[ Upvalues[6]:
					[1]: os_clock_result1_upvr (readonly)
					[2]: var61_upvr (readonly)
					[3]: cframe_upvr (copied, readonly)
					[4]: var54_upvr (copied, readonly)
					[5]: clone_2_upvr (copied, readonly)
					[6]: CurrentCamera_upvr (copied, readonly)
				]]
				clone_2_upvr:PivotTo(cframe_upvr * CFrame.new(0, 0, -50) * CFrame.new(0, 0, -((var54_upvr - 50) * math.clamp((os.clock() - os_clock_result1_upvr) / (var61_upvr - os_clock_result1_upvr), 0, 1))))
				CurrentCamera_upvr.CFrame = clone_2_upvr.Camera.CFrame
			end
			v2()
			any_new_result1_3_upvr:Add(task.delay(arg1 - 1, function() -- Line 200
				--[[ Upvalues[1]:
					[1]: any_new_result1_2_upvr (copied, readonly)
				]]
				--any_new_result1_2_upvr:Clean()
			end))
			ReplicatedStorage_upvr.Sounds.Events["North Pole"].TrainLoop:Play()
			any_new_result1_3_upvr:Add(function() -- Line 205
				--[[ Upvalues[1]:
					[1]: ReplicatedStorage_upvr (copied, readonly)
				]]
				ReplicatedStorage_upvr.Sounds.Events["North Pole"].TrainLoop:Stop()
			end)
			
			fade_upvr("In")
		end)
	end
end
local function stopTrainTravel_upvr() -- Line 213, Named "stopTrainTravel"
	--[[ Upvalues[2]:
		[1]: var12_upvw (read and write)
		[2]: any_new_result1_2_upvr (readonly)
	]]
	
	any_new_result1_2_upvr:Clean()
	var12_upvw = false
end
local function playCharacterAnimation_upvr(arg1, arg2) -- Line 221, Named "playCharacterAnimation"
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	local Character_4 = arg1.Character
	if not Character_4 then
	else
		local HumanoidRootPart = Character_4:FindFirstChild("HumanoidRootPart")
		if not HumanoidRootPart then return end
		local clone_13_upvr = script.Reward:Clone()
		clone_13_upvr.CurrencyCandyCane.Text = `+{arg2}`
		clone_13_upvr.Parent = HumanoidRootPart
		TweenService_upvr:Create(clone_13_upvr, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			StudsOffset = Vector3.new(0, 2.5, 2.20000);
		}):Play()
		TweenService_upvr:Create(clone_13_upvr.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
			ImageTransparency = 1;
		}):Play()
		TweenService_upvr:Create(clone_13_upvr.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
			TextTransparency = 1;
		}):Play()
		TweenService_upvr:Create(clone_13_upvr.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
			Transparency = 1;
		}):Play()
		task.delay(5, function() -- Line 252
			--[[ Upvalues[1]:
				[1]: clone_13_upvr (readonly)
			]]
			clone_13_upvr:Destroy()
		end)
	end
end
local CreateTween_upvr = require(ReplicatedStorage_upvr.Packages.CreateTween)
local function playScreenCandyCaneAnimation_upvr() -- Line 257, Named "playScreenCandyCaneAnimation"
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: CreateTween_upvr (readonly)
	]]
	local random_state = Random.new()
	for _ = 1, 10 do
		local clone_12_upvr = script.Image:Clone()
		clone_12_upvr.Position = UDim2.fromScale(random_state:NextNumber(-0.25, 1.25), -0.25)
		clone_12_upvr.Rotation = random_state:NextNumber(-120, 120)
		local any_NextNumber_result1 = random_state:NextNumber(0.15, 0.2)
		clone_12_upvr.Size = UDim2.fromScale(any_NextNumber_result1, any_NextNumber_result1)
		clone_12_upvr.Parent = LocalPlayer_upvr.PlayerGui:FindFirstChild("Effects")
		CreateTween_upvr(clone_12_upvr, TweenInfo.new(random_state:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Position = clone_12_upvr.Position + UDim2.fromScale(0, 1.5);
			Rotation = clone_12_upvr.Rotation + random_state:NextInteger(-3, 3) * 10;
		}, true).Completed:Once(function() -- Line 277
			--[[ Upvalues[1]:
				[1]: clone_12_upvr (readonly)
			]]
			task.wait(1)
			clone_12_upvr:Destroy()
		end)
	end
end
local EventController_upvr = require(ReplicatedStorage_upvr.Controllers.EventController)
local any_RemoteEvent_result1_upvr_5 = Net:RemoteEvent(`EventService/{Name_upvr}/StartTransition`)
local any_RemoteEvent_result1_upvr_3 = Net:RemoteEvent(`EventService/{Name_upvr}/StopTransition`)
local any_RemoteEvent_result1_upvr_11 = Net:RemoteEvent(`EventService/{Name_upvr}/PointArrow`)
local any_RemoteEvent_result1_upvr_2 = Net:RemoteEvent(`EventService/{Name_upvr}/Grab`)
local Spr_upvr = require(ReplicatedStorage_upvr.Packages.Spr)
local FFlags_upvr = require(ReplicatedStorage_upvr.Packages.FFlags)
local ServerData_upvr = require(ReplicatedStorage_upvr.Datas.ServerData)
local HttpService_upvr = game:GetService("HttpService")
local any_RemoteEvent_result1_upvr_9 = Net:RemoteEvent(`EventService/{Name_upvr}/Delivery`)
local Animals_upvr = require(ReplicatedStorage_upvr.Shared.Animals)
local any_RemoteEvent_result1_upvr_12 = Net:RemoteEvent(`EventService/{Name_upvr}/SpawnBrainrot`)
local CycleController_upvr = require(ReplicatedStorage_upvr.Controllers.CycleController)
local EffectController_upvr = require(ReplicatedStorage_upvr.Controllers.EffectController)
function module.OnStart(arg1) -- Line 284
	--[[ Upvalues[24]:
		[1]: EventController_upvr (readonly)
		[2]: Name_upvr (readonly)
		[3]: any_new_result1_4_upvr (readonly)
		[4]: any_RemoteEvent_result1_upvr_5 (readonly)
		[5]: startTrainTravel_upvr (readonly)
		[6]: any_RemoteEvent_result1_upvr_3 (readonly)
		[7]: stopTrainTravel_upvr (readonly)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: any_RemoteEvent_result1_upvr_11 (readonly)
		[10]: RunService_upvr (readonly)
		[11]: LocalPlayer_upvr (readonly)
		[12]: Observers_upvr (readonly)
		[13]: any_RemoteEvent_result1_upvr_2 (readonly)
		[14]: Spr_upvr (readonly)
		[15]: SoundController_upvr (readonly)
		[16]: FFlags_upvr (readonly)
		[17]: ServerData_upvr (readonly)
		[18]: HttpService_upvr (readonly)
		[19]: any_RemoteEvent_result1_upvr_9 (readonly)
		[20]: Trove_upvr (readonly)
		[21]: Animals_upvr (readonly)
		[22]: any_RemoteEvent_result1_upvr_12 (readonly)
		[23]: CycleController_upvr (readonly)
		[24]: EffectController_upvr (readonly)
	]]
	local any_GetActiveEventData_result1_upvr = EventController_upvr:GetActiveEventData(Name_upvr)
	assert(any_GetActiveEventData_result1_upvr)
	local function _(arg1_5) -- Line 288, Named "calculateTimeLeft"
		--[[ Upvalues[1]:
			[1]: any_GetActiveEventData_result1_upvr (readonly)
		]]
		return math.max(any_GetActiveEventData_result1_upvr.startedAt + arg1_5 - workspace:GetServerTimeNow(), 0)
	end
	any_new_result1_4_upvr:Add(any_RemoteEvent_result1_upvr_5.OnClientEvent:Connect(startTrainTravel_upvr))
	any_new_result1_4_upvr:Add(any_RemoteEvent_result1_upvr_3.OnClientEvent:Connect(stopTrainTravel_upvr))
	local clone_4_upvw = any_new_result1_4_upvr:Clone(script.EntranceSign)
	clone_4_upvw.Parent = workspace
	any_new_result1_4_upvr:Add(ReplicatedStorage_upvr:GetAttributeChangedSignal("NorthPoleEventInMap"):Connect(function() -- Line 297
		--[[ Upvalues[3]:
			[1]: ReplicatedStorage_upvr (copied, readonly)
			[2]: clone_4_upvw (read and write)
			[3]: any_new_result1_4_upvr (copied, readonly)
		]]
		if ReplicatedStorage_upvr:GetAttribute("NorthPoleEventInMap") and clone_4_upvw then
			any_new_result1_4_upvr:Remove(clone_4_upvw)
			clone_4_upvw = nil
		end
	end))
	local any_Extend_result1_upvr = any_new_result1_4_upvr:Extend()
	local var99_upvw
	local var100_upvw
	any_new_result1_4_upvr:Add(any_RemoteEvent_result1_upvr_11.OnClientEvent:Connect(function(arg1_6, arg2) -- Line 307
		--[[ Upvalues[5]:
			[1]: any_Extend_result1_upvr (readonly)
			[2]: var99_upvw (read and write)
			[3]: var100_upvw (read and write)
			[4]: RunService_upvr (copied, readonly)
			[5]: LocalPlayer_upvr (copied, readonly)
		]]
		if arg1_6 == nil then
			any_Extend_result1_upvr:Clean()
		else
			var99_upvw = arg1_6
			var100_upvw = arg2
			any_Extend_result1_upvr:Add(function() -- Line 316
				--[[ Upvalues[2]:
					[1]: var99_upvw (copied, read and write)
					[2]: var100_upvw (copied, read and write)
				]]
				var99_upvw = nil
				var100_upvw = nil
			end)
			local clone = any_Extend_result1_upvr:Clone(script.PointingArrow)
			clone.Parent = workspace
			local Start_upvr = clone.Start
			local End_upvr = clone.End
			any_Extend_result1_upvr:Add(RunService_upvr.PreRender:Connect(function() -- Line 326
				--[[ Upvalues[6]:
					[1]: arg1_6 (readonly)
					[2]: LocalPlayer_upvr (copied, readonly)
					[3]: Start_upvr (readonly)
					[4]: var100_upvw (copied, read and write)
					[5]: any_Extend_result1_upvr (copied, readonly)
					[6]: End_upvr (readonly)
				]]
				-- KONSTANTERROR: [0] 1. Error Block 19 start (CF ANALYSIS FAILED)
				local var109
				if typeof(arg1_6) == "Instance" then
					var109 = arg1_6:GetPivot().Position
					-- KONSTANTWARNING: GOTO [26] #20
				end
				-- KONSTANTERROR: [0] 1. Error Block 19 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [14] 11. Error Block 20 start (CF ANALYSIS FAILED)
				if typeof(arg1_6) == "CFrame" then
					var109 = arg1_6.Position
				else
					var109 = arg1_6
				end
				local Character_3 = LocalPlayer_upvr.Character
				if Character_3 then
					local any_GetPivot_result1_3 = Character_3:GetPivot()
					Start_upvr:PivotTo(any_GetPivot_result1_3)
					if var100_upvw and (var109 - any_GetPivot_result1_3.Position).Magnitude <= 10 then
						any_Extend_result1_upvr:Clean()
					end
				end
				End_upvr:PivotTo(CFrame.new(var109))
				-- KONSTANTERROR: [14] 11. Error Block 20 end (CF ANALYSIS FAILED)
			end))
		end
	end))
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("NorthPoleEventGrabItem", function(arg1_7) -- Line 346
		--[[ Upvalues[2]:
			[1]: Observers_upvr (copied, readonly)
			[2]: any_RemoteEvent_result1_upvr_2 (copied, readonly)
		]]
		return Observers_upvr.observeAttribute(arg1_7, "GrabPrompt", function(arg1_8) -- Line 347
			--[[ Upvalues[2]:
				[1]: arg1_7 (readonly)
				[2]: any_RemoteEvent_result1_upvr_2 (copied, readonly)
			]]
			if arg1_8 == false then return end
			local ProximityPrompt_upvr_2 = Instance.new("ProximityPrompt")
			ProximityPrompt_upvr_2.Name = "ProximityPrompt"
			ProximityPrompt_upvr_2.ActionText = "Grab"
			ProximityPrompt_upvr_2.HoldDuration = 0.5
			ProximityPrompt_upvr_2.RequiresLineOfSight = false
			ProximityPrompt_upvr_2.Enabled = true
			ProximityPrompt_upvr_2.Parent = arg1_7
			local Name_upvr_2 = arg1_7.Name
			local any_Connect_result1_upvr_2 = ProximityPrompt_upvr_2.Triggered:Connect(function() -- Line 362
				--[[ Upvalues[2]:
					[1]: any_RemoteEvent_result1_upvr_2 (copied, readonly)
					[2]: Name_upvr_2 (readonly)
				]]
				any_RemoteEvent_result1_upvr_2:FireServer(Name_upvr_2)
			end)
			return function() -- Line 366
				--[[ Upvalues[2]:
					[1]: ProximityPrompt_upvr_2 (readonly)
					[2]: any_Connect_result1_upvr_2 (readonly)
				]]
				ProximityPrompt_upvr_2:Destroy()
				any_Connect_result1_upvr_2:Disconnect()
			end
		end)
	end, {workspace}))
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("NorthPolePlayerCollision", function(arg1_9) -- Line 373
		arg1_9.CanCollide = true
		return nil
	end, {workspace}))
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("NorthPoleDoor", function(arg1_10) -- Line 378
		--[[ Upvalues[3]:
			[1]: Observers_upvr (copied, readonly)
			[2]: Spr_upvr (copied, readonly)
			[3]: SoundController_upvr (copied, readonly)
		]]
		local any_GetPivot_result1_2_upvr = arg1_10:GetPivot()
		return Observers_upvr.observeAttribute(arg1_10, "Open", function(arg1_11) -- Line 380
			--[[ Upvalues[4]:
				[1]: Spr_upvr (copied, readonly)
				[2]: arg1_10 (readonly)
				[3]: any_GetPivot_result1_2_upvr (readonly)
				[4]: SoundController_upvr (copied, readonly)
			]]
			if not arg1_11 then
				Spr_upvr.target(arg1_10, 0.75, 3.5, {
					Pivot = any_GetPivot_result1_2_upvr;
				})
				SoundController_upvr:PlaySound(script.DoorClose, any_GetPivot_result1_2_upvr.Position, false)
			else
				Spr_upvr.target(arg1_10, 0.75, 3.5, {
					Pivot = any_GetPivot_result1_2_upvr * CFrame.Angles(0, (-math.pi/2), 0);
				})
				SoundController_upvr:PlaySound(script.DoorOpen, any_GetPivot_result1_2_upvr.Position, false)
			end
			return function() -- Line 389
				--[[ Upvalues[4]:
					[1]: arg1_10 (copied, readonly)
					[2]: Spr_upvr (copied, readonly)
					[3]: any_GetPivot_result1_2_upvr (copied, readonly)
					[4]: SoundController_upvr (copied, readonly)
				]]
				if arg1_10:IsDescendantOf(workspace) then
					Spr_upvr.target(arg1_10, 0.75, 3.5, {
						Pivot = any_GetPivot_result1_2_upvr;
					})
					SoundController_upvr:PlaySound(script.DoorClose, any_GetPivot_result1_2_upvr.Position, false)
				end
			end
		end)
	end, {workspace}))
	local tbl_upvr = {}
	local tbl_3_upvr = {}
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("NorthPoleSantaSleign", function(arg1_12) -- Line 400
		--[[ Upvalues[6]:
			[1]: ReplicatedStorage_upvr (copied, readonly)
			[2]: FFlags_upvr (copied, readonly)
			[3]: ServerData_upvr (copied, readonly)
			[4]: HttpService_upvr (copied, readonly)
			[5]: tbl_upvr (readonly)
			[6]: tbl_3_upvr (readonly)
		]]
		local Name_upvr_3 = arg1_12.Name
		local clone_upvr_2 = ReplicatedStorage_upvr.Models.Events["North Pole"].Sleigh:Clone()
		clone_upvr_2.PrimaryPart.Anchored = true
		if FFlags_upvr:GetInstant("Optimisation.HumanoidBrainrotModels", ServerData_upvr.IsNewPlayersServer()) then
			local AnimationController_2 = clone_upvr_2:FindFirstChild("AnimationController")
			if AnimationController_2 then
				AnimationController_2:Destroy()
			end
			local Humanoid_2 = Instance.new("Humanoid", clone_upvr_2)
			Humanoid_2.Name = "AnimationController"
			Humanoid_2.EvaluateStateMachine = false
			Humanoid_2.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			Humanoid_2.PlatformStand = true
			Humanoid_2.Parent = clone_upvr_2
		end
		clone_upvr_2.Parent = arg1_12
		local any_LoadAnimation_result1_upvr = clone_upvr_2.AnimationController.Animator:LoadAnimation(ReplicatedStorage_upvr.Models.Events["North Pole"].SleighFly)
		any_LoadAnimation_result1_upvr.Looped = true
		any_LoadAnimation_result1_upvr:Play()
		local function updateGifts() -- Line 429
			--[[ Upvalues[3]:
				[1]: HttpService_upvr (copied, readonly)
				[2]: arg1_12 (readonly)
				[3]: clone_upvr_2 (readonly)
			]]
			local any_JSONDecode_result1 = HttpService_upvr:JSONDecode(arg1_12:GetAttribute("Gifts") or "[]")
			for i_2 = 1, 10 do
				local SOME = clone_upvr_2.Gifts:FindFirstChild(tostring(i_2))
				if SOME then
					SOME:SetAttribute("GiftTexture", any_JSONDecode_result1[i_2] or "")
					SOME:AddTag("NorthPoleEventGiftTexture")
					for _, v in SOME:GetChildren() do
						local children = v:IsA("BasePart")
						if children then
							if i_2 <= #any_JSONDecode_result1 then
								children = 0
							else
								children = 1
							end
							v.Transparency = children
						end
					end
				end
			end
		end
		updateGifts()
		table.insert(tbl_upvr, arg1_12)
		tbl_3_upvr[Name_upvr_3] = clone_upvr_2
		local any_Connect_result1_upvr = arg1_12:GetAttributeChangedSignal("Gifts"):Connect(updateGifts)
		return function() -- Line 451
			--[[ Upvalues[7]:
				[1]: tbl_3_upvr (copied, readonly)
				[2]: Name_upvr_3 (readonly)
				[3]: tbl_upvr (copied, readonly)
				[4]: arg1_12 (readonly)
				[5]: any_Connect_result1_upvr (readonly)
				[6]: any_LoadAnimation_result1_upvr (readonly)
				[7]: clone_upvr_2 (readonly)
			]]
			tbl_3_upvr[Name_upvr_3] = nil
			local table_find_result1 = table.find(tbl_upvr, arg1_12)
			if table_find_result1 then
				table.remove(tbl_upvr, table_find_result1)
			end
			any_Connect_result1_upvr:Disconnect()
			any_LoadAnimation_result1_upvr:Stop(0)
			any_LoadAnimation_result1_upvr:Destroy()
			clone_upvr_2:Destroy()
		end
	end))
	any_new_result1_4_upvr:Add(RunService_upvr.PreRender:Connect(function(arg1_13) -- Line 468
		--[[ Upvalues[2]:
			[1]: tbl_upvr (readonly)
			[2]: tbl_3_upvr (readonly)
		]]
		debug.profilebegin("North Pole:BulkMoveTo")
		for _, v_2 in tbl_upvr do
			local var156 = tbl_3_upvr[v_2.Name]
			if var156 then
				table.insert({}, var156.PrimaryPart)
				table.insert({}, v_2.CFrame)
			end
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		workspace:BulkMoveTo({}, {}, Enum.BulkMoveMode.FireCFrameChanged)
		debug.profileend()
	end))
	local tbl_6_upvr = {}
	local OverlapParams_new_result1_upvr = OverlapParams.new()
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("NorthPoleDeliveryHitboxes", function(arg1_14) -- Line 487
		--[[ Upvalues[2]:
			[1]: tbl_6_upvr (readonly)
			[2]: OverlapParams_new_result1_upvr (readonly)
		]]
		table.insert(tbl_6_upvr, arg1_14)
		OverlapParams_new_result1_upvr.FilterDescendantsInstances = tbl_6_upvr
		return function() -- Line 490
			--[[ Upvalues[3]:
				[1]: tbl_6_upvr (copied, readonly)
				[2]: arg1_14 (readonly)
				[3]: OverlapParams_new_result1_upvr (copied, readonly)
			]]
			local table_find_result1_2 = table.find(tbl_6_upvr, arg1_14)
			if table_find_result1_2 then
				table.remove(tbl_6_upvr, table_find_result1_2)
				OverlapParams_new_result1_upvr.FilterDescendantsInstances = tbl_6_upvr
			end
		end
	end))
	OverlapParams_new_result1_upvr.FilterDescendantsInstances = tbl_6_upvr
	OverlapParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Include
	OverlapParams_new_result1_upvr.MaxParts = 1
	local var163_upvw = 0
	any_new_result1_4_upvr:Add(RunService_upvr.PostSimulation:Connect(function(arg1_15) -- Line 504
		--[[ Upvalues[4]:
			[1]: var163_upvw (read and write)
			[2]: LocalPlayer_upvr (copied, readonly)
			[3]: OverlapParams_new_result1_upvr (readonly)
			[4]: any_RemoteEvent_result1_upvr_9 (copied, readonly)
		]]
		var163_upvw += arg1_15
		if var163_upvw < 0.05 then
		else
			debug.profilebegin("NorthPole:Hitboxes")
			var163_upvw = 0
			if not LocalPlayer_upvr:GetAttribute("Stealing") then return end
			local Character_2 = LocalPlayer_upvr.Character
			if not Character_2 then
				debug.profileend()
				return
			end
			if #workspace:GetPartBoundsInBox(CFrame.new(Character_2:GetPivot().Position), Vector3.new(4, 4, 2), OverlapParams_new_result1_upvr) <= 0 then return end
			any_RemoteEvent_result1_upvr_9:FireServer()
			debug.profileend()
		end
	end))
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("NorthPoleSantaSpawner", function(arg1_16) -- Line 534
		--[[ Upvalues[7]:
			[1]: LocalPlayer_upvr (copied, readonly)
			[2]: Observers_upvr (copied, readonly)
			[3]: Trove_upvr (copied, readonly)
			[4]: HttpService_upvr (copied, readonly)
			[5]: Animals_upvr (copied, readonly)
			[6]: Spr_upvr (copied, readonly)
			[7]: any_RemoteEvent_result1_upvr_12 (copied, readonly)
		]]
		local clone_8_upvr = script.SpawnerUI:Clone()
		clone_8_upvr.Adornee = arg1_16
		clone_8_upvr.Parent = LocalPlayer_upvr.PlayerGui
		local any_observeAttribute_result1_upvr = Observers_upvr.observeAttribute(arg1_16, "Brainrots", function(arg1_17) -- Line 539
			--[[ Upvalues[7]:
				[1]: Trove_upvr (copied, readonly)
				[2]: HttpService_upvr (copied, readonly)
				[3]: clone_8_upvr (readonly)
				[4]: Animals_upvr (copied, readonly)
				[5]: arg1_16 (readonly)
				[6]: Spr_upvr (copied, readonly)
				[7]: any_RemoteEvent_result1_upvr_12 (copied, readonly)
			]]
			if arg1_17 == nil then
				return nil
			end
			local any_new_result1 = Trove_upvr.new()
			for _, v_3 in HttpService_upvr:JSONDecode(arg1_17) do
				local Brainrot_upvr = v_3.Brainrot
				local clone_11_upvr = any_new_result1:Clone(clone_8_upvr.ScrollingFrame.UIListLayout.Template)
				clone_11_upvr.Spacer.Title.Text = Brainrot_upvr
				local any_AttachOnViewport_result1 = Animals_upvr:AttachOnViewport(Brainrot_upvr, clone_11_upvr.Spacer.ViewportFrame, true)
				if any_AttachOnViewport_result1 then
					any_new_result1:Add(any_AttachOnViewport_result1)
				end
				clone_11_upvr.Spacer.Buy.Txt.Size = UDim2.fromScale(0.35, 0.8)
				clone_11_upvr.Spacer.Buy.Txt.Text = v_3.Price
				clone_11_upvr.Parent = clone_8_upvr.ScrollingFrame
				local Index_upvr = v_3.Index
				local function updateBuyButton() -- Line 562
					--[[ Upvalues[5]:
						[1]: HttpService_upvr (copied, readonly)
						[2]: arg1_16 (copied, readonly)
						[3]: Index_upvr (readonly)
						[4]: Spr_upvr (copied, readonly)
						[5]: clone_11_upvr (readonly)
					]]
					local any_JSONDecode_result1_2 = HttpService_upvr:JSONDecode(arg1_16:GetAttribute("Stocks") or "[]")
					if not Index_upvr or (any_JSONDecode_result1_2[Index_upvr] or 0) <= 0 then
						Spr_upvr.target(clone_11_upvr.Spacer.Buy, 1, 5, {
							BackgroundColor3 = Color3.fromRGB(150, 150, 150);
						})
						clone_11_upvr.Spacer.Amount.Text = "SOLD OUT"
						clone_11_upvr.Spacer.Amount.TextColor3 = Color3.fromRGB(255, 61, 61)
					else
						Spr_upvr.target(clone_11_upvr.Spacer.Buy, 1, 5, {
							BackgroundColor3 = Color3.fromRGB(81, 158, 86);
						})
						clone_11_upvr.Spacer.Amount.Text = `{any_JSONDecode_result1_2[Index_upvr] or 0} LEFT`
						clone_11_upvr.Spacer.Amount.TextColor3 = Color3.fromRGB(255, 213, 0)
					end
				end
				any_new_result1:Add(arg1_16:GetAttributeChangedSignal("Stocks"):Connect(updateBuyButton))
				updateBuyButton()
				any_new_result1:Add(clone_11_upvr.Spacer.Buy.Activated:Connect(function() -- Line 578
					--[[ Upvalues[2]:
						[1]: any_RemoteEvent_result1_upvr_12 (copied, readonly)
						[2]: Brainrot_upvr (readonly)
					]]
					any_RemoteEvent_result1_upvr_12:FireServer(Brainrot_upvr)
				end))
			end
			return any_new_result1:WrapClean()
		end)
		return function() -- Line 585
			--[[ Upvalues[2]:
				[1]: any_observeAttribute_result1_upvr (readonly)
				[2]: clone_8_upvr (readonly)
			]]
			any_observeAttribute_result1_upvr()
			clone_8_upvr:Destroy()
		end
	end))
	any_new_result1_4_upvr:Add(Observers_upvr.observeTag("Elf", function(arg1_18) -- Line 591
		--[[ Upvalues[3]:
			[1]: Trove_upvr (copied, readonly)
			[2]: any_new_result1_4_upvr (copied, readonly)
			[3]: Observers_upvr (copied, readonly)
		]]
		local any_new_result1_5 = Trove_upvr.new()
		local clone_3_upvr = any_new_result1_5:Clone(script.Elf)
		local any_Add_result1 = any_new_result1_5:Add(Instance.new("Weld"))
		any_Add_result1.Part0 = clone_3_upvr.PrimaryPart
		any_Add_result1.Part1 = arg1_18:WaitForChild("HumanoidRootPart")
		any_Add_result1.Parent = clone_3_upvr.PrimaryPart
		clone_3_upvr.Parent = arg1_18
		local AnimationController = clone_3_upvr:FindFirstChild("AnimationController")
		if AnimationController then
			AnimationController:Destroy()
		end
		local Humanoid = Instance.new("Humanoid", clone_3_upvr)
		Humanoid.Name = "AnimationController"
		Humanoid.EvaluateStateMachine = false
		Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		Humanoid.PlatformStand = true
		Humanoid.Parent = clone_3_upvr
		local Animator = clone_3_upvr.AnimationController.Animator
		local any_LoadAnimation_result1_upvr_3 = Animator:LoadAnimation(script.Idle)
		local var192 = any_new_result1_5
		if not var192 then
			var192 = any_new_result1_4_upvr
		end
		var192:Add(function() -- Line 70
			--[[ Upvalues[1]:
				[1]: any_LoadAnimation_result1_upvr_3 (readonly)
			]]
			any_LoadAnimation_result1_upvr_3:Stop(0)
			any_LoadAnimation_result1_upvr_3:Destroy()
		end)
		local var194 = any_LoadAnimation_result1_upvr_3
		var194.Looped = true
		var194.Priority = Enum.AnimationPriority.Idle
		var194:Play()
		any_LoadAnimation_result1_upvr_3 = script.Attack
		local any_LoadAnimation_result1_upvr_5 = Animator:LoadAnimation(any_LoadAnimation_result1_upvr_3)
		local var196 = any_new_result1_5
		if not var196 then
			var196 = any_new_result1_4_upvr
		end
		var196:Add(function() -- Line 70
			--[[ Upvalues[1]:
				[1]: any_LoadAnimation_result1_upvr_5 (readonly)
			]]
			any_LoadAnimation_result1_upvr_5:Stop(0)
			any_LoadAnimation_result1_upvr_5:Destroy()
		end)
		local var198_upvr = any_LoadAnimation_result1_upvr_5
		any_LoadAnimation_result1_upvr_3 = false
		var198_upvr.Looped = any_LoadAnimation_result1_upvr_3
		any_LoadAnimation_result1_upvr_3 = Enum.AnimationPriority.Action
		var198_upvr.Priority = any_LoadAnimation_result1_upvr_3
		any_new_result1_5:Add(var198_upvr:GetMarkerReachedSignal("CandyDisappear"):Once(function() -- Line 631
			--[[ Upvalues[1]:
				[1]: clone_3_upvr (readonly)
			]]
			clone_3_upvr.Candy.Transparency = 1
		end))
		any_new_result1_5:Add(arg1_18:GetAttributeChangedSignal("AttackAnimation"):Connect(function() -- Line 635
			--[[ Upvalues[1]:
				[1]: var198_upvr (readonly)
			]]
			var198_upvr:Play()
		end))
		any_LoadAnimation_result1_upvr_5 = script.Walk
		local any_LoadAnimation_result1_upvr_4 = Animator:LoadAnimation(any_LoadAnimation_result1_upvr_5)
		local var202 = any_new_result1_5
		if not var202 then
			var202 = any_new_result1_4_upvr
		end
		var202:Add(function() -- Line 70
			--[[ Upvalues[1]:
				[1]: any_LoadAnimation_result1_upvr_4 (readonly)
			]]
			any_LoadAnimation_result1_upvr_4:Stop(0)
			any_LoadAnimation_result1_upvr_4:Destroy()
		end)
		any_LoadAnimation_result1_upvr_3 = any_LoadAnimation_result1_upvr_4
		local var204_upvr = any_LoadAnimation_result1_upvr_3
		any_LoadAnimation_result1_upvr_5 = Enum.AnimationPriority.Action2
		var204_upvr.Priority = any_LoadAnimation_result1_upvr_5
		any_new_result1_5:Add(Observers_upvr.observeAttribute(arg1_18, "IsRunning", function(arg1_19) -- Line 642
			--[[ Upvalues[1]:
				[1]: var204_upvr (readonly)
			]]
			if arg1_19 then
				var204_upvr:Play()
				var204_upvr:AdjustSpeed(1.5)
			else
				var204_upvr:Stop()
			end
			return nil
		end))
		any_LoadAnimation_result1_upvr_5 = any_new_result1_5:WrapClean()
		return any_LoadAnimation_result1_upvr_5
	end))
	any_new_result1_4_upvr:Add(ReplicatedStorage_upvr:GetAttributeChangedSignal("NorthPoleEventActive"):Connect(function() -- Line 656
		--[[ Upvalues[2]:
			[1]: CycleController_upvr (copied, readonly)
			[2]: SoundController_upvr (copied, readonly)
		]]
		CycleController_upvr:Update()
		SoundController_upvr:UpdateOST()
	end))
	any_new_result1_4_upvr:Add(function() -- Line 661
		--[[ Upvalues[4]:
			[1]: stopTrainTravel_upvr (copied, readonly)
			[2]: EffectController_upvr (copied, readonly)
			[3]: CycleController_upvr (copied, readonly)
			[4]: SoundController_upvr (copied, readonly)
		]]
		task.spawn(stopTrainTravel_upvr)
		EffectController_upvr:Activate("Blink")
		CycleController_upvr:Update()
		SoundController_upvr:UpdateOST()
	end)
end
function module.OnStop(arg1) -- Line 669
	--[[ Upvalues[1]:
		[1]: any_new_result1_4_upvr (readonly)
	]]
	any_new_result1_4_upvr:Destroy()
end
local ContentProvider_upvr = game:GetService("ContentProvider")
local any_RemoteEvent_result1_upvr_4 = Net:RemoteEvent(`EventService/{Name_upvr}/GiftBurst`)
local VFX_upvr = require(ReplicatedStorage_upvr.Shared.VFX)
local AnimalController_upvr = require(ReplicatedStorage_upvr.Controllers.AnimalController)
local any_RemoteEvent_result1_upvr_10 = Net:RemoteEvent(`EventService/{Name_upvr}/SpawnGift`)
local MathUtils_upvr = require(ReplicatedStorage_upvr.Utils.MathUtils)
local any_RemoteEvent_result1_upvr = Net:RemoteEvent(`EventService/{Name_upvr}/OpenGift`)
local any_RemoteEvent_result1_upvr_7 = Net:RemoteEvent(`EventService/{Name_upvr}/DestroyGift`)
local any_RemoteEvent_result1_upvr_6 = Net:RemoteEvent(`EventService/{Name_upvr}/CandyCaneAnimation`)
local any_RemoteEvent_result1_upvr_8 = Net:RemoteEvent(`EventService/{Name_upvr}/Burst`)
function module.OnLoad(arg1) -- Line 673
	--[[ Upvalues[20]:
		[1]: ContentProvider_upvr (readonly)
		[2]: ReplicatedStorage_upvr (readonly)
		[3]: any_RemoteEvent_result1_upvr_4 (readonly)
		[4]: any_new_result1_4_upvr (readonly)
		[5]: VFX_upvr (readonly)
		[6]: SoundController_upvr (readonly)
		[7]: AnimalController_upvr (readonly)
		[8]: Observers_upvr (readonly)
		[9]: any_RemoteEvent_result1_upvr_10 (readonly)
		[10]: RaycastParams_new_result1_upvr (readonly)
		[11]: RunService_upvr (readonly)
		[12]: TweenService_upvr (readonly)
		[13]: MathUtils_upvr (readonly)
		[14]: any_RemoteEvent_result1_upvr (readonly)
		[15]: any_RemoteEvent_result1_upvr_7 (readonly)
		[16]: any_RemoteEvent_result1_upvr_6 (readonly)
		[17]: LocalPlayer_upvr (readonly)
		[18]: playScreenCandyCaneAnimation_upvr (readonly)
		[19]: playCharacterAnimation_upvr (readonly)
		[20]: any_RemoteEvent_result1_upvr_8 (readonly)
	]]
	task.spawn(pcall, function() -- Line 674
		--[[ Upvalues[1]:
			[1]: ContentProvider_upvr (copied, readonly)
		]]
		ContentProvider_upvr:PreloadAsync(script:GetChildren())
	end)
	task.spawn(pcall, function() -- Line 678
		--[[ Upvalues[2]:
			[1]: ContentProvider_upvr (copied, readonly)
			[2]: ReplicatedStorage_upvr (copied, readonly)
		]]
		ContentProvider_upvr:PreloadAsync(ReplicatedStorage_upvr.Models.Events["North Pole"]:GetChildren())
	end)
	task.spawn(pcall, function() -- Line 682
		--[[ Upvalues[2]:
			[1]: ContentProvider_upvr (copied, readonly)
			[2]: ReplicatedStorage_upvr (copied, readonly)
		]]
		ContentProvider_upvr:PreloadAsync(ReplicatedStorage_upvr.Sounds.Events["North Pole"]:GetChildren())
	end)
	any_RemoteEvent_result1_upvr_4.OnClientEvent:Connect(function(arg1_20) -- Line 686
		--[[ Upvalues[5]:
			[1]: any_new_result1_4_upvr (copied, readonly)
			[2]: VFX_upvr (copied, readonly)
			[3]: SoundController_upvr (copied, readonly)
			[4]: ReplicatedStorage_upvr (copied, readonly)
			[5]: AnimalController_upvr (copied, readonly)
		]]
		if typeof(arg1_20) == "Instance" then
			local clone_14_upvr = any_new_result1_4_upvr:Clone(script.GiftBurst)
			clone_14_upvr.Anchored = false
			clone_14_upvr:PivotTo(arg1_20:GetPivot())
			clone_14_upvr.Parent = workspace
			local Weld = Instance.new("Weld")
			Weld.Part0 = clone_14_upvr
			Weld.Part1 = arg1_20
			Weld.Parent = clone_14_upvr
			VFX_upvr.emit(clone_14_upvr)
			task.delay(5, function() -- Line 699
				--[[ Upvalues[1]:
					[1]: clone_14_upvr (readonly)
				]]
				clone_14_upvr:Destroy()
			end)
			task.spawn(function() -- Line 703
				--[[ Upvalues[3]:
					[1]: SoundController_upvr (copied, readonly)
					[2]: ReplicatedStorage_upvr (copied, readonly)
					[3]: clone_14_upvr (readonly)
				]]
				SoundController_upvr:PlaySound(ReplicatedStorage_upvr.Sounds.Events["North Pole"].PresentOpen, clone_14_upvr:GetPivot().Position)
			end)
		else
			clone_14_upvr = typeof(arg1_20)
			if clone_14_upvr == "Vector3" then
				clone_14_upvr = any_new_result1_4_upvr:Clone(script.GiftBurst)
				local var226_upvr = clone_14_upvr
				var226_upvr.Anchored = true
				var226_upvr:PivotTo(CFrame.new(arg1_20))
				var226_upvr.Parent = workspace
				VFX_upvr.emit(var226_upvr)
				local function var227() -- Line 715
					--[[ Upvalues[1]:
						[1]: var226_upvr (readonly)
					]]
					var226_upvr:Destroy()
				end
				task.delay(5, var227)
				task.spawn(function() -- Line 719
					--[[ Upvalues[3]:
						[1]: SoundController_upvr (copied, readonly)
						[2]: ReplicatedStorage_upvr (copied, readonly)
						[3]: var226_upvr (readonly)
					]]
					SoundController_upvr:PlaySound(ReplicatedStorage_upvr.Sounds.Events["North Pole"].PresentOpen, var226_upvr:GetPivot().Position)
				end)
				return
			end
			var226_upvr = AnimalController_upvr:GetAnimals()
			local var229 = var226_upvr[arg1_20]
			if not var229 then return end
			local AnimalModel = var229.AnimalModel
			var227 = AnimalModel
			local var231 = var227
			if var231 then
				var231 = AnimalModel.PrimaryPart
			end
			local Instance = var229.Instance
			local var233 = Instance
			if var233 then
				var233 = Instance.PrimaryPart
			end
			if not var233 or not var231 then return end
			local clone_10_upvr = any_new_result1_4_upvr:Clone(script.GiftBurst)
			clone_10_upvr:PivotTo(var233.CFrame * CFrame.new(0, (clone_10_upvr.Size.Y + AnimalModel:GetExtentsSize().Y) / 2, 0))
			clone_10_upvr.Parent = Instance
			local WeldConstraint = Instance.new("WeldConstraint")
			WeldConstraint.Part0 = clone_10_upvr
			WeldConstraint.Part1 = var229.AnimalModel.PrimaryPart
			WeldConstraint.Parent = clone_10_upvr
			VFX_upvr.emit(clone_10_upvr)
			task.delay(5, function() -- Line 753
				--[[ Upvalues[1]:
					[1]: clone_10_upvr (readonly)
				]]
				clone_10_upvr:Destroy()
			end)
			task.spawn(function() -- Line 757
				--[[ Upvalues[3]:
					[1]: SoundController_upvr (copied, readonly)
					[2]: ReplicatedStorage_upvr (copied, readonly)
					[3]: clone_10_upvr (readonly)
				]]
				SoundController_upvr:PlaySound(ReplicatedStorage_upvr.Sounds.Events["North Pole"].PresentOpen, clone_10_upvr:GetPivot().Position)
			end)
		end
	end)
	local tbl_5_upvr = {"rbxassetid://106128825959360", "rbxassetid://84670396546354", "rbxassetid://131357512835082", "rbxassetid://94526507693712"}
	Observers_upvr.observeTag("NorthPoleEventGiftTexture", function(arg1_21) -- Line 769
		--[[ Upvalues[2]:
			[1]: tbl_5_upvr (readonly)
			[2]: Observers_upvr (copied, readonly)
		]]
		local var242 = arg1_21:GetAttribute("GiftTexture") or ""
		local var243 = 0
		for i_6 = 1, #var242 do
			var243 = (var243 * 31 + string.byte(var242, i_6)) % 4294967296
		end
		local var244_upvr = tbl_5_upvr[var243 % #tbl_5_upvr + 1]
		if not var244_upvr then
			var244_upvr = tbl_5_upvr[1]
		end
		return Observers_upvr.observeDescendants(arg1_21, function(arg1_22) -- Line 781
			--[[ Upvalues[1]:
				[1]: var244_upvr (readonly)
			]]
			if not arg1_22:IsA("MeshPart") then
				return nil
			end
			local TextureID_upvr = arg1_22.TextureID
			if TextureID_upvr == "" then
				return nil
			end
			arg1_22.TextureID = var244_upvr
			return function() -- Line 792
				--[[ Upvalues[2]:
					[1]: arg1_22 (readonly)
					[2]: TextureID_upvr (readonly)
				]]
				arg1_22.TextureID = TextureID_upvr
			end
		end)
	end)
	local tbl_4_upvr = {}
	any_RemoteEvent_result1_upvr_10.OnClientEvent:Connect(function(arg1_23, arg2, arg3, arg4, arg5, arg6) -- Line 800
		--[[ Upvalues[9]:
			[1]: ReplicatedStorage_upvr (copied, readonly)
			[2]: tbl_4_upvr (readonly)
			[3]: SoundController_upvr (copied, readonly)
			[4]: RaycastParams_new_result1_upvr (copied, readonly)
			[5]: RunService_upvr (copied, readonly)
			[6]: TweenService_upvr (copied, readonly)
			[7]: MathUtils_upvr (copied, readonly)
			[8]: VFX_upvr (copied, readonly)
			[9]: any_RemoteEvent_result1_upvr (copied, readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local clone_upvr = ReplicatedStorage_upvr.Models.Events["North Pole"].WrappedGift:Clone()
		clone_upvr.Name = arg1_23
		clone_upvr:SetAttribute("GiftTexture", arg1_23)
		clone_upvr:AddTag("NorthPoleEventGiftTexture")
		tbl_4_upvr[arg1_23] = clone_upvr
		local PrimaryPart = clone_upvr.PrimaryPart
		if not PrimaryPart then
			PrimaryPart = clone_upvr:FindFirstChild("Handle")
		end
		if PrimaryPart then
			PrimaryPart.Anchored = true
			local Attachment = Instance.new("Attachment")
			Attachment.Name = "Attachment0"
			Attachment.Position = Vector3.new(0, 1, 0)
			Attachment.Parent = PrimaryPart
			local Attachment_2 = Instance.new("Attachment")
			Attachment_2.Name = "Attachment1"
			Attachment_2.Position = Vector3.new(0, -1, 0)
			Attachment_2.Parent = PrimaryPart
			local Trail = Instance.new("Trail")
			Trail.Name = "Trail"
			Trail.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 69, 69)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 69, 69))})
			Trail.Attachment0 = Attachment
			Trail.Attachment1 = Attachment_2
			Trail.Lifetime = 0.35
			Trail.LightInfluence = 1
			Trail.Parent = clone_upvr
		end
		clone_upvr.Parent = workspace
		local ProximityPrompt_upvr = Instance.new("ProximityPrompt")
		ProximityPrompt_upvr.Name = "ProximityPrompt"
		ProximityPrompt_upvr.ActionText = "Open"
		ProximityPrompt_upvr.RequiresLineOfSight = false
		ProximityPrompt_upvr.Enabled = false
		ProximityPrompt_upvr.HoldDuration = 0.5
		ProximityPrompt_upvr.Parent = PrimaryPart
		task.spawn(function() -- Line 848
			--[[ Upvalues[4]:
				[1]: SoundController_upvr (copied, readonly)
				[2]: ReplicatedStorage_upvr (copied, readonly)
				[3]: arg3 (readonly)
				[4]: clone_upvr (readonly)
			]]
			SoundController_upvr:PlaySound(ReplicatedStorage_upvr.Sounds.Events["North Pole"].SantaHoHoHo, arg3, false)
			local clone_9_upvr = ReplicatedStorage_upvr.Sounds.Events["North Pole"].PresentDrop:Clone()
			clone_9_upvr.Parent = clone_upvr.PrimaryPart
			clone_9_upvr:Play()
			clone_9_upvr.Ended:Once(function() -- Line 855
				--[[ Upvalues[1]:
					[1]: clone_9_upvr (readonly)
				]]
				clone_9_upvr:Destroy()
			end)
		end)
		local workspace_Raycast_result1 = workspace:Raycast(arg4 + Vector3.new(0, 10, 0), Vector3.new(-0, -30, -0), RaycastParams_new_result1_upvr)
		if not workspace_Raycast_result1 or not workspace_Raycast_result1.Position then
		end
		local var261_upvr = arg4
		local var263_upvr = arg3 + (var261_upvr - arg3) * 0.5
		local any_GetScale_result1_upvr = clone_upvr:GetScale()
		local var265_upvw = false
		local any_Connect_result1_upvr_3 = RunService_upvr.PostSimulation:Connect(function(arg1_24) -- Line 871
			--[[ Upvalues[12]:
				[1]: arg5 (readonly)
				[2]: arg6 (readonly)
				[3]: TweenService_upvr (copied, readonly)
				[4]: MathUtils_upvr (copied, readonly)
				[5]: arg3 (readonly)
				[6]: var263_upvr (readonly)
				[7]: var261_upvr (readonly)
				[8]: clone_upvr (readonly)
				[9]: any_GetScale_result1_upvr (readonly)
				[10]: var265_upvw (read and write)
				[11]: VFX_upvr (copied, readonly)
				[12]: ProximityPrompt_upvr (readonly)
			]]
			local var266
			if arg6 == 0 then
				var266 = 1
			else
				var266 = math.clamp((workspace:GetServerTimeNow() - arg5) / arg6, 0, 1)
			end
			local any_GetValue_result1_2 = TweenService_upvr:GetValue(var266, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			clone_upvr:ScaleTo(math.lerp(any_GetScale_result1_upvr * 2, any_GetScale_result1_upvr, any_GetValue_result1_2))
			clone_upvr:PivotTo(CFrame.new(MathUtils_upvr.quadBezier(any_GetValue_result1_2, arg3, var263_upvr, var261_upvr)) * CFrame.Angles(0, math.lerp(12.566370614359172, 0, any_GetValue_result1_2), 0))
			if 0.8 <= any_GetValue_result1_2 and not var265_upvw then
				var265_upvw = true
				local clone_upvr_3 = script.GiftLanding:Clone()
				clone_upvr_3:PivotTo(CFrame.new(var261_upvr))
				clone_upvr_3.Parent = workspace
				VFX_upvr.emit(clone_upvr_3)
				task.delay(5, function() -- Line 890
					--[[ Upvalues[1]:
						[1]: clone_upvr_3 (readonly)
					]]
					clone_upvr_3:Destroy()
				end)
			end
			clone_upvr_3 = 1
			if clone_upvr_3 <= any_GetValue_result1_2 then
				clone_upvr_3 = ProximityPrompt_upvr
				clone_upvr_3.Enabled = true
			end
		end)
		clone_upvr.Destroying:Connect(function() -- Line 900
			--[[ Upvalues[1]:
				[1]: any_Connect_result1_upvr_3 (readonly)
			]]
			any_Connect_result1_upvr_3:Disconnect()
		end)
		ProximityPrompt_upvr.Triggered:Connect(function() -- Line 904
			--[[ Upvalues[2]:
				[1]: any_RemoteEvent_result1_upvr (copied, readonly)
				[2]: arg1_23 (readonly)
			]]
			any_RemoteEvent_result1_upvr:FireServer(arg1_23)
		end)
	end)
	any_RemoteEvent_result1_upvr_7.OnClientEvent:Connect(function(arg1_25) -- Line 909
		--[[ Upvalues[1]:
			[1]: tbl_4_upvr (readonly)
		]]
		local var274 = tbl_4_upvr[arg1_25]
		if not var274 then
		else
			var274:Destroy()
			tbl_4_upvr[arg1_25] = nil
		end
	end)
	any_RemoteEvent_result1_upvr_6.OnClientEvent:Connect(function(arg1_26, arg2, arg3, arg4) -- Line 919
		--[[ Upvalues[7]:
			[1]: ReplicatedStorage_upvr (copied, readonly)
			[2]: RunService_upvr (copied, readonly)
			[3]: TweenService_upvr (copied, readonly)
			[4]: MathUtils_upvr (copied, readonly)
			[5]: LocalPlayer_upvr (copied, readonly)
			[6]: playScreenCandyCaneAnimation_upvr (copied, readonly)
			[7]: playCharacterAnimation_upvr (copied, readonly)
		]]
		local Model_upvr = Instance.new("Model")
		local clone_5 = ReplicatedStorage_upvr.Models.Events["North Pole"]["Candy Cane Tiers"][arg3]:Clone()
		clone_5.Parent = Model_upvr
		if clone_5:IsA("Model") then
			Model_upvr.PrimaryPart = clone_5.PrimaryPart
		else
			Model_upvr.PrimaryPart = clone_5
		end
		Model_upvr.Parent = workspace
		local var279_upvw = 0
		local any_GetScale_result1_upvr_2 = Model_upvr:GetScale()
		local var281_upvw
		var281_upvw = RunService_upvr.PostSimulation:Connect(function(arg1_27) -- Line 941
			--[[ Upvalues[12]:
				[1]: var279_upvw (read and write)
				[2]: arg2 (readonly)
				[3]: arg1_26 (readonly)
				[4]: TweenService_upvr (copied, readonly)
				[5]: Model_upvr (readonly)
				[6]: MathUtils_upvr (copied, readonly)
				[7]: any_GetScale_result1_upvr_2 (readonly)
				[8]: var281_upvw (read and write)
				[9]: LocalPlayer_upvr (copied, readonly)
				[10]: playScreenCandyCaneAnimation_upvr (copied, readonly)
				[11]: playCharacterAnimation_upvr (copied, readonly)
				[12]: arg4 (readonly)
			]]
			debug.profilebegin("North Pole:UpdateCandyAnimation")
			var279_upvw += arg1_27
			local var286
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var286 = arg2.Character:GetPivot().Position
				return var286
			end
			if not arg2.Character or not INLINED() then
				var286 = Vector3.new(0, 0, 0)
			end
			local any_GetValue_result1 = TweenService_upvr:GetValue(var279_upvw / 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
			Model_upvr:PivotTo(CFrame.new(MathUtils_upvr.quadBezier(any_GetValue_result1, arg1_26, arg1_26 + (var286 - arg1_26) * 0.25 + Vector3.new(0, 20, 0), var286)))
			Model_upvr:ScaleTo(math.lerp(any_GetScale_result1_upvr_2, 0.05, any_GetValue_result1))
			if 1 <= any_GetValue_result1 and var281_upvw then
				var281_upvw:Disconnect()
				var281_upvw = nil
				for _, v_4 in Model_upvr:GetDescendants() do
					if v_4:IsA("BasePart") then
						v_4.Transparency = 1
					end
				end
				task.delay(3, function() -- Line 962
					--[[ Upvalues[1]:
						[1]: Model_upvr (copied, readonly)
					]]
					Model_upvr:Destroy()
				end)
				if arg2 == LocalPlayer_upvr then
					playScreenCandyCaneAnimation_upvr()
				end
				playCharacterAnimation_upvr(arg2, arg4)
			end
			debug.profileend()
		end)
	end)
	any_RemoteEvent_result1_upvr_8.OnClientEvent:Connect(function(arg1_28, arg2, arg3) -- Line 976
		--[[ Upvalues[4]:
			[1]: SoundController_upvr (copied, readonly)
			[2]: ReplicatedStorage_upvr (copied, readonly)
			[3]: VFX_upvr (copied, readonly)
			[4]: playCharacterAnimation_upvr (copied, readonly)
		]]
		local Position_upvr = arg1_28:GetPivot().Position
		task.spawn(function() -- Line 979
			--[[ Upvalues[3]:
				[1]: SoundController_upvr (copied, readonly)
				[2]: ReplicatedStorage_upvr (copied, readonly)
				[3]: Position_upvr (readonly)
			]]
			SoundController_upvr:PlaySound(ReplicatedStorage_upvr.Sounds.Events["North Pole"].CandyCane, Position_upvr)
		end)
		local clone_6_upvr = script.Burst:Clone()
		clone_6_upvr:PivotTo(CFrame.new(Position_upvr))
		clone_6_upvr.Anchored = false
		local WeldConstraint_2 = Instance.new("WeldConstraint")
		WeldConstraint_2.Part0 = clone_6_upvr
		WeldConstraint_2.Part1 = arg1_28
		WeldConstraint_2.Parent = clone_6_upvr
		clone_6_upvr.Parent = workspace
		VFX_upvr.emit(clone_6_upvr)
		task.delay(5, function() -- Line 996
			--[[ Upvalues[1]:
				[1]: clone_6_upvr (readonly)
			]]
			clone_6_upvr:Destroy()
		end)
		if arg2 and arg3 then
			playCharacterAnimation_upvr(arg2, arg3)
		end
	end)
end
return module