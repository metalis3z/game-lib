local tbl_upv_1 = {}
local _ = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType")
)
local v1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild(
        "EventInfoService"
    )
):WaitForInitializedAsync()
local ItemService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService")
)
local TimestampService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild(
        "TimestampService"
    )
)
local u1 = v1:GetMainEvent()
local u2 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild(
    u1.Title .. "Remotes"
)
local ProfileData_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData")
)
local NavigationService_upv_1 = require(script.Parent:WaitForChild("NavigationService"))
local Container_1 = script.Parent.Parent:WaitForChild("Container")
local Main_1 = Container_1:WaitForChild("Main")
local Navigation_upv_1 = Container_1:WaitForChild("Title"):WaitForChild("Navigation")
local Quests_upv_1 = Main_1:WaitForChild("Quests")
local QuestFrame_upv_1 = Quests_upv_1:WaitForChild("QuestFrame")
QuestFrame_upv_1.Parent = script
QuestFrame_upv_1.ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None
local u3 = 10
local v2 = QuestFrame_upv_1.ScrollingFrame:FindFirstChildOfClass("UIPadding")
if (v2) then
    u3 = u3 + (v2.PaddingLeft.Offset + v2.PaddingRight.Offset)
end
local Daily_upv_1 = Navigation_upv_1:WaitForChild("Daily")
Daily_upv_1.Parent = script
local Weekly_1 = Navigation_upv_1:FindFirstChild("Weekly")
if (Weekly_1) then
    Weekly_1.Visible = false
end
local Main_2 = QuestFrame_upv_1.ScrollingFrame.QuestFrame.Main
local Container_2 = Main_2.Progress.Progress.Progress.Container
local BackgroundColor3_upv_1 = Container_2.Bar.BackgroundColor3
local BackgroundColor3_upv_2 = Container_2.BackgroundColor3
local u4 = Main_2.Rewards.Reward1:Clone()
local u5 = Main_2.Challenges.Challenge1:Clone()
local u6 = Container_2.Checkpoint1:Clone()
local u7 = Container_2.CheckpointBackground1:Clone()
u6.BackgroundColor3 = BackgroundColor3_upv_2
u7.BackgroundColor3 = BackgroundColor3_upv_2
u7.UIStroke.Color = BackgroundColor3_upv_2
u5.AnchorPoint = Vector2.new(0.5, u5.AnchorPoint.Y)
for v3, value_1 in Main_2.Rewards:GetChildren() do
    if (value_1:IsA("Frame")) then
        value_1:Destroy()
    end
end
for v4, value_2 in Main_2.Challenges:GetChildren() do
    if (value_2:IsA("Frame")) then
        value_2:Destroy()
    end
end
for v5, value_3 in Container_2:GetChildren() do
    if (value_3.Name:match("^Checkpoint")) then
        value_3:Destroy()
    end
end
local tbl_upv_2 = {}
local function GetRefreshTime(a1)
    local UnixTimestamp_1 = DateTime.now().UnixTimestamp
    local tbl_3 = {}
    tbl_3.Text = TimestampService_upv_1:GetTimeLeftText(
        (TimestampService_upv_1:GetCurrentPeriodStartPST(a1, u1.EventStartTime) + a1)
            - UnixTimestamp_1
    )
    return tbl_3
end
local function UpdateRefreshTime(a1)
    local v3 = u1.EventStartInfo.Quests[a1]
    local RefreshLabel_1 = tbl_upv_2[a1].RefreshLabel
    if (v3.RefreshTime) then
        RefreshLabel_1.Text = ("Refreshes in %*"):format(GetRefreshTime(v3.RefreshTime).Text)
        RefreshLabel_1.Visible = true
    else
        RefreshLabel_1.Visible = false
    end
end
local function GetVisualProgress(a1, a2, a3)
    local v4, v5 = nil, nil
    for n_1 = 1, #a2 do
        v4 = ((n_1 == 1) and 0) or (a2[n_1 - 1].ChallengeAmount)
        v5 = a2[n_1].ChallengeAmount
        if (a1 > v5) then
            continue
        end
        local v6 = ((n_1 == 1) and 0) or (a3[n_1 - 1])
        return v6 + (math.clamp((a1 - v4) / (v5 - v4), 0, 1) * (a3[n_1] - v6))
    end
    return a3[#a2] or 1
end
local function UpdateProgressBar(a1, a2)
    local v7 = u1.EventStartInfo.Quests[a1]
    local v8 = tbl_upv_2[a1]
    v8.CurrentProgress = a2
    if (#v8.CheckpointScales < #v7.Quests) then
        return
    end
    local ProgressFrame_1 = v8.ProgressFrame
    local v9 = GetVisualProgress(a2, v7.Quests, v8.CheckpointScales)
    ProgressFrame_1.Current.Position = UDim2.fromScale(v9, 0.5)
    ProgressFrame_1.Current.AmountLabel.Text = tostring(a2)
    ProgressFrame_1.Container.Bar.Size = UDim2.fromScale(v9, 1)
    local v10 = nil
    for n_2 = 1, #v7.Quests do
        local v11 = v7.Quests[n_2].ChallengeAmount <= a2
        local v12 = ProgressFrame_1.Container:FindFirstChild(("Checkpoint%*"):format(n_2))
        if (v11) then
            v10 = BackgroundColor3_upv_1
        else
            v10 = BackgroundColor3_upv_2
        end
        v12.BackgroundColor3 = v10
        v8.RewardFrames[n_2].Claimed.Visible = v11
    end
end
local function UpdateQuestLayout(a1)
    local u8 = tbl_upv_2[a1]
    local X_1 = u8.RewardsFrame.UIListLayout.AbsoluteContentSize.X
    if (X_1 <= 0) then
        return
    end
    u8.RewardsFrame.Size = UDim2.new(
        0,
        X_1,
        u8.RewardsFrame.Size.Y.Scale,
        u8.RewardsFrame.Size.Y.Offset
    )
    u8.ProgressOuter.Size = UDim2.new(
        0,
        X_1,
        u8.ProgressOuter.Size.Y.Scale,
        u8.ProgressOuter.Size.Y.Offset
    )
    u8.ChallengesFrame.Size = UDim2.new(
        0,
        X_1,
        u8.ChallengesFrame.Size.Y.Scale,
        u8.ChallengesFrame.Size.Y.Offset
    )
    local X_2 = u8.ScrollingFrame.AbsoluteWindowSize.X
    local v13 = X_1 + u3 <= X_2
    u8.ScrollingFrame.CanvasSize = UDim2.fromOffset(math.max(X_1 + u3, X_2), 0)
    local PageLayout_1 = u8.PageLayout
    local v14
    if (v13) then
        v14 = Enum.HorizontalAlignment.Center
    else
        v14 = Enum.HorizontalAlignment.Left
    end
    PageLayout_1.HorizontalAlignment = v14
    task.defer(
        function()
            local Container_3 = u8.ProgressFrame.Container
            local X_3 = Container_3.AbsolutePosition.X
            local v15 = math.max(Container_3.AbsoluteSize.X, 1)
            local X_4 = u8.ChallengesFrame.AbsolutePosition.X
            local v16 = math.max(u8.ChallengesFrame.AbsoluteSize.X, 1)
            for key_1, value_4 in u8.RewardFrames do
                local v17 = value_4.AbsolutePosition.X + value_4.AbsoluteSize.X / 2
                local v18 = (v17 - X_3) / v15
                u8.CheckpointScales[key_1] = v18
                local v19 = Container_3:FindFirstChild(("Checkpoint%*"):format(key_1))
                v19.Position = UDim2.fromScale(v18, 0.5)
                local v20 = Container_3:FindFirstChild(("CheckpointBackground%*"):format(key_1))
                v20.Position = UDim2.fromScale(v18, 0.5)
                local v21 = u8.ChallengeFrames[key_1]
                v21.Position = UDim2.new(
                    (v17 - X_4) / v16,
                    0,
                    v21.Position.Y.Scale,
                    v21.Position.Y.Offset
                )
            end
            UpdateProgressBar(a1, u8.CurrentProgress)
        end
    )
end
function tbl_upv_1.ShowQuest(a1, a2)
    local v22 = nil
    for key_2, value_5 in tbl_upv_2 do
        local v23 = key_2 == a2
        value_5.PageFrame.Visible = v23
        local TabFrame_1 = value_5.TabFrame
        if (v23) then
            v22 = 0
        else
            v22 = 0.5
        end
        TabFrame_1.BackgroundTransparency = v22
    end
end
function tbl_upv_1.GenerateQuestFrames(a1)
    local Quests_upv_2 = ProfileData_upv_1[u1.Title].Quests
    local v24 = nil
    local v25 = nil
    for key_upv_3, value_6 in u1.EventStartInfo.Quests do
        local v26 = QuestFrame_upv_1:Clone()
        v26.Name = key_upv_3
        v26.LayoutOrder = value_6.LayoutOrder
        v26.Visible = false
        local Container_4 = v26.Title.Container
        Container_4.TitleLabel.Text = value_6.Title
        v26.Description.Container.TitleLabel.Text = value_6.Description or ""
        local Main_3 = v26.ScrollingFrame.QuestFrame.Main
        local Progress_1 = Main_3.Progress
        local Progress_2 = Progress_1.Progress.Progress
        local v27 = Daily_upv_1:Clone()
        v27.Name = key_upv_3
        v27.LayoutOrder = value_6.LayoutOrder
        v27.TextLabel.Text = value_6.Subtitle or (value_6.Title)
        v27.Parent = Navigation_upv_1
        local tbl_4 = {}
        tbl_4.PageFrame = v26
        tbl_4.TabFrame = v27
        tbl_4.ScrollingFrame = v26.ScrollingFrame
        tbl_4.PageLayout = v26.ScrollingFrame.QuestFrame.UIListLayout
        tbl_4.RefreshLabel = Container_4.RefreshLabel
        tbl_4.ProgressOuter = Progress_1
        tbl_4.ProgressFrame = Progress_2
        tbl_4.RewardsFrame = Main_3.Rewards
        tbl_4.ChallengesFrame = Main_3.Challenges
        tbl_4.RewardFrames = {}
        tbl_4.ChallengeFrames = {}
        tbl_4.CheckpointScales = {}
        tbl_4.CurrentProgress = Quests_upv_2[key_upv_3].Progress
        tbl_upv_2[key_upv_3] = tbl_4
        for key_4, value_7 in value_6.Quests do
            local v28 = u4:Clone()
            v28.Name = ("Reward%*"):format(key_4)
            v28.LayoutOrder = key_4
            local v29 = ItemService_upv_1:GetDisplayInfo(value_7.RewardID, value_7.RewardType)
            v28.ItemFrame.Container.Icon.Image = v29.Image
            v28.ItemFrame.ItemName.TextLabel.Text = v29.Name
            v28.ItemFrame.ItemName.BackgroundColor3 = v29.Color
            local Amount_1 = v28.ItemFrame.Container.Amount
            Amount_1.Text = value_7.RewardAmount <= 1 and "" or ("x%*"):format(value_7.RewardAmount)
            v28.Parent = tbl_4.RewardsFrame
            tbl_4.RewardFrames[key_4] = v28
            local v31 = u6:Clone()
            v31.Name = ("Checkpoint%*"):format(key_4)
            v31.Parent = Progress_2.Container
            local v32 = u7:Clone()
            v32.Name = ("CheckpointBackground%*"):format(key_4)
            v32.Parent = Progress_2.Container
            local v33 = u5:Clone()
            v33.Name = ("Challenge%*"):format(key_4)
            v33.TextLabel.Text = tostring(value_7.ChallengeAmount)
            v33.Parent = tbl_4.ChallengesFrame
            tbl_4.ChallengeFrames[key_4] = v33
        end
        v27.InputBegan:Connect(
            function(a2)
                if (a2.UserInputType ~= Enum.UserInputType.MouseButton1
                    and a2.UserInputType ~= Enum.UserInputType.Touch) then
                    return
                end
                NavigationService_upv_1:GoToPage("Quests")
                tbl_upv_1:ShowQuest(key_upv_3)
            end
        )
        local v34 = u1.EventStartInfo.Quests[key_upv_3]
        local RefreshLabel_2 = tbl_upv_2[key_upv_3].RefreshLabel
        if (v34.RefreshTime) then
            RefreshLabel_2.Text = ("Refreshes in %*"):format(GetRefreshTime(v34.RefreshTime).Text)
            RefreshLabel_2.Visible = true
        else
            RefreshLabel_2.Visible = false
        end
        v26.Parent = Quests_upv_1
        UpdateQuestLayout(key_upv_3)
        tbl_4.RewardsFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                UpdateQuestLayout(key_upv_3)
            end
        )
        tbl_4.ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(
            function()
                UpdateQuestLayout(key_upv_3)
            end
        )
        if (not (v25) or value_6.LayoutOrder < v25) then
            v25, v24 = value_6.LayoutOrder, key_upv_3
        end
    end
    if (v24) then
        tbl_upv_1:ShowQuest(v24)
    end
    u2:WaitForChild("EventQuestProgressed").OnClientEvent:Connect(
        function(a3, a4)
            Quests_upv_2[a3].Progress = a4
            UpdateProgressBar(a3, a4)
        end
    )
    NavigationService_upv_1.PageChanged.Event:Connect(
        function(a5)
            if (a5 ~= "Quests") then
                return
            end
            for key_5 in u1.EventStartInfo.Quests do
                local v35 = u1.EventStartInfo.Quests[key_5]
                local RefreshLabel_3 = tbl_upv_2[key_5].RefreshLabel
                if (v35.RefreshTime) then
                    RefreshLabel_3.Text = ("Refreshes in %*"):format(
                        GetRefreshTime(v35.RefreshTime).Text
                    )
                    RefreshLabel_3.Visible = true
                else
                    RefreshLabel_3.Visible = false
                end
            end
        end
    )
end
return tbl_upv_1