-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Parent_0 = script.Parent;
local l_Ring_0 = l_Parent_0:WaitForChild("Ring");
local function v6() --[[ Line: 11 ]] --[[ Name: SpawnRing ]]
    -- upvalues: l_Ring_0 (copy), l_Parent_0 (copy), l_TweenService_0 (copy)
    local v3 = l_Ring_0:Clone();
    v3.Parent = l_Parent_0;
    v3.CFrame = l_Ring_0.CFrame;
    local v4 = l_TweenService_0:Create(v3, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = v3.CFrame * CFrame.new(0, 20, 0)
    });
    local v5 = l_TweenService_0:Create(v3, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        Transparency = 1
    });
    v4:Play();
    v5:Play();
    task.delay(1.55, function() --[[ Line: 19 ]]
        -- upvalues: v3 (copy)
        v3:Destroy();
    end);
end;
while true do
    v6();
    task.wait(0.75);
end;