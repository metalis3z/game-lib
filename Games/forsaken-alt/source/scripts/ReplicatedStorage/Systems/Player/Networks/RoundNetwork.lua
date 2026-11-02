-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local v2 = require(game.ReplicatedStorage.Modules.Util);
    local v3 = require(game.ReplicatedStorage.Modules.Network);
    local l_Gamemodes_0 = game.ReplicatedStorage.Modules.Gamemodes;
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    v3:SetConnection("HandleGamemode", "REMOTE_EVENT", function(v7, ...) --[[ Line: 14 ]]
        -- upvalues: l_Gamemodes_0 (copy), v0 (ref)
        if v7 == "Init" then
            local v8, v9 = unpack({
                ...
            });
            v0.CurrentSession = require(l_Gamemodes_0[v8]).Init(v9);
            return;
        else
            if v0.CurrentSession then
                if v7 == "Destroy" then
                    v0.CurrentSession:Destroy(...);
                    v0.CurrentSession = nil;
                    return;
                end;
            else
                warn((("[Rounds] Couldn't do anything with the information (%*) passed to client!"):format((tostring(v7)))));
            end;
            return;
        end;
    end);
    v3:SetConnection("ReplicateMapCreation", "REMOTE_EVENT", function(v10) --[[ Line: 33 ]]
        local v11 = require(v10);
        local v12 = {
            Map = v10.Parent, 
            Config = v11
        };
        if v11.ClientCreated then
            pcall(function() --[[ Line: 43 ]]
                -- upvalues: v11 (copy), v12 (copy)
                v11.ClientCreated(v12);
            end);
        end;
    end);
    v3:SetConnection("LastSurvivor", "REMOTE_EVENT", function(_) --[[ Line: 50 ]]
        -- upvalues: v2 (copy)
        v2:ToggleResetButton(false);
    end);
    v3:SetConnection("PlayWinnerCutscene", "REMOTE_EVENT", function(v14, v15) --[[ Line: 55 ]]
        -- upvalues: v2 (copy), l_LocalPlayer_0 (copy), l_CurrentCamera_0 (copy)
        local v16 = {};
        v2:FadeIn({
            Time = 0.5
        });
        task.wait(0.75);
        l_LocalPlayer_0.PlayerGui.MainUI.Enabled = false;
        l_LocalPlayer_0.PlayerGui.TemporaryUI.Enabled = false;
        local v17 = 3;
        local v18 = nil;
        if v14 == "Killers" then
            local v19 = v15[1];
            if v19 and v19.Config and v19.Config.Animations.Victory then
                local l_CutsceneActor_0, v21, v22 = require(game.ReplicatedStorage.Modules.Actors):CreateCutsceneActor(v19, "Victory");
                v17 = v22;
                table.insert(v16, l_CutsceneActor_0);
                table.insert(v16, v21);
                v18 = require(v19.Folder.Behavior);
                if v18.OnVictory then
                    v18:OnVictory("Start", v19, l_CutsceneActor_0, v22);
                end;
            end;
        elseif v14 == "Survivors" then
            local l_SurvivorWinArea_0 = workspace.Map.Lobby.SurvivorWinArea;
            local v24 = require(game.ReplicatedStorage.Modules.Schematics.SurvivorWinAnims);
            local v25 = math.clamp(math.random(1, #v24), 1, 1e999);
            local v26 = {
                l_SurvivorWinArea_0.SurvivorTable.Tabletop.Position
            };
            local v27 = nil;
            local v28 = nil;
            local l_v26_0 = v26 --[[ copy: 8 -> 23 ]];
            local l_l_SurvivorWinArea_0_0 = l_SurvivorWinArea_0 --[[ copy: 5 -> 24 ]];
            do
                local l_v25_0, l_v27_0, l_v28_0 = v25, v27, v28;
                local function v39() --[[ Line: 99 ]] --[[ Name: updateCamPosition ]]
                    -- upvalues: l_v27_0 (ref), l_v26_0 (copy), l_l_SurvivorWinArea_0_0 (copy), l_v28_0 (ref)
                    if l_v27_0 then
                        local v34 = Vector3.new();
                        for _, v36 in pairs(l_v26_0) do
                            v34 = v34 + v36;
                        end;
                        local v37 = v34 / #l_v26_0;
                        local v38 = CFrame.lookAt(l_l_SurvivorWinArea_0_0.SurvivorWinCam.Position, v37);
                        if l_v28_0 then
                            l_v28_0:Cancel();
                        end;
                        l_v27_0.CFrame = v38 * CFrame.Angles(0, 0, 0.4363323129985824);
                        l_v28_0 = game.TweenService:Create(l_v27_0, TweenInfo.new(3), {
                            CFrame = v38
                        });
                        l_v28_0:Play();
                    end;
                end;
                local l_NumberValue_0 = Instance.new("NumberValue");
                l_NumberValue_0.Name = "CutsceneFOV";
                l_NumberValue_0.Value = 5;
                l_NumberValue_0.Parent = l_SurvivorWinArea_0;
                game.TweenService:Create(l_NumberValue_0, TweenInfo.new(4), {
                    Value = 37.5
                }):Play();
                table.insert(v16, l_NumberValue_0);
                l_LocalPlayer_0:SetAttribute("FOVMultipliersDisabled", true);
                local v41 = nil;
                local l_l_NumberValue_0_0 = l_NumberValue_0 --[[ copy: 12 -> 25 ]];
                v41 = game["Run Service"].RenderStepped:Connect(function(_) --[[ Line: 129 ]]
                    -- upvalues: l_l_NumberValue_0_0 (copy), v41 (ref), l_LocalPlayer_0 (ref), l_CurrentCamera_0 (ref)
                    if not l_l_NumberValue_0_0.Parent then
                        v41:Disconnect();
                        v41 = nil;
                        l_LocalPlayer_0:SetAttribute("FOVMultipliersDisabled", nil);
                        return;
                    else
                        l_CurrentCamera_0.FieldOfView = l_l_NumberValue_0_0.Value;
                        return;
                    end;
                end);
                local _ = task.spawn(function() --[[ Line: 135 ]]
                    -- upvalues: l_v27_0 (ref), l_l_SurvivorWinArea_0_0 (copy), v16 (copy), l_CurrentCamera_0 (ref), l_LocalPlayer_0 (ref)
                    l_v27_0 = Instance.new("Part");
                    l_v27_0.Name = "TemporaryCamera";
                    l_v27_0.Anchored = true;
                    l_v27_0.Transparency = 1;
                    l_v27_0.CFrame = l_l_SurvivorWinArea_0_0.SurvivorWinCam.CFrame;
                    l_v27_0.Parent = l_l_SurvivorWinArea_0_0;
                    table.insert(v16, l_v27_0);
                    while l_v27_0.Parent do
                        l_CurrentCamera_0.CameraType = Enum.CameraType.Scriptable;
                        l_CurrentCamera_0.CFrame = l_v27_0.CFrame;
                        task.wait();
                    end;
                    local v44 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Humanoid");
                    if v44 then
                        l_CurrentCamera_0.CameraSubject = v44;
                    end;
                    l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
                end);
                for v46, v47 in pairs(v15) do
                    local l_FirstChild_0 = l_SurvivorWinArea_0.SurvivorPositions:FindFirstChild(v46);
                    local v49 = v47.Rig and v47.Rig:Clone();
                    if l_FirstChild_0 and v49 and v49.PrimaryPart then
                        task.spawn(function() --[[ Line: 170 ]]
                            -- upvalues: v49 (copy), l_FirstChild_0 (copy), l_SurvivorWinArea_0 (copy), v16 (copy), v26 (copy), v39 (copy), l_v25_0 (ref), v24 (copy), v2 (ref)
                            v49:SetPrimaryPartCFrame(l_FirstChild_0.CFrame);
                            v49.PrimaryPart.Anchored = true;
                            v49.Parent = l_SurvivorWinArea_0;
                            table.insert(v16, v49);
                            for _, v51 in pairs(v49:GetDescendants()) do
                                if v51:IsA("Audio") or v51:IsA("ParticleEmitter") or v51:IsA("Light") or v51:IsA("Beam") or v51:IsA("Highlight") then
                                    v51:Destroy();
                                end;
                            end;
                            table.insert(v26, l_FirstChild_0.Position);
                            v39();
                            l_v25_0 = l_v25_0 + 1;
                            local v52 = v24[l_v25_0 % #v24 + 1];
                            local v53 = v52 and v2:LoadAnimationFromID(v49, v52);
                            if v53 then
                                v53:Play(0);
                                v53.Looped = true;
                                v53.Priority = Enum.AnimationPriority.Action4;
                            end;
                        end);
                    end;
                end;
            end;
        end;
        v2:FadeOut({
            Time = 0.75
        });
        local v54 = script.EndScreen:Clone();
        v54.Parent = l_LocalPlayer_0.PlayerGui;
        local v55 = script.WinnerTitle:Clone();
        v55.Parent = v54;
        v55.Text = #v15 > 1 and ("The %* won."):format(v14) or #v15 == 1 and v14 == "Survivors" and "The last survivor won." or #v15 == 1 and ("The %* won."):format((string.sub(v14, 0, #v14 - 1))) or "Nobody won.";
        v55.TextTransparency = 1;
        v55.Usernames.TextTransparency = 1;
        v54.Main.MainTitle.Text = v55.Text;
        game.TweenService:Create(v55, TweenInfo.new(0.3), {
            TextTransparency = 0
        }):Play();
        game.TweenService:Create(v55.Usernames, TweenInfo.new(0.3), {
            TextTransparency = 0.45
        }):Play();
        for v56, v57 in pairs(v15) do
            if v56 == 1 then
                v55.Usernames.Text = tostring(v57.Username);
            elseif #v15 >= 3 then
                if v56 == #v15 then
                    v55.Usernames.Text = ("%*, and %*"):format(v55.Usernames.Text, (tostring(v57.Username)));
                else
                    v55.Usernames.Text = ("%*, %*"):format(v55.Usernames.Text, (tostring(v57.Username)));
                end;
            elseif #v15 == 2 then
                v55.Usernames.Text = ("%* and %*"):format(v55.Usernames.Text, (tostring(v57.Username)));
            else
                v55.Usernames.Text = ("%*"):format((tostring(v57.Username)));
            end;
        end;
        local _ = require(game.ReplicatedStorage.Modules.Stats);
        local v59 = game.ReplicatedStorage:WaitForChild("FinalRoundStats", 10);
        local v60 = v59 and v2:ValueBaseToTable(v59);
        if v60 then
            local function v64(v61) --[[ Line: 242 ]] --[[ Name: convertToString ]]
                -- upvalues: v2 (ref)
                local v62 = nil;
                local v63 = tostring(v61.ConvertToDisplay);
                if v63:find("<CLOCKTIME>") then
                    v62 = v2:FormatTime(tonumber(v61.Value), "Clock");
                elseif v63:find("<VALUE>") then
                    v62 = v63:gsub("<VALUE>", v61.Value);
                end;
                return v62 or tostring(v61.Value);
            end;
            for v65, v66 in pairs(v60.Round) do
                local v67 = v54.Main.RoundStats:FindFirstChild(v65, true) or script.Stat:Clone();
                if not v67.Parent then
                    v67.Text = ("%*: <b>%*</b>"):format(v65, (v64(v66)));
                    v67.LayoutOrder = #v65;
                    v67.Parent = v54.Main.RoundStats;
                else
                    v67.Text = v64(v66);
                end;
            end;
            local l_v64_0 = v64 --[[ copy: 10 -> 22 ]];
            local function v80(v69) --[[ Line: 266 ]] --[[ Name: updatePlayerStats ]]
                -- upvalues: v60 (copy), v54 (copy), l_v64_0 (copy)
                for v70, v71 in pairs(v60.Players) do
                    if tostring(v70) == tostring(v69) then
                        for _, v73 in pairs(v54.Main.PlayerStats:GetChildren()) do
                            if v73:IsA("GuiObject") and v73.Name ~= "Header" then
                                v73:Destroy();
                            end;
                        end;
                        if v71.Info and v71.Info.RenderImage then
                            local l_CardContainer_0 = v54.Main.PlayerCardHolder.CardContainer;
                            l_CardContainer_0.CharacterRender.Image = v71.Info.RenderImage;
                            l_CardContainer_0.Splatter.Visible = v71.Stats["Time Alive"];
                            l_CardContainer_0.CharacterRender.ImageColor3 = v71.Stats["Time Alive"] and Color3.fromRGB(155, 0, 0) or Color3.fromRGB(255, 255, 255);
                        end;
                        local l_pairs_0 = pairs;
                        local v76 = v71.Stats or {};
                        for v77, v78 in l_pairs_0(v76) do
                            local v79 = script.Stat:Clone();
                            v79.Text = ("%*: <b>%*</b>"):format(v77, (l_v64_0(v78)));
                            v79.LayoutOrder = #v77;
                            v79.Parent = v54.Main.PlayerStats;
                        end;
                        return;
                    end;
                end;
            end;
            v80(l_LocalPlayer_0.Name);
            local v81 = {};
            for v82, _ in pairs(v60.Players) do
                table.insert(v81, (tostring(v82)));
            end;
            local l_StringValue_0 = Instance.new("StringValue");
            l_StringValue_0.Parent = v54;
            l_StringValue_0:SetAttribute("Options", table.concat(v81, "|"));
            require(game.ReplicatedStorage.Systems.Player.UI.Menus.Settings.Templates.String):CreateSettingUI(l_StringValue_0, v54.Main.PlayerStats.Header.PlayerDropdown, v80).Instance.DropdownFrame.ChosenValue.Title.Text = l_LocalPlayer_0.Name;
        end;
        local v85 = {};
        for _, v87 in pairs(v54:GetDescendants()) do
            if v87:IsA("TextLabel") then
                v85[v87] = {
                    TextTransparency = v87.TextTransparency, 
                    Position = v87.Position
                };
                v87.TextTransparency = 1;
                v87.Position = v87.Position - UDim2.fromOffset(0, 10);
            elseif v87:IsA("Frame") then
                v85[v87] = {
                    BackgroundTransparency = v87.BackgroundTransparency, 
                    Position = v87.Position
                };
                v87.BackgroundTransparency = 1;
            elseif v87:IsA("ImageButton") or v87:IsA("ImageLabel") then
                v85[v87] = {
                    ImageTransparency = v87.ImageTransparency, 
                    Position = v87.Position
                };
                v87.ImageTransparency = 1;
            end;
        end;
        task.delay(v17 + 0.5, function() --[[ Line: 334 ]]
            -- upvalues: v85 (copy)
            for v88, v89 in pairs(v85) do
                game.TweenService:Create(v88, TweenInfo.new(0.3), v89):Play();
            end;
        end);
        task.delay(v17, function() --[[ Line: 341 ]]
            -- upvalues: v54 (copy)
            game.TweenService:Create(v54.Main.MainTitle.Underline, TweenInfo.new(1.5), {
                Size = UDim2.new(3, 0, 0, 2)
            }):Play();
        end);
        local v90 = false;
        local function v93() --[[ Line: 347 ]] --[[ Name: stopCutscene ]]
            -- upvalues: v90 (ref), v54 (copy), v16 (copy), v2 (ref), l_LocalPlayer_0 (ref), v18 (ref)
            if v90 then
                return;
            else
                v90 = true;
                game.Debris:AddItem(v54, 0.5);
                for _, v92 in pairs(v16) do
                    game.Debris:AddItem(v92, 0.5);
                end;
                v2:FadeIn({
                    Time = 0.5, 
                    Yield = true
                });
                task.wait(0.25);
                v2:FadeOut({
                    Time = 0.5
                });
                l_LocalPlayer_0.PlayerGui.MainUI.Enabled = true;
                l_LocalPlayer_0.PlayerGui.TemporaryUI.Enabled = true;
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
                workspace.CurrentCamera.CameraSubject = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Humanoid");
                if v18 and v18.OnVictory then
                    v18:OnVictory("End");
                end;
                return;
            end;
        end;
        local l_Return_0 = v54.Main.Return;
        l_Return_0.MouseButton1Click:Connect(v93);
        task.spawn(function() --[[ Line: 377 ]]
            -- upvalues: l_Return_0 (copy), v90 (ref), v93 (copy)
            local v95 = 0;
            local l_Timer_0 = l_Return_0:WaitForChild("Timer");
            while l_Return_0.Parent and not v90 do
                v95 = v95 + game["Run Service"].Heartbeat:Wait();
                l_Timer_0.Text = math.round((math.clamp(25 - v95, 0, 25)));
                if v95 >= 25 then
                    v93();
                end;
            end;
        end);
    end);
end;
return v0;