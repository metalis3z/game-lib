-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = game.Players.LocalPlayer
local v_u_2 = script.Parent.Parent
local v_u_3 = v_u_2:WaitForChild("Progress")
local v_u_4 = v_u_2:WaitForChild("Main"):WaitForChild("Prompt", 10)
local v5 = v_u_2:WaitForChild("Remotes")
local v_u_6 = v5:WaitForChild("RE")
local v_u_7 = v5:WaitForChild("RF")
local v_u_8 = require(game.ReplicatedStorage.Modules.Util)
local v_u_9 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_10 = nil
local v_u_11 = {}
local v_u_12 = {}
local v_u_13 = nil
local v_u_14 = false
local v_u_15 = {
	["Center"] = {
		["Crouch"] = "rbxassetid://134851386101823",
		["GetUp"] = "rbxassetid://79058054398280",
		["FixingLoop"] = "rbxassetid://72803865524092",
		["MissSkillCheck"] = "rbxassetid://130699127484911"
	},
	["Left"] = {
		["Crouch"] = "rbxassetid://117001868187774",
		["GetUp"] = "rbxassetid://75961432707071",
		["FixingLoop"] = "rbxassetid://136386932981095",
		["MissSkillCheck"] = "rbxassetid://89426579572728"
	},
	["Right"] = {
		["Crouch"] = "rbxassetid://95875685232345",
		["GetUp"] = "rbxassetid://127703504515325",
		["FixingLoop"] = "rbxassetid://111043353037600",
		["MissSkillCheck"] = "rbxassetid://75714713086241"
	}
}
task.spawn(function()
	-- upvalues: (copy) v_u_15
	local v16 = {}
	for _, v17 in pairs(v_u_15) do
		for _, v18 in pairs(v17) do
			table.insert(v16, v18)
		end
	end
	game.ContentProvider:PreloadAsync(v16)
end)
local function v_u_22(p19)
	-- upvalues: (copy) v_u_1
	local v20 = v_u_1.PlayerGui.TemporaryUI:FindFirstChild("GeneratorWarning")
	if v20 then
		v20:Destroy()
	end
	local v_u_21 = script.Warning:Clone()
	v_u_21.Name = "GeneratorWarning"
	v_u_21.Title.Text = tostring(p19)
	v_u_21.Parent = v_u_1.PlayerGui.TemporaryUI
	local _ = v_u_21.Size
	v_u_21.Size = v_u_21.Size + UDim2.fromScale(0.025, 0.01)
	game.TweenService:Create(v_u_21, TweenInfo.new(0.35), {
		["Size"] = v_u_21.Size
	}):Play()
	task.delay(3, function()
		-- upvalues: (copy) v_u_21
		if v_u_21.Parent then
			game.Debris:AddItem(v_u_21, 1)
			game.TweenService:Create(v_u_21, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["BackgroundTransparency"] = 1
			}):Play()
			game.TweenService:Create(v_u_21.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["TextTransparency"] = 1,
				["TextStrokeTransparency"] = 1,
				["BackgroundTransparency"] = 1
			}):Play()
		end
	end)
end
local function v_u_28(p23)
	-- upvalues: (ref) v_u_14, (copy) v_u_4, (copy) v_u_9, (copy) v_u_2, (ref) v_u_10, (ref) v_u_13, (copy) v_u_11, (copy) v_u_12, (copy) v_u_1
	v_u_14 = false
	if v_u_4 then
		v_u_4.Enabled = true
	end
	if p23 then
		v_u_9:Play("puzzlesDone", {
			["Parent"] = v_u_2.PrimaryPart
		})
	end
	if v_u_10 then
		v_u_10:endGame()
	end
	if v_u_13 then
		game.Debris:AddItem(v_u_13, 0.4)
		game.TweenService:Create(v_u_13.Background, TweenInfo.new(0.4), {
			["BackgroundTransparency"] = 1
		}):Play()
		for _, v24 in pairs(v_u_13:GetDescendants()) do
			if v24:IsA("ImageLabel") then
				game.TweenService:Create(v24, TweenInfo.new(0.3), {
					["ImageTransparency"] = 1
				}):Play()
			end
		end
		if p23 then
			task.spawn(function()
				-- upvalues: (ref) v_u_13
				game.TweenService:Create(v_u_13.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
					["Size"] = UDim2.fromScale(1, 1)
				}):Play()
				game.TweenService:Create(v_u_13.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
					["Size"] = UDim2.fromScale(1, 1)
				}):Play()
			end)
		end
	end
	for _, v25 in pairs(v_u_11) do
		v25:Disconnect()
	end
	table.clear(v_u_11)
	for _, v26 in pairs(v_u_12) do
		v26:Stop()
	end
	local _ = v_u_12.GetUp
	table.clear(v_u_12)
	local v27 = v_u_1.Character
	if v27 then
		v27 = v_u_1.Character:FindFirstChild("SpeedMultipliers")
	end
	if v27 then
		v27 = v27:FindFirstChild("FixingGenerator")
	end
	if v27 then
		v27:Destroy()
	end
end
local function v_u_63(p29, p_u_30)
	-- upvalues: (copy) v_u_1, (ref) v_u_14, (copy) v_u_4, (copy) v_u_15, (copy) v_u_12, (copy) v_u_8, (copy) v_u_2, (ref) v_u_10, (ref) v_u_13, (copy) v_u_3, (copy) v_u_11, (copy) v_u_6, (copy) v_u_9, (copy) v_u_28
	local v31 = v_u_1.Character
	if v31 then
		local v_u_32 = v31.PrimaryPart
		if v_u_32 then
			local v_u_33 = v31:FindFirstChild("Humanoid")
			if v_u_33 then
				if p_u_30 then
					if p_u_30.Parent then
						v_u_14 = true
						if v_u_4 then
							v_u_4.Enabled = false
						end
						local v34 = v_u_15[p29.Name] or v_u_15.Center
						for v35, v36 in pairs(v34) do
							v_u_12[v35] = v_u_8:LoadAnimationFromID(v_u_1.Character, v36, false)
						end
						v_u_12.Crouch:Play(0)
						v_u_12.FixingLoop:Play()
						local v_u_37 = v_u_2:GetAttribute("Size")
						v_u_10 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager)
						v_u_10:startGame(v_u_37)
						if v_u_13 then
							v_u_13:Destroy()
						end
						v_u_13 = script.BackgroundUI:Clone()
						v_u_13.Parent = v_u_1.PlayerGui:FindFirstChild("TemporaryUI")
						game.TweenService:Create(v_u_13.Background, TweenInfo.new(0.4), {
							["BackgroundTransparency"] = 0.75
						}):Play()
						if not game.Players.LocalPlayer:GetAttribute("CompletedGenPuzzle") then
							v_u_13.Background.Position = UDim2.fromScale(0.5, 0.55)
						end
						for _, v38 in pairs(v_u_13:GetDescendants()) do
							if v38:IsA("ImageLabel") then
								local v39 = v38.ImageTransparency
								v38.ImageTransparency = 1
								game.TweenService:Create(v38, TweenInfo.new(0.4), {
									["ImageTransparency"] = v39
								}):Play()
							end
						end
						local function v44(p40)
							-- upvalues: (ref) v_u_13, (ref) v_u_3
							if v_u_13.Parent then
								local v41 = v_u_3.Value / 100
								local v42 = math.clamp(v41, 0, 1)
								local v43 = v42 == 0 and 0 or 1 / v42
								if p40 == true then
									v_u_13.Background.BarHolder.Bar.Clipping.Size = UDim2.fromScale(1, v42)
									v_u_13.Background.BarHolder.Bar.Clipping.Top.Size = UDim2.fromScale(1, v43)
									return
								end
								game.TweenService:Create(v_u_13.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
									["Size"] = UDim2.fromScale(1, v42)
								}):Play()
								game.TweenService:Create(v_u_13.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
									["Size"] = UDim2.fromScale(1, v43)
								}):Play()
							end
						end
						v44(true)
						v_u_11.ProgressUI = v_u_3:GetPropertyChangedSignal("Value"):Connect(v44)
						local function v_u_49(p45)
							-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) v_u_6, (ref) v_u_14, (ref) v_u_9, (ref) v_u_10, (copy) v_u_37, (ref) v_u_11, (copy) v_u_49, (ref) v_u_13
							if p45 == "finishedPuzzle" then
								local v46 = v_u_3.Value + v_u_2:GetAttribute("PowerGain")
								v_u_6:FireServer()
								if v46 < 100 and v_u_14 then
									v_u_9:Play("puzzleDone", {
										["Parent"] = v_u_2.PrimaryPart
									})
									v_u_10 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager)
									v_u_10:startGame(v_u_37)
									if v_u_11.Completed then
										v_u_11.Completed:Disconnect()
										v_u_11.Completed = nil
									end
									local v47 = v_u_11
									local v48 = v_u_10.Completed
									if v48 then
										v48 = v_u_10.Completed:Connect(v_u_49)
									end
									v47.Completed = v48
									game.TweenService:Create(v_u_13.Background, TweenInfo.new(1), {
										["Position"] = UDim2.fromScale(0.5, 0.5)
									}):Play()
									return
								end
							else
								local _ = p45 == "leaveGenerator"
							end
						end
						local v50 = v_u_11
						local v51 = v_u_10.Completed
						if v51 then
							v51 = v_u_10.Completed:Connect(v_u_49)
						end
						v50.Completed = v51
						if p_u_30 and p_u_30.Parent then
							v_u_11.SpeedGiven = p_u_30.AncestryChanged:Connect(function(_, p52)
								-- upvalues: (ref) v_u_28, (copy) p_u_30
								if not p52 then
									v_u_28(p_u_30:GetAttribute("Completed"))
								end
							end)
						else
							v_u_28()
						end
						local v_u_53 = v_u_33.MoveDirection.Magnitude
						local v_u_54 = tick()
						local v_u_55 = false
						v_u_11.Moved = v_u_33:GetPropertyChangedSignal("MoveDirection"):Connect(function()
							-- upvalues: (copy) v_u_33, (ref) v_u_53, (copy) v_u_54, (ref) v_u_55, (ref) v_u_28
							local v56 = v_u_33.MoveDirection.Magnitude
							if v_u_53 == 0 and (v56 > 0 and (tick() >= v_u_54 + 0.25 and not v_u_55)) then
								v_u_55 = true
								v_u_28()
								toggleGeneratorState("leave")
							end
							v_u_53 = v56
						end)
						local v57 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
						local v58 = v_u_11
						local v59 = v57.SprintToggled
						if v59 then
							v59 = v57.SprintToggled:Connect(function(p60)
								-- upvalues: (ref) v_u_28
								if p60 then
									v_u_28()
									toggleGeneratorState("leave")
								end
							end)
						end
						v58.Sprinted = v59
						local v_u_61 = v_u_2.PrimaryPart.Position
						local v_u_62 = false
						v_u_11.Teleported = v_u_32:GetPropertyChangedSignal("Position"):Connect(function()
							-- upvalues: (copy) v_u_61, (copy) v_u_32, (ref) v_u_62, (ref) v_u_28
							if (v_u_61 - v_u_32.Position).Magnitude > 16 and not v_u_62 then
								v_u_62 = true
								v_u_28()
								toggleGeneratorState("leave")
							end
						end)
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function toggleGeneratorState(p64)
	-- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_22, (copy) v_u_63
	local v65 = v_u_1.Character
	if v65 and v65.PrimaryPart then
		local v66, v67, v68 = v_u_7:InvokeServer(p64)
		local v69 = {
			["tooFar"] = "Move a bit closer to an available side of the generator and try again.",
			["positionOccupied"] = "Move to another side of the generator and try again.",
			["tooMany"] = "Too many people are fixing the generator right now. Try again later.",
			["alreadyFixed"] = "This generator\'s already been fixed. Go try fixing another one.",
			["dead"] = "Try not to die next time.",
			["isKiller"] = "You\'re supposed to be killing them, not helping them. Go do that.",
			["isUnknownTeam"] = "Dude what r u doing rn you\'re a spectator",
			["leftAlready"] = ""
		}
		if v69[v66] then
			v_u_22(v69[v66])
		elseif not v66 then
			v_u_22("An unknown error occurred while trying to fix the generator. Try again.")
		end
		if v66 == "fixing" then
			v_u_63(v67, v68)
		else
			local _ = v66 == "notFixing"
		end
	else
		return
	end
end
if v_u_4 then
	v_u_4.Triggered:Connect(function()
		toggleGeneratorState("enter")
	end)
end
v_u_3:GetPropertyChangedSignal("Value"):Connect(function()
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v70 = v_u_2.Instances.Generator.Progress.BarUI.Bar
	local v71 = v_u_3.Value / 100
	game.TweenService:Create(v70, TweenInfo.new(0.5), {
		["Size"] = UDim2.fromScale(v71, 1),
		["BackgroundTransparency"] = 1 - v71
	}):Play()
end)
v_u_2.AncestryChanged:Connect(function(_, p72)
	-- upvalues: (copy) v_u_28
	if not p72 then
		v_u_28()
	end
end)
