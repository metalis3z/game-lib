-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local u1 = UserInputService.TouchEnabled and not UserInputService.MouseEnabled;
local u2 = nil;
local Events = script.Parent.Parent:WaitForChild("Events");
local v3 = {};
local burst = script:FindFirstChild("burst");
local u4 = Color3.fromHex("fbcf14");
local u5 = Color3.fromRGB(255, 255, 255);
local u6 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u7 = TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

local function getTooltipText(p8) -- Line: 37
    return p8 and "Remove from Favorites" or "Add to Favorites";
end;

local function setOutlineFillVisual(p9, p10, p11, p12, p13) -- Line: 42
    -- upvalues: u6 (copy), u4 (copy), u5 (copy), TweenService (copy)
    if not (p9 and p10) then
        return;
    end;

    local v14 = p13 or u6;

    if p12 then
        p9.ImageTransparency = p11 and 1 or 0;
        p10.ImageTransparency = p11 and 0 or 1;
        p10.ImageColor3 = u4;
        p9.ImageColor3 = u5;

        return;
    end;

    TweenService:Create(p9, v14, {
        ImageTransparency = p11 and 1 or 0
    }):Play();
    TweenService:Create(p10, v14, {
        ImageTransparency = p11 and 0 or 1
    }):Play();
    p10.ImageColor3 = u4;
    p9.ImageColor3 = u5;
end;

local function playBurst(u15, u16, u17, p18) -- Line: 59
    -- upvalues: TweenService (copy), u4 (copy)
    if not (u17 and (u15 and u15:IsDescendantOf(game))) then
        return;
    end;

    local u19 = p18 or u15.Size;
    local v20 = TweenService:Create(u15, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(u19.X.Scale * 0.55, 0, u19.Y.Scale * 0.55, 0)
    });
    v20:Play();
    v20.Completed:Once(function() -- Line: 67
        -- upvalues: u15 (copy), TweenService (ref), u19 (copy), u17 (copy), u4 (ref), u16 (copy)
        if not u15:IsDescendantOf(game) then
            return;
        end;

        TweenService:Create(u15, TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = u19
        }):Play();
        local u21 = u17:Clone();
        u21.ImageColor3 = u4;
        u21.ImageTransparency = 0.1;
        u21.Size = UDim2.new(0.3, 0, 0.3, 0);
        u21.Rotation = math.random(0, 360);
        u21.ZIndex = u15.ZIndex - 1;
        u21.Parent = u16;
        TweenService:Create(u21, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(1.6, 0, 1.6, 0)
        }):Play();
        task.delay(0.15, function() -- Line: 86
            -- upvalues: u21 (copy), TweenService (ref)
            if not u21:IsDescendantOf(game) then
                return;
            end;

            local v22 = TweenService:Create(u21, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1
            });
            v22:Play();
            v22.Completed:Once(function() -- Line: 92
                -- upvalues: u21 (ref)
                u21:Destroy();
            end);
        end);
    end);
end;

function v3.OutlineFill(p23) -- Line: 112
    -- upvalues: burst (copy), u6 (copy), TweenService (copy), u4 (copy), u5 (copy), Events (copy), CollectionService (copy), playBurst (copy), setOutlineFillVisual (copy)
    local Button = p23.Button;
    local outline = Button:FindFirstChild("outline");
    local fill = Button:FindFirstChild("fill");
    local StateHolder = p23.StateHolder;
    local FavoriteAction = p23.FavoriteAction;
    local u24 = p23.BurstTemplate or burst;
    local u25 = p23.TweenInfo or u6;
    local u26 = p23.DefaultScale or 0.75;
    local u27 = {};

    local function setScale(p28, p29) -- Line: 124
        -- upvalues: outline (copy), fill (copy), TweenService (ref), u25 (copy)
        local v30 = UDim2.fromScale(p28, p28);

        if p29 then
            if outline then
                outline.Size = v30;
            end;

            if fill then
                fill.Size = v30;
            end;
        else
            if outline then
                TweenService:Create(outline, u25, {
                    Size = v30
                }):Play();
            end;

            if fill then
                TweenService:Create(fill, u25, {
                    Size = v30
                }):Play();
            end;
        end;
    end;

    local v31 = StateHolder:GetAttribute("isFavorited") == true;

    if outline and fill then
        outline.ImageTransparency = v31 and 1 or 0;
        fill.ImageTransparency = v31 and 0 or 1;
        fill.ImageColor3 = u4;
        outline.ImageColor3 = u5;
    end;

    local v32 = UDim2.fromScale(u26, u26);

    if outline then
        outline.Size = v32;
    end;

    if fill then
        fill.Size = v32;
    end;

    Events.AddTooltipToObject:Fire(Button, StateHolder:GetAttribute("isFavorited") == true and "Remove from Favorites" or "Add to Favorites");
    Button:SetAttribute("noHoverSound", true);
    CollectionService:AddTag(Button, "UIEffectSoundOnly");
    table.insert(u27, Button.MouseEnter:Connect(function() -- Line: 142
        -- upvalues: setScale (copy), u26 (copy)
        setScale(u26 * 1.08);
    end));
    table.insert(u27, Button.MouseLeave:Connect(function() -- Line: 145
        -- upvalues: setScale (copy), u26 (copy)
        setScale(u26);
    end));
    table.insert(u27, Button.MouseButton1Down:Connect(function() -- Line: 148
        -- upvalues: setScale (copy), u26 (copy)
        setScale(u26 * 0.92);
    end));
    table.insert(u27, Button.Activated:Connect(function() -- Line: 152
        -- upvalues: StateHolder (copy), u24 (copy), fill (copy), playBurst (ref), Button (copy), FavoriteAction (copy)
        local v33 = StateHolder:GetAttribute("isFavorited") ~= true;
        StateHolder:SetAttribute("isFavorited", v33);

        if v33 and (u24 and fill) then
            playBurst(fill, Button, u24);
        end;

        if not FavoriteAction(v33) then
            StateHolder:SetAttribute("isFavorited", not v33);
        end;
    end));
    local v34 = StateHolder:GetAttributeChangedSignal("isFavorited");
    table.insert(u27, v34:Connect(function() -- Line: 166
        -- upvalues: StateHolder (copy), setOutlineFillVisual (ref), outline (copy), fill (copy), u25 (copy), Events (ref), Button (copy)
        local v35 = StateHolder:GetAttribute("isFavorited") == true;
        setOutlineFillVisual(outline, fill, v35, false, u25);
        Events.AddTooltipToObject:Fire(Button, v35 and "Remove from Favorites" or "Add to Favorites");
    end));
    local v37 = {
        SetFavorited = function(p36) -- Line: 174, Name: SetFavorited
            -- upvalues: StateHolder (copy)
            StateHolder:SetAttribute("isFavorited", p36);
        end,

        Destroy = function() -- Line: 178, Name: Destroy
            -- upvalues: u27 (copy)
            for _, v in u27 do
                v:Disconnect();
            end;

            table.clear(u27);
        end
    };
    Button.Destroying:Once(v37.Destroy);

    return v37;
end;

function v3.Icon(p38) -- Line: 203
    -- upvalues: burst (copy), u6 (copy), u4 (copy), u5 (copy), TweenService (copy), Events (copy), CollectionService (copy), playBurst (copy)
    local Container = p38.Container;
    local u39 = p38.Icon or Container:FindFirstChild("icon");
    local u40;

    if u39 then
        u40 = u39:FindFirstChild("outline");
    else
        u40 = u39;
    end;

    local StateHolder = p38.StateHolder;
    local FavoriteAction = p38.FavoriteAction;
    local u41 = p38.BurstTemplate or burst;
    local u42 = p38.TweenInfo or u6;
    local u43 = u39 and u39.Size or UDim2.fromScale(0.8, 0.8);
    local u44 = p38.HoverMultiplier or 1.06;
    local u45 = {};

    local function setVisual(p46, p47) -- Line: 215
        -- upvalues: u39 (copy), u40 (copy), u42 (copy), u4 (ref), u5 (ref), TweenService (ref)
        if not u39 then
            return;
        end;

        if not u40 then
            local v48;

            if p46 then
                v48 = u4;
            else
                v48 = u5;
            end;

            if not p47 then
                TweenService:Create(u39, u42, {
                    ImageColor3 = v48
                }):Play();

                return;
            end;

            u39.ImageColor3 = v48;
            u39.ImageTransparency = 0;

            return;
        end;

        local v49 = u42;

        if p47 then
            u39.ImageTransparency = p46 and 0 or 1;
            u39.ImageColor3 = u4;
            u40.ImageTransparency = p46 and 1 or 0;
            u40.ImageColor3 = u5;

            return;
        end;

        TweenService:Create(u39, v49, {
            ImageTransparency = p46 and 0 or 1
        }):Play();
        u39.ImageColor3 = u4;
        TweenService:Create(u40, v49, {
            ImageTransparency = p46 and 1 or 0
        }):Play();
        u40.ImageColor3 = u5;
    end;

    local v50 = StateHolder:GetAttribute("isFavorited") == true;

    if u39 then
        if u40 then
            u39.ImageTransparency = v50 and 0 or 1;
            u39.ImageColor3 = u4;
            u40.ImageTransparency = v50 and 1 or 0;
            u40.ImageColor3 = u5;
        else
            local v51;

            if v50 then
                v51 = u4;
            else
                v51 = u5;
            end;

            u39.ImageColor3 = v51;
            u39.ImageTransparency = 0;
        end;
    end;

    Events.AddTooltipToObject:Fire(u39, StateHolder:GetAttribute("isFavorited") == true and "Remove from Favorites" or "Add to Favorites");
    Container:SetAttribute("noHoverSound", true);
    CollectionService:AddTag(Container, "UIEffectSoundOnly");
    table.insert(u45, Container.MouseEnter:Connect(function() -- Line: 249
        -- upvalues: u39 (copy), TweenService (ref), u42 (copy), u43 (copy), u44 (copy)
        if u39 then
            TweenService:Create(u39, u42, {
                Size = UDim2.new(u43.X.Scale * u44, 0, u43.Y.Scale * u44, 0)
            }):Play();
        end;
    end));
    table.insert(u45, Container.MouseLeave:Connect(function() -- Line: 255
        -- upvalues: u39 (copy), TweenService (ref), u42 (copy), u43 (copy)
        if u39 then
            TweenService:Create(u39, u42, {
                Size = u43
            }):Play();
        end;
    end));
    table.insert(u45, Container.Activated:Connect(function() -- Line: 261
        -- upvalues: StateHolder (copy), Events (ref), u39 (copy), u41 (copy), playBurst (ref), FavoriteAction (copy)
        local v52 = StateHolder:GetAttribute("isFavorited") ~= true;
        Events.AddTooltipToObject:Fire(u39, v52 and "Remove from Favorites" or "Add to Favorites");

        if v52 and u41 then
            playBurst(u39, u39, u41);
        end;

        if FavoriteAction(v52) then
            StateHolder:SetAttribute("isFavorited", v52);
        end;
    end));
    local v53 = StateHolder:GetAttributeChangedSignal("isFavorited");
    table.insert(u45, v53:Connect(function() -- Line: 276
        -- upvalues: StateHolder (copy), setVisual (copy), Events (ref), u39 (copy)
        local v54 = StateHolder:GetAttribute("isFavorited") == true;
        setVisual(v54);
        Events.AddTooltipToObject:Fire(u39, v54 and "Remove from Favorites" or "Add to Favorites");
    end));
    local v56 = {
        SetFavorited = function(p55) -- Line: 284, Name: SetFavorited
            -- upvalues: StateHolder (copy)
            StateHolder:SetAttribute("isFavorited", p55);
        end,

        Destroy = function() -- Line: 288, Name: Destroy
            -- upvalues: u45 (copy)
            for _, v in u45 do
                v:Disconnect();
            end;

            table.clear(u45);
        end
    };
    Container.Destroying:Once(v56.Destroy);

    return v56;
end;

function v3.Dynamic(p57) -- Line: 316
    -- upvalues: burst (copy), u6 (copy), u4 (copy), u5 (copy), u1 (copy), u2 (ref), Events (copy), CollectionService (copy), TweenService (copy), u7 (copy), playBurst (copy)
    local Template = p57.Template;
    local Parent = p57.Parent;
    local StateHolder = p57.StateHolder;
    local FavoriteAction = p57.FavoriteAction;
    local u58 = p57.BurstTemplate or burst;
    local u59 = p57.TweenInfo or u6;
    local SizeFactor = p57.SizeFactor;
    local u60 = p57.DefaultScale or 0.75;
    local u61 = nil;
    local u62 = {};
    local u63 = false;
    local u64 = nil;

    local function clearButton() -- Line: 331
        -- upvalues: u62 (copy), u61 (ref)
        for _, v in u62 do
            v:Disconnect();
        end;

        table.clear(u62);

        if u61 then
            u61:Destroy();
            u61 = nil;
        end;
    end;

    local function applyVisual(p65, p66, p67) -- Line: 344
        -- upvalues: u60 (copy), u4 (ref), u5 (ref)
        local outline = p65:FindFirstChild("outline");
        local fill = p65:FindFirstChild("fill");
        local v68 = UDim2.fromScale(u60, u60);

        if p66 then
            p65.BackgroundTransparency = 0.4;

            if fill then
                fill.ImageColor3 = u4;
                fill.ImageTransparency = 0;
                fill.Size = v68;
            end;

            if outline then
                outline.ImageTransparency = 1;
                outline.Size = v68;
            end;
        else
            p65.BackgroundTransparency = p67 and 0.4 or 1;

            if outline then
                outline.ImageColor3 = u5;
                outline.ImageTransparency = p67 and 0 or 1;
                outline.Size = v68;
            end;

            if fill then
                fill.ImageTransparency = 1;
                fill.Size = v68;
            end;
        end;
    end;

    local function addButton(p69, p70, p71) -- Line: 373
        -- upvalues: StateHolder (copy), u1 (ref), u2 (ref), u64 (ref), u61 (ref), applyVisual (copy), u62 (copy), Template (copy), SizeFactor (copy), Events (ref), CollectionService (ref), TweenService (ref), u59 (copy), u60 (copy), u63 (ref), u7 (ref), u4 (ref), u58 (copy), playBurst (ref), FavoriteAction (copy), Parent (copy)
        if p69 == nil then
            p69 = StateHolder:GetAttribute("isFavorited") == true;
        end;

        local v72 = StateHolder:GetAttribute("isHovered") == true and true or u1 or p70;

        if u1 and (p71 and (u2 and u2 ~= u64)) then
            u2(true);
        end;

        if u61 then
            applyVisual(u61, p69, v72);

            if u1 and (p71 and not p69) then
                u2 = u64;
            end;

            return;
        end;

        for _, v in u62 do
            v:Disconnect();
        end;

        table.clear(u62);

        if u61 then
            u61:Destroy();
            u61 = nil;
        end;

        local u73 = Template:Clone();

        if SizeFactor then
            local Size = u73.Size;
            u73.Size = UDim2.new(Size.X.Scale * SizeFactor, Size.X.Offset * SizeFactor, Size.Y.Scale * SizeFactor, Size.Y.Offset * SizeFactor);
        end;

        u61 = u73;
        local outline = u73:FindFirstChild("outline");
        local fill = u73:FindFirstChild("fill");
        applyVisual(u73, p69, v72);
        Events.AddTooltipToObject:Fire(u73, p69 and "Remove from Favorites" or "Add to Favorites");
        u73:SetAttribute("noHoverSound", true);
        CollectionService:AddTag(u73, "UIEffectSoundOnly");

        local function setIconScale(p74) -- Line: 423
            -- upvalues: outline (copy), TweenService (ref), u59 (ref), fill (copy)
            local v75 = UDim2.fromScale(p74, p74);

            if outline then
                TweenService:Create(outline, u59, {
                    Size = v75
                }):Play();
            end;

            if fill then
                TweenService:Create(fill, u59, {
                    Size = v75
                }):Play();
            end;
        end;

        table.insert(u62, u73.MouseEnter:Connect(function() -- Line: 429
            -- upvalues: setIconScale (copy), u60 (ref)
            setIconScale(u60 * 1.08);
        end));
        table.insert(u62, u73.MouseLeave:Connect(function() -- Line: 432
            -- upvalues: setIconScale (copy), u60 (ref)
            setIconScale(u60);
        end));
        table.insert(u62, u73.MouseButton1Down:Connect(function() -- Line: 435
            -- upvalues: setIconScale (copy), u60 (ref)
            setIconScale(u60 * 0.92);
        end));
        table.insert(u62, u73.Activated:Connect(function() -- Line: 439
            -- upvalues: StateHolder (ref), u63 (ref), Events (ref), u73 (copy), outline (copy), TweenService (ref), u59 (ref), u7 (ref), fill (copy), u4 (ref), u58 (ref), u60 (ref), playBurst (ref), FavoriteAction (ref), u61 (ref), u1 (ref), u64 (ref)
            local v76 = StateHolder:GetAttribute("isFavorited") ~= true;
            u63 = true;
            StateHolder:SetAttribute("isFavorited", v76);
            Events.AddTooltipToObject:Fire(u73, v76 and "Remove from Favorites" or "Add to Favorites");

            if outline then
                local v77;

                if v76 then
                    v77 = u59;
                else
                    v77 = u7;
                end;

                TweenService:Create(outline, v77, {
                    ImageTransparency = v76 and 1 or 0
                }):Play();
            end;

            if fill then
                fill.ImageColor3 = u4;
                local v78;

                if v76 then
                    v78 = u59;
                else
                    v78 = u7;
                end;

                TweenService:Create(fill, v78, {
                    ImageTransparency = v76 and 0 or 1
                }):Play();
            end;

            if v76 and (u58 and fill) then
                local v79 = UDim2.fromScale(u60 * 1.08, u60 * 1.08);
                fill.Size = v79;

                if outline then
                    outline.Size = v79;
                end;

                playBurst(fill, u73, u58, v79);
            end;

            if not FavoriteAction(v76) then
                StateHolder:SetAttribute("isFavorited", not v76);

                if outline and outline:IsDescendantOf(game) then
                    TweenService:Create(outline, u59, {
                        ImageTransparency = v76 and 0 or 1
                    }):Play();
                end;

                if fill and fill:IsDescendantOf(game) then
                    TweenService:Create(fill, u59, {
                        ImageTransparency = v76 and 1 or 0
                    }):Play();
                end;
            end;

            task.delay(0.7, function() -- Line: 475
                -- upvalues: u63 (ref), u61 (ref), StateHolder (ref), u1 (ref), u64 (ref)
                u63 = false;

                if u61 and (StateHolder:GetAttribute("isFavorited") ~= true and (StateHolder:GetAttribute("isHovered") ~= true and not u1)) then
                    u64();
                end;
            end);
        end));
        u73.Parent = Parent;

        if u1 and (p71 and not p69) then
            u2 = u64;
        end;
    end;

    u64 = function(p80) -- Line: 494
        -- upvalues: u1 (ref), u61 (ref), u2 (ref), u64 (ref), TweenService (ref), u59 (copy)
        if u1 and not p80 then
            return;
        end;

        if not u61 then
            return;
        end;

        local u81 = u61;
        u61 = nil;

        if u2 == u64 then
            u2 = nil;
        end;

        local outline = u81:FindFirstChild("outline");
        local fill = u81:FindFirstChild("fill");

        if outline then
            TweenService:Create(outline, u59, {
                ImageTransparency = 1
            }):Play();
        end;

        if fill then
            TweenService:Create(fill, u59, {
                ImageTransparency = 1
            }):Play();
        end;

        local v82 = TweenService:Create(u81, u59, {
            BackgroundTransparency = 1
        });
        v82:Play();
        v82.Completed:Connect(function() -- Line: 510
            -- upvalues: u81 (copy)
            if u81 then
                u81:Destroy();
            end;
        end);
    end;

    local v90 = {
        Add = function(p83, p84, p85) -- Line: 516, Name: Add
            -- upvalues: u63 (ref), u61 (ref), TweenService (ref), u59 (copy), u7 (ref), u4 (ref), addButton (copy)
            if not (u63 and u61) then
                addButton(p83, p84, p85);

                return;
            end;

            local outline = u61:FindFirstChild("outline");
            local fill = u61:FindFirstChild("fill");

            if outline then
                local v86;

                if p83 then
                    v86 = u59;
                else
                    v86 = u7;
                end;

                TweenService:Create(outline, v86, {
                    ImageTransparency = p83 and 1 or 0
                }):Play();
            end;

            if fill then
                fill.ImageColor3 = u4;
                local v87;

                if p83 then
                    v87 = u59;
                else
                    v87 = u7;
                end;

                TweenService:Create(fill, v87, {
                    ImageTransparency = p83 and 0 or 1
                }):Play();
            end;
        end,

        Remove = function(p88) -- Line: 532, Name: Remove
            -- upvalues: u64 (ref)
            u64(p88);
        end,

        SetFavorited = function(p89) -- Line: 536, Name: SetFavorited
            -- upvalues: StateHolder (copy)
            StateHolder:SetAttribute("isFavorited", p89);
        end,

        IsShowing = function() -- Line: 540, Name: IsShowing
            -- upvalues: u61 (ref)
            return u61 ~= nil;
        end,

        Destroy = function() -- Line: 544, Name: Destroy
            -- upvalues: u2 (ref), u64 (ref), u62 (copy), u61 (ref)
            if u2 == u64 then
                u2 = nil;
            end;

            for _, v in u62 do
                v:Disconnect();
            end;

            table.clear(u62);

            if u61 then
                u61:Destroy();
                u61 = nil;
            end;
        end
    };
    Parent.Destroying:Once(v90.Destroy);

    return v90;
end;

function v3.DismissActiveTouchSticky() -- Line: 556
    -- upvalues: u2 (ref)
    if u2 then
        u2(true);
    end;
end;

return v3;