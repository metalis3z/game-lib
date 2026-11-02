-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local KeybindSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("KeybindSlot");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 16
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._objects = {};
    v2._generate_hashes = {};
    v2:_Init();

    return v2;
end;

function u1._ObjectRemoved(p3, p4) -- Line: 37
    p3._generate_hashes[p4] = (p3._generate_hashes[p4] or 0) + 1;

    if p3._objects[p4] then
        p3._objects[p4].Slot:Destroy();
        p3._objects[p4] = nil;
    end;
end;

function u1._ObjectAdded(p5, p6) -- Line: 46
    -- upvalues: Players (copy), ReplicatedStorage (copy), InputLibrary (copy), KeybindSlot (copy)
    p5:_ObjectRemoved(p6);

    if not (p6:IsDescendantOf(Players.LocalPlayer.PlayerGui) or p6:IsDescendantOf(workspace) or (p6:IsDescendantOf(ReplicatedStorage) or p6:IsDescendantOf(Players.LocalPlayer.PlayerScripts.Assets.Temp))) then
        return;
    end;

    local v7 = p5._generate_hashes[p6];
    local Attribute = p6:GetAttribute("InputName");
    local Attribute2 = p6:GetAttribute("EnumType");
    local Attribute3 = p6:GetAttribute("EnumName");
    local v8, v9, v10, v11;

    if Attribute2 and (Attribute2 ~= "" and (Attribute3 and Attribute3 ~= "")) then
        v8, v9, v10 = InputLibrary:GetInputIcons(Attribute2, Attribute3);
        v11 = Enum[Attribute2][Attribute3];
    else
        if not Attribute or Attribute == "" then
            return;
        end;

        v8, v9, v10 = InputLibrary:GetInputIconsByInputName(Attribute);
        v11 = InputLibrary:FindFirstEnum(Attribute);
    end;

    if not v11 then
        return;
    end;

    if v7 ~= p5._generate_hashes[p6] then
        return;
    end;

    local v12 = KeybindSlot:Clone();
    v12.Icon.Image = v8;
    v12.Icon.Title.Text = v10;
    v12.Name = v7;
    v12.Parent = p6;
    p5._objects[p6] = {
        Enum = v11,
        Icon = v8,
        PressedIcon = v9,
        InputString = v10,
        Slot = v12
    };
end;

function u1._AddAllObjects(p13) -- Line: 97
    -- upvalues: CollectionService (copy)
    for _, v in pairs(CollectionService:GetTagged("UIKeybindContainer")) do
        p13:_ObjectAdded(v);
    end;
end;

function u1._Init(u14) -- Line: 103
    -- upvalues: CollectionService (copy), UserInputService (copy), ControlsController (copy), SettingsLibrary (copy), PlayerDataController (copy)
    CollectionService:GetInstanceRemovedSignal("UIKeybindContainer"):Connect(function(p15) -- Line: 104
        -- upvalues: u14 (copy)
        u14:_ObjectRemoved(p15);
    end);
    CollectionService:GetInstanceAddedSignal("UIKeybindContainer"):Connect(function(p16) -- Line: 108
        -- upvalues: u14 (copy)
        u14:_ObjectAdded(p16);
    end);
    UserInputService.InputBegan:Connect(function(p17) -- Line: 112
        -- upvalues: u14 (copy)
        for _, v in pairs(u14._objects) do
            if v.Enum == p17.KeyCode or v.Enum == p17.UserInputType then
                v.Slot.Icon.Image = v.PressedIcon;
                v.Slot.Icon.Title.Position = UDim2.new(0.5, 0, 0.525, 0);
            end;
        end;
    end);
    UserInputService.InputEnded:Connect(function(p18) -- Line: 121
        -- upvalues: u14 (copy)
        for _, v in pairs(u14._objects) do
            if v.Enum == p18.KeyCode or v.Enum == p18.UserInputType then
                v.Slot.Icon.Image = v.Icon;
                v.Slot.Icon.Title.Position = UDim2.new(0.5, 0, 0.45, 0);
            end;
        end;
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 130
        -- upvalues: u14 (copy)
        u14:_AddAllObjects();
    end);

    for i, v in pairs(SettingsLibrary.Info) do
        if v.InputType == "Hotkey" then
            PlayerDataController:GetSettingChangedSignal(i):Connect(function() -- Line: 136
                -- upvalues: u14 (copy)
                u14:_AddAllObjects();
            end);
        end;
    end;

    task.spawn(u14._AddAllObjects, u14);
end;

return u1._new();