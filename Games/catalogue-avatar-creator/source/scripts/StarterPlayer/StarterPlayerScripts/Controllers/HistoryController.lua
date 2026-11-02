-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Icon = require(ReplicatedStorage:WaitForChild("Icon"));
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local u1 = {
    CurrentState = {}
};
local u2 = nil;
local actionPending = false;

local function performAction(action)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if actionPending then
        return;
    end;

    if action == "undo" and not u1.CurrentState.canUndo then
        return;
    end;

    if action == "redo" and not u1.CurrentState.canRedo then
        return;
    end;

    if action ~= "undo" and action ~= "redo" then
        return;
    end;

    actionPending = true;
    Remotes.HistoryAction:FireServer(action);
    task.delay(2, function()
        actionPending = false;
    end);
end;

local u4 = Icon.new():setCaption("Undo Recent Action"):setImage("rbxassetid://106947829527141"):setImageScale(1):autoDeselect(false):oneClick():setOrder(1):setWidth(60):setImageScale(0.9):bindToggleKey(Enum.KeyCode.Undo):bindEvent("deselected", function()
    performAction("undo");
end);
local u5 = Icon.new():setCaption("Redo Recent Action"):setImage("rbxassetid://119124282396266"):setImageScale(1):autoDeselect(false):oneClick():setOrder(2):setWidth(60):setImageScale(0.9):bindToggleKey(Enum.KeyCode.SysReq):bindEvent("deselected", function()
    performAction("redo");
end);

u2 = function(p6) -- Line: 71, Name: applyButtonImages
    -- upvalues: u5 (copy), u4 (copy)
    if p6.canRedo then
        u5:setImage("rbxassetid://112206530063728");
    else
        u5:setImage("rbxassetid://119124282396266");
    end;

    if p6.canUndo then
        u4:setImage("rbxassetid://134822934485639");

        return;
    end;

    u4:setImage("rbxassetid://106947829527141");
end;

Remotes.HistoryStateUpdated.OnClientEvent:Connect(function(state)
    if typeof(state) ~= "table" then
        return;
    end;

    actionPending = false;
    u1.CurrentState = {
        canUndo = state.canUndo == true,
        canRedo = state.canRedo == true
    };
    u2(u1.CurrentState);
end);
task.spawn(function()
    if u1.CurrentState.canUndo == nil then
        local success, state = pcall(function()
            return Remotes.GetHistoryState:InvokeServer();
        end);

        if success and typeof(state) == "table" then
            u1.CurrentState = {
                canUndo = state.canUndo == true,
                canRedo = state.canRedo == true
            };
        else
            u1.CurrentState = {
                canUndo = false,
                canRedo = false
            };
        end;

        u2(u1.CurrentState);
    end;
end);
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or UserInputService:GetFocusedTextBox() then
        return;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
        if input.KeyCode == Enum.KeyCode.Z then
            performAction("undo");
        elseif input.KeyCode == Enum.KeyCode.Y then
            performAction("redo");
        end;
    end;
end);
u1.UndoButton = u4;
u1.RedoButton = u5;

function u1.SetButtonsVisible(p10) -- Line: 115
    -- upvalues: u4 (copy), u5 (copy)
    if p10 == "All" or type(p10) == "table" and table.find(p10, "All") then
        for _, v in { u4, u5 } do
            v:setEnabled(true);
        end;

        return;
    end;

    u4:setEnabled(table.find(p10, "Undo") ~= nil);
    u5:setEnabled(table.find(p10, "Redo") ~= nil);
end;

Events.SetButtonsVisible.Event:Connect(u1.SetButtonsVisible);

return u1;