-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Pages = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Temp"):WaitForChild("Pages");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy), Pages (copy)
    local v3 = typeof(p2) == "string";
    local v4 = "Argument 1 invalid, expected a string, got " .. tostring(p2);
    assert(v3, v4);
    local v5 = setmetatable({}, u1);
    v5.OpenChanged = Signal.new();
    v5.Closed = Signal.new();
    v5.OpenPage = Signal.new();
    v5.Name = p2;
    v5.PageFrame = UILibrary:GetPage(p2);
    v5.CantBeClosedFromInputs = false;
    v5._default_size = v5.PageFrame.Size;
    v5._is_open = false;
    v5._is_open_hash = 0;
    v5._open_connections = {};
    v5._open_threads = {};
    v5._temp_folder = Pages;
    v5._redirect_to = nil;
    v5._open_animation_disabled = false;
    v5:_Init();

    return v5;
end;

function u1.GetDefaultElement(p6) -- Line: 46
    return p6.PromptSystem and p6.PromptSystem:GetDefaultElement() or p6.PageFrame;
end;

function u1.CloseRequest(p7) -- Line: 50
    if p7.PromptSystem and p7.PromptSystem.CurrentPrompt then
        p7.PromptSystem.CurrentPrompt:CloseRequest();

        return;
    end;

    if not p7._redirect_to then
        p7.Closed:Fire();

        return;
    end;

    p7.OpenPage:Fire(p7._redirect_to);
    p7._redirect_to = nil;
end;

function u1.IsOpen(p8) -- Line: 61
    return p8._is_open;
end;

function u1.Open(p9, p10) -- Line: 66
    -- upvalues: GuiService (copy)
    local v11 = typeof(p10) == "Instance";
    local v12 = "Argument 1 invalid, expected an Instance, got " .. tostring(p10);
    assert(v11, v12);
    p9.PageFrame.Parent = p10;
    p9.PageFrame.Visible = true;

    if p9._open_animation_disabled or GuiService.ReducedMotionEnabled then
        p9.PageFrame.Size = p9._default_size;
        p9.PageFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
    else
        p9.PageFrame.Size = UDim2.new(p9._default_size.X.Scale * 0.75, p9._default_size.X.Offset * 0.75, p9._default_size.Y.Scale * 0.75, p9._default_size.Y.Offset * 0.75);
        p9.PageFrame:TweenSize(p9._default_size, "Out", "Back", 0.25, true);
        p9.PageFrame.Position = UDim2.new(0.5, 0, 0.6, 0);
        p9.PageFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.25, true);
    end;

    p9:_CleanupOnOpenChanged();
    p9._is_open = true;
    p9._is_open_hash = p9._is_open_hash + 1;
    p9.OpenChanged:Fire();
end;

function u1.Close(p13) -- Line: 88
    -- upvalues: Pages (copy)
    p13:_CleanupOnOpenChanged();
    p13._is_open = false;
    p13._is_open_hash = p13._is_open_hash + 1;
    p13.OpenChanged:Fire();

    if p13.PromptSystem then
        p13.PromptSystem:Close();
    end;

    p13.PageFrame.Visible = false;
    p13.PageFrame.Parent = Pages;
end;

function u1.RedirectTo(p14, p15) -- Line: 102
    p14._redirect_to = p15;
end;

function u1._CleanupOnOpenChanged(p16) -- Line: 110
    for _, v in pairs(p16._open_connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p16._open_threads) do
        pcall(task.cancel, v);
    end;

    p16._open_connections = {};
    p16._open_threads = {};
end;

function u1._Init(p17) -- Line: 123
end;

return u1;