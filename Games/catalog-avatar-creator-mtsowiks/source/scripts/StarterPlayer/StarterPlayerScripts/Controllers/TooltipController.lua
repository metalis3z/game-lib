-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local v1 = {};
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local ThemeController = require(script.Parent.ThemeController);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "TooltipContainer";
ScreenGui.DisplayOrder = 1000;
ScreenGui.Parent = PlayerGui;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = setmetatable({}, {
    __mode = "k"
});
local u8 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function createTooltipVisual(p9) -- Line: 31
    -- upvalues: ThemeController (copy), ScreenGui (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Tooltip";
    Frame.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(24, 25, 33));
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    local v10 = math.max(300, ScreenGui.AbsoluteSize.X * 0.15);
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MaxSize = Vector2.new(v10, (1 / 0));
    UISizeConstraint.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 8);
    UIPadding.PaddingBottom = UDim.new(0, 8);
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Content";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p9;
    TextLabel.TextColor3 = ThemeController.GetColor(Color3.fromRGB(244, 244, 244));
    TextLabel.TextTransparency = 1;
    TextLabel.TextWrapped = true;
    TextLabel.Font = Enum.Font.BuilderSans;
    TextLabel.TextSize = 22;
    TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
    TextLabel.Parent = Frame;

    return Frame, TextLabel;
end;

local function cleanupTooltip() -- Line: 75
    -- upvalues: u4 (ref), u5 (ref), u2 (ref), TweenService (copy), u8 (copy)
    if u4 then
        u4:Cancel();
        u4 = nil;
    end;

    if u5 then
        u5:Disconnect();
        u5 = nil;
    end;

    if u2 then
        local u11 = u2;
        u2 = nil;
        local Content = u11:FindFirstChild("Content");

        if Content then
            local v12 = TweenService:Create(u11, u8, {
                BackgroundTransparency = 1
            });
            local v13 = TweenService:Create(Content, u8, {
                TextTransparency = 1
            });
            v12:Play();
            v13:Play();
            v12.Completed:Connect(function() -- Line: 100
                -- upvalues: u11 (copy)
                if u11 then
                    u11:Destroy();
                end;
            end);

            return;
        end;

        u11:Destroy();
    end;
end;

function v1.AddTooltipOnHover(u14, u15, u16) -- Line: 109
    -- upvalues: u7 (copy), u6 (ref), u2 (ref), u3 (ref), cleanupTooltip (copy), createTooltipVisual (copy), ScreenGui (copy), u5 (ref), RunService (copy), TweenService (copy), u8 (copy), u4 (ref)
    if u14 == nil then
        return;
    end;

    if u7[u14] then
        for _, v in u7[u14] do
            v:Disconnect();
        end;

        u7[u14] = nil;
    end;

    local v17 = u6 == u14 and u2 and u2:FindFirstChild("Content");

    if v17 then
        v17.Text = u15;
    end;

    u7[u14] = { u14.MouseEnter:Connect(function() -- Line: 127
            -- upvalues: u3 (ref), u6 (ref), u14 (copy), u2 (ref), cleanupTooltip (ref), createTooltipVisual (ref), u15 (copy), ScreenGui (ref), u16 (copy), u5 (ref), RunService (ref), TweenService (ref), u8 (ref), u4 (ref)
            if u3 then
                task.cancel(u3);
            end;

            u6 = u14;
            u3 = task.delay(0.25, function() -- Line: 134
                -- upvalues: u14 (ref), u2 (ref), cleanupTooltip (ref), createTooltipVisual (ref), u15 (ref), ScreenGui (ref), u16 (ref), u5 (ref), RunService (ref), TweenService (ref), u8 (ref), u4 (ref)
                if not (u14 and u14.Parent) then
                    return;
                end;

                if u2 then
                    cleanupTooltip();
                end;

                local u18, v19 = createTooltipVisual(u15);
                local AbsolutePosition = u14.AbsolutePosition;
                u18.Parent = ScreenGui;
                u2 = u18;

                local function updatePosition() -- Line: 150
                    -- upvalues: u18 (copy), ScreenGui (ref), u16 (ref), u14 (ref)
                    local AbsoluteSize = u18.AbsoluteSize;
                    local AbsoluteSize2 = ScreenGui.AbsoluteSize;
                    local v20 = type(u16) == "function" and u16() or (u16 or 0);
                    local v21 = u14.AbsolutePosition.Y + u14.AbsoluteSize.Y + 10;

                    if v21 + AbsoluteSize.Y > AbsoluteSize2.Y then
                        v21 = u14.AbsolutePosition.Y - AbsoluteSize.Y - 10;
                    end;

                    local v22 = math.clamp(u14.AbsolutePosition.X + u14.AbsoluteSize.X / 2 + v20, AbsoluteSize.X / 2, AbsoluteSize2.X - AbsoluteSize.X / 2);
                    local v23 = math.clamp(v21, 0, AbsoluteSize2.Y - AbsoluteSize.Y);
                    u18.Position = UDim2.fromOffset(v22, v23);
                end;

                updatePosition();
                u5 = RunService.Heartbeat:Connect(function() -- Line: 172
                    -- upvalues: u14 (ref), cleanupTooltip (ref), AbsolutePosition (copy), updatePosition (copy)
                    if not (u14 and u14.Parent) then
                        cleanupTooltip();

                        return;
                    end;

                    if (u14.AbsolutePosition - AbsolutePosition).Magnitude > 1 then
                        cleanupTooltip();

                        return;
                    end;

                    updatePosition();
                end);
                local v24 = TweenService:Create(u18, u8, {
                    BackgroundTransparency = 0.1
                });
                local v25 = TweenService:Create(v19, u8, {
                    TextTransparency = 0
                });
                u4 = v24;
                v24:Play();
                v25:Play();
            end);
        end), (u14.MouseLeave:Connect(function() -- Line: 195
            -- upvalues: u6 (ref), u14 (copy), u3 (ref), cleanupTooltip (ref)
            if u6 == u14 then
                if u3 then
                    task.cancel(u3);
                    u3 = nil;
                end;

                u6 = nil;
            end;

            cleanupTooltip();
        end)) };
end;

script.Parent.Parent:WaitForChild("Events"):WaitForChild("AddTooltipToObject").Event:Connect(v1.AddTooltipOnHover);

return v1;