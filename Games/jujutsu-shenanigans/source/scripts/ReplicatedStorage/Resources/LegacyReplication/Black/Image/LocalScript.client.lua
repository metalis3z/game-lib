local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v1 = require(game.ReplicatedStorage.Info);
local l_Parent_0 = script.Parent;
local l_TextButton_0 = l_Parent_0.TitlesSF.TextButton;
l_TextButton_0.Parent = script;
l_LocalPlayer_0:WaitForChild("LoadedData");
wait();
l_LocalPlayer_0:WaitForChild("GamepassesLoaded", 5);
if not l_LocalPlayer_0:GetAttribute("AllowedTitles") then
    local v7 = tick();
    while true do
        task.wait();
        if not (tick() - v7 <= 5 and not l_LocalPlayer_0:GetAttribute("AllowedTitles")) then
            break;
        end;
    end;
end;
local v8 = {
    {
        id = 1849123672, 
        count = 1
    }, 
    {
        id = 1849161369, 
        count = 3
    }, 
    {
        id = 1849161479, 
        count = 5
    }
};
shared.cosgui = function()
    local l_Parent_1 = l_Parent_0.Parent;
    if not l_Parent_1.Enabled then
        local l_Children_0 = l_LocalPlayer_0.PlayerGui:GetChildren();
        l_LocalPlayer_0.Character.Communicate:FireServer({
            Goal = "Delete Guis", 
            guis = l_Children_0, 
            caller = script.Parent
        });
        for _, v12 in pairs(l_Children_0) do
            if not (v12.Name ~= "Cape Customization" and v12.Name ~= "Awakening Outfit") or v12.Name == "Kill Sound" then
                game:GetService("Debris"):AddItem(v12, 0);
            elseif (not (v12.Name ~= "Emotes") or v12.Name == "Gifting") and v12 ~= script.Parent.Parent then
                local v13 = v12:FindFirstChild("ImageLabel") or v12:FindFirstChild("Frame");
                if v13 then
                    v13.Visible = true;
                    v13.Visible = false;
                end;
            end;
        end;
    end;
    l_Parent_1.Enabled = not l_Parent_1.Enabled;
end;
local v14 = table.clone(v1.Cosmetics);
for v15, v16 in pairs(v14) do
    if v16[1] == "Special Stuff" and not v1.Special[l_LocalPlayer_0.UserId] then
        table.remove(v14, v15);
        break;
    end;
end;
local v17 = {};
local function v28(v18, v19)
    local v20 = "<font color=\"rgb(%s, %s, %s)\">%s</font>";
    local v21 = 255;
    local v22 = 101;
    local v23 = 101;
    local v24 = false;
    if v19[2] == 10000000000 then
        v20 = "<font color=\"rgb(255, 216, 19)\">ONLY YOURS</font>";
    elseif v19[2] == 100000000000 then
        v20 = "<font color=\"rgb(156, 182, 255)\">THE HUNT</font>";
    elseif v19[2] > 1000000 then
        v20 = "<font color=\"rgb(255, 216, 19)\">VIP ONLY</font>";
    elseif v19[2] == 1000000 then
        v20 = "<font color=\"rgb(169, 255, 176)\">GROUP ONLY</font>";
    else
        local v25 = l_LocalPlayer_0:GetAttribute("CosmeticGamepass") and v19[5];
        local v26 = nil;
        local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Cosmetics");
        v26 = rawget(game:GetService("HttpService"):JSONDecode(l_l_LocalPlayer_0_Attribute_0), v19[1]);
        if not ((l_LocalPlayer_0:GetAttribute("TotalKillsFrb") or 0) < v19[2] and not v25) or v26 then
            v21 = 143;
            v22 = 204;
            v23 = 140;
            game:GetService("TweenService"):Create(v18.ImageLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.new(1, 1, 1)
            }):Play();
        elseif not v25 then
            v18.ImageLabel.ImageColor3 = Color3.new(0, 0, 0);
            v24 = true;
        end;
        v20 = string.format(v20, v21, v22, v23, "%s");
    end;
    if not v24 then
        if not l_LocalPlayer_0.Character:GetAttribute("WC_" .. string.gsub(v19[1], " ", "")) then
            game:GetService("TweenService"):Create(v18.ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.new(0.35, 0.35, 0.35)
            }):Play();
        else
            game:GetService("TweenService"):Create(v18.ImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.new(1, 1, 1)
            }):Play();
        end;
    end;
    if v19[3] then
        v18.ImageLabel.Image = v19[3];
    else
        v18.ImageLabel.Image = "rbxassetid://16523852699";
    end;
    if v19[2] <= 0 then
        v18.Info.Info.Text = string.format(v20, "FREE");
        return ;
    else
        v18.Info.Info.Text = string.format(v20, v19[2] .. " KILLS");
        return ;
    end;
end;
local function v37()
    for _, v35 in pairs(v17) do
        local v36 = v35[1];
        v28(v36, v35[2]);
    end;
end;
l_LocalPlayer_0:GetAttributeChangedSignal("TotalKillsFrb"):Connect(v37);
l_LocalPlayer_0:GetAttributeChangedSignal("Update"):Connect(v37);
l_LocalPlayer_0:GetAttributeChangedSignal("HandlerLoaded"):Connect(v37);
l_LocalPlayer_0:GetAttributeChangedSignal("CosmeticGamepass"):Connect(v37);
for _, v39 in pairs(v17) do
    v28(v39[1], v39[2]);
end;
for _, v41 in pairs(l_Parent_0:GetChildren()) do
    if v41:IsA("ScrollingFrame") then
        local function v42()
            v41.CanvasSize = UDim2.new(0, 0, 0, v41.UIGridLayout.AbsoluteContentSize.Y);
        end;
        v41.CanvasSize = UDim2.new(0, 0, 0, v41.UIGridLayout.AbsoluteContentSize.Y);
        v41.UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v42);
    elseif v41:IsA("TextButton") then
        v41.MouseButton1Click:Connect(function()
            local v43 = string.sub(v41.Text, 2, #v41.Text):lower();
            local v44 = string.sub(v41.Text, 1, 1):upper();
            local l_l_Parent_0_FirstChild_0 = l_Parent_0:FindFirstChild(v44 .. v43 .. "SF");
            for _, v47 in pairs(l_Parent_0:GetChildren()) do
                if v47:IsA("ScrollingFrame") and v47 ~= l_l_Parent_0_FirstChild_0 then
                    v47.Visible = false;
                end;
            end;
            if not l_l_Parent_0_FirstChild_0.Visible then
                l_l_Parent_0_FirstChild_0.Visible = true;
                shared.sfx({
                    SoundId = "rbxassetid://15675032796", 
                    Parent = workspace, 
                    Volume = 0.5
                }):Play();
            end;
        end);
    end;
end;
local function v53()
    local v48 = 0;
    local l_l_LocalPlayer_0_Attribute_1 = l_LocalPlayer_0:GetAttribute("Cosmetics");
    local v50 = {};
    l_l_LocalPlayer_0_Attribute_1 = game:GetService("HttpService"):JSONDecode(l_l_LocalPlayer_0_Attribute_1);
    for _, v52 in pairs(v1.Cosmetics) do
        if not (l_LocalPlayer_0:GetAttribute("CosmeticGamepass") and v52[5]) and (l_LocalPlayer_0:GetAttribute("TotalKillsFrb") or 0) < v52[2] and not l_l_LocalPlayer_0_Attribute_1[v52[1]] and v52[2] < 100000 then
            v48 = v48 + 1;
            table.insert(v50, v52);
        end;
    end;
    return v48, v50;
end;
local function v67()
    local l_TitlesSF_0 = l_Parent_0.TitlesSF;
    for _, v56 in pairs(l_TitlesSF_0:GetChildren()) do
        if not v56:IsA("UIGridLayout") then
            v56:Destroy();
        end;
    end;
    local v57 = v53();
    for _, v59 in pairs(v8) do
        if v59.button then
            if v59.count <= v57 then
                v59.button.Visible = true;
            else
                v59.button.Visible = false;
            end;
        end;
    end;
    local v60 = game:GetService("HttpService"):JSONDecode(l_LocalPlayer_0:GetAttribute("AllowedTitles") or "[]");
    for _, v62 in pairs(game:GetService("HttpService"):JSONDecode(l_LocalPlayer_0:GetAttribute("StoredTitles") or "[]")) do
        local v63 = l_TextButton_0:Clone();
        local l_Frame_1 = v63.Frame;
        if v60[v62] then
            l_Frame_1.BackgroundColor3 = Color3.fromRGB(130, 255, 116);
        else
            l_Frame_1.BackgroundColor3 = Color3.fromRGB(255, 87, 87);
        end;
        v63.Text = v62;
        if v62 == "Rank Title" then
            v63.Text = string.format("Rank Title %s", l_LocalPlayer_0:GetAttribute("OGRankTitle") or "N/A");
        end;
        if v62 == "Duel Title" then
            v63.Text = string.format("Duel Title %s", l_LocalPlayer_0:GetAttribute("OGDuelTitle") or "N/A");
        end;
        v63.Parent = l_TitlesSF_0;
        v63.MouseButton1Click:Connect(function()
            shared.sfx({
                SoundId = "rbxassetid://552900451", 
                Parent = workspace, 
                Volume = 0.5
            }):Play();
            local l_l_LocalPlayer_0_Attribute_2 = l_LocalPlayer_0:GetAttribute("AllowedTitles");
            local v66 = nil;
            l_l_LocalPlayer_0_Attribute_2 = game:GetService("HttpService"):JSONDecode(l_l_LocalPlayer_0_Attribute_2);
            if l_l_LocalPlayer_0_Attribute_2[v62] then
                l_l_LocalPlayer_0_Attribute_2[v62] = false;
            else
                l_l_LocalPlayer_0_Attribute_2[v62] = true;
            end;
            v66 = l_l_LocalPlayer_0_Attribute_2;
            l_l_LocalPlayer_0_Attribute_2 = game:GetService("HttpService"):JSONEncode(l_l_LocalPlayer_0_Attribute_2);
            if v66[v62] then
                l_Frame_1.BackgroundColor3 = Color3.fromRGB(130, 255, 116);
            else
                l_Frame_1.BackgroundColor3 = Color3.fromRGB(255, 87, 87);
            end;
            l_LocalPlayer_0.Character.Communicate:FireServer({
                Goal = "Update Titles", 
                Title = l_l_LocalPlayer_0_Attribute_2
            });
        end);
    end;
end;
l_LocalPlayer_0:GetAttributeChangedSignal("StoredTitles"):Connect(v67);
l_LocalPlayer_0:GetAttributeChangedSignal("OGRankTitle"):Connect(v67);
l_LocalPlayer_0:GetAttributeChangedSignal("OGDuelTitle"):Connect(v67);
v67();
v67();
for _, v76 in pairs(v17) do
    v28(v76[1], v76[2]);
end;
l_LocalPlayer_0:GetAttributeChangedSignal("Cosmetics"):Connect(function()
    for _, v78 in pairs(v17) do
        local v79 = v78[1];
        v28(v79, v78[2]);
    end;
    v67();
end);
local l_Main_0 = script.Parent.Parent.Main;
local l_Parent_2 = script.Parent;
local v82 = {};
local v83 = {
    53, 
    25, 
    73, 
    29, 
    15, 
    329
};
local function _(v84, v85, v86)
    return v84 + (v85 - v84) * v86;
end;
l_LocalPlayer_0:GetAttributeChangedSignal("NewCosmetic"):Connect(function()
    l_Parent_2.Visible = false;
    local l_l_LocalPlayer_0_Attribute_3 = l_LocalPlayer_0:GetAttribute("NewCosmetic");
    l_l_LocalPlayer_0_Attribute_3 = game:GetService("HttpService"):JSONDecode(l_l_LocalPlayer_0_Attribute_3);
    local v89 = {};
    for _ = 1, #l_l_LocalPlayer_0_Attribute_3 do
        local _, v92 = v53();
        table.insert(v89, v92);
    end;
    for v93, v94 in pairs(l_l_LocalPlayer_0_Attribute_3) do
        local v95 = v89[v93];
        l_Main_0.ImageLabel.Rotation = 0;
        for _, v97 in pairs(v82) do
            v97.brake = true;
        end;
        table.clear(v82);
        for _, v99 in pairs(l_Main_0.ImageLabel:GetChildren()) do
            local l_ImageLabel_0 = v99:FindFirstChildOfClass("ImageLabel");
            if l_ImageLabel_0 then
                l_ImageLabel_0.Image = v95[math.random(#v95)][3];
            end;
        end;
        l_Main_0.Visible = true;
        local v101 = -(-1440 + 52 * math.random(#v83));
        local v102 = nil;
        for _, v104 in pairs(v95) do
            if v104[1] == v94 then
                v102 = v104;
            end;
        end;
        l_Main_0.ImageLabel[v101].ImageLabel.Image = v102[3];
        local l_ImageLabel_1 = l_Main_0.ImageLabel;
        l_ImageLabel_1.Rotation = 0;
        local v106 = 15;
        if #l_l_LocalPlayer_0_Attribute_3 > 5 then
            v106 = 125;
        elseif #l_l_LocalPlayer_0_Attribute_3 > 1 then
            v106 = 50;
        end;
        local v107 = {};
        local v108 = 0;
        v107.brake = false;
        table.insert(v82, v107);
        local v109 = false;
        local v110 = tick();
        local v111 = nil;
        do
            local l_v106_0, l_v108_0, l_v109_0, l_v111_0 = v106, v108, v109, v111;
            l_v111_0 = shared.loop(function()
                local v116 = 1 - l_ImageLabel_1.Rotation / v101;
                local v117 = l_v106_0 * v116;
                if v116 <= 0.001 then
                    v116 = 0;
                end;
                l_ImageLabel_1.Rotation = math.clamp(l_ImageLabel_1.Rotation + v117, 0, v101);
                if l_ImageLabel_1.Rotation - l_v108_0 > 15 then
                    l_v108_0 = l_ImageLabel_1.Rotation;
                    shared.sfx({
                        SoundId = "rbxassetid://17849584689", 
                        Parent = workspace, 
                        PlaybackSpeed = 1 + l_ImageLabel_1.Rotation / v101, 
                        Volume = 1
                    }):Play();
                end;
                if not (v101 > l_ImageLabel_1.Rotation and not v107.brake) or v116 == 0 then
                    if v116 == 0 then
                        local function _()
                            return (math.random(1, 2) == 1 and -1 or 1) * Random.new():NextNumber(1, 3);
                        end;
                        shared.sfx({
                            SoundId = "rbxassetid://17849807535", 
                            Parent = workspace, 
                            Volume = 2
                        }):Play();
                        local v119 = {};
                        local v120 = 1;
                        local v121 = #l_l_LocalPlayer_0_Attribute_3 == 5 and v93 ~= #l_l_LocalPlayer_0_Attribute_3 and 5 or 25;
                        for _ = v120, v121 do
                            local v123 = (math.random(1, 2) == 1 and -1 or 1) * Random.new():NextNumber(1, 3) * math.random();
                            local v124 = Random.new():NextNumber(1, 3);
                            local v125 = (math.random(1, 2) == 1 and -1 or 1) * Random.new():NextNumber(1, 3) * math.random();
                            local v126 = Random.new():NextNumber(0.4, 0.6);
                            local l_Frame_2 = Instance.new("Frame");
                            l_Frame_2.BorderSizePixel = 0;
                            l_Frame_2.Rotation = math.random(-360, 360);
                            l_Frame_2.BackgroundColor3 = BrickColor.Random().Color;
                            l_Frame_2.Size = UDim2.new(v126, 0, v126, 0);
                            l_Frame_2.Parent = l_Main_0.Arrow;
                            local v128 = {
                                l_Frame_2, 
                                v123, 
                                v124, 
                                v125
                            };
                            task.delay(Random.new():NextNumber(0.6, 1.2), function()
                                local v129 = Random.new():NextNumber(1, 2);
                                l_Frame_2:TweenSize(UDim2.new(0, 0, 0, 0), nil, nil, v129);
                                task.delay(v129, function()
                                    l_Frame_2:Destroy();
                                    table.remove(v119, table.find(v119, v128));
                                end);
                            end);
                            table.insert(v119, v128);
                        end;
                        task.delay(#l_l_LocalPlayer_0_Attribute_3 == 5 and 0.5 or 1.5, function()
                            l_v109_0 = true;
                        end);
                        v121 = tick();
                        local v130 = nil;
                        do
                            local l_v130_0 = v130;
                            l_v130_0 = shared.loop(function()
                                if not (tick() - v121 <= 3) or #v119 == 0 then
                                    return l_v130_0();
                                else
                                    for _, v133 in pairs(v119) do
                                        local v134 = v133[2];
                                        local v135 = v133[3];
                                        local _ = v133[4];
                                        v133[2] = v133[2] * 0.99;
                                        v133[3] = v133[3] - 0.08;
                                        local v137 = v133[1];
                                        v134 = v134 * 5;
                                        v135 = v135 * 5;
                                        v137.Rotation = v137.Rotation + 0.1;
                                        v137.Position = UDim2.new(v137.Position.X.Scale, v137.Position.X.Offset + v134, v137.Position.Y.Scale, v137.Position.Y.Offset + v135);
                                    end;
                                    return ;
                                end;
                            end, 60);
                        end;
                    end;
                    if v93 == #l_l_LocalPlayer_0_Attribute_3 then
                        task.delay(#l_l_LocalPlayer_0_Attribute_3 > 1 and 1.75 or 3, function()
                            l_Main_0.Visible = false;
                            l_Parent_2.Visible = true;
                        end);
                    end;
                    return l_v111_0();
                else
                    return ;
                end;
            end, 60);
            while true do
                task.wait();
                if not (not l_v109_0 and tick() - v110 <= 25) then
                    break;
                end;
            end;
        end;
    end;
end);