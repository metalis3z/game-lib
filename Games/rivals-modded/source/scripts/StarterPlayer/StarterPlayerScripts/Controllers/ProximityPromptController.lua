-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ProximityPromptService = game:GetService("ProximityPromptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Shutdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Shutdown"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local ProximityPrompts = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ProximityPrompts");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 25
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._custom_prompt = nil;
    v2._custom_prompt_hash = 0;
    v2._custom_prompt_connections = {};
    v2:_Init();

    return v2;
end;

function u1._UpdateEnabled(p3) -- Line: 47
    -- upvalues: ProximityPromptService (copy), SpectateController (copy), MobileInputs (copy), Pages (copy), Teleporting (copy), Shutdown (copy), Queue (copy), GuiService (copy), Equipment (copy), PlayerDataController (copy)
    local v4 = not (SpectateController.CurrentDuelSubject or MobileInputs.EditorEnabled or (Pages.PageSystem.CurrentPage or Teleporting.Enabled) or (Shutdown.Enabled or Queue:IsVisible() or (GuiService.MenuIsOpen or Equipment.IsOpen))) and not PlayerDataController:GetSetting("Hide HUD");
    ProximityPromptService.Enabled = v4;
end;

function u1._Cleanup(p5) -- Line: 59
    -- upvalues: BetterDebris (copy), Players (copy)
    p5._custom_prompt_hash = p5._custom_prompt_hash + 1;

    for _, v in pairs(p5._custom_prompt_connections) do
        v:Disconnect();
    end;

    p5._custom_prompt_connections = {};

    if p5._custom_prompt then
        BetterDebris:AddItem(p5._custom_prompt, 0.15);

        if p5._custom_prompt:FindFirstChild("Button") and p5._custom_prompt:IsDescendantOf(Players) then
            p5._custom_prompt.Button:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.25, true);
        end;

        p5._custom_prompt = nil;
    end;
end;

function u1._Create(u6, u7) -- Line: 79
    -- upvalues: ControlsController (copy), ProximityPrompts (copy), Players (copy), WeaponStatusHandler (copy), ItemLibrary (copy), ButtonEffect (copy)
    u6:_Cleanup();
    u7:SetAttribute("ClickablePrompt", u7.ClickablePrompt);
    u7.ClickablePrompt = ControlsController.CurrentControls == "Touch" and true or u7:GetAttribute("ClickablePrompt");
    u6._custom_prompt_hash = u6._custom_prompt_hash + 1;
    local _custom_prompt_hash = u6._custom_prompt_hash;
    local v8 = ProximityPrompts[u7:GetAttribute("Style") or "Default"];
    u6._custom_prompt = v8:Clone();
    u6._custom_prompt.Name = "ProximityPrompt - " .. v8.Name;
    u6._custom_prompt.Button.Inputs.MouseKeyboard.KeyText.Text = u7.KeyboardKeyCode.Name;
    u6._custom_prompt.Button.Inputs.Gamepad.Container:SetAttribute("EnumType", "KeyCode");
    u6._custom_prompt.Button.Inputs.Gamepad.Container:SetAttribute("EnumName", u7.GamepadKeyCode.Name);
    u6._custom_prompt.Button.Inputs.Gamepad.Container:AddTag("UIKeybindContainer");
    u6._custom_prompt.Button.Interactable = u7.ClickablePrompt;
    u6._custom_prompt.Adornee = u7.Parent;
    u6._custom_prompt.Parent = Players.LocalPlayer.PlayerGui;

    local function update() -- Line: 99
        -- upvalues: u6 (copy), u7 (copy), WeaponStatusHandler (ref), ItemLibrary (ref)
        u6._custom_prompt.Button.ObjectText.Text = u7.ObjectText;
        u6._custom_prompt.Button.ActionText.Text = u7.ActionText;
        WeaponStatusHandler:ClearStatusElements(u6._custom_prompt.Button.ObjectText);
        WeaponStatusHandler:ApplyItemStatusToText(u6._custom_prompt.Button.ObjectText, ItemLibrary.Items[u7.ObjectText] and ItemLibrary.Items[u7.ObjectText].Status);
    end;

    local _custom_prompt_connections = u6._custom_prompt_connections;
    local PropertyChangedSignal = u7:GetPropertyChangedSignal("ObjectText");
    table.insert(_custom_prompt_connections, PropertyChangedSignal:Connect(update));
    local _custom_prompt_connections2 = u6._custom_prompt_connections;
    local PropertyChangedSignal2 = u7:GetPropertyChangedSignal("ActionText");
    table.insert(_custom_prompt_connections2, PropertyChangedSignal2:Connect(update));
    update();
    u6._custom_prompt.Button.Size = UDim2.new(u6._custom_prompt.Button.Size.X.Scale * 0.5, u6._custom_prompt.Button.Size.X.Offset * 0.5, u6._custom_prompt.Button.Size.Y.Scale * 0.5, u6._custom_prompt.Button.Size.Y.Offset * 0.5);
    u6._custom_prompt.Button:TweenSize(v8.Button.Size, "Out", "Quint", 0.25, true, function() -- Line: 111
        -- upvalues: u6 (copy), _custom_prompt_hash (copy), u7 (copy), ButtonEffect (ref)
        if u6._custom_prompt_hash ~= _custom_prompt_hash or not u7.ClickablePrompt then
            return;
        end;

        u6._custom_prompt.Button.MouseButton1Down:Connect(function() -- Line: 116
            -- upvalues: u7 (ref)
            u7:InputHoldBegin();
        end);
        u6._custom_prompt.Button.MouseButton1Up:Connect(function() -- Line: 120
            -- upvalues: u7 (ref)
            u7:InputHoldEnd();
        end);
        u6._custom_prompt.Button.MouseLeave:Connect(function() -- Line: 124
            -- upvalues: u7 (ref)
            u7:InputHoldEnd();
        end);
        ButtonEffect:Add(u6._custom_prompt.Button, nil, {
            DontReposition = true
        });
    end);
    u6:_UpdateEnabled();
end;

function u1._Init(u9) -- Line: 134
    -- upvalues: ProximityPromptService (copy), Pages (copy), Teleporting (copy), Shutdown (copy), Queue (copy), SpectateController (copy), MobileInputs (copy), GuiService (copy), Equipment (copy), PlayerDataController (copy)
    ProximityPromptService.PromptShown:Connect(function(p10) -- Line: 135
        -- upvalues: u9 (copy)
        if p10.Style ~= Enum.ProximityPromptStyle.Custom then
            return;
        end;

        u9:_Create(p10);
    end);
    ProximityPromptService.PromptHidden:Connect(function(p11) -- Line: 143
        -- upvalues: u9 (copy)
        if p11.Style ~= Enum.ProximityPromptStyle.Custom then
            return;
        end;

        u9:_Cleanup();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 151
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 155
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 159
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    Shutdown.EnabledChanged:Connect(function() -- Line: 163
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 167
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 171
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 175
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 179
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    Equipment.Opened:Connect(function() -- Line: 183
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    PlayerDataController:GetSettingChangedSignal("Hide HUD"):Connect(function() -- Line: 187
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    u9:_UpdateEnabled();
end;

return u1._new();