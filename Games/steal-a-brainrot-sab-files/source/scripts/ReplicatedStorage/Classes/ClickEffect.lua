

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v4 = require(l_Packages_0.Trove);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v6 = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local v8 = {
    GetSize = function(_)
        return 35;
    end
};
v8.new = function(v9)
    if not v9 then
        warn("[ClickEffect] targetPosition nil");
        return;
    else
        local l_ClickEffect_0 = l_PlayerGui_0:FindFirstChild("ClickEffect");
        if not l_ClickEffect_0 then
            l_ClickEffect_0 = Instance.new("ScreenGui");
            l_ClickEffect_0.Name = "ClickEffect";
            l_ClickEffect_0.DisplayOrder = 100;
            l_ClickEffect_0.IgnoreGuiInset = false;
            l_ClickEffect_0.ResetOnSpawn = false;
            l_ClickEffect_0.Parent = l_PlayerGui_0;
        end;
        local v11 = v4.new();
        local v12 = 2;
        local function _()
            v12 = v12 - 1;
            if v12 <= 0 then
                v11:Destroy();
            end;
        end;
        local function v20(v14, v15)
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
            l_Frame_0.Position = UDim2.fromOffset(v9.X, v9.Y);
            l_Frame_0.Size = UDim2.fromOffset(1, 1);
            l_Frame_0.BackgroundColor3 = Color3.new(1, 1, 1);
            l_Frame_0.BackgroundTransparency = 1;
            l_Frame_0.ZIndex = 10;
            l_Frame_0.Parent = l_ClickEffect_0;
            v11:Add(l_Frame_0);
            local l_UICorner_0 = Instance.new("UICorner");
            l_UICorner_0.CornerRadius = UDim.new(1, 0);
            l_UICorner_0.Parent = l_Frame_0;
            v11:Add(l_UICorner_0);
            local v18 = l_TweenService_0:Create(l_Frame_0, v6, {
                Size = UDim2.fromOffset(v14, v14), 
                BackgroundTransparency = 0.3
            });
            v11:Add(v18);
            v18.Completed:Once(function()
                local v19 = l_TweenService_0:Create(l_Frame_0, v6, {
                    Size = UDim2.fromOffset(1, 1), 
                    BackgroundTransparency = 1
                });
                v11:Add(v19);
                v19.Completed:Once(function()
                    l_Frame_0:Destroy();
                    v12 = v12 - 1;
                    if v12 <= 0 then
                        v11:Destroy();
                    end;
                end);
                v19:Play();
            end);
            task.delay(v15, v18.Play, v18);
        end;
        v20(v8:GetSize(), 0);
        v20(v8:GetSize() * 1.25, 0.05);
        return;
    end;
end;
return v8;