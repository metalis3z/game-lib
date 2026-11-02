-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Pages = p2;
    v3.Frame = v3.Pages.Frame:WaitForChild("Bundles");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.PermanentFrame = v3.Container:WaitForChild("Permanent");
    v3.TimedFrame = v3.Container:WaitForChild("Timed");
    v3._is_open_hash = 0;
    v3._superstarterbundle_slot = nil;
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 31
    if p4._superstarterbundle_slot then
        p4._superstarterbundle_slot:StartLoops();
    end;
end;

function u1.Close(p5) -- Line: 37
    if p5._superstarterbundle_slot then
        p5._superstarterbundle_slot:StopLoops();
    end;
end;

function u1.Setup(p6) -- Line: 43
    for _, v in pairs(p6.Pages.Shop.BUNDLE_NAMES) do
        p6.Pages.Shop:CreateBundleSlot(v):SetParent(p6.PermanentFrame:WaitForChild(v));
    end;

    p6:_SetupSuperStarterBundleSlot();
end;

function u1._SetupSuperStarterBundleSlot(u7) -- Line: 55
    u7._superstarterbundle_slot = u7.Pages.Shop:CreateBundleSlot("superstarter_bundle");
    u7._superstarterbundle_slot:SetParent(u7.TimedFrame:WaitForChild("superstarter_bundle"));
    u7._superstarterbundle_slot.AvailabilityChanged:Connect(function() -- Line: 59, Name: update
        -- upvalues: u7 (copy)
        u7.TimedFrame.Visible = u7._superstarterbundle_slot:IsAvailableToPurchase();
    end);
    u7.TimedFrame.Visible = u7._superstarterbundle_slot:IsAvailableToPurchase();

    if u7.Pages.Shop:IsOpen() then
        u7._superstarterbundle_slot:StartLoops();
    end;
end;

function u1._Init(p8) -- Line: 71
end;

return u1;