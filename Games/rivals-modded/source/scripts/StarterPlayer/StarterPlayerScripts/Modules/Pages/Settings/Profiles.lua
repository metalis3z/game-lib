-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local SettingsProfileSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingsProfileSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.Clicked = Signal.new();
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Profiles");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.ShareFrame = v3.Container:WaitForChild("Share");
    v3.ShareButton = v3.ShareFrame:WaitForChild("Button");
    v3.ShareBubbleFrame = v3.ShareFrame:WaitForChild("Bubble");
    v3.ShareCloseButton = v3.ShareBubbleFrame:WaitForChild("Close");
    v3.ShareExportBox = v3.ShareBubbleFrame:WaitForChild("Export");
    v3.ShareExportSectionBox = v3.ShareBubbleFrame:WaitForChild("ExportSection");
    v3.ShareExportSectionTitle = v3.ShareBubbleFrame:WaitForChild("ExportSectionTitle");
    v3.ShareImportFrame = v3.ShareBubbleFrame:WaitForChild("Import");
    v3.ShareImportButton = v3.ShareImportFrame:WaitForChild("Button");
    v3.ShareImportButtonTitle = v3.ShareImportButton:WaitForChild("Title");
    v3.ShareImportButtonSection = v3.ShareImportButton:WaitForChild("Section");
    v3.ShareImportBox = v3.ShareImportFrame:WaitForChild("Box");
    v3._slots = {};
    v3._update_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.SetPage(p4) -- Line: 54
    p4:_SetShareBubbleVisible(false);
end;

function u1.Open(p5) -- Line: 58
    p5:_SetShareBubbleVisible(false);
end;

function u1._ImportSettings(p6) -- Line: 66
    -- upvalues: EnumLibrary (copy), Utility (copy), SettingsController (copy)
    local v7, v8 = EnumLibrary:DecryptTable(p6.ShareImportBox.Text);

    if not v7 then
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    SettingsController:ChangeSettings(v8);
    p6:_SetShareBubbleVisible(false);
end;

function u1._GetBulkSettings(p9, p10) -- Line: 78
    -- upvalues: SettingsLibrary (copy), PlayerDataController (copy)
    local v11 = {};

    for _, v in pairs(SettingsLibrary.Order) do
        if v.InputType ~= "Divider" and (not p10 or v.Section == p10) then
            local v12 = { v.Name, PlayerDataController:GetSetting(v.Name) };
            table.insert(v11, v12);
        end;
    end;

    return v11;
end;

function u1._UpdateImportButton(p13) -- Line: 96
    -- upvalues: EnumLibrary (copy), SettingsLibrary (copy)
    local v14, v15 = EnumLibrary:DecryptTable(p13.ShareImportBox.Text);
    local v16 = nil;

    if v14 then
        for _, v in pairs(v15) do
            local v17 = SettingsLibrary.Info[v[1]] and SettingsLibrary.Info[v[1]].Section;

            if v17 then
                if v16 then
                    if v16 ~= v17 then
                        if v16 ~= v17 then
                            v16 = "Everything";
                            break;
                        end;
                    end;
                else
                    v16 = v17;
                end;
            end;
        end;
    end;

    local ShareImportButtonTitle = p13.ShareImportButtonTitle;
    local v18;

    if v14 then
        v18 = UDim2.new(0.5, 0, 0.35, 0);
    else
        v18 = UDim2.new(0.5, 0, 0.5, 0);
    end;

    ShareImportButtonTitle.Position = v18;
    p13.ShareImportButtonSection.Visible = v14;
    p13.ShareImportButtonSection.Text = v16 or "Nothing";
end;

function u1._SetShareBubbleVisible(p19, p20) -- Line: 124
    -- upvalues: EnumLibrary (copy)
    if p20 == p19.ShareBubbleFrame.Visible then
        return;
    end;

    p19.ShareBubbleFrame.Visible = p20;
    p19.ShareExportSectionTitle.Text = string.format("Share only your %s settings by copying this: ", p19.Page.CurrentPage or "");
    p19.ShareExportBox.Text = EnumLibrary:EncryptTable(p19:_GetBulkSettings(nil));
    p19.ShareExportSectionBox.Text = not p19.Page.CurrentPage and "???" or EnumLibrary:EncryptTable(p19:_GetBulkSettings(p19.Page.CurrentPage));
    p19.ShareImportBox.Text = "";
end;

function u1._Update(u21, p22) -- Line: 136
    -- upvalues: PlayerDataController (copy)
    u21._update_hash = u21._update_hash + 1;
    local _update_hash = u21._update_hash;
    local v23 = PlayerDataController:Get("SettingsProfile");

    for i, v in pairs(u21._slots) do
        local v24 = i == v23;
        v.Button.Background.Visible = v24;
        local Title = v.Button.Title;
        local v25;

        if v24 then
            v25 = Color3.fromRGB(0, 0, 0);
        else
            v25 = Color3.fromRGB(255, 255, 255);
        end;

        Title.TextColor3 = v25;
        v.Bubble.Visible = false;

        if v24 and not p22 then
            v.Bubble.Visible = true;
            v.Bubble.Size = UDim2.new(0.5, 0, 0.5, 0);
            v.Bubble:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.25, true);
            task.delay(3, function() -- Line: 153
                -- upvalues: _update_hash (copy), u21 (copy), v (copy)
                if _update_hash ~= u21._update_hash then
                    return;
                end;

                v.Bubble:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "In", "Quint", 0.25, true);
                task.delay(0.25, function() -- Line: 160
                    -- upvalues: _update_hash (ref), u21 (ref), v (ref)
                    if _update_hash ~= u21._update_hash then
                        return;
                    end;

                    v.Bubble.Visible = false;
                end);
            end);
        end;
    end;
end;

function u1._ButtonEffect(p26, u27) -- Line: 172
    -- upvalues: ButtonEffect (copy)
    u27.MouseEnter:Connect(function() -- Line: 173
        -- upvalues: u27 (copy)
        u27.OnHover.Visible = true;
    end);
    u27.MouseLeave:Connect(function() -- Line: 177
        -- upvalues: u27 (copy)
        u27.OnHover.Visible = false;
    end);
    ButtonEffect:Add(u27);
end;

function u1._Setup(u28) -- Line: 184
    -- upvalues: SettingsLibrary (copy), SettingsProfileSlot (copy)
    for i = 1, SettingsLibrary.NUM_PROFILES do
        local v29 = SettingsProfileSlot:Clone();
        v29.Button.Title.Text = i;
        v29.Bubble.Container.Title.Text = "Switched to profile #" .. i;
        v29.Parent = u28.Container;
        v29.Button.MouseButton1Click:Connect(function() -- Line: 191
            -- upvalues: u28 (copy), i (copy)
            u28.Clicked:Fire(i);
        end);
        u28._slots[i] = v29;
        u28:_ButtonEffect(v29.Button);
        local _ = i;
    end;
end;

function u1._Init(u30) -- Line: 200
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u30.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 201
        -- upvalues: u30 (copy)
        u30.Background.Size = UDim2.new(1, 0, 0, u30.Layout.AbsoluteContentSize.Y);
    end);
    u30.ShareButton.MouseButton1Click:Connect(function() -- Line: 205
        -- upvalues: u30 (copy)
        u30:_SetShareBubbleVisible(true);
    end);
    u30.ShareCloseButton.MouseButton1Click:Connect(function() -- Line: 209
        -- upvalues: u30 (copy)
        u30:_SetShareBubbleVisible(false);
    end);
    u30.ShareImportButton.MouseButton1Click:Connect(function() -- Line: 213
        -- upvalues: u30 (copy)
        u30:_ImportSettings();
    end);
    u30.ShareImportBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 217
        -- upvalues: u30 (copy)
        u30:_UpdateImportButton();
    end);
    PlayerDataController:GetDataChangedSignal("SettingsProfile"):Connect(function() -- Line: 221
        -- upvalues: u30 (copy)
        u30:_Update();
    end);
    u30:_Setup();
    u30:_Update(true);
    u30:_UpdateImportButton();
    u30:_ButtonEffect(u30.ShareButton);
    ButtonEffect:Add(u30.ShareImportButton, true);
end;

return u1;