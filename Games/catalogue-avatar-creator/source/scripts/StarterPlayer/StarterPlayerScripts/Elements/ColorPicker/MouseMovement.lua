-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.CallbackFunc = p2;
    v3.Connected = false;

    return v3;
end;

function u1.Connect(u4, ...) -- Line: 14
    -- upvalues: UserInputService (copy)
    if u4.Connected then
        return;
    end;

    u4.Connected = true;
    local u5 = { ... };
    u4.CallbackFunc(...);
    u4._mouseMovement = UserInputService.InputChanged:Connect(function(p6) -- Line: 21
        -- upvalues: u4 (copy), u5 (copy)
        if p6.UserInputType == Enum.UserInputType.MouseMovement or p6.UserInputType == Enum.UserInputType.Touch then
            u4.CallbackFunc(table.unpack(u5));
        end;
    end);
    u4._mouseUp = UserInputService.InputEnded:Connect(function(p7) -- Line: 27
        -- upvalues: u4 (copy)
        if p7.UserInputType == Enum.UserInputType.MouseButton1 or p7.UserInputType == Enum.UserInputType.Touch then
            if u4.DisconnectCallback then
                u4.DisconnectCallback();
            end;

            u4:Disconnect();
        end;
    end);
end;

function u1.Disconnect(p8) -- Line: 38
    p8.Connected = false;

    if p8._mouseMovement then
        p8._mouseMovement:Disconnect();
        p8._mouseMovement = nil;
    end;

    if p8._mouseUp then
        p8._mouseUp:Disconnect();
        p8._mouseUp = nil;
    end;
end;

function u1.OnDisconnect(p9, p10) -- Line: 51
    p9.DisconnectCallback = p10;
end;

function u1.Destroy(p11) -- Line: 55
    p11:Disconnect();
end;

return u1;