-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Parent = script.Parent;
local GradientOverlay = Parent:WaitForChild("GradientOverlay");
local u1 = GradientOverlay:FindFirstChildWhichIsA("UIGradient");
local HeartsContainer = Parent:WaitForChild("HeartsContainer");
local u2 = {
    Color3.fromRGB(255, 182, 193),
    Color3.fromRGB(255, 150, 170),
    Color3.fromRGB(255, 200, 210),
    Color3.fromRGB(240, 128, 160),
    Color3.fromRGB(255, 170, 190),
    Color3.fromRGB(248, 200, 220),
    Color3.fromRGB(255, 105, 140)
};
local u3 = false;

local function playGradientPulse() -- Line: 23
    -- upvalues: GradientOverlay (copy), u1 (copy), TweenService (copy), u3 (ref)
    GradientOverlay.BackgroundTransparency = 1;
    GradientOverlay.Size = UDim2.new(1, 0, 0.4, 0);
    GradientOverlay.Position = UDim2.new(0, 0, 0.6, 0);
    u1.Offset = Vector2.new(0, 0);
    TweenService:Create(GradientOverlay, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play();
    local u4 = TweenInfo.new(0.675, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    task.spawn(function() -- Line: 35
        -- upvalues: u3 (ref), TweenService (ref), GradientOverlay (ref), u4 (copy), u1 (ref)
        local v5 = 0;

        while u3 and v5 < 2 do
            TweenService:Create(GradientOverlay, u4, {
                Size = UDim2.new(1, 0, 0.45, 0),
                Position = UDim2.new(0, 0, 0.55, 0)
            }):Play();
            TweenService:Create(u1, u4, {
                Offset = Vector2.new(0, -0.06)
            }):Play();
            task.wait(0.675);
            TweenService:Create(GradientOverlay, u4, {
                Size = UDim2.new(1, 0, 0.4, 0),
                Position = UDim2.new(0, 0, 0.6, 0)
            }):Play();
            TweenService:Create(u1, u4, {
                Offset = Vector2.new(0, 0.03)
            }):Play();
            task.wait(0.675);
            v5 = v5 + 1;
        end;
    end);
    task.delay(2.25, function() -- Line: 48
        -- upvalues: TweenService (ref), GradientOverlay (ref), u1 (ref)
        local v6 = TweenService:Create(GradientOverlay, TweenInfo.new(1.125, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 1
        });
        v6:Play();
        v6.Completed:Once(function() -- Line: 53
            -- upvalues: GradientOverlay (ref), u1 (ref)
            GradientOverlay.Size = UDim2.new(1, 0, 0.4, 0);
            GradientOverlay.Position = UDim2.new(0, 0, 0.6, 0);
            u1.Offset = Vector2.new(0, 0);
        end);
    end);
end;

local function spawnHeart(p7) -- Line: 61
    -- upvalues: u2 (copy), HeartsContainer (copy), TweenService (copy)
    task.delay(p7, function() -- Line: 62
        -- upvalues: u2 (ref), HeartsContainer (ref), TweenService (ref)
        local v8 = math.random(40, 75) / 1000;
        local v9 = math.random(5, 95) / 100;
        local v10 = (math.random() - 0.5) * 0.12;
        local v11 = math.random(-25, 25);
        local v12 = v11 + math.random(-60, 60);
        local v13 = 0.15 + math.random() * 0.15;
        local u14 = 1.35 + math.random() * 0.75;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Heart";
        ImageLabel.Image = "rbxassetid://137209860825391";
        ImageLabel.ImageColor3 = u2[math.random(1, #u2)];
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Size = UDim2.new(v8, 0, v8, 0);
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Position = UDim2.new(v9, 0, 1.05, 0);
        ImageLabel.Rotation = v11;
        ImageLabel.ImageTransparency = 1;
        ImageLabel.ZIndex = 3;
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.Parent = HeartsContainer;
        TweenService:Create(ImageLabel, TweenInfo.new(0.225, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0.05
        }):Play();
        TweenService:Create(ImageLabel, TweenInfo.new(u14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(v9 + v10, 0, 1.05 - v13, 0),
            Rotation = v12
        }):Play();
        task.delay(u14 * 0.6, function() -- Line: 94
            -- upvalues: TweenService (ref), ImageLabel (copy), u14 (copy)
            local v15 = TweenService:Create(ImageLabel, TweenInfo.new(u14 * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1
            });
            v15:Play();
            v15.Completed:Once(function() -- Line: 99
                -- upvalues: ImageLabel (ref)
                ImageLabel:Destroy();
            end);
        end);
    end);
end;

local function playLikeEffect() -- Line: 106
    -- upvalues: u3 (ref), playGradientPulse (copy), u2 (copy), HeartsContainer (copy), TweenService (copy)
    if u3 then
        return;
    end;

    u3 = true;
    playGradientPulse();

    for _ = 1, 22 do
        local v16 = math.random() * 1.65;
        task.delay(v16, function() -- Line: 62
            -- upvalues: u2 (ref), HeartsContainer (ref), TweenService (ref)
            local v17 = math.random(40, 75) / 1000;
            local v18 = math.random(5, 95) / 100;
            local v19 = (math.random() - 0.5) * 0.12;
            local v20 = math.random(-25, 25);
            local v21 = v20 + math.random(-60, 60);
            local v22 = 0.15 + math.random() * 0.15;
            local u23 = 1.35 + math.random() * 0.75;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Heart";
            ImageLabel.Image = "rbxassetid://137209860825391";
            ImageLabel.ImageColor3 = u2[math.random(1, #u2)];
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Size = UDim2.new(v17, 0, v17, 0);
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Position = UDim2.new(v18, 0, 1.05, 0);
            ImageLabel.Rotation = v20;
            ImageLabel.ImageTransparency = 1;
            ImageLabel.ZIndex = 3;
            ImageLabel.ScaleType = Enum.ScaleType.Fit;
            ImageLabel.Parent = HeartsContainer;
            TweenService:Create(ImageLabel, TweenInfo.new(0.225, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0.05
            }):Play();
            TweenService:Create(ImageLabel, TweenInfo.new(u23, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = UDim2.new(v18 + v19, 0, 1.05 - v22, 0),
                Rotation = v21
            }):Play();
            task.delay(u23 * 0.6, function() -- Line: 94
                -- upvalues: TweenService (ref), ImageLabel (copy), u23 (copy)
                local v24 = TweenService:Create(ImageLabel, TweenInfo.new(u23 * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ImageTransparency = 1
                });
                v24:Play();
                v24.Completed:Once(function() -- Line: 99
                    -- upvalues: ImageLabel (ref)
                    ImageLabel:Destroy();
                end);
            end);
        end);
    end;

    task.delay(5.25, function() -- Line: 116
        -- upvalues: u3 (ref)
        u3 = false;
    end);
end;

game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Events"):WaitForChild("PlayLikeEffect").Event:Connect(playLikeEffect);