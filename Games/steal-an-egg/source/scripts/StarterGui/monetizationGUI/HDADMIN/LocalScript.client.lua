-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Constants = require(ReplicatedStorage.Library.Globals.Constants);
local Gamepasses = require(ReplicatedStorage.Directory.Gamepasses);
local Network = require(ReplicatedStorage.Library.Client.Network);
local script_Parent = script.Parent;
local v1 = script_Parent:IsA("GuiButton");
assert(v1, "monetizationGUI.HDADMIN must be a GuiButton");

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    script_Parent.Position = UDim2.new(0.26, script_Parent.Position.X.Offset, 0.17, script_Parent.Position.Y.Offset);
end;

local Price = script_Parent:FindFirstChild("Price");
local v2;

if Price == nil then
    v2 = false;
else
    v2 = Price:IsA("TextLabel");
end;

assert(v2, "monetizationGUI.HDADMIN.Price must be a TextLabel");
local ProductId = Gamepasses.Directory.OwnerAdmin.ProductId;
task.spawn(function() -- Line: 24
    -- upvalues: MarketplaceService (copy), ProductId (copy), Price (copy), Constants (copy)
    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, ProductId, Enum.InfoType.GamePass);

    if not success or typeof(result) ~= "table" then
        return;
    end;

    Price.Text = not result.IsForSale and "OFF SALE" or `{Constants.ROBUX_ICON_STR}{tostring(result.PriceInRobux)}`;
end);
script_Parent.Activated:Connect(function() -- Line: 40
    -- upvalues: Network (copy), Constants (copy)
    Network.Fire(Constants.NETWORK_MAP.Gamepasses.REQUEST_OWNER_ADMIN_PROMPT);
end);