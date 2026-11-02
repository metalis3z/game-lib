-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    SidebarMenus = {}, 
    Sidebar = script.Sidebar
};
v0.__index = v0;
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
v0.CreateSidebarMenu = function(v2, v3, v4) --[[ Line: 9 ]] --[[ Name: CreateSidebarMenu ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local v6 = setmetatable({}, v0);
    v6.Menu = v4:Clone();
    v6.Menu.Visible = false;
    v6.Menu.Size = UDim2.fromScale();
    v6.Menu.Parent = l_LocalPlayer_0.PlayerGui.MainUI;
    v6.SidebarButton = v0.Sidebar.Buttons:FindFirstChild(v3);
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    l_BindableEvent_0.Parent = v6.Menu;
    v6.Toggled = l_BindableEvent_0.Event;
    v6.__toggleEvent = l_BindableEvent_0;
    for _, v9 in pairs(v6.Menu:GetDescendants()) do
        if v9:IsA("ScrollingFrame") then
            v9:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 27 ]]
                -- upvalues: v9 (copy)
                v9.ScrollBarThickness = v9.AbsoluteSize.X / 44;
            end);
        end;
    end;
    v2.SidebarMenus[v3] = v6;
    return v6;
end;
v0.ToggleMenu = function(v10, v11) --[[ Line: 40 ]] --[[ Name: ToggleMenu ]]
    -- upvalues: v0 (copy), v1 (copy)
    if v0.TogglingMenus then
        return;
    elseif v0.MenusHidden and v10.SidebarButton then
        return;
    elseif v11 and v10.Menu.Visible then
        return;
    else
        v0.TogglingMenus = true;
        v1:Play("select");
        local l_Visible_0 = v10.Menu.Visible;
        local v13 = false;
        for _, v15 in pairs(v0.SidebarMenus) do
            if v15.Menu ~= v10.Menu or l_Visible_0 then
                if v15.Menu ~= v10.Menu and v15.Menu.Visible then
                    v13 = true;
                end;
                if v15.Menu.Visible then
                    v15.__toggleEvent:Fire(false);
                    game.TweenService:Create(v15.Menu, TweenInfo.new(0.25), {
                        Size = UDim2.new(1, -20, 0, 0)
                    }):Play();
                    if v15.SidebarButton then
                        game.TweenService:Create(v15.SidebarButton.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(v15.SidebarButton.InvertedIcon, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(v15.SidebarButton.PulloutHolder.PulloutFrame.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(v15.SidebarButton.PulloutHolder.PulloutFrame.Title, TweenInfo.new(0.25), {
                            TextColor3 = Color3.new(1, 1, 1)
                        }):Play();
                    end;
                    task.delay(0.25, function() --[[ Line: 65 ]]
                        -- upvalues: v15 (copy)
                        v15.Menu.Visible = false;
                    end);
                end;
            end;
        end;
        task.delay(0.3 + (v13 and 0.125 or 0), function() --[[ Line: 70 ]]
            -- upvalues: v0 (ref)
            v0.TogglingMenus = nil;
        end);
        if v13 then
            task.wait(0.125);
            if v0.MenusHidden then
                return;
            end;
        end;
        if not l_Visible_0 then
            v10.__toggleEvent:Fire(true);
            v10.Menu.Visible = true;
            game.TweenService:Create(v10.Menu, TweenInfo.new(0.25), {
                Size = UDim2.new(1, -20, 1, -20)
            }):Play();
            if v10.SidebarButton then
                game.TweenService:Create(v10.SidebarButton.Inverted, TweenInfo.new(0.25), {
                    ImageTransparency = 0
                }):Play();
                game.TweenService:Create(v10.SidebarButton.InvertedIcon, TweenInfo.new(0.25), {
                    ImageTransparency = 0
                }):Play();
                game.TweenService:Create(v10.SidebarButton.PulloutHolder.PulloutFrame.Inverted, TweenInfo.new(0.25), {
                    ImageTransparency = 0
                }):Play();
                game.TweenService:Create(v10.SidebarButton.PulloutHolder.PulloutFrame.Title, TweenInfo.new(0.25), {
                    TextColor3 = Color3.new()
                }):Play();
            end;
        end;
        return;
    end;
end;
v0.ToggleSidebarButtons = function(_, v17) --[[ Line: 95 ]] --[[ Name: ToggleSidebarButtons ]]
    -- upvalues: v0 (copy)
    v0.MenusHidden = not v17;
    v0.Sidebar.Visible = v17;
    if not v17 then
        for _, v19 in pairs(v0.SidebarMenus) do
            game.TweenService:Create(v19.Menu, TweenInfo.new(0.25), {
                Size = UDim2.new(1, -20, 0, 0)
            }):Play();
            if v19.SidebarButton then
                game.TweenService:Create(v19.SidebarButton.Inverted, TweenInfo.new(0.25), {
                    ImageTransparency = 1
                }):Play();
                game.TweenService:Create(v19.SidebarButton.InvertedIcon, TweenInfo.new(0.25), {
                    ImageTransparency = 1
                }):Play();
                game.TweenService:Create(v19.SidebarButton.PulloutHolder.PulloutFrame.Inverted, TweenInfo.new(0.25), {
                    ImageTransparency = 1
                }):Play();
                game.TweenService:Create(v19.SidebarButton.PulloutHolder.PulloutFrame.Title, TweenInfo.new(0.25), {
                    TextColor3 = Color3.new(1, 1, 1)
                }):Play();
            end;
            task.delay(0.25, function() --[[ Line: 128 ]]
                -- upvalues: v19 (copy)
                v19.Menu.Visible = false;
            end);
        end;
    end;
end;
v0.Start = function(_) --[[ Line: 133 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), v1 (copy)
    local l_LocalPlayer_1 = game.Players.LocalPlayer;
    local _ = l_LocalPlayer_1:FindFirstChild("PlayerData");
    v0.Sidebar.Parent = l_LocalPlayer_1.PlayerGui:WaitForChild("MainUI");
    require(game.ReplicatedStorage.Modules.Util):CreateMoneyDisplay(v0.Sidebar.Money);
    for _, v24 in pairs(v0.Sidebar.Buttons:GetChildren()) do
        if v24:IsA("Frame") then
            task.spawn(function() --[[ Line: 174 ]]
                -- upvalues: v0 (ref), v24 (copy)
                local v25 = tick();
                repeat
                    task.wait();
                until v0.SidebarMenus[v24.Name] or tick() >= v25 + 10;
                local v26 = v0.SidebarMenus[v24.Name];
                if v26 then
                    v24.Button.MouseButton1Click:Connect(function() --[[ Line: 182 ]]
                        -- upvalues: v26 (copy)
                        v26:ToggleMenu();
                    end);
                end;
            end);
            local v27 = script.PulloutHolder:Clone();
            v27.Parent = v24;
            local l_PulloutFrame_0 = v27.PulloutFrame;
            l_PulloutFrame_0.Title.Text = v24.Name;
            v24.MouseEnter:Connect(function() --[[ Line: 196 ]]
                -- upvalues: v24 (copy), l_PulloutFrame_0 (copy), v1 (ref)
                if v24.Button.ImageTransparency > 0.1 then
                    return;
                else
                    game.TweenService:Create(v24, TweenInfo.new(0.2), {
                        Size = UDim2.fromScale(1.05, 0.25)
                    }):Play();
                    game.TweenService:Create(l_PulloutFrame_0, TweenInfo.new(0.2), {
                        Position = UDim2.new(0.225, l_PulloutFrame_0.Title.AbsoluteSize.X ^ 1.03, 0.5, 0)
                    }):Play();
                    v1:Play("hover");
                    return;
                end;
            end);
            v24.MouseLeave:Connect(function() --[[ Line: 203 ]]
                -- upvalues: v24 (copy), l_PulloutFrame_0 (copy), v1 (ref)
                game.TweenService:Create(v24, TweenInfo.new(0.2), {
                    Size = UDim2.fromScale(1, 0.2)
                }):Play();
                game.TweenService:Create(l_PulloutFrame_0, TweenInfo.new(0.2), {
                    Position = UDim2.fromScale(0, 0.5)
                }):Play();
                if v24.Button.ImageTransparency > 0.1 then
                    return;
                else
                    v1:Play("hoverEnd");
                    return;
                end;
            end);
        end;
    end;
end;
return v0;