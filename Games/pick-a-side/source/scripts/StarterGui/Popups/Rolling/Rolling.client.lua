-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:51
-- Luau version 6, Types version 3
-- Time taken: 0.011388 seconds

-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local ProximityPromptService_upvr = game:GetService("ProximityPromptService")
local TweenService_upvr = game:GetService("TweenService")
local Preview_upvr = script.Parent.Preview
local Auras_upvr = require(game.ReplicatedStorage.Settings.Auras)
for _, v in Auras_upvr do
	local TextLabel = Instance.new("TextLabel")
	local font = v.font
	TextLabel.FontFace = Font.new(font.family, font.weight, font.style)
	table.insert({}, TextLabel)
	local var17
end
game:GetService("ContentProvider"):PreloadAsync(var17, function(arg1, arg2) -- Line 45
end)
ProximityPromptService_upvr.Enabled = true
local random_state_upvr = Random.new()
function ShakeUI(arg1, arg2, arg3) -- Line 56
	--[[ Upvalues[1]:
		[1]: random_state_upvr (readonly)
	]]
	local os_clock_result1 = os.clock()
	local function _(arg1_2) -- Line 60, Named "randomShake"
		--[[ Upvalues[1]:
			[1]: random_state_upvr (copied, readonly)
		]]
		return random_state_upvr:NextNumber(-arg1_2, arg1_2)
	end
	local function _(arg1_3, arg2_2, arg3_2) -- Line 63, Named "easeOutQuad"
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		local var21 = arg1_3 / arg3_2
		return arg2 + arg2_2 * var21 * (var21 - 2)
	end
	while os.clock() - os_clock_result1 < arg3 do
		local var22 = (os.clock() - os_clock_result1) / arg3
		local var23 = arg2 + arg2 * var22 * (var22 - 2)
		local var24 = var23 * 300
		arg1.Position = UDim2.new(random_state_upvr:NextNumber(-var23, var23), 0, random_state_upvr:NextNumber(-var23, var23), 0)
		arg1.Rotation = random_state_upvr:NextNumber(-var24, var24)
		task.wait()
	end
end
local Rarity_upvr = require(game.ReplicatedStorage.Settings.Rarity)
local Sounds_upvr = game.ReplicatedStorage.Sounds
local Sparkle_upvr = script.Parent.Sparkle
local Fade_upvr = script.Parent.Fade
local Vignette_upvr = script.Parent.Vignette
local Debris_upvr = game:GetService("Debris")
local function Tick_upvr(arg1, arg2) -- Line 81, Named "Tick"
	--[[ Upvalues[10]:
		[1]: Preview_upvr (readonly)
		[2]: Auras_upvr (readonly)
		[3]: Rarity_upvr (readonly)
		[4]: CLIENT_DATA_upvr (readonly)
		[5]: Sounds_upvr (readonly)
		[6]: Sparkle_upvr (readonly)
		[7]: TweenService_upvr (readonly)
		[8]: Fade_upvr (readonly)
		[9]: Vignette_upvr (readonly)
		[10]: Debris_upvr (readonly)
	]]
	local Title = Preview_upvr.Title
	local Name = arg1.Name
	local var33 = Auras_upvr[Name]
	local font_2 = var33.font
	Title.TextColor3 = var33.color
	Title.FontFace = Font.new(font_2.family, font_2.weight, font_2.style)
	Title.UIGradient.Color = var33.gradient
	Title.UIGradient.Rotation = var33.rotation
	Title.UIStroke.Color = var33.stroke
	Title.UIStroke.Thickness = var33.thickness
	Title.Text = Name
	local Rarity = arg1:GetAttribute("Rarity")
	Preview_upvr.Rarity.Text = Rarity_upvr[Rarity].title
	Preview_upvr.Rarity.TextColor3 = Rarity_upvr[Rarity].color
	if arg2 == 1.25 and 3 <= Rarity then
		Sounds_upvr.Thud:Play()
		Sounds_upvr.Riser:Play()
		Preview_upvr.Visible = false
		if Rarity == 4 then
			Sparkle_upvr.Size = UDim2.new(0.8, 0, 0.8, 0)
			Sparkle_upvr.UIGradient.Color = ColorSequence.new(Rarity_upvr[Rarity].color)
			TweenService_upvr:Create(Sparkle_upvr, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Rotation = 90;
				Size = UDim2.new(0.4, 0, 0.4, 0);
			}):Play()
			Sparkle_upvr.Visible = true
		else
			Sounds_upvr.Riser.TimePosition = 1
		end
		Fade_upvr.BackgroundColor3 = Color3.new(0, 0, 0)
		Fade_upvr.ZIndex = 7
		local any_Create_result1_2 = TweenService_upvr:Create(Fade_upvr, TweenInfo.new(0.5), {
			BackgroundTransparency = 0;
		})
		any_Create_result1_2:Play()
		any_Create_result1_2.Completed:Wait()
		Sounds_upvr.Dune:Play()
		if Sparkle_upvr.Visible then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			local var39 = 90 + 270
			local any_Create_result1_4 = TweenService_upvr:Create(Sparkle_upvr, TweenInfo.new(4, Enum.EasingStyle.Linear), {
				Rotation = var39;
			})
			any_Create_result1_4:Play()
			any_Create_result1_4.Completed:Wait()
			TweenService_upvr:Create(Sparkle_upvr, TweenInfo.new(3, Enum.EasingStyle.Linear), {
				Rotation = var39 + 360;
				Size = UDim2.new(1.4, 0, 1.4, 0);
			}):Play()
		else
			task.wait(2)
		end
		local UIGradient = Vignette_upvr.UIGradient
		UIGradient.Color = ColorSequence.new(Rarity_upvr[Rarity].color)
		if Sparkle_upvr.Visible then
			UIGradient = 2
		else
			UIGradient = 1
		end
		local any_Create_result1_3 = TweenService_upvr:Create(Vignette_upvr, TweenInfo.new(UIGradient, Enum.EasingStyle.Linear), {
			ImageTransparency = 0;
		})
		any_Create_result1_3:Play()
		any_Create_result1_3.Completed:Wait()
		Fade_upvr.ZIndex = 10
		Fade_upvr.BackgroundColor3 = Color3.new(1, 1, 1)
		if Sparkle_upvr.Visible then
			task.wait(2)
		end
		Sparkle_upvr.Visible = false
		Sounds_upvr.Hit:Play()
		Sounds_upvr.Impact:Play()
		Sparkle_upvr.Rotation = 0
		TweenService_upvr:Create(Fade_upvr, TweenInfo.new(0.5), {
			BackgroundTransparency = 1;
		}):Play()
		Preview_upvr.Visible = true
		Vignette_upvr.ImageTransparency = 1
		ShakeUI(Preview_upvr, 0.05, 2)
	else
		local clone = Sounds_upvr.Tick:Clone()
		clone.Parent = Sounds_upvr
		clone:Play()
		Debris_upvr:AddItem(clone, 1)
		Preview_upvr.Position = UDim2.new(0, 0, -0.05, 0)
		local any_Create_result1 = TweenService_upvr:Create(Preview_upvr, TweenInfo.new(arg2), {
			Position = UDim2.new(0, 0, 0, 0);
		})
		any_Create_result1:Play()
		return any_Create_result1
	end
end
local Parent_upvr = script.Parent
local Pick_upvr = require(game.ReplicatedStorage.Modules.Pick)
local AurasByRarity_upvr = require(game.ReplicatedStorage.Modules.AurasByRarity)
game.ReplicatedStorage.Signals.Roll.OnClientEvent:Connect(function(arg1, arg2) -- Line 164
	--[[ Upvalues[8]:
		[1]: TweenService_upvr (readonly)
		[2]: Parent_upvr (readonly)
		[3]: ProximityPromptService_upvr (readonly)
		[4]: Preview_upvr (readonly)
		[5]: CLIENT_DATA_upvr (readonly)
		[6]: Pick_upvr (readonly)
		[7]: AurasByRarity_upvr (readonly)
		[8]: Tick_upvr (readonly)
	]]
	TweenService_upvr:Create(Parent_upvr, TweenInfo.new(0.2), {
		BackgroundTransparency = 0.6;
	}):Play()
	ProximityPromptService_upvr.Enabled = false
	Preview_upvr.Visible = true
	for i_2 = 1, 10 do
		Tick_upvr(Pick_upvr(AurasByRarity_upvr, arg2), 0.08 + 0.025 * i_2).Completed:Wait()
	end
	Tick_upvr(arg1, 1.25)
	task.wait(2)
	TweenService_upvr:Create(Parent_upvr, TweenInfo.new(0.2), {
		BackgroundTransparency = 1;
	}):Play()
	Preview_upvr.Visible = false
	ProximityPromptService_upvr.Enabled = true
end)