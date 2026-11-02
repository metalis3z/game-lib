-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-12-08 12:49:46
-- Luau version 6, Types version 3
-- Time taken: 0.002586 seconds

local RunService_upvr = game:GetService("RunService")
local tbl_upvr = {}
for i = 1, 4 do
	if script.Parent:FindFirstChild("Blood"..i) then
		tbl_upvr[i] = game:GetService("TweenService"):Create(script.Parent["Blood"..i], TweenInfo.new(2, Enum.EasingStyle.Exponential), {
			Position = ({Vector3.new(0, 0, 4), Vector3.new(4, 0, 0), Vector3.new(0, 0, -4), Vector3.new(-4, 0, 0)})[i];
		})
		tbl_upvr[i]:Play()
	end
end
script.Parent:WaitForChild("Smear").Enabled = false
function quadraticBezier(arg1, arg2, arg3, arg4) -- Line 20
	return (1 - arg1) ^ 2 * arg2 + 2 * (1 - arg1) * arg1 * arg3 + arg1 ^ 2 * arg4
end
local var8_upvw = 0
local var9_upvr = CFrame.new(0, 3, 0) * CFrame.Angles(-0.3490658503988659, 0, 0)
RunService_upvr.Stepped:Connect(function(arg1, arg2) -- Line 26
	--[[ Upvalues[2]:
		[1]: var8_upvw (read and write)
		[2]: var9_upvr (readonly)
	]]
	var8_upvw += 1 * arg2
	local Weld = script.Parent.Weld
	Weld.C1 *= CFrame.Angles(0, math.rad(160 * arg2), 0)
	script.Parent.Weld.C0 = var9_upvr * CFrame.Angles(math.sin(var8_upvw) * 10, 0, math.sin(var8_upvw) * 10) + Vector3.new(0, math.sin(var8_upvw) - 1, 0)
end)
local Parent_upvr = script.Parent.Parent.Parent
if script.Parent:GetAttribute("Charge") < 4 then
	for i_2 = 4, script.Parent:GetAttribute("Charge") + 1, -1 do
		if script.Parent:FindFirstChild("Blood"..i_2) then
			script.Parent["Blood"..i_2]:Destroy()
		end
	end
end
local Debris_upvr = game:GetService("Debris")
local HumanoidRootPart_upvr = Parent_upvr.HumanoidRootPart
script.Parent:GetAttributeChangedSignal("Charge"):Connect(function() -- Line 44
	--[[ Upvalues[5]:
		[1]: Debris_upvr (readonly)
		[2]: tbl_upvr (readonly)
		[3]: HumanoidRootPart_upvr (readonly)
		[4]: RunService_upvr (readonly)
		[5]: Parent_upvr (readonly)
	]]
	local var15_upvr = script.Parent["Blood"..(script.Parent:GetAttribute("Charge") + 1)]
	Debris_upvr:AddItem(var15_upvr, 1)
	if tbl_upvr[script.Parent:GetAttribute("Charge") + 1] then
		tbl_upvr[script.Parent:GetAttribute("Charge") + 1]:Cancel()
		tbl_upvr[script.Parent:GetAttribute("Charge") + 1]:Destroy()
	end
	local function var16() -- Line 52
		--[[ Upvalues[1]:
			[1]: var15_upvr (readonly)
		]]
		var15_upvr.Trail.Enabled = false
		var15_upvr.ParticleEmitter:Destroy()
		local clone = game.ReplicatedStorage.Utils.Choso.PiercingBlood.Start.Burst:Clone()
		clone.Parent = var15_upvr
		clone:Emit(4)
	end
	task.delay(0.6, var16)
	local WorldPosition_upvr = var15_upvr.WorldPosition
	var15_upvr.Parent = HumanoidRootPart_upvr
	var15_upvr.WorldPosition = WorldPosition_upvr
	if math.random(1, 2) == 1 then
		var16 = -8
	else
		var16 = 8
	end
	local var20_upvw
	local tick_result1_upvr = tick()
	local cframe_upvr = CFrame.new(var16, math.random(4, 7), -4)
	var20_upvw = RunService_upvr.Stepped:Connect(function() -- Line 65
		--[[ Upvalues[7]:
			[1]: var15_upvr (readonly)
			[2]: var20_upvw (read and write)
			[3]: tick_result1_upvr (readonly)
			[4]: Parent_upvr (copied, readonly)
			[5]: HumanoidRootPart_upvr (copied, readonly)
			[6]: cframe_upvr (readonly)
			[7]: WorldPosition_upvr (readonly)
		]]
		if not var15_upvr.Parent then
			var20_upvw:Disconnect()
		else
			var15_upvr.WorldPosition = quadraticBezier((tick() - tick_result1_upvr) / 0.6, WorldPosition_upvr, (HumanoidRootPart_upvr.CFrame * cframe_upvr).Position, Parent_upvr["Right Arm"].Position - Parent_upvr["Right Arm"].CFrame.UpVector * 1)
		end
	end)
end)