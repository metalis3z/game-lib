-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local u1 = {
    Info = {},
    Order = {}
};

local function add_currency(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14) -- Line: 10
    -- upvalues: u1 (copy)
    local v15 = {
        IsHidden = p2,
        OrderIndex = #u1.Order + 1,
        DataName = p3,
        CanBePurchasedWithRobux = p4,
        OnlyDisplayAboveZeroBalance = p5,
        OnlyDisplayBuyButtonAboveZeroBalance = p6,
        NeedsAreYouSurePrompt = p7,
        DisplayName = p8,
        DisplayNamePlural = p9,
        Image = p10,
        ImageFlat = p11,
        ImageFlatOutline = p12,
        Color = p13 or Color3.fromRGB(255, 255, 255),
        ColorGradient = p14 or ColorSequence.new(Color3.fromRGB(255, 255, 255))
    };
    u1.Info[p3] = v15;
    table.insert(u1.Order, p3);
end;

add_currency(false, "WeaponKeys", true, false, false, false, "Key", "Keys", "rbxassetid://17860673529", "rbxassetid://17495953455", "rbxassetid://17495953350", Color3.fromRGB(255, 255, 255), ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.464, Color3.fromRGB(251, 243, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 192, 21)) }));
add_currency(false, "UnlockTokens", false, true, false, false, "Unlock Token", "Unlock Tokens", "rbxassetid://140345278696055", "rbxassetid://17495953455", "rbxassetid://17495953350", Color3.fromRGB(255, 255, 255));
add_currency(false, "EventCurrency", true, false, false, false, EventLibrary.EVENT_DETAILS.CURRENCY_NAME, EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL, EventLibrary.EVENT_DETAILS.CURRENCY_IMAGE, EventLibrary.EVENT_DETAILS.CURRENCY_IMAGE_FLAT, EventLibrary.EVENT_DETAILS.CURRENCY_IMAGE_FLAT_OUTLINE, EventLibrary.EVENT_DETAILS.CURRENCY_COLOR, EventLibrary.EVENT_DETAILS.CURRENCY_COLOR_GRADIENT);
add_currency(false, "Glory", false, false, false, false, "Glory", "Glory", "rbxassetid://91728915485540", "rbxassetid://99547957275402", "rbxassetid://126219583943163", Color3.fromRGB(204, 92, 255));
add_currency(false, "SkinTickets", false, true, true, true, "Skin Ticket", "Skin Tickets", "rbxassetid://89210639622638", "rbxassetid://77049671345769", "rbxassetid://76853894340797", Color3.fromRGB(255, 255, 255), ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.464, Color3.fromRGB(251, 243, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 192, 21)) }));

return u1;