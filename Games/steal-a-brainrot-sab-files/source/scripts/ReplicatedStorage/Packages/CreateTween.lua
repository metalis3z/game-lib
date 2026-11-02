

local l_TweenService_0 = game:GetService("TweenService");
return function(v1, v2, v3, v4)
    local v5 = l_TweenService_0:Create(v1, v2, v3);
    v5.Completed:Once(function()
        v5:Destroy();
    end);
    if v4 ~= false then
        v5:Play();
    end;
    return v5;
end;