-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BanLibrary = require(ReplicatedStorage.Modules.BanLibrary);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local BanLogSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BanLogSlot");
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: Prompt (copy), u1 (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.CloseButton = v4.PromptFrame:WaitForChild("Close");
    v4.EmptyText = v4.PromptFrame:WaitForChild("Empty");
    v4.List = v4.PromptFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4._ban_data = p2;
    v4:_Init();

    return v4;
end;

function u1._Setup(p5) -- Line: 40
    -- upvalues: BanLogSlot (copy), CONSTANTS (copy), BanLibrary (copy), Players (copy)
    local v6 = p5._ban_data.BanHistory or {};
    p5.EmptyText.Visible = #v6 == 0;
    p5.List.Visible = not p5.EmptyText.Visible;

    for _, v in pairs(v6) do
        local u7 = BanLogSlot:Clone();
        u7.Picture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, (tostring(v.Moderator)));
        u7.Date.Text = v.Date;
        u7.Duration.Text = v.Duration and v.Duration >= BanLibrary.PERMANENT_BAN_DURATION and "∞" or (v.Duration and (v.Duration .. "d" or "") or "");
        u7.Moderator.Text = "• • •";
        u7.Reason.Text = v.Reason;
        u7.Reason.TextColor3 = BanLibrary:IsBanLogANote(v) and Color3.fromRGB(127, 127, 127) or (BanLibrary:IsBanLogABan(v) and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
        u7.Parent = p5.Container;
        task.spawn(function() -- Line: 56
            -- upvalues: u7 (copy), Players (ref), v (copy)
            local Moderator = u7.Moderator;
            local success, result = pcall(Players.GetNameFromUserIdAsync, Players, v.Moderator);

            if success then
                Moderator.Text = result;
            end;
        end);
    end;
end;

function u1._Init(u8) -- Line: 67
    -- upvalues: ButtonEffect (copy)
    u8.CloseButton.MouseButton1Click:Connect(function() -- Line: 68
        -- upvalues: u8 (copy)
        u8:CloseRequest();
    end);
    u8.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 72
        -- upvalues: u8 (copy)
        u8.List.CanvasSize = UDim2.new(0, 0, 0, u8.Layout.AbsoluteContentSize.Y);
    end);
    u8:_Setup();
    ButtonEffect:Add(u8.CloseButton);
end;

return u1;