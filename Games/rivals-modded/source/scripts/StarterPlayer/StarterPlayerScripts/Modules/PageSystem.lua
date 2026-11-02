-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local Pages = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Pages");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = typeof(p2) == "Instance";
    local v4 = "Argument 1 invalid, expected an Instance, got " .. tostring(p2);
    assert(v3, v4);
    local v5 = setmetatable({}, u1);
    v5.CurrentPage = nil;
    v5.PageAdded = Signal.new();
    v5.PageOpened = Signal.new();
    v5.PageClosed = Signal.new();
    v5.PagesActivity = Signal.new();
    v5._pages = {};
    v5._container = p2;
    v5:_Init();

    return v5;
end;

function u1.GetDefaultElement(p6) -- Line: 39
    local v7 = p6.CurrentPage and p6.CurrentPage:GetDefaultElement();

    return v7;
end;

function u1.CloseRequest(p8) -- Line: 43
    if p8.CurrentPage then
        p8.CurrentPage:CloseRequest();
    end;
end;

function u1.GetPage(p9, p10) -- Line: 50
    local v11 = typeof(p10) == "string";
    local v12 = "Argument 1 invalid, expected a string, got " .. tostring(p10);
    assert(v11, v12);

    for i, v in pairs(p9._pages) do
        if v.Name == p10 then
            return v, i;
        end;
    end;
end;

function u1.OpenPage(p13, p14, p15) -- Line: 61
    local v16 = typeof(p14) == "string";
    local v17 = "Argument 1 invalid, expected a string, got " .. tostring(p14);
    assert(v16, v17);
    local v18 = not p15 or typeof(p15) == "boolean";
    local v19 = "Argument 2 invalid, expected a boolean or nil, got " .. tostring(p15);
    assert(v18, v19);
    local Page = p13:GetPage(p14);

    if not Page then
        p13:CreatePage(p14);
        Page = p13:WaitForPage(p14);
    end;

    local v20 = "Argument 1 invalid, expected a valid page name, got " .. tostring(p14);
    assert(Page ~= nil, v20);

    if Page ~= p13.CurrentPage then
        if p15 ~= false then
            p13:CloseCurrentPage();
            p13:_OpenPage(Page);
        end;

        return;
    end;

    if p15 then
        return;
    end;

    p13:CloseCurrentPage();
end;

function u1.CloseCurrentPage(p21) -- Line: 86
    local CurrentPage = p21.CurrentPage;

    if CurrentPage then
        CurrentPage:Close();
        p21.CurrentPage = nil;
        p21.PageClosed:Fire(CurrentPage);
    end;
end;

function u1.WaitForPage(p22, p23) -- Line: 97
    local v24 = typeof(p23) == "string";
    local v25 = "Argument 1 invalid, expected a string, got " .. tostring(p23);
    assert(v24, v25);
    local Page = p22:GetPage(p23);

    while not Page or Page.Name ~= p23 do
        Page = p22.PageAdded:Wait();
    end;

    return Page;
end;

function u1.CreatePage(u26, p27) -- Line: 110
    -- upvalues: Pages (copy)
    local v28 = typeof(p27) == "string";
    local v29 = "Argument 1 invalid, expected a string, got " .. tostring(p27);
    assert(v28, v29);
    local u30 = require(Pages:WaitForChild(p27));
    assert(u30.GetDefaultElement, "You forgot to implement " .. p27 .. ":GetDefaultElement()");
    assert(u30.CloseRequest, "You forgot to implement " .. p27 .. ":CloseRequest()");
    u30.Closed:Connect(function() -- Line: 118
        -- upvalues: u26 (copy), u30 (copy)
        u26:OpenPage(u30.Name, false);
    end);
    u30.OpenPage:Connect(function(...) -- Line: 122
        -- upvalues: u30 (copy), u26 (copy)
        if u30:IsOpen() then
            u26:OpenPage(...);
        end;
    end);
    u30:Close();
    table.insert(u26._pages, u30);
    u26.PageAdded:Fire(u30);
end;

function u1._OpenPage(p31, p32) -- Line: 139
    -- upvalues: ControlsController (copy), Players (copy), GamepadService (copy)
    p31.CurrentPage = p32;
    p31.CurrentPage:Open(p31._container);
    p31.PageOpened:Fire(p31.CurrentPage);

    if ControlsController.CurrentControls == "Gamepad" then
        local DefaultElement = p31.CurrentPage:GetDefaultElement();

        if not (DefaultElement and DefaultElement:IsDescendantOf(Players.LocalPlayer.PlayerGui)) then
            return;
        end;

        GamepadService:EnableGamepadCursor(DefaultElement);
    end;
end;

function u1._Init(u33) -- Line: 155
    u33.PageOpened:Connect(function() -- Line: 156
        -- upvalues: u33 (copy)
        u33.PagesActivity:Fire();
    end);
    u33.PageClosed:Connect(function() -- Line: 160
        -- upvalues: u33 (copy)
        u33.PagesActivity:Fire();
    end);
end;

return u1;