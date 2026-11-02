-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:42
-- Luau version 6, Types version 3
-- Time taken: 0.001367 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local MainUI_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1) -- Line 20
	--[[ Upvalues[3]:
		[1]: Knit_upvr (readonly)
		[2]: MainUI_upvr (readonly)
		[3]: TweenService_upvr (readonly)
	]]
	Knit_upvr.GetController("SoundController"):play("Confetti")
	local tbl_upvr = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 221), Color3.fromRGB(157, 0, 255), Color3.fromRGB(0, 187, 255), Color3.fromRGB(71, 238, 52), Color3.fromRGB(255, 176, 0), Color3.fromRGB(255, 255, 0)}
	local Frame_upvr = Instance.new("Frame")
	local random_state = Random.new()
	local any_NextNumber_result1_upvr = random_state:NextNumber(0.0125, 0.0175)
	local any_NextNumber_result1_upvr_2 = random_state:NextNumber(0.05, 0.06)
	Frame_upvr.Size = UDim2.new(any_NextNumber_result1_upvr, 0, any_NextNumber_result1_upvr_2, 0)
	Frame_upvr.BorderSizePixel = 0
	Frame_upvr.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame_upvr.ZIndex = 1
	task.spawn(function() -- Line 47
		--[[ Upvalues[6]:
			[1]: Frame_upvr (readonly)
			[2]: tbl_upvr (readonly)
			[3]: MainUI_upvr (copied, readonly)
			[4]: TweenService_upvr (copied, readonly)
			[5]: any_NextNumber_result1_upvr (readonly)
			[6]: any_NextNumber_result1_upvr_2 (readonly)
		]]
		for _ = 1, 275 do
			local clone = Frame_upvr:Clone()
			clone.BackgroundColor3 = tbl_upvr[math.random(1, 7)]
			clone.Position = UDim2.new(math.random(3, 97) / 100, 0, -0.1, 0)
			clone.Rotation = math.random(-360, 360)
			clone.Parent = MainUI_upvr
			local var14 = math.random(11, 17) / 10
			TweenService_upvr:Create(clone, TweenInfo.new(var14, Enum.EasingStyle.Linear), {
				Rotation = math.random(-360, 360);
				Size = UDim2.new(any_NextNumber_result1_upvr / 2, 0, any_NextNumber_result1_upvr_2 / 2, 0);
				Position = UDim2.new(clone.Position.X.Scale, 0, 1.1, 0);
			}):Play()
			game.Debris:AddItem(clone, var14)
			task.wait(0.007272727272727273)
		end
	end)
end