
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local u3 = {}
require(v1.Packages.Observers).observeTag("ScrollingTexture", function(u4)
    local u5 = {
        ["texture"] = u4,
        ["initial"] = u4.OffsetStudsV,
        ["speed"] = u4:GetAttribute("ScrollSpeed") or 10,
        ["direction"] = u4:GetAttribute("Direction") or 1,
        ["start"] = time()
    }
    local v6 = u3
    table.insert(v6, u5)
    local u7 = u4:GetAttributeChangedSignal("ScrollSpeed"):Connect(function()
        u5.speed = u4:GetAttribute("ScrollSpeed")
    end)
    local u8 = u4:GetAttributeChangedSignal("Direction"):Connect(function()
        u5.direction = u4:GetAttribute("Direction")
    end)
    return function()
        u7:Disconnect()
        u8:Disconnect()
        local v9 = table.find(u3, u5)
        if v9 then
            table.remove(u3, v9)
        end
    end
end)
v2.RenderStepped:Connect(function()
    local v10 = time()
    for _, v11 in u3 do
        local v12 = v11.initial + (v10 - v11.start) * v11.speed * v11.direction
        v11.texture.OffsetStudsV = v12
    end
end)