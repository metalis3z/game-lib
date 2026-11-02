

local l_TweenService_0 = game:GetService("TweenService");
return function(v1, v2, v3)
    local l_CFrameValue_0 = Instance.new("CFrameValue");
    l_CFrameValue_0.Value = v1:GetPivot();
    local v5 = l_TweenService_0:Create(l_CFrameValue_0, v2, {
        Value = v3
    });
    l_CFrameValue_0.Changed:Connect(function(v6)
        v1:PivotTo(v6);
    end);
    v5.Completed:Once(function()
        v5:Destroy();
        l_CFrameValue_0:Destroy();
    end);
    return v5;
end;