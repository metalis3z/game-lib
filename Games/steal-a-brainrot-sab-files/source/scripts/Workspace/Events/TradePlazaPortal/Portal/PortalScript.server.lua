


if script:IsDescendantOf(workspace) then
    local l__RunService__1 = game:GetService("RunService");
    local l__TweenService__2 = game:GetService("TweenService");
    local l__Players__3 = game:GetService("Players");
    local l__Portal__4 = script.Parent:WaitForChild("Portal");
    local l__PlayerGui__5 = l__Players__3.LocalPlayer.PlayerGui;
    local l__PortalGui__6 = script.PortalGui;
    l__PortalGui__6.Parent = l__PlayerGui__5;
    l__PortalGui__6.Adornee = l__Portal__4;
    local l__Portal__7 = l__PortalGui__6:WaitForChild("Portal");
    local u1 = l__PortalGui__6:Clone();
    u1.Name = "PortalGuiBack";
    u1.Face = Enum.NormalId.Back;
    u1.Adornee = l__Portal__4;
    u1.Parent = l__PlayerGui__5;
    local l__Portal__8 = u1:WaitForChild("Portal");
    local l__ViewportFrame__9 = l__Portal__7:WaitForChild("ViewportFrame");
    local l__ViewportFrame__10 = l__Portal__8:WaitForChild("ViewportFrame");
    local l__DepthLines__11 = l__Portal__7:WaitForChild("DepthLines");
    local l__TradeIcon__12 = l__ViewportFrame__9.WorldModel.TradeIcon;
    local l__TradeIcon__13 = l__ViewportFrame__10.WorldModel.TradeIcon;
    local l__CFrame__14 = l__TradeIcon__12.CFrame;
    local u2 = l__TradeIcon__13.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
    local u3 = false;
    local u4 = false;
    local u5 = {};
    local u6 = {};
    local function u9(p7, p8)
        if p7:IsA("GuiObject") and not p7:IsA("ViewportFrame") then
            p8[p7] = {
                position = p7.Position,
                depth = p7:GetAttribute("ParallaxDepth") or 0
            };
        end;
    end;
    local function u15(p10, p11)
        for v12, v13 in p10 do
            local v14 = UDim2.fromScale(p11.X * v13.depth, p11.Y * v13.depth);
            v12.Position = v13.position + v14;
        end;
    end;
    local function u20(p16, u17)
        local u18 = l__DepthLines__11:Clone();
        u18.Visible = true;
        u18:SetAttribute("ParallaxDepth", l__DepthLines__11:GetAttribute("ParallaxDepth") or 0);
        u18.Parent = p16;
        u9(u18, u17);
        local v19 = l__TweenService__2:Create(u18, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            ImageTransparency = 1,
            Size = UDim2.fromScale(0, 0)
        });
        v19:Play();
        v19.Completed:Connect(function()
            u17[u18] = nil;
            u18:Destroy();
        end);
    end;
    local function u23()
        u3 = false;
        for _, v21 in { l__Portal__7, l__Portal__8 } do
            for _, v22 in v21:GetChildren() do
                if v22.Name == "DepthLines" and v22 ~= l__DepthLines__11 then
                    v22:Destroy();
                end;
            end;
        end;
    end;
    local function u32()
        local l__CurrentCamera__15 = workspace.CurrentCamera;
        local v24 = l__Portal__4.CFrame.LookVector:Dot(l__CurrentCamera__15.CFrame.Position - l__Portal__4.Position) > 0;
        l__PortalGui__6.Enabled = v24;
        u1.Enabled = not v24;
        if (l__CurrentCamera__15.CFrame.Position - l__Portal__4.Position).Magnitude >= 200 then
            if u4 == false then
            else
                u4 = false;
                u23();
            end;
        else
            if u4 ~= true then
                u4 = true;
                if not u3 then
                    u3 = true;
                    task.spawn(function()
                        while u3 do
                            u20(l__Portal__7, u5);
                            u20(l__Portal__8, u6);
                            task.wait(0.4);
                        end;
                    end);
                end;
            end;
            local v25 = l__Portal__4.Size.Y / l__Portal__4.Size.X;
            local v26 = l__Portal__4.CFrame:VectorToObjectSpace((l__Portal__4.Position - l__CurrentCamera__15.CFrame.Position).Unit);
            local v27 = Vector3.new(v26.X, v26.Y / v25, 0);
            u15(u5, v27);
            u15(u6, v27);
            local v28 = os.clock() * 90;
            local v29 = os.clock() * 1;
            local v30 = math.sin(v29) * 1;
            local v31 = Vector3.new(0, v30, 0);
            l__TradeIcon__12.CFrame = l__CFrame__14 * CFrame.Angles(0, math.rad(v28), 0) + v31;
            l__TradeIcon__13.CFrame = u2 * CFrame.Angles(0, math.rad(v28), 0) + v31;
        end;
    end;
    (function()
        l__Portal__7.ChildAdded:Connect(function(p33)
            if p33.Name == "DepthLines" then
            else
                u9(p33, u5);
            end;
        end);
        l__Portal__8.ChildAdded:Connect(function(p34)
            if p34.Name == "DepthLines" then
            else
                u9(p34, u6);
            end;
        end);
        for _, v35 in l__Portal__7:GetChildren() do
            u9(v35, u5);
        end;
        for _, v36 in l__Portal__8:GetChildren() do
            u9(v36, u6);
        end;
        l__RunService__1.RenderStepped:Connect(u32);
    end)();
end;