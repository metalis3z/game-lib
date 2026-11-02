-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: Prompt (copy), u1 (copy), Signal (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.ClosePage = Signal.new();
    v4.Title = v4.PromptFrame:WaitForChild("Title");
    v4.ExpireText = v4.PromptFrame:WaitForChild("Expire");
    v4.ExpireLeftIcon = v4.ExpireText:WaitForChild("LeftIcon");
    v4.ExpireRightIcon = v4.ExpireText:WaitForChild("RightIcon");
    v4.Container = v4.PromptFrame:WaitForChild("Container");
    v4.CloseButton = v4.PromptFrame:WaitForChild("Close");
    v4.ButtonsFrame = v4.PromptFrame:WaitForChild("Buttons");
    v4.ViewContentsButton = v4.ButtonsFrame:WaitForChild("ViewContents");
    v4.UseButton = v4.ButtonsFrame:WaitForChild("Use");
    v4.Use3Button = v4.ButtonsFrame:WaitForChild("Use3");
    v4.UseMaxButton = v4.ButtonsFrame:WaitForChild("UseMax");
    v4.UseMaxButtonText = v4.UseMaxButton:WaitForChild("Price");
    v4._index = p2;
    v4._reward_data = nil;
    v4._cosmetic_info = nil;
    v4._reward_info = nil;
    v4._reward_slot = nil;
    v4._expire_hash = 0;
    v4._is_using = false;
    v4:_Init();

    return v4;
end;

function u1.Use(p5, p6) -- Line: 53
    -- upvalues: FighterController (copy), ReplicatedStorage (copy), CosmeticLibrary (copy)
    if p5._is_using or (not FighterController.LocalFighter or (FighterController.LocalFighter:Get("IsInDuel") or FighterController.LocalFighter:Get("IsInShootingRange"))) then
        return;
    end;

    p5._is_using = true;
    local v7 = p5._reward_info and p5._reward_info.Type == "Lootbox";

    if ReplicatedStorage.Remotes.Data.UseUnclaimedReward:InvokeServer(p5._index, p6) == "Success" then
        if v7 then
            if p5._reward_info and p5._reward_info.SoundProfile then
                p5.ClosePage:Fire();
            else
                p5:CloseRequest();
            end;
        end;
    elseif v7 then
        p5.OpenPrompt:Fire("ErrorMessage", "Whoops!", "Failed to open, you probably already have everything!");
    elseif p5._cosmetic_info and CosmeticLibrary.Types[p5._cosmetic_info.Type].IsWeaponCosmetic then
        p5.OpenPrompt:Fire(
            "ErrorMessage",
            "Whoops!",
            "Failed to use, this item is probably already unlocked for all possible weapons!"
        );
    else
        p5.OpenPrompt:Fire("ErrorMessage", "Whoops!", "Failed to use, this item is probably already unlocked!");
    end;

    p5._is_using = false;
end;

function u1.Destroy(p8) -- Line: 84
    -- upvalues: Prompt (copy)
    p8:_Clear();
    Prompt.Destroy(p8);
end;

function u1._UpdateTextBounds(p9) -- Line: 93
    p9.ExpireLeftIcon.Position = UDim2.new(0.5, -p9.ExpireText.TextBounds.X / 2, 0.5, 0);
    p9.ExpireRightIcon.Position = UDim2.new(0.5, p9.ExpireText.TextBounds.X / 2, 0.5, 0);
end;

function u1._UpdateExpireText(p10) -- Line: 98
    -- upvalues: ServerOsTime (copy), Utility (copy)
    p10.ExpireText.Text = not p10._reward_data and "" or (not p10._reward_data.ExpireTime and "" or (ServerOsTime:Get() >= p10._reward_data.ExpireTime and "This item has expired" or "Expires in " .. Utility:TimeFormat2(p10._reward_data.ExpireTime - ServerOsTime:GetRounded())));
end;

function u1._Clear(p11) -- Line: 105
    if p11._reward_slot then
        p11._reward_slot:Destroy();
        p11._reward_slot = nil;
    end;

    p11._expire_hash = p11._expire_hash + 1;
end;

function u1._Update(u12) -- Line: 114
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy), CONSTANTS (copy), RewardSlot (copy)
    u12:_Clear();
    u12._reward_data = PlayerDataController:Get("UnclaimedRewards")[u12._index];
    u12._cosmetic_info = u12._reward_data and CosmeticLibrary.Cosmetics[u12._reward_data.Name];
    u12._reward_info = u12._reward_data and CosmeticLibrary.Rewards[u12._reward_data.Name];

    if not u12._reward_data then
        task.defer(u12.CloseRequest, u12);

        return;
    end;

    local v13 = u12._reward_data.Weapon == "IsRandom" and "Random" or (u12._reward_data.Weapon == "IsUniversal" and "Universal" or u12._reward_data.Weapon);
    local v14 = u12._reward_data.Quantity or 1;
    local v15;

    if u12._cosmetic_info and v13 then
        v15 = v13 .. " " .. u12._cosmetic_info.Type;
    elseif u12._cosmetic_info then
        v15 = u12._cosmetic_info.Type;
    else
        v15 = u12._reward_data.Name;
    end;

    u12.Title.Text = v15;
    u12.ExpireText.Visible = u12._reward_data.ExpireTime ~= nil;
    local v16;

    if u12._reward_info and u12._reward_info.Type == "Lootbox" then
        v16 = true;
    else
        v16 = u12._cosmetic_info and CosmeticLibrary.Types[u12._cosmetic_info.Type].IsWeaponCosmetic and u12._reward_data.Weapon == "IsRandom";
    end;

    u12.ViewContentsButton.Visible = v16;
    u12.Use3Button.Visible = u12.ViewContentsButton.Visible and v14 >= 3;
    u12.UseMaxButton.Visible = u12.ViewContentsButton.Visible and v14 > 3;
    u12.UseMaxButtonText.Text = "×" .. math.min(CONSTANTS.MAX_BACKPACK_USE_QUANTITY, v14);
    u12._reward_slot = RewardSlot.new(u12._reward_data);
    u12._reward_slot:SetParent(u12.Container);

    if u12.ExpireText.Visible then
        task.spawn(function() -- Line: 143
            -- upvalues: u12 (copy)
            local v17 = u12;
            v17._expire_hash = v17._expire_hash + 1;

            while not u12._destroyed or u12._expire_hash ~= u12._expire_hash do
                u12:_UpdateExpireText();
                wait(1);
            end;
        end);
    end;
end;

function u1._Init(u18) -- Line: 155
    -- upvalues: CONSTANTS (copy), PlayerDataController (copy), ButtonEffect (copy)
    u18.CloseButton.MouseButton1Click:Connect(function() -- Line: 156
        -- upvalues: u18 (copy)
        u18:CloseRequest();
    end);
    u18.UseButton.MouseButton1Click:Connect(function() -- Line: 160
        -- upvalues: u18 (copy)
        u18:Use(1);
    end);
    u18.Use3Button.MouseButton1Click:Connect(function() -- Line: 164
        -- upvalues: u18 (copy)
        u18:Use(3);
    end);
    u18.UseMaxButton.MouseButton1Click:Connect(function() -- Line: 168
        -- upvalues: u18 (copy), CONSTANTS (ref)
        u18:Use(CONSTANTS.MAX_BACKPACK_USE_QUANTITY);
    end);
    u18.ViewContentsButton.MouseButton1Click:Connect(function() -- Line: 172
        -- upvalues: u18 (copy)
        if u18._reward_data then
            u18.OpenPrompt:Fire("InspectLootbox", u18._reward_data.Name, u18._reward_data.Weapon, "InspectBackpackReward", u18._index);
        end;
    end);
    u18.ExpireText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 178
        -- upvalues: u18 (copy)
        u18:_UpdateTextBounds();
    end);
    local _connections = u18._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("UnclaimedRewards");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 182
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
    u18:_Update();
    u18:_UpdateTextBounds();
    ButtonEffect:Add(u18.UseButton);
    ButtonEffect:Add(u18.Use3Button);
    ButtonEffect:Add(u18.UseMaxButton);
    ButtonEffect:Add(u18.CloseButton);
    ButtonEffect:Add(u18.ViewContentsButton);
end;

return u1;