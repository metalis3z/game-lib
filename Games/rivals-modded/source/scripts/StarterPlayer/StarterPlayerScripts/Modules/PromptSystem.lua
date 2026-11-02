-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("GuiService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local Prompts = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompts");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: u1 (copy), Signal (copy)
    local v3;

    if typeof(p2) == "Instance" then
        v3 = p2:IsA("ImageButton");
    else
        v3 = false;
    end;

    local v4 = "Argument 1 invalid, expected an ImageButton, got " .. tostring(p2);
    assert(v3, v4);
    local v5 = setmetatable({}, u1);
    v5.PromptAdded = Signal.new();
    v5.PromptRemoved = Signal.new();
    v5.PromptsFrame = p2;
    v5.PromptsFrameBackground = v5.PromptsFrame:WaitForChild("Background");
    v5.CurrentPrompt = nil;
    v5._locked = false;
    v5:_Init();

    return v5;
end;

function u1.GetDefaultElement(p6) -- Line: 41
    local v7 = p6.CurrentPrompt and p6.CurrentPrompt:GetDefaultElement();

    return v7;
end;

function u1.Lock(p8, p9) -- Line: 46
    local v10 = typeof(p9) == "boolean";
    local v11 = "Argument 1 invalid, expected a boolean, got " .. tostring(p9);
    assert(v10, v11);
    p8._locked = p9;
end;

function u1.Open(u12, p13, ...) -- Line: 53
    -- upvalues: Prompts (copy), Utility (copy)
    local v14 = not p13 or typeof(p13) == "string";
    local v15 = "Argument 1 invalid, expected a string or nil, got " .. tostring(p13);
    assert(v14, v15);
    u12:Close(true);

    if p13 then
        local v16 = require(Prompts[p13]);
        assert(v16.GetDefaultElement, "You forgot to implement " .. p13 .. ":GetDefaultElement()");
        assert(v16.CloseRequest, "You forgot to implement " .. p13 .. ":CloseRequest()");
        assert(v16.Open, "You forgot to implement " .. p13 .. ":Open()");
        assert(v16.Destroy, "You forgot to implement " .. p13 .. ":Destroy()");
        u12.CurrentPrompt = v16.new(...);
        u12.CurrentPrompt.Closed:Connect(function() -- Line: 68
            -- upvalues: u12 (copy)
            u12:Close();
        end);
        u12.CurrentPrompt.OpenPrompt:Connect(function(...) -- Line: 72
            -- upvalues: u12 (copy)
            u12:Open(...);
        end);
        u12.CurrentPrompt:Open(u12.PromptsFrame);
        local CurrentPrompt = u12.CurrentPrompt;
        u12.PromptsFrame.Visible = true;
        task.spawn(Utility.RenderstepForLoop, Utility, (1 - u12.PromptsFrameBackground.BackgroundTransparency) * 100, 100, 4, function(p17) -- Line: 82
            -- upvalues: u12 (copy), CurrentPrompt (copy)
            if u12.CurrentPrompt ~= CurrentPrompt then
                return true;
            end;

            u12.PromptsFrameBackground.BackgroundTransparency = 1 + -0.667 * (1 - (1 - p17 / 100) ^ 5);
        end);
        u12.PromptAdded:Fire(u12.CurrentPrompt);
    end;

    return u12.CurrentPrompt;
end;

function u1.Close(u18, p19) -- Line: 100
    -- upvalues: Utility (copy)
    local v20 = not p19 or typeof(p19) == "boolean";
    local v21 = "Argument 1 invalid, expected a boolean or nil, got " .. tostring(p19);
    assert(v20, v21);
    local CurrentPrompt = u18.CurrentPrompt;

    if CurrentPrompt then
        u18.CurrentPrompt = nil;
        u18:Lock(false);
        CurrentPrompt:Destroy();
        u18.PromptRemoved:Fire(CurrentPrompt);

        if p19 then
            return;
        end;

        task.spawn(function() -- Line: 115
            -- upvalues: Utility (ref), u18 (copy)
            Utility:RenderstepForLoop(u18.PromptsFrameBackground.BackgroundTransparency * 100, 100, 10, function(p22) -- Line: 116
                -- upvalues: u18 (ref)
                if u18.CurrentPrompt then
                    return true;
                end;

                u18.PromptsFrameBackground.BackgroundTransparency = 0.333 + 0.667 * (p22 / 100);
            end);
            u18.PromptsFrame.Visible = u18.CurrentPrompt ~= nil;
        end);
    end;
end;

function u1.Destroy(p23) -- Line: 131
    p23:Close(true);
    p23.PromptAdded:Destroy();
    p23.PromptRemoved:Destroy();
end;

function u1._IsMouseWithinPromptBounds(p24) -- Line: 141
    -- upvalues: UILibrary (copy)
    if p24._locked then
        return true;
    end;

    local v25 = p24.CurrentPrompt and p24.CurrentPrompt.PromptFrame;

    if v25 then
        v25 = UILibrary:IsMouseWithinBounds(v25.AbsolutePosition, v25.AbsoluteSize);
    end;

    return v25;
end;

function u1._Init(u26) -- Line: 151
    u26.PromptsFrame.MouseButton1Click:Connect(function() -- Line: 152
        -- upvalues: u26 (copy)
        if not u26:_IsMouseWithinPromptBounds() then
            u26:Close();
        end;
    end);
end;

return u1;