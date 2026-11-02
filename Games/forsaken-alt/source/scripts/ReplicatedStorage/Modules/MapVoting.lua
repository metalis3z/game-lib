-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    CurrentVote = nil, 
    VoteDuration = 20, 
    MapsIncludedInVote = 3
};
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
local v4 = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Maps);
local v6 = require(game.ReplicatedStorage.Modules.Util);
v0.StartVote = function(_) --[[ Line: 18 ]] --[[ Name: StartVote ]]
    -- upvalues: v0 (copy), v5 (copy), v6 (copy)
    if not workspace:GetAttribute("MapVotingEnabled") then
        v0.CurrentVote = {};
        return;
    else
        v0:Destroy();
        v0.CurrentVote = {
            MapSelection = {}, 
            VoteFolder = nil
        };
        local l_v5_SelectableMaps_0 = v5:GetSelectableMaps();
        v6:ShuffleTable(l_v5_SelectableMaps_0);
        local l_pairs_0 = pairs;
        local v10 = l_v5_SelectableMaps_0 or {};
        for _, v12 in l_pairs_0(v10) do
            table.insert(v0.CurrentVote.MapSelection, v12);
            if #v0.CurrentVote.MapSelection >= v0.MapsIncludedInVote then
                break;
            end;
        end;
        v0.CurrentVote.VoteFolder = Instance.new("Folder");
        v0.CurrentVote.VoteFolder.Name = "MapVote";
        v0.CurrentVote.VoteFolder:SetAttribute("VoteDuration", v0.VoteDuration);
        for _, v14 in pairs(v0.CurrentVote.MapSelection) do
            local v15 = v14.Config:Clone();
            v15.Name = v14.Name;
            v15.Parent = v0.CurrentVote.VoteFolder;
        end;
        v0.CurrentVote.VoteFolder.Parent = game.ReplicatedStorage;
        return;
    end;
end;
v0.GetResults = function(_) --[[ Line: 56 ]] --[[ Name: GetResults ]]
    -- upvalues: v0 (copy)
    if v0.CurrentVote then
        local l_Children_0 = v0.CurrentVote.VoteFolder:GetChildren();
        table.sort(l_Children_0, function(v18, v19) --[[ Line: 59 ]]
            return #v18:GetChildren() > #v19:GetChildren();
        end);
        return l_Children_0;
    else
        return {};
    end;
end;
v0.GetMostVotedMapName = function(_) --[[ Line: 66 ]] --[[ Name: GetMostVotedMapName ]]
    -- upvalues: v0 (copy)
    if not workspace:GetAttribute("MapVotingEnabled") then
        return "N/A";
    else
        local v21 = v0:GetResults()[1];
        return v21 and v21.Name or "N/A";
    end;
end;
v0.Destroy = function(_) --[[ Line: 73 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.CurrentVote then
        if not v0.CurrentVote.VoteFolder then
            return;
        else
            v0.CurrentVote.VoteFolder:Destroy();
            v0.CurrentVote = nil;
        end;
    end;
end;
v0.Start = function(_) --[[ Line: 84 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), v4 (copy), v0 (copy), v2 (copy)
    if v3 then
        v4:SetConnection("VoteForMap", "REMOTE_EVENT", function(v24, v25, v26) --[[ Line: 87 ]]
            -- upvalues: v0 (ref)
            if not v0.CurrentVote then
                return;
            elseif typeof(v25) ~= "string" then
                return;
            elseif typeof(v26) ~= "Vector2" then
                return;
            else
                local l_FirstChild_0 = v0.CurrentVote.VoteFolder:FindFirstChild(v25);
                if l_FirstChild_0 then
                    local v28 = game.MarketplaceService:UserOwnsGamePassAsync(v24.UserId, 13600173502) and 2 or 1;
                    local v29 = {};
                    for _, v31 in pairs(v0.CurrentVote.VoteFolder:GetChildren()) do
                        for _, v33 in pairs(v31:GetChildren()) do
                            if v33.Name == v24.Name then
                                table.insert(v29, v33);
                            end;
                        end;
                    end;
                    if v28 <= #v29 then
                        table.sort(v29, function(v34, v35) --[[ Line: 112 ]]
                            return v34:GetAttribute("TimeVoted") < v35:GetAttribute("TimeVoted");
                        end);
                        v29[1]:Destroy();
                    end;
                    if not v29[1] or v29[1].Name ~= v25 then
                        local l_StringValue_0 = Instance.new("StringValue");
                        l_StringValue_0.Name = v24.Name;
                        l_StringValue_0.Value = ("%*|%*"):format(math.clamp(v26.X, 0, 1), (math.clamp(v26.Y, 0, 1)));
                        l_StringValue_0:SetAttribute("TimeVoted", tick());
                        l_StringValue_0.Parent = l_FirstChild_0;
                    end;
                end;
                return;
            end;
        end);
        return;
    else
        if v2 then
            local function v71(v37) --[[ Line: 129 ]] --[[ Name: setupMapVoting ]]
                -- upvalues: v0 (ref), v4 (ref)
                if v37.Name == "MapVote" and v37:IsA("Folder") then
                    local l_LocalPlayer_0 = game.Players.LocalPlayer;
                    local v39 = script.MapVoting:Clone();
                    v39.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("MainUI");
                    v39.Position = v39.Position - UDim2.new(0, 0, v39.Size.Y.Scale, v39.Size.Y.Offset + 58);
                    game.TweenService:Create(v39, TweenInfo.new(0.3), {
                        Position = script.MapVoting.Position
                    }):Play();
                    task.spawn(function() --[[ Line: 139 ]]
                        -- upvalues: v39 (copy), v0 (ref)
                        local v40 = 0;
                        while v39.Parent do
                            v39.Timer.Text = ("Time Left: %*"):format((math.abs((math.clamp(math.ceil(v0.VoteDuration - v40), 0, v0.VoteDuration)))));
                            v40 = v40 + task.wait();
                        end;
                    end);
                    local v41 = {};
                    local function v51(v42, v43, v44, v45) --[[ Line: 149 ]] --[[ Name: updateMapVotes ]]
                        -- upvalues: v41 (copy), l_LocalPlayer_0 (copy)
                        v43.Votes.Text = #v42:GetChildren();
                        if v41[v43] then
                            v41[v43]:Cancel();
                        end;
                        local l_Votes_0 = v43.Votes;
                        l_Votes_0.Position = l_Votes_0.Position - UDim2.fromScale(0, 0.05);
                        v41[v43] = game.TweenService:Create(v43.Votes, TweenInfo.new(0.15), {
                            Position = script.MapChoice.Votes.Position
                        });
                        v41[v43]:Play();
                        if v44.Name == l_LocalPlayer_0.Name then
                            game.TweenService:Create(v43, TweenInfo.new(0.25), {
                                ImageColor3 = v45 and Color3.new(1, 0, 0) or Color3.new(1, 1, 1)
                            }):Play();
                        end;
                        if v45 then
                            l_Votes_0 = string.split(v44.Value, "|");
                            local v47 = Vector2.new(l_Votes_0[1], l_Votes_0[2]);
                            local v48 = script.PlayerIcon:Clone();
                            v48.Name = v44.Name;
                            v48.Position = UDim2.fromScale(v47.X, v47.Y);
                            v48.Size = v48.Size + UDim2.fromScale(0.15, 0.15);
                            v48.Parent = v43;
                            game.TweenService:Create(v48, TweenInfo.new(0.175), {
                                Size = v48.Size - UDim2.fromScale(0.15, 0.15)
                            }):Play();
                            if v44.Name == l_LocalPlayer_0.Name then
                                v48.Outline.ImageColor3 = Color3.new(1, 0, 0);
                            end;
                            task.spawn(function() --[[ Line: 184 ]]
                                -- upvalues: v44 (copy), v48 (copy)
                                local l_FirstChild_1 = game.Players:FindFirstChild(v44.Name);
                                if l_FirstChild_1 then
                                    local l_UserId_0 = l_FirstChild_1.UserId;
                                    v48.Image = game.Players:GetUserThumbnailAsync(l_UserId_0, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
                                end;
                            end);
                            return;
                        else
                            l_Votes_0 = v43:FindFirstChild(v44.Name);
                            if l_Votes_0 then
                                l_Votes_0:Destroy();
                            end;
                            return;
                        end;
                    end;
                    local function v65(v52) --[[ Line: 202 ]] --[[ Name: listenForVotes ]]
                        -- upvalues: v39 (copy), v4 (ref), v51 (copy)
                        if not v52:IsA("ModuleScript") then
                            return;
                        else
                            local v53 = require(v52);
                            local v54 = script.MapChoice:Clone();
                            v54.Name = v52.Name;
                            v54.Render.Image = v53.Render or "rbxassetid://77285008779144";
                            v54.TitleButton.Text = v53.DisplayName or v52.Name;
                            v54.Gamemode.Text = v52:GetAttribute("Gamemode") or "Standard";
                            v54.Parent = v39.Choices;
                            local v55 = false;
                            v54.TitleButton.MouseButton1Click:Connect(function() --[[ Line: 215 ]]
                                -- upvalues: v55 (ref), v54 (copy), v4 (ref), v52 (copy)
                                if v55 then
                                    return;
                                else
                                    v55 = true;
                                    task.delay(0.1, function() --[[ Line: 218 ]]
                                        -- upvalues: v55 (ref)
                                        v55 = false;
                                    end);
                                    local v56 = game.UserInputService:GetMouseLocation() - game.GuiService:GetGuiInset();
                                    local l_AbsolutePosition_0 = v54.AbsolutePosition;
                                    local l_AbsoluteSize_0 = v54.AbsoluteSize;
                                    local v59 = math.clamp(v56.X, l_AbsolutePosition_0.X, l_AbsolutePosition_0.X + l_AbsoluteSize_0.X);
                                    local v60 = math.clamp(v56.Y, l_AbsolutePosition_0.Y, l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y);
                                    local v61 = (v59 - l_AbsolutePosition_0.X) / l_AbsoluteSize_0.X;
                                    local v62 = (v60 - l_AbsolutePosition_0.Y) / l_AbsoluteSize_0.Y;
                                    v4:FireServerConnection("VoteForMap", "REMOTE_EVENT", v52.Name, Vector2.new(v61, v62));
                                    return;
                                end;
                            end);
                            v52.ChildAdded:Connect(function(v63) --[[ Line: 231 ]]
                                -- upvalues: v51 (ref), v52 (copy), v54 (copy)
                                v51(v52, v54, v63, true);
                            end);
                            v52.ChildRemoved:Connect(function(v64) --[[ Line: 235 ]]
                                -- upvalues: v51 (ref), v52 (copy), v54 (copy)
                                v51(v52, v54, v64, false);
                            end);
                            return;
                        end;
                    end;
                    for _, v67 in pairs(v37:GetChildren()) do
                        v65(v67);
                    end;
                    v37.ChildAdded:Connect(v65);
                    local function v68() --[[ Line: 245 ]] --[[ Name: closeUI ]]
                        -- upvalues: v39 (copy)
                        game.Debris:AddItem(v39, 0.3);
                        game.TweenService:Create(v39, TweenInfo.new(0.3), {
                            Position = script.MapVoting.Position - UDim2.new(0, 0, v39.Size.Y.Scale, v39.Size.Y.Offset + 58)
                        }):Play();
                    end;
                    v37.AncestryChanged:Connect(function(_, v70) --[[ Line: 251 ]]
                        -- upvalues: v68 (copy)
                        if not v70 then
                            v68();
                        end;
                    end);
                    v39.Close.MouseButton1Click:Connect(v68);
                end;
            end;
            for _, v73 in pairs(game.ReplicatedStorage:GetChildren()) do
                v71(v73);
            end;
            game.ReplicatedStorage.ChildAdded:Connect(v71);
        end;
        return;
    end;
end;
return v0;