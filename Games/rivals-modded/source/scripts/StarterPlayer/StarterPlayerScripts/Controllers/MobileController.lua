-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._models = {};
    v2:_Init();

    return v2;
end;

function u1._FixPermanentKeyboardBug(p3) -- Line: 33
    -- upvalues: Utility (copy), Players (copy)
    if not Utility:IsTextBoxFocused() then
        return;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Parent = Players.LocalPlayer.PlayerGui;
    local TextBox = Instance.new("TextBox");
    TextBox.BackgroundTransparency = 1;
    TextBox.Text = "";
    TextBox.PlaceholderText = "";
    TextBox.TextTransparency = 1;
    TextBox.Parent = ScreenGui;
    task.defer(function() -- Line: 48
        -- upvalues: TextBox (copy), ScreenGui (copy)
        TextBox:CaptureFocus();
        task.defer(function() -- Line: 51
            -- upvalues: TextBox (ref), ScreenGui (ref)
            TextBox:ReleaseFocus();
            TextBox:Destroy();
            ScreenGui:Destroy();
        end);
    end);
end;

function u1._UpdatePrompts(p4) -- Line: 59
    -- upvalues: CONSTANTS (copy), ControlsController (copy)
    for i, v in pairs(p4._models) do
        local v5;

        if CONSTANTS.IS_MOBILE_SERVER or ControlsController.CurrentControls == "Touch" then
            v5 = i;
        else
            v5 = nil;
        end;

        v.Parent = v5;
    end;
end;

function u1._PromptAdded(p6, p7) -- Line: 65
    -- upvalues: ReplicatedStorage (copy), CONSTANTS (copy)
    local Model = p7:WaitForChild("Model");
    local ProximityPrompt = Model:WaitForChild("Prompt"):WaitForChild("ProximityPrompt");
    ProximityPrompt.Triggered:Connect(function() -- Line: 69
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Misc.MobileDuelsTeleport:FireServer();
    end);
    ProximityPrompt.ActionText = CONSTANTS.IS_MOBILE_SERVER and "Leave" or "Teleport";
    p6._models[p7] = Model;
    task.defer(p6._UpdatePrompts, p6);
end;

function u1._Init(u8) -- Line: 80
    -- upvalues: Teleporting (copy), CollectionService (copy)
    Teleporting.EnabledChanged:Connect(function() -- Line: 81
        -- upvalues: u8 (copy)
        u8:_FixPermanentKeyboardBug();
    end);
    CollectionService:GetInstanceAddedSignal("LobbyMobileDuelsPrompt"):Connect(function(p9) -- Line: 85
        -- upvalues: u8 (copy)
        u8:_PromptAdded(p9);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyMobileDuelsPrompt")) do
        task.defer(u8._PromptAdded, u8, v);
    end;

    task.defer(u8._UpdatePrompts, u8);
    task.defer(u8._FixPermanentKeyboardBug, u8);
end;

return u1._new();