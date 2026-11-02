-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new() -- Line: 11
    -- upvalues: Prompt (copy), u1 (copy)
    local v2 = Prompt.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PromptFrame:WaitForChild("Close");
    v3.Container = v3.PromptFrame:WaitForChild("Container");
    v3.TextFrame = v3.PromptFrame:WaitForChild("TextFrame");
    v3.TextFrameBox = v3.TextFrame:WaitForChild("Box");
    v3.TextFrameBackground = v3.TextFrame:WaitForChild("Background");
    v3._reward_slot = nil;
    v3:_Init();

    return v3;
end;

function u1._Update(u4) -- Line: 37
    -- upvalues: HttpService (copy), RewardSlot (copy)
    if u4._reward_slot then
        u4._reward_slot:Destroy();
        u4._reward_slot = nil;
    end;

    local success, result = pcall(HttpService.JSONDecode, HttpService, u4.TextFrameBox.Text);

    if success then
        local success2, result2 = pcall(function() -- Line: 46
            -- upvalues: RewardSlot (ref), result (copy), u4 (copy)
            local v5 = RewardSlot.new(result);
            v5:UseHighResolutionImage();
            v5:SetInteractable(false);
            v5:SetParent(u4.Container);

            return v5;
        end);

        if success2 then
            u4._reward_slot = result2;
        end;
    end;

    local TextFrameBackground = u4.TextFrameBackground;
    local v6;

    if u4.TextFrameBox.Text == "" or u4._reward_slot then
        v6 = Color3.fromRGB(255, 255, 255);
    else
        v6 = Color3.fromRGB(255, 50, 50);
    end;

    TextFrameBackground.ImageColor3 = v6;
end;

function u1._Init(u7) -- Line: 62
    -- upvalues: ButtonEffect (copy)
    u7.CloseButton.MouseButton1Click:Connect(function() -- Line: 63
        -- upvalues: u7 (copy)
        u7:CloseRequest();
    end);
    u7.TextFrameBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 67
        -- upvalues: u7 (copy)
        u7:_Update();
    end);
    u7:_Update();
    ButtonEffect:Add(u7.CloseButton);
end;

return u1;