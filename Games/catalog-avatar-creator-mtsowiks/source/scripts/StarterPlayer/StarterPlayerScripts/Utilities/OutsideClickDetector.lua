-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");

local function getGuiMousePoint() -- Line: 4
    -- upvalues: UserInputService (copy), GuiService (copy)
    local v1 = UserInputService:GetMouseLocation();
    local v2 = GuiService:GetGuiInset();

    return Vector2.new(v1.X - v2.X, v1.Y - v2.Y);
end;

local function pointInGui(p3, p4, p5) -- Line: 10
    if not (p3 and p3.Visible) then
        return false;
    end;

    local AbsolutePosition = p3.AbsolutePosition;
    local AbsoluteSize = p3.AbsoluteSize;
    local v6;

    if p4.X >= AbsolutePosition.X and (p4.X <= AbsolutePosition.X + AbsoluteSize.X and p4.Y >= AbsolutePosition.Y) then
        v6 = p4.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v6 = false;
    end;

    if v6 == false and p5 then
        for _, v in p5 do
            local AbsolutePosition2 = v.AbsolutePosition;
            local AbsoluteSize2 = v.AbsoluteSize;
            local v7;

            if p4.X >= AbsolutePosition2.X and (p4.X <= AbsolutePosition2.X + AbsoluteSize2.X and p4.Y >= AbsolutePosition2.Y) then
                v7 = p4.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y;
            else
                v7 = false;
            end;

            if v7 == true then
                return true;
            end;
        end;
    end;

    return v6;
end;

return function(p8, u9, p10) -- Line: 33
    -- upvalues: pointInGui (copy), UserInputService (copy), GuiService (copy)
    local u11 = typeof(p8) == "Instance" and { p8 } or p8;
    local u12;

    if p10 then
        u12 = p10.include;
    else
        u12 = nil;
    end;

    local function insideAny(p13) -- Line: 40
        -- upvalues: u11 (ref), pointInGui (ref), u12 (copy)
        for _, v in ipairs(u11) do
            if pointInGui(v, p13, u12) then
                return true;
            end;
        end;

        return false;
    end;

    local u18 = UserInputService.InputBegan:Connect(function(p14, p15) -- Line: 50
        -- upvalues: UserInputService (ref), GuiService (ref), insideAny (copy), u9 (copy)
        if p14.UserInputType ~= Enum.UserInputType.MouseButton1 and p14.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v16 = UserInputService:GetMouseLocation();
        local v17 = GuiService:GetGuiInset();

        if not insideAny((Vector2.new(v16.X - v17.X, v16.Y - v17.Y))) then
            u9();
        end;
    end);

    return {
        Disconnect = function() -- Line: 64, Name: Disconnect
            -- upvalues: u18 (ref)
            if u18 then
                u18:Disconnect();
                u18 = nil;
            end;
        end
    };
end;