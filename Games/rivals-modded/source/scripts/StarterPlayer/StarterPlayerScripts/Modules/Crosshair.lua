-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Crosshair = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Crosshair");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 15
    -- upvalues: u1 (copy), Crosshair (copy)
    local v2 = setmetatable({}, u1);
    v2.Type = nil;
    v2.Info = nil;
    v2.Appearance = nil;
    v2.Frame = Crosshair:Clone();
    v2._destroyed = false;
    v2._visible = true;
    v2._spacing = 16;
    v2._spacing_multiplier = 1;
    v2._transparency = 0;
    v2._update_queued = false;
    v2._hitmarker_color = nil;
    v2._hitmarker_color_crit = nil;
    v2._last_hitmarker_crit_set = false;
    v2:_Init();

    return v2;
end;

function u1.GetDisplayAppearance(p3) -- Line: 42
    if p3.Info.IsSpecial and not (p3.Appearance and p3.Appearance.Override) then
        return nil;
    end;

    return p3.Appearance;
end;

function u1.IsStatic(p4) -- Line: 46
    local DisplayAppearance = p4:GetDisplayAppearance();

    if DisplayAppearance then
        return DisplayAppearance.IsStatic;
    end;

    return false;
end;

function u1.IsScopedRedDotDisabled(p5) -- Line: 52
    local DisplayAppearance = p5:GetDisplayAppearance();

    if DisplayAppearance then
        return DisplayAppearance.ScopedRedDotDisabled;
    end;

    return false;
end;

function u1.IsScopedBarsDisabled(p6) -- Line: 58
    local DisplayAppearance = p6:GetDisplayAppearance();

    if DisplayAppearance then
        return DisplayAppearance.ScopedBarsDisabled;
    end;

    return false;
end;

function u1.GetScopedRedDotColor(p7) -- Line: 64
    local DisplayAppearance = p7:GetDisplayAppearance();

    if DisplayAppearance then
        DisplayAppearance = DisplayAppearance.ScopedRedDotColor;
    end;

    return DisplayAppearance;
end;

function u1.ShowWhileAiming(p8) -- Line: 70
    local DisplayAppearance = p8:GetDisplayAppearance();

    if DisplayAppearance then
        return DisplayAppearance.ShowWhileAiming;
    end;

    return false;
end;

function u1.ShowWhileInspecting(p9) -- Line: 76
    local DisplayAppearance = p9:GetDisplayAppearance();

    if DisplayAppearance then
        return DisplayAppearance.ShowWhileInspecting;
    end;

    return false;
end;

function u1.GetAppearanceSpacing(p10) -- Line: 82
    local DisplayAppearance = p10:GetDisplayAppearance();

    return DisplayAppearance and DisplayAppearance.BarsSpacing or 16;
end;

function u1.SetParent(p11, p12) -- Line: 88
    p11.Frame.Parent = p12;
end;

function u1.SetType(p13, p14, p15) -- Line: 92
    -- upvalues: ItemLibrary (copy)
    p13.Type = p14;
    p13.Info = ItemLibrary.Crosshairs[p13.Type];
    p13:_UpdateDeferred(p15);
end;

function u1.SetVisible(p16, p17, p18) -- Line: 98
    if p17 == p16._visible then
        return;
    end;

    p16._visible = p17;
    p16:_UpdateDeferred(p18);
end;

function u1.SetSpacing(p19, p20, p21, p22) -- Line: 107
    if p20 == p19._spacing and p21 == p19._spacing_multiplier then
        return;
    end;

    p19._spacing = p20 or p19._spacing;
    p19._spacing_multiplier = p21 or p19._spacing_multiplier;
    p19:_UpdateDeferred(p22);
end;

function u1.SetTransparency(p23, p24, p25) -- Line: 117
    if p24 == p23._transparency then
        return;
    end;

    p23._transparency = p24;
    p23:_UpdateDeferred(p25);
end;

function u1.SetAppearance(p26, p27, p28) -- Line: 126
    p26.Appearance = p27;
    p26:_UpdateDeferred(p28);
end;

function u1.SetHitmarkerColor(p29, p30) -- Line: 131
    -- upvalues: Utility (copy)
    p29._last_hitmarker_crit_set = p30;
    local v31;

    if p29._last_hitmarker_crit_set then
        v31 = p29._hitmarker_color_crit or "#ff3232";
    else
        v31 = p29._hitmarker_color or "#ffffff";
    end;

    local v32 = Utility:Color3FromHex(v31);
    p29.Frame.Hitmarker.TL.ImageColor3 = v32;
    p29.Frame.Hitmarker.TR.ImageColor3 = v32;
    p29.Frame.Hitmarker.BR.ImageColor3 = v32;
    p29.Frame.Hitmarker.BL.ImageColor3 = v32;
end;

function u1.SetHitmarkerVisuals(p33, p34, p35, p36, p37) -- Line: 141
    local Appearance = p33.Appearance;
    local v38 = p33._last_hitmarker_crit_set and Appearance and Appearance.HitmarkerTransparencyCrit or (Appearance and Appearance.HitmarkerTransparency or 0);
    local v39 = v38 + (1 - v38) * p36;
    p33.Frame.Hitmarker.TL.Position = UDim2.new(0.5, -p34, 0.5, -p34);
    p33.Frame.Hitmarker.TR.Position = UDim2.new(0.5, p34, 0.5, -p34);
    p33.Frame.Hitmarker.BR.Position = UDim2.new(0.5, p34, 0.5, p34);
    p33.Frame.Hitmarker.BL.Position = UDim2.new(0.5, -p34, 0.5, p34);
    p33.Frame.Hitmarker.TL.Size = p35;
    p33.Frame.Hitmarker.TR.Size = p35;
    p33.Frame.Hitmarker.BR.Size = p35;
    p33.Frame.Hitmarker.BL.Size = p35;
    p33.Frame.Hitmarker.TL.ImageTransparency = v39;
    p33.Frame.Hitmarker.TR.ImageTransparency = v39;
    p33.Frame.Hitmarker.BR.ImageTransparency = v39;
    p33.Frame.Hitmarker.BL.ImageTransparency = v39;
end;

function u1.Destroy(p40) -- Line: 164
    if p40._destroyed then
        return;
    end;

    p40._destroyed = true;
    pcall(p40.Frame.Destroy, p40.Frame);
end;

function u1._UpdateDeferred(u41, ...) -- Line: 177
    if u41._update_queued then
        task.cancel(u41._update_queued);
        u41._update_queued = nil;
    end;

    u41._update_queued = task.defer(function(...) -- Line: 183
        -- upvalues: u41 (copy)
        u41._update_queued = nil;
        u41:_Update(...);
    end, ...);
end;

function u1._Update(p42, p43) -- Line: 189
    -- upvalues: ItemLibrary (copy), Utility (copy)
    if p42._destroyed or p43 then
        return;
    end;

    local Appearance = p42.Appearance;
    local v44 = p42._visible and (not Appearance and true or not Appearance.IsDisabled);
    p42.Frame.Foreground.Visible = v44;
    p42.Frame.Background.Visible = v44;
    local v45 = not Appearance and true or not Appearance.HitmarkerDisabled;
    local v46;

    if Appearance then
        v46 = Appearance.HitmarkerColor;
    else
        v46 = Appearance;
    end;

    p42._hitmarker_color = v46;

    if Appearance then
        Appearance = Appearance.HitmarkerColorCrit;
    end;

    p42._hitmarker_color_crit = Appearance;
    p42.Frame.Hitmarker.Visible = v45;

    if not v44 then
        return;
    end;

    local DisplayAppearance = p42:GetDisplayAppearance();
    local v47 = DisplayAppearance and (DisplayAppearance.Scale or 1) or 1;
    local v48 = DisplayAppearance and (DisplayAppearance.Rotation or 0) or 0;
    local v49 = DisplayAppearance and (DisplayAppearance.HitmarkerScale or 1) or 1;
    local v50 = DisplayAppearance and (DisplayAppearance.HitmarkerRotation or 0) or 0;
    p42.Frame.UIScale.Scale = v47;
    p42.Frame.Rotation = v48;
    p42.Frame.Hitmarker.UIScale.Scale = v49 / v47;
    p42.Frame.Hitmarker.Rotation = -v48 + v50;
    local v51 = p42.Info.IsSpecial and (p42.Appearance and p42.Appearance.Override) and ItemLibrary.Crosshairs.Default or p42.Info;
    p42.Frame.Foreground.Dot.Image = v51.DotImage;
    p42.Frame.Foreground.Right.Image = v51.RightBarImage;
    p42.Frame.Foreground.Left.Image = v51.LeftBarImage;
    p42.Frame.Foreground.Down.Image = v51.BottomBarImage;
    p42.Frame.Foreground.Up.Image = v51.TopBarImage;
    p42.Frame.Background.Dot.Image = p42.Frame.Foreground.Dot.Image;
    p42.Frame.Background.Right.Image = p42.Frame.Foreground.Right.Image;
    p42.Frame.Background.Left.Image = p42.Frame.Foreground.Left.Image;
    p42.Frame.Background.Down.Image = p42.Frame.Foreground.Down.Image;
    p42.Frame.Background.Up.Image = p42.Frame.Foreground.Up.Image;
    local v52 = not DisplayAppearance and true or not DisplayAppearance.BarsDisabled;
    local v53 = not DisplayAppearance and true or not DisplayAppearance.BarsTopDisabled;
    local v54 = not DisplayAppearance and true or not DisplayAppearance.BarsBottomDisabled;
    local v55 = not DisplayAppearance and true or not DisplayAppearance.BarsRightDisabled;
    local v56 = not DisplayAppearance and true or not DisplayAppearance.BarsLeftDisabled;
    local v57 = not DisplayAppearance and true or not DisplayAppearance.CircleDisabled;
    p42.Frame.Foreground.Dot.Visible = v51.DotEnabled and (not DisplayAppearance and true or not DisplayAppearance.DotDisabled);
    local BarsEnabled = v51.BarsEnabled;

    if BarsEnabled then
        if not v52 then
            v55 = v52;
        end;
    else
        v55 = BarsEnabled;
    end;

    p42.Frame.Foreground.Right.Visible = v55;
    local BarsEnabled2 = v51.BarsEnabled;

    if BarsEnabled2 then
        if not v52 then
            v56 = v52;
        end;
    else
        v56 = BarsEnabled2;
    end;

    p42.Frame.Foreground.Left.Visible = v56;
    local BarsEnabled3 = v51.BarsEnabled;

    if BarsEnabled3 then
        if not v52 then
            v54 = v52;
        end;
    else
        v54 = BarsEnabled3;
    end;

    p42.Frame.Foreground.Down.Visible = v54;
    local BarsEnabled4 = v51.BarsEnabled;

    if BarsEnabled4 then
        if not v52 then
            v53 = v52;
        end;
    else
        v53 = BarsEnabled4;
    end;

    p42.Frame.Foreground.Up.Visible = v53;
    p42.Frame.Foreground.Circle.Visible = v51.CircleEnabled and v57;
    p42.Frame.Background.Dot.Visible = p42.Frame.Foreground.Dot.Visible;
    p42.Frame.Background.Right.Visible = p42.Frame.Foreground.Right.Visible;
    p42.Frame.Background.Left.Visible = p42.Frame.Foreground.Left.Visible;
    p42.Frame.Background.Down.Visible = p42.Frame.Foreground.Down.Visible;
    p42.Frame.Background.Up.Visible = p42.Frame.Foreground.Up.Visible;
    p42.Frame.Background.Circle.Visible = p42.Frame.Foreground.Circle.Visible;
    local v58;

    if DisplayAppearance then
        v58 = DisplayAppearance.IsStatic;
    else
        v58 = false;
    end;

    local v59 = (v58 and p42:GetAppearanceSpacing() or p42._spacing) * p42._spacing_multiplier;
    p42.Frame.Foreground.Right.Position = UDim2.new(0.5, v59, 0.5, 0);
    p42.Frame.Foreground.Left.Position = UDim2.new(0.5, -v59, 0.5, 0);
    p42.Frame.Foreground.Down.Position = UDim2.new(0.5, 0, 0.5, v59);
    p42.Frame.Foreground.Up.Position = UDim2.new(0.5, 0, 0.5, -v59);
    p42.Frame.Background.Right.Position = p42.Frame.Foreground.Right.Position;
    p42.Frame.Background.Left.Position = p42.Frame.Foreground.Left.Position;
    p42.Frame.Background.Down.Position = p42.Frame.Foreground.Down.Position;
    p42.Frame.Background.Up.Position = p42.Frame.Foreground.Up.Position;
    local v60 = DisplayAppearance and (DisplayAppearance.DotTransparency or 0) or 0;
    local v61 = DisplayAppearance and (DisplayAppearance.BarsTransparency or 0) or 0;
    local v62 = v61 + (1 - v61) * p42._transparency;
    local v63 = DisplayAppearance and (DisplayAppearance.CircleTransparency or 0) or 0;
    local v64 = v63 + (1 - v63) * p42._transparency;
    p42.Frame.Foreground.Dot.ImageTransparency = v60 + (1 - v60) * p42._transparency;
    p42.Frame.Foreground.Right.ImageTransparency = v62;
    p42.Frame.Foreground.Left.ImageTransparency = v62;
    p42.Frame.Foreground.Down.ImageTransparency = v62;
    p42.Frame.Foreground.Up.ImageTransparency = v62;
    p42.Frame.Foreground.Circle.UIStroke.Transparency = v64;
    p42.Frame.Background.Dot.ImageTransparency = p42.Frame.Foreground.Dot.ImageTransparency;
    p42.Frame.Background.Right.ImageTransparency = p42.Frame.Foreground.Right.ImageTransparency;
    p42.Frame.Background.Left.ImageTransparency = p42.Frame.Foreground.Left.ImageTransparency;
    p42.Frame.Background.Down.ImageTransparency = p42.Frame.Foreground.Down.ImageTransparency;
    p42.Frame.Background.Up.ImageTransparency = p42.Frame.Foreground.Up.ImageTransparency;
    local v65 = DisplayAppearance and (DisplayAppearance.DotThickness or 2) or 2;
    local v66 = DisplayAppearance and (DisplayAppearance.BarsLength or 6) or 6;
    local v67 = DisplayAppearance and (DisplayAppearance.BarsThickness or 2) or 2;
    local v68 = DisplayAppearance and (DisplayAppearance.CircleSize or 16) or 16;
    local v69 = DisplayAppearance and (DisplayAppearance.CircleThickness or 2) or 2;
    p42.Frame.Foreground.Dot.Size = v51.DotSize or UDim2.new(0, v65, 0, v65);
    p42.Frame.Foreground.Right.Size = v51.RightBarSize or UDim2.new(0, v66, 0, v67);
    p42.Frame.Foreground.Left.Size = v51.LeftBarSize or UDim2.new(0, v66, 0, v67);
    p42.Frame.Foreground.Down.Size = v51.BottomBarSize or UDim2.new(0, v67, 0, v66);
    p42.Frame.Foreground.Up.Size = v51.TopBarSize or UDim2.new(0, v67, 0, v66);
    p42.Frame.Foreground.Circle.Size = v51.CircleSize or UDim2.new(0, v68, 0, v68);
    p42.Frame.Foreground.Circle.UIStroke.Thickness = v51.CircleThickness or v69;
    p42.Frame.Background.Dot.Size = p42.Frame.Foreground.Dot.Size;
    p42.Frame.Background.Right.Size = p42.Frame.Foreground.Right.Size;
    p42.Frame.Background.Left.Size = p42.Frame.Foreground.Left.Size;
    p42.Frame.Background.Down.Size = p42.Frame.Foreground.Down.Size;
    p42.Frame.Background.Up.Size = p42.Frame.Foreground.Up.Size;
    local v70 = not DisplayAppearance and true or not DisplayAppearance.OutlineDisabled;
    p42.Frame.Background.Circle.UIStroke.Enabled = v70;
    p42.Frame.Background.Dot.UIStroke.Enabled = v70;
    p42.Frame.Background.Right.UIStroke.Enabled = v70;
    p42.Frame.Background.Left.UIStroke.Enabled = v70;
    p42.Frame.Background.Down.UIStroke.Enabled = v70;
    p42.Frame.Background.Up.UIStroke.Enabled = v70;

    if v70 then
        local v71 = DisplayAppearance and (DisplayAppearance.OutlineTransparency or 0) or 0;
        local v72 = v71 + (1 - v71) * p42._transparency;
        p42.Frame.Background.Dot.UIStroke.Transparency = v72;
        p42.Frame.Background.Right.UIStroke.Transparency = v72;
        p42.Frame.Background.Left.UIStroke.Transparency = v72;
        p42.Frame.Background.Down.UIStroke.Transparency = v72;
        p42.Frame.Background.Up.UIStroke.Transparency = v72;
        p42.Frame.Background.Circle.UIStroke.Transparency = v72;
        local v73 = DisplayAppearance and (DisplayAppearance.OutlineThickness or 0) or 0;
        local _ = v73 * 2 + v69;
        p42.Frame.Background.Dot.UIStroke.Thickness = v73;
        p42.Frame.Background.Right.UIStroke.Thickness = v73;
        p42.Frame.Background.Left.UIStroke.Thickness = v73;
        p42.Frame.Background.Down.UIStroke.Thickness = v73;
        p42.Frame.Background.Up.UIStroke.Thickness = v73;
        p42.Frame.Background.Circle.UIStroke.Thickness = v73 * 2 + v69;
        p42.Frame.Background.Circle.Size = UDim2.new(0, math.max(0, p42.Frame.Foreground.Circle.Size.X.Offset - v73 * 2), 0, (math.max(0, p42.Frame.Foreground.Circle.Size.Y.Offset - v73 * 2)));
        local v74 = Enum.LineJoinMode[DisplayAppearance and (DisplayAppearance.OutlineType or "Miter") or "Miter"];
        p42.Frame.Background.Dot.UIStroke.LineJoinMode = v74;
        p42.Frame.Background.Right.UIStroke.LineJoinMode = v74;
        p42.Frame.Background.Left.UIStroke.LineJoinMode = v74;
        p42.Frame.Background.Down.UIStroke.LineJoinMode = v74;
        p42.Frame.Background.Up.UIStroke.LineJoinMode = v74;
    end;

    local v75 = Utility:Color3FromHex(DisplayAppearance and (DisplayAppearance.DotColor or "#ffffff") or "#ffffff");
    local v76 = Utility:Color3FromHex(DisplayAppearance and (DisplayAppearance.BarsColor or "#ffffff") or "#ffffff");
    local v77 = Utility:Color3FromHex(DisplayAppearance and (DisplayAppearance.CircleColor or "#ffffff") or "#ffffff");
    p42.Frame.Foreground.Dot.ImageColor3 = v75;
    p42.Frame.Foreground.Right.ImageColor3 = v76;
    p42.Frame.Foreground.Left.ImageColor3 = v76;
    p42.Frame.Foreground.Down.ImageColor3 = v76;
    p42.Frame.Foreground.Up.ImageColor3 = v76;
    p42.Frame.Foreground.Circle.UIStroke.Color = v77;
    p42.Frame.Background.Dot.ImageColor3 = p42.Frame.Foreground.Dot.ImageColor3;
    p42.Frame.Background.Right.ImageColor3 = p42.Frame.Foreground.Right.ImageColor3;
    p42.Frame.Background.Left.ImageColor3 = p42.Frame.Foreground.Left.ImageColor3;
    p42.Frame.Background.Down.ImageColor3 = p42.Frame.Foreground.Down.ImageColor3;
    p42.Frame.Background.Up.ImageColor3 = p42.Frame.Foreground.Up.ImageColor3;
    local v78 = Utility:Color3FromHex(DisplayAppearance and (DisplayAppearance.OutlineColor or "#000000") or "#000000");
    p42.Frame.Background.Dot.UIStroke.Color = v78;
    p42.Frame.Background.Right.UIStroke.Color = v78;
    p42.Frame.Background.Left.UIStroke.Color = v78;
    p42.Frame.Background.Down.UIStroke.Color = v78;
    p42.Frame.Background.Up.UIStroke.Color = v78;
    p42.Frame.Background.Circle.UIStroke.Color = v78;
    local v79 = DisplayAppearance and (DisplayAppearance.BarsShape or "Sharp") or "Sharp";
    local v80 = DisplayAppearance and DisplayAppearance.CircleShape or "Circle";
    p42.Frame.Foreground.Dot.UICorner.CornerRadius = (DisplayAppearance and (DisplayAppearance.DotShape or "Sharp") or "Sharp") == "Round" and UDim.new(1, 0) or UDim.new(0, 0);
    p42.Frame.Foreground.Right.UICorner.CornerRadius = v79 == "Round" and UDim.new(1, 0) or UDim.new(0, 0);
    p42.Frame.Foreground.Left.UICorner.CornerRadius = v79 == "Round" and UDim.new(1, 0) or UDim.new(0, 0);
    p42.Frame.Foreground.Down.UICorner.CornerRadius = v79 == "Round" and UDim.new(1, 0) or UDim.new(0, 0);
    p42.Frame.Foreground.Up.UICorner.CornerRadius = v79 == "Round" and UDim.new(1, 0) or UDim.new(0, 0);
    p42.Frame.Foreground.Circle.UICorner.CornerRadius = v80 == "Circle" and UDim.new(1, 0) or (v80 == "Round" and UDim.new(0.25, 0) or UDim.new(0, 0));
    p42.Frame.Background.Dot.UICorner.CornerRadius = p42.Frame.Foreground.Dot.UICorner.CornerRadius;
    p42.Frame.Background.Right.UICorner.CornerRadius = p42.Frame.Foreground.Right.UICorner.CornerRadius;
    p42.Frame.Background.Left.UICorner.CornerRadius = p42.Frame.Foreground.Left.UICorner.CornerRadius;
    p42.Frame.Background.Down.UICorner.CornerRadius = p42.Frame.Foreground.Down.UICorner.CornerRadius;
    p42.Frame.Background.Up.UICorner.CornerRadius = p42.Frame.Foreground.Up.UICorner.CornerRadius;
    p42.Frame.Background.Circle.UICorner.CornerRadius = p42.Frame.Foreground.Circle.UICorner.CornerRadius;
end;

function u1._Setup(p81) -- Line: 398
    p81.Frame.Visible = true;
end;

function u1._Init(u82) -- Line: 402
    u82.Frame.Destroying:Connect(function() -- Line: 403
        -- upvalues: u82 (copy)
        u82:Destroy();
    end);
    u82:_Setup();
    u82:SetType("Default", true);
    u82:SetSpacing(16, 1, true);
    u82:SetTransparency(0, true);
    u82:SetHitmarkerVisuals(0, UDim2.new(0, 0, 0), 1, 0);
    u82:SetVisible(true, true);
    u82:SetAppearance(nil, true);
    u82:_Update();
end;

return u1;