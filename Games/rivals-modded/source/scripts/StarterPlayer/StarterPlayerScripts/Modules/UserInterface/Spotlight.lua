-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "Spotlight");
    v2._spotlight_hash = 0;
    v2._spotlight_connection = nil;
    v2._spotlight_reference = nil;
    v2._spotlight_transparency = 1;
    v2:_Init();

    return v2;
end;

function u1.GetCurrentReference(p3) -- Line: 32
    return p3._spotlight_reference;
end;

function u1.ChangeSubject(u4, p5, p6) -- Line: 36
    -- upvalues: Spring (copy), RunService (copy)
    if p6 and u4:GetCurrentReference() ~= p6 then
        return;
    end;

    u4._spotlight_hash = u4._spotlight_hash + 1;

    if u4._spotlight_connection then
        u4._spotlight_connection:Disconnect();
        u4._spotlight_connection = nil;
    end;

    if u4._spotlight_reference then
        local _spotlight_reference = u4._spotlight_reference;
        _spotlight_reference.ZIndex = _spotlight_reference.ZIndex - 1;
    end;

    u4._spotlight_reference = p5;

    if not u4._spotlight_reference then
        u4:_SetTransparency(1);

        return;
    end;

    local _spotlight_reference = u4._spotlight_reference;
    _spotlight_reference.ZIndex = _spotlight_reference.ZIndex + 1;
    u4:_SetTransparency(0.75);
    local u7 = Spring.new(u4.Frame.AbsolutePosition, 0.875, 25);
    local u8 = Spring.new(u4.Frame.AbsoluteSize, 0.875, 25);
    u4._spotlight_connection = RunService.RenderStepped:Connect(function() -- Line: 65
        -- upvalues: u7 (copy), u4 (copy), u8 (copy)
        u7.Target = u4._spotlight_reference.AbsolutePosition;
        u8.Target = u4._spotlight_reference.AbsoluteSize;
        local v9 = u7.Value - u4.Frame.Parent.AbsolutePosition;
        u4.Frame.Position = UDim2.new(0, v9.X - 8, 0, v9.Y - 8);
        u4.Frame.Size = UDim2.new(0, u8.Value.X + 16, 0, u8.Value.Y + 16);
    end);
end;

function u1._UpdateVisibility(p10) -- Line: 80
    -- upvalues: GuiService (copy)
    p10.Frame.Visible = not GuiService.MenuIsOpen;
end;

function u1._SetTransparency(u11, u12) -- Line: 84
    -- upvalues: Utility (copy)
    local _spotlight_hash = u11._spotlight_hash;
    task.spawn(function() -- Line: 87
        -- upvalues: Utility (ref), _spotlight_hash (copy), u11 (copy), u12 (copy)
        Utility:RenderstepForLoop(0, 100, 4, function(p13) -- Line: 88
            -- upvalues: _spotlight_hash (ref), u11 (ref), u12 (ref)
            if _spotlight_hash ~= u11._spotlight_hash then
                return true;
            end;

            u11._spotlight_transparency = u11._spotlight_transparency + (u12 - u11._spotlight_transparency) * (1 - (1 - p13 / 100) ^ 2);

            for _, child in pairs(u11.Frame:GetChildren()) do
                if child:IsA("ImageLabel") then
                    child.ImageTransparency = u11._spotlight_transparency;
                else
                    child.BackgroundTransparency = u11._spotlight_transparency;
                end;
            end;
        end);

        if _spotlight_hash ~= u11._spotlight_hash then
            return;
        end;

        if u12 >= 1 then
            u11.Frame.Size = UDim2.new(3, 0, 3, 0);
            u11.Frame.Position = UDim2.new(-1, 0, -1, 0);
        end;
    end);
end;

function u1._Init(u14) -- Line: 115
    -- upvalues: GuiService (copy)
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 116
        -- upvalues: u14 (copy)
        u14:_UpdateVisibility();
    end);
    u14:_UpdateVisibility();
    u14:ChangeSubject(nil);
end;

return u1._new();