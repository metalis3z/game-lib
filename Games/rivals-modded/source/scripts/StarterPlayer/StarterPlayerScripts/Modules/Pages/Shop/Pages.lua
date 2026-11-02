-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
require(script:WaitForChild("Daily"));
require(script:WaitForChild("Currency"));
require(script:WaitForChild("Bundles"));
require(script:WaitForChild("Ranked"));
require(script:WaitForChild("Skins"));
require(script:WaitForChild("Home"));
local ShopPages = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Temp"):WaitForChild("ShopPages");
local u1 = { "Currency", "Bundles", "Ranked", "Daily", "Skins", "Home" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 18
    -- upvalues: u2 (copy), Signal (copy)
    local v4 = setmetatable({}, u2);
    v4.UpdateCanvasSize = Signal.new();
    v4.Shop = p3;
    v4.Frame = v4.Shop.Container:WaitForChild("Pages");
    v4.Components = {};
    v4._page_frames = {};
    v4:_Init();

    return v4;
end;

function u2.GetComponentFrame(p5, p6) -- Line: 39
    return p5.Components[p6] and p5.Components[p6].Frame;
end;

function u2.Open(p7) -- Line: 43
    for _, v in pairs(p7.Components) do
        v:Open();
    end;
end;

function u2.Close(p8) -- Line: 49
    for _, v in pairs(p8.Components) do
        v:Close();
    end;
end;

function u2.Setup(p9) -- Line: 55
    for _, v in pairs(p9.Components) do
        v:Setup();
    end;

    p9:_Update();
end;

function u2._Update(p10) -- Line: 67
    -- upvalues: ShopPages (copy)
    for i, v in pairs(p10._page_frames) do
        local v11 = i == p10.Shop.CurrentPage;
        v.Parent = v11 and p10.Frame or ShopPages;
        v.Visible = v11;
    end;
end;

function u2._Setup(u12) -- Line: 76
    -- upvalues: u1 (copy), ShopPages (copy)
    for _, v in pairs(u1) do
        local v13 = require(script:WaitForChild(v)).new(u12);
        v13.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 80
            -- upvalues: u12 (copy)
            u12.UpdateCanvasSize:Fire();
        end);
        v13.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 84
            -- upvalues: u12 (copy)
            u12.UpdateCanvasSize:Fire();
        end);
        u12.Components[v] = v13;
    end;

    for _, v in pairs(u12.Shop.PAGE_NAMES) do
        local v14 = u12.Frame:WaitForChild(v);
        v14.Visible = false;
        v14.Parent = ShopPages;
        u12._page_frames[v] = v14;
    end;
end;

function u2._Init(u15) -- Line: 99
    u15.Shop.CurrentPageChanged:Connect(function() -- Line: 100
        -- upvalues: u15 (copy)
        u15:_Update();
    end);
    u15:_Setup();
end;

return u2;