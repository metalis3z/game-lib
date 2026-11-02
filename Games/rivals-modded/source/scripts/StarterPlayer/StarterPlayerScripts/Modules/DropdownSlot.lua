-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local DropdownButton = Players.LocalPlayer.PlayerScripts.UserInterface.DropdownButton;
local DropdownSlot = Players.LocalPlayer.PlayerScripts.UserInterface.DropdownSlot;
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 21
    -- upvalues: u1 (copy), Signal (copy), DropdownSlot (copy)
    local v5 = typeof(p2) == "Instance";
    assert(v5, "Argument 1 invalid, expected a valid UI element");
    local v6 = typeof(p3) == "table";
    assert(v6, "Argument 2 invalid, expected a table");
    local v7 = setmetatable({}, u1);
    v7.Selected = Signal.new();
    v7.Frame = DropdownSlot:Clone();
    v7.Background = v7.Frame:WaitForChild("Background");
    v7.List = v7.Frame:WaitForChild("List");
    v7.Container = v7.List:WaitForChild("Container");
    v7.Layout = v7.Container:WaitForChild("Layout");
    v7._destroyed = false;
    v7._reference = p2;
    v7._options = p3;
    v7._max_options = p4 or 5;
    v7._connections = {};
    v7._selected = false;
    v7:_Init();

    return v7;
end;

function u1.Cancel(p8) -- Line: 51
    p8:_Select(nil);
end;

function u1.Destroy(p9) -- Line: 55
    if p9._destroyed then
        return;
    end;

    p9._destroyed = true;

    for _, v in pairs(p9._connections) do
        v:Disconnect();
    end;

    p9.Selected:Destroy();
    pcall(p9.Frame.Destroy, p9.Frame);
end;

function u1._Select(p10, ...) -- Line: 75
    if p10._selected then
        return;
    end;

    p10._selected = true;
    p10.Selected:Fire(...);
end;

function u1._Update(p11) -- Line: 84
    -- upvalues: UILibrary (copy)
    local v12 = UILibrary:ScreenPointToPosition(p11._reference.AbsolutePosition);
    local AbsoluteSize = p11._reference.AbsoluteSize;
    local v13 = AbsoluteSize.Y / AbsoluteSize.X;
    local Frame = p11.Frame;
    local UDim2_new = UDim2.new;
    local X = v12.X;
    local Y = v12.Y;
    local math_max_ret = math.max(20, UILibrary.MainGui.AbsoluteSize.Y + UILibrary.MainGui.AbsolutePosition.Y - p11.Frame.AbsoluteSize.Y - 20);
    Frame.Position = UDim2_new(0, X, 0, (math.clamp(Y, 20, math_max_ret)));
    p11.Frame.Size = UDim2.new(0, AbsoluteSize.X, 0, AbsoluteSize.Y);
    p11.Container.Size = UDim2.new(1, 0, v13, 0);
end;

function u1._Setup(u14) -- Line: 94
    -- upvalues: DropdownButton (copy), ButtonEffect (copy), WeaponStatusHandler (copy), ItemLibrary (copy), UILibrary (copy)
    u14.Background.Size = UDim2.new(1, 10, math.min(u14._max_options, #u14._options), 10);
    u14.List.Size = UDim2.new(1, 0, u14._max_options, 0);
    u14.Layout.CellSize = UDim2.new(1, 0, 1, 0);

    for _, v in pairs(u14._options) do
        local v15 = tostring(v);
        local u16 = DropdownButton:Clone();
        u16.Button.Title.Text = v15;
        u16.Parent = u14.Container;
        ButtonEffect:Add(u16.Button, nil, {
            ReleaseRatio = UDim2.new(0, -3, 0, -3),
            HoverRatio = UDim2.new(0, -3, 0, -3),
            PressRatio = UDim2.new(0, -10, 0, -10)
        });
        WeaponStatusHandler:ApplyItemStatusToText(u16.Button.Title, ItemLibrary.Items[v15] and ItemLibrary.Items[v15].Status);
        u16.Button.MouseButton1Click:Connect(function() -- Line: 108
            -- upvalues: u14 (copy), v (copy)
            u14:_Select(v);
        end);

        local function hover(p17) -- Line: 112
            -- upvalues: u16 (copy)
            u16.Button.Hovering.Visible = p17;
            u16.Button.Title.TextColor3 = p17 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        end;

        u16.MouseEnter:Connect(function() -- Line: 117
            -- upvalues: u16 (copy)
            u16.Button.Hovering.Visible = true;
            u16.Button.Title.TextColor3 = Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        end);
        u16.MouseLeave:Connect(function() -- Line: 121
            -- upvalues: u16 (copy)
            u16.Button.Hovering.Visible = false;
            u16.Button.Title.TextColor3 = Color3.fromRGB(0, 0, 0);
        end);
        u16.Button.Hovering.Visible = false;
        u16.Button.Title.TextColor3 = Color3.fromRGB(0, 0, 0);
    end;

    u14.Frame.Parent = UILibrary.MainGui;
end;

function u1._Init(u18) -- Line: 131
    -- upvalues: Players (copy), UserInputService (copy), UILibrary (copy)
    u18.Selected:Connect(function() -- Line: 132
        -- upvalues: u18 (copy)
        task.defer(u18.Destroy, u18);
    end);
    u18.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 136
        -- upvalues: u18 (copy)
        u18.List.CanvasSize = UDim2.new(0, 0, 0, u18.Layout.AbsoluteContentSize.Y);
    end);
    u18.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 140
        -- upvalues: u18 (copy)
        u18:_Update();
    end);
    table.insert(u18._connections, u18._reference.AncestryChanged:Connect(function() -- Line: 144
        -- upvalues: Players (ref), u18 (copy)
        if not (Players.LocalPlayer:FindFirstChild("PlayerGui") and u18._reference:IsDescendantOf(Players.LocalPlayer.PlayerGui)) then
            u18.Selected:Fire(nil);
        end;
    end));
    local _connections = u18._connections;
    local PropertyChangedSignal = u18._reference:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(_connections, PropertyChangedSignal:Connect(function() -- Line: 150
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
    local _connections2 = u18._connections;
    local PropertyChangedSignal2 = u18._reference:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(_connections2, PropertyChangedSignal2:Connect(function() -- Line: 154
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
    table.insert(u18._connections, UserInputService.InputBegan:Connect(function(p19, p20) -- Line: 158
        -- upvalues: UILibrary (ref), u18 (copy)
        if p19.UserInputType ~= Enum.UserInputType.MouseButton1 and (p19.UserInputType ~= Enum.UserInputType.Touch and p19.KeyCode ~= Enum.KeyCode.ButtonA) then
            return;
        end;

        if not UILibrary:IsMouseWithinBounds(u18.Background.AbsolutePosition, u18.Background.AbsoluteSize) then
            u18.Selected:Fire(nil);
        end;
    end));
    u18:_Setup();
    u18:_Update();
end;

return u1;