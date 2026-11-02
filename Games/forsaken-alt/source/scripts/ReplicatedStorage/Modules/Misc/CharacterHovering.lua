-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    HighlightTweenTime = 0.125, 
    HoverRange = 30, 
    HoverData = {}, 
    HoverableCharacters = {}, 
    Connections = {}, 
    HoveredCharacter = nil, 
    Hovered = nil, 
    HoverEnded = nil, 
    Clicked = nil
};
v0.AddHoverableCharacter = function(_, v2) --[[ Line: 18 ]] --[[ Name: AddHoverableCharacter ]]
    -- upvalues: v0 (copy)
    if game.Players.LocalPlayer.Character ~= v2 then
        v0.HoverableCharacters[v2] = true;
    end;
end;
v0.ToggleHoverHighlight = function(_, v4, v5, v6) --[[ Line: 24 ]] --[[ Name: ToggleHoverHighlight ]]
    -- upvalues: v0 (copy)
    if not v0.HoverData[v4] then
        v0.HoverData[v4] = {
            Hovers = {}, 
            Highlight = nil
        };
    end;
    v0.HoverData[v4].Hovers[v5] = v6 or nil;
    local v7 = 0;
    for _, v9 in pairs(v0.HoverData[v4].Hovers) do
        if v9 then
            v7 = v7 + 1;
        end;
    end;
    if v7 > 0 and not v0.HoverData[v4].Highlight then
        local l_Highlight_0 = Instance.new("Highlight");
        l_Highlight_0.Name = "CharacterHoverHighlight";
        l_Highlight_0.OutlineTransparency = 1;
        l_Highlight_0.FillTransparency = 1;
        l_Highlight_0.FillColor = Color3.new(1, 1, 1);
        l_Highlight_0.Parent = v4;
        l_Highlight_0.Adornee = v4;
        game.TweenService:Create(l_Highlight_0, TweenInfo.new(v0.HighlightTweenTime), {
            OutlineTransparency = 0.5, 
            FillTransparency = 0.9
        }):Play();
        v0.HoverData[v4].Highlight = l_Highlight_0;
        v0.__hoveredEvent:Fire(v4);
        return;
    else
        if v7 <= 0 and v0.HoverData[v4].Highlight then
            local l_Highlight_1 = v0.HoverData[v4].Highlight;
            l_Highlight_1.Name = "Disappearing";
            game.TweenService:Create(l_Highlight_1, TweenInfo.new(v0.HighlightTweenTime), {
                FillTransparency = 1, 
                OutlineTransparency = 1
            }):Play();
            game.Debris:AddItem(l_Highlight_1, v0.HighlightTweenTime);
            v0.HoverData[v4] = nil;
            v0.__hoverEndedEvent:Fire(v4);
        end;
        return;
    end;
end;
v0.Init = function(_) --[[ Line: 75 ]] --[[ Name: Init ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsServer() then
        return;
    else
        local v13 = {
            Hovered = "__hovered", 
            HoverEnded = "__hoverEnded", 
            Clicked = "__clicked"
        };
        for v14, v15 in pairs(v13) do
            local v16 = v15 .. "Event";
            v0[v16] = Instance.new("BindableEvent");
            v0[v16].Name = v15;
            v0[v16].Parent = script;
            v0[v14] = v0[v16].Event;
        end;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 96 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsServer() then
        return;
    else
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
        local v20 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
        local l_Parent_0 = v20.Parent;
        local v22 = v20 and v20.PrimaryPart or v20:WaitForChild("HumanoidRootPart", 5);
        l_LocalPlayer_0.CharacterAdded:Connect(function(v23) --[[ Line: 109 ]]
            -- upvalues: v20 (ref), l_Parent_0 (ref), v22 (ref), v0 (ref)
            v20 = v23;
            l_Parent_0 = v23.Parent;
            v22 = v20 and v20.PrimaryPart or v20:WaitForChild("HumanoidRootPart", 5);
            for _, v25 in pairs(v0.HoverData) do
                if v25.Highlight then
                    v25.Highlight:Destroy();
                end;
            end;
            v0.HoverData = {};
            v0.HoverableCharacters = {};
        end);
        v0.Connections.ClickConnection = game.UserInputService.InputBegan:Connect(function(v26, v27) --[[ Line: 123 ]]
            -- upvalues: v0 (ref)
            if v27 then
                return;
            else
                local v28 = {
                    [Enum.UserInputType.MouseButton1] = true, 
                    [Enum.UserInputType.Touch] = true, 
                    [Enum.KeyCode.ButtonA] = true
                };
                if (v28[v26.UserInputType] or v28[v26.KeyCode]) and v0.HoveredCharacter then
                    v0.__clickedEvent:Fire(v0.HoveredCharacter);
                end;
                return;
            end;
        end);
        v0.Connections.HoverConnection = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 138 ]]
            -- upvalues: l_l_LocalPlayer_0_Mouse_0 (copy), v0 (ref), v22 (ref)
            local l_Target_0 = l_l_LocalPlayer_0_Mouse_0.Target;
            local v30 = l_Target_0 and l_Target_0.Parent;
            if v30 ~= v0.HoveredCharacter then
                if v0.HoveredCharacter then
                    v0:ToggleHoverHighlight(v0.HoveredCharacter, "DefaultHover", false);
                    v0.HoveredCharacter = nil;
                end;
                local l_Magnitude_0 = (l_l_LocalPlayer_0_Mouse_0.Hit.Position - v22.Position).Magnitude;
                if v0.HoveredCharacter ~= v30 and v0.HoverableCharacters[v30] and l_Magnitude_0 <= v0.HoverRange then
                    v0:ToggleHoverHighlight(v30, "DefaultHover", true);
                    v0.HoveredCharacter = v30;
                end;
            end;
        end);
        return;
    end;
end;
return v0;