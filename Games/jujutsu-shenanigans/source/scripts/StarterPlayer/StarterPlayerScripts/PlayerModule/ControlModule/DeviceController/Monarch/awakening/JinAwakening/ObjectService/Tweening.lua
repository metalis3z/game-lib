-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
v0.TweenProperty = function(v2, v3, v4, v5, v6, v7) --[[ Line: 5 ]] --[[ Name: TweenProperty ]]
    if not v2 then
        return;
    else
        if v7 == nil then
            v7 = false;
        end;
        return (l_TweenService_0:Create(v2, TweenInfo.new(v3, Enum.EasingStyle[v4], Enum.EasingDirection[v5], 0, v7), v6));
    end;
end;
v0.TweenGroup = function(v8, v9) --[[ Line: 18 ]] --[[ Name: TweenGroup ]]
    if typeof(v8) ~= "table" then
        error("SEQUENCE MUST BE A TABLE!!!");
    end;
    for v10 = 1, #v8 do
        local _ = v8[v10]:Play();
        if v9 > 0 then
            task.wait(v9);
        end;
    end;
end;
v0.TweenSequence = function(v12) --[[ Line: 31 ]] --[[ Name: TweenSequence ]]
    if typeof(v12) ~= "table" then
        error("SEQUENCE MUST BE A TABLE!!!");
    end;
    task.spawn(function() --[[ Line: 36 ]]
        for v13 = 1, #v12 do
            local v14 = v12[v13];
            v14:Play();
            v14.Completed:Wait();
        end;
    end);
    return true;
end;
return v0;