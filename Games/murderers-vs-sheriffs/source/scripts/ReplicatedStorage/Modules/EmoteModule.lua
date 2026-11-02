-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
repeat
    task.wait();
until _G.EmoteController ~= nil;
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local _ = {};
local v5 = {};
local v6 = {};
_G.EmotePages = {};
_G.CurrentPage = "";
v0.EmoteGUI = nil;
local l_UserInputService_0 = game:GetService("UserInputService");
local function _(v8) --[[ Line: 23 ]] --[[ Name: GetImage ]]
    if _G.Cache[v8] ~= nil then
        return _G.Cache[v8];
    else
        local v9 = (tonumber(v8) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v8 or v8) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v8] = v9;
        return v9;
    end;
end;
v0.GeneratePage = function(v11, v12, v13, _, _) --[[ Line: 35 ]]
    local v16 = script.Page:Clone();
    local v17 = script.Container:Clone();
    v17.Parent = v16;
    v16.Name = v13;
    v16.Parent = v12.EmotePages;
    local v18 = {};
    for v19, v20 in pairs(v11) do
        v18[v19] = v20;
    end;
    table.insert(v18, 1, "");
    table.insert(v18, 2, "");
    v5[v13] = {};
    local v21 = #v18 - 2;
    v17.Size = UDim2.new(v21, 0, 1, 0);
    v17:ClearAllChildren();
    local v22 = 3;
    for _, v24 in v18 do
        local v25 = l_Sync_0.Emotes[v24] or l_Sync_0.Toys[v24];
        if v25 then
            local v26 = script.Emote:Clone();
            v26.Size = UDim2.new(1 / v21, 0, 1, 0);
            v26.Position = UDim2.new(1 / v21 * (v22 - 1 - 1 - 1), 0, 0, 0);
            v26.Name = v24;
            v26.Parent = v17;
            local l_Icon_0 = v26.Container.Icon;
            local l_Image_0 = v25.Image;
            local v29;
            if _G.Cache[l_Image_0] ~= nil then
                v29 = _G.Cache[l_Image_0];
            else
                local v30 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_0] = v30;
                v29 = v30;
            end;
            l_Icon_0.Image = v29;
            v26.Container.EmoteName.Text = v25.Name;
            v26.Container.Hotkey.Text = v22;
            v26.Container.Hotkey.Visible = l_UserInputService_0.KeyboardEnabled;
            v26.Container.Button.MouseButton1Click:Connect(function() --[[ Line: 70 ]]
                game.ReplicatedStorage.Remotes.Misc.PlayEmote:Fire(v24);
            end);
            v5[v13][v22] = v24;
            v22 = v22 + 1;
        end;
    end;
    table.insert(_G.EmotePages, v13);
    local v31 = script.Back:Clone();
    v31.Size = UDim2.new(1 / v21, 0, 1, 0);
    v31.Container.Icon.Visible = not game:GetService("UserInputService").GamepadEnabled;
    v31.Container.BButton.Visible = game:GetService("UserInputService").GamepadEnabled;
    v31.Container.Hotkey.Visible = game:GetService("UserInputService").KeyboardEnabled;
    v31.Parent = v17;
end;
v0.ShowPage = function(v32) --[[ Line: 89 ]]
    _G.EmoteController.Emotes = {
        [1] = nil, 
        [2] = "Back"
    };
    for v33, v34 in pairs(v5[v32]) do
        _G.EmoteController.Emotes[v33] = v34;
    end;
    for _, v36 in pairs(v0.EmoteGUI.EmotePages:GetChildren()) do
        v36.Visible = v36.Name == v32;
    end;
    _G.CurrentPage = v32;
    v0.EmoteGUI.PageName.Text = v32;
    task.wait();
    if l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Gamepad1 and v0.EmoteGUI.Visible then
        game:GetService("GuiService").SelectedObject = v0.EmoteGUI.EmotePages[v32].Container:GetChildren()[1].Container.Button;
    end;
end;
_G.ChangePage = function(v37) --[[ Line: 106 ]]
    for v38, v39 in _G.EmotePages do
        if v38 == v37 then
            v0.ShowPage(v39);
        end;
    end;
end;
v0.GenerateEmotes = function(v40, v41) --[[ Line: 115 ]]
    v5 = {};
    _G.EmotePages = {};
    _G.CurrentPage = "";
    v41.EmotePages:ClearAllChildren();
    if #v40 > 0 then
        if #v40 > 6 then
            local v42 = {};
            local v43 = 0;
            for v44, v45 in pairs(v40) do
                local v46 = math.floor(v44 / 6) + 1;
                v42[v46] = v42[v46] or {};
                table.insert(v42[v46], v45);
                v43 = v46;
            end;
            local v47 = nil;
            for v48, v49 in pairs(v42) do
                local v50 = "Your Emotes (" .. v48 .. "/" .. v43 .. ")";
                v0.GeneratePage(v49, v41, v50);
                if v48 == 1 then
                    v47 = v50;
                end;
            end;
            v0.GeneratePage({
                "wave", 
                "cheer", 
                "laugh", 
                "dance1", 
                "dance2", 
                "dance3"
            }, v41, "Roblox Emotes");
            v0.ShowPage(v47, v41);
        else
            v0.GeneratePage(v40, v41, "Your Emotes");
            v0.GeneratePage({
                "wave", 
                "cheer", 
                "laugh", 
                "dance1", 
                "dance2", 
                "dance3"
            }, v41, "Roblox Emotes");
            v0.ShowPage("Your Emotes", v41);
        end;
    else
        v0.GeneratePage({
            "wave", 
            "cheer", 
            "laugh", 
            "dance1", 
            "dance2", 
            "dance3"
        }, v41, "Roblox Emotes");
        v0.GeneratePage(v40, v41, "Your Emotes");
        v0.ShowPage("Roblox Emotes", v41);
    end;
    v6 = {};
    for _, v52 in pairs(v40) do
        v6[v52] = true;
    end;
end;
v0.SetupPageButtons = function() --[[ Line: 157 ]]
    local v53 = game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1;
    local v54 = not v53;
    local v55 = v53 and "" or v54 and "< Q" or "<";
    local v56 = v53 and "" or v54 and "E >" or ">";
    v0.EmoteGUI.Left.Text = v55;
    v0.EmoteGUI.Right.Text = v56;
    if v0.EmoteGUI.Left:FindFirstChild("ButtonIcon") then
        v0.EmoteGUI.Left.ButtonIcon.Visible = v53;
        v0.EmoteGUI.Right.ButtonIcon.Visible = v53;
    end;
    v0.EmoteGUI.Left.MouseButton1Click:Connect(_G.EmotePageLeft);
    v0.EmoteGUI.Right.MouseButton1Click:Connect(_G.EmotePageRight);
end;
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(function(v57, _, _) --[[ Line: 188 ]]
    if v57 == "Emotes" or v57 == "Toys" then
        for _, v61 in l_ProfileData_0.Emotes.Owned do
            if v6[v61] == nil then
                v0.GenerateEmotes(l_ProfileData_0.Emotes.Owned, v0.EmoteGUI);
                return;
            end;
        end;
    end;
end);
return v0;