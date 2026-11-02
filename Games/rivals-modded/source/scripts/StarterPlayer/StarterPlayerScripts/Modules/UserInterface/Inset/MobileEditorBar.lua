-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local InsetButtonsBar = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("InsetButtonsBar"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local InsetBarButtonShareBubble = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetBarButtonShareBubble");
local u1 = {};
local u2 = { { "Close", "Finish editing", "rbxassetid://108220438104376" }, { "Settings", "Edit your settings", "rbxassetid://14641612286" }, { "Reset", "Double tap to reset this layout", "rbxassetid://81857929131936" }, { "Share", "Share & import this layout", "rbxassetid://13733474711" } };
local u3 = {};
u3.__index = u3;

function u3.new(p4) -- Line: 27
    -- upvalues: u3 (copy), InsetButtonsBar (copy), UILibrary (copy), Signal (copy), InsetBarButtonShareBubble (copy)
    local v5 = setmetatable({}, u3);
    v5.Inset = p4;
    v5.Bar = InsetButtonsBar.new(UILibrary.BUTTON_BACKGROUND_TRANSPARENCY, UILibrary.BUTTON_BACKGROUND_COLOR, UILibrary.BUTTON_ICON_COLOR);
    v5._last_reset_click = 0;
    v5._reset_button_hash = 0;
    v5._interruption_internal = Signal.new();
    v5._share_bubble_frame = InsetBarButtonShareBubble:Clone();
    v5._was_from_settings = false;
    v5:_Init();

    return v5;
end;

function u3.SetVisible(p6, p7, p8, p9) -- Line: 48
    -- upvalues: MobileInputs (copy)
    local v10;

    if p7 then
        v10 = p6._was_from_settings or p9;
    else
        v10 = false;
    end;

    p6._was_from_settings = v10;
    p6.Bar.Buttons.Close.Frame.Visible = not p6._was_from_settings;
    p6.Bar.Frame.Visible = p7;
    p6.Bar.Frame.Size = p8 or p6.Bar.Frame.Size;
    p6.Bar:Toggle(true);
    p6:_CloseButtonAnimation();
    MobileInputs.EditorLogic:SetEnabled(p7);

    if not p7 then
        p6._interruption_internal:Fire();
    end;
end;

function u3._UpdateShareBubblePosition(p11) -- Line: 68
    p11._share_bubble_frame.Position = UDim2.new(0, p11.Bar.Buttons.Share.Frame.AbsolutePosition.X + p11.Bar.Buttons.Share.Frame.AbsoluteSize.X / 2 - p11.Bar.Frame.AbsolutePosition.X, 0.99, 0);
end;

function u3._CloseButtonAnimation(p12) -- Line: 74
    -- upvalues: Players (copy)
    local Close = p12.Bar.Buttons.Close;

    if not Close.Frame:IsDescendantOf(Players) then
        Close.Frame.Button.Icon.Size = UDim2.new(0.5, 0, 0.5, 0);

        return;
    end;

    Close.Frame.Button.Icon.Size = UDim2.new(0, 0, 0, 0);
    Close.Frame.Button.Icon:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
end;

function u3._UpdateProfileButtons(p13) -- Line: 85
    -- upvalues: PlayerDataController (copy)
    local v14 = PlayerDataController:Get("MobileButtonSettings");
    local v15 = PlayerDataController:Get("SettingsProfile");

    for i, _ in pairs(v14) do
        local v16 = v15 == i;
        local v17 = p13.Bar.Buttons["Profile" .. i];
        v17.Frame.Button.IsSelected.Visible = v16;
        v17.Frame.Button.Title.TextColor3 = v16 and p13.Bar:GetBackgroundColor() or p13.Bar:GetVisualColor();
        v17.Frame.Button.Icon.ImageColor3 = v16 and p13.Bar:GetBackgroundColor() or p13.Bar:GetVisualColor();
    end;
end;

function u3._Setup(u18) -- Line: 99
    -- upvalues: u2 (copy), PlayerDataController (copy), MobileInputs (copy), u1 (copy), SettingsLibrary (copy), SettingsController (copy), Pages (copy), Utility (copy)
    for i, v in pairs(u2) do
        u18.Bar:CreateButton(i, table.unpack(v));
    end;

    local v19 = PlayerDataController:Get("MobileButtonSettings");

    for i, _ in pairs(v19) do
        local v20 = u18.Bar:CreateButton(#u2 + i, "Profile" .. i, "Switch to layout #" .. i, i);
        local Frame = Instance.new("Frame");
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Size = UDim2.new(0.75, 0, 0.75, 0);
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
        Frame.ZIndex = 0;
        Frame.Name = "IsSelected";
        Frame.BackgroundColor3 = u18.Bar:GetVisualColor();
        Frame.Parent = v20.Frame.Button;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame;
        v20.Clicked:Connect(function() -- Line: 122
            -- upvalues: MobileInputs (ref), i (copy)
            MobileInputs:SwitchProfile(i);
        end);
    end;

    for i, v in pairs(u1) do
        local u21 = SettingsLibrary.Info[v];
        local u22 = u18.Bar:CreateButton(#u2 + #v19 + i, "Settings" .. i, nil, u21.Image);
        u22.Clicked:Connect(function() -- Line: 132
            -- upvalues: SettingsController (ref), v (copy), PlayerDataController (ref)
            SettingsController:ChangeSetting(v, not PlayerDataController:GetSetting(v));
        end);
        local u23 = 0;

        local function update_value(p24) -- Line: 138
            -- upvalues: u18 (copy), v (copy), u23 (ref), PlayerDataController (ref), u22 (copy), u21 (copy)
            u18._interruption_internal:Fire(v);
            u23 = u23 + 1;
            local Setting = PlayerDataController:GetSetting(v);
            u22.Frame.Button.Icon.ImageColor3 = Setting and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 50, 50);
            local v25;

            if p24 then
                v25 = string.format("%s <font weight=\"900\" color=\"rgb(%s)\">%s</font>", u21.DisplayName, Setting and "100,255,50" or "255,50,50", Setting and "ON" or "OFF");
            else
                v25 = nil;
            end;

            u22:PlayBubbleEffect(v25);
        end;

        PlayerDataController:GetSettingChangedSignal(v):Connect(function() -- Line: 149
            -- upvalues: update_value (copy)
            update_value(true);
        end);
        update_value(false);
        u18._interruption_internal:Connect(function(p26) -- Line: 155
            -- upvalues: v (copy), u22 (copy)
            if p26 ~= v then
                u22:PlayBubbleEffect(nil);
            end;
        end);
    end;

    local function close_bar() -- Line: 162
        -- upvalues: u18 (copy)
        u18:SetVisible(false);
        u18.Inset.MainBar:SetVisible(true, u18.Bar.Frame.Size);
    end;

    u18.Bar.Buttons.Close.Clicked:Connect(function() -- Line: 168
        -- upvalues: u18 (copy)
        u18:SetVisible(false);
        u18.Inset.MainBar:SetVisible(true, u18.Bar.Frame.Size);
    end);
    u18.Bar.Buttons.Settings.Clicked:Connect(function() -- Line: 172
        -- upvalues: u18 (copy), Pages (ref)
        u18:SetVisible(false);
        u18.Inset.MainBar:SetVisible(true, u18.Bar.Frame.Size);
        Pages.PageSystem:OpenPage("Settings", true);
        Pages.PageSystem:WaitForPage("Settings"):SetPage("Touch");
    end);
    u18.Bar.Buttons.Reset.Clicked:Connect(function() -- Line: 178
        -- upvalues: u18 (copy), Utility (ref), MobileInputs (ref)
        if tick() > u18._last_reset_click + 0.5 then
            u18._last_reset_click = tick();

            return;
        end;

        local v27 = u18;
        v27._reset_button_hash = v27._reset_button_hash + 1;
        local _reset_button_hash = u18._reset_button_hash;
        task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 5, function(p28) -- Line: 187
            -- upvalues: u18 (ref), _reset_button_hash (copy)
            if u18._reset_button_hash ~= _reset_button_hash then
                return true;
            end;

            u18.Bar.Buttons.Reset.Frame.Button.Icon.Rotation = -360 * (1 - (1 - (1 - p28 / 100) ^ 3));
        end);
        MobileInputs.EditorLogic:ResetLayout();
    end);
    u18.Bar.Buttons.Share.Clicked:Connect(function() -- Line: 200
        -- upvalues: u18 (copy), MobileInputs (ref), PlayerDataController (ref)
        u18._share_bubble_frame.Import.Box.Text = "";
        u18._share_bubble_frame.Export.Text = MobileInputs.Buttons:EncryptProfile();
        u18._share_bubble_frame.ExportTitle.Text = "Share layout #" .. PlayerDataController:Get("SettingsProfile") .. " by copying this: ";
        u18._share_bubble_frame.Visible = true;
        u18._interruption_internal:Fire("Share");
    end);
    u18.Bar.Buttons.Share.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 208
        -- upvalues: u18 (copy)
        u18:_UpdateShareBubblePosition();
    end);
    u18.Bar.Buttons.Share.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 212
        -- upvalues: u18 (copy)
        u18:_UpdateShareBubblePosition();
    end);
    u18._interruption_internal:Connect(function(p29) -- Line: 216
        -- upvalues: u18 (copy)
        if p29 ~= "Share" then
            u18._share_bubble_frame.Visible = false;
        end;
    end);
    u18._share_bubble_frame.Parent = u18.Bar.Frame;
    u18.Bar.Frame.Parent = u18.Inset.LeftButtonsFrame;
end;

function u3._Init(u30) -- Line: 226
    -- upvalues: MobileInputs (copy), PlayerDataController (copy), ButtonEffect (copy)
    u30.Bar.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 227
        -- upvalues: u30 (copy)
        u30:_UpdateShareBubblePosition();
    end);
    u30._share_bubble_frame.Close.MouseButton1Click:Connect(function() -- Line: 231
        -- upvalues: u30 (copy)
        u30._share_bubble_frame.Visible = false;
    end);
    u30._share_bubble_frame.Import.Button.MouseButton1Click:Connect(function() -- Line: 235
        -- upvalues: MobileInputs (ref), u30 (copy)
        MobileInputs.EditorLogic:ImportProfile(u30._share_bubble_frame.Import.Box.Text);
    end);
    PlayerDataController:GetDataChangedSignal("MobileButtonSettings"):Connect(function() -- Line: 239
        -- upvalues: u30 (copy)
        u30:_UpdateProfileButtons();
    end);
    PlayerDataController:GetDataChangedSignal("SettingsProfile"):Connect(function() -- Line: 243
        -- upvalues: u30 (copy)
        u30:_UpdateProfileButtons();
    end);
    u30:_Setup();
    u30:_UpdateProfileButtons();
    u30:_UpdateShareBubblePosition();
    u30:SetVisible(false);
    ButtonEffect:Add(u30._share_bubble_frame.Import.Button, true);
end;

return u3;