-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local _ = script.Parent.Parent.Game;
local l_Songs_0 = script.Parent.Parent.Lobby.Screens.Inventory.Main.Songs;
local l_Attribute_0 = game.Players.LocalPlayer:GetAttribute("Radio");
local v3 = true;
local v4 = true;
local _ = require(game.ReplicatedStorage.Modules.AudioSearcher);
local l_Container_0 = l_Songs_0.Main.MySongs.ScrollFrame.Container;
local l_Search_0 = l_Songs_0.Main.Search;
local l_Container_1 = l_Search_0.Container.ScrollFrame.Container;
local l_Searcher_0 = l_Search_0.Searcher;
unescape = function(v10)
    v10 = string.gsub(v10, "&lt;", "<");
    v10 = string.gsub(v10, "&gt;", ">");
    v10 = string.gsub(v10, "&quot;", "\"");
    v10 = string.gsub(v10, "&apos;", "'");
    v10 = string.gsub(v10, "&#(%d+);", function(v11)
        if tonumber(v11) and tonumber(v11) < 126 then
            return (string.char((tonumber(v11))));
        else
            return "";
        end;
    end);
    v10 = string.gsub(v10, "&#x(%d+);", function(v12)
        if tonumber(v12) and tonumber(v12) < 126 then
            return (string.char((tonumber(v12))));
        else
            return "";
        end;
    end);
    v10 = string.gsub(v10, ".", function(v13)
        local v14 = string.byte(v13);
        if v14 and v14 < 126 then
            return v13;
        else
            return "";
        end;
    end);
    return (string.gsub(v10, "&amp;", "&"));
end;
if not v3 and not v4 then
    local v15 = unpack({
        game.ReplicatedStorage.Remotes.Extras.GetData:InvokeServer("RadioSongs")
    });
    for _, v17 in pairs(l_Songs_0.Nav:GetChildren()) do
        v17.MouseButton1Click:connect(function()
            script.Preview:Stop();
            script.Preview.SoundId = "";
            for _, v19 in pairs(l_Songs_0.Nav:GetChildren()) do
                v19.Style = v19 == v17 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
            end;
            for _, v21 in pairs(l_Songs_0.Main:GetChildren()) do
                v21.Visible = v21.Name == v17.Name;
            end;
        end);
    end;
    local v22 = false;
    game.ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:connect(function(_, _, _, _)
        v22 = true;
    end);
    game.ReplicatedStorage.Remotes.Shop.GetRadio.OnClientEvent:connect(function()
        v22 = true;
    end);
    local function v27()
        l_Container_0:ClearAllChildren();
        for v28, v29 in pairs(v15) do
            local v30 = script.Song:Clone();
            v30.Container.SongName.Text = v29.Name;
            v30.Container.Play.MouseButton1Click:connect(function()
                if v22 then
                    if l_Attribute_0 then
                        game.ReplicatedStorage.Remotes.Inventory.PlaySong:FireServer(v29.ID);
                        return;
                    else
                        game.ReplicatedStorage.Remotes.Shop.GetRadio:FireServer();
                        return;
                    end;
                else
                    l_Songs_0.Main.MySongs.Wait.Visible = true;
                    wait(2);
                    l_Songs_0.Main.MySongs.Wait.Visible = false;
                    return;
                end;
            end);
            v30.Container.Delete.MouseButton1Click:connect(function()
                table.remove(v15, v28);
                game.ReplicatedStorage.Remotes.Inventory.RemoveSong:FireServer(v28);
                v27();
            end);
            v30.Position = UDim2.new(0, 0, 0, (v28 - 1) * v30.Size.Y.Offset);
            v30.Parent = l_Container_0;
        end;
    end;
    local function v37(v31, v32)
        local v33 = nil;
        if v32 == nil then
            pcall(function()
                if tonumber(v31) then
                    local l_ProductInfo_0 = game:GetService("MarketplaceService"):GetProductInfo(v31);
                    if l_ProductInfo_0 and l_ProductInfo_0.AssetTypeId == 3 then
                        v33 = "https://www.roblox.com/asset/?id=" .. v31;
                        v32 = unescape(l_ProductInfo_0.Name);
                    end;
                end;
            end);
        else
            v33 = "https://www.roblox.com/asset/?id=" .. v31;
        end;
        if v33 then
            for _, v36 in pairs(v15) do
                if v36.ID == v33 then
                    return;
                end;
            end;
            table.insert(v15, 1, {
                ID = v33, 
                Name = v32
            });
            if #v15 >= 30 then
                table.remove(v15, 30);
            end;
            game.ReplicatedStorage.Remotes.Inventory.SaveSong:FireServer(v33, v32);
            v27();
        end;
    end;
    local function v58(v38)
        if not l_Attribute_0 and not v38 then
            return;
        else
            script.Preview:Stop();
            script.Preview.SoundId = "";
            for _, v40 in pairs(l_Search_0:GetChildren()) do
                if v40.Name ~= "Searcher" then
                    v40.Visible = false;
                end;
            end;
            l_Search_0.Processing.Visible = true;
            l_Search_0.Processing.Text = "Searching.";
            spawn(function()
                local v41 = 1;
                while l_Search_0.Processing.Visible do
                    l_Search_0.Processing.Text = "Searching";
                    for _ = 1, (v41 - 1) % 4 do
                        l_Search_0.Processing.Text = l_Search_0.Processing.Text .. ".";
                    end;
                    v41 = v41 + 1;
                    wait(0.25);
                end;
            end);
            local v43 = game.ReplicatedStorage.Remotes.Extras.SearchSongs:InvokeServer(not v38 and l_Searcher_0.ID.Text or "");
            local _ = l_Searcher_0.ID.Text;
            l_Search_0.Processing.Visible = false;
            if v43 then
                if #v43 > 0 then
                    l_Container_1:ClearAllChildren();
                    for v45, v46 in pairs(v43) do
                        local v47 = script.SearchedSong:Clone();
                        local v48 = v46.Title or v46.Name;
                        local v49 = v46.Id or v46.AssetId;
                        v47.Container.SongName.Text = tostring(v48);
                        for _, v51 in pairs(v15) do
                            if v51.ID == "https://www.roblox.com/asset/?id=" .. v49 then
                                v47.Container.Add.Text = "Added";
                                v47.Container.Add.Style = Enum.ButtonStyle.RobloxRoundButton;
                            end;
                        end;
                        local v52 = nil;
                        do
                            local l_v52_0 = v52;
                            l_v52_0 = v47.Container.Add.MouseButton1Click:connect(function()
                                l_v52_0:disconnect();
                                v47.Container.Add.Text = "Added";
                                v47.Container.Add.Style = Enum.ButtonStyle.RobloxRoundButton;
                                v37(v49, v48);
                            end);
                            v47.Container.Preview.MouseButton1Click:connect(function()
                                for _, v55 in pairs(l_Container_1:GetChildren()) do
                                    v55.Container.Preview.Text = "Preview";
                                end;
                                script.Preview:Stop();
                                local v56 = "https://www.roblox.com/asset/?id=" .. v49;
                                local l_SoundId_0 = script.Preview.SoundId;
                                script.Preview.SoundId = v56;
                                if script.Preview.SoundId ~= l_SoundId_0 then
                                    v47.Container.Preview.Text = "Stop";
                                    script.Preview:Play();
                                    return;
                                else
                                    script.Preview.SoundId = "";
                                    return;
                                end;
                            end);
                            v47.Position = UDim2.new(0, 0, 0, (v45 - 1) * v47.Size.Y.Offset);
                            l_Container_1.Parent.CanvasSize = UDim2.new(0, 0, 0, v47.Size.Y.Offset * v45);
                            v47.Parent = l_Container_1;
                        end;
                    end;
                    l_Container_1.Parent.Parent.Visible = true;
                    return;
                else
                    l_Search_0.Empty.Visible = true;
                    return;
                end;
            else
                l_Search_0.Error.Visible = true;
                return;
            end;
        end;
    end;
    l_Searcher_0.ID.FocusLost:connect(function(v59)
        if v59 then
            v58();
        end;
    end);
    v58(true);
    v27();
    return;
else
    if v3 then
        pcall(function()
            game.Workspace.Lobby.RadioGamepass:Destroy();
        end);
    end;
    return;
end;