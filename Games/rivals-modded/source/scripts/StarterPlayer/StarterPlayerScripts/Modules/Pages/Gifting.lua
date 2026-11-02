-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local GiftPlayerEmptySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("GiftPlayerEmptySlot");
local GiftProductSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("GiftProductSlot");
local GiftPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("GiftPlayerSlot");
local u1 = { "None", "Enjoy!", "Thanks!", "Surprise!", "I appreciate you!", "You\'re the best!", "Thanks for everything!", "You played well!", "You owe me!", "Happy birthday!", "Merry Christmas!", "Happy holidays!", "Congratulations!", "Custom" };
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 28
    -- upvalues: Page (copy), u2 (copy), PromptSystem (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.CloseButton = v4.PageFrame:WaitForChild("Close");
    v4.PromptsFrame = v4.PageFrame:WaitForChild("Prompts");
    v4.BackButton = v4.PageFrame:WaitForChild("Back");
    v4.Container = v4.PageFrame:WaitForChild("Container");
    v4.SelectPlayerFrame = v4.Container:WaitForChild("SelectPlayer");
    v4.PlayersList = v4.SelectPlayerFrame:WaitForChild("List");
    v4.PlayersContainer = v4.PlayersList:WaitForChild("Container");
    v4.PlayersLayout = v4.PlayersContainer:WaitForChild("Layout");
    v4.PlayersGiftRewardFrame = v4.PlayersContainer:WaitForChild("GiftReward");
    v4.PlayersGiftRewardProgressBar = v4.PlayersGiftRewardFrame:WaitForChild("Progress"):WaitForChild("Bar");
    v4.PlayersGiftRewardContainer = v4.PlayersGiftRewardFrame:WaitForChild("Container");
    v4.PlayersGiftRewardGoalText = v4.PlayersGiftRewardFrame:WaitForChild("Goal");
    v4.PlayersOfflineGiftFrame = v4.PlayersContainer:WaitForChild("OfflineGift");
    v4.PlayersOfflineGiftBox = v4.PlayersOfflineGiftFrame:WaitForChild("Input"):WaitForChild("Box");
    v4.PlayersOfflineGiftButton = v4.PlayersOfflineGiftFrame:WaitForChild("Button");
    v4.PlayersOfflineGiftButtonOn = v4.PlayersOfflineGiftButton:WaitForChild("On");
    v4.PlayersOfflineGiftButtonOff = v4.PlayersOfflineGiftButton:WaitForChild("Off");
    v4.PlayersOfflineGiftButtonIcon = v4.PlayersOfflineGiftButton:WaitForChild("Icon");
    v4.PlayersOfflineGiftButtonCountdown = v4.PlayersOfflineGiftButton:WaitForChild("Countdown");
    v4.SelectProductFrame = v4.Container:WaitForChild("SelectProduct");
    v4.ProductsEmptyFrame = v4.SelectProductFrame:WaitForChild("Empty");
    v4.ProductsDotsFrame = v4.SelectProductFrame:WaitForChild("Dots");
    v4.ProductsList = v4.SelectProductFrame:WaitForChild("List");
    v4.ProductsContainer = v4.ProductsList:WaitForChild("Container");
    v4.ProductsLayout = v4.ProductsContainer:WaitForChild("Layout");
    v4.ProductsPlayerFrame = v4.ProductsContainer:WaitForChild("Player");
    v4.ProductsPlayerPicture = v4.ProductsPlayerFrame:WaitForChild("Picture");
    v4.ProductsPlayerUsernameText = v4.ProductsPlayerFrame:WaitForChild("Username");
    v4.ProductsPlayerDisplayNameText = v4.ProductsPlayerFrame:WaitForChild("DisplayName");
    v4.ConfirmPurchaseFrame = v4.Container:WaitForChild("ConfirmPurchase");
    v4.ConfirmPurchaseDotsFrame = v4.ConfirmPurchaseFrame:WaitForChild("Dots");
    v4.ConfirmPurchaseList = v4.ConfirmPurchaseFrame:WaitForChild("List");
    v4.ConfirmPurchaseContainer = v4.ConfirmPurchaseList:WaitForChild("Container");
    v4.ConfirmPurchaseLayout = v4.ConfirmPurchaseContainer:WaitForChild("Layout");
    v4.ConfirmPurchasePlayerFrame = v4.ConfirmPurchaseContainer:WaitForChild("Player");
    v4.ConfirmPurchasePlayerPicture = v4.ConfirmPurchasePlayerFrame:WaitForChild("Picture");
    v4.ConfirmPurchasePlayerUsernameText = v4.ConfirmPurchasePlayerFrame:WaitForChild("Username");
    v4.ConfirmPurchasePlayerDisplayNameText = v4.ConfirmPurchasePlayerFrame:WaitForChild("DisplayName");
    v4.ConfirmPurchaseProductFrame = v4.ConfirmPurchaseContainer:WaitForChild("Product");
    v4.ConfirmPurchaseProductIcon = v4.ConfirmPurchaseProductFrame:WaitForChild("Icon");
    v4.ConfirmPurchaseProductTitleText = v4.ConfirmPurchaseProductFrame:WaitForChild("DisplayName");
    v4.ConfirmPurchaseWarningsFrame = v4.ConfirmPurchaseContainer:WaitForChild("Warnings");
    v4.ConfirmPurchaseWarningsGiftTicketsFrame = v4.ConfirmPurchaseWarningsFrame:WaitForChild("GiftTickets");
    v4.ConfirmPurchaseWarningsGiftTicketsText = v4.ConfirmPurchaseWarningsGiftTicketsFrame:WaitForChild("Icon"):WaitForChild("Quantity");
    v4.ConfirmPurchaseWarningsOfflineGiftingFrame = v4.ConfirmPurchaseWarningsFrame:WaitForChild("OfflineGifting");
    v4.ConfirmPurchaseBuyFrame = v4.ConfirmPurchaseContainer:WaitForChild("Buy");
    v4.ConfirmPurchaseBuyButton = v4.ConfirmPurchaseBuyFrame:WaitForChild("Button");
    v4.ConfirmPurchaseBuyButtonGiftTicketIcon = v4.ConfirmPurchaseBuyButton:WaitForChild("GiftTicket");
    v4.ConfirmPurchaseBuyButtonRobuxPrice = v4.ConfirmPurchaseBuyButton:WaitForChild("Robux");
    v4.ConfirmPurchaseSettingsFrame = v4.ConfirmPurchaseContainer:WaitForChild("Settings");
    v4.ConfirmPurchaseSettingsContainer = v4.ConfirmPurchaseSettingsFrame:WaitForChild("Container");
    v4.ConfirmPurchaseSettingsLayout = v4.ConfirmPurchaseSettingsContainer:WaitForChild("Layout");
    v4.ConfirmPurchaseSettingsNoteFrame = v4.ConfirmPurchaseSettingsContainer:WaitForChild("Note");
    v4.ConfirmPurchaseSettingsNoteDropdownFrame = v4.ConfirmPurchaseSettingsNoteFrame:WaitForChild("Dropdown");
    v4.ConfirmPurchaseSettingsNoteDropdownButton = v4.ConfirmPurchaseSettingsNoteDropdownFrame:WaitForChild("Button");
    v4.ConfirmPurchaseSettingsNoteDropdownButtonTitle = v4.ConfirmPurchaseSettingsNoteDropdownButton:WaitForChild("Title");
    v4.ConfirmPurchaseSettingsCustomNoteFrame = v4.ConfirmPurchaseSettingsContainer:WaitForChild("CustomNote");
    v4.ConfirmPurchaseSettingsCustomNoteContainer = v4.ConfirmPurchaseSettingsCustomNoteFrame:WaitForChild("Container");
    v4.ConfirmPurchaseSettingsCustomNoteLockedFrame = v4.ConfirmPurchaseSettingsCustomNoteContainer:WaitForChild("Locked");
    v4.ConfirmPurchaseSettingsCustomNoteUnlockedFrame = v4.ConfirmPurchaseSettingsCustomNoteContainer:WaitForChild("Unlocked");
    v4.ConfirmPurchaseSettingsCustomNoteBox = v4.ConfirmPurchaseSettingsCustomNoteUnlockedFrame:WaitForChild("Box");
    v4.ConfirmPurchaseSettingsCustomNoteCount = v4.ConfirmPurchaseSettingsCustomNoteUnlockedFrame:WaitForChild("Count");
    v4.ConfirmPurchaseSettingsAnonymousFrame = v4.ConfirmPurchaseSettingsContainer:WaitForChild("Anonymous");
    v4.ConfirmPurchaseSettingsAnonymousTitle = v4.ConfirmPurchaseSettingsAnonymousFrame:WaitForChild("Title");
    v4.ConfirmPurchaseSettingsAnonymousButton = v4.ConfirmPurchaseSettingsAnonymousFrame:WaitForChild("Button");
    v4.ConfirmPurchaseSettingsAnonymousEmpty = v4.ConfirmPurchaseSettingsAnonymousButton:WaitForChild("Empty");
    v4.ConfirmPurchaseSettingsAnonymousFilled = v4.ConfirmPurchaseSettingsAnonymousButton:WaitForChild("Filled");
    v4.PromptSystem = PromptSystem.new(v4.PromptsFrame);
    v4._open_animation_disabled = true;
    v4._selected_player_input = nil;
    v4._selected_product_id = nil;
    v4._selected_player_lookup = nil;
    v4._player_slots = {};
    v4._gift_slots = {};
    v4._fetch_player_data_hash = 0;
    v4._generate_hash = 0;
    v4._dont_redirect = nil;
    v4:_Init();

    return v4;
end;

function u2.CloseRequest(p5) -- Line: 120
    -- upvalues: Page (copy)
    if not p5._dont_redirect then
        p5.OpenPage:Fire("Shop", true);

        return;
    end;

    p5._dont_redirect = nil;
    Page.CloseRequest(p5);
end;

function u2.Open(p6, ...) -- Line: 129
    -- upvalues: Page (copy)
    Page.Open(p6, ...);
    p6:SelectPlayer(nil);
    task.spawn(p6._FetchGiftImages, p6);
    task.spawn(p6._GeneratePlayers, p6);
end;

function u2.Close(p7, ...) -- Line: 136
    -- upvalues: Page (copy)
    p7:SelectPlayer(nil);
    p7:_StopNoteDropdown();
    Page.Close(p7, ...);
end;

function u2.DontRedirect(p8) -- Line: 142
    p8._dont_redirect = true;
end;

function u2.SelectPlayer(p9, p10) -- Line: 147
    local v11 = not p10;

    if not v11 then
        if typeof(p10) == "string" then
            v11 = true;
        elseif typeof(p10) == "Instance" then
            v11 = p10:IsA("Player");
        else
            v11 = false;
        end;
    end;

    local v12 = "Argument 1 invalid, expected a Player or string or nil, got " .. tostring(p10);
    assert(v11, v12);
    p9._fetch_player_data_hash = p9._fetch_player_data_hash + 1;
    p9._selected_player_input = p10;
    p9._selected_player_lookup = nil;
    p9:_UpdateFrameVisibility();

    if p9._selected_player_input then
        task.spawn(p9._FetchSelectedPlayerData, p9);
    else
        p9:SelectProduct(nil);
    end;

    task.spawn(p9._GeneratePlayers, p9);
end;

function u2.SelectProduct(p13, p14) -- Line: 165
    local v15 = not p14 or typeof(p14) == "number";
    local v16 = "Argument 1 invalid, expected a number or nil, got " .. tostring(p14);
    assert(v15, v16);
    p13._fetch_player_data_hash = p13._fetch_player_data_hash + 1;
    p13._selected_product_id = p14;
    p13:_UpdateFrameVisibility();
end;

function u2.ConfirmPurchase(p17) -- Line: 174
    -- upvalues: ReplicatedStorage (copy)
    if not (p17._selected_player_input and p17._selected_product_id) then
        return;
    end;

    p17.ConfirmPurchaseList.Visible = false;
    p17.ConfirmPurchaseDotsFrame.Visible = true;
    p17.ConfirmPurchaseDotsFrame:AddTag("UILoadingDots");
    ReplicatedStorage.Remotes.Misc.PromptGiftProductPurchase:InvokeServer(p17._selected_product_id, p17._selected_player_lookup.UserID, p17._selected_player_lookup.IsOfflineGift, p17:_GetGiftNote(), p17.ConfirmPurchaseSettingsAnonymousFilled.Visible);
    p17.ConfirmPurchaseList.Visible = true;
    p17.ConfirmPurchaseDotsFrame.Visible = false;
    p17.ConfirmPurchaseDotsFrame:RemoveTag("UILoadingDots");
    p17:SelectPlayer(nil);
end;

function u2._StopNoteDropdown(p18) -- Line: 202
    if p18._note_dropdown_slot then
        p18._note_dropdown_slot:Cancel();
        p18._note_dropdown_slot = nil;
    end;

    p18.ConfirmPurchaseSettingsNoteDropdownButton.Visible = true;
end;

function u2._StartNoteDropdown(u19) -- Line: 211
    -- upvalues: DropdownSlot (copy), u1 (copy)
    u19:_StopNoteDropdown();
    u19.ConfirmPurchaseSettingsNoteDropdownButton.Visible = false;
    u19._note_dropdown_slot = DropdownSlot.new(u19.ConfirmPurchaseSettingsNoteDropdownFrame, u1);
    u19._note_dropdown_slot.Selected:Connect(function(p20) -- Line: 218
        -- upvalues: u19 (copy)
        if p20 then
            u19.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text = p20;
        end;

        u19:_StopNoteDropdown();
    end);
end;

function u2._GetGiftNote(p21) -- Line: 227
    local Text = p21.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text;

    if Text == "None" then
        return "";
    end;

    if Text == "Custom" then
        return not p21.ConfirmPurchaseSettingsCustomNoteUnlockedFrame.Visible and "" or p21.ConfirmPurchaseSettingsCustomNoteBox.Text;
    end;

    return Text;
end;

function u2._VerifyNote(p22) -- Line: 245
    -- upvalues: MonetizationLibrary (copy)
    p22.ConfirmPurchaseSettingsCustomNoteBox.Text = MonetizationLibrary:SanitizeGiftNote(p22.ConfirmPurchaseSettingsCustomNoteBox.Text) or "";
    p22.ConfirmPurchaseSettingsCustomNoteCount.Text = #p22.ConfirmPurchaseSettingsCustomNoteBox.Text .. " / " .. MonetizationLibrary.MAX_GIFTING_NOTE_CHARACTER_COUNT;
    p22.ConfirmPurchaseSettingsCustomNoteCount.TextColor3 = #p22.ConfirmPurchaseSettingsCustomNoteBox.Text >= MonetizationLibrary.MAX_GIFTING_NOTE_CHARACTER_COUNT and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    p22.ConfirmPurchaseSettingsCustomNoteCount.TextTransparency = #p22.ConfirmPurchaseSettingsCustomNoteBox.Text >= MonetizationLibrary.MAX_GIFTING_NOTE_CHARACTER_COUNT and 0 or 0.5;
end;

function u2._UpdateGiftReward(p23) -- Line: 252
    -- upvalues: PlayerDataController (copy), MonetizationLibrary (copy), Utility (copy)
    local v24 = PlayerDataController:Get("GiftRobuxSpentProgress");
    local GiftRewardRobuxSpentRequirement = MonetizationLibrary:GetGiftRewardRobuxSpentRequirement(PlayerDataController:Get("GiftRobuxSpentRewardsClaimed"));
    p23.PlayersGiftRewardProgressBar.Size = UDim2.new(math.clamp(v24 / GiftRewardRobuxSpentRequirement, 0, 1), 0, 1, 2);
    p23.PlayersGiftRewardGoalText.Text = Utility:PrettyNumber(v24) .. " / " .. Utility:PrettyNumber(GiftRewardRobuxSpentRequirement) .. " points";
end;

function u2._OfflineGiftingCooldown(p25) -- Line: 260
    p25.PlayersOfflineGiftButtonCountdown.Visible = true;
    p25.PlayersOfflineGiftButtonIcon.Visible = false;

    for i = 15, 1, -1 do
        p25.PlayersOfflineGiftButtonCountdown.Text = i;
        wait(1);
        local _ = i;
    end;

    p25.PlayersOfflineGiftButtonCountdown.Visible = false;
    p25.PlayersOfflineGiftButtonIcon.Visible = true;
end;

function u2._UpdateOfflineGiftingButton(p26) -- Line: 273
    -- upvalues: Players (copy), CONSTANTS (copy)
    local PlayersOfflineGiftButtonOn = p26.PlayersOfflineGiftButtonOn;
    local Visible = p26.PlayersOfflineGiftButtonIcon.Visible;

    if Visible then
        if p26.PlayersOfflineGiftBox.Text == "" then
            Visible = false;
        else
            Visible = string.lower(p26.PlayersOfflineGiftBox.Text) ~= string.lower(Players.LocalPlayer.Name) and true or CONSTANTS.IS_STUDIO;
        end;
    end;

    PlayersOfflineGiftButtonOn.Visible = Visible;
    p26.PlayersOfflineGiftButtonOff.Visible = not p26.PlayersOfflineGiftButtonOn.Visible;
end;

function u2._FetchGiftImages(u27) -- Line: 278
    -- upvalues: MonetizationLibrary (copy), MarketplaceService (copy)
    for i, v in pairs(MonetizationLibrary.Gifts) do
        if not v.ImageID then
            task.spawn(function() -- Line: 284
                -- upvalues: MarketplaceService (ref), v (copy), u27 (copy), i (copy)
                local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v.ProductID, Enum.InfoType.Product);

                if v.ImageID then
                    return;
                end;

                if not success then
                    warn("Failed to fetch gamepass info:", result);

                    return;
                end;

                v.ImageID = "rbxassetid://" .. result.IconImageAssetId;
                u27._gift_slots[i].Slot.Icon.Image = v.ImageID;
            end);
        end;
    end;
end;

function u2._FetchSelectedPlayerData(p28) -- Line: 301
    -- upvalues: ReplicatedStorage (copy)
    p28._fetch_player_data_hash = p28._fetch_player_data_hash + 1;
    local _fetch_player_data_hash = p28._fetch_player_data_hash;
    p28.ProductsDotsFrame.Visible = true;
    p28.ProductsDotsFrame:AddTag("UILoadingDots");
    p28.ProductsList.Visible = false;
    p28._selected_player_lookup = nil;
    wait(0.25);

    if p28._fetch_player_data_hash ~= _fetch_player_data_hash then
        return;
    end;

    local v29, v30 = ReplicatedStorage.Remotes.Misc.RequestGiftingDetails:InvokeServer(p28._selected_player_input);

    if p28._fetch_player_data_hash ~= _fetch_player_data_hash then
        return;
    end;

    p28.ProductsDotsFrame:RemoveTag("UILoadingDots");
    p28.ProductsDotsFrame.Visible = false;
    p28.ProductsList.Visible = true;

    if v29 and v30 then
        p28._selected_player_lookup = v30;
    else
        if v30 then
            p28.PromptSystem:Open("ErrorMessage", "Whoops!", v30);
        end;

        p28:SelectPlayer(nil);
    end;

    p28:_UpdateProducts();
end;

function u2._UpdateConfirmPurchasePage(p31) -- Line: 340
    -- upvalues: MonetizationLibrary (copy), PlayerDataController (copy), CONSTANTS (copy), MonetizationController (copy)
    if not (p31._selected_player_input and p31._selected_product_id) then
        return;
    end;

    local v32 = MonetizationLibrary.Gifts[tostring(p31._selected_product_id)];
    local v33 = PlayerDataController:Get("GiftTickets")[tostring(p31._selected_product_id)] or 0;
    local v34 = typeof(p31._selected_player_input) == "string";
    p31.ConfirmPurchasePlayerPicture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p31._selected_player_lookup.UserID);
    p31.ConfirmPurchasePlayerUsernameText.Text = not p31._selected_player_lookup.DisplayName and "" or (p31._selected_player_lookup.DisplayName == p31._selected_player_lookup.Name and "" or "@" .. p31._selected_player_lookup.Name);
    p31.ConfirmPurchasePlayerDisplayNameText.Text = p31._selected_player_lookup.DisplayName or "@" .. p31._selected_player_lookup.Name;
    p31.ConfirmPurchasePlayerDisplayNameText.Position = p31.ConfirmPurchasePlayerUsernameText.Text == "" and UDim2.new(0.15, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.4, 0);
    p31.ConfirmPurchaseProductIcon.Image = v32.ImageID or "";
    p31.ConfirmPurchaseProductTitleText.Text = v32.DisplayName;
    p31.ConfirmPurchaseSettingsAnonymousTitle.Text = "Hide my name from " .. (p31._selected_player_lookup.DisplayName or p31._selected_player_lookup.Name);
    p31.ConfirmPurchaseSettingsCustomNoteLockedFrame.Visible = v34;
    p31.ConfirmPurchaseSettingsCustomNoteUnlockedFrame.Visible = not v34;
    p31.ConfirmPurchaseWarningsGiftTicketsFrame.Visible = v33 > 0;
    p31.ConfirmPurchaseWarningsGiftTicketsText.Text = "×" .. v33;
    p31.ConfirmPurchaseBuyButtonGiftTicketIcon.Visible = v33 > 0;
    p31.ConfirmPurchaseBuyButtonRobuxPrice.Visible = v33 <= 0;
    p31.ConfirmPurchaseWarningsOfflineGiftingFrame.Visible = v34;
    MonetizationController:SetRobuxText(p31.ConfirmPurchaseBuyButtonRobuxPrice, p31._selected_product_id, Enum.InfoType.Product);
end;

function u2._UpdateFrameVisibility(p35) -- Line: 373
    p35.BackButton.Visible = p35._selected_player_input ~= nil;
    p35.SelectPlayerFrame.Visible = not p35._selected_player_input;
    p35.SelectProductFrame.Visible = p35._selected_player_input and not p35._selected_product_id;
    p35.ConfirmPurchaseFrame.Visible = p35._selected_player_input and p35._selected_product_id;
    p35.PlayersList.CanvasPosition = Vector2.new(0, 0);
    p35.ProductsList.CanvasPosition = Vector2.new(0, 0);
    p35.ConfirmPurchaseSettingsAnonymousFilled.Visible = false;
    p35.ConfirmPurchaseSettingsAnonymousEmpty.Visible = true;
    p35.ConfirmPurchaseSettingsCustomNoteBox.Text = "";
    p35.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text = "Surprise!";
    p35:_UpdateProducts();
    p35:_UpdateConfirmPurchasePage();
end;

function u2._UpdateProducts(p36) -- Line: 391
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), MonetizationLibrary (copy), CONSTANTS (copy)
    if not p36._selected_player_input or p36._selected_product_id then
        return;
    end;

    local v37 = PlayerDataController:Get("GiftTickets");

    for i, v in pairs(p36._gift_slots) do
        local v38 = v37[i] or 0;
        v.Slot.Button.GiftTicket.Visible = v38 > 0;
        v.Slot.Button.GiftTicket.Quantity.Text = "×" .. v38;
        local v39 = p36._selected_player_lookup and (p36._selected_player_lookup.CanReceiveGifts and (v.Info.GiftType ~= "Gamepass" or not p36._selected_player_lookup.GamepassesOwned[v.Info.GiftName]));

        if v39 then
            if v.Info.GiftName == "BattlePassLevels10" and p36._selected_player_lookup.CurrentSeasonPassLevel >= SeasonLibrary.CurrentSeason.NumBattlePassTiers or v.Info.GiftName == "primeseason_bundle" and p36._selected_player_lookup.CurrentSeasonMaxPassTrackNum >= MonetizationLibrary.Bundles.primeseason_bundle.BattlePassMaxPassTrackNum then
                v39 = false;
            else
                v39 = v.Info.GiftName ~= "contrabandseason_bundle" and true or not p36._selected_player_lookup.CurrentSeasonSeasonPassBundleOwned;
            end;
        end;

        v.Slot.Visible = v39;
    end;

    p36.ProductsEmptyFrame.Visible = p36._selected_player_lookup and not p36._selected_player_lookup.CanReceiveGifts;
    p36.ProductsPlayerFrame.Visible = not p36.ProductsEmptyFrame.Visible;
    p36.ProductsPlayerPicture.Image = not p36._selected_player_lookup and "" or string.format(CONSTANTS.HEADSHOT_IMAGE, p36._selected_player_lookup.UserID);
    p36.ProductsPlayerUsernameText.Text = not p36._selected_player_lookup and "" or (not p36._selected_player_lookup.DisplayName and "" or (p36._selected_player_lookup.DisplayName == p36._selected_player_lookup.Name and "" or "@" .. p36._selected_player_lookup.Name));
    p36.ProductsPlayerDisplayNameText.Text = not p36._selected_player_lookup and "" or (p36._selected_player_lookup.DisplayName or "@" .. p36._selected_player_lookup.Name);
    p36.ProductsPlayerDisplayNameText.Position = p36.ProductsPlayerUsernameText.Text == "" and UDim2.new(0.15, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.4, 0);
end;

function u2._GeneratePlayers(u40) -- Line: 420
    -- upvalues: Players (copy), Utility (copy), CONSTANTS (copy), GiftPlayerSlot (copy), ButtonEffect (copy), GiftPlayerEmptySlot (copy)
    for _, v in pairs(u40._player_slots) do
        v:Destroy();
    end;

    u40._player_slots = {};
    u40._generate_hash = u40._generate_hash + 1;
    local _generate_hash = u40._generate_hash;
    local Players2 = Players:GetPlayers();
    table.sort(Players2, function(p41, p42) -- Line: 431
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p41.DisplayName, p42.DisplayName);
    end);
    local table_find_ret = table.find(Players2, Players.LocalPlayer);

    if table_find_ret then
        table.remove(Players2, table_find_ret);
    end;

    table.insert(Players2, 1, Players.LocalPlayer);

    for i, v in pairs(Players2) do
        if v ~= Players.LocalPlayer or CONSTANTS.IS_STUDIO then
            local v43 = GiftPlayerSlot:Clone();
            v43.Username.Text = v.DisplayName == v.Name and "" or "@" .. v.Name;
            v43.DisplayName.Text = v.DisplayName;
            v43.DisplayName.Position = v43.Username.Text == "" and UDim2.new(0.175, 0, 0.5, 0) or UDim2.new(0.175, 0, 0.4, 0);
            v43.Icon.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, v.UserId);
            v43.LayoutOrder = i;
            v43.Parent = u40.PlayersContainer;
            ButtonEffect:Add(v43.Button);
            table.insert(u40._player_slots, v43);
            v43.Button.MouseButton1Click:Connect(function() -- Line: 458
                -- upvalues: u40 (copy), v (copy)
                u40:SelectPlayer(v);
            end);

            if _generate_hash ~= u40._generate_hash then
                return;
            end;
        end;
    end;

    for i = #u40._player_slots + 1, 6 do
        local v44 = GiftPlayerEmptySlot:Clone();
        v44.Parent = u40.PlayersContainer;
        table.insert(u40._player_slots, v44);

        if _generate_hash ~= u40._generate_hash then
            return;
        end;

        local _ = i;
    end;

    if typeof(u40._selected_player_input) == "Instance" and u40._selected_player_input.Parent ~= Players then
        u40:SelectPlayer(nil);
    end;
end;

function u2._Setup(u45) -- Line: 486
    -- upvalues: MonetizationLibrary (copy), GiftProductSlot (copy), ButtonEffect (copy), RewardSlot (copy)
    for i, v in pairs(MonetizationLibrary.GiftOrder) do
        local u46 = MonetizationLibrary.Gifts[v];
        local v47 = GiftProductSlot:Clone();
        v47.Icon.Image = "";
        v47.DisplayName.Text = u46.DisplayName;
        v47.LayoutOrder = i;
        v47.Parent = u45.ProductsContainer;
        ButtonEffect:Add(v47.Button);
        v47.Button.MouseButton1Click:Connect(function() -- Line: 497
            -- upvalues: u45 (copy), u46 (copy)
            u45:SelectProduct(u46.ProductID);
        end);
        u45._gift_slots[v] = {
            Slot = v47,
            Info = u46
        };
    end;

    RewardSlot.new({
        Quantity = 1,
        Weapon = "IsRandom",
        Name = MonetizationLibrary.GIFT_REWARD_DATA
    }):SetParent(u45.PlayersGiftRewardContainer);
end;

function u2._Init(u48) -- Line: 510
    -- upvalues: PlayerDataController (copy), MonetizationController (copy), ButtonEffect (copy)
    u48.CloseButton.MouseButton1Click:Connect(function() -- Line: 511
        -- upvalues: u48 (copy)
        u48:CloseRequest();
    end);
    u48.BackButton.MouseButton1Click:Connect(function() -- Line: 515
        -- upvalues: u48 (copy)
        if u48._selected_product_id then
            u48:SelectProduct(nil);

            return;
        end;

        if u48._selected_player_input then
            u48:SelectPlayer(nil);
        end;
    end);
    u48.ConfirmPurchaseBuyButton.MouseButton1Click:Connect(function() -- Line: 523
        -- upvalues: u48 (copy)
        u48:ConfirmPurchase();
    end);
    u48.ConfirmPurchaseSettingsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 527
        -- upvalues: u48 (copy)
        u48.ConfirmPurchaseSettingsFrame.Size = UDim2.new(1, 0, 0, u48.ConfirmPurchaseSettingsLayout.AbsoluteContentSize.Y);
    end);
    u48.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 531
        -- upvalues: u48 (copy)
        u48.PlayersList.CanvasSize = UDim2.new(0, 0, 0, u48.PlayersLayout.AbsoluteContentSize.Y);
    end);
    u48.ProductsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 535
        -- upvalues: u48 (copy)
        u48.ProductsList.CanvasSize = UDim2.new(0, 0, 0, u48.ProductsLayout.AbsoluteContentSize.Y);
    end);
    u48.ConfirmPurchaseLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 539
        -- upvalues: u48 (copy)
        u48.ConfirmPurchaseList.CanvasSize = UDim2.new(0, 0, 0, u48.ConfirmPurchaseLayout.AbsoluteContentSize.Y);
    end);
    u48.ConfirmPurchaseSettingsNoteDropdownButtonTitle:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 543
        -- upvalues: u48 (copy)
        u48.ConfirmPurchaseSettingsCustomNoteFrame.Visible = u48.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text == "Custom";
    end);
    u48.PlayersOfflineGiftBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 547
        -- upvalues: u48 (copy)
        u48:_UpdateOfflineGiftingButton();
    end);
    u48.PlayersOfflineGiftButtonIcon:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 551
        -- upvalues: u48 (copy)
        u48:_UpdateOfflineGiftingButton();
    end);
    u48.PlayersOfflineGiftButton.MouseButton1Click:Connect(function() -- Line: 555
        -- upvalues: u48 (copy)
        if not (u48.PlayersOfflineGiftButtonOn.Visible and u48.PlayersOfflineGiftButtonIcon.Visible) then
            return;
        end;

        local Text = u48.PlayersOfflineGiftBox.Text;
        task.defer(u48._OfflineGiftingCooldown, u48);
        u48.PlayersOfflineGiftBox.Text = "";
        u48:SelectPlayer(Text);
    end);
    u48.ConfirmPurchaseSettingsCustomNoteBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 567
        -- upvalues: u48 (copy)
        u48:_VerifyNote();
    end);
    u48.ConfirmPurchaseSettingsAnonymousButton.MouseButton1Click:Connect(function() -- Line: 571
        -- upvalues: u48 (copy)
        u48.ConfirmPurchaseSettingsAnonymousEmpty.Visible = not u48.ConfirmPurchaseSettingsAnonymousEmpty.Visible;
        u48.ConfirmPurchaseSettingsAnonymousFilled.Visible = not u48.ConfirmPurchaseSettingsAnonymousEmpty.Visible;
    end);
    u48.ConfirmPurchaseSettingsNoteDropdownButton.MouseButton1Click:Connect(function() -- Line: 576
        -- upvalues: u48 (copy)
        u48:_StartNoteDropdown();
    end);
    PlayerDataController:GetDataChangedSignal("GiftTickets"):Connect(function() -- Line: 580
        -- upvalues: u48 (copy)
        u48:_UpdateProducts();
    end);
    PlayerDataController:GetDataChangedSignal("GiftRobuxSpentProgress"):Connect(function() -- Line: 585
        -- upvalues: u48 (copy)
        u48:_UpdateGiftReward();
    end);
    PlayerDataController:GetDataChangedSignal("GiftRobuxSpentRewardsClaimed"):Connect(function() -- Line: 589
        -- upvalues: u48 (copy)
        u48:_UpdateGiftReward();
    end);
    MonetizationController.PurchaseFinished:Connect(function() -- Line: 593
        -- upvalues: u48 (copy)
        u48:SelectPlayer(nil);
    end);
    u48:_Setup();
    u48:SelectPlayer(nil);
    u48:_UpdateGiftReward();
    ButtonEffect:Add(u48.BackButton);
    ButtonEffect:Add(u48.CloseButton);
    ButtonEffect:Add(u48.PlayersOfflineGiftButton);
    ButtonEffect:Add(u48.ConfirmPurchaseSettingsAnonymousButton);
    ButtonEffect:Add(u48.ConfirmPurchaseBuyButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u48.ConfirmPurchaseSettingsNoteDropdownButton, nil, {
        ReleaseRatio = 1.025,
        HoverRatio = 1.025
    });
end;

return u2._new();