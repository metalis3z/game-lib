local tbl_upv_1 = {}
local ItemService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService")
)
local u1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild(
        "EventInfoService"
    )
):WaitForInitializedAsync()
local NavigationService_upv_1 = require(script.Parent:WaitForChild("NavigationService"))
local TimestampService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild(
        "TimestampService"
    )
)
local Button_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button")
)
local Container_1 = script.Parent.Parent:WaitForChild("Container")
local _ = Container_1:WaitForChild("Title")
local Leaderboard_upv_1 = Container_1:WaitForChild("Main"):WaitForChild("Leaderboard")
local tbl_upv_2 = {Tokens = 0}
tbl_upv_2.Tokens = {Global = {}, Friends = {}}
local u2 = u1:GetMainEvent()
local CurrencyName_1 = u2.EventStartInfo.CurrencyName
local u3 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild(
    u2.Title .. "Remotes"
)
local u4
if (string.find(CurrencyName_1, "Tokens")) then
    u4 = "Tokens"
elseif (string.find(CurrencyName_1, "Candies")) then
    u4 = "Candies"
else
    local v1 = string.find(CurrencyName_1, "Beach")
    u4 = (v1 and "Beach balls") or "Points"
end
function tbl_upv_1.UpdateStatus(a1)
    local v2, v3 = u1:GetLeaderboardStatus(u2)
    local v4 = TimestampService_upv_1:GetLeaderboardTimeText(v3)
    if (v2 == "pausingSoon") then
        Leaderboard_upv_1.Timer.Pause.Text = u4 .. " leaderboard pauses for Christmas in: " .. v4
    elseif (v2 == "paused") then
        Leaderboard_upv_1.Timer.Pause.Text = u4 .. " leaderboard resumes in: " .. v4
    elseif (v2 == "endingSoon") then
        Leaderboard_upv_1.Timer.Pause.Text = "Leaderboards end in: " .. v4
    elseif (v2 == "ended") then
        Leaderboard_upv_1.Timer.Pause.Text = "Leaderboards have ended!"
    end
end
function tbl_upv_1.Generate(a1, a2, a3)
    for key_1, value_1 in a3 do
        local v5 = (script:FindFirstChild("Place" .. key_1) and ("Place" .. key_1)) or "Place"
        local v6 = script[v5]:Clone()
        if (key_1 < 4) then
            v6.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(
                value_1.userName
            )
        end
        local v7 = ((string.find(a1, "Gifts")) and "Gifts") or u4
        v6.Container.Username.Text = "#" .. key_1 .. " - " .. value_1.userName
        v6.Container.TokenCount.Text = ItemService_upv_1:CommaNumber(value_1.points) .. " "
            .. string.lower(v7)
        v6.Visible = true
        v6.LayoutOrder = key_1
        v6.Parent = Leaderboard_upv_1.Leaderboards[a1][a2]
    end
end
local function RequestLeaderboard(a1)
    local tbl_3 = {}
    tbl_3.Global = u3.GetLeaderboard:InvokeServer(u2.Title, a1, "Global")
    tbl_3.Friends = u3.GetLeaderboard:InvokeServer(u2.Title, a1, "Friends")
    return tbl_3
end
function tbl_upv_1.Create(a1)
    tbl_upv_1:UpdateStatus()
    tbl_upv_2 = {}
    local Leaderboards_1 = u2.EventStartInfo.Leaderboards
    if (Leaderboards_1.Points) then
        tbl_upv_2.Tokens = RequestLeaderboard("Points")
    end
    if (Leaderboards_1.Gifts) then
        tbl_upv_2.Gifts = RequestLeaderboard("Gifts")
    end
    for _, value_2 in Leaderboard_upv_1.Leaderboards:GetChildren() do
        if (not (tbl_upv_2[value_2.Name])) then
            continue
        end
        for v1, value_3 in value_2:GetChildren() do
            local Name_1 = value_2.Name
            local Name_2 = value_3.Name
            tbl_upv_1.Generate(Name_1, Name_2, tbl_upv_2[Name_1][Name_2])
        end
    end
end
function tbl_upv_1.Update(a1)
    local Leaderboards_2 = u2.EventStartInfo.Leaderboards
    tbl_upv_1:UpdateStatus()
    tbl_upv_2 = {}
    if (Leaderboards_2.Points) then
        tbl_upv_2.Tokens = RequestLeaderboard("Points")
    end
    if (Leaderboards_2.Gifts) then
        tbl_upv_2.Gifts = RequestLeaderboard("Gifts")
    end
    for key_2, value_4 in tbl_upv_2 do
        for key_3, value_5 in value_4 do
            for _, value_6 in Leaderboard_upv_1.Leaderboards[key_2][key_3]:GetChildren() do
                if (value_6:IsA("Frame")) then
                    value_6:Destroy()
                end
            end
            tbl_upv_1.Generate(key_2, key_3, value_5)
        end
    end
end
local u5 = -60
local function onLeaderboardOpened()
    if (os.clock() - u5 < 60) then
        return
    end
    u5 = os.clock()
    tbl_upv_1.Update()
end
function tbl_upv_1.Initialize()
    if (u2.EventStartInfo.Leaderboards.Gifts == nil) then
        Leaderboard_upv_1:WaitForChild("Info"):WaitForChild("TypeButtons").Visible = false
    else
        local u6 = nil
        local u7 = Button_upv_1.createButton(Leaderboard_upv_1.Info.TypeButtons.Tokens)
        u7.clickStart = function()
            Leaderboard_upv_1.Leaderboards.Gifts.Visible = false
            Leaderboard_upv_1.Leaderboards.Tokens.Visible = true
            u7:Disable()
            u6:Enable()
        end
        u7:Disable()
        u6 = Button_upv_1.createButton(Leaderboard_upv_1.Info.TypeButtons.Gifts)
        u6.clickStart = function()
            Leaderboard_upv_1.Leaderboards.Gifts.Visible = true
            Leaderboard_upv_1.Leaderboards.Tokens.Visible = false
            u6:Disable()
            u7:Enable()
        end
    end
    Leaderboard_upv_1.Info.GroupButtons.GlobalButton.Activated:Connect(
        function()
            Leaderboard_upv_1.Leaderboards.Gifts.Global.Visible = true
            Leaderboard_upv_1.Leaderboards.Tokens.Global.Visible = true
            Leaderboard_upv_1.Leaderboards.Gifts.Friends.Visible = false
            Leaderboard_upv_1.Leaderboards.Tokens.Friends.Visible = false
            Leaderboard_upv_1.Info.GroupButtons.Background:TweenPosition(
                UDim2.new(0, 0, 0, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.1
            )
        end
    )
    Leaderboard_upv_1.Info.GroupButtons.FriendsButton.Activated:Connect(
        function()
            Leaderboard_upv_1.Leaderboards.Gifts.Global.Visible = false
            Leaderboard_upv_1.Leaderboards.Tokens.Global.Visible = false
            Leaderboard_upv_1.Leaderboards.Gifts.Friends.Visible = true
            Leaderboard_upv_1.Leaderboards.Tokens.Friends.Visible = true
            Leaderboard_upv_1.Info.GroupButtons.Background:TweenPosition(
                UDim2.new(0.5, 0, 0, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.1
            )
        end
    )
    NavigationService_upv_1.PageChanged.Event:Connect(
        function(a1)
            if (a1 ~= "Leaderboard" or os.clock() - u5 < 60) then
                return
            end
            u5 = os.clock()
            tbl_upv_1.Update()
        end
    )
    tbl_upv_1.Create()
end
return tbl_upv_1