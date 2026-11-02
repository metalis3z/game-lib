-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = {};
local function v5(v2, v3, v4)
    v1[v2] = v1[v2] or {};
    v1[v2][v3] = l_TweenService_0:Create(v2, TweenInfo.new(v4.Time, Enum.EasingStyle[v4.EasingStyle], Enum.EasingDirection[v4.EasingDirection], 0, false, v4.DelayTime), v4.Properties);
end;
game.ReplicatedStorage.ClientTweenEvents.CreateClientTween.OnClientEvent:Connect(function(v6, v7, v8)
    v5(v6, v7, v8);
end);
game.ReplicatedStorage.ClientTweenEvents.PlayClientTween.OnClientEvent:Connect(function(v9, v10)
    if v1[v9] == nil then
        local v11 = game.ReplicatedStorage.ClientTweenEvents.GetClientTween:InvokeServer(v9, v10);
        v5(v9, v10, v11);
    elseif v1[v9][v10] == nil then
        local v12 = game.ReplicatedStorage.ClientTweenEvents.GetClientTween:InvokeServer(v9, v10);
        v5(v9, v10, v12);
    end;
    v1[v9][v10]:Play();
end);
game.ReplicatedStorage.ClientTweenEvents.StopClientTween.OnClientEvent:Connect(function(v13, v14)
    if v1[v13] ~= nil and v1[v13][v14] ~= nil then
        v1[v13][v14]:Cancel();
    end;
end);
game.ReplicatedStorage.ClientTweenEvents.ClearTweens.OnClientEvent:Connect(function()
    v1 = {};
end);