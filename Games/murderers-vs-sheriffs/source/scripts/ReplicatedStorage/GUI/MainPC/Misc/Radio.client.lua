-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Game_0 = script.Parent.Parent:WaitForChild("Game");
local l_Radio_0 = l_Game_0:WaitForChild("Settings"):WaitForChild("Radio");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Radio_1 = l_Game_0.Radio;
l_WindowService_0:RegisterFrame(l_Radio_1, "Radio");
local l_Attribute_0 = game.Players.LocalPlayer:GetAttribute("Radio");
local _ = require(game.ReplicatedStorage.Modules.AudioSearcher);
local v6 = true;

if game.PlaceId ~= require(game.ReplicatedStorage.Constants).Places.Disguises then
    v6 = game.PlaceId == 333740520;
end;
local v7 = true;
if game.PlaceId ~= 5895823254 then
    v7 = game.PlaceId == 5928494131;
end;
local l_ScrollFrame_0 = l_Radio_1.Main.MySongs.ScrollFrame;
local l_Adder_0 = l_Radio_1.Main.MySongs.Adder;
local l_Search_0 = l_Radio_1.Main.Search;
local l_ScrollFrame_1 = l_Radio_1.Main.Search.ScrollFrame;
local l_Searcher_0 = l_Radio_1.Main.Search.Searcher;
unescape = function(v13) --[[ Line: 29 ]] --[[ Name: unescape ]]
    v13 = string.gsub(v13, "&lt;", "<");
    v13 = string.gsub(v13, "&gt;", ">");
    v13 = string.gsub(v13, "&quot;", "\"");
    v13 = string.gsub(v13, "&apos;", "'");
    v13 = string.gsub(v13, "&#(%d+);", function(v14) --[[ Line: 35 ]]
        if tonumber(v14) and tonumber(v14) < 126 then
            return (string.char((tonumber(v14))));
        else
            return "";
        end;
    end);
    v13 = string.gsub(v13, "&#x(%d+);", function(v15) --[[ Line: 43 ]]
        if tonumber(v15) and tonumber(v15) < 126 then
            return (string.char((tonumber(v15))));
        else
            return "";
        end;
    end);
    v13 = string.gsub(v13, ".", function(v16) --[[ Line: 51 ]]
        local v17 = string.byte(v16);
        if v17 and v17 < 126 then
            return v16;
        else
            return "";
        end;
    end);
    return (string.gsub(v13, "&amp;", "&"));
end;
if not v6 and not v7 then
    local v18 = unpack({
        game.ReplicatedStorage.Remotes.Extras.GetData:InvokeServer("RadioSongs")
    });
    for _, v20 in pairs(l_Radio_1.Nav:GetChildren()) do
        v20.MouseButton1Click:connect(function() --[[ Line: 70 ]]
            script.Preview:Stop();
            script.Preview.SoundId = "";
            for _, v22 in pairs(l_Radio_1.Nav:GetChildren()) do
                v22.Style = v22 == v20 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
            end;
            for _, v24 in pairs(l_Radio_1.Main:GetChildren()) do
                v24.Visible = v24.Name == v20.Name;
            end;
        end);
    end;
    local v25 = false;
    game.ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:connect(function(_, _, _, _) --[[ Line: 83 ]]
        v25 = true;
    end);
    game.ReplicatedStorage.Remotes.Shop.GetRadio.OnClientEvent:connect(function() --[[ Line: 87 ]]
        v25 = true;
    end);
    local function v30() --[[ Line: 91 ]] --[[ Name: UpdateSongList ]]
        l_ScrollFrame_0:ClearAllChildren();
        for v31, v32 in pairs(v18) do
            local v33 = script.Song:Clone();
            v33.Container.SongName.Text = v32.Name;
            v33.Container.Play.MouseButton1Click:connect(function() --[[ Line: 96 ]]
                if v25 and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                    if l_Attribute_0 then
                        game.ReplicatedStorage.Remotes.Inventory.PlaySong:FireServer(v32.ID);
                        return;
                    else
                        game.ReplicatedStorage.Remotes.Shop.GetRadio:FireServer();
                        return;
                    end;
                else
                    l_Radio_1.Main.MySongs.Wait.Visible = true;
                    wait(2);
                    l_Radio_1.Main.MySongs.Wait.Visible = false;
                    return;
                end;
            end);
            v33.Container.Delete.MouseButton1Click:connect(function() --[[ Line: 109 ]]
                table.remove(v18, v31);
                game.ReplicatedStorage.Remotes.Inventory.RemoveSong:FireServer(v31);
                v30();
            end);
            v33.Position = UDim2.new(0, 0, 0, (v31 - 1) * v33.Size.Y.Offset);
            v33.Parent = l_ScrollFrame_0;
        end;
    end;
    local function v40(v34, v35) --[[ Line: 120 ]] --[[ Name: AddSong ]]
        local v36 = nil;
        if v35 == nil then
            pcall(function() --[[ Line: 124 ]]
                if tonumber(v34) then
                    local l_ProductInfo_0 = game:GetService("MarketplaceService"):GetProductInfo(v34);
                    if l_ProductInfo_0 and l_ProductInfo_0.AssetTypeId == 3 then
                        v36 = "https://www.roblox.com/asset/?id=" .. v34;
                        v35 = unescape(l_ProductInfo_0.Name);
                    end;
                end;
            end);
        else
            v36 = "https://www.roblox.com/asset/?id=" .. v34;
        end;
        if v36 then
            for _, v39 in pairs(v18) do
                if v39.ID == v36 then
                    return;
                end;
            end;
            table.insert(v18, 1, {
                ID = v36, 
                Name = v35
            });
            if #v18 >= 30 then
                table.remove(v18, 30);
            end;
            game.ReplicatedStorage.Remotes.Inventory.SaveSong:FireServer(v36, v35);
            v30();
        else
            l_Adder_0.ID.Text = "Invalid ID!";
        end;
    end;
    l_Radio_0.Button.Activated:Connect(function() --[[ Line: 154 ]]
        l_WindowService_0:ToggleFrame("Radio");
    end);
    local function v61(v41) --[[ Line: 164 ]] --[[ Name: SearchSongs ]]
        if not l_Attribute_0 and not v41 then
            return;
        else
            script.Preview:Stop();
            script.Preview.SoundId = "";
            for _, v43 in pairs(l_Search_0:GetChildren()) do
                if v43.Name ~= "Searcher" then
                    v43.Visible = false;
                end;
            end;
            l_Search_0.Processing.Visible = true;
            l_Search_0.Processing.Text = "Searching.";
            spawn(function() --[[ Line: 171 ]]
                local v44 = 1;
                while l_Search_0.Processing.Visible do
                    l_Search_0.Processing.Text = "Searching";
                    for _ = 1, (v44 - 1) % 4 do
                        l_Search_0.Processing.Text = l_Search_0.Processing.Text .. ".";
                    end;
                    v44 = v44 + 1;
                    wait(0.25);
                end;
            end);
            local _ = l_Searcher_0.ID.Text;
            local v47 = game.ReplicatedStorage.Remotes.Extras.SearchSongs:InvokeServer(not v41 and l_Searcher_0.ID.Text or "");
            l_Search_0.Processing.Visible = false;
            if v47 and type(v47) == "table" then
                if #v47 > 0 then
                    l_ScrollFrame_1:ClearAllChildren();
                    for v48, v49 in pairs(v47) do
                        local v50 = script.SearchedSong:Clone();
                        local v51 = v49.Title or v49.Name;
                        local v52 = v49.Id or v49.AssetId;
                        v50.Container.SongName.Text = tostring(v51);
                        for _, v54 in pairs(v18) do
                            if v54.ID == "https://www.roblox.com/asset/?id=" .. v52 then
                                v50.Container.Add.Text = "Added";
                                v50.Container.Add.Style = Enum.ButtonStyle.RobloxRoundButton;
                            end;
                        end;
                        local v55 = nil;
                        do
                            local l_v55_0 = v55;
                            l_v55_0 = v50.Container.Add.MouseButton1Click:connect(function() --[[ Line: 210 ]]
                                l_v55_0:disconnect();
                                v50.Container.Add.Text = "Added";
                                v50.Container.Add.Style = Enum.ButtonStyle.RobloxRoundButton;
                                v40(v52, v51);
                            end);
                            v50.Container.Preview.MouseButton1Click:connect(function() --[[ Line: 217 ]]
                                for _, v58 in pairs(l_ScrollFrame_1:GetChildren()) do
                                    v58.Container.Preview.Text = "Preview";
                                end;
                                script.Preview:Stop();
                                local v59 = "https://www.roblox.com/asset/?id=" .. v52;
                                local l_SoundId_0 = script.Preview.SoundId;
                                script.Preview.SoundId = v59;
                                if script.Preview.SoundId ~= l_SoundId_0 then
                                    v50.Container.Preview.Text = "Stop";
                                    script.Preview:Play();
                                    return;
                                else
                                    script.Preview.SoundId = "";
                                    return;
                                end;
                            end);
                            v50.Position = UDim2.new(0, 0, 0, (v48 - 1) * v50.Size.Y.Offset);
                            l_ScrollFrame_1.CanvasSize = UDim2.new(0, 0, 0, v50.Size.Y.Offset * v48);
                            v50.Parent = l_ScrollFrame_1;
                        end;
                    end;
                    l_ScrollFrame_1.Visible = true;
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
    l_Searcher_0.Add.MouseButton1Click:connect(v61);
    l_Searcher_0.ID.FocusLost:connect(function(v62) --[[ Line: 249 ]]
        if v62 then
            v61();
        end;
    end);
    l_Adder_0.Add.MouseButton1Click:connect(function() --[[ Line: 254 ]]
        v40(l_Adder_0.ID.Text);
    end);
    v61();
    v30();
    return;
else
    if v6 then
        pcall(function() --[[ Line: 263 ]]
            game.Workspace.Lobby.RadioGamepass:Destroy();
        end);
    end;
    return;
end;