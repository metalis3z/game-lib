-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_Examine_0 = l_Parent_0.Examine;
local l_Main_0 = l_Examine_0.Main;
local _ = l_Parent_0.Processing;
local _ = game.ReplicatedStorage.Remotes;
local l_Attribute_0 = game.Players.LocalPlayer:GetAttribute("Radio");
local v6 = "";
local function _(v7)
    if _G.Cache[v7] ~= nil then
        return _G.Cache[v7];
    else
        local v8 = (tonumber(v7) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v7 or v7) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v7] = v8;
        return v8;
    end;
end;
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = function(v11, v12, v13)
    l_ContextActionService_0:BindAction(v11, function(_, v15)
        if v15 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v13();
        end;
    end, false, v12);
end;
local _ = function(v17, _, _)
    l_ContextActionService_0:UnbindAction(v17);
end;
local v21 = {};
local function v25(v22)
    for _, v24 in pairs(v21) do
        game:GetService("GuiService"):RemoveSelectionGroup(v24);
    end;
    if v22 then
        game:GetService("GuiService"):AddSelectionParent(v22.Name, v22);
        table.insert(v21, v22.Name);
    end;
end;
local l_DatabaseCompatability_0 = require(script:WaitForChild("DatabaseCompatability"));
local l_Rarity_0 = l_DatabaseCompatability_0.Rarity;
local v28 = {
    Classic = 1, 
    Common = 2, 
    Uncommon = 3, 
    Rare = 4, 
    Legendary = 5, 
    Godly = 6, 
    Victim = 7, 
    Unique = 7, 
    Christmas = 1.5, 
    Halloween = 1.6, 
    Ancient = 6.5
};
local v29 = {
    Weapons = nil, 
    Effects = nil, 
    Perks = nil, 
    Emotes = nil, 
    Radios = nil, 
    Pets = nil
};
local v30 = {
    "Weapons", 
    "Perks", 
    "Effects", 
    "Pets"
};
local function v31(v32)
    local v33 = {};
    for v34, v35 in pairs(v32) do
        if type(v35) == "table" then
            v35 = v31(v35);
        end;
        v33[v34] = v35;
    end;
    return v33;
end;
local function _(v36, v37, v38, v39)
    local v40 = (not not v36:IsA("ImageLabel") or v36:IsA("ImageButton")) and v36 or v36.Icon;
    if v37 == nil then
        v40.Image = "";
        v36.ItemName.Text = "";
        if v36:FindFirstChild("Amount") then
            v36.Amount.Text = "";
            return;
        end;
    else
        local v41 = l_DatabaseCompatability_0[v39 or "Weapons"][v37];
        local l_Image_0 = v41.Image;
        local v43;
        if _G.Cache[l_Image_0] ~= nil then
            v43 = _G.Cache[l_Image_0];
        else
            local v44 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_0] = v44;
            v43 = v44;
        end;
        v40.Image = v43;
        v36.ItemName.Text = v41.ItemName or v41.Name;
        v36.ItemName.TextColor3 = v41.Rarity and l_Rarity_0[v41.Rarity] or Color3.new(1, 1, 1);
        if tonumber(v38) and v36:FindFirstChild("Amount") then
            v36.Amount.Text = "x" .. v38;
        end;
        if v36:FindFirstChild("Rarity") then
            v36.Rarity.Text = v41.Rarity or "";
            v36.Rarity.TextColor3 = l_Rarity_0[v41.Rarity] or Color3.new(1, 1, 1);
        end;
    end;
end;
local function v64(v46)
    for _, v48 in pairs(v30) do
        local v49 = v31(v46[v48]);
        if v49 ~= nil then
            table.sort(v49.Owned, function(v50, v51)
                return v50 < v51;
            end);
            v29[v48] = v49;
        end;
    end;
    for _, v53 in pairs({
        "Weapons", 
        "Pets"
    }) do
        local v54 = v31(v46[v53]);
        local v55 = {};
        for v56, v57 in pairs(v54.Owned) do
            table.insert(v55, {
                ItemID = v56, 
                Amount = v57
            });
        end;
        table.sort(v55, function(v58, v59)
            local v60 = {
                v58.ItemID, 
                v59.ItemID
            };
            local v61 = {
                v58.Amount, 
                v59.Amount
            };
            local v62 = {
                l_DatabaseCompatability_0[v53][v60[1]], 
                l_DatabaseCompatability_0[v53][v60[2]]
            };
            local v63 = {
                v28[v62[1].Rarity], 
                v28[v62[2].Rarity]
            };
            if v60[1] == "DefaultKnife" then
                return true;
            elseif v60[2] == "DefaultKnife" then
                return false;
            elseif v60[1] == "DefaultGun" then
                return true;
            elseif v60[2] == "DefaultGun" then
                return false;
            elseif v63[1] ~= v63[2] then
                return v63[1] > v63[2];
            elseif v61[1] ~= v61[2] then
                return v61[1] > v61[2];
            else
                return v62[1][v53 == "Weapons" and "ItemName" or "Name"] < v62[2][v53 == "Weapons" and "ItemName" or "Name"];
            end;
        end);
        v54.Owned = v55;
        v29[v53] = v54;
    end;
end;
local _ = {
    Common = "Uncommon", 
    Uncommon = "Rare", 
    Rare = "Legendary"
};
local v106 = {
    Weapons = {
        FrameFunction = function(v66, _, v68)
            local v69 = l_DatabaseCompatability_0.Weapons[v68.ItemID];
            v66.Icon.Image = v69.Image;
            v66.ItemName.Text = v69.ItemName;
            v66.ItemName.TextColor3 = l_Rarity_0[v69.Rarity];
            v66.Rarity.Text = v69.Rarity;
            v66.Rarity.TextColor3 = l_Rarity_0[v69.Rarity];
            if v68.Amount > 1 then
                v66.Amount.Text = "x" .. v68.Amount;
            end;
        end
    }, 
    Effects = {
        FrameFunction = function(v70, _, v72)
            local v73 = l_DatabaseCompatability_0.Effects[v72];
            v70.Icon.Image = v73.Image;
            v70.Type.Text = v73.Type;
            v70.ItemName.Text = v73.Name;
        end
    }, 
    Perks = {
        FrameFunction = function(v74, _, v76)
            local v77 = l_DatabaseCompatability_0.Perks[v76];
            local l_Icon_0 = v74.Icon;
            local l_Image_1 = v77.Image;
            local v80;
            if _G.Cache[l_Image_1] ~= nil then
                v80 = _G.Cache[l_Image_1];
            else
                local v81 = (tonumber(l_Image_1) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_1 or l_Image_1) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_1] = v81;
                v80 = v81;
            end;
            l_Icon_0.Image = v80;
            v74.ItemName.Text = v77.Name;
        end
    }, 
    Emotes = {
        FrameFunction = function(v82, _, v84)
            local v85 = l_DatabaseCompatability_0.Emotes[v84];
            v82.ItemName.Text = v85.Name;
            v82.Icon.Image = v85.Image;
            v82.Type.Text = "";
        end
    }, 
    Radios = {
        FrameFunction = function(v86, _, v88)
            local v89 = l_DatabaseCompatability_0.Radios[v88];
            v86.ItemName.Text = v89.Name;
            v86.Icon.Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v89.Image;
        end
    }, 
    Toys = {
        FrameFunction = function(v90, _, v92)
            local v93 = l_DatabaseCompatability_0.Toys[v92];
            v90.ItemName.Text = v93.Name;
            local l_Icon_1 = v90.Icon;
            local l_Image_2 = v93.Image;
            local v96;
            if _G.Cache[l_Image_2] ~= nil then
                v96 = _G.Cache[l_Image_2];
            else
                local v97 = (tonumber(l_Image_2) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_2 or l_Image_2) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_2] = v97;
                v96 = v97;
            end;
            l_Icon_1.Image = v96;
        end
    }, 
    Pets = {
        FrameFunction = function(v98, _, v100)
            local v101 = l_DatabaseCompatability_0.Pets[v100.ItemID];
            local l_Icon_2 = v98.Icon;
            local l_Image_3 = v101.Image;
            local v104;
            if _G.Cache[l_Image_3] ~= nil then
                v104 = _G.Cache[l_Image_3];
            else
                local v105 = (tonumber(l_Image_3) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_3 or l_Image_3) .. "&bust=" .. math.random(1, 10000);
                _G.Cache[l_Image_3] = v105;
                v104 = v105;
            end;
            l_Icon_2.Image = v104;
            v98.ItemName.Text = v101.Name;
            v98.ItemName.TextColor3 = l_Rarity_0[v101.Rarity];
            v98.Rarity.Text = v101.Rarity;
            v98.Rarity.TextColor3 = l_Rarity_0[v101.Rarity];
            if v100.Amount > 1 then
                v98.Amount.Text = "x" .. v100.Amount;
            end;
            v98.MouseEnter:connect(function()
                v98.Rarity.Visible = true;
            end);
            v98.MouseLeave:connect(function()
                v98.Rarity.Visible = false;
            end);
        end
    }
};
local function v123(v107)
    if v29[v107] == nil then
        return;
    else
        local v108 = 0;
        local l_ScrollFrame_0 = l_Main_0[v107].Items.ScrollFrame;
        local l_Container_0 = l_ScrollFrame_0.Container;
        local v111 = v106[v107] and v106[v107].Size or 0.2;
        local v112 = v106[v107] and v106[v107].FrameFunction or function()

        end;
        local l_Y_0 = l_ScrollFrame_0.CanvasPosition.Y;
        local v114 = false;
        l_ScrollFrame_0.Changed:connect(function()
            if v114 then
                return;
            else
                if l_ScrollFrame_0.CanvasPosition.Y > l_Y_0 then
                    v114 = true;
                    l_ScrollFrame_0.CanvasPosition = Vector2.new(0, l_ScrollFrame_0.CanvasPosition.Y + 20);
                    game:GetService("RunService").RenderStepped:wait();
                    v114 = false;
                end;
                l_Y_0 = l_ScrollFrame_0.CanvasPosition.Y;
                return;
            end;
        end);
        l_Container_0:ClearAllChildren();
        local function v120(v115, v116)
            if v116 ~= "None" then
                local v117 = math.floor(v108 / (1 / v111));
                local v118 = v108 % (1 / v111);
                local v119 = script.Item:Clone();
                v119.Parent = l_Container_0;
                v119.Size = UDim2.new(v111, 0, v111, 0);
                v119.Position = UDim2.new(v119.Size.X.Scale * v118, 0, 0, v119.AbsoluteSize.Y * v117);
                v119.Name = "Slot" .. v108;
                if v115 and v116 then
                    v112(v119.Container, v115, v116);
                end;
                l_ScrollFrame_0.CanvasSize = UDim2.new(0, 0, 0, (v117 + 1) * v119.AbsoluteSize.Y);
                v108 = v108 + 1;
            end;
        end;
        if l_Main_0[v107]:FindFirstChild("BuyRadio") and l_Attribute_0 then
            l_Main_0[v107].BuyRadio.Visible = false;
        end;
        for v121, v122 in pairs(v29[v107].Owned) do
            v120(v121, v122);
        end;
        return;
    end;
end;
local v124 = true;
local v125 = {
    {
        "Examine", 
        Enum.KeyCode.ButtonA, 
        {
            "Weapons", 
            "Perks", 
            "Effects", 
            "Pets"
        }, 
        1
    }
};
local function v135(v126, v127)
    if not v124 then
        return;
    else
        v124 = false;
        local v128 = v125[v126];
        local _ = v128[3];
        local v130 = l_Parent_0[v128[1]].Main[v128[3][v128[4]]];
        v125[v126][4] = v128[4] + v127;
        local v131 = (v128[4] - 1) % #v128[3] + 1;
        local v132 = l_Parent_0[v128[1]].Main[v128[3][v131]];
        for _, v134 in pairs(l_Parent_0[v128[1]].Title.Nav:GetChildren()) do
            v134.Style = v134.Name == v132.Name and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
        end;
        l_Parent_0[v128[1]].Title.Title.Text = v6 .. "'s " .. v132.Name;
        v132.Position = UDim2.new(v127, 0, 0, 0);
        v130:TweenPosition(UDim2.new(-v127, 0, 0, 0), "Out", "Quad", 0.2, false);
        v132:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, false);
        v125[v126][4] = v131;
        v25(NexFrame);
        game:GetService("GuiService").SelectedObject = v132.Items.ScrollFrame.Container:FindFirstChild("Slot0") and v132.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button or nil;
        wait(0.2);
        v124 = true;
        return;
    end;
end;
_G.Examine = function(v136, v137)
    v6 = v137;
    local l_SelectedObject_0 = game:GetService("GuiService").SelectedObject;
    local v139 = nil;
    local v140 = nil;
    if l_SelectedObject_0 then
        v139 = l_SelectedObject_0.Name;
        v140 = l_SelectedObject_0.Parent;
    end;
    v64(v136);
    for _, v142 in pairs(v30) do
        v123(v142);
    end;
    if v139 and v140 then
        game:GetService("GuiService").SelectedObject = v140[v139];
    end;
    l_Examine_0.Title.Title.Text = v6 .. "'s Weapons";
    v25(l_Examine_0.Main);
    game:GetService("GuiService").SelectedObject = l_Examine_0.Main.Weapons.Items.ScrollFrame.Container:FindFirstChild("Slot0") and l_Examine_0.Main.Weapons.Items.ScrollFrame.Container:FindFirstChild("Slot0").Container.Button or nil;
    l_Examine_0:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, false);
    local l_ButtonX_0 = Enum.KeyCode.ButtonX;
    local function v144()

    end;
    local l_v144_0 = v144 --[[ copy: 6 -> 10 ]];
    l_ContextActionService_0:BindAction("NoX", function(_, v147)
        if v147 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v144_0();
        end;
    end, false, l_ButtonX_0);
    l_ButtonX_0 = Enum.KeyCode.ButtonB;
    v144 = function()

    end;
    local l_v144_1 = v144 --[[ copy: 6 -> 11 ]];
    l_ContextActionService_0:BindAction("NoB", function(_, v150)
        if v150 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v144_1();
        end;
    end, false, l_ButtonX_0);
    game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0);
    l_ButtonX_0 = Enum.KeyCode.ButtonR1;
    v144 = function()
        v135(1, 1);
    end;
    local l_v144_2 = v144 --[[ copy: 6 -> 12 ]];
    l_ContextActionService_0:BindAction("NavRight", function(_, v153)
        if v153 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v144_2();
        end;
    end, false, l_ButtonX_0);
    l_ButtonX_0 = Enum.KeyCode.ButtonL1;
    v144 = function()
        v135(1, -1);
    end;
    local l_v144_3 = v144 --[[ copy: 6 -> 13 ]];
    l_ContextActionService_0:BindAction("NavLeft", function(_, v156)
        if v156 == Enum.UserInputState.Begin and not _G.PauseBinds then
            l_v144_3();
        end;
    end, false, l_ButtonX_0);
    l_Parent_0.Leaderboard.Visible = false;
    l_Parent_0.Chat.Visible = false;
    wait(0.2);
    l_ContextActionService_0:UnbindAction("NoB");
    l_ButtonX_0 = Enum.KeyCode.ButtonB;
    v144 = function()
        l_ContextActionService_0:UnbindAction("NoX");
        l_ContextActionService_0:UnbindAction("NoB");
        l_ContextActionService_0:UnbindAction("NavLeft");
        l_ContextActionService_0:UnbindAction("NavRight");
        l_ContextActionService_0:UnbindAction("BuyCrateBundle");
        l_Examine_0:TweenPosition(UDim2.new(0, 0, -1, -36), "Out", "Quad", 0.2, false);
        game.Players.LocalPlayer:WaitForChild("PlayerGui"):SetTopbarTransparency(0.5);
        l_Parent_0.Leaderboard.Visible = true;
        l_Parent_0.Chat.Visible = true;
        wait(0.2);
        l_ContextActionService_0:UnbindAction("Close");
        v25(l_Parent_0.Leaderboard);
        game:GetService("GuiService").SelectedObject = l_Parent_0.Leaderboard.List.Player1.Container.Button;
    end;
    l_ContextActionService_0:BindAction("Close", function(_, v158)
        if v158 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v144();
        end;
    end, false, l_ButtonX_0);
end;