-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-11-29 19:55:02
-- Luau version 6, Types version 3
-- Time taken: 0.038029 seconds

local LocalPlayer_upvr = game.Players.LocalPlayer
local Parent_upvr = script.Parent.Parent
local Progress_upvr = Parent_upvr:WaitForChild("Progress")
local Prompt_upvr = Parent_upvr:WaitForChild("Main"):WaitForChild("Prompt", 10)
local Remotes = Parent_upvr:WaitForChild("Remotes")
local Sounds_upvr = require(game.ReplicatedStorage.Modules.Sounds)
local var7_upvw
local tbl_5_upvr = {}
local tbl_2_upvr = {}
local var10_upvw
local var11_upvw = false
local tbl_3_upvr = {
	Center = {
		Crouch = "rbxassetid://99275822741374";
		GetUp = "rbxassetid://138501580936935";
		FixingLoop = "rbxassetid://138583066698239";
		MissSkillCheck = "rbxassetid://136128789674834";
	};
	Left = {
		Crouch = "rbxassetid://128742617423561";
		GetUp = "rbxassetid://74476642249436";
		FixingLoop = "rbxassetid://75848468306277";
		MissSkillCheck = "rbxassetid://120798378818690";
	};
	Right = {
		Crouch = "rbxassetid://118739478285880";
		GetUp = "rbxassetid://105466566198545";
		FixingLoop = "rbxassetid://80002018506570";
		MissSkillCheck = "rbxassetid://107095605797660";
	};
}
task.spawn(function() -- Line 47
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	local tbl_4 = {}
	for _, v in pairs(tbl_3_upvr) do
		for _, v_2 in pairs(v) do
			table.insert(tbl_4, v_2)
		end
	end
	game.ContentProvider:PreloadAsync(tbl_4)
end)
local function createWarning_upvr(arg1) -- Line 58, Named "createWarning"
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	local GeneratorWarning = LocalPlayer_upvr.PlayerGui.TemporaryUI:FindFirstChild("GeneratorWarning")
	if GeneratorWarning then
		GeneratorWarning:Destroy()
	end
	local clone_upvr = script.Warning:Clone()
	clone_upvr.Name = "GeneratorWarning"
	clone_upvr.Title.Text = tostring(arg1)
	clone_upvr.Parent = LocalPlayer_upvr.PlayerGui.TemporaryUI
	clone_upvr.Size += UDim2.fromScale(0.025, 0.01)
	game.TweenService:Create(clone_upvr, TweenInfo.new(0.35), {
		Size = clone_upvr.Size;
	}):Play()
	task.delay(3, function() -- Line 75
		--[[ Upvalues[1]:
			[1]: clone_upvr (readonly)
		]]
		if clone_upvr.Parent then
			game.Debris:AddItem(clone_upvr, 1)
			game.TweenService:Create(clone_upvr, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				BackgroundTransparency = 1;
			}):Play()
			game.TweenService:Create(clone_upvr.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				TextTransparency = 1;
				TextStrokeTransparency = 1;
				BackgroundTransparency = 1;
			}):Play()
		end
	end)
end
local function stopFixingGenerator_upvr(arg1) -- Line 84, Named "stopFixingGenerator"
	--[[ Upvalues[9]:
		[1]: var11_upvw (read and write)
		[2]: Prompt_upvr (readonly)
		[3]: Sounds_upvr (readonly)
		[4]: Parent_upvr (readonly)
		[5]: var7_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: tbl_5_upvr (readonly)
		[8]: tbl_2_upvr (readonly)
		[9]: LocalPlayer_upvr (readonly)
	]]
	var11_upvw = false
	local var50
	if Prompt_upvr then
		var50 = true
		Prompt_upvr.Enabled = var50
	end
	if arg1 then
		Sounds_upvr:Play("puzzlesDone", {
			Parent = Parent_upvr.PrimaryPart;
		})
	end
	if var7_upvw then
		var7_upvw:endGame()
	end
	if var10_upvw then
		var50 = game
		var50.Debris:AddItem(var10_upvw, 0.4)
		var50 = game
		var50.TweenService:Create(var10_upvw.Background, TweenInfo.new(0.4), {
			BackgroundTransparency = 1;
		}):Play()
		var50 = var10_upvw:GetDescendants()
		local pairs_result1_3, pairs_result2_4, pairs_result3_4 = pairs(var50)
		for _, v_3 in pairs_result1_3, pairs_result2_4, pairs_result3_4 do
			if v_3:IsA("ImageLabel") then
				game.TweenService:Create(v_3, TweenInfo.new(0.3), {
					ImageTransparency = 1;
				}):Play()
			end
		end
		if arg1 then
			function pairs_result2_4() -- Line 105
				--[[ Upvalues[1]:
					[1]: var10_upvw (copied, read and write)
				]]
				game.TweenService:Create(var10_upvw.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
					Size = UDim2.fromScale(1, 1);
				}):Play()
				game.TweenService:Create(var10_upvw.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
					Size = UDim2.fromScale(1, 1);
				}):Play()
			end
			task.spawn(pairs_result2_4)
		end
	end
	pairs_result2_4 = tbl_5_upvr
	local pairs_result1_2, pairs_result2_2, pairs_result3 = pairs(pairs_result2_4)
	for _, v_4 in pairs_result1_2, pairs_result2_2, pairs_result3 do
		v_4:Disconnect()
	end
	pairs_result2_2 = tbl_5_upvr
	table.clear(pairs_result2_2)
	pairs_result2_2 = tbl_2_upvr
	local pairs_result1, pairs_result2, pairs_result3_2 = pairs(pairs_result2_2)
	for i_5, v_5 in pairs_result1, pairs_result2, pairs_result3_2 do
		v_5:Stop()
	end
	pairs_result2 = tbl_2_upvr
	pairs_result2 = table.clear
	pairs_result2(tbl_2_upvr)
	pairs_result2 = LocalPlayer_upvr.Character
	if pairs_result2 then
		pairs_result2 = LocalPlayer_upvr.Character
		i_5 = "SpeedMultipliers"
		pairs_result2 = pairs_result2:FindFirstChild(i_5)
	end
	local var66 = pairs_result2
	if var66 then
		v_5 = "FixingGenerator"
		var66 = pairs_result2:FindFirstChild(v_5)
	end
	if var66 then
		i_5 = var66:Destroy()
		i_5()
	end
end
local Util_upvr = require(game.ReplicatedStorage.Modules.Util)
local RE_upvr = Remotes:WaitForChild("RE")
local function startFixingGenerator_upvr(arg1, arg2) -- Line 133, Named "startFixingGenerator"
	--[[ Upvalues[14]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: Prompt_upvr (readonly)
		[4]: tbl_3_upvr (readonly)
		[5]: tbl_2_upvr (readonly)
		[6]: Util_upvr (readonly)
		[7]: Parent_upvr (readonly)
		[8]: var7_upvw (read and write)
		[9]: var10_upvw (read and write)
		[10]: Progress_upvr (readonly)
		[11]: tbl_5_upvr (readonly)
		[12]: RE_upvr (readonly)
		[13]: Sounds_upvr (readonly)
		[14]: stopFixingGenerator_upvr (readonly)
	]]
	local Character = LocalPlayer_upvr.Character
	local var78
	if not Character then
	else
		local PrimaryPart_upvr = Character.PrimaryPart
		if not PrimaryPart_upvr then return end
		local Humanoid_upvr = Character:FindFirstChild("Humanoid")
		if not Humanoid_upvr then return end
		if not arg2 then return end
		if not arg2.Parent then return end
		var11_upvw = true
		if Prompt_upvr then
			Prompt_upvr.Enabled = false
		end
		local var81 = tbl_3_upvr[arg1.Name]
		if not var81 then
			var81 = tbl_3_upvr.Center
		end
		for i_6, v_6 in pairs(var81) do
			tbl_2_upvr[i_6] = Util_upvr:LoadAnimationFromID(LocalPlayer_upvr.Character, v_6, false)
		end
		tbl_2_upvr.Crouch:Play(0)
		tbl_2_upvr.FixingLoop:Play()
		local Size_upvr = Parent_upvr:GetAttribute("Size")
		var7_upvw = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager)
		var7_upvw:startGame(Size_upvr)
		if var10_upvw then
			var10_upvw:Destroy()
		end
		var10_upvw = script.BackgroundUI:Clone()
		var10_upvw.Parent = LocalPlayer_upvr.PlayerGui:FindFirstChild("TemporaryUI")
		game.TweenService:Create(var10_upvw.Background, TweenInfo.new(0.4), {
			BackgroundTransparency = 0.75;
		}):Play()
		if not game.Players.LocalPlayer:GetAttribute("CompletedGenPuzzle") then
			var10_upvw.Background.Position = UDim2.fromScale(0.5, 0.55)
		end
		for _, v_7 in pairs(var10_upvw:GetDescendants()) do
			if v_7:IsA("ImageLabel") then
				v_7.ImageTransparency = 1
				game.TweenService:Create(v_7, TweenInfo.new(0.4), {
					ImageTransparency = v_7.ImageTransparency;
				}):Play()
			end
		end
		local function updateGenProgress(arg1_2) -- Line 180
			--[[ Upvalues[2]:
				[1]: var10_upvw (copied, read and write)
				[2]: Progress_upvr (copied, readonly)
			]]
			local var91
			if var10_upvw.Parent then
				var91 = Progress_upvr.Value / 100
				local clamped = math.clamp(var91, 0, 1)
				if clamped == 0 then
					var91 = 0
				else
					var91 = 1 / clamped
				end
				if arg1_2 == true then
					var10_upvw.Background.BarHolder.Bar.Clipping.Size = UDim2.fromScale(1, clamped)
					var10_upvw.Background.BarHolder.Bar.Clipping.Top.Size = UDim2.fromScale(1, var91)
					return
				end
				game.TweenService:Create(var10_upvw.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
					Size = UDim2.fromScale(1, clamped);
				}):Play()
				game.TweenService:Create(var10_upvw.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
					Size = UDim2.fromScale(1, var91);
				}):Play()
			end
		end
		updateGenProgress(true)
		tbl_5_upvr.ProgressUI = Progress_upvr:GetPropertyChangedSignal("Value"):Connect(updateGenProgress)
		local function completedPuzzle_upvr(arg1_3) -- Line 197, Named "completedPuzzle"
			--[[ Upvalues[10]:
				[1]: Progress_upvr (copied, readonly)
				[2]: Parent_upvr (copied, readonly)
				[3]: RE_upvr (copied, readonly)
				[4]: var11_upvw (copied, read and write)
				[5]: Sounds_upvr (copied, readonly)
				[6]: var7_upvw (copied, read and write)
				[7]: Size_upvr (readonly)
				[8]: tbl_5_upvr (copied, readonly)
				[9]: completedPuzzle_upvr (readonly)
				[10]: var10_upvw (copied, read and write)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [20] 16. Error Block 15 start (CF ANALYSIS FAILED)
			Sounds_upvr:Play("puzzleDone", {
				Parent = Parent_upvr.PrimaryPart;
			})
			var7_upvw = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager)
			var7_upvw:startGame(Size_upvr)
			if tbl_5_upvr.Completed then
				tbl_5_upvr.Completed:Disconnect()
				tbl_5_upvr.Completed = nil
			end
			local Completed = var7_upvw.Completed
			if Completed then
				Completed = var7_upvw.Completed:Connect(completedPuzzle_upvr)
			end
			tbl_5_upvr.Completed = Completed
			game.TweenService:Create(var10_upvw.Background, TweenInfo.new(1), {
				Position = UDim2.fromScale(0.5, 0.5);
			}):Play()
			do
				return
			end
			-- KONSTANTERROR: [20] 16. Error Block 15 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [104] 74. Error Block 12 start (CF ANALYSIS FAILED)
			if arg1_3 ~= "leaveGenerator" then
			end
			-- KONSTANTERROR: [104] 74. Error Block 12 end (CF ANALYSIS FAILED)
		end
		if var7_upvw.Completed then
		end
		tbl_5_upvr.Completed = var7_upvw.Completed:Connect(completedPuzzle_upvr)
		if not arg2 or not arg2.Parent then
			stopFixingGenerator_upvr()
		else
			tbl_5_upvr.SpeedGiven = arg2.AncestryChanged:Connect(function(arg1_4, arg2_2) -- Line 227
				--[[ Upvalues[2]:
					[1]: stopFixingGenerator_upvr (copied, readonly)
					[2]: arg2 (readonly)
				]]
				if not arg2_2 then
					stopFixingGenerator_upvr(arg2:GetAttribute("Completed"))
				end
			end)
		end
		local Magnitude_upvw = Humanoid_upvr.MoveDirection.Magnitude
		local tick_result1_upvr = tick()
		local var102_upvw = false
		tbl_5_upvr.Moved = Humanoid_upvr:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- Line 234
			--[[ Upvalues[5]:
				[1]: Humanoid_upvr (readonly)
				[2]: Magnitude_upvw (read and write)
				[3]: tick_result1_upvr (readonly)
				[4]: var102_upvw (read and write)
				[5]: stopFixingGenerator_upvr (copied, readonly)
			]]
			local Magnitude = Humanoid_upvr.MoveDirection.Magnitude
			if Magnitude_upvw == 0 and 0 < Magnitude and tick_result1_upvr + 0.25 <= tick() and not var102_upvw then
				var102_upvw = true
				stopFixingGenerator_upvr()
				toggleGeneratorState("leave")
			end
			Magnitude_upvw = Magnitude
		end)
		local Sprinting = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
		local SprintToggled = Sprinting.SprintToggled
		if SprintToggled then
			SprintToggled = Sprinting.SprintToggled
			SprintToggled = SprintToggled:Connect(function(arg1_5) -- Line 246
				--[[ Upvalues[1]:
					[1]: stopFixingGenerator_upvr (copied, readonly)
				]]
				if arg1_5 then
					stopFixingGenerator_upvr()
					toggleGeneratorState("leave")
				end
			end)
		end
		tbl_5_upvr.Sprinted = SprintToggled
		local Position_upvr = Parent_upvr.PrimaryPart.Position
		local var109_upvw = false
		tbl_5_upvr.Teleported = PrimaryPart_upvr:GetPropertyChangedSignal("Position"):Connect(function() -- Line 256
			--[[ Upvalues[4]:
				[1]: Position_upvr (readonly)
				[2]: PrimaryPart_upvr (readonly)
				[3]: var109_upvw (read and write)
				[4]: stopFixingGenerator_upvr (copied, readonly)
			]]
			if 16 < (Position_upvr - PrimaryPart_upvr.Position).Magnitude and not var109_upvw then
				var109_upvw = true
				stopFixingGenerator_upvr()
				toggleGeneratorState("leave")
			end
		end)
	end
end
local RF_upvr = Remotes:WaitForChild("RF")
function toggleGeneratorState(arg1) -- Line 265
	--[[ Upvalues[4]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: RF_upvr (readonly)
		[3]: createWarning_upvr (readonly)
		[4]: startFixingGenerator_upvr (readonly)
	]]
	local Character_2 = LocalPlayer_upvr.Character
	if not Character_2 or not Character_2.PrimaryPart then
	else
		local any_InvokeServer_result1, any_InvokeServer_result2, any_InvokeServer_result3 = RF_upvr:InvokeServer(arg1)
		local tbl = {
			tooFar = "Move a bit closer to an available side of the generator and try again.";
			positionOccupied = "Move to another side of the generator and try again.";
			tooMany = "Too many people are fixing the generator right now. Try again later.";
			alreadyFixed = "This generator's already been fixed. Go try fixing another one.";
			dead = "Try not to die next time.";
			isKiller = "You're supposed to be killing them, not helping them. Go do that.";
			isUnknownTeam = "Dude what r u doing rn you're a spectator";
			leftAlready = "";
		}
		if tbl[any_InvokeServer_result1] then
			createWarning_upvr(tbl[any_InvokeServer_result1])
		elseif not any_InvokeServer_result1 then
			createWarning_upvr("An unknown error occurred while trying to fix the generator. Try again.")
		end
		if any_InvokeServer_result1 == "fixing" then
			startFixingGenerator_upvr(any_InvokeServer_result2, any_InvokeServer_result3)
			return
		end
		if any_InvokeServer_result1 ~= "notFixing" then
		end
	end
end
if Prompt_upvr then
	Prompt_upvr.Triggered:Connect(function() -- Line 296
		toggleGeneratorState("enter")
	end)
end
Progress_upvr:GetPropertyChangedSignal("Value"):Connect(function() -- Line 302
	--[[ Upvalues[2]:
		[1]: Parent_upvr (readonly)
		[2]: Progress_upvr (readonly)
	]]
	local var118 = Progress_upvr.Value / 100
	game.TweenService:Create(Parent_upvr.Instances.Generator.Progress.BarUI.Bar, TweenInfo.new(0.5), {
		Size = UDim2.fromScale(var118, 1);
		BackgroundTransparency = 1 - var118;
	}):Play()
end)
Parent_upvr.AncestryChanged:Connect(function(arg1, arg2) -- Line 309
	--[[ Upvalues[1]:
		[1]: stopFixingGenerator_upvr (readonly)
	]]
	if not arg2 then
		stopFixingGenerator_upvr()
	end
end)