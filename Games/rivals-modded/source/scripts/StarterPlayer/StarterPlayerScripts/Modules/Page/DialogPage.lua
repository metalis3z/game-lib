-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local DialogButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DialogButton");
local DialogPage = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DialogPage");
local Pages = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Pages");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: DialogPage (copy), Pages (copy), Page (copy), u1 (copy)
    local v3 = DialogPage:Clone();
    v3.Name = p2;
    v3.Parent = Pages;
    local v4 = Page.new(p2);
    local v5 = setmetatable(v4, u1);
    v5.Container = v5.PageFrame:WaitForChild("Container");
    v5.Background = v5.Container:WaitForChild("Background");
    v5.Arrow = v5.Background:WaitForChild("Arrow");
    v5.Message = v5.Container:WaitForChild("Message");
    v5.Picture = v5.Container:WaitForChild("Picture");
    v5.ButtonsFrame = v5.Container:WaitForChild("Buttons");
    v5.HidePartyDisplay = true;
    v5._close_callback = nil;
    v5._dialog_buttons = {};
    v5._layout_order = 0;
    v5._buttons_hash = 0;
    v5._play_dialog_hash = 0;
    v5._picture_original_size = v5.Picture.Size;
    v5._dialog_actions = {};
    v5:_Init();

    return v5;
end;

function u1.PlayDialog(u6, u7) -- Line: 48
    u6._play_dialog_hash = u6._play_dialog_hash + 1;
    local _ = u6._play_dialog_hash;

    if u7.Message then
        u6:_Message(u7.Message.Picture, u7.Message.Text, u7.Message.SoundID);
    else
        u6:_Clear();
    end;

    if u7.Buttons then
        for _, v in pairs(u7.Buttons) do
            local v8 = u6:_GetButtonAction(v.NextDialog, v.DialogActionKey);
            local v9 = v.IsCloseButton and Color3.fromRGB(255, 50, 50);
            u6:_CreateButton(v.Text, v8, v9, u7.ButtonAppearDelay);
        end;
    end;

    if u7.DelayedContinue then
        task.spawn(function() -- Line: 71
            -- upvalues: u6 (copy), u7 (copy)
            local _play_dialog_hash = u6._play_dialog_hash;
            wait(u7.DelayedContinue.Delay);

            if _play_dialog_hash ~= u6._play_dialog_hash then
                return;
            end;

            u6:_GetButtonAction(u7.DelayedContinue.NextDialog)();
        end);
    end;
end;

function u1.HookDialogActionKey(p10, p11, p12) -- Line: 85
    p10._dialog_actions[p11] = p12;
end;

function u1.Open(p13, ...) -- Line: 89
    -- upvalues: Page (copy)
    Page.Open(p13, ...);
    p13:_Clear();
end;

function u1.Close(p14, ...) -- Line: 94
    -- upvalues: Page (copy)
    p14:_Clear();
    Page.Close(p14, ...);
end;

function u1._FetchDialog(p15, p16, ...) -- Line: 103
    local _is_open_hash = p15._is_open_hash;
    local success, result = pcall(p16.InvokeServer, p16, ...);

    if _is_open_hash ~= p15._is_open_hash then
        return;
    end;

    if not success then
        warn("Failed to fetch dialog, error:", result);
    end;

    if success and result then
        p15:PlayDialog(result);

        return;
    end;

    p15:CloseRequest();
end;

function u1._GetButtonAction(u17, u18, u19) -- Line: 124
    -- upvalues: ReplicatedStorage (copy)
    return function() -- Line: 125
        -- upvalues: u18 (copy), u17 (copy), u19 (copy), ReplicatedStorage (ref)
        if u18 then
            u17:PlayDialog(u18);
        else
            u17:CloseRequest();
        end;

        if u19 then
            if u17._dialog_actions[u19] then
                u17._dialog_actions[u19]();

                return;
            end;

            ReplicatedStorage.Remotes.Misc.DialogAction:FireServer(u19);
        end;
    end;
end;

function u1._CreateButton(u20, p21, p22, p23, p24) -- Line: 142
    -- upvalues: DialogButton (copy), ButtonEffect (copy)
    u20._layout_order = u20._layout_order + 1;
    local v25 = p23 or Color3.fromRGB(84, 212, 42);
    local u26 = p24 or 0;
    local u27 = DialogButton:Clone();
    u27.Button.BackgroundColor3 = v25;
    u27.Button.Container.Arrow.ImageColor3 = v25;
    u27.Button.Container.Title.Text = p21;
    u27.LayoutOrder = u20._layout_order;
    u27.Parent = u20.ButtonsFrame;
    table.insert(u20._dialog_buttons, u27);
    local Button = u27.Button;
    local Container = Button.Container;
    local Title = Container.Title;

    local function update() -- Line: 159
        -- upvalues: u27 (copy), Title (copy), Container (copy), Button (copy)
        u27.Size = UDim2.new(0, (Title.TextBounds.X + Container.AbsoluteSize.X) / Button.Size.X.Scale, 1, 0);
        Title.Position = UDim2.new(1, -u27.AbsoluteSize.X / 2 * Button.Size.X.Scale, 0.5, 0);
    end;

    Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
    Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
    Title:GetPropertyChangedSignal("TextBounds"):Connect(update);
    update();
    Button.MouseButton1Click:Connect(p22);
    ButtonEffect:Add(Button);
    task.spawn(function() -- Line: 172
        -- upvalues: u20 (copy), Button (copy), u26 (copy)
        local _buttons_hash = u20._buttons_hash;
        Button.Visible = false;
        wait(0.1 * (u20._layout_order - 1) + u26);

        if _buttons_hash ~= u20._buttons_hash then
            return;
        end;

        Button.Visible = true;
        Button.Position = UDim2.new(0.75, 0, 0.5, 0);
        Button:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.5, true);
    end);
end;

function u1._ClearButtons(p28) -- Line: 189
    for _, v in pairs(p28._dialog_buttons) do
        v:Destroy();
    end;

    p28._dialog_buttons = {};
    p28._layout_order = 0;
    p28._buttons_hash = p28._buttons_hash + 1;
end;

function u1._Message(p29, p30, p31, p32) -- Line: 199
    -- upvalues: Players (copy), Utility (copy)
    p29:_ClearButtons();
    local v33 = p30 or "";
    local v34 = p31 or "";
    p29.Message.Text = v34;
    p29.Picture.Image = v33;
    p29.Background.Visible = v34 ~= "" and true or v33 ~= "";
    p29.Arrow.Visible = v33 ~= "";

    if p29.Picture:IsDescendantOf(Players) then
        p29.Picture.Size = UDim2.new(p29._picture_original_size.X.Scale * 0.8, 0, p29._picture_original_size.Y.Scale * 1.2, 0);
        p29.Picture:TweenSize(p29._picture_original_size, "Out", "Back", 0.5, true);
    else
        p29.Picture.Size = p29._picture_original_size;
    end;

    if p32 then
        Utility:CreateSound(p32, 1, 1, script, true, 10);
    end;
end;

function u1._Clear(p35) -- Line: 222
    p35:_Message(nil, nil, nil);
end;

function u1._Setup(u36) -- Line: 226
    function u36._close_callback() -- Line: 227
        -- upvalues: u36 (copy)
        u36:CloseRequest();
    end;
end;

function u1._Init(p37) -- Line: 232
    p37:_Setup();
    p37:_Clear();
end;

return u1;