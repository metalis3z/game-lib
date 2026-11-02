-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
v0.ToggleEmoteMenu = function(_) --[[ Line: 6 ]] --[[ Name: ToggleEmoteMenu ]]
    -- upvalues: v0 (copy)
    if v0.EmoteMenu and v0.EmoteMenu.FrameHolder:FindFirstChild("RadialMenu") then
        v0.EmoteMenu.CurrentlyVisible = not v0.EmoteMenu.CurrentlyVisible;
        if v0.EmoteMenu.TogglingThread then
            task.cancel(v0.EmoteMenu.TogglingThread);
        end;
        if v0.EmoteMenu.CurrentlyVisible then
            game.TweenService:Create(v0.EmoteMenu.FrameHolder, TweenInfo.new(0.15), {
                Size = UDim2.fromScale(0.5, 0.5)
            }):Play();
            game.TweenService:Create(v0.Blur, TweenInfo.new(0.15), {
                Size = 12
            }):Play();
            v0.EmoteMenu.FrameHolder.Visible = true;
            return;
        else
            game.TweenService:Create(v0.EmoteMenu.FrameHolder, TweenInfo.new(0.15), {
                Size = UDim2.fromScale()
            }):Play();
            game.TweenService:Create(v0.Blur, TweenInfo.new(0.15), {
                Size = 0
            }):Play();
            v0.EmoteMenu.TogglingThread = task.delay(0.15, function() --[[ Line: 20 ]]
                -- upvalues: v0 (ref)
                v0.EmoteMenu.FrameHolder.Visible = false;
            end);
        end;
    end;
end;
v0.GetPlayerEmotes = function(_) --[[ Line: 27 ]] --[[ Name: GetPlayerEmotes ]]
    local v4 = false;
    local v5 = require(game.ReplicatedStorage.Modules.Util);
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_PlayerData_0 = l_LocalPlayer_0:WaitForChild("PlayerData");
    local v8 = string.split(l_PlayerData_0.Equipped.Emotes.Value, "|");
    local _ = function(v9) --[[ Line: 34 ]] --[[ Name: getLengthOfDict ]]
        local v10 = 0;
        for _, _ in pairs(v9) do
            v10 = v10 + 1;
        end;
        return v10;
    end;
    local v14 = {
        Animations = {}, 
        Voicelines = {}
    };
    if not l_LocalPlayer_0.Character:GetAttribute("CustomRig") and (l_LocalPlayer_0.Character.Parent ~= workspace.Players.Killers or workspace:GetAttribute("ServerType") == "VIP") then
        local l_Emotes_0 = game.ReplicatedStorage.Assets.Emotes;
        for _, v17 in pairs(v8) do
            local l_l_Emotes_0_FirstChild_0 = l_Emotes_0:FindFirstChild(v17);
            local v19 = l_l_Emotes_0_FirstChild_0 and v5:CopyTable(require(l_l_Emotes_0_FirstChild_0));
            if v19 and (v19.AssetID or v19.AssetIDs) then
                v19.RealAssetName = l_l_Emotes_0_FirstChild_0.Name;
                table.insert(v14.Animations, v19);
            else
                table.insert(v14.Animations, "nil");
            end;
        end;
    end;
    if l_LocalPlayer_0.Character.Parent ~= workspace.Players.Spectating then
        local v20 = tick();
        local v21 = require(game.ReplicatedStorage.Modules.Actors);
        if not v21.CurrentActors[l_LocalPlayer_0] then
            repeat
                task.wait();
            until v21.CurrentActors[l_LocalPlayer_0] or tick() >= v20 + 5;
        end;
        if v21.CurrentActors[l_LocalPlayer_0] then
            local l_Emotes_1 = v21.CurrentActors[l_LocalPlayer_0].Config.Emotes;
            if l_Emotes_1 then
                for v23, v24 in pairs(l_Emotes_1) do
                    for v25, v26 in pairs(v24) do
                        if v14[v23] then
                            v26.RealAssetName = v25;
                            table.insert(v14[v23], v26);
                        else
                            warn(debug.traceback((("emote type of %* doesn't exist"):format(v23))));
                        end;
                    end;
                end;
            end;
        end;
    end;
    local l_Animations_0 = v14.Animations;
    local v28 = 0;
    for _, _ in pairs(l_Animations_0) do
        v28 = v28 + 1;
    end;
    local v31;
    if v28 <= 0 then
        v31 = false;
        l_Animations_0 = v14.Animations;
        v28 = 0;
        for _, _ in pairs(l_Animations_0) do
            v28 = v28 + 1;
        end;
        v4 = v28 <= 0;
    end;
    if not v4 then
        v31 = v14;
    end;
    v4 = false;
    return v31;
end;
v0.BuildMenu = function(_) --[[ Line: 90 ]] --[[ Name: BuildMenu ]]
    -- upvalues: v0 (copy), v1 (copy)
    local v35 = require(script.RadialMenu);
    local v36 = game.Players.LocalPlayer.PlayerGui:WaitForChild("TemporaryUI", 15);
    if not v36 then
        return;
    else
        local l_v0_PlayerEmotes_0 = v0:GetPlayerEmotes();
        if not l_v0_PlayerEmotes_0 then
            return;
        else
            local l_EmoteMenuHolder_0 = v36:FindFirstChild("EmoteMenuHolder");
            while l_EmoteMenuHolder_0 do
                l_EmoteMenuHolder_0.Name = "byebye";
                l_EmoteMenuHolder_0:Destroy();
                l_EmoteMenuHolder_0 = v36:FindFirstChild("EmoteMenuHolder");
            end;
            local v39 = script.EmoteMenuHolder:Clone();
            v39.Visible = false;
            v39.Size = UDim2.fromScale(0, 0);
            v39.Parent = v36;
            local v40 = {};
            for _, v42 in pairs({
                v39.Last, 
                v39.Next
            }) do
                v42.MouseEnter:Connect(function() --[[ Line: 118 ]]
                    -- upvalues: v1 (ref), v40 (copy), v42 (copy)
                    v1:Play("hover");
                    v40[v42.Name] = true;
                end);
                v42.MouseLeave:Connect(function() --[[ Line: 122 ]]
                    -- upvalues: v1 (ref), v40 (copy), v42 (copy)
                    v1:Play("hoverEnd");
                    v40[v42.Name] = nil;
                end);
            end;
            local function v45() --[[ Line: 129 ]] --[[ Name: isOnButton ]]
                -- upvalues: v39 (copy), v40 (copy)
                for _, v44 in pairs({
                    v39.Last, 
                    v39.Next
                }) do
                    if game.GuiService.SelectedObject == v44 then
                        return true;
                    end;
                end;
                return v40.Last or v40.Next;
            end;
            local v46 = 0;
            local v47 = {};
            local v48 = {
                Animations = 1, 
                Voicelines = 2
            };
            local v49 = {
                Animations = "Emotes"
            };
            local v50 = 1;
            for v51, v52 in pairs({
                v39.Last, 
                v39.Next
            }) do
                v52.MouseButton1Click:Connect(function() --[[ Line: 154 ]]
                    -- upvalues: v1 (ref), v50 (ref), v51 (copy), v46 (ref), v48 (copy), v47 (copy), v39 (copy), v49 (copy)
                    v1:Play("switch");
                    v50 = v50 + (v51 == 1 and -1 or 1);
                    local v53 = v50 % v46 + 1;
                    for v54, v55 in pairs(v48) do
                        if v47[v54] then
                            if v53 == v55 then
                                v39.EmoteType.Text = v49[v54] or v54;
                                v47[v54].Frame.Visible = true;
                            else
                                v47[v54].Frame.Visible = false;
                            end;
                        end;
                    end;
                end);
            end;
            for v56, v57 in pairs(l_v0_PlayerEmotes_0) do
                if #v57 > 0 then
                    local v58 = v35.new(#v57, 0.5, 0);
                    v58.Frame.Name = "RadialMenu";
                    v58.Frame.Visible = false;
                    v58.Frame.Parent = v39;
                    v58.FrameHolder = v39;
                    v47[v56] = v58;
                    v58:SetDialProps({
                        ImageColor3 = Color3.new(1, 1, 1), 
                        ImageTransparency = 0
                    });
                    for v59, v60 in pairs(v57) do
                        if v60.RenderImage then
                            local v61 = script.Templates.RenderHolder:Clone();
                            v61.Asset.Image = v60.RenderImage;
                            v61.Parent = v58:GetAttachment(v59);
                        elseif v60.DisplayName then
                            local v62 = script.Templates.TitleHolder:Clone();
                            v62.Text = v60.DisplayName;
                            v62.Parent = v58:GetAttachment(v59);
                        end;
                    end;
                    v58.Clicked:Connect(function(v63) --[[ Line: 205 ]]
                        -- upvalues: v58 (copy), v39 (copy), v0 (ref), v45 (copy), v1 (ref), v57 (copy), v56 (copy)
                        if v58.Frame.Visible and v39.Size.X.Scale >= 0.4 and v0.EmoteMenu.CurrentlyVisible and not v45() then
                            v0:ToggleEmoteMenu();
                            v1:Play("select");
                            local v64 = v57[v63].RealAssetName or v57[v63].DisplayName;
                            v0.CurrentEmoteIndex = {
                                v56, 
                                v64
                            };
                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("PlayEmote", "REMOTE_EVENT", v56, v64);
                        end;
                    end);
                    v58.Hover:Connect(function(v65, v66) --[[ Line: 219 ]]
                        -- upvalues: v57 (copy), v58 (copy), v39 (copy), v1 (ref)
                        local _ = v57[v65];
                        local v68 = v57[v66];
                        if v58.Frame.Visible and v39.Size.X.Scale >= 0.4 and v68 then
                            v1:Play("hover");
                            local v69 = not v68.RenderImage and v68.DisplayName and v68.Description or v68.DisplayName or "";
                            if v69 ~= "" then
                                v39.EmoteDescription.Title.Text = v69;
                                if v39.EmoteDescription.ImageTransparency >= 0.5 then
                                    game.TweenService:Create(v39.EmoteDescription, TweenInfo.new(0.1), {
                                        ImageTransparency = 0
                                    }):Play();
                                    game.TweenService:Create(v39.EmoteDescription.Title, TweenInfo.new(0.1), {
                                        TextTransparency = 0
                                    }):Play();
                                    return;
                                end;
                            elseif v39.EmoteDescription.ImageTransparency <= 0.5 then
                                game.TweenService:Create(v39.EmoteDescription, TweenInfo.new(0.1), {
                                    ImageTransparency = 1
                                }):Play();
                                game.TweenService:Create(v39.EmoteDescription.Title, TweenInfo.new(0.1), {
                                    TextTransparency = 1
                                }):Play();
                                return;
                            end;
                        else
                            local v70 = if not v68 or v68.RenderImage then nil else v68.Description or v68.DisplayName;
                            v39.EmoteDescription.Title.Text = tostring(v70);
                            v39.EmoteDescription.ImageTransparency = v70 and 0 or 1;
                            v39.EmoteDescription.Title.TextTransparency = v70 and 0 or 1;
                        end;
                    end);
                    v39.AncestryChanged:Connect(function(_, v72) --[[ Line: 246 ]]
                        -- upvalues: v58 (copy)
                        if not v72 then
                            v58:Destroy();
                        end;
                    end);
                end;
            end;
            if v47.Animations then
                v39.EmoteType.Text = "Emotes";
                v47.Animations.Frame.Visible = true;
                v50 = 0;
            elseif v47.Voicelines then
                v39.EmoteType.Text = "Voicelines";
                v47.Voicelines.Frame.Visible = true;
                v50 = 1;
            end;
            for _, _ in pairs(v47) do
                v46 = v46 + 1;
            end;
            if v46 <= 1 then
                v39.Last.Visible = false;
                v39.Next.Visible = false;
            end;
            v0.EmoteMenu = {
                FrameHolder = v39, 
                RadialDials = v47
            };
            return;
        end;
    end;
end;
v0.Start = function(_) --[[ Line: 283 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    if not v0.Blur then
        v0.Blur = Instance.new("BlurEffect");
        v0.Blur.Name = "EmoteBlur";
        v0.Blur.Size = 0;
        v0.Blur.Parent = game.Lighting;
    end;
    game.TweenService:Create(v0.Blur, TweenInfo.new(0.3), {
        Size = 0
    }):Play();
    if v0.Connection then
        v0.Connection:Disconnect();
        v0.Connection = nil;
    end;
    v0:BuildMenu();
    if not v0.EmoteMenu then
        return;
    else
        v0.Connection = game.UserInputService.InputBegan:Connect(function(v76, v77) --[[ Line: 300 ]]
            -- upvalues: v0 (ref)
            if v77 then
                return;
            else
                local l_Keybinds_0 = game.Players.LocalPlayer.PlayerData.Settings.Keybinds;
                local v79 = {
                    l_Keybinds_0.Emoter.Value, 
                    l_Keybinds_0["Emote~Console"].Value
                };
                if table.find(v79, v76.KeyCode.Name) or table.find(v79, v76.UserInputType.Name) then
                    v0:ToggleEmoteMenu();
                end;
                return;
            end;
        end);
        local v80 = require(game.ReplicatedStorage.Modules.Device);
        local function v83() --[[ Line: 314 ]] --[[ Name: setupEmoteButton ]]
            -- upvalues: v0 (ref), v80 (copy)
            if v0.EmoteIcon then
                v0.EmoteIcon:Destroy();
            end;
            if v80:GetPlayerDevice() == "Mobile" then
                v0.EmoteIcon = require(game.ReplicatedStorage.Modules.Icon).new();
                v0.EmoteIcon:setOrder(10);
                v0.EmoteIcon:oneClick(true);
                v0.EmoteIcon:setLabel("Emote");
                v0.EmoteIcon:bindEvent("deselected", function() --[[ Line: 325 ]]
                    -- upvalues: v0 (ref)
                    local l_Character_0 = v0.Character;
                    local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
                    if l_Character_0:GetAttribute("UsingAnimations") and l_Humanoid_0 then
                        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("StopEmote", "REMOTE_EVENT", v0.CurrentEmoteIndex[1], v0.CurrentEmoteIndex[2]);
                        v0.CurrentEmoteIndex = nil;
                        return;
                    else
                        v0:ToggleEmoteMenu();
                        return;
                    end;
                end);
            end;
        end;
        v0.DeviceConnection = v80.Changed:Connect(v83);
        v83();
        v0.Character = game.Players.LocalPlayer.Character;
        return;
    end;
end;
v0.Destroy = function(_) --[[ Line: 348 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.DeviceConnection then
        v0.DeviceConnection:Disconnect();
    end;
end;
return v0;