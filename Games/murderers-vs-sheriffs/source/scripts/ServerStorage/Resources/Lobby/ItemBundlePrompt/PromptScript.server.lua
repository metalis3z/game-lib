local Parent_1 = script.Parent
local ProximityPrompt_1 = Parent_1:WaitForChild("ProximityPrompt")
local WindowService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService")
)
Parent_1.Transparency = 1
local function onTriggered()
    WindowService_upv_1:ViewFrame(
        "Shop",
        {TargetItem = "BeachBundleEffect", TargetFrame = "Weapons"}
    )
end
ProximityPrompt_1.Triggered:Connect(onTriggered)