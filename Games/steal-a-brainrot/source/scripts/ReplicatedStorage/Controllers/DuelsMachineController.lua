game:GetService("ServerScriptService")
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SocialService")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v1.Packages.Synchronizer)
local v_u_6 = require(v1.Packages.CreateTween)
local v_u_7 = require(v1.Packages.Observers)
local v_u_8 = require(v1.Shared.UsersAPI)
local v_u_9 = require(v1.Packages.Promise)
local v_u_10 = require(v1.Packages.FFlags)
local v_u_11 = require(v1.Packages.Trove)
local v12 = require(v1.Packages.Net)
local v_u_13 = require(v1.Packages.Spr)
local v_u_14 = require(v1.Controllers.NotificationController)
local v_u_15 = require(v1.Controllers.ConfirmationController)
local v_u_16 = require(v1.Controllers.InterfaceController)
local v_u_17 = require(v1.Controllers.SoundController)
local v_u_18 = require(v1.Classes.AnimatedButton)
local v_u_19 = require(v1.Datas.ServerData)
local v_u_20 = require(v1.Shared.Friends)
local v_u_21 = require(v1.Shared.Updates)
local v_u_22 = v_u_4.LocalPlayer
local v23 = v_u_22.PlayerGui
local v_u_24 = v23:WaitForChild("DuelsMachinePlayerList").DuelsMachinePlayerList
local v_u_25 = v23:WaitForChild("DuelsMachinePrompt").DuelsMachinePrompt
local v_u_26 = v12:RemoteEvent("DuelsMachineService/ReconnectWarn")
local v_u_27 = v12:RemoteEvent("DuelsMachineService/CreateInvite")
local v_u_28 = v12:RemoteEvent("DuelsMachineService/Reconnect")
local v_u_29 = v12:RemoteFunction("DuelsMachineService/AcceptInvite")
local v_u_30 = v12:RemoteFunction("DuelsMachineService/SearchUser")
local v_u_31 = v12:RemoteFunction("DuelsMachineService/Invite")
local v_u_35 = {
    ["IsEnabled"] = function(_)
        local v32 = not (v_u_10:GetInstant("DuelsMachineService/Disabled") or v_u_19.IsNewPlayersServer())
        if v32 then
			local v33 = not v_u_19.IsDuelsServer() and v_u_21.Methods.IsEnabled("Update-04/04/2026")
            v32 = v33 and true or v33
        end
        return v32
    end,
    ["SendInvite"] = function(_, p34)
        return v_u_31:InvokeServer(p34)
    end
}
local v_u_36 = nil
local v_u_37 = 0
local function v_u_39()
    local v38 = DateTime.now().UnixTimestamp
    if v_u_36 == nil or (v38 - v_u_37 >= 600 or v_u_36:getStatus() == v_u_9.Status.Rejected) then
        v_u_37 = v38
        v_u_36 = v_u_9.try(function()
            return v_u_22:GetFriendsOnlineAsync(200)
        end)
    end
    return v_u_36:await()
end
function v_u_35._createPlayerList(_)
    local v40 = v_u_16:Register("DuelsMachinePlayerList", v_u_24, "TopQuint")
    v40:AttachCloseButton(v_u_24.Header.Close)
    v40:Close()
    local v_u_41 = v_u_24.SearchFrame.SearchBox
    local v_u_42 = nil
    local v_u_43 = nil
    local function v_u_55(p44, p45, p46, p47)
        local v48 = p47 or p44:FindFirstChild((("%*_%*"):format(p45.username, p45.userId)))
        if v48 then
            v48.Fill.Status2.Text = p45.inGame and "Online" or (p45.isFriend and "Away" or "Offline")
            local v49 = v48.Fill.Status2
            local v50
            if p45.inGame then
                v50 = Color3.fromRGB(86, 211, 74)
            elseif p45.isFriend then
                v50 = Color3.fromRGB(239, 225, 69)
            else
                v50 = Color3.fromRGB(211, 38, 38)
            end
            v49.TextColor3 = v50
            local v51 = v48.Fill.PlayerImage.Status
            local v52
            if p45.inGame then
                v52 = Color3.fromRGB(86, 211, 74)
            elseif p45.isFriend then
                v52 = Color3.fromRGB(239, 225, 69)
            else
                v52 = Color3.fromRGB(211, 38, 38)
            end
            v51.BackgroundColor3 = v52
            local v53 = v48.Fill.Send
            local v54
            if p45.inGame and p45.canInvite or p45.isFriend then
                v54 = Color3.fromRGB(81, 158, 86)
            else
                v54 = Color3.fromRGB(112, 112, 112)
            end
            v53.BackgroundColor3 = v54
            if not p45.inGame then
                p46 = p46 + 300
            end
            v48.LayoutOrder = p46
        end
    end
    local function v_u_67(p56, p_u_57, p58)
        local v59 = ("%*_%*"):format(p_u_57.username, p_u_57.userId)
        local v_u_60 = v_u_24.LocalList.UIListLayout.Template:Clone()
        v_u_60.Name = v59
        v_u_60.Fill.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(p_u_57.userId)
        v_u_60.Fill.Username.Text = ("@%*"):format(p_u_57.username)
        v_u_55(p56, p_u_57, p58, v_u_60)
        v_u_60.Visible = true
        v_u_60.Parent = p56
        local v_u_61 = false
        v_u_60.Fill.Send.Activated:Connect(function()
            if p_u_57.canInvite and not v_u_61 then
                v_u_17:PlaySound("Sounds.Sfx.Activated")
                if p_u_57.inGame then
                    v_u_61 = true
                    xpcall(function()
                        local v62, v63 = v_u_35:SendInvite(p_u_57.userId)
                        if not v62 and typeof(v63) == "string" then
                            v_u_14:Error(v63)
                        end
                        v_u_60.Fill.Send.Txt.Text = v62 and "SENT!" or "FAILED"
                        task.wait(5)
                        v_u_60.Fill.Send.Txt.Text = "SEND"
                    end, warn)
                    v_u_61 = false
                elseif p_u_57.isFriend then
                    local v64, v65 = pcall(function()
                        return v_u_2:CanSendGameInviteAsync(v_u_22)
                    end)
                    if not (v64 and v65) then
                        return
                    end
                    local v66 = Instance.new("ExperienceInviteOptions")
                    v66.InviteUser = p_u_57.userId
                    v66.PromptMessage = ("Invite %* to a duel"):format(p_u_57.username)
                    v66.LaunchData = v_u_3:JSONEncode({
                        ["type"] = "DuelsInvite",
                        ["sender"] = v_u_22.UserId
                    })
                    v_u_2:PromptGameInvite(v_u_22, v66)
                end
            else
                return
            end
        end)
        return v_u_60
    end
    local v_u_68 = v_u_11.new()
    local function v_u_81()
        local v69 = coroutine.running()
        v_u_43 = v69
        v_u_68:Clean()
        if v_u_42 == "Global" then
            return
        else
			local v70 = v_u_20:GetInGameFriends(v_u_22) or {}
            local v71 = {}
            if v_u_42 == "Server" then
                for _, v72 in v_u_4:GetPlayers() do
                    if v72 ~= v_u_22 then
                        local v73 = {
                            ["username"] = v72.Name,
                            ["userId"] = v72.UserId,
                            ["inGame"] = true,
                            ["canInvite"] = true,
							["isFriend"] = table.find(v70, v72) ~= nil
                        }
                        table.insert(v71, v73)
                    end
                end
            elseif v_u_42 == "Friends" then
                local v74, v75 = v_u_39()
                if v74 and typeof(v75) == "table" then
                    for _, v76 in v75 do
                        local v77 = {
                            ["username"] = v76.UserName,
                            ["userId"] = v76.VisitorId
                        }
                        local v78 = v76.PlaceId
                        if v78 then
							v78 = table.find(v_u_19.AllPlaces or {}, v76.PlaceId) ~= nil
                        end
                        v77.inGame = v78
                        v77.canInvite = true
                        v77.isFriend = true
                        table.insert(v71, v77)
                    end
                end
            end
            if v69 == v_u_43 then
                for v79, v80 in v71 do
                    v_u_68:Add((v_u_67(v_u_24.LocalList, v80, v79)))
                end
            end
        end
    end
    local function v_u_85(p82)
        if v_u_42 ~= p82 then
            v_u_42 = p82
            v_u_41.Text = ""
            v_u_24.LocalList.Visible = v_u_42 ~= "Global"
            v_u_24.GlobalList.Visible = v_u_42 == "Global"
            v_u_24.SearchFrame.Visible = v_u_42 == "Global"
            for _, v83 in v_u_24.Btns:GetChildren() do
                if v83:IsA("GuiButton") then
                    local v84
                    if v_u_42 == v83.Name then
                        v84 = Color3.fromRGB(81, 158, 86)
                    else
                        v84 = Color3.fromRGB(115, 152, 172)
                    end
                    v83.BackgroundColor3 = v84
                end
            end
            v_u_81()
        end
    end
    v_u_4.PlayerAdded:Connect(function()
        if v_u_42 == "Server" then
            v_u_81()
        end
    end)
    v_u_4.PlayerRemoving:Connect(function()
        if v_u_42 == "Server" then
            v_u_81()
        end
    end)
    v_u_24.SearchFrame.SearchBox.FocusLost:Connect(function(p86)
        if p86 then
            local v_u_87 = v_u_41.Text
            v_u_41.TextEditable = false
            v_u_41.Active = false
            v_u_41.Text = "..."
            v_u_68:Clean()
            local v88, v_u_89 = pcall(function()
                return v_u_4:GetUserIdFromNameAsync(v_u_87)
            end)
            if not v88 or typeof(v_u_89) ~= "number" then
                v_u_41.Text = string.find(v_u_89, "Unknown user") and "User not found!" or "Failed to search for user, try again later"
                task.wait(5)
                v_u_41.Text = ""
                v_u_41.TextEditable = true
                v_u_41.Active = true
                return false
            end
            local v90, v91, v92, v93 = pcall(function()
                return v_u_30:InvokeServer(v_u_89)
            end)
            if not (v90 and v91) then
                local v94 = v_u_41
                if typeof(v91) ~= "string" then
                    v91 = typeof(v92) ~= "string" and "Failed to search for user, try again later" or v92
                end
                v94.Text = v91
                task.wait(5)
                v_u_41.Text = ""
                v_u_41.TextEditable = true
                v_u_41.Active = true
                return false
            end
            local v95, v96 = pcall(function()
                return v_u_8:GetUser(v_u_89)
            end)
            local v97 = v_u_68
            local v98 = v_u_67
            local v99 = v_u_24.GlobalList
            local v100 = {
                ["userId"] = v_u_89
            }
            local v101
            if v95 and (typeof(v96) == "table" and v96.IsLoaded) then
                v101 = v96.Username
            else
                v101 = string.upper(v_u_87)
            end
            v100.username = v101
            v100.inGame = v92
            v100.canInvite = v93
            v97:Add((v98(v99, v100, 1)))
            v_u_41.Text = ""
            task.wait(5)
            v_u_41.TextEditable = true
            v_u_41.ClearTextOnFocus = true
            v_u_41.Active = true
        end
    end)
    for _, v102 in v_u_24.Btns:GetChildren() do
        if v102:IsA("GuiButton") then
            local v_u_103 = v102.Name
            local v104 = v_u_18.new(v102)
            v104:Animate()
            v104.OnActivated:Connect(function()
                v_u_85(v_u_103)
            end)
        end
    end
    v_u_85("Server")
    v_u_7.observeTag("DuelsMachinePrompt", function(p105)
        local v_u_106 = p105.Triggered:Connect(function()
            v_u_16:Toggle("DuelsMachinePlayerList")
        end)
        return function()
            v_u_106:Disconnect()
        end
    end)
end
function v_u_35._createInvites(_)
    local v_u_107 = {}
    local v_u_108 = nil
    local function v_u_109()
        if v_u_108 then
            v_u_25.AnchorPoint = Vector2.new(0.5, 1)
            v_u_25.Position = UDim2.fromScale(0.5, 1) + UDim2.fromOffset(0, v_u_108.Position.Y.Offset)
        else
            v_u_25.AnchorPoint = Vector2.new(0.5, 0.5)
            v_u_25.Position = UDim2.fromScale(0.5, 1)
        end
    end
    v_u_7.observeTag("JumpButton", function(p_u_110)
        v_u_108 = p_u_110
        local v_u_111 = p_u_110:GetPropertyChangedSignal("Position"):Connect(v_u_109)
        v_u_109()
        return function()
            v_u_111:Disconnect()
            if v_u_108 == p_u_110 then
                v_u_108 = nil
                v_u_109()
            end
        end
    end)
    local function v_u_114()
        for v112, v113 in v_u_107 do
            if v113.frame then
                v_u_13.target(v113.frame, 1, 5, {
                    ["Position"] = UDim2.fromScale(1, 1 - (v112 - 1) * 0.14800000000000002)
                })
            end
        end
    end
    v_u_27.OnClientEvent:Connect(function(p_u_115, p_u_116)
        print(p_u_115, p_u_116)
        local v117 = workspace:GetServerTimeNow()
        local v118 = p_u_116.expires - v117
        if v118 <= 0 then
            return
        end
        local v119 = v_u_8:GetUser(p_u_116.from)
        if not v119 then
            return
        end
        local v_u_120 = {
            ["id"] = p_u_115,
            ["invite"] = p_u_116,
            ["frame"] = nil
        }
        local v121 = v_u_107
        table.insert(v121, v_u_120)
        local function v_u_123()
            local v122 = table.find(v_u_107, v_u_120)
            if v122 then
                table.remove(v_u_107, v122)
                v_u_114()
                if v_u_120.frame then
                    v_u_13.target(v_u_120.frame, 1, 5, {
                        ["Position"] = UDim2.fromScale(1, 1.2)
                    })
                    task.delay(1, function()
                        v_u_120.frame:Destroy()
                    end)
                end
            end
        end
        for v124, v125 in v_u_107 do
            if v125 == v_u_120 then
                v131 = 1 - (v124 - 1) * 0.14800000000000002
                local v_u_126 = nil
                local v127 = v_u_25.InviteTemplate:Clone()
                v127.Username.Text = ("@%* invited you to a Duel!"):format(v119.Username)
                v127.Visible = true
                v127.Position = UDim2.fromScale(1.3, v131)
                v127.Parent = v_u_25
                v_u_6(v127.Fill, TweenInfo.new(v118), {
                    ["Size"] = UDim2.fromScale(0, v127.Fill.Size.Y.Scale)
                })
                local v_u_128 = false
                v127.Yes.Activated:Connect(function()
                    if v_u_128 then
                        return
                    else
                        v_u_17:PlaySound("Sounds.Sfx.Activated")
                        if workspace:GetServerTimeNow() > p_u_116.expires then
                            v_u_123()
                        else
                            v_u_128 = true
                            xpcall(function()
                                local v129, v130 = v_u_29:InvokeServer(p_u_115)
                                if v129 or typeof(v130) ~= "string" then
                                    if v_u_126 and coroutine.status(v_u_126) == "suspended" then
                                        pcall(task.cancel, v_u_126)
                                    end
                                    v_u_123()
                                else
                                    v_u_14:Error(v130)
                                end
                            end, warn)
                            v_u_128 = false
                        end
                    end
                end)
                v127.No.Activated:Connect(function()
                    if workspace:GetServerTimeNow() > p_u_116.expires then
                        v_u_123()
                    else
                        v_u_17:PlaySound("Sounds.Sfx.Activated")
                        if v_u_126 and coroutine.status(v_u_126) == "suspended" then
                            pcall(task.cancel, v_u_126)
                        end
                        v_u_123()
                    end
                end)
                v_u_120.frame = v127
                v_u_114()
                v_u_126 = task.delay(v118, v_u_123)
                return
            end
        end
        local v131 = 1
    end)
    v_u_28.OnClientEvent:Connect(function(p_u_132)
        local _, v133 = pcall(function()
            return v_u_8:GetUser(p_u_132)
        end)
        if v133 and v133.IsLoaded then
            local v134 = v_u_5:Wait(v_u_22)
            if v134 then
                local v135 = v_u_15:Show(("You disconnected an active duel with @%*"):format(v133.Username), 600, "ReconnectTemplate")
                if not v135 then
                    if v134:Get("DuelsReconnectWarn") then
                        return
                    end
                    if v_u_15:Show("Leaving the duel will count as a forfeit and you will lose your brainrot! Are you sure?", 60, "WarningTemplate") then
                        v_u_26:FireServer()
                        return
                    end
                end
                v_u_28:FireServer(v135)
            end
        else
            return
        end
    end)
end
function v_u_35.Start(p136)
    task.spawn(p136._createPlayerList, p136)
    task.spawn(p136._createInvites, p136)
end
return v_u_35