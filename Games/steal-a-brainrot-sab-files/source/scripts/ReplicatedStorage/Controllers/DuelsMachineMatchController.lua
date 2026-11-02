-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Packages.ReplicatorClient);
local v4 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v5 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v6 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Shared.UsersAPI);
local _ = require(l_ReplicatedStorage_0.Packages.FFlags);
local v9 = require(l_ReplicatedStorage_0.Packages.Timer);
local v10 = require(l_ReplicatedStorage_0.Packages.Trove);
local v11 = require(l_ReplicatedStorage_0.Packages.Net);
local v12 = require(l_ReplicatedStorage_0.Packages.Spr);
local v13 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v14 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v16 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v17 = require(l_ReplicatedStorage_0.Datas.Animals);
local v18 = require(l_ReplicatedStorage_0.Datas.Traits);
local v19 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local _ = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local v21 = require(l_ReplicatedStorage_0.Shared.Animals);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_DuelsMachineSession_0 = l_PlayerGui_0:WaitForChild("DuelsMachineSession").DuelsMachineSession;
local l_DuelsMachineTopFrame_0 = l_PlayerGui_0:WaitForChild("DuelsMachineTopFrame").DuelsMachineTopFrame;
local l_DuelsMachineAnimation_0 = l_PlayerGui_0:WaitForChild("DuelsMachineAnimation").DuelsMachineAnimation;
local l_Tip_0 = l_PlayerGui_0:WaitForChild("DuelsMachineTopFrame").Tip;
local v29 = false;
return {
    Start = function(_)
        if not v16.IsDuelsServer() then
            return;
        else
            v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/WinnerScreen").OnClientEvent:Connect(function(_)

            end);
            local v32 = v3.get("DuelsRounds");
            v3.get("SelectBrainrots");
            local v33 = v13:Register("DuelsMachineSession", l_DuelsMachineSession_0, "TopQuint");
            v33:AttachCloseButton(l_DuelsMachineSession_0.Header.Close);
            v33:Close();
            local v34 = v4:Wait(l_LocalPlayer_0);
            v3.init();
            local v35 = v10.new();
            local function v90()
                if not workspace:GetAttribute("DuelsSelectBrainrotActive") then
                    v13:SetState("DuelsMachineSession", false);
                    v35:Clean();
                    return;
                else
                    v13:SetState("DuelsMachineSession", true);
                    local v36 = v3.get("SelectBrainrots");
                    v36:WaitForLoaded();
                    local v37 = v35:Extend();
                    local function v45()
                        local v38 = v36:TryIndex({
                            "lastChange"
                        }) or 0;
                        local v39 = v36:TryIndex({
                            "players"
                        }) or {};
                        local v40 = true;
                        for _, v42 in v39 do
                            if not v42.brainrot then
                                v40 = false;
                                break;
                            end;
                        end;
                        local v43 = v39[tostring(l_LocalPlayer_0.UserId)];
                        local v44 = v38 + 5 - workspace:GetServerTimeNow();
                        v12.target(l_DuelsMachineSession_0.Other.Ready, 1, 5, {
                            BackgroundColor3 = if not (v44 <= 0 and v40 and next(v39)) or v43 and v43.accepted then Color3.fromRGB(112, 112, 112) else Color3.fromRGB(81, 158, 86)
                        });
                    end;
                    v35:Add(v36:Observe({
                        "lastChange"
                    }, function(v46)
                        v37:Clean();
                        if v46 == nil then
                            return;
                        else
                            v37:Add(v9.Simple(0.1, function()
                                local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                                local v48 = v46 + 5 - l_workspace_ServerTimeNow_0;
                                l_DuelsMachineSession_0.Other.Timer.Text = v48 <= 0 and "" or ("\226\143\176%*s Left"):format(math.floor(v48 * 10) / 10);
                                v45();
                            end, true));
                            return;
                        end;
                    end));
                    local v49 = {};
                    local v50 = {};
                    v35:Add(v36:Observe({
                        "players"
                    }, function(v51)
                        local v52 = true;
                        for _, v54 in v51 do
                            if not v54.ready or not v54.brainrot then
                                v52 = false;
                                break;
                            end;
                        end;
                        if v52 then
                            l_DuelsMachineSession_0.Other.Ready.Txt.Text = "ACCEPT";
                        else
                            l_DuelsMachineSession_0.Other.Ready.Txt.Text = "READY";
                        end;
                        local function v68(v55, v56, v57)
                            local l_Item_0 = v57.Item;
                            v57.Frame.Ready.Text = v56.accepted and "ACCEPTED" or "READY";
                            v57.Frame.Ready.Visible = v56.ready;
                            v12.target(l_Item_0.UIStroke, 1, 5, {
                                Color = if v56.ready then Color3.fromRGB(0, 255, 0) else Color3.fromRGB(0, 0, 0)
                            });
                            local v59 = ("%*_%*"):format(v56.indexOnPlot, v56.brainrot and v56.brainrot.UUID);
                            if v49[v55] == v59 then
                                return;
                            else
                                v49[v55] = v59;
                                v50[v55]:Clean();
                                local l_brainrot_0 = v56.brainrot;
                                if not l_brainrot_0 then
                                    l_Item_0.Title.Text = "Waiting for player to select...";
                                    l_Item_0.Cash.Text = "";
                                    return;
                                else
                                    local v61 = v17[l_brainrot_0.Index];
                                    l_Item_0.Title.Text = v61 and v61.DisplayName or l_brainrot_0.Index;
                                    l_Item_0.Cash.Text = ("$%*/s"):format((v19:ToString(v21:GetGeneration(l_brainrot_0.Index, l_brainrot_0.Mutation, l_brainrot_0.Traits))));
                                    local v62 = v21:AttachOnViewportWithOptimizations(l_brainrot_0.Index, l_Item_0.ViewportFrame, nil, l_brainrot_0.Mutation);
                                    if v62 then
                                        v50[v55]:Add(v62);
                                    end;
                                    local v63 = l_brainrot_0.Traits or {};
                                    for _, v65 in v63 do
                                        local v66 = v18[v65];
                                        if v66 then
                                            local v67 = v50[v55]:Clone(l_Item_0.Traits.Template);
                                            v67.Name = v65;
                                            v67.Visible = true;
                                            v67.Image = v66.Icon;
                                            v67.Parent = l_Item_0.Traits;
                                        end;
                                    end;
                                    return;
                                end;
                            end;
                        end;
                        for v69, v70 in v51 do
                            if not v50[v69] then
                                v50[v69] = v35:Extend();
                            end;
                            if v69 == tostring(l_LocalPlayer_0.UserId) then
                                l_DuelsMachineSession_0.Your.Frame.Ready.Text = v70.accepted and "ACCEPTED" or "READY";
                                l_DuelsMachineSession_0.Your.Frame.Ready.Visible = v70.ready;
                                l_DuelsMachineSession_0.Main.Visible = v52;
                                l_DuelsMachineSession_0.ScrollingFrame.Visible = not v52;
                                if v52 then
                                    v68(v69, v70, l_DuelsMachineSession_0.Main);
                                end;
                            else
                                local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId((tonumber(v69)));
                                l_DuelsMachineSession_0.Other.Frame.Username.Text = ("@%*'s Offer"):format(if l_l_Players_0_PlayerByUserId_0 then l_l_Players_0_PlayerByUserId_0.Name else "???");
                                l_DuelsMachineSession_0.Other.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v69);
                                v68(v69, v70, l_DuelsMachineSession_0.Other);
                            end;
                        end;
                    end));
                    local v72 = v35:Extend();
                    v35:Add(v34:OnChanged("AnimalPodiums", function(v73)
                        v72:Clean();
                        for v74, v75 in v73 do
                            if typeof(v75) == "table" and not v75.Machine then
                                local v76 = v72:Clone(l_DuelsMachineSession_0.ScrollingFrame.Template);
                                v76.Visible = true;
                                local v77 = v17[v75.Index];
                                v76.Spacer.Title.Text = v77 and v77.DisplayName or v75.Index;
                                v76.Spacer.Cash.Text = ("$%*/s"):format((v19:ToString(v21:GetGeneration(v75.Index, v75.Mutation, v75.Traits))));
                                local v78 = v21:AttachOnViewportWithOptimizations(v75.Index, v76.Spacer.ViewportFrame, nil, v75.Mutation);
                                if v78 then
                                    v72:Add(v78);
                                end;
                                local v79 = v75.Traits or {};
                                for _, v81 in v79 do
                                    local v82 = v18[v81];
                                    if v82 then
                                        local v83 = v72:Clone(v76.Spacer.Traits.Template);
                                        v83.Name = v81;
                                        v83.Visible = true;
                                        v83.Image = v82.Icon;
                                        v83.Parent = v76.Spacer.Traits;
                                    end;
                                end;
                                v76.Parent = l_DuelsMachineSession_0.ScrollingFrame;
                                v72:Add(v76.Spacer.Activated:Connect(function()
                                    v14:PlaySound("Sounds.Sfx.Activated");
                                    v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Select"):FireServer(v74, v75);
                                end));
                                v79 = ("%*_%*"):format(v74, v75.UUID);
                                local v84 = true;
                                do
                                    local l_v84_0 = v84;
                                    v72:Add(v36:Observe({
                                        "players", 
                                        (tostring(l_LocalPlayer_0.UserId))
                                    }, function(v86)
                                        local v87 = ("%*_%*"):format(v86.indexOnPlot, v86.brainrot and v86.brainrot.UUID) == v79;
                                        local v88 = if v87 then Color3.fromRGB(15, 50, 15) else Color3.fromRGB(35, 45, 50);
                                        local v89 = if v87 then Color3.fromRGB(0, 255, 0) else Color3.fromRGB(0, 0, 0);
                                        if l_v84_0 then
                                            l_v84_0 = false;
                                            v76.Spacer.BackgroundColor3 = v88;
                                            v76.Spacer.UIStroke.Color = v89;
                                            return;
                                        else
                                            v12.target(v76.Spacer, 1, 5, {
                                                BackgroundColor3 = v88
                                            });
                                            v12.target(v76.Spacer.UIStroke, 1, 5, {
                                                Color = v89
                                            });
                                            return;
                                        end;
                                    end));
                                end;
                            end;
                        end;
                    end, true));
                    return;
                end;
            end;
            workspace:GetAttributeChangedSignal("DuelsSelectBrainrotActive"):Connect(function()
                v35:Add(task.spawn(v90));
            end);
            v35:Add(task.spawn(v90));
            l_DuelsMachineSession_0.Your.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(l_LocalPlayer_0.UserId);
            l_DuelsMachineSession_0.Other.Ready.Activated:Connect(function()
                local v91 = v3.get("SelectBrainrots");
                if not v91.Data or not workspace:GetAttribute("DuelsSelectBrainrotActive") then
                    return;
                else
                    v14:PlaySound("Sounds.Sfx.Activated");
                    local v92 = true;
                    for _, v94 in v91.Data.players do
                        if not v94.ready or not v94.brainrot then
                            v92 = false;
                            break;
                        end;
                    end;
                    if v92 then
                        v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Accept"):FireServer();
                        return;
                    else
                        v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Ready"):FireServer();
                        return;
                    end;
                end;
            end);
            l_DuelsMachineSession_0.Other.Cancel.Activated:Connect(function()
                if not v3.get("SelectBrainrots").Data or not workspace:GetAttribute("DuelsSelectBrainrotActive") then
                    return;
                else
                    v14:PlaySound("Sounds.Sfx.Activated");
                    v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Cancel"):FireServer();
                    return;
                end;
            end);
            v33.OnClose:Connect(function()
                if not v3.get("SelectBrainrots").Data or not workspace:GetAttribute("DuelsSelectBrainrotActive") then
                    return;
                else
                    v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Cancel"):FireServer();
                    return;
                end;
            end);
            local v95 = v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Animation");
            v11:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/SetDevice"):FireServer(l_UserInputService_0.PreferredInput == Enum.PreferredInput.Gamepad and "Console" or l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch and "Mobile" or "PC");
            local l_Label1_0 = l_DuelsMachineAnimation_0.Label1;
            local l_Label2_0 = l_DuelsMachineAnimation_0.Label2;
            local l_BlurEffect_0 = Instance.new("BlurEffect");
            l_BlurEffect_0.Size = 0;
            l_BlurEffect_0.Parent = workspace.CurrentCamera;
            v95.OnClientEvent:Connect(function(v99)
                while v29 do
                    task.wait();
                end;
                v29 = true;
                l_DuelsMachineAnimation_0.Visible = true;
                v14:PlaySound("Sounds.Sfx.Duels.Countdown", nil, false);
                v5(l_DuelsMachineAnimation_0, TweenInfo.new(0.25), {
                    BackgroundTransparency = 0.25
                });
                v5(l_BlurEffect_0, TweenInfo.new(0.5), {
                    Size = 20
                });
                l_Label1_0.Visible = true;
                l_Label2_0.Visible = true;
                for v100 = v99 // 1, 1, -1 do
                    local v101 = if v100 % 2 == 0 then l_Label1_0 else l_Label2_0;
                    v101.ZIndex = 2;
                    v101.TextTransparency = 1;
                    v101.Size = UDim2.fromScale(0.5, 0.5);
                    v101.Text = v100;
                    v5(v101, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(0.2, 0.2)
                    }).Completed:Once(function()
                        v101.ZIndex = 1;
                        v5(v101, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                            Size = UDim2.fromScale(0, 0)
                        });
                    end);
                    v5(v101, TweenInfo.new(0.35), {
                        TextTransparency = 0
                    });
                    task.wait(1);
                end;
                v5(l_BlurEffect_0, TweenInfo.new(0.25), {
                    Size = 0
                });
                v5(l_DuelsMachineAnimation_0, TweenInfo.new(0.25), {
                    BackgroundTransparency = 1
                }).Completed:Wait();
                l_Label1_0.TextTransparency = 1;
                l_Label2_0.TextTransparency = 1;
                l_Label1_0.Visible = false;
                l_Label2_0.Visible = false;
                l_DuelsMachineAnimation_0.Visible = false;
                v29 = false;
            end);
            l_DuelsMachineTopFrame_0.Visible = false;
            l_DuelsMachineTopFrame_0.Position = UDim2.fromScale(0.5, -0.2);
            l_Tip_0.TextTransparency = 1;
            l_Tip_0.UIStroke.Transparency = 1;
            v32:WaitForLoaded();
            l_DuelsMachineTopFrame_0.Visible = true;
            v5(l_DuelsMachineTopFrame_0, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {
                Position = UDim2.fromScale(0.5, 0.01)
            });
            v5(l_Tip_0, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 1), {
                TextTransparency = 0
            });
            v5(l_Tip_0.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 1), {
                Transparency = 0
            });
            task.delay(10.5, function()
                v5(l_Tip_0, TweenInfo.new(0.5), {
                    TextTransparency = 1
                });
                v5(l_Tip_0.UIStroke, TweenInfo.new(0.5), {
                    Transparency = 1
                });
            end);
            v32:Observe({
                "roundTimer"
            }, function(v102)
                v102 = v102 // 1;
                l_DuelsMachineTopFrame_0.Timer.Label.Text = if v102 > 60 then string.format("%d:%0.2d", v102 // 60, v102 % 60) else ("%*"):format(v102);
            end);
            local v103 = {
                l_DuelsMachineTopFrame_0.Blue, 
                l_DuelsMachineTopFrame_0.Red
            };
            local v104 = {
                PC = "rbxassetid://87143261820372", 
                Console = "rbxassetid://119798532223911", 
                Mobile = "rbxassetid://72402748445638"
            };
            local function v112()
                local v105 = v32:TryIndex({
                    "expectedPlayers"
                });
                local v106 = v32:TryIndex({
                    "roundWins"
                });
                if not v105 or not v106 then
                    return;
                else
                    for v107, v108 in v105 do
                        local v109 = v103[v107];
                        local l_l_Players_0_PlayerByUserId_1 = l_Players_0:GetPlayerByUserId(v108);
                        v109.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v108);
                        v109.Label.Text = tostring(v106[tostring(v108)] or 0);
                        local v111 = l_l_Players_0_PlayerByUserId_1 and l_l_Players_0_PlayerByUserId_1:GetAttribute("Device");
                        if v111 then
                            v109.Icon.Image = v104[v111] or "";
                        end;
                    end;
                    return;
                end;
            end;
            v32:Observe({
                "roundWins"
            }, v112);
            v32:Observe({
                "expectedPlayers"
            }, v112);
            v6.observePlayer(function(v113)
                task.spawn(v112);
                local v114 = v6.observeAttribute(v113, "Device", function()
                    task.spawn(v112);
                    return nil;
                end);
                return function()
                    v114();
                    task.spawn(v112);
                end;
            end);
            return;
        end;
    end
};
