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
local Button_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button")
)
local NavigationService_upv_1 = require(script.Parent:WaitForChild("NavigationService"))
local u1 = v1:GetMainEvent()
local Remotes_upv_1 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local u2 = Remotes_upv_1:WaitForChild("Events"):WaitForChild(u1.Title .. "Remotes")
local ProfileData_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData")
)
local Container_1 = script.Parent.Parent:WaitForChild("Container")
local v2 = Container_1:WaitForChild("Title")
local Crafting_upv_1 = Container_1:WaitForChild("Main"):WaitForChild("Crafting")
local ScrollingFrame_upv_1 = Crafting_upv_1:WaitForChild("Container"):WaitForChild("ScrollingFrame")
local CraftingRecipe_upv_1 = ScrollingFrame_upv_1:WaitForChild("CraftingRecipe")
CraftingRecipe_upv_1.Parent = script
local tbl_upv_2 = {}
local tbl_upv_3 = {}
function tbl_upv_1.UpdateRecipes(a1)
    local v2 = ProfileData_upv_1[u1.Title]
    for key_1, value_1 in tbl_upv_2 do
        local v3 = u1.EventStartInfo.CraftingRecipes[key_1]
        local Items_1 = value_1:WaitForChild("Container"):WaitForChild("Input"):WaitForChild(
            "Items"
        )
        if (v2.Crafted[key_1]) then
            value_1.Crafted.Visible = true
            for n_1 = 1, 4 do
                if (v3.Input[n_1]) then
                    local v4 = Items_1:FindFirstChild("Item" .. n_1)
                    v4.Container.Amount.Text = ""
                    v4.Container.Ready.Visible = false
                end
            end
            tbl_upv_3[key_1]:Disable()
        else
            local v5 = 0
            for n_2 = 1, 4 do
                if (not (v3.Input[n_2])) then
                    continue
                end
                local v6 = v3.Input[n_2]
                local v7 = Items_1:FindFirstChild("Item" .. n_2)
                local v8 = ProfileData_upv_1[v6.ItemType].Owned[v6.ItemID] or 0
                v7.Container.Amount.Text = ("%*/%*"):format(v8, v6.Amount)
                v7.Container.Ready.Visible = v6.Amount <= v8
                if (v6.Amount <= v8) then
                    v5 = v5 + 1
                end
            end
            if (#v3.Input <= v5) then
                tbl_upv_3[key_1]:Enable()
            else
                tbl_upv_3[key_1]:Disable()
            end
        end
    end
end
function tbl_upv_1.GenerateRecipes(a1)
    for key_upv_2, value_2 in u1.EventStartInfo.CraftingRecipes do
        local v9 = CraftingRecipe_upv_1:Clone()
        v9.Container.Input.Title.TextLabel.Text = value_2.Title
        for n_3 = 1, 4 do
            local v10 = value_2.Input[n_3]
            local v11 = v9.Container.Input.Items:FindFirstChild("Item" .. n_3)
            if (v10) then
                local v12 = ItemService_upv_1:GetDisplayInfo(v10.ItemID, v10.ItemType)
                v11.ItemName.TextLabel.Text = v12.Name
                v11.ItemName.BackgroundColor3 = v12.Color
                v11.Container.Icon.Image = v12.Image
                v11.Visible = true
            else
                v11.Visible = false
            end
        end
        for n_4 = 1, 1 do
            local v13 = value_2.Output[n_4]
            local v14 = v9.Container.Output:FindFirstChild("Item" .. n_4)
            if (v13) then
                local v15 = ItemService_upv_1:GetDisplayInfo(v13.ItemID, v13.ItemType)
                v14.ItemName.TextLabel.Text = v15.Name
                v14.ItemName.BackgroundColor3 = v15.Color
                v14.Container.Icon.Image = v15.Image
                v14.Container.Amount.Text = ""
                v14.Visible = true
            else
                v14.Visible = false
            end
        end
        tbl_upv_3[key_upv_2] = Button_upv_1.createButton(
            v9:WaitForChild("Container"):WaitForChild("Output"):WaitForChild("Craft"):WaitForChild(
                "Craft"
            ),
            function()
                u2.CraftRecipe:FireServer(key_upv_2)
            end
        )
        tbl_upv_2[key_upv_2] = v9
        v9.LayoutOrder = value_2.LayoutOrder
        v9.Parent = ScrollingFrame_upv_1
    end
    tbl_upv_1:UpdateRecipes()
    Remotes_upv_1:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(
        function(a2, a3)
            if (not Crafting_upv_1.Visible) then
                return
            end
            local v16 = false
            for _, value_3 in u1.EventStartInfo.CraftingRecipes do
                for v17, value_4 in value_3.Input do
                    if (value_4.ItemID == a3) then
                        v16 = true
                        break
                    end
                end
                for v18, value_5 in value_3.Output do
                    if (value_5.ItemID == a3) then
                        v16 = true
                        break
                    end
                end
            end
            if (not v16) then
                return
            end
            tbl_upv_1:UpdateRecipes()
        end
    )
    NavigationService_upv_1.PageChanged.Event:Connect(
        function(a4)
            if (a4 ~= "Crafting") then
                return
            end
            tbl_upv_1:UpdateRecipes()
        end
    )
end
return tbl_upv_1