-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v5 = require(v2.Packages.Component)
local v_u_6 = require(v2.Packages.Trove)
local v7 = v5.new({
    ["Tag"] = "UILoadingDots",
    ["Ancestors"] = { v4 }
})
function v7.Construct(p8)
    -- upvalues: (copy) v_u_6
    p8._trove = v_u_6.new()
end
function v7.Start(p9)
    -- upvalues: (copy) v_u_3
    local v_u_10 = {}
    for _, v11 in pairs(p9.Instance:GetChildren()) do
        if v11:IsA("ImageLabel") then
            table.insert(v_u_10, v11)
        end
    end
    p9._trove:Add(v_u_3.RenderStepped:Connect(function()
        -- upvalues: (copy) v_u_10
        for v12 = 1, 3 do
            local v13 = (tick() * -4 + v12 / 3 * 3.141592653589793 * 2 * 0.15) % 6.283185307179586
            local v14 = math.sin(v13)
            local v15 = math.abs(v14)
            local v16 = math.max(0.5, v15) * 0.3333
            v_u_10[v12].Size = UDim2.new(v16, 0, v16, 0)
        end
    end))
end
function v7.Stop(p17)
    p17._trove:Destroy()
end
return v7