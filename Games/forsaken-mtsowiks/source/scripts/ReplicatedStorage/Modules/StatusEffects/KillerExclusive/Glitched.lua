-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = {
    Data = {
        Duration = 10, 
        MaxLevel = 3, 
        Stackable = true, 
        Description = "Makes you more suspectible to damage while inflicting your screen with a glitchy effect."
    }
};
local v2 = nil;
local v3 = false;
local l_Part_0 = script:WaitForChild("Part");
local v5 = {};
v1.Applied = function(v6) --[[ Line: 23 ]] --[[ Name: Applied ]]
    -- upvalues: l_RunService_0 (copy), v1 (copy), v3 (ref), l_Part_0 (copy), v5 (copy), v2 (ref)
    if l_RunService_0:IsServer() then
        local v7 = tonumber(v6.Level * (100 / v1.Data.MaxLevel));
        if v7 then
            require(game.ReplicatedStorage.Modules.Util):CreateResistanceMultiplier(v6.Character, -v7, "GlitchedStatus", v6.Data.Duration);
            return;
        end;
    elseif l_RunService_0:IsClient() then
        if v3 then
            return;
        elseif require(game.ReplicatedStorage.Initializer).PlayerSettings.EpilepsyMode.Value then
            return;
        else
            if not workspace:FindFirstChild("GlitchParts") then
                local l_Model_0 = Instance.new("Model");
                l_Model_0.Name = "GlitchParts";
                l_Model_0.Parent = workspace;
                local l_Highlight_0 = Instance.new("Highlight");
                l_Highlight_0.FillColor = Color3.fromRGB(45, 130, 88);
                l_Highlight_0.FillTransparency = -22222222;
                l_Highlight_0.OutlineColor = Color3.fromRGB(255, 0, 144);
                l_Highlight_0.OutlineTransparency = 1;
                l_Highlight_0.Parent = l_Model_0;
            end;
            workspace.GlitchParts.Highlight.Enabled = not v6.Data.NoHighlight;
            local v10 = v6.Level == 1 and 1 or v6.Level / 1.5;
            for _ = 1, 24 * v10 do
                local v12 = l_Part_0:Clone();
                v12.Size = Vector3.new(3, 1, -3, 0);
                v12.Parent = workspace.GlitchParts;
                table.insert(v5, {
                    part = v12, 
                    x = 0, 
                    y = 0
                });
            end;
            if not v2 then
                v2 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 71 ]]
                    -- upvalues: v5 (ref)
                    for _, v14 in ipairs(v5) do
                        local l_CFrame_0 = workspace.CurrentCamera.CFrame;
                        v14.part.CFrame = l_CFrame_0 * CFrame.new(v14.x, v14.y, -6);
                    end;
                end);
                task.spawn(function() --[[ Line: 78 ]]
                    -- upvalues: v2 (ref), v5 (ref)
                    while v2 do
                        for _, v17 in ipairs(v5) do
                            local v18 = math.random(-8, 8);
                            local v19 = math.random(-4, 4);
                            v17.x = v18;
                            v17.y = v19;
                        end;
                        task.wait(0.3);
                    end;
                end);
            end;
            if v6.Level >= 3 then
                v3 = true;
            end;
        end;
    end;
end;
v1.Removed = function(_) --[[ Line: 99 ]] --[[ Name: Removed ]]
    -- upvalues: l_RunService_0 (copy), v5 (copy), v2 (ref), v3 (ref)
    if l_RunService_0:IsClient() then
        local l_GlitchParts_0 = workspace:FindFirstChild("GlitchParts");
        while l_GlitchParts_0 do
            l_GlitchParts_0.Name = "byebye";
            l_GlitchParts_0:Destroy();
            l_GlitchParts_0 = workspace:FindFirstChild("GlitchParts");
        end;
        if v5 then
            for _, v23 in ipairs(v5) do
                v23.part:Destroy();
            end;
            table.clear(v5);
        end;
        if v2 then
            v2:Disconnect();
            v2 = nil;
        end;
        v3 = false;
    end;
end;
return v1;