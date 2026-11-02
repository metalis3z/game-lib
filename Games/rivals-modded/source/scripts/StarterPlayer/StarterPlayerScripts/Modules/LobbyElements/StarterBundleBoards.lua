-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local VideoAdRewards = require(Players.LocalPlayer.PlayerScripts.Modules.VideoAdRewards);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local StarterBundleGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("StarterBundleGui");
Color3.fromRGB(114, 140, 255);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 23
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._boards = {};
    v3:_Init();

    return v3;
end;

function u1._BoardAdded(p4, p5) -- Line: 43
    -- upvalues: StarterBundleGui (copy), VideoAdRewards (copy), MonetizationLibrary (copy), CosmeticLibrary (copy), ComplianceController (copy), RewardSlot (copy), Pages (copy), PlayerDataController (copy), MonetizationController (copy), ButtonEffect (copy), Players (copy)
    local v6 = {
        Gui = StarterBundleGui:Clone(),
        VideoAdRewards = VideoAdRewards.new(),
        Connections = {}
    };
    local StarterBundle = v6.Gui.StarterBundle;
    local starter_bundle = MonetizationLibrary.Bundles.starter_bundle;

    for i, v in pairs(starter_bundle.Rewards) do
        local v7 = CosmeticLibrary.Rewards[v.Name];

        if not (v7 and (v7.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
            local v8 = RewardSlot.new(v);
            v8.Frame.LayoutOrder = i;
            v8:SetParent(StarterBundle.MainFrame.Rewards);
            v8:OnClick(function() -- Line: 65
                -- upvalues: Pages (ref)
                if Pages.PageSystem.CurrentPage then
                    return;
                end;

                Pages.PageSystem:OpenPage("Shop");
                Pages.PageSystem:WaitForPage("Shop"):SetPage("Bundles");
                Pages.PageSystem:WaitForPage("Shop"):InspectBundle("starter_bundle");
            end);
        end;
    end;

    local function update() -- Line: 76
        -- upvalues: PlayerDataController (ref), starter_bundle (copy), StarterBundle (copy)
        local v9 = PlayerDataController:Get("GamepassBundlesClaimed")[starter_bundle.GamepassName];
        StarterBundle.MainFrame.Button.Visible = not v9;
        StarterBundle.MainFrame.Owned.Visible = v9;
    end;

    local Connections = v6.Connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("GamepassBundlesClaimed");
    table.insert(Connections, DataChangedSignal:Connect(update));
    local v10 = PlayerDataController:Get("GamepassBundlesClaimed")[starter_bundle.GamepassName];
    StarterBundle.MainFrame.Button.Visible = not v10;
    StarterBundle.MainFrame.Owned.Visible = v10;
    StarterBundle.MainFrame.Button.MouseButton1Click:Connect(function() -- Line: 86
        -- upvalues: Pages (ref), MonetizationController (ref), MonetizationLibrary (ref), starter_bundle (copy)
        if Pages.PageSystem.CurrentPage then
            return;
        end;

        MonetizationController:PromptGamePassPurchase(MonetizationLibrary.Gamepasses[starter_bundle.GamepassName].GamepassID);
    end);
    MonetizationController:SetRobuxText(StarterBundle.MainFrame.Button.Title, MonetizationLibrary.Gamepasses[starter_bundle.GamepassName].GamepassID, Enum.InfoType.GamePass);
    ButtonEffect:Add(StarterBundle.MainFrame.Button);
    local VideoAdRewards2 = v6.Gui.VideoAdRewards;
    StarterBundle.Visible = true;
    VideoAdRewards2.Visible = false;
    v6.Gui.Adornee = p5;
    v6.Gui.Parent = Players.LocalPlayer.PlayerGui;
    p4._boards[p5] = v6;
end;

function u1._BoardRemoved(p11, p12) -- Line: 130
    local v13 = p11._boards[p12];

    if not v13 then
        return;
    end;

    for _, v in pairs(v13.Connections) do
        v:Disconnect();
    end;

    v13.Gui:Destroy();
    v13.VideoAdRewards:Destroy();
    p11._boards[p12] = nil;
end;

function u1._Init(u14) -- Line: 146
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyStarterBundleBoard"):Connect(function(p15) -- Line: 147
        -- upvalues: u14 (copy)
        u14:_BoardAdded(p15);
    end);
    CollectionService:GetInstanceRemovedSignal("LobbyStarterBundleBoard"):Connect(function(p16) -- Line: 151
        -- upvalues: u14 (copy)
        u14:_BoardRemoved(p16);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyStarterBundleBoard")) do
        task.defer(u14._BoardAdded, u14, v);
    end;
end;

return u1._new();