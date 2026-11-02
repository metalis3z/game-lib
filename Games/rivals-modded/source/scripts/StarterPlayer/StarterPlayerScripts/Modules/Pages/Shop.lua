-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
require(ReplicatedStorage.Modules.EventLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShopController"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Spotlight = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Spotlight"));
local ShopSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseShopSlot"):WaitForChild("ShopSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local BundleSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local BottomTabs = require(script:WaitForChild("BottomTabs"));
local Pages = require(script:WaitForChild("Pages"));
local Tabs = require(script:WaitForChild("Tabs"));
local u1 = { "rpg_bundle", "energy_bundle", "starter_bundle", "medkit_bundle", "exogun_bundle", "heavyduty_bundle", "classic_bundle", "standardweapons_bundle" };
local u2 = { "Home", "Bundles", "Skins", "Daily", "Currency", "Ranked", "Rewards", "Gifting", "Weapons" };
local u3 = setmetatable({}, Page);
u3.__index = u3;

function u3._new() -- Line: 31
    -- upvalues: Page (copy), u3 (copy), Signal (copy), u1 (copy), u2 (copy), PromptSystem (copy), Tabs (copy), Pages (copy), BottomTabs (copy)
    local v4 = Page.new(script.Name);
    local v5 = setmetatable(v4, u3);
    v5.CurrentPageChanged = Signal.new();
    v5.PageContainer = v5.PageFrame:WaitForChild("Container");
    v5.PromptsFrame = v5.PageContainer:WaitForChild("Prompts");
    v5.WaitingFrame = v5.PageContainer:WaitForChild("Waiting");
    v5.DotsFrame = v5.WaitingFrame:WaitForChild("Dots");
    v5.List = v5.PageContainer:WaitForChild("List");
    v5.Container = v5.List:WaitForChild("Container");
    v5.BUNDLE_NAMES = u1;
    v5.PAGE_NAMES = u2;
    v5.HidePartyDisplay = true;
    v5.CurrentPage = nil;
    v5.PromptSystem = PromptSystem.new(v5.PromptsFrame);
    v5.Tabs = Tabs.new(v5);
    v5.Pages = Pages.new(v5);
    v5.BottomTabs = BottomTabs.new(v5);
    v5._open_animation_disabled = true;
    v5._setup_finished = false;
    v5._setup_finished_event_internal = Signal.new();
    v5._bundle_slots = {};
    v5:_Init();

    return v5;
end;

function u3.SetPage(p6, p7) -- Line: 67
    -- upvalues: Spotlight (copy), Equipment (copy)
    Spotlight:ChangeSubject(nil);

    if p7 == "Weapons" then
        Equipment:Open(true);
        p6:CloseRequest();

        return;
    end;

    if p7 == "Gifting" then
        p6.OpenPage:Fire("Gifting");

        return;
    end;

    if p7 == "Rewards" then
        p6.OpenPage:Fire("Rewards");

        return;
    end;

    if p7 == "BattlePass" then
        p6.OpenPage:Fire("BattlePass");

        return;
    end;

    p6.CurrentPage = p7;
    p6.CurrentPageChanged:Fire(p6.CurrentPage);
end;

function u3.InspectShopEntry(p8, p9) -- Line: 89
    if p9 then
        p8.PromptSystem:Open("InspectShopEntry", p9);
    end;
end;

function u3.InspectBundle(u10, u11, p12) -- Line: 95
    if not u11 then
        return;
    end;

    task.defer(function() -- Line: 100
        -- upvalues: u10 (copy), u11 (copy)
        if not u10._setup_finished then
            u10._setup_finished_event_internal:Wait();
        end;

        u10.PromptSystem:Open("InspectBundle", u11);
    end);
end;

function u3.CreateShopSlot(u13, p14, p15, p16, ...) -- Line: 109
    -- upvalues: Utility (copy), ShopController (copy), ShopSlot (copy), CosmeticLibrary (copy), ComplianceController (copy)
    local v17 = Utility:CloneTable(ShopController:GetShopEntry(p16));

    if p15 then
        p15.BackgroundTransparency = 1;
    end;

    for _, v in pairs(v17.Rewards) do
        local v18 = CosmeticLibrary.Rewards[v.Name];

        if v18 and v18.Type == "Lootbox" then
            ComplianceController:ArePaidRandomItemsRestricted();
        end;
    end;

    local u19 = (p14 or ShopSlot).new(v17, ...);
    u19.Frame.Parent = p15;
    u19:OnClick(function() -- Line: 128
        -- upvalues: u19 (copy), u13 (copy)
        if u19.IsLocked or u19.IsOwned then
            return;
        end;

        u13:InspectShopEntry(u19.ShopEntry.EntryName);
    end);

    return u19;
end;

function u3.CreateBundleSlot(u20, p21) -- Line: 139
    -- upvalues: BundleSlot (copy), ControlsController (copy)
    local u22 = BundleSlot.new(p21);
    u20._bundle_slots[p21] = u22;
    u22.Tapped:Connect(function() -- Line: 143
        -- upvalues: ControlsController (ref), u20 (copy), u22 (copy)
        if ControlsController.CurrentControls == "Touch" then
            u20:InspectBundle(u22.Name);

            return;
        end;

        u22:PurchaseRequest();
    end);

    return u22;
end;

function u3.Open(p23, ...) -- Line: 155
    -- upvalues: Page (copy), Utility (copy)
    Page.Open(p23, ...);
    p23.Tabs:Open();
    p23.Pages:Open();
    p23.BottomTabs:Open();
    Utility:CreateSound("rbxassetid://18100002432", 1.25, 1, script, true, 5);
end;

function u3.Close(p24, ...) -- Line: 163
    -- upvalues: Page (copy)
    Page.Close(p24, ...);
    p24.Tabs:Close();
    p24.Pages:Close();
    p24.BottomTabs:Close();
end;

function u3._CheckScrollDownToLoginRewards(u25) -- Line: 174
    -- upvalues: PlayerDataController (copy), TweenService (copy)
    if u25.CurrentPage ~= "Daily" or PlayerDataController:Get("ClaimedLoginRewardToday") then
        return;
    end;

    local Frame = u25.Pages.Components.Daily.LoginRewards.Frame;
    task.delay(0.15, function() -- Line: 181
        -- upvalues: TweenService (ref), u25 (copy), Frame (copy)
        TweenService:Create(u25.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, Frame.AbsolutePosition.Y - u25.Container.AbsolutePosition.Y)
        }):Play();
    end);
end;

function u3._UpdatePromptContext(p26) -- Line: 186
    p26.List.Visible = not p26.PromptSystem.CurrentPrompt;
end;

function u3._UpdateScale(p27) -- Line: 190
    local v28 = p27.CurrentPage == "Home" and 0.9 or 1;
    p27.List.Size = UDim2.new(1 / v28, 18, 1, 0);
    p27.Container.Size = UDim2.new(v28 * 1, -8, v28 * 1, -8);
end;

function u3._UpdateCanvasSize(p29) -- Line: 197
    -- upvalues: UILibrary (copy)
    local ComponentFrame = p29.Pages:GetComponentFrame(p29.CurrentPage);
    p29.List.Size = UDim2.new(1, 18, 0, (math.min(p29.PageFrame.AbsoluteSize.Y, UILibrary.MainGui.AbsolutePosition.Y + UILibrary.MainGui.AbsoluteSize.Y - p29.List.AbsolutePosition.Y - 20)));
    p29.List.CanvasSize = ComponentFrame and UDim2.new(0, 0, 0, ComponentFrame.AbsolutePosition.Y + ComponentFrame.AbsoluteSize.Y - p29.Container.AbsolutePosition.Y) or UDim2.new(0, 0, 0, 0);
end;

function u3._UpdateSize(p30) -- Line: 204
    -- upvalues: GuiService (copy)
    p30.PageContainer.Size = UDim2.new(1, 0, 1, -GuiService.TopbarInset.Height);
end;

function u3._Setup(u31) -- Line: 208
    u31.DotsFrame:AddTag("UILoadingDots");
    u31.WaitingFrame.Visible = true;
    u31.Tabs.Frame.Visible = false;
    u31.Pages.Frame.Visible = false;
    u31.BottomTabs.Frame.Visible = false;
    task.delay(0.25, function() -- Line: 216
        -- upvalues: u31 (copy)
        u31.DotsFrame:RemoveTag("UILoadingDots");
        u31.WaitingFrame.Visible = false;
        u31.Tabs.Frame.Visible = true;
        u31.Pages.Frame.Visible = true;
        u31.BottomTabs.Frame.Visible = true;
        u31.Tabs:Setup();
        u31.Pages:Setup();
        u31.BottomTabs:Setup();
        u31:SetPage(u31.CurrentPage or "Home");
        u31._setup_finished = true;
        u31._setup_finished_event_internal:Fire();
    end);
end;

function u3._Init(u32) -- Line: 235
    -- upvalues: Spotlight (copy), UILibrary (copy), GuiService (copy)
    u32.PromptSystem.PromptAdded:Connect(function(p33) -- Line: 236
        -- upvalues: u32 (copy)
        u32.List.CanvasPosition = Vector2.new(0, 0);
        u32:_UpdatePromptContext();

        if p33.InspectCurrencyPage then
            p33.InspectCurrencyPage:Connect(function() -- Line: 241
                -- upvalues: u32 (ref)
                u32:SetPage("Currency");
            end);
        end;
    end);
    u32.PromptSystem.PromptRemoved:Connect(function() -- Line: 247
        -- upvalues: u32 (copy)
        u32:_UpdatePromptContext();
    end);
    u32.OpenChanged:Connect(function() -- Line: 251
        -- upvalues: Spotlight (ref)
        Spotlight:ChangeSubject(nil);
    end);
    u32.CurrentPageChanged:Connect(function() -- Line: 255
        -- upvalues: u32 (copy)
        u32:_CheckScrollDownToLoginRewards();
        u32:_UpdateCanvasSize();
        u32:_UpdateScale();
    end);
    u32.List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 261
        -- upvalues: u32 (copy)
        u32:_UpdateCanvasSize();
    end);
    u32.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 265
        -- upvalues: u32 (copy)
        u32:_UpdateCanvasSize();
    end);
    u32.Container:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 269
        -- upvalues: u32 (copy)
        u32:_UpdateCanvasSize();
    end);
    u32.Pages.UpdateCanvasSize:Connect(function() -- Line: 273
        -- upvalues: u32 (copy)
        u32:_UpdateCanvasSize();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 277
        -- upvalues: u32 (copy)
        u32:_UpdateCanvasSize();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 281
        -- upvalues: u32 (copy)
        u32:_UpdateCanvasSize();
    end);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 285
        -- upvalues: u32 (copy)
        u32:_UpdateSize();
    end);
    u32:_Setup();
    u32:_UpdateSize();
    u32:_UpdateScale();
    u32:_UpdateCanvasSize();
    u32:_UpdatePromptContext();
end;

return u3._new();