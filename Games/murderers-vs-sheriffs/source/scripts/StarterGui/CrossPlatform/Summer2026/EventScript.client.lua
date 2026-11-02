local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType"))
local Button_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button"))
local WindowService_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"))
local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService")):WaitForInitializedAsync()
local GuiService_upv_1 = game:GetService("GuiService")
local NavigationService_upv_1 = require(script:WaitForChild("NavigationService"))
local ProfileData_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
local ItemService_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"))
local Remotes_upv_1 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local Parent_upv_1 = script.Parent
local Container_1 = Parent_upv_1:WaitForChild("Container")
local Title_upv_1 = Container_1:WaitForChild("Title")
local Main_upv_1 = Container_1:WaitForChild("Main")
local Navigation_upv_1 = Title_upv_1:WaitForChild("Navigation")
local ButtonContainer_upv_1 = Navigation_upv_1:FindFirstChild("ButtonContainer")
local u1 = v1:GetMainEvent()
local tbl_upv_1 = {}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local function findPath(a1, ...)
    local tbl_4 = {...}
    local v2 = a1
    for _, value_1 in tbl_4 do
        v2 = v2:FindFirstChild(value_1)
        if (v2) then
            continue
        end
        return nil
    end
    return v2
end
local v3 = findPath(Main_upv_1, "ShopBundles", "Title", "Back", "Back")
if (v3) then
    table.insert(tbl_upv_1, v3)
end
local v4 = findPath(Title_upv_1, "Tokens", "Container", "Amount")
if (v4) then
    tbl_upv_2[v4] = "Currency"
end
local v5 = findPath(Main_upv_1, "ShopBundles", "Title", "Tokens", "Container", "TextLabel")
if (v5) then
    tbl_upv_2[v5] = "Currency"
end
local v6 = findPath(Main_upv_1, "ShopBundles", "Title", "Keys", "Container", "TextLabel")
if (v6) then
    tbl_upv_2[v6] = "Keys"
end
local v7 = findPath(Title_upv_1, "Tokens", "GetMore", "Button")
if (v7) then
    table.insert(tbl_upv_3, v7)
end
local function onEventEnd()
    local EventEnded_1 = Navigation_upv_1:FindFirstChild("EventEnded")
    if (EventEnded_1) then
        EventEnded_1.Visible = true
    end
    if (not ButtonContainer_upv_1) then
        return
    end
    ButtonContainer_upv_1.Quests.Visible = false
end
local u2 = false
local function UpdateCurrencyLabels()
    for key_1, value_2 in tbl_upv_2 do
        key_1.Text = ItemService_upv_1:CommaNumber(
            ProfileData_upv_1.Materials.Owned[((value_2 == "Keys") and (u1.EventStartInfo.KeyName))
                or (u1.EventStartInfo.CurrencyName)] or 0
        )
    end
end
local function onInitialize()
    if (not u1) then
        return
    end
    Parent_upv_1.Visible = false
    NavigationService_upv_1:GoToPage("Quests")
    if (u1.EventStartInfo.BattlePass) then
        require(script:WaitForChild("BattlePassService")):Initialize(u1)
    end
    if (u1.EventStartInfo.Quests) then
        require(script:WaitForChild("QuestService")):GenerateQuestFrames()
    end
    if (u1.EventStartInfo.ShopData and Main_upv_1:FindFirstChild("ShopBundles")) then
        local _ = require(script:WaitForChild("EventShopService"))
    end
    if (u1.EventStartInfo.CraftingRecipes) then
        require(script:WaitForChild("CraftingService")):GenerateRecipes()
    end
    if (u1.EventStartInfo.Gifting) then
        require(script:WaitForChild("GiftingService")).Initialize()
    end
    if (u1.EventStartInfo.Leaderboards) then
        require(script:WaitForChild("LeaderboardService")).Initialize()
    end
    WindowService_upv_1:RegisterFrame(
        Parent_upv_1,
        "CurrentEvent",
        function(a1)
            if (GuiService_upv_1:IsTenFootInterface()) then
                GuiService_upv_1:Select(Parent_upv_1)
            end
            if (not a1) then
                return
            end
            if (a1 == "ItemBundle") then
                NavigationService_upv_1:GoToPage("ShopBundles", "ItemBundle")
            elseif (a1 ~= "MysteryBox") then
                NavigationService_upv_1:GoToPage(a1)
            else
                WindowService_upv_1:ViewFrame(
                    "Shop",
                    {TargetItem = "Summer2026Box", TargetFrame = "ViewContents"}
                )
            end
        end
    )
    Button_upv_1.createButton(
        Title_upv_1:WaitForChild("Close"),
        function()
            WindowService_upv_1:Back()
        end
    )
    UpdateCurrencyLabels()
    Remotes_upv_1:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(
        function(a2, a3)
            if (a3 ~= u1.EventStartInfo.CurrencyName and a3 ~= u1.EventStartInfo.KeyName) then
                return
            end
            UpdateCurrencyLabels()
        end
    )
    for _, value_3 in tbl_upv_3 do
        value_3.Activated:Connect(
            function()
                NavigationService_upv_1:GoToPage("ShopBundles")
            end
        )
    end
    if (ButtonContainer_upv_1) then
        NavigationService_upv_1:ConnectNavigationButtons(ButtonContainer_upv_1)
    end
    for _, value_4 in tbl_upv_1 do
        Button_upv_1.createButton(
            value_4,
            function()
                NavigationService_upv_1:GoToPage("Navigation")
            end
        )
    end
    Button_upv_1.createButton(
        Title_upv_1:WaitForChild("Close"),
        function()
            if (GuiService_upv_1:IsTenFootInterface()) then
                GuiService_upv_1.SelectedObject = nil
            end
            WindowService_upv_1:CloseAllFrames()
        end
    )
    Button_upv_1.createButton(
        Title_upv_1:WaitForChild("OpenBox"),
        function()
            WindowService_upv_1:ViewFrame(
                "Shop",
                {TargetItem = "Summer2026Box", TargetFrame = "ViewContents"}
            )
        end
    )
    task.wait()
    u2 = true
end
v1:OnMainEventStarted(onInitialize)
v1:OnEventEnded(
    function(a1)
        if (a1.Name == "Summer") then
            while (not (u2)) do
                task.wait()
            end
            local EventEnded_2 = Navigation_upv_1:FindFirstChild("EventEnded")
            if (EventEnded_2) then
                EventEnded_2.Visible = true
            end
            if (not ButtonContainer_upv_1) then
                return
            end
            ButtonContainer_upv_1.Quests.Visible = false
        end
    end
)