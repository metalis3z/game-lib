-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local Sine = Enum.EasingStyle.Sine
local v1 = {}

function v1.Bind(v2) -- line 9 | captures: TweenService, Sine
    local GuiObject = v2:IsA("GuiObject")
    local v3 = ("%* must be a GuiObject to hover bob"):format((v2:GetFullName()))
    assert(GuiObject, v3)
    local v4 = v2:GetAttribute("HoverBobDistance") or 6
    local v5 = v2:GetAttribute("HoverBobSeconds") or 1.4
    local v6 = v2:GetAttribute("HoverBobSway") or 0
    local v7 = v2:GetAttribute("HoverBobSwaySeconds") or 1.9
    local Position = v2.Position
    local Rotation = v2.Rotation
    local v8 = {}
    local v9 = TweenInfo.new(v5 / 2, Sine, Enum.EasingDirection.Out)
    local v10 = { Position = Position - UDim2.fromOffset(0, v4) }
    local v11 = TweenService:Create(v2, v9, v10)
    table.insert(v8, v11)
    v11.Completed:Connect(function(v12) -- line 23 | captures: v2, v4, v5, Position, v8, TweenService, Sine
        if v12 ~= Enum.PlaybackState.Completed then
            return
        end
        local v13 = TweenInfo.new(v5, Sine, Enum.EasingDirection.InOut, -1, true)
        local v14 = TweenService:Create(v2, v13, { Position = Position + UDim2.fromOffset(0, v4) })
        table.insert(v8, v14)
        v14:Play()
    end)
    v11:Play()
    if v6 > 0 then
        v2.Rotation = Rotation - v6
        local v15 = TweenInfo.new(v7, Sine, Enum.EasingDirection.InOut, -1, true)
        local v16 = TweenService:Create(v2, v15, { Rotation = Rotation + v6 })
        table.insert(v8, v16)
        v16:Play()
    end
    return function() -- line 40 | captures: v2, Position, Rotation, v8
        for v17, v18 in v8 do
            v18:Cancel()
            v18:Destroy()
        end
        table.clear(v8)
        v2.Position = Position
        v2.Rotation = Rotation
    end
end

return v1
