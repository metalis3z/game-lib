-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local CurrentCamera = workspace.CurrentCamera;
local u1 = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u2 = {};
local u3 = nil;
local zero = Vector2.zero;

local function reEnableAll() -- Line: 26
    -- upvalues: u2 (copy), u3 (ref)
    next(u2);
    local u4 = {};

    for i, _ in pairs(u2) do
        u4[i] = true;
    end;

    table.clear(u2);
    u3 = nil;
    task.delay(0.25, function() -- Line: 40
        -- upvalues: u4 (copy), u2 (ref)
        for i, _ in pairs(u4) do
            if not u2[i] then
                i.ScrollingEnabled = true;
            end;
        end;
    end);
end;

UserInputService.InputChanged:Connect(function(p5, p6) -- Line: 50
    -- upvalues: UserInputService (copy), GuiService (copy), CurrentCamera (copy), zero (ref), u3 (ref), PlayerGui (copy), CollectionService (copy), reEnableAll (copy), u2 (copy)
    if p5.UserInputType == Enum.UserInputType.MouseMovement then
        local v7 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
        local ViewportSize = CurrentCamera.ViewportSize;
        local v8 = ViewportSize.X * 0.04;
        local v9 = ViewportSize.Y * 0.3;
        local v10 = v7 - zero;

        if not u3 and (math.abs(v10.X) < v8 and math.abs(v10.Y) < v9) then
            return;
        end;

        zero = v7;
        local v11 = PlayerGui:GetGuiObjectsAtPosition(v7.X, v7.Y);
        local v12 = nil;

        for _, v in ipairs(v11) do
            if v:IsA("ScrollingFrame") and CollectionService:HasTag(v, "NestedScrollingFrame") then
                v12 = v;
                break;
            end;
        end;

        if v12 ~= u3 then
            reEnableAll();

            if v12 then
                u3 = v12;
                v12.ScrollingEnabled = false;
                u2[v12] = true;
                local Parent = v12.Parent;

                while Parent and Parent:IsDescendantOf(PlayerGui) do
                    if Parent:IsA("ScrollingFrame") then
                        Parent.ScrollingEnabled = false;
                        u2[Parent] = true;
                    end;

                    Parent = Parent.Parent;
                end;
            end;
        end;
    end;
end);
UserInputService.InputChanged:Connect(function(p13, p14) -- Line: 110
    -- upvalues: u3 (ref), PlayerGui (copy), UserInputService (copy), GuiService (copy), reEnableAll (copy), zero (ref), u2 (copy), TweenService (copy), u1 (copy)
    if p13.UserInputType == Enum.UserInputType.MouseWheel and (u3 and u3:IsDescendantOf(PlayerGui)) then
        local v15 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
        local v16 = PlayerGui:GetGuiObjectsAtPosition(v15.X, v15.Y);
        local v17 = false;

        for _, v in ipairs(v16) do
            if v == u3 then
                v17 = true;
                break;
            end;
        end;

        if not v17 then
            reEnableAll();

            return;
        end;

        zero = v15;
        local v18 = u3;
        local Z = p13.Position.Z;
        local CanvasPosition = v18.CanvasPosition;
        local AbsoluteWindowSize = v18.AbsoluteWindowSize;
        local v19 = v18.AbsoluteCanvasSize - AbsoluteWindowSize;
        local v20;

        if v18.ScrollingDirection == Enum.ScrollingDirection.X then
            local v21 = CanvasPosition.X - Z * (AbsoluteWindowSize.X * 0.235);
            local v22 = math.max(0, v19.X);
            local v23 = math.clamp(v21, 0, v22);
            v20 = Vector2.new(v23, CanvasPosition.Y);
        else
            local v24 = CanvasPosition.Y - Z * (AbsoluteWindowSize.Y * 0.235);
            local v25 = math.max(0, v19.Y);
            local v26 = math.clamp(v24, 0, v25);
            v20 = Vector2.new(CanvasPosition.X, v26);
        end;

        if v20 ~= CanvasPosition then
            for i, _ in pairs(u2) do
                if i ~= v18 then
                    i.ScrollingEnabled = false;
                end;
            end;

            TweenService:Create(v18, u1, {
                CanvasPosition = v20
            }):Play();

            return;
        end;

        for i, _ in pairs(u2) do
            if i ~= v18 then
                i.ScrollingEnabled = true;
            end;
        end;
    end;
end);