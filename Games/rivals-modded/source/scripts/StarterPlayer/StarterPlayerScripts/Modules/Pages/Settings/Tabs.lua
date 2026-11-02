-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local SettingTabSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingTabSlot");
local u1 = {
    { "Video", "rbxassetid://111628467664626" },
    { "Audio", "rbxassetid://77374671054355" },
    { "Game", "rbxassetid://76006565289299" },
    { "Crosshair", "rbxassetid://132790955082325" },
    { "Hotkeys", "rbxassetid://74762673547084" },
    { "Touch", "rbxassetid://123856214444472" },
    { "Account", string.format(CONSTANTS.HEADSHOT_IMAGE, Players.LocalPlayer.UserId) }
};
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 23
    -- upvalues: u2 (copy), Signal (copy)
    local v4 = setmetatable({}, u2);
    v4.Clicked = Signal.new();
    v4.Page = p3;
    v4.Frame = v4.Page.Container:WaitForChild("Tabs");
    v4.Background = v4.Frame:WaitForChild("Background");
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4._tab_frames = {};
    v4:_Init();

    return v4;
end;

function u2.SetPage(p5, p6) -- Line: 45
    for i, v in pairs(p5._tab_frames) do
        local v7 = p6 == i;
        local Title = v.Button.Title;
        local v8;

        if v7 then
            v8 = Color3.fromRGB(0, 0, 0);
        else
            v8 = Color3.fromRGB(255, 255, 255);
        end;

        Title.TextColor3 = v8;
        local UIStroke = v.Button.Title.UIStroke;
        local v9;

        if v7 then
            v9 = Color3.fromRGB(255, 255, 255);
        else
            v9 = Color3.fromRGB(0, 0, 0);
        end;

        UIStroke.Color = v9;
        v.Button.Title.UIStroke.Transparency = v7 and 0 or 0.75;
        v.Button.Background.Visible = v7;
    end;
end;

function u2._UpdateControls(p10) -- Line: 60
    -- upvalues: ControlsController (copy)
    p10._tab_frames.Touch.Visible = ControlsController.CurrentControls == "Touch";
    p10._tab_frames.Hotkeys.Visible = not p10._tab_frames.Touch.Visible;
end;

function u2._Setup(u11) -- Line: 65
    -- upvalues: u1 (copy), SettingTabSlot (copy), ButtonEffect (copy)
    for i, v in pairs(u1) do
        local table_unpack_ret, v12 = table.unpack(v);
        local v13 = SettingTabSlot:Clone();
        v13.Button.Title.Text = table_unpack_ret;
        v13.Button.Icon.Image = v12;
        v13.LayoutOrder = i;
        v13.Parent = u11.Container;
        u11._tab_frames[table_unpack_ret] = v13;
        v13.Button.MouseButton1Click:Connect(function() -- Line: 75
            -- upvalues: u11 (copy), table_unpack_ret (copy)
            u11.Clicked:Fire(table_unpack_ret);
        end);
        ButtonEffect:Add(v13.Button);

        if table_unpack_ret == "Account" then
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = v13.Button.Icon;
        end;
    end;
end;

function u2._Init(u14) -- Line: 89
    -- upvalues: ControlsController (copy)
    u14.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 90
        -- upvalues: u14 (copy)
        u14.Background.Size = UDim2.new(0, u14.Layout.AbsoluteContentSize.X, 1.25, 0);
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 94
        -- upvalues: u14 (copy)
        u14:_UpdateControls();
    end);
    u14:_Setup();
    u14:_UpdateControls();
end;

return u2;