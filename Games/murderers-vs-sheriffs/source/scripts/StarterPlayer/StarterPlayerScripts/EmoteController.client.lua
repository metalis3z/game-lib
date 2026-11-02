-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = game:GetService("UserInputService");
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
repeat
    wait();
until game.Players.LocalPlayer.Character and _G.EmoteFrame ~= nil;
local v3 = script.Emotes:Clone();
v3.D.Disabled = false;
v3.Parent = game.Players.LocalPlayer.Backpack;
_G.EmoteController = {};
_G.EmoteController.Emotes = {};
local v4 = {
    Enum.KeyCode.One, 
    Enum.KeyCode.Two, 
    Enum.KeyCode.Three, 
    Enum.KeyCode.Four, 
    Enum.KeyCode.Five, 
    Enum.KeyCode.Six, 
    Enum.KeyCode.Seven, 
    Enum.KeyCode.Eight, 
    Enum.KeyCode.Nine, 
    Enum.KeyCode.Zero
};
local v5 = {};
local v6 = {};
local l_UserInputService_1 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_ContextActionService_1 = game:GetService("ContextActionService");
local function v10() --[[ Line: 35 ]] --[[ Name: closeEmotes ]]
    v3.Parent = game.Players.LocalPlayer.Backpack;
end;
local function v15() --[[ Line: 39 ]] --[[ Name: ClearBinds ]]
    for _, v12 in v5 do
        l_ContextActionService_1:UnbindAction(v12);
    end;
    for _, v14 in v6 do
        v14:Disconnect();
    end;
end;
local v16 = 1;
local function v23() --[[ Line: 50 ]] --[[ Name: BindPage ]]
    v15();
    for v17, v18 in _G.EmoteController.Emotes do
        local function v19() --[[ Line: 54 ]]
            if v18 ~= "Back" then
                game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(v18);
            end;
            v3.Parent = game.Players.LocalPlayer.Backpack;
        end;
        game:GetService("ContextActionService"):BindAction(v18, function(_, v21, _) --[[ Line: 61 ]]
            if v21 ~= Enum.UserInputState.Begin then
                return;
            else
                if v18 ~= "Back" then
                    game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(v18);
                end;
                v3.Parent = game.Players.LocalPlayer.Backpack;
                return;
            end;
        end, false, v4[v17]);
        table.insert(v5, v18);
        table.insert(v6, _G.EmoteFrame.EmotePages[_G.CurrentPage].Container:FindFirstChild(v18).Container.Button.MouseButton1Click:connect(v19));
    end;
end;
_G.RebindPage = function() --[[ Line: 70 ]]
    v23();
end;
local function _(v24) --[[ Line: 74 ]] --[[ Name: ChangePage ]]
    v16 = v16 + v24 > #_G.EmotePages and 1 or v16 + v24 < 1 and #_G.EmotePages or v16 + v24;
    _G.ChangePage(v16);
    v23();
end;
_G.EmotePageLeft = function() --[[ Line: 79 ]]
    v16 = v16 + -1 > #_G.EmotePages and 1 or v16 + -1 < 1 and #_G.EmotePages or v16 + -1;
    _G.ChangePage(v16);
    v23();
end;
_G.EmotePageRight = function() --[[ Line: 80 ]]
    v16 = v16 + 1 > #_G.EmotePages and 1 or v16 + 1 < 1 and #_G.EmotePages or v16 + 1;
    _G.ChangePage(v16);
    v23();
end;
local function v29(v26, v27, _) --[[ Line: 83 ]] --[[ Name: onPageAction ]]
    if v27 ~= Enum.UserInputState.Begin then
        return;
    elseif v26 == "EmotePageLeft" then
        _G.EmotePageLeft();
        return;
    else
        if v26 == "EmotePageRight" then
            _G.EmotePageRight();
        end;
        return;
    end;
end;
local v30 = 0;
l_ContextActionService_0.LocalToolEquipped:Connect(function(v31) --[[ Line: 97 ]]
    if v31.Name ~= "Emotes" then
        return;
    else
        game.Players.LocalPlayer.Character.ChildAdded:Connect(function(_) --[[ Line: 101 ]]
            v30 = time();
        end);
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        _G.EmoteFrame.Visible = true;
        v23();
        l_ContextActionService_1:BindAction("EmotePageLeft", v29, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.Q);
        l_ContextActionService_1:BindAction("EmotePageRight", v29, false, Enum.KeyCode.ButtonR1, Enum.KeyCode.E);
        l_ContextActionService_1:BindAction("CloseEmotePage", v10, false, Enum.KeyCode.ButtonB);
        if l_UserInputService_1:GetLastInputType() == Enum.UserInputType.Gamepad1 then
            l_GuiService_0.SelectedObject = _G.EmoteFrame.EmotePages[_G.CurrentPage].Container:GetChildren()[1].Container.Button;
        end;
        if #game.Players.LocalPlayer.Backpack:GetChildren() == 0 then
            script.AAAAA:Clone().Parent = game.Players.LocalPlayer.Backpack;
        end;
        return;
    end;
end);
l_ContextActionService_1.LocalToolUnequipped:Connect(function(v33) --[[ Line: 131 ]]
    if v33.Name ~= "Emotes" then
        return;
    else
        l_GuiService_0.SelectedObject = nil;
        task.wait();
        local l_AAAAA_0 = game.Players.LocalPlayer.Backpack:FindFirstChild("AAAAA");
        if l_AAAAA_0 then
            l_AAAAA_0:Destroy();
        end;
        v15();
        l_ContextActionService_1:UnbindAction("EmotePageLeft");
        l_ContextActionService_1:UnbindAction("EmotePageRight");
        l_ContextActionService_1:UnbindAction("CloseEmotePage");
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
        _G.EmoteFrame.Visible = false;
        return;
    end;
end);
game.Players.LocalPlayer.CharacterAdded:Connect(function(_) --[[ Line: 154 ]]
    repeat
        wait();
    until game.Players.LocalPlayer.Character;
    v15();
    v3 = script.Emotes:Clone();
    v3.D.Disabled = false;
    v3.Parent = game.Players.LocalPlayer.Backpack;
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
    _G.EmoteFrame.Visible = false;
end);
game.Players.LocalPlayer.Backpack.ChildAdded:connect(function(_) --[[ Line: 171 ]]

end);