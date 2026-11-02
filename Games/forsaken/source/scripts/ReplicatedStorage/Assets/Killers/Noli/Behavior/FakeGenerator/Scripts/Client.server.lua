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
        Crouch = "rbxassetid://127802146383565", 
        GetUp = "rbxassetid://73366656069996", 
        FixingLoop = "rbxassetid://82691533602949", 
        MissSkillCheck = "rbxassetid://123764169071995"
    }, 
    Left = {
        Crouch = "rbxassetid://128943791000974", 
        GetUp = "rbxassetid://100892454179956", 
        FixingLoop = "rbxassetid://122604262087779", 
        MissSkillCheck = "rbxassetid://132527194370907"
    }, 
    Right = {
        Crouch = "rbxassetid://139901321415812", 
        GetUp = "rbxassetid://74108842024349", 
        FixingLoop = "rbxassetid://130355934640695", 
        MissSkillCheck = "rbxassetid://88700613969854"
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
        v34:Destroy();
    end;
end;
local function v41() --[[ Line: 133 ]] --[[ Name: getSettings ]]
    local v36 = {
        Modifiers = {}
    };
    local v37 = {
        "NumberSkip"
    };
    local v38 = v37[math.random(1, #v37)];
    local v40 = {
        AllowBadColors = function() --[[ Line: 139 ]]
            -- upvalues: v36 (copy)
            local v39 = math.random(12, 19) / 20;
            v36.Colors = {
                Color3.fromRGB(85 * v39, 0, 255 * v39)
            };
        end
    };
    v36.Modifiers[v38] = true;
    if v40[v38] then
        v40[v38]();
    end;
    return v36;
end;
local function v71(v42, v43) --[[ Line: 152 ]] --[[ Name: startFixingGenerator ]]
    -- upvalues: l_LocalPlayer_0 (copy), v13 (ref), v3 (copy), v14 (copy), v11 (copy), v7 (copy), l_Parent_0 (copy), v9 (ref), v41 (copy), v12 (ref), l_Progress_0 (copy), v10 (copy), l_RE_0 (copy), v8 (copy), v35 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    else
        local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
        if not l_PrimaryPart_0 then
            return;
        else
            local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
            if not l_Humanoid_0 then
                return;
            elseif not v43 then
                return;
            elseif not v43.Parent then
                return;
            else
                v13 = true;
                if v3 then
                    v3.Enabled = false;
                end;
                local v47 = v14[v42.Name] or v14.Center;
                for v48, v49 in pairs(v47) do
                    v11[v48] = v7:LoadAnimationFromID(l_LocalPlayer_0.Character, v49, false);
                end;
                v11.Crouch:Play(0);
                v11.FixingLoop:Play();
                local l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("Size");
                v9 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager);
                v9:startGame(l_l_Parent_0_Attribute_0, (v41()));
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
                for _, v52 in pairs(v12:GetDescendants()) do
                    if v52:IsA("ImageLabel") then
                        local l_ImageTransparency_0 = v52.ImageTransparency;
                        v52.ImageTransparency = 1;
                        game.TweenService:Create(v52, TweenInfo.new(0.4), {
                            ImageTransparency = l_ImageTransparency_0
                        }):Play();
                    end;
                end;
                local function v57(v54) --[[ Line: 202 ]] --[[ Name: updateGenProgress ]]
                    -- upvalues: v12 (ref), l_Progress_0 (ref)
                    if v12.Parent then
                        local v55 = math.clamp(l_Progress_0.Value / 100, 0, 1);
                        local v56 = v55 == 0 and 0 or 1 / v55;
                        if v54 == true then
                            v12.Background.BarHolder.Bar.Clipping.Size = UDim2.fromScale(1, v55);
                            v12.Background.BarHolder.Bar.Clipping.Top.Size = UDim2.fromScale(1, v56);
                            return;
                        else
                            game.TweenService:Create(v12.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
                                Size = UDim2.fromScale(1, v55)
                            }):Play();
                            game.TweenService:Create(v12.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
                                Size = UDim2.fromScale(1, v56)
                            }):Play();
                        end;
                    end;
                end;
                v57(true);
                v10.ProgressUI = l_Progress_0:GetPropertyChangedSignal("Value"):Connect(v57);
                local function v58(v59) --[[ Line: 219 ]] --[[ Name: completedPuzzle ]]
                    -- upvalues: l_Progress_0 (ref), l_Parent_0 (ref), l_RE_0 (ref), v13 (ref), v8 (ref), v9 (ref), l_l_Parent_0_Attribute_0 (copy), v41 (ref), v10 (ref), v58 (copy), v12 (ref)
                    if v59 == "finishedPuzzle" then
                        local v60 = l_Progress_0.Value + l_Parent_0:GetAttribute("PowerGain");
                        l_RE_0:FireServer();
                        if v60 < 100 and v13 then
                            v8:Play("puzzleDone", {
                                Parent = l_Parent_0.PrimaryPart
                            });
                            v9 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager);
                            v9:startGame(l_l_Parent_0_Attribute_0, (v41()));
                            if v10.Completed then
                                v10.Completed:Disconnect();
                                v10.Completed = nil;
                            end;
                            v10.Completed = v9.Completed and v9.Completed:Connect(v58);
                            game.TweenService:Create(v12.Background, TweenInfo.new(1), {
                                Position = UDim2.fromScale(0.5, 0.5)
                            }):Play();
                            return;
                        end;
                    elseif v59 == "leaveGenerator" then

                    end;
                end;
                v10.Completed = v9.Completed and v9.Completed:Connect(v58);
                if not v43 or not v43.Parent then
                    v35();
                else
                    v10.SpeedGiven = v43.AncestryChanged:Connect(function(_, v62) --[[ Line: 249 ]]
                        -- upvalues: v35 (ref), v43 (copy)
                        if not v62 then
                            v35(v43:GetAttribute("Completed"));
                        end;
                    end);
                end;
                local l_Magnitude_0 = l_Humanoid_0.MoveDirection.Magnitude;
                local v64 = tick();
                local v65 = false;
                v10.Moved = l_Humanoid_0:GetPropertyChangedSignal("MoveDirection"):Connect(function() --[[ Line: 256 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_Magnitude_0 (ref), v64 (copy), v65 (ref), v35 (ref)
                    local l_Magnitude_1 = l_Humanoid_0.MoveDirection.Magnitude;
                    if l_Magnitude_0 == 0 and l_Magnitude_1 > 0 and tick() >= v64 + 0.25 and not v65 then
                        v65 = true;
                        v35();
                        toggleGeneratorState("leave");
                    end;
                    l_Magnitude_0 = l_Magnitude_1;
                end);
                local v67 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                v10.Sprinted = v67.SprintToggled and v67.SprintToggled:Connect(function(v68) --[[ Line: 268 ]]
                    -- upvalues: v35 (ref)
                    if v68 then
                        v35();
                        toggleGeneratorState("leave");
                    end;
                end);
                local l_Position_0 = l_Parent_0.PrimaryPart.Position;
                local v70 = false;
                v10.Teleported = l_PrimaryPart_0:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 278 ]]
                    -- upvalues: l_Position_0 (copy), l_PrimaryPart_0 (copy), v70 (ref), v35 (ref)
                    if (l_Position_0 - l_PrimaryPart_0.Position).Magnitude > 16 and not v70 then
                        v70 = true;
                        v35();
                        toggleGeneratorState("leave");
                    end;
                end);
                return;
            end;
        end;
    end;
end;
toggleGeneratorState = function(v72) --[[ Line: 287 ]] --[[ Name: toggleGeneratorState ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_RF_0 (copy), v24 (copy), v71 (copy)
    local l_Character_1 = l_LocalPlayer_0.Character;
    if not l_Character_1 or not l_Character_1.PrimaryPart then
        return;
    else
        local v74, v75, v76 = l_RF_0:InvokeServer(v72);
        local v77 = {
            tooFar = "Move a bit closer to an available side of the generator and try again.", 
            positionOccupied = "Move to another side of the generator and try again.", 
            tooMany = "Too many people are fixing the generator right now. Try again later.", 
            alreadyFixed = "This generator's already been fixed. Go try fixing another one.", 
            dead = "Try not to die next time.", 
            isKiller = "You're supposed to be killing them, not helping them. Go do that.", 
            isUnknownTeam = "Dude what r u doing rn you're a spectator", 
            leftAlready = ""
        };
        if v77[v74] then
            v24(v77[v74]);
        elseif not v74 then
            v24("An unknown error occurred while trying to fix the generator. Try again.");
        end;
        if v74 == "fixing" then
            v71(v75, v76);
            return;
        else
            if v74 == "notFixing" then

            end;
            return;
        end;
    end;
end;
if v3 then
    v3.Triggered:Connect(function() --[[ Line: 318 ]]
        toggleGeneratorState("enter");
    end);
end;
l_Progress_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 324 ]]
    -- upvalues: l_Parent_0 (copy), l_Progress_0 (copy)
    local l_Bar_0 = l_Parent_0.Instances.Generator.Progress.BarUI.Bar;
    local v79 = l_Progress_0.Value / 100;
    game.TweenService:Create(l_Bar_0, TweenInfo.new(0.5), {
        Size = UDim2.fromScale(v79, 1), 
        BackgroundTransparency = 1 - v79
    }):Play();
end);
l_Parent_0.AncestryChanged:Connect(function(_, v81) --[[ Line: 331 ]]
    -- upvalues: v35 (copy)
    if not v81 then
        v35();
    end;
end);