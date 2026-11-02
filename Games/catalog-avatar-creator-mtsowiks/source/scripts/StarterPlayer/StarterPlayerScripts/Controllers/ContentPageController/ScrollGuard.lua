-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local v1 = {};

local function dprint(...) -- Line: 26
end;

local function getMouseGuiPos() -- Line: 32
    -- upvalues: UserInputService (copy), GuiService (copy)
    local v2 = UserInputService:GetMouseLocation();
    local v3, v4 = GuiService:GetGuiInset();

    return v2 - Vector2.new(v3, v4);
end;

function v1.Attach(u5, u6, u7, u8) -- Line: 45
    -- upvalues: dprint (copy), UserInputService (copy), GuiService (copy)
    u5 = u5;
    local v9;

    if u5 then
        v9 = u5.Name;
    else
        v9 = u5;
    end;

    local v10;

    if u6 then
        v10 = u6.Name;
    else
        v10 = u6;
    end;

    local v11;

    if u7 then
        v11 = u7.Name;
    else
        v11 = u7;
    end;

    local v12;

    if u8 then
        v12 = u8.Name;
    else
        v12 = u8;
    end;

    dprint("Attach", v9, v10, v11, v12);
    local u13 = {};
    local u14 = false;
    local u15 = false;

    local function pointInRect(p16, p17) -- Line: 51
        if not (p17 and (p17.Parent and p17.Visible)) then
            return false;
        end;

        local AbsolutePosition = p17.AbsolutePosition;
        local AbsoluteSize = p17.AbsoluteSize;

        if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
            return false;
        end;

        local v18;

        if p16.X >= AbsolutePosition.X and (p16.Y >= AbsolutePosition.Y and p16.X <= AbsolutePosition.X + AbsoluteSize.X) then
            v18 = p16.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v18 = false;
        end;

        return v18;
    end;

    local function takeOver() -- Line: 61
        -- upvalues: u7 (copy), u5 (copy)
        if u7 then
            u7.ScrollingEnabled = false;
        end;

        u5.ScrollingEnabled = true;
    end;

    local function handBack(p19) -- Line: 69
        -- upvalues: u7 (copy), u5 (copy), pointInRect (copy), u8 (copy)
        if u7 then
            u7.ScrollingEnabled = true;
        end;

        local v20;

        if p19 == nil then
            v20 = false;
        else
            v20 = pointInRect(p19, u8);
        end;

        u5.ScrollingEnabled = not v20;
    end;

    local function refreshHover(p21) -- Line: 74
        -- upvalues: pointInRect (copy), u6 (copy), u15 (ref), dprint (ref), u7 (copy), u5 (copy), u8 (copy)
        if not pointInRect(p21, u6) then
            if u15 then
                u15 = false;

                if u7 then
                    u7.ScrollingEnabled = true;
                end;

                local v22;

                if p21 == nil then
                    v22 = false;
                else
                    v22 = pointInRect(p21, u8);
                end;

                u5.ScrollingEnabled = not v22;
                dprint("leave band (mouse)");
            end;

            return;
        end;

        if not u15 then
            u15 = true;
            dprint("enter band (mouse)");
        end;

        if u7 then
            u7.ScrollingEnabled = false;
        end;

        u5.ScrollingEnabled = true;
    end;

    table.insert(u13, UserInputService.InputChanged:Connect(function(p23) -- Line: 86
        -- upvalues: UserInputService (ref), GuiService (ref), pointInRect (copy), u6 (copy), u15 (ref), dprint (ref), u7 (copy), u5 (copy), u8 (copy)
        local UserInputType = p23.UserInputType;

        if UserInputType == Enum.UserInputType.MouseMovement then
            local v24 = UserInputService:GetMouseLocation();
            local v25, v26 = GuiService:GetGuiInset();
            local v27 = v24 - Vector2.new(v25, v26);

            if pointInRect(v27, u6) then
                if not u15 then
                    u15 = true;
                    dprint("enter band (mouse)");
                end;

                if u7 then
                    u7.ScrollingEnabled = false;
                end;

                u5.ScrollingEnabled = true;

                return;
            end;

            if u15 then
                u15 = false;

                if u7 then
                    u7.ScrollingEnabled = true;
                end;

                local v28;

                if v27 == nil then
                    v28 = false;
                else
                    v28 = pointInRect(v27, u8);
                end;

                u5.ScrollingEnabled = not v28;
                dprint("leave band (mouse)");
            end;
        elseif UserInputType == Enum.UserInputType.MouseWheel then
            local v29 = UserInputService:GetMouseLocation();
            local v30, v31 = GuiService:GetGuiInset();

            if pointInRect(v29 - Vector2.new(v30, v31), u6) then
                u15 = true;

                if u7 then
                    u7.ScrollingEnabled = false;
                end;

                u5.ScrollingEnabled = true;
            end;
        end;
    end));

    if u8 then
        table.insert(u13, u8.MouseEnter:Connect(function() -- Line: 101
            -- upvalues: UserInputService (ref), GuiService (ref), pointInRect (copy), u6 (copy), u15 (ref), dprint (ref), u7 (copy), u5 (copy), u8 (copy)
            local v32 = UserInputService:GetMouseLocation();
            local v33, v34 = GuiService:GetGuiInset();
            local v35 = v32 - Vector2.new(v33, v34);

            if not pointInRect(v35, u6) then
                if u15 then
                    u15 = false;

                    if u7 then
                        u7.ScrollingEnabled = true;
                    end;

                    local v36;

                    if v35 == nil then
                        v36 = false;
                    else
                        v36 = pointInRect(v35, u8);
                    end;

                    u5.ScrollingEnabled = not v36;
                    dprint("leave band (mouse)");
                end;

                return;
            end;

            if not u15 then
                u15 = true;
                dprint("enter band (mouse)");
            end;

            if u7 then
                u7.ScrollingEnabled = false;
            end;

            u5.ScrollingEnabled = true;
        end));
    end;

    table.insert(u13, UserInputService.InputBegan:Connect(function(p37) -- Line: 106
        -- upvalues: pointInRect (copy), u6 (copy), u15 (ref), u7 (copy), u5 (copy), dprint (ref)
        if p37.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        if not pointInRect(p37.Position, u6) then
            return;
        end;

        u15 = true;

        if u7 then
            u7.ScrollingEnabled = false;
        end;

        u5.ScrollingEnabled = true;
        dprint("touch begin in band -> native wrapper scroll");
    end));
    table.insert(u13, UserInputService.InputEnded:Connect(function(p38) -- Line: 114
        -- upvalues: u15 (ref), u7 (copy), u5 (copy)
        if p38.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        if not u15 then
            return;
        end;

        u15 = false;

        if u7 then
            u7.ScrollingEnabled = true;
        end;

        u5.ScrollingEnabled = true;
    end));

    local function cleanup() -- Line: 121
        -- upvalues: u14 (ref), u13 (copy), u7 (copy), u5 (copy)
        if u14 then
            return;
        end;

        u14 = true;

        for _, v in u13 do
            pcall(v.Disconnect, v);
        end;

        table.clear(u13);
        pcall(function() -- Line: 126
            -- upvalues: u7 (ref)
            if u7 then
                u7.ScrollingEnabled = true;
            end;
        end);
        pcall(function() -- Line: 127
            -- upvalues: u5 (ref)
            u5.ScrollingEnabled = true;
        end);
    end;

    table.insert(u13, u6.Destroying:Connect(cleanup));

    return cleanup;
end;

return v1;