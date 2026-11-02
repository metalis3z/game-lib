local tbl_upv_1 = {}
local _ = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button")
)
local WindowService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService")
)
local Container_1 = script.Parent.Parent:WaitForChild("Container")
local v1 = Container_1:WaitForChild("Title")
local Main_upv_1 = Container_1:WaitForChild("Main")
tbl_upv_1.PageChanged = Instance.new("BindableEvent")
function tbl_upv_1.GoToPage(a1, a2, a3)
    if (not Main_upv_1:FindFirstChild(a2)) then
        return
    end
    for _, value_1 in Main_upv_1:GetChildren() do
        if (value_1:IsA("Frame")) then
            value_1.Visible = value_1.Name == a2
        end
    end
    tbl_upv_1.PageChanged:Fire(a2, a3)
end
function tbl_upv_1.ConnectNavigationButtons(a1, a2)
    for _, value_upv_2 in a2:GetChildren() do
        if (value_upv_2:IsA("Frame")) then
            value_upv_2.Container.Button.Activated:Connect(
                function()
                    if (value_upv_2.Name == "MysteryBox") then
                        WindowService_upv_1:ViewFrame(
                            "Shop",
                            {TargetItem = "Christmas2025Box", TargetFrame = "ViewContents"}
                        )
                    elseif (value_upv_2.Name ~= "ItemBundle") then
                        tbl_upv_1:GoToPage(value_upv_2.Name)
                    else
                        tbl_upv_1:GoToPage("ShopBundles", "ItemBundle")
                    end
                end
            )
        end
    end
end
return tbl_upv_1