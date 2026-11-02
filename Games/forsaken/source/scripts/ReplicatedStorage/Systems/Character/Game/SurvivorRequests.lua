-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Connections = {}
};
v0.Start = function(_) --[[ Line: 8 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local v4 = require(game.ReplicatedStorage.Modules.Actors);
    local v5 = require(game.ReplicatedStorage.Modules.Network);
    local v6 = require(game.ReplicatedStorage.Modules.Misc.CharacterHovering);
    if not v0.Initialized then
        v0.Initialized = true;
        v5:SetConnection("SurvivorRequested", "REMOTE_EVENT", function(v7, v8) --[[ Line: 21 ]]
            -- upvalues: v4 (copy), l_LocalPlayer_0 (copy)
            local v9 = v4.CurrentActors[l_LocalPlayer_0];
            local v10 = v9 and v9.Config.Requests and v9.Config.Requests[v8];
            local l_Character_1 = v7.Character;
            local v12 = l_Character_1 and l_Character_1.PrimaryPart;
            if v10 and v12 then
                local v13 = script.RequestUI:Clone();
                v13.Title.Text = v10.NotificationTitle:gsub("PLAYERNAME", l_Character_1.Name);
                v13.Adornee = v12;
                v13.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
                local l_Highlight_0 = Instance.new("Highlight");
                l_Highlight_0.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
                l_Highlight_0.Adornee = l_Character_1;
                l_Highlight_0.FillColor = Color3.new(0.5, 1, 0.5);
                l_Highlight_0.OutlineColor = Color3.new(0.5, 1, 0.5);
                local v15 = {
                    [v13.Title] = {
                        TextTransparency = 0, 
                        TextStrokeTransparency = 0.5
                    }, 
                    [l_Highlight_0] = {
                        FillTransparency = 0.9, 
                        OutlineTransparency = 0.5
                    }
                };
                for v16, v17 in pairs(v15) do
                    for v18, v19 in pairs(v17) do
                        v16[v18] = 1;
                        game.TweenService:Create(v16, TweenInfo.new(0.2), {
                            [v18] = v19
                        }):Play();
                    end;
                end;
                task.delay(6, function() --[[ Line: 54 ]]
                    -- upvalues: v15 (copy)
                    for v20, v21 in pairs(v15) do
                        game.Debris:AddItem(v20, 0.2);
                        for v22, _ in pairs(v21) do
                            game.TweenService:Create(v20, TweenInfo.new(0.2), {
                                [v22] = 1
                            }):Play();
                        end;
                    end;
                end);
            end;
        end);
    end;
    local function v63() --[[ Line: 68 ]] --[[ Name: toggleRequestFunctionality ]]
        -- upvalues: v0 (ref), l_Character_0 (copy), v4 (copy), v5 (copy), l_LocalPlayer_0 (copy), v6 (copy)
        if v0.Connections then
            for _, v25 in pairs(v0.Connections) do
                v25:Disconnect();
            end;
            table.clear(v0.Connections);
        end;
        local l_Parent_0 = l_Character_0.Parent;
        if l_Character_0 and l_Parent_0 and l_Parent_0 ~= workspace.Players.Spectating then
            local function _(v27) --[[ Line: 80 ]] --[[ Name: getActorInfo ]]
                -- upvalues: v4 (ref)
                local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v27);
                local v29 = v4.CurrentActors[l_PlayerFromCharacter_0];
                if v29 and v29.Rig and v29.Config.Requests then
                    return v29;
                else
                    return;
                end;
            end;
            local v31 = nil;
            do
                local l_v31_0 = v31;
                local function v52(v33) --[[ Line: 90 ]] --[[ Name: survivorClicked ]]
                    -- upvalues: v4 (ref), l_v31_0 (ref), v5 (ref), l_LocalPlayer_0 (ref)
                    local l_PlayerFromCharacter_1 = game.Players:GetPlayerFromCharacter(v33);
                    local v35 = v4.CurrentActors[l_PlayerFromCharacter_1];
                    local v36 = if v35 and v35.Rig and v35.Config.Requests then v35 else nil;
                    if v36 and not l_v31_0 then
                        l_PlayerFromCharacter_1 = 0;
                        v35 = nil;
                        local l_pairs_0 = pairs;
                        local v38 = v36.Config.Requests or {};
                        for v39, _ in l_pairs_0(v38) do
                            l_PlayerFromCharacter_1 = l_PlayerFromCharacter_1 + 1;
                            v35 = v39;
                        end;
                        if l_PlayerFromCharacter_1 <= 1 and v35 then
                            l_pairs_0 = v5:FireServerConnection("SurvivorRequest", "REMOTE_FUNCTION", v33, v35);
                            if typeof(l_pairs_0) == "string" then
                                require(game.ReplicatedStorage.Modules.Util):CreateWarning("SurvivorRequestWarning", l_pairs_0);
                            end;
                            return;
                        else
                            l_v31_0 = script.RequestPrompt:Clone();
                            l_v31_0.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
                            l_v31_0.Background.ImageTransparency = 1;
                            game.TweenService:Create(l_v31_0.Background, TweenInfo.new(0.3), {
                                ImageTransparency = 0
                            }):Play();
                            l_pairs_0 = v36.Config.Requests or {};
                            l_pairs_0.Cancel = {
                                AbilityName = "N/A", 
                                NotificationTitle = "...", 
                                Order = 999
                            };
                            v38 = false;
                            do
                                local l_v38_0 = v38;
                                for v42, v43 in pairs(l_pairs_0) do
                                    local v44 = script.Choice:Clone();
                                    v44.Name = v42;
                                    v44.Text = v43.RequestTitle or v42:gsub("(%l)(%u)", "%1 %2");
                                    v44.LayoutOrder = tonumber(v43.Order) or 1;
                                    v44.Parent = l_v31_0.Choices;
                                    v44.TextTransparency = 1;
                                    game.TweenService:Create(v44, TweenInfo.new(0.15), {
                                        TextTransparency = 0
                                    }):Play();
                                    v44.MouseButton1Click:Connect(function() --[[ Line: 136 ]]
                                        -- upvalues: l_v38_0 (ref), l_v31_0 (ref), v44 (copy), v42 (copy), v5 (ref), v33 (copy)
                                        if not l_v38_0 then
                                            l_v38_0 = true;
                                            for _, v46 in pairs(l_v31_0.Choices:GetChildren()) do
                                                if v46:IsA("TextButton") then
                                                    game.TweenService:Create(v46, TweenInfo.new(0.15), {
                                                        TextTransparency = 1, 
                                                        Size = UDim2.new(v44.Size.X.Scale, v44.Size.X.Offset, 0, 0)
                                                    }):Play();
                                                end;
                                            end;
                                            game.TweenService:Create(l_v31_0.Background, TweenInfo.new(0.15), {
                                                ImageTransparency = 1
                                            }):Play();
                                            game.Debris:AddItem(l_v31_0, 0.15);
                                            l_v31_0 = nil;
                                            if v42 ~= "Cancel" then
                                                local v47 = v5:FireServerConnection("SurvivorRequest", "REMOTE_FUNCTION", v33, v42);
                                                if typeof(v47) == "string" then
                                                    require(game.ReplicatedStorage.Modules.Util):CreateWarning("SurvivorRequestWarning", v47);
                                                end;
                                            end;
                                        end;
                                    end);
                                end;
                                local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
                                l_v31_0.Position = UDim2.fromOffset(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y + l_v31_0.AbsoluteSize.Y / 2);
                                for _, v50 in pairs(l_v31_0.Choices:GetChildren()) do
                                    if v50:IsA("GuiObject") then
                                        local l_Size_0 = v50.Size;
                                        v50.Size = UDim2.new(v50.Size.X.Scale, v50.Size.X.Offset, 0, 0);
                                        game.TweenService:Create(v50, TweenInfo.new(0.15), {
                                            Size = l_Size_0
                                        }):Play();
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                local function v57(v53) --[[ Line: 175 ]] --[[ Name: addSurvivor ]]
                    -- upvalues: v4 (ref), v6 (ref)
                    task.delay(2, function() --[[ Line: 176 ]]
                        -- upvalues: v53 (copy), v4 (ref), v6 (ref)
                        local l_v53_0 = v53;
                        local l_PlayerFromCharacter_2 = game.Players:GetPlayerFromCharacter(l_v53_0);
                        local v56 = v4.CurrentActors[l_PlayerFromCharacter_2];
                        if if v56 and v56.Rig and v56.Config.Requests then v56 else nil then
                            v6:AddHoverableCharacter(v53);
                        end;
                    end);
                end;
                v0.Connections.SurvivorClicked = v6.Clicked:Connect(v52);
                v0.Connections.SurvivorAdded = l_Parent_0.ChildAdded:Connect(v57);
                for _, v59 in pairs(l_Parent_0:GetChildren()) do
                    task.delay(2, function() --[[ Line: 176 ]]
                        -- upvalues: v59 (copy), v4 (ref), v6 (ref)
                        local l_v59_0 = v59;
                        local l_PlayerFromCharacter_3 = game.Players:GetPlayerFromCharacter(l_v59_0);
                        local v62 = v4.CurrentActors[l_PlayerFromCharacter_3];
                        if if v62 and v62.Rig and v62.Config.Requests then v62 else nil then
                            v6:AddHoverableCharacter(v59);
                        end;
                    end);
                end;
            end;
        end;
    end;
    v63();
    l_Character_0:GetPropertyChangedSignal("Parent"):Connect(v63);
end;
return v0;