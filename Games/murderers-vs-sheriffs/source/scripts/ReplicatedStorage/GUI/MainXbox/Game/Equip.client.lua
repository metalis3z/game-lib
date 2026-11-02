-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local _ = script.Parent.Parent;
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v2, v3, v4)
    l_ContextActionService_0:BindAction(v2, function(_, v6)
        if v6 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v4();
        end;
    end, false, v3);
end;
local _ = function(v8, _, _)
    l_ContextActionService_0:UnbindAction(v8);
end;
local l_ButtonL1_0 = Enum.KeyCode.ButtonL1;
local function v17()
    for _, v14 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v14:IsA("Tool") then
            v14.Parent = game.Players.LocalPlayer.Backpack;
            if v14:FindFirstChild("KnifeServer") then
                return;
            end;
        end;
    end;
    for _, v16 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v16:IsA("Tool") and v16.Name ~= "Emotes" and v16:FindFirstChild("KnifeServer") then
            v16.Parent = game.Players.LocalPlayer.Character;
            return;
        end;
    end;
end;
l_ContextActionService_0:BindAction("EquipWeapons", function(_, v19)
    if v19 == Enum.UserInputState.Begin and not _G.PauseBinds then
        v17();
    end;
end, false, l_ButtonL1_0);
l_ContextActionService_0:BindAction("ShiftLock", function(_, v21, _)
    if v21 ~= Enum.UserInputState.Begin then
        return;
    else
        game.Players.LocalPlayer.PlayerScripts.MouseLock:Invoke();
        return;
    end;
end, false, Enum.KeyCode.DPadDown);
game.Players.LocalPlayer.Backpack.ChildAdded:connect(function(_)
    for _ = 1, 50 do
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        wait();
    end;
end);