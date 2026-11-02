-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Container_0 = script.Parent.Container;
local l_TweenService_0 = game:GetService("TweenService");
local l_CoinCollected_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinCollected");
local l_CoinsStarted_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinsStarted");
local v4 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v5 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v6 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local function v9(v7)
    local v8 = script.FullBagNotification:Clone();
    v8.Text = string.upper(v7) .. " FULL!";
    v8.Position = UDim2.new(0.5, 0, 1.15, 0);
    v8.Rotation = -3;
    v8.Visible = true;
    v8.Parent = script.Parent;
    game.Debris:AddItem(v8, 3);
    l_TweenService_0:Create(v8, v4, {
        Position = UDim2.new(0.5, 0, 0.8, 0)
    }):Play();
    task.wait(0.5);
    l_TweenService_0:Create(v8, v5, {
        Rotation = 3
    }):Play();
    task.wait(1.5);
    l_TweenService_0:Create(v8, v6, {
        Position = UDim2.new(0.5, 0, 1.15, 0)
    }):Play();
end;
local function v16(v10, v11, v12, _)
    local l_l_Container_0_FirstChild_0 = l_Container_0:FindFirstChild(v10);
    if not l_l_Container_0_FirstChild_0 then
        return;
    else
        local v15 = v12 <= v11;
        l_l_Container_0_FirstChild_0.CurrencyFrame.Icon.Coins.Text = v11;
        if v15 then
            l_l_Container_0_FirstChild_0.EmptyBagIcon.Visible = false;
            l_l_Container_0_FirstChild_0.FullBagIcon.Visible = true;
            l_l_Container_0_FirstChild_0.Full.Visible = true;
            v9(l_l_Container_0_FirstChild_0:GetAttribute("BagName"));
        end;
        return;
    end;
end;
local function v21(v17)
    local l_l_Container_0_Children_0 = l_Container_0:GetChildren();
    for _, v20 in pairs(l_l_Container_0_Children_0) do
        if v20:IsA("Frame") then
            v20.Visible = v17[v20.Name] ~= nil;
        end;
    end;
end;
for _, v23 in pairs(l_Container_0:GetChildren()) do
    if v23:IsA("Frame") then
        v23.Visible = false;
    end;
end;
l_CoinCollected_0.OnClientEvent:Connect(v16);
l_CoinsStarted_0.OnClientEvent:Connect(v21);