
local _ = {
    Fire = "http://www.roblox.com/asset/?id=9426132023"
};
local l_Parent_0 = script.Parent;
local v2 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
game.ReplicatedStorage.Remotes.Gameplay.KillEvent.OnClientEvent:Connect(function(_, _, v6, v7) --[[ Line: 10 ]]
    for _, v9 in pairs(l_Parent_0:GetChildren()) do
        if v9:IsA("Frame") then
            v9.LayoutOrder = v9.LayoutOrder + 1;
        end;
    end;
    local v10 = script.NewEvent:Clone();
    v10.Parent = script.Parent;
    local v11 = "";
    if v6 then
        v11 = "+" .. v6 .. " - ";
    end;
    v7 = v7 or "Eliminated";
    v10.EventName.Text = v7;
    game.Debris:AddItem(v10, 2);
    v10.EventName.TextTransparency = 1;
    v10.EventName.TextStrokeTransparency = 1;
    local _ = game:GetService("TweenService"):Create(v10.EventName, v2, {
        TextTransparency = 0, 
        TextStrokeTransparency = 0.3, 
        Position = UDim2.new(0, 0, 0, 0)
    }):Play();
    wait(1.5);
    local _ = game:GetService("TweenService"):Create(v10.EventName, v3, {
        TextTransparency = 1, 
        TextStrokeTransparency = 1
    }):Play();
end);