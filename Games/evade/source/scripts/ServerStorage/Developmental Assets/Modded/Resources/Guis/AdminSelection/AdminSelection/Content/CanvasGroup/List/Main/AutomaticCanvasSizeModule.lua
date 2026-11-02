-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(v0, v1) --[[ Line: 3 ]]
    if v0.ScrollingDirection == Enum.ScrollingDirection.X then
        local v2 = 1000;
        local l_UIListLayout_0 = v0:FindFirstChildOfClass("UIListLayout");
        if l_UIListLayout_0 then
            v2 = v2 + l_UIListLayout_0.AbsoluteContentSize.X;
        end;
        local l_UIGridLayout_0 = v0:FindFirstChildOfClass("UIGridLayout");
        if l_UIGridLayout_0 then
            v2 = v2 + l_UIGridLayout_0.AbsoluteContentSize.X;
        end;
        local l_UIPadding_0 = v0:FindFirstChildOfClass("UIPadding");
        if l_UIPadding_0 then
            v2 = v2 + (l_UIPadding_0.PaddingLeft.Offset + l_UIPadding_0.PaddingRight.Offset);
        end;
        if v1 then
            v2 = v2 + v1;
        end;
        v0.CanvasSize = UDim2.new(0, v2, 0, 0);
        return;
    else
        local v6 = 1000;
        local l_UIListLayout_1 = v0:FindFirstChildOfClass("UIListLayout");
        if l_UIListLayout_1 then
            v6 = v6 + l_UIListLayout_1.AbsoluteContentSize.Y;
        end;
        local l_UIGridLayout_1 = v0:FindFirstChildOfClass("UIGridLayout");
        if l_UIGridLayout_1 then
            v6 = v6 + l_UIGridLayout_1.AbsoluteContentSize.Y;
        end;
        local l_UIPadding_1 = v0:FindFirstChildOfClass("UIPadding");
        if l_UIPadding_1 then
            v6 = v6 + (l_UIPadding_1.PaddingBottom.Offset + l_UIPadding_1.PaddingTop.Offset);
        end;
        if v1 then
            v6 = v6 + v1;
        end;
        v0.CanvasSize = UDim2.new(0, 0, 0, v6);
        return;
    end;
end;