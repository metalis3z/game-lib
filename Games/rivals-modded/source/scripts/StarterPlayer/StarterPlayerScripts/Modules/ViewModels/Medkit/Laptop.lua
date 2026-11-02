-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local Medkit = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Medkit);
local u1 = setmetatable({}, Medkit);
u1.__index = u1;

function u1.new(...) -- Line: 22
    -- upvalues: Medkit (copy), u1 (copy)
    local v2 = Medkit.new(...);
    local v3 = setmetatable(v2, u1);
    v3._play_cat_gif_hash = 0;
    v3._cat_surface_gui = v3.ItemModel:WaitForChild("MedkitTop"):WaitForChild("Screen"):WaitForChild("CatGui");
    v3._cat_image_label = v3._cat_surface_gui:WaitForChild("Frame"):WaitForChild("ImageLabel"):WaitForChild("Picture"):WaitForChild("ImageLabel");
    v3._use_surface_gui = v3.ItemModel:WaitForChild("MedkitTop"):WaitForChild("Screen"):WaitForChild("UseGui");
    v3._use_bar = v3._use_surface_gui:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Bar");
    v3._use_text = v3._use_surface_gui:WaitForChild("Frame"):WaitForChild("Progress");
    v3._use_background = v3._use_surface_gui:WaitForChild("Frame"):WaitForChild("ImageLabel");
    v3._use_effect_hash = 0;
    v3._use_tween = nil;
    v3:_Init();

    return v3;
end;

function u1._CancelTween(p4) -- Line: 50
    if p4._use_tween then
        p4._use_tween:Pause();
        p4._use_tween = nil;
    end;
end;

function u1._UpdateUseBar(p5) -- Line: 57
    p5._use_text.Text = p5._use_bar.AbsoluteSize.X <= 1 and "• • •" or math.floor(p5._use_bar.AbsoluteSize.X / p5._use_bar.Parent.AbsoluteSize.X * 100) .. "%";
end;

function u1._UpdateUseGui(u6) -- Line: 61
    -- upvalues: AnimationLibrary (copy), TweenService (copy)
    u6:_CancelTween();
    u6._use_effect_hash = u6._use_effect_hash + 1;
    local _use_effect_hash = u6._use_effect_hash;
    local v7 = u6:IsAnimationPlaying("Use");
    local v8 = not v7 or u6:IsAnimationPlaying("UseQuick");
    u6._use_surface_gui.Enabled = v7 or v8;

    if not u6._use_surface_gui.Enabled then
        return;
    end;

    task.spawn(function() -- Line: 74
        -- upvalues: u6 (copy), _use_effect_hash (copy)
        while not u6._destroyed and u6._use_effect_hash == _use_effect_hash do
            u6._use_background.Image = "rbxassetid://134936596399147";
            wait(0.1);

            if u6._destroyed or u6._use_effect_hash ~= _use_effect_hash then
                return;
            end;

            u6._use_background.Image = "rbxassetid://115756225131937";
            wait(0.1);
        end;
    end);
    u6._use_bar.Size = UDim2.new(0, 0, 1, 0);

    if not v7 then
        if v8 then
            wait(AnimationLibrary.Info[u6.Info.Animations.UseQuick].ActionTimestamp);

            if u6._destroyed or u6._use_effect_hash ~= _use_effect_hash then
                return;
            end;

            u6._use_bar.Size = UDim2.new(1, 0, 1, 0);
        end;

        return;
    end;

    local v9 = AnimationLibrary.Info[u6.Info.Animations.Use];
    local v10 = 2.07765 / v9.Speed;
    wait(v10);

    if u6._destroyed or u6._use_effect_hash ~= _use_effect_hash then
        return;
    end;

    u6._use_tween = TweenService:Create(u6._use_bar, TweenInfo.new(v9.ActionTimestamp - v10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0)
    });
    u6._use_tween:Play();
end;

function u1._UpdateCatGui(p11) -- Line: 117
    p11._play_cat_gif_hash = p11._play_cat_gif_hash + 1;
    local _play_cat_gif_hash = p11._play_cat_gif_hash;
    p11._cat_surface_gui.Enabled = p11:IsAnimationPlaying("RareInspect");

    if not p11._cat_surface_gui.Enabled then
        return;
    end;

    local v12 = 1;

    while not (p11._destroyed or (not p11:IsAnimationPlaying("RareInspect") or p11._play_cat_gif_hash ~= _play_cat_gif_hash)) do
        local math_floor_ret = math.floor((v12 - 1) / 4);
        p11._cat_image_label.Position = UDim2.new((v12 - 1) % 4 * -1, 0, math_floor_ret * -1, 0);
        v12 = v12 % 14 + 1;
        wait(0.1);
    end;
end;

function u1._Setup(p13) -- Line: 145
    p13._cat_image_label.Image = "rbxassetid://120426879154579";
    p13._cat_image_label.Size = UDim2.new(p13._cat_image_label.Size.X.Scale * 4, p13._cat_image_label.Size.X.Offset * 4, p13._cat_image_label.Size.Y.Scale * 4, p13._cat_image_label.Size.Y.Offset * 4);
end;

function u1._Init(u14) -- Line: 157
    u14.AnimationPlayed:Connect(function(p15) -- Line: 158
        -- upvalues: u14 (copy)
        if p15 == "RareInspect" then
            u14:_UpdateCatGui();

            return;
        end;

        if p15 == "Use" or p15 == "UseQuick" then
            u14:_UpdateUseGui();
        end;
    end);
    u14.AnimationStopped:Connect(function(p16) -- Line: 166
        -- upvalues: u14 (copy)
        if p16 == "RareInspect" then
            u14:_UpdateCatGui();

            return;
        end;

        if p16 == "Use" or p16 == "UseQuick" then
            u14:_UpdateUseGui();
        end;
    end);
    u14.Equipped:Connect(function() -- Line: 174
        -- upvalues: u14 (copy)
        u14:_CancelTween();
    end);
    u14._use_bar:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 178
        -- upvalues: u14 (copy)
        u14:_UpdateUseBar();
    end);
    u14:_Setup();
end;

return u1;