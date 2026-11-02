-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Pages = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Pages");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy), Players (copy)
    local v2 = setmetatable({}, u1);
    v2.BUTTON_BACKGROUND_TRANSPARENCY = 0.08;
    v2.BUTTON_BACKGROUND_COLOR = Color3.fromRGB(18, 18, 21);
    v2.BUTTON_ICON_COLOR = Color3.fromRGB(247, 247, 248);
    v2.PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
    v2.MainGui = v2.PlayerGui:WaitForChild("MainGui");
    v2:_Init();

    return v2;
end;

function u1.GetMouseLocation(p3) -- Line: 33
    -- upvalues: UserInputService (copy), GuiService (copy)
    return UserInputService:GetMouseLocation() - Vector2.new(0, GuiService.TopbarInset.Height);
end;

function u1.GetMouseLocationCentered(p4) -- Line: 38
    -- upvalues: GuiService (copy)
    return workspace.CurrentCamera.ViewportSize / 2 - Vector2.new(0, GuiService.TopbarInset.Height);
end;

function u1.ScreenPointToPosition(p5, p6, p7) -- Line: 42
    local v8 = p7 or p5.MainGui.AbsolutePosition;

    return Vector2.new(p6.X - v8.X, p6.Y - v8.Y);
end;

function u1.IsWithinBounds(p9, p10, p11, p12, p13) -- Line: 48
    local v14;

    if p12.X <= p10 and (p10 <= p12.X + p13.X and p12.Y <= p11) then
        v14 = p11 <= p12.Y + p13.Y;
    else
        v14 = false;
    end;

    return v14;
end;

function u1.IsMouseWithinBounds(p15, p16, p17) -- Line: 55
    local MouseLocation = p15:GetMouseLocation();

    return p15:IsWithinBounds(MouseLocation.X, MouseLocation.Y, p16, p17);
end;

function u1.GetTo(p18, ...) -- Line: 61
    -- upvalues: Utility (copy)
    return Utility:WaitForChild(p18.MainGui, ...);
end;

function u1.GetPage(p19, p20) -- Line: 65
    -- upvalues: Pages (copy)
    return Pages:WaitForChild(p20);
end;

function u1.ScrollingTextLabel(u21, u22, u23, u24) -- Line: 69
    -- upvalues: Players (copy)
    local u25 = nil;
    local u26 = 0;
    local u27 = 0;

    local function check_tween(u28) -- Line: 74
        -- upvalues: u26 (ref), u22 (copy), Players (ref), u25 (ref), u23 (copy), u27 (ref), u21 (copy), check_tween (copy)
        task.defer(function() -- Line: 75
            -- upvalues: u26 (ref), u22 (ref), Players (ref), u25 (ref), u23 (ref), u27 (ref), u21 (ref), u28 (copy), check_tween (ref)
            if tick() < u26 then
                return;
            end;

            if not u22:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
                u25 = nil;

                return;
            end;

            local v29 = u23.TextBounds.X - u22.AbsoluteSize.X;

            if v29 <= 0 or u25 and math.abs(v29 - u25) < 0.1 then
                return;
            end;

            u27 = u27 + 1;
            local u30 = u27;
            local v31 = v29 / u21.MainGui.AbsoluteSize.X * 50;
            local UDim2_new_ret = UDim2.new(0, 0, 0.5, 0);
            local UDim2_new_ret2 = UDim2.new(0, -v29, 0.5, 0);
            u26 = tick() + 1;
            u25 = v29;
            u23.Position = u28 and UDim2_new_ret2 and UDim2_new_ret2 or UDim2_new_ret;

            if u28 then
                UDim2_new_ret2 = UDim2_new_ret or UDim2_new_ret2;
            end;

            u23:TweenPosition(UDim2_new_ret2, "InOut", "Linear", v31, true, function() -- Line: 100
                -- upvalues: u27 (ref), u30 (copy), u25 (ref), check_tween (ref), u28 (ref)
                if u27 ~= u30 then
                    return;
                end;

                u25 = nil;
                task.delay(1, check_tween, not u28);
            end);
        end);
    end;

    u22.AncestryChanged:Connect(check_tween);
    u22:GetPropertyChangedSignal("AbsoluteSize"):Connect(check_tween);
    u23:GetPropertyChangedSignal("TextBounds"):Connect(check_tween);
    local u32 = nil;
    task.defer(function() -- Line: 75
        -- upvalues: u26 (ref), u22 (copy), Players (ref), u25 (ref), u23 (copy), u27 (ref), u21 (copy), u32 (copy), check_tween (copy)
        if tick() < u26 then
            return;
        end;

        if not u22:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
            u25 = nil;

            return;
        end;

        local v33 = u23.TextBounds.X - u22.AbsoluteSize.X;

        if v33 <= 0 or u25 and math.abs(v33 - u25) < 0.1 then
            return;
        end;

        u27 = u27 + 1;
        local u34 = u27;
        local v35 = v33 / u21.MainGui.AbsoluteSize.X * 50;
        local UDim2_new_ret = UDim2.new(0, 0, 0.5, 0);
        local UDim2_new_ret2 = UDim2.new(0, -v33, 0.5, 0);
        u26 = tick() + 1;
        u25 = v33;
        u23.Position = u32 and UDim2_new_ret2 and UDim2_new_ret2 or UDim2_new_ret;

        if u32 then
            UDim2_new_ret2 = UDim2_new_ret or UDim2_new_ret2;
        end;

        u23:TweenPosition(UDim2_new_ret2, "InOut", "Linear", v35, true, function() -- Line: 100
            -- upvalues: u27 (ref), u34 (copy), u25 (ref), check_tween (ref), u32 (ref)
            if u27 ~= u34 then
                return;
            end;

            u25 = nil;
            task.delay(1, check_tween, not u32);
        end);
    end);

    if u24 then
        local function update() -- Line: 117
            -- upvalues: u24 (copy), u22 (copy), u26 (ref), Players (ref), u25 (ref), u23 (copy), u27 (ref), u21 (copy), check_tween (copy)
            local v36 = not u24.Visible and 0 or u24.TextBounds.X;
            u22.Size = UDim2.new(0, u24.AbsolutePosition.X + u24.AbsoluteSize.X - v36 - (not v36 and 0 or u24.AbsoluteSize.Y * 0.5 + u22.AbsolutePosition.X), u22.Size.Y.Scale, u22.Size.Y.Offset);
            u26 = 0;
            local u37 = nil;
            task.defer(function() -- Line: 75
                -- upvalues: u26 (ref), u22 (ref), Players (ref), u25 (ref), u23 (ref), u27 (ref), u21 (ref), u37 (copy), check_tween (ref)
                if tick() < u26 then
                    return;
                end;

                if not u22:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
                    u25 = nil;

                    return;
                end;

                local v38 = u23.TextBounds.X - u22.AbsoluteSize.X;

                if v38 <= 0 or u25 and math.abs(v38 - u25) < 0.1 then
                    return;
                end;

                u27 = u27 + 1;
                local u39 = u27;
                local v40 = v38 / u21.MainGui.AbsoluteSize.X * 50;
                local UDim2_new_ret = UDim2.new(0, 0, 0.5, 0);
                local UDim2_new_ret2 = UDim2.new(0, -v38, 0.5, 0);
                u26 = tick() + 1;
                u25 = v38;
                u23.Position = u37 and UDim2_new_ret2 and UDim2_new_ret2 or UDim2_new_ret;

                if u37 then
                    UDim2_new_ret2 = UDim2_new_ret or UDim2_new_ret2;
                end;

                u23:TweenPosition(UDim2_new_ret2, "InOut", "Linear", v40, true, function() -- Line: 100
                    -- upvalues: u27 (ref), u39 (copy), u25 (ref), check_tween (ref), u37 (ref)
                    if u27 ~= u39 then
                        return;
                    end;

                    u25 = nil;
                    task.delay(1, check_tween, not u37);
                end);
            end);
        end;

        u22:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
        u22:GetPropertyChangedSignal("AbsolutePosition"):Connect(update);
        u24:GetPropertyChangedSignal("AbsolutePosition"):Connect(update);
        u24:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
        u24:GetPropertyChangedSignal("TextBounds"):Connect(update);
        u24:GetPropertyChangedSignal("Visible"):Connect(update);
        update();
    end;
end;

function u1._Init(p41) -- Line: 146
end;

return u1._new();