-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:23:04
-- Luau version 6, Types version 3
-- Time taken: 0.004581 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Harvester";
})
local var4_upvw
local TweenService_upvr = game:GetService("TweenService")
local var6_upvw
function any_new_result1.setOriginalData(arg1, arg2) -- Line 30
	arg2:SetAttribute("scale", arg2:GetScale())
	arg2:SetAttribute("cframe", arg2:GetPivot())
end
function any_new_result1.setOriginalDatas(arg1) -- Line 35
	for _, v in arg1.Instance.Grain:GetChildren() do
		if v:IsA("Model") then
			arg1:setOriginalData(v)
		end
	end
	arg1:setOriginalData(arg1.Instance.Main)
end
function any_new_result1.growGrain(arg1) -- Line 47
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	for _, v_2_upvr in arg1.Instance.Grain:GetChildren() do
		if v_2_upvr:IsA("Model") then
		task.spawn(function() -- Line 53
				--[[ Upvalues[2]:
					[1]: v_2_upvr (readonly)
					[2]: TweenService_upvr (copied, readonly)
				]]
				local NumberValue_upvr = Instance.new("NumberValue")
				NumberValue_upvr.Value = 0.01
				-- Fixed: connect Changed BEFORE tween plays so it drives ScaleTo during animation
				local conn = NumberValue_upvr.Changed:Connect(function()
					v_2_upvr:ScaleTo(NumberValue_upvr.Value)
				end)
				TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
					Value = v_2_upvr:GetAttribute("scale");
				}):Play()
				task.wait(0.25)
				conn:Disconnect()
				NumberValue_upvr:Destroy()
		end)
		end
	end
end
function any_new_result1.harvestGrain(arg1, arg2) -- Line 72
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	for _, v_3_upvr in arg1.Instance.Grain:GetChildren() do
		if v_3_upvr:IsA("Model") and v_3_upvr.Name == arg2 then
			task.spawn(function() -- Line 82
				--[[ Upvalues[2]:
					[1]: v_3_upvr (readonly)
					[2]: TweenService_upvr (copied, readonly)
				]]
				local NumberValue_upvr_2 = Instance.new("NumberValue")
				NumberValue_upvr_2.Value = v_3_upvr:GetAttribute("scale") or 1
				local any_GetPivot_result1_upvr = v_3_upvr:GetPivot()
				-- Fixed: connect Changed BEFORE tween plays so it drives PivotTo/ScaleTo during animation
				local conn = NumberValue_upvr_2.Changed:Connect(function()
					v_3_upvr:PivotTo(any_GetPivot_result1_upvr)
					v_3_upvr:ScaleTo(NumberValue_upvr_2.Value)
				end)
				TweenService_upvr:Create(NumberValue_upvr_2, TweenInfo.new(0.25), {
					Value = 0.01;
				}):Play()
				task.wait(0.25)
				conn:Disconnect()
				NumberValue_upvr_2:Destroy()
			end)
		end
	end
end
local RunService_upvr = game:GetService("RunService")
function any_new_result1.spin(arg1) -- Line 102
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	RunService_upvr.RenderStepped:Connect(function(arg1_2) -- Line 103
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if not arg1.Instance:FindFirstChild("Main") then
		else
			if not arg1.Instance.Main:FindFirstChild("Spin") then return end
			arg1.Instance.Main.Spin.CFrame = arg1.Instance.Main.Spin.CFrame * CFrame.Angles(-0.03490658503988659, 0, 0)
		end
	end)
end
local random_state_upvr = Random.new()
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function any_new_result1.run(arg1) -- Line 114
	--[[ Upvalues[4]:
		[1]: random_state_upvr (readonly)
		[2]: var6_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: TweenService_upvr (readonly)
	]]
	task.spawn(function() -- Line 115
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: random_state_upvr (copied, readonly)
			[3]: var6_upvw (copied, read and write)
			[4]: LocalPlayer_upvr (copied, readonly)
			[5]: TweenService_upvr (copied, readonly)
		]]
		arg1:spin()
		while task.wait(random_state_upvr:NextNumber(10, 30)) do
			local any_getHRP_result1 = var6_upvw.getHRP(LocalPlayer_upvr)
			if any_getHRP_result1 and arg1.Instance:FindFirstChild("Main") and arg1.Instance.Main.PrimaryPart and 300 >= (any_getHRP_result1.Position - arg1.Instance.Main.PrimaryPart.Position).Magnitude then
				arg1:growGrain()
				task.wait(5)
				local cframe = arg1.Instance.Main:GetAttribute("cframe")
				local CFrameValue_upvr = Instance.new("CFrameValue")
				CFrameValue_upvr.Value = cframe
				local NumberValue_upvr_3 = Instance.new("NumberValue")
				-- Fixed: set up Changed connections BEFORE tweens play so they drive the animations
				local connCF = CFrameValue_upvr.Changed:Connect(function()
					arg1.Instance.Main:PivotTo(CFrameValue_upvr.Value)
				end)
				local connNV = NumberValue_upvr_3.Changed:Connect(function()
					for _, v_4 in arg1.Instance.Main:GetChildren() do
						if v_4:GetAttribute("isWheel") then
							v_4:PivotTo(v_4:GetPivot() * CFrame.Angles(math.rad(NumberValue_upvr_3.Value * v_4:GetAttribute("multiply")), 0, 0))
						end
					end
				end)
				TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Value = cframe + cframe.LookVector * 12;
				}):Play()
				task.spawn(function() -- Line 161
					--[[ Upvalues[2]:
						[1]: TweenService_upvr (copied, readonly)
						[2]: NumberValue_upvr_3 (readonly)
					]]
					TweenService_upvr:Create(NumberValue_upvr_3, TweenInfo.new(4), {
						Value = 1;
					}):Play()
					task.wait(2)
					TweenService_upvr:Create(NumberValue_upvr_3, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Value = 0;
					}):Play()
				end)
				task.wait(1.8)
				arg1:harvestGrain('1')
				task.wait(1)
				arg1:harvestGrain('2')
				task.wait(2)
				TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Value = cframe;
				}):Play()
				task.spawn(function() -- Line 176
					--[[ Upvalues[2]:
						[1]: TweenService_upvr (copied, readonly)
						[2]: NumberValue_upvr_3 (readonly)
					]]
					TweenService_upvr:Create(NumberValue_upvr_3, TweenInfo.new(6), {
						Value = -1;
					}):Play()
					task.wait(3)
					TweenService_upvr:Create(NumberValue_upvr_3, TweenInfo.new(4), {
						Value = 0;
					}):Play()
				end)
				task.wait(6)
				connCF:Disconnect()
				connNV:Disconnect()
				CFrameValue_upvr:Destroy()
				NumberValue_upvr_3:Destroy()
			end
		end
	end)
end
function any_new_result1.onMapChange(arg1) -- Line 192
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.onMapChange:Connect(function() -- Line 193
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		if var4_upvw:getCurrentMap() ~= "Farm" then
		else
			if arg1._isRunning then return end
			arg1._isRunning = true
			arg1:setOriginalDatas()
			arg1:run()
		end
	end)
end
function any_new_result1.Start(arg1) -- Line 208
	arg1:onMapChange()
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 212
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
	]]
	var4_upvw = Knit_upvr.GetController("MapController")
	var6_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1