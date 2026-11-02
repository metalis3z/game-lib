
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Datas.ServerData)
if script:IsDescendantOf(workspace) then
    local v3 = Instance.new("Highlight")
    v3.Name = "Highlight"
    if v2.IsTsunamiServer() then
        v3.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    else
        v3.DepthMode = Enum.HighlightDepthMode.Occluded
    end
    v3.FillTransparency = 1
    v3.OutlineColor = Color3.fromRGB(255, 12, 12)
    v3.Parent = script.Parent
end