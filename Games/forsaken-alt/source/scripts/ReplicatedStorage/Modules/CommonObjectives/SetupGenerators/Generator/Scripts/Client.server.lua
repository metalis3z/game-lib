-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent.Parent;
local l_Progress_0 = l_Parent_0:WaitForChild("Progress");
local v3 = l_Parent_0:WaitForChild("Main"):WaitForChild("Prompt", 10);
local l_Remotes_0 = l_Parent_0:WaitForChild("Remotes");
local l_RE_0 = l_Remotes_0:WaitForChild("RE");
local l_RF_0 = l_Remotes_0:WaitForChild("RF");
local v7 = require(game.ReplicatedStorage.Modules.Util);
local v8 = require(game.ReplicatedStorage.Modules.Sounds);
local v9 = nil;
local v10 = {};
local v11 = {};
local v12 = nil;
local v13 = false;
local v14 = {
    Center = {
		Crouch = "rbxassetid://129381906532487", 
		GetUp = "rbxassetid://109295817265500", 
		FixingLoop = "rbxassetid://132993350282123", 
		MissSkillCheck = "rbxassetid://74299362939102"
    }, 
    Left = {
        Crouch = "rbxassetid://88097739509103", 
        GetUp = "rbxassetid://105295276078262", 
        FixingLoop = "rbxassetid://106362304435190", 
        MissSkillCheck = "rbxassetid://71238970074155"
    }, 
    Right = {
        Crouch = "rbxassetid://117746129818102", 
        GetUp = "rbxassetid://105699866498264", 
        FixingLoop = "rbxassetid://88166658847908", 
        MissSkillCheck = "rbxassetid://129496766476934"
    }
};
task.spawn(function() --[[ Line: 47 ]]
    -- upvalues: v14 (copy)
    local v15 = {};
    for _, v17 in pairs(v14) do
        for _, v19 in pairs(v17) do
            table.insert(v15, v19);
        end;
    end;
    game.ContentProvider:PreloadAsync(v15);
end);
local function v24(v20) --[[ Line: 58 ]] --[[ Name: createWarning ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_GeneratorWarning_0 = l_LocalPlayer_0.PlayerGui.TemporaryUI:FindFirstChild("GeneratorWarning");
    if l_GeneratorWarning_0 then
        l_GeneratorWarning_0:Destroy();
    end;
    local v22 = script.Warning:Clone();
    v22.Name = "GeneratorWarning";
    v22.Title.Text = tostring(v20);
    v22.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
    local _ = v22.Size;
    v22.Size = v22.Size + UDim2.fromScale(0.025, 0.01);
    game.TweenService:Create(v22, TweenInfo.new(0.35), {
        Size = v22.Size
    }):Play();
    task.delay(3, function() --[[ Line: 75 ]]
        -- upvalues: v22 (copy)
        if v22.Parent then
            game.Debris:AddItem(v22, 1);
            game.TweenService:Create(v22, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            }):Play();
            game.TweenService:Create(v22.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                TextTransparency = 1, 
                TextStrokeTransparency = 1, 
                BackgroundTransparency = 1
            }):Play();
        end;
    end);
end;
local function v35(v25) --[[ Line: 84 ]] --[[ Name: stopFixingGenerator ]]
    -- upvalues: v13 (ref), v3 (copy), v8 (copy), l_Parent_0 (copy), v9 (ref), v12 (ref), v10 (copy), v11 (copy), l_LocalPlayer_0 (copy)
    v13 = false;
    if v3 then
        v3.Enabled = true;
    end;
    if v25 then
        v8:Play("puzzlesDone", {
            Parent = l_Parent_0.PrimaryPart
        });
    end;
    if v9 then
        v9:endGame();
    end;
    if v12 then
        game.Debris:AddItem(v12, 0.4);
        game.TweenService:Create(v12.Background, TweenInfo.new(0.4), {
            BackgroundTransparency = 1
        }):Play();
        for _, v27 in pairs(v12:GetDescendants()) do
            if v27:IsA("ImageLabel") then
                game.TweenService:Create(v27, TweenInfo.new(0.3), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
        if v25 then
            task.spawn(function() --[[ Line: 105 ]]
                -- upvalues: v12 (ref)
                game.TweenService:Create(v12.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                game.TweenService:Create(v12.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
                    Size = UDim2.fromScale(1, 1)
                }):Play();
            end);
        end;
    end;
    for _, v29 in pairs(v10) do
        v29:Disconnect();
    end;
    table.clear(v10);
    for _, v31 in pairs(v11) do
        v31:Stop();
    end;
    local _ = v11.GetUp;
    table.clear(v11);
    local v33 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("SpeedMultipliers");
    local v34 = v33 and v33:FindFirstChild("FixingGenerator");
    if v34 then
        print("stopped fixing");
        v34:Destroy();
    end;
end;
local function v62(v36, v37) --[[ Line: 133 ]] --[[ Name: startFixingGenerator ]]
    -- upvalues: l_LocalPlayer_0 (copy), v13 (ref), v3 (copy), v14 (copy), v11 (copy), v7 (copy), l_Parent_0 (copy), v9 (ref), v12 (ref), l_Progress_0 (copy), v10 (copy), l_RE_0 (copy), v8 (copy), v35 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    elseif not l_Character_0.PrimaryPart then
        return;
    else
        local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
        if not l_Humanoid_0 then
            return;
        elseif not v37 then
            return;
        elseif not v37.Parent then
            return;
        else
            v13 = true;
            if v3 then
                v3.Enabled = false;
            end;
            local v40 = v14[v36.Name] or v14.Center;
            for v41, v42 in pairs(v40) do
                v11[v41] = v7:LoadAnimationFromID(l_LocalPlayer_0.Character, v42, false);
            end;
            v11.Crouch:Play(0);
			v11.FixingLoop:Play();
			warn(l_Parent_0)
            local l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("Size");
            v9 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager);
            v9:startGame(l_l_Parent_0_Attribute_0);
            if v12 then
                v12:Destroy();
            end;
            v12 = script.BackgroundUI:Clone();
            v12.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
            game.TweenService:Create(v12.Background, TweenInfo.new(0.4), {
                BackgroundTransparency = 0.75
            }):Play();
            if not game.Players.LocalPlayer:GetAttribute("CompletedGenPuzzle") then
                v12.Background.Position = UDim2.fromScale(0.5, 0.55);
            end;
            for _, v45 in pairs(v12:GetDescendants()) do
                if v45:IsA("ImageLabel") then
                    local l_ImageTransparency_0 = v45.ImageTransparency;
                    v45.ImageTransparency = 1;
                    game.TweenService:Create(v45, TweenInfo.new(0.4), {
                        ImageTransparency = l_ImageTransparency_0
                    }):Play();
                end;
            end;
            local function v50(v47) --[[ Line: 180 ]] --[[ Name: updateGenProgress ]]
                -- upvalues: v12 (ref), l_Progress_0 (ref)
                if v12.Parent then
                    local v48 = math.clamp(l_Progress_0.Value / 100, 0, 1);
                    local v49 = v48 == 0 and 0 or 1 / v48;
                    if v47 == true then
                        v12.Background.BarHolder.Bar.Clipping.Size = UDim2.fromScale(1, v48);
                        v12.Background.BarHolder.Bar.Clipping.Top.Size = UDim2.fromScale(1, v49);
                        return;
                    else
                        game.TweenService:Create(v12.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
                            Size = UDim2.fromScale(1, v48)
                        }):Play();
                        game.TweenService:Create(v12.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
                            Size = UDim2.fromScale(1, v49)
                        }):Play();
                    end;
                end;
            end;
            v50(true);
            v10.ProgressUI = l_Progress_0:GetPropertyChangedSignal("Value"):Connect(v50);
            local function v51(v52) --[[ Line: 197 ]] --[[ Name: completedPuzzle ]]
                -- upvalues: l_Progress_0 (ref), l_Parent_0 (ref), l_RE_0 (ref), v13 (ref), v8 (ref), v9 (ref), l_l_Parent_0_Attribute_0 (copy), v10 (ref), v51 (copy), v12 (ref)
                if v52 == "finishedPuzzle" then
                    local v53 = l_Progress_0.Value + l_Parent_0:GetAttribute("PowerGain");
                    l_RE_0:FireServer();
                    if v53 < 100 and v13 then
                        v8:Play("puzzleDone", {
                            Parent = l_Parent_0.PrimaryPart
                        });
                        v9 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager);
                        v9:startGame(l_l_Parent_0_Attribute_0);
                        if v10.Completed then
                            v10.Completed:Disconnect();
                            v10.Completed = nil;
                        end;
                        v10.Completed = v9.Completed and v9.Completed:Connect(v51);
                        game.TweenService:Create(v12.Background, TweenInfo.new(1), {
                            Position = UDim2.fromScale(0.5, 0.5)
                        }):Play();
                        return;
                    end;
                elseif v52 == "leaveGenerator" then

                end;
            end;
            v10.Completed = v9.Completed and v9.Completed:Connect(v51);
            if not v37 or not v37.Parent then
                v35();
            else
				v10.SpeedGiven = v37.AncestryChanged:Connect(function(_, v55) --[[ Line: 227 ]]
                    if not v55 then
                        v35(v37:GetAttribute("Completed"));
                    end;
                end);
            end;
            local l_Magnitude_0 = l_Humanoid_0.MoveDirection.Magnitude;
            local v57 = tick();
            local v58 = false;
            v10.Moved = l_Humanoid_0:GetPropertyChangedSignal("MoveDirection"):Connect(function() --[[ Line: 234 ]]
                -- upvalues: l_Humanoid_0 (copy), l_Magnitude_0 (ref), v57 (copy), v58 (ref), v35 (ref)
                local l_Magnitude_1 = l_Humanoid_0.MoveDirection.Magnitude;
                if l_Magnitude_0 == 0 and l_Magnitude_1 > 0 and tick() >= v57 + 0.25 and not v58 then
                    v58 = true;
                    v35();
                    toggleGeneratorState("leave");
                end;
                l_Magnitude_0 = l_Magnitude_1;
            end);
            local v60 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
            v10.Sprinted = v60.SprintToggled and v60.SprintToggled:Connect(function(v61) --[[ Line: 246 ]]
                if v61 then
                    v35();
                    toggleGeneratorState("leave");
                end;
            end);
            return;
        end;
    end;
end;
function toggleGeneratorState(v63) --[[ Line: 254 ]] --[[ Name: toggleGeneratorState ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_RF_0 (copy), v24 (copy), v62 (copy)
    local l_Character_1 = l_LocalPlayer_0.Character;
    if not l_Character_1 or not l_Character_1.PrimaryPart then
        return;
    else
        local v65, v66, v67 = l_RF_0:InvokeServer(v63);
        local v68 = {
            tooFar = "Move a bit closer to an available side of the generator and try again.", 
            positionOccupied = "Move to another side of the generator and try again.", 
            tooMany = "Too many people are fixing the generator right now. Try again later.", 
            alreadyFixed = "This generator's already been fixed. Go try fixing another one.", 
            dead = "Try not to die next time.", 
            isKiller = "You're supposed to be killing them, not helping them. Go do that.", 
            isUnknownTeam = "Dude what r u doing rn you're a spectator", 
            leftAlready = ""
        };
        if v68[v65] then
            v24(v68[v65]);
        elseif not v65 then
            v24("An unknown error occurred while trying to fix the generator. Try again.");
        end;
        if v65 == "fixing" then
            v62(v66, v67);
            return;
        else
            if v65 == "notFixing" then

            end;
            return;
        end;
    end;
end;
if v3 then
    v3.Triggered:Connect(function() --[[ Line: 285 ]]
        toggleGeneratorState("enter");
    end);
end;
l_Progress_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 291 ]]
    -- upvalues: l_Parent_0 (copy), l_Progress_0 (copy)
    local l_Bar_0 = l_Parent_0.Instances.Generator.Progress.BarUI.Bar;
    local v70 = l_Progress_0.Value / 100;
    game.TweenService:Create(l_Bar_0, TweenInfo.new(0.5), {
        Size = UDim2.fromScale(v70, 1), 
        BackgroundTransparency = 1 - v70
    }):Play();
end);
l_Parent_0.AncestryChanged:Connect(function(_, v72) --[[ Line: 298 ]]
	warn(v72)
    if not v72 then
        v35();
    end;
end);