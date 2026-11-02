local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v3 = require(l_Packages_0.Trove);
local v4 = require(l_Packages_0.Net);
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v6 = require(l_Utils_0.NumberUtils);
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v8 = require(l_Shared_0.Animals);
local l_FireServer_0 = Instance.new("RemoteEvent").FireServer;
local v10 = v4:RemoteEvent("b096e1ca-9c3a-453b-8b60-268b235083b9");
local v11 = {};
v11.__index = v11;
v11.GetState = function(v12)
    return v12.State;
end;
v11.SetState = function(v13, v14, v15)
    v13.State = v14;
    local l_ProximityPrompt_0 = v13.ProximityPrompt;
    local l_AnimalIndex_0 = v13.AnimalIndex;
    l_ProximityPrompt_0.ObjectText = if not (not l_AnimalIndex_0 or string.find(l_AnimalIndex_0, "None")) and v14 ~= "Sell" then l_AnimalIndex_0 else "";
    l_ProximityPrompt_0.Enabled = v14 ~= "None";
    l_ProximityPrompt_0:SetAttribute("State", v14);
    if v14 == "Sell" then
        l_ProximityPrompt_0.ActionText = if l_AnimalIndex_0 then ("Sell: $%*"):format((v6:ToString(v8:GetSellValue(l_AnimalIndex_0), 2))) else "";
    elseif v14 == "Open" then
        l_ProximityPrompt_0.ActionText = "Open";
    elseif v14 == "Steal" then
        l_ProximityPrompt_0.ActionText = "Steal";
    elseif v14 == "Delete" then
        l_ProximityPrompt_0.ActionText = "Delete";
    elseif v14 == "Add" then
        l_ProximityPrompt_0.ActionText = "Add";
    elseif v14 == "Grab" then
        l_ProximityPrompt_0.ActionText = "Grab";
    elseif v14 == "Place" then
        l_ProximityPrompt_0.ActionText = "Place";
    elseif v14 == "Return" then
        l_ProximityPrompt_0.ActionText = "Return";
    end;
    if v15 then
        v13.TargetCallback = v15;
    end;
end;
v11.SetCallback = function(v18, v19)
    v18.TargetCallback = v19;
end;
v11.new = function(v20, v21, v22, v23)
    local v24 = setmetatable({}, v11);
    v24.Index = v20;
    v24.AnimalIndex = v21;
    v24.Collector = v3.new();
    local l_ProximityPrompt_1 = Instance.new("ProximityPrompt");
    l_ProximityPrompt_1.HoldDuration = 1.5;
    l_ProximityPrompt_1.RequiresLineOfSight = true;
    l_ProximityPrompt_1.Style = Enum.ProximityPromptStyle.Custom;
    if v23 then
        for v26, v27 in v23 do
            l_ProximityPrompt_1[v26] = v27;
        end;
    end;
    v24.ProximityPrompt = l_ProximityPrompt_1;
    l_ProximityPrompt_1.Parent = v22;
    v24.Collector:Add(l_ProximityPrompt_1);
    v24.Collector:Add(l_ProximityPrompt_1.Changed:Connect(function()
        l_ProximityPrompt_1.HoldDuration = 1.5;
        l_ProximityPrompt_1.RequiresLineOfSight = true;
        l_ProximityPrompt_1.MaxActivationDistance = 10;
    end));
    v24.Collector:Add(l_ProximityPrompt_1.PromptButtonHoldBegan:Connect(function()
        l_ProximityPrompt_1.HoldDuration = 1.5;
        l_ProximityPrompt_1.RequiresLineOfSight = true;
        l_ProximityPrompt_1.MaxActivationDistance = 10;
    end));
    v24.Collector:Add(l_ProximityPrompt_1.Triggered:Connect(function()
        if v24.TargetCallback then
            v24.TargetCallback();
        end;
    end));
    v24.Collector:Add(l_ProximityPrompt_1.PromptButtonHoldBegan:Connect(function()
        if v24.State == "Steal" then
            l_FireServer_0(v10, workspace:GetServerTimeNow() + 53, "5c0bd012-dfb2-4bac-8f1a-e41f136e4744");
            v10:FireServer(workspace:GetServerTimeNow() + 53, "6be28b5b-dbc3-4aab-aa0c-6ebcfa191f22");
        end;
    end));
    return v24;
end;
v11.Destroy = function(v28)
    v28.Collector:Destroy();
end;
return v11;