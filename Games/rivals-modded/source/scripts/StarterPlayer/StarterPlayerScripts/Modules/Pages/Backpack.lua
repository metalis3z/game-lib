-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local CosmeticSlotEmpty = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlotEmpty");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.SlotsFrame = v3.Container:WaitForChild("Slots");
    v3.SlotsContainer = v3.SlotsFrame:WaitForChild("Container");
    v3.SlotsLayout = v3.SlotsContainer:WaitForChild("Layout");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3._slots = {};
    v3._generation_queued = false;
    v3:_Init();

    return v3;
end;

function u1.Open(p4, ...) -- Line: 43
    -- upvalues: Page (copy)
    Page.Open(p4, ...);
    p4:_Generate();
end;

function u1.Close(p5, ...) -- Line: 48
    -- upvalues: Page (copy)
    Page.Close(p5, ...);
    p5:_Generate();
end;

function u1._Generate(u6) -- Line: 57
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy), Utility (copy), RewardSlot (copy), CosmeticSlotEmpty (copy)
    for _, v in pairs(u6._slots) do
        v:Destroy();
    end;

    u6._slots = {};

    if not u6:IsOpen() then
        return;
    end;

    local v7 = PlayerDataController:Get("UnclaimedRewards");

    if #v7 == 0 then
        u6.Closed:Fire();

        return;
    end;

    local table_clone_ret = table.clone(v7);
    table.sort(table_clone_ret, function(p8, p9) -- Line: 77
        -- upvalues: CosmeticLibrary (ref), Utility (ref)
        local v10 = CosmeticLibrary.Rewards[p8.Name] ~= nil;
        local v11 = CosmeticLibrary.Rewards[p9.Name] ~= nil;

        if v10 ~= v11 then
            return v11;
        end;

        local v12 = not v10 and CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p8.Name].Rarity].Value;
        local v13 = not v11 and CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p9.Name].Rarity].Value;

        if v12 ~= v13 then
            return v13 < v12;
        end;

        local v14 = not v10 and CosmeticLibrary.Types[CosmeticLibrary.Cosmetics[p8.Name].Type].Value;
        local v15 = not v11 and CosmeticLibrary.Types[CosmeticLibrary.Cosmetics[p9.Name].Type].Value;

        if v14 ~= v15 then
            return v15 < v14;
        end;

        local v16 = p8.Quantity or 1;
        local v17 = p9.Quantity or 1;
        local v18;

        if v16 == v17 then
            v18 = nil;
        else
            v18 = v17 < v16;
        end;

        local v19;

        if p8.Name == p9.Name then
            v19 = nil;
        else
            v19 = Utility:StringLessThan(p8.Name, p9.Name);
        end;

        if v10 then
            v10 = CosmeticLibrary.Rewards[p8.Name].Type == "Lootbox";
        end;

        if v11 then
            v11 = CosmeticLibrary.Rewards[p9.Name].Type == "Lootbox";
        end;

        if v10 ~= v11 then
            return v11;
        end;

        if v10 and v11 then
            if v19 ~= nil then
                return v19;
            end;

            if v18 ~= nil then
                return v18;
            end;
        else
            if v18 ~= nil then
                return v18;
            end;

            if v19 ~= nil then
                return v19;
            end;
        end;

        local Weapon = p8.Weapon;
        local Weapon2 = p9.Weapon;

        if Weapon == Weapon2 then
            return false;
        end;

        if Weapon and not Weapon2 then
            return false;
        end;

        return not Weapon and Weapon2 and true or Utility:StringLessThan(p8.Weapon, p9.Weapon);
    end);

    for i, v in pairs(table_clone_ret) do
        local table_find_ret = table.find(v7, v);
        local v20 = CosmeticLibrary.Rewards[v.Name];

        if v20 then
            local _ = v20.Type == "Lootbox";
        end;

        local v21 = RewardSlot.new(v);
        v21.Frame.LayoutOrder = i;
        v21:SetParent(u6.SlotsContainer);
        table.insert(u6._slots, v21);
        v21:OnClick(function() -- Line: 153
            -- upvalues: u6 (copy), table_find_ret (copy)
            u6.PromptSystem:Open("InspectBackpackReward", table_find_ret);
        end);
    end;

    for i = 1, 12 - ((#u6._slots - 1) % 6 + 1) do
        local v22 = CosmeticSlotEmpty:Clone();
        v22.Background.BackgroundTransparency = 0.5;
        v22.LayoutOrder = 9999999;
        v22.Parent = u6.SlotsContainer;
        table.insert(u6._slots, v22);
        local _ = i;
    end;
end;

function u1._QueueGenerate(u23) -- Line: 167
    if u23._generation_queued then
        return;
    end;

    u23._generation_queued = true;
    task.defer(function() -- Line: 174
        -- upvalues: u23 (copy)
        u23._generation_queued = false;
        u23:_Generate();
    end);
end;

function u1._Init(u24) -- Line: 180
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u24.CloseButton.MouseButton1Click:Connect(function() -- Line: 181
        -- upvalues: u24 (copy)
        u24:CloseRequest();
    end);
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 185
        -- upvalues: u24 (copy)
        u24.List.CanvasSize = UDim2.new(0, 0, 0, u24.Layout.AbsoluteContentSize.Y);
        u24.List.Active = u24.Layout.AbsoluteContentSize.Y >= u24.List.AbsoluteSize.Y;
    end);
    u24.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 190
        -- upvalues: u24 (copy)
        u24.SlotsFrame.Size = UDim2.new(1, 0, 0, u24.SlotsLayout.AbsoluteContentSize.Y);
    end);
    u24.PromptSystem.PromptAdded:Connect(function(p25) -- Line: 194
        -- upvalues: u24 (copy)
        if p25.ClosePage then
            p25.ClosePage:Connect(function() -- Line: 196
                -- upvalues: u24 (ref)
                u24.Closed:Fire();
            end);
        end;
    end);
    PlayerDataController:GetDataChangedSignal("UnclaimedRewards"):Connect(function() -- Line: 202
        -- upvalues: u24 (copy)
        u24:_QueueGenerate();
    end);
    u24:_Generate();
    ButtonEffect:Add(u24.CloseButton);
end;

return u1._new();