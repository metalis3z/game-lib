-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local v1 = {};
local Quad = Enum.EasingStyle.Quad;
local InOut = Enum.EasingDirection.InOut;
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "BezierMoverLayer";
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 1000;
ScreenGui.ResetOnSpawn = false;
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
local u2 = {};

local function getQuadraticBezier(p3, p4, p5, p6) -- Line: 31
    return p4:Lerp(p5, p3):Lerp(p5:Lerp(p6, p3), p3);
end;

function v1.CurveTransition(p7, p8, u9) -- Line: 37
    -- upvalues: u2 (copy), ScreenGui (copy), GuiService (copy), TweenService (copy), RunService (copy), Quad (copy), InOut (copy)
    if not p7 then
        return;
    end;

    local v10 = p8 or Vector2.new(workspace.CurrentCamera.ViewportSize.X - 40, 40);

    if u9 and u2[u9] then
        u2[u9]();
    end;

    local u11 = p7:Clone();
    u11.Parent = ScreenGui;
    u11.AnchorPoint = Vector2.new(0, 0);
    local AbsolutePosition = p7.AbsolutePosition;
    local AbsoluteSize = p7.AbsoluteSize;
    local v12 = GuiService:GetGuiInset();
    local u13 = {};

    local function cacheTransparency(p14) -- Line: 61
        -- upvalues: u13 (copy)
        local v15 = {
            Instance = p14
        };
        local v16;

        if p14:IsA("GuiObject") then
            v15.Bg = p14.BackgroundTransparency;
            v16 = true;
        else
            v16 = false;
        end;

        if p14:IsA("ImageLabel") or p14:IsA("ImageButton") then
            v15.Img = p14.ImageTransparency;
            v16 = true;
        end;

        if p14:IsA("TextLabel") or (p14:IsA("TextButton") or p14:IsA("TextBox")) then
            v15.Txt = p14.TextTransparency;
            v16 = true;
        end;

        if p14:IsA("UIStroke") then
            v15.Stroke = p14.Transparency;
            v16 = true;
        end;

        if v16 then
            table.insert(u13, v15);
        end;
    end;

    cacheTransparency(u11);

    for _, descendant in u11:GetDescendants() do
        cacheTransparency(descendant);
    end;

    u11.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    u11.Position = UDim2.fromOffset(AbsolutePosition.X, AbsolutePosition.Y + v12.Y);
    local v17 = v10.Y + v12.Y;
    local X = v10.X;
    local u18 = Vector2.new(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2 + v12.Y);
    local u19 = Vector2.new(X, v17);
    local v20 = (u18 + u19) / 2;
    local v21 = u19 - u18;
    local Unit = Vector2.new(-v21.Y, v21.X).Unit;

    if Unit.Y > 0 then
        Unit = -Unit;
    end;

    local v22 = v21.Magnitude * 0.5;
    local u23 = v20 + Unit * v22;
    local AbsoluteSize2 = ScreenGui.AbsoluteSize;

    if u23.X < 0 or (u23.X > AbsoluteSize2.X or (u23.Y < 0 or u23.Y > AbsoluteSize2.Y)) then
        u23 = v20 - Unit * v22;
    end;

    local u24 = AbsoluteSize * 0.5;
    local u25 = tick();
    local u26 = nil;
    local u27 = false;

    local function cancelTransition() -- Line: 129
        -- upvalues: u27 (ref), u26 (ref), u13 (copy), TweenService (ref), u11 (copy)
        u27 = true;

        if u26 then
            u26:Disconnect();
        end;

        local v28 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

        for _, v in u13 do
            local v29 = {};

            if v.Bg then
                v29.BackgroundTransparency = 1;
            end;

            if v.Img then
                v29.ImageTransparency = 1;
            end;

            if v.Txt then
                v29.TextTransparency = 1;
            end;

            if v.Stroke then
                v29.Transparency = 1;
            end;

            if next(v29) then
                TweenService:Create(v.Instance, v28, v29):Play();
            end;
        end;

        task.delay(0.15, function() -- Line: 148
            -- upvalues: u11 (ref)
            if u11 then
                u11:Destroy();
            end;
        end);
    end;

    if u9 then
        u2[u9] = cancelTransition;
    end;

    u26 = RunService.Heartbeat:Connect(function() -- Line: 158
        -- upvalues: u27 (ref), u25 (copy), TweenService (ref), Quad (ref), InOut (ref), u18 (copy), u23 (ref), u19 (copy), AbsoluteSize (copy), u24 (copy), u11 (copy), u13 (copy), u26 (ref), u9 (copy), u2 (ref), cancelTransition (copy)
        if u27 then
            return;
        end;

        local v30 = tick() - u25;
        local v31 = math.clamp(v30 / 2, 0, 1);
        local v32 = TweenService:GetValue(v31, Quad, InOut);
        local v33 = u23;
        local v34 = u18:Lerp(v33, v32):Lerp(v33:Lerp(u19, v32), v32);
        local v35 = v31 >= 0.3 and 1 or math.sin(v31 / 0.3 * 3.141592653589793) * 0.25 + 1;
        local v36 = AbsoluteSize:Lerp(u24, v32) * v35;
        u11.Size = UDim2.fromOffset(v36.X, v36.Y);
        u11.Position = UDim2.fromOffset(v34.X - v36.X / 2, v34.Y - v36.Y / 2);
        u11.Rotation = math.sin(v30 * 5) * 15;
        local v37 = (v31 <= 0.6 and 0 or math.clamp((v31 - 0.6) / 0.20000000000000007, 0, 1)) * 0.8 + 0.2;

        for _, v in u13 do
            local Instance2 = v.Instance;

            if v.Bg then
                Instance2.BackgroundTransparency = v.Bg + (1 - v.Bg) * v37;
            end;

            if v.Img then
                Instance2.ImageTransparency = v.Img + (1 - v.Img) * v37;
            end;

            if v.Txt then
                Instance2.TextTransparency = v.Txt + (1 - v.Txt) * v37;
            end;

            if v.Stroke then
                Instance2.Transparency = v.Stroke + (1 - v.Stroke) * v37;
            end;
        end;

        if v31 >= 1 then
            u26:Disconnect();
            u11:Destroy();

            if u9 and u2[u9] == cancelTransition then
                u2[u9] = nil;
            end;
        end;
    end);
end;

function v1.Cancel(p38) -- Line: 221
    -- upvalues: u2 (copy)
    if p38 and u2[p38] then
        u2[p38]();
        u2[p38] = nil;
    end;
end;

return v1;