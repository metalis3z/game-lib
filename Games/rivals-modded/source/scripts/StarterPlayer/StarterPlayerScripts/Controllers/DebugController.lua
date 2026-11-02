-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MechanicsController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"));
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"));
local OutOfBoundsParts = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("GameComponents"):WaitForChild("OutOfBoundsParts"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local TableViewer = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("TableViewer"));
local DebugState = require(script:WaitForChild("DebugState"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 24
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2._are_hitboxes_visible = false;
    v2._are_map_barriers_visible = false;
    v2._are_map_barriers_visible_changed_internal = Signal.new();
    v2:_Init();

    return v2;
end;

function u1.Command(p3, p4, p5) -- Line: 40
    if p3[p4] then
        p3[p4](p3, p5);

        return;
    end;

    p3:_Command(p4, p5);
end;

function u1.SetHandicapsEnabled(p6, p7) -- Line: 48
    -- upvalues: DebugState (copy)
    DebugState:SetReplicate("AreHandicapsEnabled", p7);
end;

function u1.DisableTransparentHats(p8, p9) -- Line: 52
    -- upvalues: DebugState (copy)
    DebugState:SetReplicate("DisableTransparentHats", p9);
end;

function u1.SpectateNilDuel(p10) -- Line: 56
    -- upvalues: SpectateController (copy)
    SpectateController:SpectateDuelRequest(nil);
end;

function u1.ShowClientEnvironment(p11) -- Line: 60
    -- upvalues: TableViewer (copy), Players (copy)
    TableViewer.new(require(Players.LocalPlayer.PlayerScripts.Client)).ScreenGui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1.GetMatchmakingData(p12) -- Line: 65
    p12:_JSONDump(p12:_Command("GetMatchmakingData", true));
end;

function u1.SetMapBarriersVisible(p13, p14) -- Line: 69
    p13._are_map_barriers_visible = p14;
    p13._are_map_barriers_visible_changed_internal:Fire();
    p13:_SetupMapBarriersLogic();
end;

function u1.SetOOBVisible(p15, p16) -- Line: 75
    -- upvalues: OutOfBoundsParts (copy)
    OutOfBoundsParts:SetVisible(p16);
end;

function u1.DisableDeviceAutoSwitch(p17, p18) -- Line: 79
    -- upvalues: ControlsController (copy)
    ControlsController:DisableVerification(p18);
end;

function u1.SetHitboxesVisible(p19, p20) -- Line: 83
    p19._are_hitboxes_visible = p20;
    p19:_UpdateAllClientFighterCharacterHitboxes();
end;

function u1.InternalViewRewardSlot(p21) -- Line: 88
    -- upvalues: Pages (copy)
    Pages.PageSystem:OpenPage("Debug", true);
    Pages.PageSystem:WaitForPage("Debug").PromptSystem:Open("InternalViewRewardSlot");
end;

function u1.SendOfflineGiftRewards(p22) -- Line: 93
    -- upvalues: PermissionsLibrary (copy), PlayerDataController (copy), Pages (copy)
    if not PermissionsLibrary:IsAdministrator(PlayerDataController:Get("PermissionsRoles")) then
        return;
    end;

    Pages.PageSystem:OpenPage("Debug", true);
    Pages.PageSystem:WaitForPage("Debug").PromptSystem:Open("SendOfflineGiftRewards");
end;

function u1.SendBugRewards(p23) -- Line: 103
    -- upvalues: PermissionsLibrary (copy), PlayerDataController (copy), Pages (copy)
    if not PermissionsLibrary:HasPermission("permission_testing_publiccommands_bugrewards", PlayerDataController:Get("PermissionsRoles")) then
        return;
    end;

    Pages.PageSystem:OpenPage("Debug", true);
    Pages.PageSystem:WaitForPage("Debug").PromptSystem:Open("SendBugRewards");
end;

function u1._SetupMapBarriersLogic(u24) -- Line: 117
    -- upvalues: DuelController (copy)
    if u24._map_barrier_logic_setup then
        return;
    end;

    u24._map_barrier_logic_setup = true;
    DuelController.ObjectAdded:Connect(function(u25) -- Line: 124, Name: duel_added
        -- upvalues: u24 (copy)
        local function update_map() -- Line: 125
            -- upvalues: u25 (copy), u24 (ref)
            if not u25.Map then
                return;
            end;

            for _, descendant in pairs(u25.Map.Model.Barriers:GetDescendants()) do
                if descendant:IsA("BasePart") and not descendant:HasTag("OutOfBoundsPart") then
                    descendant.Transparency = u24._are_map_barriers_visible and 0.5 or 1;
                    descendant.Material = Enum.Material.SmoothPlastic;
                    descendant.Color = descendant:HasTag("KillBrick") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(127, 127, 127);
                    descendant.CastShadow = false;
                end;
            end;
        end;

        u24._are_map_barriers_visible_changed_internal:Connect(update_map);
        u25.MapAdded:Connect(update_map);
        update_map();
    end);

    for _, v in pairs(DuelController.Objects) do
        local function v26() -- Line: 125
            -- upvalues: v (copy), u24 (copy)
            if not v.Map then
                return;
            end;

            for _, descendant in pairs(v.Map.Model.Barriers:GetDescendants()) do
                if descendant:IsA("BasePart") and not descendant:HasTag("OutOfBoundsPart") then
                    descendant.Transparency = u24._are_map_barriers_visible and 0.5 or 1;
                    descendant.Material = Enum.Material.SmoothPlastic;
                    descendant.Color = descendant:HasTag("KillBrick") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(127, 127, 127);
                    descendant.CastShadow = false;
                end;
            end;
        end;

        u24._are_map_barriers_visible_changed_internal:Connect(v26);
        v.MapAdded:Connect(v26);
        v26();
    end;
end;

function u1._JSONDump(p27, ...) -- Line: 152
    -- upvalues: Players (copy), BetterDebris (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Parent = Players.LocalPlayer.PlayerGui;
    BetterDebris:AddItem(ScreenGui, 60);
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.Parent = ScreenGui;
    local v28 = { ... };

    for i, v in pairs(v28) do
        local v29 = i;
        local v30 = v;

        for i2 = 1, math.ceil(#v / 199999) do
            local v31 = (i2 - 1) * 199999;
            local string_sub_ret = string.sub(v30, v31 + 1, v31 + 199999);
            local TextBox = Instance.new("TextBox");
            TextBox.BackgroundColor3 = Color3.fromHSV(v29 / #v28, 0.75, 1);
            TextBox.Size = UDim2.new(0, 200, 0, 200);
            TextBox.ClearTextOnFocus = false;
            TextBox.TextEditable = false;
            TextBox.Text = string_sub_ret;
            TextBox.TextWrapped = true;
            TextBox.Parent = ScreenGui;
            local _ = i2;
        end;
    end;
end;

function u1._Encode(p32, p33) -- Line: 184
    -- upvalues: HttpService (copy)
    local u34 = {};

    local function clone(p35) -- Line: 187
        -- upvalues: u34 (copy), clone (copy)
        local v36 = {};

        for i, v in pairs(p35) do
            if u34[v] then
                v36[i] = "*** cyclic table detected ***";
            elseif typeof(v) == "table" then
                u34[v] = true;
                v36[i] = clone(v);
            else
                v36[i] = v;
            end;
        end;

        return v36;
    end;

    return HttpService:JSONEncode((clone(p33)));
end;

function u1._Command(p37, ...) -- Line: 207
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage.Remotes.Debug.Command:InvokeServer(...);
end;

function u1._UpdateClientFighterCharacterHitboxes(p38, p39) -- Line: 211
    p39:SetHitboxesVisible(p38._are_hitboxes_visible);
end;

function u1._UpdateAllClientFighterCharacterHitboxes(p40) -- Line: 215
    -- upvalues: FighterController (copy)
    for _, v in pairs(FighterController.Objects) do
        if v.Entity then
            p40:_UpdateClientFighterCharacterHitboxes(v.Entity);
        end;
    end;
end;

function u1._SetupHitboxesVisualizer(u41) -- Line: 223
    -- upvalues: FighterController (copy)
    local function client_fighter_added(p42) -- Line: 224
        -- upvalues: u41 (copy)
        p42.EntityAdded:Connect(function(p43) -- Line: 225
            -- upvalues: u41 (ref)
            u41:_UpdateClientFighterCharacterHitboxes(p43);
        end);

        if p42.Entity then
            u41:_UpdateClientFighterCharacterHitboxes(p42.Entity);
        end;
    end;

    FighterController.ObjectAdded:Connect(client_fighter_added);

    for _, v in pairs(FighterController.Objects) do
        task.defer(client_fighter_added, v);
    end;
end;

function u1._Init(p44) -- Line: 241
    task.defer(p44._SetupHitboxesVisualizer, p44);
end;

return u1._new();