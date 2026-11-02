-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local LikeBoardGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LikeBoardGui");
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 21
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._BoardAdded(p4, u5) -- Line: 39
    -- upvalues: LikeBoardGui (copy), Utility (copy), RewardSlot (copy), MonetizationLibrary (copy), CosmeticLibrary (copy), ComplianceController (copy), Pages (copy), PlayerDataController (copy), MonetizationController (copy), ButtonEffect (copy), Players (copy)
    local u6 = LikeBoardGui:Clone();
    local u7 = nil;

    local function update() -- Line: 46
        -- upvalues: u7 (ref), u5 (copy), u6 (copy), Utility (ref), RewardSlot (ref)
        if u7 then
            u7:Destroy();
            u7 = nil;
        end;

        local Attribute = u5:GetAttribute("Loaded");
        local v8 = u5:GetAttribute("CurrentLikes") or 0;
        local v9 = u5:GetAttribute("GoalLikes") or 0;
        local v10 = u5:GetAttribute("LastGoalLikes") or 0;
        local v11 = u5:GetAttribute("CurrentMilestone") or 0;
        local v12 = u5:GetAttribute("KeyQuantity") or 0;
        local v13 = u5:GetAttribute("Code") or "";
        local v14 = (v8 - v10) / (v9 - v10);
        u6.MainFrame.Progress.Current.Text = Utility:PrettyNumber(v8);
        u6.MainFrame.Progress.Goal.Text = Utility:PrettyNumber(v9);
        u6.MainFrame.Progress.Bar.Bar.Size = UDim2.new(math.clamp(v14, 0, 1), 0, 1, 0);
        u6.MainFrame.Progress.Percent.Text = math.floor(v14 * 100) .. "%";
        u6.MainFrame.Code.Text = string.upper(v13);
        u6.MainFrame.Description.Visible = v11 > 0;
        u6.MainFrame.Visible = Attribute;
        u6.StarterBundle.Visible = not Attribute;
        u6.Waiting.Visible = false;

        if v11 > 0 then
            u7 = RewardSlot.new({
                Name = "Key",
                Quantity = v12
            });
            u7:SetParent(u6.MainFrame.Reward);
        end;
    end;

    u5:GetAttributeChangedSignal("CurrentLikes"):Connect(update);
    u5:GetAttributeChangedSignal("GoalLikes"):Connect(update);
    u5:GetAttributeChangedSignal("LastGoalLikes"):Connect(update);
    u5:GetAttributeChangedSignal("CurrentMilestone"):Connect(update);
    u5:GetAttributeChangedSignal("KeyQuantity"):Connect(update);
    u5:GetAttributeChangedSignal("Code"):Connect(update);
    update();
    local StarterBundle = u6.StarterBundle;
    local starter_bundle = MonetizationLibrary.Bundles.starter_bundle;

    for i, v in pairs(starter_bundle.Rewards) do
        local v15 = CosmeticLibrary.Rewards[v.Name];

        if not (v15 and (v15.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
            local v16 = RewardSlot.new(v);
            v16.Frame.LayoutOrder = i;
            v16:SetParent(StarterBundle.MainFrame.Rewards);
            v16:OnClick(function() -- Line: 108
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

    local function v18() -- Line: 119
        -- upvalues: PlayerDataController (ref), starter_bundle (copy), StarterBundle (copy)
        local v17 = PlayerDataController:Get("GamepassBundlesClaimed")[starter_bundle.GamepassName];
        StarterBundle.MainFrame.Button.Visible = not v17;
        StarterBundle.MainFrame.Owned.Visible = v17;
    end;

    PlayerDataController:GetDataChangedSignal("GamepassBundlesClaimed"):Connect(v18);
    local v19 = PlayerDataController:Get("GamepassBundlesClaimed")[starter_bundle.GamepassName];
    StarterBundle.MainFrame.Button.Visible = not v19;
    StarterBundle.MainFrame.Owned.Visible = v19;
    StarterBundle.MainFrame.Button.MouseButton1Click:Connect(function() -- Line: 129
        -- upvalues: Pages (ref), MonetizationController (ref), MonetizationLibrary (ref), starter_bundle (copy)
        if Pages.PageSystem.CurrentPage then
            return;
        end;

        MonetizationController:PromptGamePassPurchase(MonetizationLibrary.Gamepasses[starter_bundle.GamepassName].GamepassID);
    end);
    MonetizationController:SetRobuxText(StarterBundle.MainFrame.Button.Title, MonetizationLibrary.Gamepasses[starter_bundle.GamepassName].GamepassID, Enum.InfoType.GamePass);
    ButtonEffect:Add(StarterBundle.MainFrame.Button);
    u6.Adornee = u5;
    u6.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u20) -- Line: 145
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyLikeBoard"):Connect(function(p21) -- Line: 146
        -- upvalues: u20 (copy)
        u20:_BoardAdded(p21);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyLikeBoard")) do
        task.defer(u20._BoardAdded, u20, v);
    end;
end;

return u1._new();