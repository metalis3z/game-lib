-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return table.freeze({
    Bind = function(v1, v2) -- Bind | line 7
        local v3 = v2.PerRow > 0
        assert(v3, "AutoGridLayout.PerRow must be positive")
        local UIGridLayout = v1:FindFirstChildOfClass("UIGridLayout")
        assert(UIGridLayout, "AutoGridLayout container needs a UIGridLayout")
        local UIPadding = v1:FindFirstChildOfClass("UIPadding")
        local v4
        if v1:IsA("ScrollingFrame") then
            v4 = v1
        else
            v4 = v1:FindFirstAncestorOfClass("ScrollingFrame")
        end
        local ScreenGui = v1:FindFirstAncestorOfClass("ScreenGui")
        return function() -- line 20 | captures: v4, v1, v2, UIGridLayout, UIPadding, ScreenGui
            local AbsoluteSize = v1.AbsoluteSize
            local v5 = v2.Padding or UDim2.new()
            if v2.ScalePaddingOffset then
                local v6 = v4
                assert(v6, "scaled grid padding needs a ScrollingFrame")
                local AbsoluteWindowSize = v4.AbsoluteWindowSize
                local v7 = v5.X.Scale * AbsoluteWindowSize.X + v5.X.Offset
                local v8 = math.floor(v7)
                local v9 = v5.Y.Scale * AbsoluteWindowSize.Y
                local fromOffset = UDim2.fromOffset
                local v10 = v9 + v5.Y.Offset
                v5 = fromOffset(v8, (math.floor(v10)))
            end
            local v11 = if UIPadding then UIPadding.PaddingLeft.Offset + UIPadding.PaddingLeft.Scale * AbsoluteSize.X else 0
            local v12 = if UIPadding then UIPadding.PaddingRight.Offset + UIPadding.PaddingRight.Scale * AbsoluteSize.X else 0
            local v13 = if v4 then v4.ScrollBarThickness else 0
            local v14 = (AbsoluteSize.X - v11 - v12 - v13) / v2.PerRow - (v5.X.Offset + v5.X.Scale * AbsoluteSize.X)
            local v15 = ScreenGui and ScreenGui:FindFirstChildOfClass("Frame")
            local v16 = v15 and v15:FindFirstChild("TabScale")
            if v16 and v16:IsA("UIScale") then
                v14 /= v16.Scale
            end
            local v17 = math.floor(v14)
            UIGridLayout.CellPadding = v5
            UIGridLayout.CellSize = UDim2.fromOffset(v17, v17)
            if not v4 then
                return
            end
            local v18 = if UIPadding then UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset + (UIPadding.PaddingTop.Scale + UIPadding.PaddingBottom.Scale) * AbsoluteSize.Y else 0
            local AbsoluteContentSize = UIGridLayout.AbsoluteContentSize
            v4.CanvasSize = UDim2.fromOffset(AbsoluteContentSize.X, AbsoluteContentSize.Y + v18)
        end
    end
})
