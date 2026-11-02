-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_Parent_0 = script.Parent.Parent;
local l_Dock_0 = l_Parent_0.Dock;
local _ = l_Parent_0.Inventory;
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
pcall(function()
    game.Workspace.Lobby.RadioGamepass:Destroy();
end);
game:GetService("GuiService").AutoSelectGuiEnabled = false;
game:GetService("GuiService").CoreGuiNavigationEnabled = false;
_G.PauseBinds = false;
local v4 = 1;
local v5 = nil;
local _ = function(v6, v7, v8)
    l_ContextActionService_0:BindAction(v6, function(_, v10)
        if v10 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v8();
        end;
    end, false, v7);
end;
local _ = function(v12, _, _)
    l_ContextActionService_0:UnbindAction(v12);
end;
local l_Icon1_0 = l_Dock_0.Tip.Icon1;
local _ = l_Icon1_0.Icon2.Icon3;
local function _(v18)
    local v19 = v18 == "X" and "ButtonX" or "ButtonB";
    l_Icon1_0.Image = _G.GetButtonIcon(v19);
end;
local v21 = {
    {
        "Inventory", 
        Enum.KeyCode.ButtonA, 
        {
            "Weapons", 
            "Perks", 
            "Effects", 
            "Pets"
        }, 
        1
    }, 
    {
        "Shop", 
        Enum.KeyCode.ButtonX, 
        {
            "Featured", 
            "Currency", 
            "Weapons", 
            "Emotes", 
            "Perks", 
            "Effects", 
            "Pets"
        }, 
        1
    }, 
    {
        "Spectate", 
        Enum.KeyCode.ButtonY
    }
};
local v22 = {};
local function v26(v23)
    for _, v25 in pairs(v22) do
        game:GetService("GuiService"):RemoveSelectionGroup(v25);
    end;
    if v23 then
        game:GetService("GuiService"):AddSelectionParent(v23.Name, v23);
        table.insert(v22, v23.Name);
    end;
end;
local v27 = game.ReplicatedStorage.Remotes.Extras.GetPlayerData:InvokeServer();
local v28 = false;
local function v33()
    local v29 = {};
    if v27 then
        for v30, v31 in pairs(v27) do
            local l_FirstChild_0 = game.Players:FindFirstChild(v30);
            if l_FirstChild_0 == game.Players.LocalPlayer and not v31.Dead then
                return {};
            elseif not v31.Dead and l_FirstChild_0 and l_FirstChild_0.Character and l_FirstChild_0.Character:FindFirstChild("Humanoid") then
                table.insert(v29, l_FirstChild_0);
            end;
        end;
    end;
    return v29;
end;
game.ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged.OnClientEvent:connect(function(v34)
    v27 = v34;
    if not v28 then
        return;
    else
        if v33() and #v33() > 0 then
            if v5 ~= v33()[v5] then
                for v35, v36 in pairs((v33())) do
                    if v36 == v5 then
                        v4 = v35;
                        return;
                    end;
                end;
                while true do
                    v4 = v4 + 1;
                    if not (not v33()[v4] and v4 <= #v33()) then
                        break;
                    end;
                end;
                if v4 > #v33() then
                    v4 = 1;
                end;
                v5 = v33()[v4];
                if v5 then
                    l_Parent_0.Spectate.Title.PlayerName.Text = v5.Name;
                    game.Workspace.CurrentCamera.CameraSubject = v5.Character.Humanoid;
                    return;
                else
                    game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
                    _G.ResetDock();
                    return;
                end;
            end;
        else
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
            _G.ResetDock();
        end;
        return;
    end;
end);
local v37 = true;
local function v47(v38, v39)
    if not v37 then
        return;
    else
        v37 = false;
        local v40 = v21[v38];
        if v40[1] ~= "Spectate" then
            local _ = v40[3];
            local v42 = l_Parent_0[v40[1]].Main[v40[3][v40[4]]];
            v21[v38][4] = v40[4] + v39;
            local v43 = (v40[4] - 1) % #v40[3] + 1;
            local v44 = l_Parent_0[v40[1]].Main[v40[3][v43]];
            for _, v46 in pairs(l_Parent_0[v40[1]].Title.Nav:GetChildren()) do
                v46.Style = v46.Name == v44.Name and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
            end;
            l_Parent_0[v40[1]].Title.Title.Text = v44.Name;
            if v40[1] == "Shop" then
                if v44.Name == "Weapons" then
                    l_Parent_0.Shop.Info.Buy.ButtonIcon.Title.Text = "View";
                else
                    l_Parent_0.Shop.Info.Buy.ButtonIcon.Title.Text = "Buy";
                end;
            end;
            v44.Position = UDim2.new(v39, 0, 0, 0);
            v42:TweenPosition(UDim2.new(-v39, 0, 0, 0), "Out", "Quad", 0.2, false);
            v44:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, false);
            v21[v38][4] = v43;
            v26(v44);
            wait(0.2);
            game:GetService("GuiService").SelectedObject = v44.Items.ScrollFrame.Container:FindFirstChild("Slot0") and v44.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button or nil;
        elseif v33() and #v33() > 0 then
            v4 = v4 + v39;
            if v4 < 1 then
                v4 = #v33();
            elseif v4 > #v33() then
                v4 = 1;
            end;
            v5 = v33()[v4];
            game.Workspace.CurrentCamera.CameraSubject = v5.Character.Humanoid;
            l_Parent_0.Spectate.Title.PlayerName.Text = v5.Name;
        else
            _G.ResetDock();
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
        end;
        v37 = true;
        return;
    end;
end;
local function v48()
    if not l_Dock_0.Visible then
        return;
    else
        for v49, v50 in pairs(v21) do
            local v51 = l_Parent_0[v50[1]];
            local v52 = "Open" .. v50[1];
            local v53 = v50[2];
            local function v80()
                if v50[1] == "Spectate" then
                    if v33() and #v33() > 0 then
                        v4 = 1;
                        v5 = v33()[v4];
                        game.Workspace.CurrentCamera.CameraSubject = v5.Character.Humanoid;
                        l_Parent_0.Spectate.Title.PlayerName.Text = v5.Name;
                        v28 = true;
                    else
                        return;
                    end;
                end;
                for _, v55 in pairs(v21) do
                    local v56 = "Open" .. v55[1];
                    l_ContextActionService_0:UnbindAction(v56);
                end;
                local v57 = v50[1] == "Spectate" and "" or l_Parent_0[v50[1]].Main[v50[3][v50[4]]];
                v51:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, false);
                l_Dock_0:TweenPosition(UDim2.new(0.5, -(l_Dock_0.AbsoluteSize.X / 2), 1, 100), "Out", "Quad", 0.2, false);
                local l_ButtonX_0 = Enum.KeyCode.ButtonX;
                local function v59()

                end;
                local l_v59_0 = v59 --[[ copy: 2 -> 6 ]];
                l_ContextActionService_0:BindAction("NoX", function(_, v62)
                    if v62 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        l_v59_0();
                    end;
                end, false, l_ButtonX_0);
                l_ButtonX_0 = Enum.KeyCode.ButtonB;
                v59 = function()

                end;
                local l_v59_1 = v59 --[[ copy: 2 -> 7 ]];
                l_ContextActionService_0:BindAction("NoB", function(_, v65)
                    if v65 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        l_v59_1();
                    end;
                end, false, l_ButtonX_0);
                game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0);
                l_ButtonX_0 = Enum.KeyCode.ButtonR1;
                v59 = function()
                    v47(v49, 1);
                end;
                local l_v59_2 = v59 --[[ copy: 2 -> 8 ]];
                l_ContextActionService_0:BindAction("NavRight", function(_, v68)
                    if v68 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        l_v59_2();
                    end;
                end, false, l_ButtonX_0);
                l_ButtonX_0 = Enum.KeyCode.ButtonL1;
                v59 = function()
                    v47(v49, -1);
                end;
                local l_v59_3 = v59 --[[ copy: 2 -> 9 ]];
                l_ContextActionService_0:BindAction("NavLeft", function(_, v71)
                    if v71 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        l_v59_3();
                    end;
                end, false, l_ButtonX_0);
                l_ButtonX_0 = Enum.KeyCode.DPadLeft;
                v59 = function()

                end;
                local l_v59_4 = v59 --[[ copy: 2 -> 10 ]];
                l_ContextActionService_0:BindAction("NoDpadLeft", function(_, v74)
                    if v74 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        l_v59_4();
                    end;
                end, false, l_ButtonX_0);
                l_ButtonX_0 = Enum.KeyCode.DPadRight;
                v59 = function()

                end;
                local l_v59_5 = v59 --[[ copy: 2 -> 11 ]];
                l_ContextActionService_0:BindAction("NoDpadRight", function(_, v77)
                    if v77 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        l_v59_5();
                    end;
                end, false, l_ButtonX_0);
                l_Parent_0.Leaderboard.Visible = false;
                l_Parent_0.Chat.Visible = false;
                l_Parent_0.CashBag:TweenPosition(UDim2.new(1.12, 0, 0.7, 0), "Out", "Quad", 0.2);
                l_Parent_0.Perk:TweenPosition(UDim2.new(1.25, 0, 0.99, 0), "Out", "Quad", 0.2);
                l_Parent_0.Weapon:TweenPosition(UDim2.new(-0.51, 0, 0.8, -5), "Out", "Quad", 0.2);
                wait(0.2);
                if v50[1] ~= "Spectate" then
                    v26(v57);
                    game:GetService("GuiService").SelectedObject = v57.Items.ScrollFrame.Container:FindFirstChild("Slot0") and v57.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button or nil;
                end;
                l_ContextActionService_0:UnbindAction("NoB");
                l_ButtonX_0 = Enum.KeyCode.ButtonB;
                v59 = function()
                    l_ContextActionService_0:UnbindAction("NoX");
                    l_ContextActionService_0:UnbindAction("NoB");
                    l_ContextActionService_0:UnbindAction("NavLeft");
                    l_ContextActionService_0:UnbindAction("NavRight");
                    l_ContextActionService_0:UnbindAction("BuyCrateBundle");
                    l_ContextActionService_0:UnbindAction("NoDpadLeft");
                    l_ContextActionService_0:UnbindAction("NoDpadRight");
                    l_Parent_0.CashBag:TweenPosition(UDim2.new(0.99, 0, 0.7, 0), "Out", "Quad", 0.2);
                    l_Parent_0.Perk:TweenPosition(UDim2.new(0.99, 0, 0.99, 0), "Out", "Quad", 0.2);
                    l_Parent_0.Weapon:TweenPosition(UDim2.new(0, 5, 0.8, -5), "Out", "Quad", 0.2);
                    v51:TweenPosition(UDim2.new(0, 0, -1, -36), "Out", "Quad", 0.2, false);
                    if l_Dock_0.Visible then
                        l_Dock_0:TweenPosition(UDim2.new(0.5, -(l_Dock_0.AbsoluteSize.X / 2), 1, -l_Dock_0.AbsoluteSize.Y - 10), "Out", "Quad", 0.2, false);
                    end;
                    game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
                    v28 = false;
                    game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0.5);
                    l_Parent_0.Leaderboard.Visible = true;
                    l_Parent_0.Chat.Visible = true;
                    wait(0.2);
                    l_ContextActionService_0:UnbindAction("Close");
                    v26(nil);
                    game:GetService("GuiService").SelectedObject = nil;
                    v48();
                end;
                l_ContextActionService_0:BindAction("Close", function(_, v79)
                    if v79 == Enum.UserInputState.Begin and not _G.PauseBinds then
                        v59();
                    end;
                end, false, l_ButtonX_0);
            end;
            l_ContextActionService_0:BindAction(v52, function(_, v82)
                if v82 == Enum.UserInputState.Begin and not _G.PauseBinds then
                    v80();
                end;
            end, false, v53);
        end;
        return;
    end;
end;
game.ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:connect(function(_, _, _, _, _)
    l_Dock_0.Frame.Spectate.Icon.Image = "http://www.roblox.com/asset/?id=189764018";
    l_Dock_0.Frame.Spectate.Icon.ImageColor3 = Color3.new(0.25, 0.25, 0.25);
    l_Dock_0.Frame.Spectate.ButtonIcon.ImageColor3 = Color3.new(0.17254901960784313, 0.17254901960784313, 0.17254901960784313);
end);
local l_ButtonX_1 = Enum.KeyCode.ButtonX;
local function v98()
    for _, v90 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v90:IsA("Tool") and v90.Name == "Emotes" then
            v90.Parent = game.Players.LocalPlayer.Backpack;
            l_ContextActionService_0:UnbindAction("CloseEmotes");
        end;
    end;
    l_Dock_0:TweenPosition(UDim2.new(0.5, -(l_Dock_0.AbsoluteSize.X / 2), 1, -l_Dock_0.AbsoluteSize.Y - 10), "Out", "Quad", 0.2, false);
    l_Dock_0.Tip.TipText.Text = "CLOSE";
    l_Icon1_0.Image = _G.GetButtonIcon("ButtonB");
    wait(0.2);
    v48();
    local l_ButtonB_0 = Enum.KeyCode.ButtonB;
    local function v95()
        l_Icon1_0.Image = _G.GetButtonIcon("ButtonX");
        l_Dock_0:TweenPosition(UDim2.new(0.5, -(l_Dock_0.AbsoluteSize.X / 2), 1, 0), "Out", "Quad", 0.2, false);
        l_Dock_0.Tip.TipText.Text = "MENU";
        for _, v93 in pairs(v21) do
            local v94 = "Open" .. v93[1];
            l_ContextActionService_0:UnbindAction(v94);
        end;
        wait(0.2);
        l_ContextActionService_0:UnbindAction("CloseMenu");
    end;
    l_ContextActionService_0:BindAction("CloseMenu", function(_, v97)
        if v97 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v95();
        end;
    end, false, l_ButtonB_0);
end;
l_ContextActionService_0:BindAction("OpenMenu", function(_, v100)
    if v100 == Enum.UserInputState.Begin and not _G.PauseBinds then
        v98();
    end;
end, false, l_ButtonX_1);
_G.ResetDock = function()
    l_ContextActionService_0:UnbindAction("NoX");
    l_ContextActionService_0:UnbindAction("NoB");
    l_ContextActionService_0:UnbindAction("NavLeft");
    l_ContextActionService_0:UnbindAction("NavRight");
    l_ContextActionService_0:UnbindAction("BuyCrateBundle");
    l_ContextActionService_0:UnbindAction("NoDpadLeft");
    l_ContextActionService_0:UnbindAction("NoDpadRight");
    v28 = false;
    l_Parent_0.Shop:TweenPosition(UDim2.new(0, 0, -1, -36), "Out", "Quad", 0.2, false);
    l_Parent_0.Inventory:TweenPosition(UDim2.new(0, 0, -1, -36), "Out", "Quad", 0.2, false);
    l_Parent_0.Spectate:TweenPosition(UDim2.new(0, 0, -1, -36), "Out", "Quad", 0.2, false);
    game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0.5);
    l_ContextActionService_0:UnbindAction("Close");
    l_Parent_0.Leaderboard.Visible = true;
    l_Parent_0.Chat.Visible = true;
    l_Parent_0.CashBag:TweenPosition(UDim2.new(0.99, 0, 0.7, 0), "Out", "Quad", 0.2);
    l_Parent_0.Perk:TweenPosition(UDim2.new(0.99, 0, 0.99, 0), "Out", "Quad", 0.2);
    l_Parent_0.Weapon:TweenPosition(UDim2.new(0, 5, 0.8, -5), "Out", "Quad", 0.2);
    v26(nil);
    game:GetService("GuiService").SelectedObject = nil;
    v48();
    l_Icon1_0.Image = _G.GetButtonIcon("ButtonX");
    l_Dock_0:TweenPosition(UDim2.new(0.5, -(l_Dock_0.AbsoluteSize.X / 2), 1, 0), "Out", "Quad", 0, false);
    l_Dock_0.Tip.TipText.Text = "MENU";
    for _, v102 in pairs(v21) do
        local v103 = "Open" .. v102[1];
        l_ContextActionService_0:UnbindAction(v103);
    end;
    l_ContextActionService_0:UnbindAction("CloseMenu");
    l_Dock_0.Visible = true;
end;
wait();
game:GetService("GuiService").SelectedObject = nil;