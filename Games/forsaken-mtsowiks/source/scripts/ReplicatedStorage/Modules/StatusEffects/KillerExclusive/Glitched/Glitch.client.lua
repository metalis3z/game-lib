-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_Part_0 = script:WaitForChild("Part");
local v3 = {};
for _ = 1, 24 do
    local v5 = l_Part_0:Clone();
    v5.Size = Vector3.new(3, 1, -3, 0);
    v5.Parent = workspace;
    table.insert(v3, {
        part = v5, 
        x = 0, 
        y = 0
    });
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 24 ]]
    -- upvalues: v3 (copy)
    for _, v7 in ipairs(v3) do
        local l_CFrame_0 = workspace.CurrentCamera.CFrame;
        v7.part.CFrame = l_CFrame_0 * CFrame.new(v7.x, v7.y, -6);
    end;
end);
while true do
    for _, v10 in ipairs(v3) do
        local v11 = math.random(-8, 8);
        local v12 = math.random(-4, 4);
        v10.x = v11;
        v10.y = v12;
    end;
    task.wait(0.3);
end;