-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetViewport = require(ReplicatedStorage.Library.Client.AssetViewport);
local OffersV2 = require(ReplicatedStorage.Modded.OffersV2);
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities);
local script_Parent = script.Parent;
local v1 = script_Parent:IsA("GuiObject");
assert(v1, "BestPetDisplays must be parented to monetizationGUI.Toggles");

local function getRankedPetInfo(p2: number) -- Line: 21
    -- upvalues: OffersV2 (copy)
    local OfferInfo = OffersV2.GetOfferInfo(p2);
    local v3 = `Missing offer info for rank {p2}`;
    assert(OfferInfo ~= nil, v3);

    return OfferInfo;
end;

local function createBestPetDisplay(p4: number) -- Line: 27
    -- upvalues: script_Parent (copy), OffersV2 (copy), AssetViewport (copy), Personalities (copy)
    local v5 = script_Parent:WaitForChild(`BestPet{p4}`, 10);
    local v6 = `monetizationGUI.Toggles is missing BestPet{p4}`;
    assert(v5 ~= nil, v6);
    local v7 = v5:IsA("GuiObject");
    local v8 = `BestPet{p4} must be a GuiObject`;
    assert(v7, v8);
    local BestPetDisplay = v5:FindFirstChild("BestPetDisplay");

    if BestPetDisplay ~= nil then
        BestPetDisplay:Destroy();
    end;

    local OfferInfo = OffersV2.GetOfferInfo(p4);
    local v9 = `Missing offer info for rank {p4}`;
    assert(OfferInfo ~= nil, v9);
    local v10 = AssetViewport.Create(v5);
    v10.Name = "BestPetDisplay";
    v10.Position = UDim2.fromScale(0.5, 0.5);
    v10.Size = UDim2.fromScale(1, 1);
    v10.ZIndex = 0;
    local ImageButton = v5.ImageButton;

    for _, v in { ImageButton.HeaderLabel, ImageButton.SubheaderLabel, ImageButton.FooterLabel } do
        v.ZIndex = 4;
    end;

    local v11 = {
        BaseMutation = nil,
        GeneratedMoney = 0,
        IsFavorite = false,
        HasBeenFirstPlaced = true,
        Category = OfferInfo.AssetName,
        Scale = OfferInfo.Scale,
        Mutations = OfferInfo.Mutation == nil and {} or { OfferInfo.Mutation },
        Personality = Personalities.Personalities.Normal
    };
    v5.ImageButton.FooterLabel.Text = OfferInfo.AssetName;
    v5.ImageButton.SubheaderLabel.Text = OfferInfo.Mutation or "";
    AssetViewport.AttachItemDataOnViewport(v11, v10, 1, true);
end;

createBestPetDisplay(1);
createBestPetDisplay(2);
createBestPetDisplay(3);