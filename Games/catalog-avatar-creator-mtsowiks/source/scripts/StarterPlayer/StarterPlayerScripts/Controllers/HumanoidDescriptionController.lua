-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("AvatarEditorService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Modules = require(script.Parent.Parent.Modules);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local Cache = require(Modules.Services.Cache);
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    _onHumanoidDescriptionUpdated = Instance.new("BindableEvent"),
    _onEquippedUpdated = Instance.new("BindableEvent")
};
u1.OnHumanoidDescriptionUpdated = u1._onHumanoidDescriptionUpdated.Event;
u1.OnEquippedUpdated = u1._onEquippedUpdated.Event;
u1.HumanoidDescription = nil;

function u1.EquippedHeadSupportsHeadShapes() -- Line: 35
    -- upvalues: u1 (copy), Cache (copy)
    local HumanoidDescription = u1.HumanoidDescription;

    if HumanoidDescription then
        HumanoidDescription = HumanoidDescription.Head;
    end;

    if not HumanoidDescription or HumanoidDescription == 0 then
        return false;
    end;

    local v2 = Cache.Get("ItemDetails", (tostring(HumanoidDescription)));

    if v2 == nil then
        return nil;
    end;

    if v2.SupportsHeadShapes == true then
        return true;
    end;

    if v2.SupportsHeadShapes == false then
        return false;
    end;

    return nil;
end;

function u1.GetCurrentDescription() -- Line: 50
    -- upvalues: u1 (copy)
    return u1.GetHumanoid():GetAppliedDescription();
end;

function u1.GetHumanoidParentedDescription() -- Line: 55
    -- upvalues: u1 (copy)
    return u1.GetHumanoid():WaitForChild("HumanoidDescription");
end;

function u1.GetHumanoid() -- Line: 61
    -- upvalues: LocalPlayer (copy)
    return (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid");
end;

u1.AccessoryAdjustmentsCache = {};
Remotes:WaitForChild("AccessoryAdjustmentsChanged").OnClientEvent:Connect(function(p3) -- Line: 74
    -- upvalues: u1 (copy)
    u1.AccessoryAdjustmentsCache = typeof(p3) ~= "table" and {} or p3;
end);
task.spawn(function() -- Line: 81
    -- upvalues: Remotes (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 82
        -- upvalues: Remotes (ref)
        return Remotes.AccessoryAdjustmentAction:InvokeServer({
            Action = "GetCurrentAdjustments"
        });
    end);

    if success and typeof(result) == "table" then
        u1.AccessoryAdjustmentsCache = result;
    end;
end);

function u1.GetCurrentAccessoryAdjustments() -- Line: 90
    -- upvalues: u1 (copy)
    return u1.AccessoryAdjustmentsCache;
end;

local function characterAdded(u4) -- Line: 94
    -- upvalues: LocalPlayer (copy), RunService (copy), Remotes (copy), u1 (copy)
    local Humanoid = u4:WaitForChild("Humanoid");

    local function getVerifiedDescription() -- Line: 100
        -- upvalues: u4 (copy), Humanoid (ref), LocalPlayer (ref), RunService (ref), Remotes (ref), u1 (ref)
        local function isHollow(p5) -- Line: 104
            if not p5 then
                return true;
            end;

            local RightLegColor = p5.RightLegColor;
            local Pants = p5.Pants;
            local v6;

            if p5.LeftLegColor == Color3.new(0, 0, 0) and RightLegColor == Color3.new(0, 0, 0) then
                v6 = Pants == 0;
            else
                v6 = false;
            end;

            return v6;
        end;

        local v7 = 0;

        while v7 < 40 do
            local v8 = u4:FindFirstChildOfClass("Humanoid");

            if v8 and v8 ~= Humanoid then
                Humanoid = v8;
            end;

            local v9 = Humanoid:GetAppliedDescription();
            local v10;

            if v9 then
                local RightLegColor = v9.RightLegColor;
                local Pants = v9.Pants;

                if v9.LeftLegColor == Color3.new(0, 0, 0) and RightLegColor == Color3.new(0, 0, 0) then
                    v10 = Pants == 0;
                else
                    v10 = false;
                end;
            else
                v10 = true;
            end;

            if v10 then
                local v11 = Humanoid:FindFirstChildOfClass("HumanoidDescription");

                if v11 then
                    v9 = v11:Clone();
                end;
            end;

            local v12 = u4 == LocalPlayer.Character;
            local v13;

            if v9 then
                local RightLegColor = v9.RightLegColor;
                local Pants = v9.Pants;

                if v9.LeftLegColor == Color3.new(0, 0, 0) and RightLegColor == Color3.new(0, 0, 0) then
                    v13 = Pants == 0;
                else
                    v13 = false;
                end;
            else
                v13 = true;
            end;

            if not v13 and v12 then
                return v9;
            end;

            if not v12 then
                return v9;
            end;

            if v7 > 10 then
                task.wait(0.2);
            else
                RunService.PostSimulation:Wait();
            end;

            v7 = v7 + 1;
            local _ = v7 % 5 == 0;
        end;

        if Remotes.GetHumanoidDescription then
            local success, result = pcall(function() -- Line: 161
                -- upvalues: Remotes (ref)
                return Remotes.GetHumanoidDescription:InvokeServer();
            end);

            if success and result then
                return u1.DeserializeHumanoidDescription(result);
            end;
        end;

        return Humanoid:GetAppliedDescription();
    end;

    Humanoid.ApplyDescriptionFinished:Connect(function() -- Line: 174
        -- upvalues: getVerifiedDescription (copy), u1 (ref)
        task.defer(function() -- Line: 175
            -- upvalues: getVerifiedDescription (ref), u1 (ref)
            local v14 = getVerifiedDescription();
            u1.HumanoidDescription = v14;
            u1._onHumanoidDescriptionUpdated:Fire(v14);
        end);
    end);
    task.spawn(function() -- Line: 182
        -- upvalues: getVerifiedDescription (copy), u1 (ref), Humanoid (ref)
        local v15 = getVerifiedDescription();
        u1.UpdateEquipped(v15);
        task.wait(0.5);
        local v16 = Humanoid:GetAppliedDescription();

        if v16 ~= v15 then
            u1.HumanoidDescription = v16;
            u1._onHumanoidDescriptionUpdated:Fire(v16);
        end;
    end);
end;

function u1.DeserializeHumanoidDescription(u17) -- Line: 198
    -- upvalues: HttpService (copy), CatalogUtilities (copy)
    local success, result = pcall(function() -- Line: 199
        -- upvalues: HttpService (ref), u17 (copy)
        return HttpService:JSONDecode(u17);
    end);

    if not (success and result) then
        warn("Failed to decode HumanoidDescription JSON!");

        return nil;
    end;

    local HumanoidDescription = Instance.new("HumanoidDescription");
    local R15 = Enum.HumanoidRigType.R15;
    local u18 = result.Accessories ~= nil;
    local u19 = {
        HatAccessory = true,
        HairAccessory = true,
        FaceAccessory = true,
        NeckAccessory = true,
        ShouldersAccessory = true,
        WaistAccessory = true,
        BackAccessory = true,
        FrontAccessory = true
    };

    for i, v in result do
        local success2, result2 = pcall(function() -- Line: 234
            -- upvalues: i (copy), v (copy), HumanoidDescription (copy), R15 (ref), u18 (copy), u19 (copy)
            if i == "Emotes" or (i == "EquippedEmotes" or (i == "HeadShape" or (i == "Makeup" or i == "AccessoryAdjustments"))) then
                return;
            end;

            if i == "Accessories" then
                for _, v2 in v do
                    for i2, v3 in v2 do
                        if i2 == "AccessoryType" then
                            v2[i2] = Enum.AccessoryType:FromName(v3);
                        elseif typeof(v3) == "table" and #v3 == 3 then
                            v2[i2] = Vector3.new(v3[1], v3[2], v3[3]);
                        end;
                    end;
                end;

                HumanoidDescription:SetAccessories(v, true);

                return;
            end;

            if i:find("Color") then
                HumanoidDescription[i] = Color3.fromHex(v);

                return;
            end;

            if i == "RigType" then
                R15 = Enum.HumanoidRigType:FromName(v);

                return;
            end;

            if u18 and u19[i] then
                return;
            end;

            HumanoidDescription[i] = v;
        end);

        if not success2 then
            warn(string.format("[HumanoidDescriptionController] Skipping property \'%s\' (value type %s): %s", tostring(i), typeof(v), (tostring(result2))));
        end;
    end;

    if result.Emotes then
        HumanoidDescription:SetEmotes(result.Emotes);
    end;

    if result.EquippedEmotes then
        HumanoidDescription:SetEquippedEmotes(result.EquippedEmotes);
    end;

    if result.HeadShape and (result.HeadShape ~= "" and CatalogUtilities.HeadShapeKeyToAssetId[result.HeadShape]) then
        local v20 = nil;

        for _, child in HumanoidDescription:GetChildren() do
            if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
                v20 = child;
                break;
            end;
        end;

        if not v20 then
            v20 = Instance.new("BodyPartDescription");
            v20.BodyPart = Enum.BodyPart.Head;
            v20.AssetId = HumanoidDescription.Head;
            v20.Parent = HumanoidDescription;
        end;

        v20.HeadShape = result.HeadShape;
    end;

    if result.Makeup then
        for _, v in result.Makeup do
            local MakeupDescription = Instance.new("MakeupDescription");
            MakeupDescription.AssetId = v.AssetId;
            MakeupDescription.MakeupType = Enum.MakeupType[v.MakeupType];
            MakeupDescription.Order = v.Order or 1;
            MakeupDescription.Parent = HumanoidDescription;
        end;
    end;

    local v21;

    if typeof(result.AccessoryAdjustments) == "table" then
        v21 = {};

        for i, v in result.AccessoryAdjustments do
            if typeof(v) == "table" then
                local v22 = {};

                if v.UseColor == true then
                    v22.UseColor = true;
                end;

                if typeof(v.Color) == "string" then
                    local success2, result2 = pcall(Color3.fromHex, v.Color);

                    if success2 then
                        v22.Color = result2;
                    end;
                end;

                if v.Neon == true then
                    v22.Neon = true;
                end;

                if typeof(v.Transparency) == "number" then
                    v22.Transparency = v.Transparency;
                end;

                if typeof(v.Reflectance) == "number" then
                    v22.Reflectance = v.Reflectance;
                end;

                if typeof(v.CustomTextureId) == "string" then
                    v22.CustomTextureId = v.CustomTextureId;
                end;

                if next(v22) then
                    v21[tostring(i)] = v22;
                end;
            end;
        end;
    else
        v21 = nil;
    end;

    return HumanoidDescription, R15, v21;
end;

function u1.GetRigType(u23) -- Line: 328
    -- upvalues: Players (copy), LocalPlayer (copy)
    local success, result = pcall(function() -- Line: 329
        -- upvalues: Players (ref), u23 (copy), LocalPlayer (ref)
        return Players:GetCharacterAppearanceInfoAsync(u23 or LocalPlayer.UserId);
    end);

    if success == false then
        warn("error while getting rigtype:", result);

        return Enum.HumanoidRigType.R15;
    end;

    if result.playerAvatarType then
        return Enum.HumanoidRigType:FromName(result.playerAvatarType);
    end;

    return Enum.HumanoidRigType.R15;
end;

function u1.UpdateHumanoidDescription() -- Line: 341
    -- upvalues: u1 (copy), LocalPlayer (copy)
    if u1.HumanoidDescription == nil then
        u1.HumanoidDescription = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid"):GetAppliedDescription();
    end;

    u1._onHumanoidDescriptionUpdated:Fire(u1.HumanoidDescription);
end;

function u1.UpdateEquipped(u24) -- Line: 352
    -- upvalues: CatalogUtilities (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 353
        -- upvalues: u24 (copy), CatalogUtilities (ref), u1 (ref)
        if u24 == nil then
            return print("description is nil");
        end;

        local v25 = {};

        for _, v in CatalogUtilities.GetEquippedAssetIdsFromDescription(u24, u1.GetHumanoid()) do
            v25[tostring(v.AssetId)] = {
                ItemType = v.ItemType,
                AssetType = v.AssetType
            };
        end;

        v25.Description = u24;
        u1.EquippedDict = v25;
        u1._onEquippedUpdated:Fire(v25);
    end);

    if not success then
        warn("error during updateEquipped:", (tostring(result)));
    end;
end;

u1.OnHumanoidDescriptionUpdated:Connect(u1.UpdateEquipped);

LocalPlayer.CharacterAdded:Connect(characterAdded);

if LocalPlayer.Character then
    task.spawn(characterAdded, LocalPlayer.Character);
end;

return u1;