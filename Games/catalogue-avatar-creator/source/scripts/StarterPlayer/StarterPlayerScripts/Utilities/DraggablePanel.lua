-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;

local function isDragInput(p2) -- Line: 16
    return p2.UserInputType == Enum.UserInputType.MouseButton1 and true or p2.UserInputType == Enum.UserInputType.Touch;
end;

local function isMoveInput(p3) -- Line: 21
    return p3.UserInputType == Enum.UserInputType.MouseMovement and true or p3.UserInputType == Enum.UserInputType.Touch;
end;

function u1.new(p4, u5, p6) -- Line: 26
    -- upvalues: u1 (copy), UserInputService (copy)
    local v7 = p6 or {};
    local u8 = setmetatable({}, u1);
    u8._handle = p4;
    u8._target = u5;
    u8._screenGui = v7.ScreenGui;
    u8._keepVisible = v7.KeepVisible or 16;
    u8._home = u5.Position;
    u8._offset = Vector2.zero;
    u8._connections = {};
    local u9 = false;
    local zero = Vector2.zero;
    local zero2 = Vector2.zero;
    p4.Active = true;

    local function apply() -- Line: 46
        -- upvalues: u8 (copy), u5 (copy)
        local _offset = u8._offset;
        local v10;

        if u8._screenGui then
            v10 = u8._screenGui.AbsoluteSize;
        else
            v10 = u5.Parent.AbsoluteSize;
        end;

        local AbsoluteSize = u5.AbsoluteSize;
        local AnchorPoint = u5.AnchorPoint;
        local _home = u8._home;
        local _keepVisible = u8._keepVisible;
        local v11 = v10.X * _home.X.Scale + _home.X.Offset - AnchorPoint.X * AbsoluteSize.X;
        local v12 = v10.Y * _home.Y.Scale + _home.Y.Offset - AnchorPoint.Y * AbsoluteSize.Y;
        local v13 = Vector2.new(math.clamp(_offset.X, _keepVisible - AbsoluteSize.X - v11, v10.X - _keepVisible - v11), (math.clamp(_offset.Y, _keepVisible - AbsoluteSize.Y - v12, v10.Y - _keepVisible - v12)));
        u8._offset = v13;
        u5.Position = u8._home + UDim2.fromOffset(v13.X, v13.Y);
    end;

    table.insert(u8._connections, p4.InputBegan:Connect(function(p14) -- Line: 70
        -- upvalues: u9 (ref), zero (ref), zero2 (ref), u8 (copy)
        if p14.UserInputType ~= Enum.UserInputType.MouseButton1 and p14.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u9 = true;
        zero = Vector2.new(p14.Position.X, p14.Position.Y);
        zero2 = u8._offset;
    end));
    table.insert(u8._connections, UserInputService.InputChanged:Connect(function(p15) -- Line: 77
        -- upvalues: u9 (ref), u8 (copy), zero2 (ref), zero (ref), apply (copy)
        if not u9 or p15.UserInputType ~= Enum.UserInputType.MouseMovement and p15.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u8._offset = zero2 + (Vector2.new(p15.Position.X, p15.Position.Y) - zero);
        apply();
    end));
    table.insert(u8._connections, UserInputService.InputEnded:Connect(function(p16) -- Line: 84
        -- upvalues: u9 (ref)
        if u9 and (p16.UserInputType == Enum.UserInputType.MouseButton1 or p16.UserInputType == Enum.UserInputType.Touch) then
            u9 = false;
        end;
    end));

    return u8;
end;

function u1.Reset(p17) -- Line: 95
    p17._offset = Vector2.zero;
    p17._target.Position = p17._home;
end;

function u1.Destroy(p18) -- Line: 100
    for _, v in p18._connections do
        v:Disconnect();
    end;

    table.clear(p18._connections);
end;

return u1;