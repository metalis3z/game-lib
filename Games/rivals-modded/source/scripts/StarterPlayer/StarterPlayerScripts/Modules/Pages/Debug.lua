-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DebugLibrary = require(ReplicatedStorage.Modules.DebugLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local DebugController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DebugController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local EmptySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EmptySlot");
local Settings = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.SettingObjects = {};
    v3.HidePartyDisplay = true;
    v3._open_animation_disabled = true;
    v3:_Init();

    return v3;
end;

function u1._Setup(u4) -- Line: 47
    -- upvalues: Settings (copy), DebugController (copy), EmptySlot (copy), DebugLibrary (copy), PlayerDataController (copy)
    local u5 = 0;

    local function create_command(u6) -- Line: 51
        -- upvalues: Settings (ref), DebugController (ref), u5 (ref), u4 (copy)
        local u7 = require(Settings:WaitForChild(u6.InputType)).new(u6);
        u7.Replicate:Connect(function() -- Line: 55
            -- upvalues: DebugController (ref), u6 (copy), u7 (copy)
            DebugController:Command(u6.Name, u7.Value);
        end);
        u7.SettingFrame.LayoutOrder = u5;
        u7.SettingFrame.Parent = u4.Container;
        u4.SettingObjects[u6.Name] = u7;
        u5 = u5 + 1;
    end;

    local function create_empty_slots(p8) -- Line: 65
        -- upvalues: u5 (ref), EmptySlot (ref), u4 (copy)
        local v9 = p8 or 0;

        for i = 1, math.max(0, v9 - u5) + 2 - (v9 >= u5 and 0 or (u5 - 1) % 2 + 1) do
            local v10 = EmptySlot:Clone();
            v10.LayoutOrder = u5;
            v10.Parent = u4.Container;
            u5 = u5 + 1;
            local _ = i;
        end;
    end;

    local v11 = false;

    for _, v in pairs(DebugLibrary.Order) do
        if DebugLibrary:IsAuthorizedToUseCommand(v.Name, PlayerDataController:Get("PermissionsRoles")) then
            if v.InputType == "Divider" then
                if v11 then
                    create_empty_slots();
                    local v12 = v;

                    for i = 1, u5 % 2 + 2 do
                        create_command(v12);
                        local _ = i;
                    end;
                end;
            else
                create_command(v);
                v11 = true;
            end;
        end;
    end;

    create_empty_slots(16);
end;

function u1._Init(u13) -- Line: 98
    -- upvalues: ButtonEffect (copy)
    u13.CloseButton.MouseButton1Click:Connect(function() -- Line: 99
        -- upvalues: u13 (copy)
        u13:CloseRequest();
    end);
    u13.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 103
        -- upvalues: u13 (copy)
        u13.List.CanvasSize = UDim2.new(0, 0, 0, u13.Layout.AbsoluteContentSize.Y);
    end);
    u13:_Setup();
    ButtonEffect:Add(u13.CloseButton);
end;

return u1._new();