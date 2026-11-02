-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreateTab = function(v0, v1) --[[ Line: 3 ]] --[[ Name: CreateTab ]]
        local l_Parent_0 = script.Parent.Parent;
        local l_CardTemplate_0 = l_Parent_0.Templates.CardTemplate;
        local l_SideContainer_0 = v1.ShopRoot.SideContainer;
        local v5 = {};
        local l_Emotes_0 = game.ReplicatedStorage.Assets.Emotes;
        require(l_Parent_0).ShopMenu.Toggled:Connect(function() --[[ Line: 13 ]]
            -- upvalues: v0 (copy)
            if v0.SFX then
                game.TweenService:Create(v0.SFX, TweenInfo.new(0.1), {
                    Volume = 0
                }):Play();
                game.Debris:AddItem(v0.SFX, 0.1);
                v0.SFX = nil;
            end;
        end);
        game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 18 ]]
            -- upvalues: v0 (copy)
            if v0.SFX then
                game.TweenService:Create(v0.SFX, TweenInfo.new(0.1), {
                    Volume = 0
                }):Play();
                game.Debris:AddItem(v0.SFX, 0.1);
                v0.SFX = nil;
            end;
        end);
        local v7 = script.EmoteViewport:Clone();
        local l_Camera_0 = Instance.new("Camera");
        l_Camera_0.FieldOfView = 25;
        l_Camera_0.CFrame = v7.WorldModel.Rig.Head.CFrame * CFrame.Angles(0, 3.490658503988659, 0) * CFrame.new(0, 0, 15) * CFrame.Angles(-0.12217304763960307, 0, 0);
        l_Camera_0.Parent = v7;
        v7.CurrentCamera = l_Camera_0;
        v0.ViewportFrame = v7;
        for _, v10 in pairs(l_Emotes_0:GetChildren()) do
            local v11 = require(v10);
            if not v11.Exclusive then
                local v12 = l_CardTemplate_0:Clone();
                local l_Container_0 = v12.Container;
                v12.Name = v10.Name;
                v12.LayoutOrder = v11.Price or 1000;
                l_Container_0.CharacterRender.Image = v11.RenderImage or "rbxassetid://13373279056";
                l_Container_0.Title.Text = tostring(v11.DisplayName);
                l_Container_0.Price.Text = (not v11.Price or v11.Price <= 0) and "FREE" or ("%*$"):format((tostring(v11.Price)));
                l_Container_0.MouseEnter:Connect(function() --[[ Line: 42 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1.05, 1.05)
                    }):Play();
                end);
                l_Container_0.MouseLeave:Connect(function() --[[ Line: 46 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1, 1)
                    }):Play();
                end);
                l_Container_0.Interact.MouseButton1Click:Connect(function() --[[ Line: 50 ]]
                    -- upvalues: v0 (copy), v10 (copy), l_SideContainer_0 (copy), v11 (copy), l_Container_0 (copy), v7 (copy)
                    v0.Shop.CurrentlySelected = v10;
                    if v0.CurrentlyLoadedAnim then
                        v0.CurrentlyLoadedAnim:Stop(0);
                        v0.CurrentlyLoadedAnim = nil;
                    end;
                    l_SideContainer_0.PreviewContainer.Render.Image = "";
                    l_SideContainer_0.PreviewContainer.Title.Text = tostring(v11.DisplayName);
                    l_SideContainer_0.PreviewContainer.Quote.Text = tostring(v11.Description);
                    l_SideContainer_0.PreviewContainer.Credits.Text = tostring(v11.Credits);
                    l_SideContainer_0.PurchaseContainer.Price.Text = l_Container_0.Price.Text;
                    l_SideContainer_0.PurchaseContainer.Buttons.Visible = false;
                    l_SideContainer_0.Visible = true;
                    game.TweenService:Create(l_SideContainer_0, TweenInfo.new(0.4), {
                        Size = UDim2.fromScale(0.3, 1)
                    }):Play();
                    if v0.SFX then
                        game.TweenService:Create(v0.SFX, TweenInfo.new(0.1), {
                            Volume = 0
                        }):Play();
                        game.Debris:AddItem(v0.SFX, 0.1);
                        v0.SFX = nil;
                    end;
                    if v0.CurrentAnimInfo and v0.CurrentAnimInfo.DestroyedServer then
                        v0.CurrentAnimInfo.DestroyedServer(v0.CurrentEmoteData);
                    end;
                    if v0.CurrentAnimInfo and v0.CurrentAnimInfo.DestroyedClient then
                        v0.CurrentAnimInfo.DestroyedClient(v0.CurrentEmoteData);
                    end;
                    v0.CurrentAnimInfo = v11;
                    local l_AssetID_0 = v11.AssetID;
                    if typeof(l_AssetID_0) == "table" then
                        if v11.isDuoAnim then
                            l_AssetID_0 = l_AssetID_0[1];
                        else
                            local v15 = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Name;
                            local v16 = v15 and game.ReplicatedStorage.Assets.Survivors:FindFirstChild(v15);
                            local v17 = v16 and v16:FindFirstChild("Config") and require(v16.Config).Class;
                            l_AssetID_0 = if v17 and v11.AssetID[v17] then v11.AssetID[v17] else if v11.AssetID.Survivalist then v11.AssetID.Survivalist else l_AssetID_0[math.random(#l_AssetID_0)];
                        end;
                    end;
                    local v18 = require(game.ReplicatedStorage.Modules.Util):LoadAnimationFromID(v7.WorldModel.Rig, l_AssetID_0);
                    if v18 then
                        local v19 = require(game.ReplicatedStorage.Modules.Sounds);
                        local v20 = v11.SFXProperties or {};
                        v20.SoundGroup = game.SoundService.Soundtrack;
                        v0.SFX = v19:Play(v11.SFX, v20);
                        task.spawn(function() --[[ Line: 107 ]]
                            -- upvalues: v0 (ref)
                            repeat
                                task.wait();
                            until not v0.SFX or not v0.SFX.Parent or v0.SFX.TimeLength > 0;
                            if v0.SFX and v0.SFX.Parent then
                                v0.SFX.PlaybackRegionsEnabled = true;
                                v0.SFX.LoopRegion = NumberRange.new(0, (math.clamp(v0.SFX.TimeLength - 0.05, 0.1, 60000)));
                            end;
                        end);
                        if v18.Looped and v0.SFX and not v0.SFX.Looped then
                            v18.DidLoop:Connect(function() --[[ Line: 117 ]]
                                -- upvalues: v0 (ref), v19 (copy), v11 (ref), v20 (copy)
                                if v0.SFX then
                                    game.TweenService:Create(v0.SFX, TweenInfo.new(0.1), {
                                        Volume = 0
                                    }):Play();
                                    game.Debris:AddItem(v0.SFX, 0.1);
                                    v0.SFX = v19:Play(v11.SFX, v20);
                                end;
                            end);
                        end;
                        v18:Play(0);
                        v18.Priority = Enum.AnimationPriority.Action;
                        v0.CurrentlyLoadedAnim = v18;
                    end;
                    v0.CurrentEmoteData = {
                        Player = game.Players.LocalPlayer, 
                        Character = v7.WorldModel.Rig, 
                        Emote = v18
                    };
                    if v0.CurrentAnimInfo and v0.CurrentAnimInfo.CreatedServer then
                        v0.CurrentAnimInfo.CreatedServer(v0.CurrentEmoteData);
                    end;
                    if v0.CurrentAnimInfo and v0.CurrentAnimInfo.CreatedClient then
                        v0.CurrentAnimInfo.CreatedClient(v0.CurrentEmoteData);
                    end;
                end);
                table.insert(v5, v12);
            end;
        end;
        return v5;
    end, 
    Selected = function(v21, v22) --[[ Line: 150 ]] --[[ Name: Selected ]]
        local l_SideContainer_1 = v22.ShopRoot.SideContainer;
        v21.ViewportFrame.Parent = l_SideContainer_1.PreviewContainer;
        task.spawn(function() --[[ Line: 154 ]]
            -- upvalues: v21 (copy)
            local v24 = require(game.ReplicatedStorage.Modules.Util):LoadAnimationFromID(v21.ViewportFrame.WorldModel.Rig, "rbxassetid://180435571");
            v24.Looped = true;
            v24:Play(0);
            v21.IdleAnim = v24;
        end);
    end, 
    Deselected = function(v25, _) --[[ Line: 163 ]] --[[ Name: Deselected ]]
        if v25.CurrentlyLoadedAnim then
            v25.CurrentlyLoadedAnim:Stop(0);
            v25.CurrentlyLoadedAnim = nil;
        end;
        if v25.IdleAnim then
            v25.IdleAnim:Stop(0);
            v25.IdleAnim = nil;
        end;
        if v25.CurrentAnimInfo and v25.CurrentAnimInfo.Destroyed then
            v25.CurrentAnimInfo.Destroyed(v25.CurrentEmoteData);
        end;
        if v25.SFX then
            game.TweenService:Create(v25.SFX, TweenInfo.new(0.1), {
                Volume = 0
            }):Play();
            game.Debris:AddItem(v25.SFX, 0.1);
            v25.SFX = nil;
        end;
        v25.ViewportFrame.Parent = nil;
    end
};