-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.ModerationLibrary);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local ActionLogSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ActionLogSlot");
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
    -- upvalues: ActionLogSlot (copy), CONSTANTS (copy), Players (copy)
    local v6 = p5._ban_data.ActionHistory or {};
    p5.EmptyText.Visible = #v6 == 0;
    p5.List.Visible = not p5.EmptyText.Visible;

    for _, v in pairs(v6) do
        local u7 = ActionLogSlot:Clone();
        u7.Picture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, (tostring(v.TargetUserID)));
        u7.Date.Text = os.date("%x", v.Timestamp) .. " " .. os.date("%X", v.Timestamp);
        u7.Target.Text = "• • •";
        u7.Action.Text = v.Action;
        u7.Parent = p5.Container;
        task.spawn(function() -- Line: 54
            -- upvalues: u7 (copy), Players (ref), v (copy)
            local Target = u7.Target;
            local success, result = pcall(Players.GetNameFromUserIdAsync, Players, v.TargetUserID);

            if success then
                Target.Text = result;
            end;
        end);
    end;
end;

function u1._Init(u8) -- Line: 65
    -- upvalues: ButtonEffect (copy)
    u8.CloseButton.MouseButton1Click:Connect(function() -- Line: 66
        -- upvalues: u8 (copy)
        u8:CloseRequest();
    end);
    u8.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 70
        -- upvalues: u8 (copy)
        u8.List.CanvasSize = UDim2.new(0, 0, 0, u8.Layout.AbsoluteContentSize.Y);
    end);
    u8:_Setup();
    ButtonEffect:Add(u8.CloseButton);
end;

return u1;