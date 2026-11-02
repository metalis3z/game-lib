-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.Modules.Schematics.GroupRankTranslations);
local _ = game:GetService("MarketplaceService");
local v2 = {};
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local v4 = require(game.ReplicatedStorage.Modules.Network);
local l_ControlModule_0 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));
v2.ToggleEmoteMenu = function(_) --[[ Line: 19 ]] --[[ Name: ToggleEmoteMenu ]]
    -- upvalues: v2 (copy)
    if v2.EmoteMenu and v2.EmoteMenu.FrameHolder:FindFirstChild("RadialMenu") then
        v2.EmoteMenu.CurrentlyVisible = not v2.EmoteMenu.CurrentlyVisible;
        if v2.EmoteMenu.TogglingThread then
            task.cancel(v2.EmoteMenu.TogglingThread);
        end;
        if v2.EmoteMenu.CurrentlyVisible then
            game.TweenService:Create(v2.EmoteMenu.FrameHolder, TweenInfo.new(0.15), {
                Size = UDim2.fromScale(0.5, 0.5)
            }):Play();
            game.TweenService:Create(v2.Blur, TweenInfo.new(0.15), {
                Size = 12
            }):Play();
            v2.EmoteMenu.FrameHolder.Visible = true;
            return;
        else
            game.TweenService:Create(v2.EmoteMenu.FrameHolder, TweenInfo.new(0.15), {
                Size = UDim2.fromScale()
            }):Play();
            game.TweenService:Create(v2.Blur, TweenInfo.new(0.15), {
                Size = 0
            }):Play();
            v2.EmoteMenu.TogglingThread = task.delay(0.15, function() --[[ Line: 33 ]]
                -- upvalues: v2 (ref)
                v2.EmoteMenu.FrameHolder.Visible = false;
            end);
        end;
    end;
end;
v2.GetPlayerEmotes = function(_) --[[ Line: 40 ]] --[[ Name: GetPlayerEmotes ]]
    -- upvalues: v0 (copy)
    local v8 = false;
    local v9 = require(game.ReplicatedStorage.Modules.Util);
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_PlayerData_0 = l_LocalPlayer_0:WaitForChild("PlayerData");
    local v12 = string.split(l_PlayerData_0.Equipped.Emotes.Value, "|");
    local v13 = string.split(l_PlayerData_0.Equipped.ExtraEmotes.Value, "|");
    local _ = function(v14) --[[ Line: 48 ]] --[[ Name: getLengthOfDict ]]
        local v15 = 0;
        for _, _ in pairs(v14) do
            v15 = v15 + 1;
        end;
        return v15;
    end;
    local v19 = {
        Animations = {}, 
        AnimationsExtra = {}, 
        Voicelines = {}
    };
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 63 ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        return l_LocalPlayer_0:GetRankInGroup(33548380);
    end);
    l_result_0 = l_status_0 and l_result_0 or 0;
    if not l_LocalPlayer_0.Character:GetAttribute("CustomRig") and (l_LocalPlayer_0.Character.Parent ~= workspace.Players.Killers or workspace:GetAttribute("ServerType") == "VIP" or v0.Tester <= l_result_0) then
        local l_Emotes_0 = game.ReplicatedStorage.Assets.Emotes;
        for _, v24 in pairs(v12) do
            local l_l_Emotes_0_FirstChild_0 = l_Emotes_0:FindFirstChild(v24);
            local v26 = l_l_Emotes_0_FirstChild_0 and v9:CopyTable(require(l_l_Emotes_0_FirstChild_0));
            if v26 and (v26.AssetID or v26.AssetIDs) then
                v26.RealAssetName = l_l_Emotes_0_FirstChild_0.Name;
                table.insert(v19.Animations, v26);
            else
                table.insert(v19.Animations, "nil");
            end;
        end;
        if l_LocalPlayer_0:GetAttribute("ExtraEmotes") then
            for _, v28 in pairs(v13) do
                local l_l_Emotes_0_FirstChild_1 = l_Emotes_0:FindFirstChild(v28);
                local v30 = l_l_Emotes_0_FirstChild_1 and v9:CopyTable(require(l_l_Emotes_0_FirstChild_1));
                if v30 and (v30.AssetID or v30.AssetIDs) then
                    v30.RealAssetName = l_l_Emotes_0_FirstChild_1.Name;
                    table.insert(v19.AnimationsExtra, v30);
                else
                    table.insert(v19.AnimationsExtra, "nil");
                end;
            end;
        end;
    end;
    if l_LocalPlayer_0.Character.Parent ~= workspace.Players.Spectating then
        local v31 = tick();
        local v32 = require(game.ReplicatedStorage.Modules.Actors);
        if not v32.CurrentActors[l_LocalPlayer_0] then
            repeat
                task.wait();
            until v32.CurrentActors[l_LocalPlayer_0] or tick() >= v31 + 5;
        end;
        if v32.CurrentActors[l_LocalPlayer_0] then
            local l_Emotes_1 = v32.CurrentActors[l_LocalPlayer_0].Config.Emotes;
            if l_Emotes_1 then
                for v34, v35 in pairs(l_Emotes_1) do
                    for v36, v37 in pairs(v35) do
                        if v19[v34] then
                            v37.RealAssetName = v36;
                            table.insert(v19[v34], v37);
                        else
                            warn(debug.traceback((("emote type of %* doesn't exist"):format(v34))));
                        end;
                    end;
                end;
            end;
        end;
    end;
    local l_Animations_0 = v19.Animations;
    local v39 = 0;
    for _, _ in pairs(l_Animations_0) do
        v39 = v39 + 1;
    end;
    local v42;
    if v39 <= 0 then
        l_Animations_0 = v19.AnimationsExtra;
        v39 = 0;
        for _, _ in pairs(l_Animations_0) do
            v39 = v39 + 1;
        end;
        if v39 <= 0 then
            v42 = false;
            l_Animations_0 = v19.Voicelines;
            v39 = 0;
            for _, _ in pairs(l_Animations_0) do
                v39 = v39 + 1;
            end;
            v8 = v39 <= 0;
        end;
    end;
    if not v8 then
        v42 = v19;
    end;
    v8 = false;
    return v42;
end;
v2.BuildMenu = function(_) --[[ Line: 122 ]] --[[ Name: BuildMenu ]]
    -- upvalues: v2 (copy), v3 (copy)
    local v48 = require(script.RadialMenu);
    local l_LocalPlayer_1 = game.Players.LocalPlayer;
    local v50 = l_LocalPlayer_1:GetAttribute("ExtraEmotes") == true;
    local v51 = l_LocalPlayer_1.PlayerGui:WaitForChild("TemporaryUI", 15);
    if not v51 then
        return;
    else
        local l_v2_PlayerEmotes_0 = v2:GetPlayerEmotes();
        if not l_v2_PlayerEmotes_0 then
            return;
        else
            local l_EmoteMenuHolder_0 = v51:FindFirstChild("EmoteMenuHolder");
            while l_EmoteMenuHolder_0 do
                l_EmoteMenuHolder_0.Name = "byebye";
                l_EmoteMenuHolder_0:Destroy();
                l_EmoteMenuHolder_0 = v51:FindFirstChild("EmoteMenuHolder");
            end;
            local v54 = script.EmoteMenuHolder:Clone();
            v54.Visible = false;
            v54.Size = UDim2.fromScale(0, 0);
            v54.Parent = v51;
            local v55 = {};
            for _, v57 in pairs({
                v54.Last, 
                v54.Next
            }) do
                v57.MouseEnter:Connect(function() --[[ Line: 151 ]]
                    -- upvalues: v3 (ref), v55 (copy), v57 (copy)
                    v3:Play("hover");
                    v55[v57.Name] = true;
                end);
                v57.MouseLeave:Connect(function() --[[ Line: 155 ]]
                    -- upvalues: v3 (ref), v55 (copy), v57 (copy)
                    v3:Play("hoverEnd");
                    v55[v57.Name] = nil;
                end);
            end;
            local function v60() --[[ Line: 162 ]] --[[ Name: isOnButton ]]
                -- upvalues: v54 (copy), v55 (copy)
                for _, v59 in pairs({
                    v54.Last, 
                    v54.Next
                }) do
                    if game.GuiService.SelectedObject == v59 then
                        return true;
                    end;
                end;
                return v55.Last or v55.Next;
            end;
            local v61 = 0;
            local v62 = {};
            local v63 = {
                Animations = 1, 
                AnimationsExtra = 2, 
                Voicelines = 3
            };
            local v64 = {
                Animations = v50 and "Emotes 1" or "Emotes", 
                AnimationsExtra = "Emotes 2"
            };
            local v65 = 1;
            for v66, v67 in pairs({
                v54.Last, 
                v54.Next
            }) do
                v67.MouseButton1Click:Connect(function() --[[ Line: 189 ]]
                    -- upvalues: v3 (ref), v65 (ref), v66 (copy), v61 (ref), v63 (copy), v62 (copy), v54 (copy), v64 (copy)
                    v3:Play("switch");
                    v65 = v65 + (v66 == 1 and -1 or 1);
                    local v68 = v65 % v61 + 1;
                    for v69, v70 in pairs(v63) do
                        if v62[v69] then
                            if v68 == v70 then
                                v54.EmoteType.Text = v64[v69] or v69;
                                v62[v69].Frame.Visible = true;
                            else
                                v62[v69].Frame.Visible = false;
                            end;
                        end;
                    end;
                end);
            end;
            for v71, v72 in pairs(l_v2_PlayerEmotes_0) do
                if #v72 > 0 then
                    local v73 = v48.new(#v72, 0.5, 0);
                    v73.Frame.Name = "RadialMenu";
                    v73.Frame.Visible = false;
                    v73.Frame.Parent = v54;
                    v73.FrameHolder = v54;
                    v62[v71] = v73;
                    v73:SetDialProps({
                        ImageColor3 = Color3.new(1, 1, 1), 
                        ImageTransparency = 0
                    });
                    for v74, v75 in pairs(v72) do
                        if v75.RenderImage then
                            local v76 = script.Templates.RenderHolder:Clone();
                            v76.Asset.Image = v75.RenderImage;
                            v76.Parent = v73:GetAttachment(v74);
                        elseif v75.DisplayName then
                            local v77 = script.Templates.TitleHolder:Clone();
                            v77.Text = v75.DisplayName;
                            v77.Parent = v73:GetAttachment(v74);
                        end;
                    end;
                    v73.Clicked:Connect(function(v78) --[[ Line: 240 ]]
                        -- upvalues: v73 (copy), v54 (copy), v2 (ref), v60 (copy), v3 (ref), v72 (copy), v71 (copy)
                        if v73.Frame.Visible and v54.Size.X.Scale >= 0.4 and v2.EmoteMenu.CurrentlyVisible and not v60() then
                            v2:ToggleEmoteMenu();
                            v3:Play("select");
                            local v79 = v72[v78].RealAssetName or v72[v78].DisplayName;
                            v2.CurrentEmoteIndex = {
                                v71, 
                                v79
                            };
                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("PlayEmote", "REMOTE_EVENT", v71, v79);
                        end;
                    end);
                    v73.Hover:Connect(function(v80, v81) --[[ Line: 254 ]]
                        -- upvalues: v72 (copy), v73 (copy), v54 (copy), v3 (ref)
                        local _ = v72[v80];
                        local v83 = v72[v81];
                        if v73.Frame.Visible and v54.Size.X.Scale >= 0.4 and v83 then
                            v3:Play("hover");
                            local v84 = not v83.RenderImage and v83.DisplayName and v83.Description or v83.DisplayName or "";
                            if v84 ~= "" then
                                v54.EmoteDescription.Title.Text = v84;
                                if v54.EmoteDescription.ImageTransparency >= 0.5 then
                                    game.TweenService:Create(v54.EmoteDescription, TweenInfo.new(0.1), {
                                        ImageTransparency = 0
                                    }):Play();
                                    game.TweenService:Create(v54.EmoteDescription.Title, TweenInfo.new(0.1), {
                                        TextTransparency = 0
                                    }):Play();
                                    return;
                                end;
                            elseif v54.EmoteDescription.ImageTransparency <= 0.5 then
                                game.TweenService:Create(v54.EmoteDescription, TweenInfo.new(0.1), {
                                    ImageTransparency = 1
                                }):Play();
                                game.TweenService:Create(v54.EmoteDescription.Title, TweenInfo.new(0.1), {
                                    TextTransparency = 1
                                }):Play();
                                return;
                            end;
                        else
                            local v85 = if not v83 or v83.RenderImage then nil else v83.Description or v83.DisplayName;
                            v54.EmoteDescription.Title.Text = tostring(v85);
                            v54.EmoteDescription.ImageTransparency = v85 and 0 or 1;
                            v54.EmoteDescription.Title.TextTransparency = v85 and 0 or 1;
                        end;
                    end);
                    v54.AncestryChanged:Connect(function(_, v87) --[[ Line: 281 ]]
                        -- upvalues: v73 (copy)
                        if not v87 then
                            v73:Destroy();
                        end;
                    end);
                end;
            end;
            for v88, v89 in ipairs({
                "Animations", 
                "AnimationsExtra", 
                "Voicelines"
            }) do
                if v62[v89] then
                    v54.EmoteType.Text = v64[v89] or v89;
                    v62[v89].Frame.Visible = true;
                    v65 = v88 - 1;
                    break;
                end;
            end;
            for _, _ in pairs(v62) do
                v61 = v61 + 1;
            end;
            if v61 <= 1 then
                v54.Last.Visible = false;
                v54.Next.Visible = false;
            end;
            v2.EmoteMenu = {
                FrameHolder = v54, 
                RadialDials = v62
            };
            return;
        end;
    end;
end;
v2.Start = function(_) --[[ Line: 317 ]] --[[ Name: Start ]]
    -- upvalues: v4 (copy), v2 (copy), l_ControlModule_0 (copy)
    v4:SetConnection("SetEmoteProximityStateAsync", "UREMOTE_EVENT", function(v93, v94) --[[ Line: 318 ]]
        if v93 and typeof(v93) == "Instance" then
            v93.Enabled = v94;
        end;
    end);
    v4:SetConnection("ReplicateEmoteData", "REMOTE_EVENT", function(v95, v96, v97) --[[ Line: 324 ]]
        local l_FirstChild_0 = game.ReplicatedStorage.Assets.Emotes:FindFirstChild(v96);
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 326 ]]
            -- upvalues: l_FirstChild_0 (copy)
            return l_FirstChild_0 and require(l_FirstChild_0);
        end);
        if not l_status_1 or not l_result_1 then
            warn((("[%*/ReplicateEmoteData]: Failed to get emote module: %*"):format(script, v96)));
            return;
        else
            if v97 then
                local l_Humanoid_0 = v97.Character:FindFirstChildOfClass("Humanoid");
                local v102 = l_Humanoid_0 and l_Humanoid_0:FindFirstChild("Animator");
                if v102 then
                    for _, v104 in (v102:GetPlayingAnimationTracks()) do
                        if v104.Animation.AnimationId == l_result_1.AssetID then
                            v97.Emote = v104;
                            break;
                        end;
                    end;
                end;
            end;
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 348 ]]
                -- upvalues: l_result_1 (copy), v95 (copy), v97 (copy)
                local v105 = l_result_1[v95 and "Created" or "Destroyed"];
                if v105 then
                    return v105(v97);
                else
                    return;
                end;
            end);
            if not l_status_2 then
                warn((("[%*/ReplicateEmoteData]: Failed to call .%*() on emote module: %* due to: %*"):format(script, v95 and "Created" or "Destroyed", v96, l_result_2)));
            end;
            return;
        end;
    end);
    if not v2.Blur then
        v2.Blur = Instance.new("BlurEffect");
        v2.Blur.Name = "EmoteBlur";
        v2.Blur.Size = 0;
        v2.Blur.Parent = game.Lighting;
    end;
    game.TweenService:Create(v2.Blur, TweenInfo.new(0.3), {
        Size = 0
    }):Play();
    if v2.KeybindConnection then
        v2.KeybindConnection:Disconnect();
        v2.KeybindConnection = nil;
    end;
    v2:BuildMenu();
    if not v2.EmoteMenu then
        return;
    else
        v2.KeybindConnection = game.UserInputService.InputBegan:Connect(function(v108, v109) --[[ Line: 378 ]]
            -- upvalues: v2 (ref)
            if v109 then
                return;
            else
                local l_Keybinds_0 = game.Players.LocalPlayer.PlayerData.Settings.Keybinds;
                local v111 = {
                    l_Keybinds_0.Emote.Value, 
                    l_Keybinds_0["Emote~Console"].Value
                };
                if table.find(v111, v108.KeyCode.Name) or table.find(v111, v108.UserInputType.Name) then
                    v2:ToggleEmoteMenu();
                end;
                return;
            end;
        end);
        local v112 = require(game.ReplicatedStorage.Modules.Device);
        local function v115() --[[ Line: 392 ]] --[[ Name: setupEmoteButton ]]
            -- upvalues: v2 (ref), v112 (copy)
            if v2.EmoteIcon then
                v2.EmoteIcon:Destroy();
            end;
            if v112:GetPlayerDevice() == "Mobile" then
                v2.EmoteIcon = require(game.ReplicatedStorage.Modules.Icon).new();
                v2.EmoteIcon:setOrder(10);
                v2.EmoteIcon:oneClick(true);
                v2.EmoteIcon:setLabel("Emote");
                v2.EmoteIcon:bindEvent("deselected", function() --[[ Line: 403 ]]
                    -- upvalues: v2 (ref)
                    local l_Character_0 = v2.Character;
                    local l_Humanoid_1 = l_Character_0:FindFirstChild("Humanoid");
                    if l_Character_0:GetAttribute("UsingAnimations") and l_Humanoid_1 then
                        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("StopEmote", "REMOTE_EVENT", v2.CurrentEmoteIndex[1], v2.CurrentEmoteIndex[2]);
                        v2.CurrentEmoteIndex = nil;
                        return;
                    else
                        v2:ToggleEmoteMenu();
                        return;
                    end;
                end);
            end;
        end;
        v2.DeviceConnection = v112.Changed:Connect(v115);
        v115();
        v4:SetConnection("EmoteAutoWalk", "REMOTE_EVENT", function(v116) --[[ Line: 422 ]]
            -- upvalues: l_ControlModule_0 (ref)
            if v116 then
                local l_Character_1 = game.Players.LocalPlayer.Character;
                local v118 = l_Character_1 and l_Character_1:WaitForChild("Humanoid", 1);
                local v119 = l_Character_1 and l_Character_1:FindFirstChild("HumanoidRootPart");
                local v120 = v119 and (v119.CFrame.LookVector * Vector3.new(1, 0, 1, 0)).Unit;
                if v118 then
                    game["Run Service"]:BindToRenderStep("EmoteAutoWalk", Enum.RenderPriority.Character.Value + 1, function(_) --[[ Line: 434 ]]
                        -- upvalues: v119 (copy), v118 (copy), l_ControlModule_0 (ref), v120 (ref)
                        if not v119 or not v118 or v118:GetState() == Enum.HumanoidStateType.Dead then
                            game["Run Service"]:UnbindFromRenderStep("EmoteAutoWalk");
                        end;
                        local v122 = workspace.CurrentCamera.CFrame:VectorToWorldSpace(l_ControlModule_0:GetMoveVector());
                        if (v122 - v120).Magnitude > 0 and v122 ~= Vector3.new(0, 0, 0, 0) then
                            v120 = Vector3.new(v122.X, 0, v122.Z).Unit;
                        end;
                        v118:Move(v120);
                    end);
                end;
                return;
            else
                game["Run Service"]:UnbindFromRenderStep("EmoteAutoWalk");
                return;
            end;
        end);
        v2.Character = game.Players.LocalPlayer.Character;
        v2.EmoteMenu.CurrentlyVisible = false;
        return;
    end;
end;
v2.Destroy = function(_) --[[ Line: 462 ]] --[[ Name: Destroy ]]
    -- upvalues: v2 (copy)
    if v2.DeviceConnection then
        v2.DeviceConnection:Disconnect();
    end;
end;
return v2;