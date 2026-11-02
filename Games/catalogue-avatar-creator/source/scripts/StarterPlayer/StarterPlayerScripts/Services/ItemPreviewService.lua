-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("InsertService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
require(Modules.Controllers.HumanoidDescriptionController);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local GetEmote = Remotes:WaitForChild("GetEmote");
local GetMovementAnimations = Remotes:WaitForChild("GetMovementAnimations");
local Animate = script:FindFirstChild("Animate");
local LocalPlayer = Players.LocalPlayer;

local function dprint(...) -- Line: 21
end;

local Camera = Instance.new("Camera");
Camera.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
Camera.Focus = CFrame.new(2, 0, 0);
Camera.FieldOfView = 60;
local MovementAnimationToNameMap = CatalogUtilities.MovementAnimationToNameMap;
local viewport = script:WaitForChild("viewport");
local u1 = {
    AnimateModuleTemplate = Animate
};
local HumanoidDescriptionApplicableProperties = CatalogUtilities.HumanoidDescriptionApplicableProperties;
local HumanoidDescriptionAcceptedAssetTypes = CatalogUtilities.HumanoidDescriptionAcceptedAssetTypes;
local LayeredClothingPriorities = CatalogUtilities.LayeredClothingPriorities;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = 0;
local u7 = 0;
local guardedPreviewRigs = setmetatable({}, {
    __mode = "k"
});

local function removeUnsafePreviewDescendant(descendant)
    if descendant:IsA("BaseScript") and descendant.Name ~= "Animate" then
        descendant:Destroy();
    elseif descendant:IsA("Tool") then
        descendant:Destroy();
    end;
end;

local function sanitizePreviewRig(rig)
    if not guardedPreviewRigs[rig] then
        guardedPreviewRigs[rig] = true;
        rig.DescendantAdded:Connect(removeUnsafePreviewDescendant);
    end;

    for _, descendant in rig:GetDescendants() do
        removeUnsafePreviewDescendant(descendant);
    end;
end;

local function updateRig(u8, p9) -- Line: 49
    -- Keep only the newest asynchronous preview generation.
    u7 = u7 + 1;
    local generation = u7;
    local v10 = Players:CreateHumanoidModelFromDescription(u8, p9);

    if generation ~= u7 then
        v10:Destroy();

        return;
    end;

    sanitizePreviewRig(v10);

    if u2 then
        u2:Destroy();
    end;

    if u5 then
        u5:Destroy();
        u5 = nil;
    end;

    u3 = u8;
    u2 = v10;
    u4 = u2:WaitForChild("Humanoid");
    u2:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
    local Animate2 = u2:FindFirstChild("Animate");
    local v11 = Animate:Clone();

    if Animate2 then
        Animate2.Disabled = true;
        Animate2.Name = "_OldAnimate";

        for _, child in Animate2:GetChildren() do
            child.Parent = v11;
        end;
    end;

    v11.Parent = u2;

    if p9 == Enum.HumanoidRigType.R6 then
        u6 = u6 + 1;
        local u12 = u6;
        task.spawn(function() -- Line: 87
            local v13 = Players:CreateHumanoidModelFromDescription(u8, Enum.HumanoidRigType.R15);

            if u6 ~= u12 or generation ~= u7 then
                v13:Destroy();

                return;
            end;

            sanitizePreviewRig(v13);
            v13:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
            u5 = v13;
        end);
    else
        u6 = u6 + 1;
    end;
end;

local function characterAdded(p14) -- Line: 97
    -- upvalues: updateRig (copy)
    local Humanoid = p14:WaitForChild("Humanoid");
    Humanoid.ApplyDescriptionFinished:Connect(function(p15) -- Line: 99
        -- upvalues: updateRig (ref), Humanoid (copy)
        updateRig(p15, Humanoid.RigType);
    end);
    updateRig(Humanoid:GetAppliedDescription(), Humanoid.RigType);
end;

LocalPlayer.CharacterAdded:Connect(characterAdded);

if LocalPlayer.Character then
    characterAdded(LocalPlayer.Character);
end;

local u92 = {
    Hat = function(p16, p17, p18) -- Line: 111, Name: Hat
        local Y = p17:FindFirstChild("Head").Position.Y;
        local v19 = CFrame.new(-3.1, Y + 0.2, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p16.CFrame = v19;
        p16.Focus = v19;
    end,

    FaceAccessory = function(p20, p21, p22) -- Line: 118, Name: FaceAccessory
        local Y = p21:FindFirstChild("Head").Position.Y;
        local v23 = CFrame.new(-2.775, Y, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p20.CFrame = v23;
        p20.Focus = v23;
    end,

    NeckAccessory = function(p24, p25, p26) -- Line: 125, Name: NeckAccessory
        local Y = p25:FindFirstChild("Head").Position.Y;
        local v27 = CFrame.new(-3, Y - 0.5, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p24.CFrame = v27;
        p24.Focus = v27;
    end,

    ShoulderAccessory = function(p28, p29, p30) -- Line: 132, Name: ShoulderAccessory
        local Y = p29:FindFirstChild("Head").Position.Y;
        local v31 = CFrame.new(-4, Y, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p28.CFrame = v31;
        p28.Focus = v31;
    end,

    FrontAccessory = function(p32, p33, p34) -- Line: 139, Name: FrontAccessory
        local v35 = CFrame.new(-4, p34.Position.Y, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p32.CFrame = v35;
        p32.Focus = v35;
    end,

    BackAccessory = function(p36, p37, p38) -- Line: 145, Name: BackAccessory
        local v39 = CFrame.new(4, p38.Position.Y, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
        p36.CFrame = v39;
        p36.Focus = v39;
    end,

    WaistAccessory = function(p40, p41, p42) -- Line: 151, Name: WaistAccessory
        local v43 = CFrame.new(-4.1, p42.Position.Y - 0.75, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(-0.04363323129985824, 0, 0);
        p40.CFrame = v43;
        p40.Focus = v43;
    end,

    EmoteAnimation = function(p44, p45, p46) -- Line: 157, Name: EmoteAnimation
        local v47 = CFrame.new(-7, p46.Position.Y, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p44.CFrame = v47;
        p44.Focus = v47;
    end,

    EntireBody = function(p48, p49, p50) -- Line: 163, Name: EntireBody
        local v51 = CFrame.new(-6, p50.Position.Y, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p48.CFrame = v51;
        p48.Focus = v51;
    end,

    MovementAnimation = function(p52, p53, p54) -- Line: 169, Name: MovementAnimation
        local v55 = CFrame.new(-5, p54.Position.Y + 1.2, 3) * CFrame.Angles(0, -1.0471975511965976, 0) * CFrame.Angles(-0.2617993877991494, 0, 0);
        p52.CFrame = v55;
        p52.Focus = v55;
    end,

    LeftLeg = function(p56, p57, p58) -- Line: 175, Name: LeftLeg
        local v59 = CFrame.new(-2.8, p58.Position.Y - 1, 1.05) * CFrame.Angles(0, -1.361356816555577, 0) * CFrame.Angles(-0.30543261909900765, 0, 0);
        p56.CFrame = v59;
        p56.Focus = v59;
    end,

    RightLeg = function(p60, p61, p62) -- Line: 181, Name: RightLeg
        local v63 = CFrame.new(-2.8, p62.Position.Y - 1, -1.05) * CFrame.Angles(0, -1.7802358370342162, 0) * CFrame.Angles(-0.30543261909900765, 0, 0);
        p60.CFrame = v63;
        p60.Focus = v63;
    end,

    LeftArm = function(p64, p65, p66) -- Line: 187, Name: LeftArm
        local v67 = CFrame.new(-2.8, p66.Position.Y + 0.75, 2) * CFrame.Angles(0, -1.361356816555577, 0) * CFrame.Angles(-0.30543261909900765, 0, 0);
        p64.CFrame = v67;
        p64.Focus = v67;
    end,

    RightArm = function(p68, p69, p70) -- Line: 193, Name: RightArm
        local v71 = CFrame.new(-2.8, p70.Position.Y + 0.75, -2) * CFrame.Angles(0, -1.7802358370342162, 0) * CFrame.Angles(-0.30543261909900765, 0, 0);
        p68.CFrame = v71;
        p68.Focus = v71;
    end,

    Torso = function(p72, p73, p74) -- Line: 199, Name: Torso
        local v75 = CFrame.new(-3.9, p74.Position.Y + 1.2, 0.75) * CFrame.Angles(0, -1.3962634015954636, 0) * CFrame.Angles(-0.24434609527920614, 0, 0);
        p72.CFrame = v75;
        p72.Focus = v75;
    end,

    TShirt = function(p76, p77, p78) -- Line: 205, Name: TShirt
        local v79 = CFrame.new(-3.9, p78.Position.Y + 0.5, 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        p76.CFrame = v79;
        p76.Focus = v79;
    end,

    Shirt = function(p80, p81, p82) -- Line: 211, Name: Shirt
        local Y = p82.Position.Y;
        local UpperTorso = p81:FindFirstChild("UpperTorso");

        if UpperTorso then
            Y = UpperTorso.Position.Y;
        end;

        local v83 = CFrame.new(-4.8, Y + 0.6, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(-0.17453292519943295, 0, 0);
        p80.CFrame = v83;
        p80.Focus = v83;
    end,

    Pants = function(p84, p85, p86) -- Line: 223, Name: Pants
        local Y = p86.Position.Y;
        local LeftUpperLeg = p85:FindFirstChild("LeftUpperLeg");

        if LeftUpperLeg then
            Y = LeftUpperLeg.Position.Y + 1.3;
        end;

        local v87 = CFrame.new(-4.8, Y - 0.4, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(-0.17453292519943295, 0, 0);
        p84.CFrame = v87;
        p84.Focus = v87;
    end,

    Shoes = function(p88, p89, p90) -- Line: 235, Name: Shoes
        local Y = p90.Position.Y;
        local LeftFoot = p89:FindFirstChild("LeftFoot");

        if LeftFoot then
            Y = LeftFoot.Position.Y + 3;
        end;

        local v91 = CFrame.new(-2.8, Y - 1.5, 2) * CFrame.Angles(0, -0.9599310885968813, 0) * CFrame.Angles(-0.17453292519943295, 0, 0);
        p88.CFrame = v91;
        p88.Focus = v91;
    end
};
u92.HairAccessory = u92.Hat;
u92.Face = u92.FaceAccessory;
u92.EyebrowAccessory = u92.FaceAccessory;
u92.EyelashAccessory = u92.FaceAccessory;
u92.FaceMakeup = u92.FaceAccessory;
u92.EyeMakeup = u92.FaceAccessory;
u92.LipMakeup = u92.FaceAccessory;
u92.HeadShape = u92.FaceAccessory;
u92.Head = u92.FaceAccessory;
u92.DynamicHead = u92.FaceAccessory;
u92.MoodAnimation = u92.FaceAccessory;
u92.EyelashAccessory = u92.Shirt;
u92.TShirtAccessory = u92.Shirt;
u92.ShirtAccessory = u92.Shirt;
u92.JacketAccessory = u92.Shirt;
u92.SweaterAccessory = u92.Shirt;
u92.PantsAccessory = u92.Pants;
u92.ShortsAccessory = u92.Pants;
u92.LeftShoeAccessory = u92.Pants;
u92.RightShoeAccessory = u92.Pants;
u92.DressSkirtAccessory = u92.Pants;

local function getCamera(p93, p94) -- Line: 271
    -- upvalues: Camera (copy), u92 (copy)
    local v95 = Camera:Clone();
    local HumanoidRootPart = p93:FindFirstChild("HumanoidRootPart");
    local v96 = u92[p94];

    if v96 then
        v96(v95, p93, HumanoidRootPart.CFrame);
    end;

    return v95;
end;

function u1.GetItemPreview(u97, u98) -- Line: 287
    -- upvalues: Remotes (copy), dprint (copy), Camera (copy), u92 (copy), CatalogUtilities (copy), LayeredClothingPriorities (copy), GetMovementAnimations (copy), MovementAnimationToNameMap (copy), AvatarEditorService (copy), HumanoidDescriptionApplicableProperties (copy), HumanoidDescriptionAcceptedAssetTypes (copy), GetEmote (copy)
    local success, result = pcall(function() -- Line: 288
        -- upvalues: u97 (copy), Remotes (ref), dprint (ref), Camera (ref), u92 (ref), CatalogUtilities (ref), LayeredClothingPriorities (ref), GetMovementAnimations (ref), MovementAnimationToNameMap (ref), u98 (copy), AvatarEditorService (ref), HumanoidDescriptionApplicableProperties (ref), HumanoidDescriptionAcceptedAssetTypes (ref), GetEmote (ref)
        local Rig = u97.Rig;

        if Rig then
            sanitizePreviewRig(Rig);
        end;

        local HumanoidDescription = u97.HumanoidDescription;
        local ItemDetails = u97.ItemDetails;

        if Rig then
            local v99 = Rig:FindFirstChildWhichIsA("Humanoid");

            if HumanoidDescription == nil then
                HumanoidDescription = v99:GetAppliedDescription();
            end;
        end;

        local u100 = {};
        local v101 = HumanoidDescription:Clone();
        local v102 = v101:GetAccessories(true);
        local v103 = true;
        local v104 = ItemDetails.Id or ItemDetails.AssetId;

        if ItemDetails.BundleType == nil then
            local v105 = Enum.AvatarAssetType:FromName(ItemDetails.AssetType);
            local v106;

            if v105 then
                v106 = AvatarEditorService:GetAccessoryType(v105);
            else
                v106 = Enum.AccessoryType.Unknown;
            end;

            if Rig then
                local AssetType = ItemDetails.AssetType;
                local v107 = Camera:Clone();
                local HumanoidRootPart = Rig:FindFirstChild("HumanoidRootPart");
                local v108 = u92[AssetType];

                if v108 then
                    v108(v107, Rig, HumanoidRootPart.CFrame);
                end;

                u100.Camera = v107;
            end;

            if v106 == Enum.AccessoryType.Unknown then
                local v109;

                if v105 then
                    v109 = v105.Name;
                else
                    v109 = ItemDetails.AssetType;
                end;

                local v110 = HumanoidDescriptionApplicableProperties[v109];
                local v111 = string.match(v109, "Animation$") and v109 ~= "MoodAnimation";

                if v110 and not v111 then
                    if Rig then
                        v101[v110] = v104;
                    else
                        u100.Value = v104;
                        u100.Property = v110;
                        u100.ApplyMethod = "property";
                    end;
                else
                    v103 = false;
                    local v112 = HumanoidDescriptionAcceptedAssetTypes[ItemDetails.AssetType] or HumanoidDescriptionAcceptedAssetTypes[v109];

                    if v112 == "EmoteAnimation" then
                        local v113, v114 = GetEmote:InvokeServer(v104);

                        if v113 and v114 then
                            local Animation = Instance.new("Animation");
                            Animation.Name = v114.EmoteName;
                            Animation.AnimationId = v114.EmoteId;

                            if Rig then
                                local Animator = Rig.Humanoid:FindFirstChild("Animator");

                                if Animator then
                                    local v115 = Animator:LoadAnimation(Animation);
                                    v115.Priority = Enum.AnimationPriority.Action;
                                    v115.Looped = true;
                                    v115:Play();

                                    if u98 then
                                        u98(u100);
                                    end;
                                end;
                            else
                                u100.Animation = Animation;
                                u100.ApplyMethod = "emoteAnimation";
                            end;
                        end;
                    elseif string.match(v112, "Animation$") then
                        local v116 = GetMovementAnimations:InvokeServer(v104);

                        if v116 then
                            if Rig then
                                local v117 = Camera:Clone();
                                local HumanoidRootPart = Rig:FindFirstChild("HumanoidRootPart");
                                local MovementAnimation = u92.MovementAnimation;

                                if MovementAnimation then
                                    MovementAnimation(v117, Rig, HumanoidRootPart.CFrame);
                                end;

                                u100.Camera = v117;
                                local Animate2 = require(Rig:FindFirstChild("Animate"));
                                local v118 = MovementAnimationToNameMap[v112];
                                Animate2:SetAnimation(v118, v116);
                                Animate2:PlayAnimation(v118);

                                if u98 then
                                    u98(u100);
                                end;
                            else
                                u100.Animations = v116;
                                u100.AnimationType = v112;
                                u100.ApplyMethod = "movementAnimation";
                            end;
                        else
                            warn("couldnt get movement animations for", v104);
                        end;
                    elseif v112 == "HeadShape" then
                        local v119 = CatalogUtilities.HeadShapeAssetIdToKey[v104];
                        assert(v119 ~= nil, "couldn\'t get head shape key");

                        if Rig then
                            local v120 = nil;
                            v103 = true;

                            for _, child in v101:GetChildren() do
                                if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
                                    v120 = child;
                                    break;
                                end;
                            end;

                            if not v120 then
                                v120 = Instance.new("BodyPartDescription");
                                v120.BodyPart = Enum.BodyPart.Head;
                                v120.AssetId = v101.Head;
                                v120.Parent = v101;
                            end;

                            v120.HeadShape = v119;
                        else
                            u100.HeadShapeKey = v119;
                            u100.ApplyMethod = "headShape";
                        end;
                    elseif CatalogUtilities.MakeupAssetTypeToMakeupType[v112] then
                        local v121 = CatalogUtilities.MakeupAssetTypeToMakeupType[v112];
                        local v122 = Enum.MakeupType[v121];

                        if Rig then
                            local v123 = 0;
                            local v124 = false;

                            for _, child in v101:GetChildren() do
                                if child:IsA("MakeupDescription") then
                                    v124 = child.AssetId == v104 and true or v124;

                                    if child.MakeupType == v122 and v123 < child.Order then
                                        v123 = child.Order;
                                    end;
                                end;
                            end;

                            if v124 then
                                v103 = true;
                            else
                                local MakeupDescription = Instance.new("MakeupDescription");
                                MakeupDescription.AssetId = v104;
                                MakeupDescription.MakeupType = v122;
                                MakeupDescription.Order = v123 + 1;
                                MakeupDescription.Parent = v101;
                                v103 = true;
                            end;
                        else
                            u100.MakeupType = v121;
                            u100.ApplyMethod = "makeup";
                        end;
                    end;
                end;
            else
                local v125 = LayeredClothingPriorities[v106.Name];

                if u97.HideSameType then
                    local sourceAccessories = v102;
                    v102 = {};

                    for _, v in sourceAccessories do
                        if v.AccessoryType ~= v106 then
                            table.insert(v102, v);
                        end;
                    end;
                end;

                v102[#v102 + 1] = {
                    AssetId = ItemDetails.Id or ItemDetails.AssetId,
                    AccessoryType = v106,
                    Order = v125
                };

                if Rig then
                    v101:SetAccessories(v102, true);
                else
                    u100.Accessories = v102;
                    u100.ApplyMethod = "accessories";
                end;
            end;
        else
            local _, v126 = Remotes.GetBundleDetails:InvokeServer(v104);
            dprint("bundledetails:", v126);
            local BundleType = v126.BundleType;

            if BundleType == "DynamicHead" then
                for _, v in v126.Items do
                    if v.AssetTypeName == "Head" then
                        v104 = v.AssetId;
                        break;
                    end;
                end;

                if Rig then
                    v101.Head = v104;
                    local v127 = Camera:Clone();
                    local HumanoidRootPart = Rig:FindFirstChild("HumanoidRootPart");
                    local DynamicHead = u92.DynamicHead;

                    if DynamicHead then
                        DynamicHead(v127, Rig, HumanoidRootPart.CFrame);
                    end;

                    u100.Camera = v127;
                else
                    u100.Value = v104;
                    u100.Property = "Head";
                    u100.ApplyMethod = "property";
                end;
            elseif BundleType == "BodyParts" then
                local v128 = {};
                local v129 = {};

                for _, v in v126.Items do
                    local AssetTypeName = v.AssetTypeName;

                    if CatalogUtilities.BodyParts[AssetTypeName] then
                        v128[AssetTypeName] = v.AssetId;
                    elseif string.match(AssetTypeName, "Accessory$") then
                        table.insert(v129, {
                            AssetId = ItemDetails.Id,
                            AccessoryType = AssetTypeName,
                            Order = LayeredClothingPriorities[AssetTypeName]
                        });
                    end;
                end;

                local v130 = v102 or {};

                for _, v in v129 do
                    v130[#v102 + 1] = v;
                end;

                if Rig then
                    local v131 = Camera:Clone();
                    local HumanoidRootPart = Rig:FindFirstChild("HumanoidRootPart");
                    local EntireBody = u92.EntireBody;

                    if EntireBody then
                        EntireBody(v131, Rig, HumanoidRootPart.CFrame);
                    end;

                    u100.Camera = v131;

                    for i, v in v128 do
                        v101[i] = v;
                    end;
                else
                    u100.Items = {
                        BodyParts = v128,
                        Accessories = v130
                    };
                    u100.ApplyMethod = "bodyParts";
                end;
            elseif BundleType == "AvatarAnimations" then
                local v132 = nil;
                local u133 = nil;
                v103 = false;

                for _, v in v126.Items do
                    local AssetTypeName = v.AssetTypeName;

                    if AssetTypeName == "RunAnimation" then
                        u133 = v.AssetId;
                    elseif AssetTypeName == "IdleAnimation" then
                        v132 = v.AssetId;
                    end;
                end;

                local u134 = {
                    Idle = {
                        Animations = GetMovementAnimations:InvokeServer(v132),
                        AnimationName = MovementAnimationToNameMap.IdleAnimation
                    }
                };
                task.spawn(function() -- Line: 379
                    -- upvalues: u134 (copy), GetMovementAnimations (ref), u133 (ref), MovementAnimationToNameMap (ref)
                    u134.Run = {
                        Animations = GetMovementAnimations:InvokeServer(u133),
                        AnimationName = MovementAnimationToNameMap.RunAnimation
                    };
                end);

                if Rig then
                    local v135 = Camera:Clone();
                    local HumanoidRootPart = Rig:FindFirstChild("HumanoidRootPart");
                    local MovementAnimation = u92.MovementAnimation;

                    if MovementAnimation then
                        MovementAnimation(v135, Rig, HumanoidRootPart.CFrame);
                    end;

                    u100.Camera = v135;
                    local Animate2 = require(Rig:FindFirstChild("Animate"));

                    if u98 then
                        u98(u100);
                    end;

                    while Rig and Rig.Parent ~= nil do
                        for _, v in u134 do
                            Animate2:SetAnimation(v.AnimationName, v.Animations);
                            Animate2:PlayAnimation(v.AnimationName);
                            task.wait(2.5);
                        end;
                    end;
                else
                    u100.Sets = u134;
                    u100.ApplyMethod = "movementAnimationBundle";
                end;
            elseif BundleType == "Shoes" then
                v103 = true;

                for _, v in v126.Items do
                    local v136 = v.AssetTypeName == "LeftShoeAccessory" and "LeftShoe" or "RightShoe";
                    v102[#v102 + 1] = {
                        AssetId = v.AssetId,
                        AccessoryType = Enum.AccessoryType:FromName(v136),
                        Order = LayeredClothingPriorities[v136]
                    };
                end;

                if Rig then
                    local v137 = Camera:Clone();
                    local HumanoidRootPart = Rig:FindFirstChild("HumanoidRootPart");
                    local Shoes = u92.Shoes;

                    if Shoes then
                        Shoes(v137, Rig, HumanoidRootPart.CFrame);
                    end;

                    u100.Camera = v137;
                    v101:SetAccessories(v102, true);
                else
                    u100.Accessories = v102;
                    u100.ApplyMethod = "accessories";
                end;
            end;
        end;

        if Rig then
            if v103 then
                Rig.Humanoid.ApplyDescriptionFinished:Connect(function() -- Line: 588
                    -- upvalues: u98 (ref), u100 (copy)
                    if u98 then
                        u98(u100);
                    end;
                end);
                Rig.Humanoid:ApplyDescriptionReset(v101);

                return u100;
            end;
        elseif u98 then
            u98(u100);
        end;

        return u100;
    end);

    if not (success or result and result:match("DataModel was not available")) then
        dprint("error during itempreview:", result);
    end;

    return success, result;
end;

function u1.ApplyPreviewInfoToRig(u138, u139, u140) -- Line: 614
    -- upvalues: Animate (copy), MovementAnimationToNameMap (copy), dprint (copy)
    local success, result = pcall(function() -- Line: 615
        -- upvalues: u138 (copy), u139 (copy), u140 (copy), Animate (ref), MovementAnimationToNameMap (ref)
        sanitizePreviewRig(u138);
        local v141 = u138:FindFirstChildWhichIsA("Humanoid");
        local v142;

        if v141 then
            v142 = v141:GetAppliedDescription();
        else
            v142 = v141;
        end;

        local v143;

        if v141 then
            v143 = v141:FindFirstChildWhichIsA("Animator");
        else
            v143 = v141;
        end;

        local ApplyMethod = u139.ApplyMethod;
        local v144 = false;

        if ApplyMethod == "accessories" then
            if v142 then
                v142:SetAccessories(u139.Accessories, true);
                v144 = true;
            end;
        elseif ApplyMethod == "property" then
            v142[u139.Property] = u139.Value;
            v144 = true;
        elseif ApplyMethod == "emoteAnimation" then
            local Animation = u139.Animation;

            if v143 then
                local v145 = v143:LoadAnimation(Animation);
                v145.Priority = Enum.AnimationPriority.Action;
                v145.Looped = true;
                v145:Play();

                if u140 then
                    u140();
                end;
            end;
        elseif ApplyMethod == "movementAnimation" then
            local Animations = u139.Animations;
            local Animate2 = u138:FindFirstChild("Animate");

            if Animate2 then
                local v146 = Animate:Clone();

                for _, child in Animate2:GetChildren() do
                    child.Parent = v146;
                end;

                v146.Parent = u138;
                Animate2:Destroy();
                local Animate3 = require(u138:FindFirstChild("Animate"));
                local v147 = MovementAnimationToNameMap[u139.AnimationType];
                Animate3:SetAnimation(v147, Animations);
                Animate3:PlayAnimation(v147);

                if u140 then
                    u140(u139);
                end;
            end;
        elseif ApplyMethod == "movementAnimationBundle" then
            local Animate2 = u138:FindFirstChild("Animate");

            if Animate2 then
                local v148 = Animate:Clone();

                for _, child in Animate2:GetChildren() do
                    child.Parent = v148;
                end;

                v148.Parent = u138;
                Animate2:Destroy();
                local v149 = u138:FindFirstChildWhichIsA("Humanoid").Animator:GetPlayingAnimationTracks();

                if v149 then
                    for _, v in v149 do
                        v:Stop();
                    end;
                end;
            end;

            local Animate3 = require(u138:FindFirstChild("Animate"));
            local Sets = u139.Sets;

            if u140 then
                u140(u139);
            end;

            task.spawn(function() -- Line: 685
                -- upvalues: u138 (ref), Sets (copy), Animate3 (copy)
                while u138 and u138.Parent ~= nil do
                    for _, v in Sets do
                        Animate3:SetAnimation(v.AnimationName, v.Animations);
                        Animate3:PlayAnimation(v.AnimationName);
                        task.wait(2.5);
                    end;
                end;
            end);
        elseif ApplyMethod == "bodyParts" then
            local Items = u139.Items;
            v142:SetAccessories(Items.Accessories, true);
            v144 = true;

            for i, v in Items.BodyParts do
                v142[i] = v;
            end;
        elseif ApplyMethod == "headShape" then
            local v150 = nil;

            for _, child in v142:GetChildren() do
                if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
                    v150 = child;
                    break;
                end;
            end;

            if not v150 then
                v150 = Instance.new("BodyPartDescription");
                v150.BodyPart = Enum.BodyPart.Head;
                v150.AssetId = v142.Head;
                v150.Parent = v142;
            end;

            v150.HeadShape = u139.HeadShapeKey;
            v144 = true;
        end;

        if v144 then
            if u140 then
                v141.ApplyDescriptionFinished:Connect(u140);
            end;

            v141:ApplyDescriptionResetAsync(v142);
        end;
    end);

    if not success then
        dprint("error during applyitempreview:", result);
    end;
end;

function u1.AddPreview(u151, u152, u153, u154) -- Line: 734
    -- upvalues: u4 (ref), u5 (ref), u2 (ref), viewport (copy), Camera (copy), u92 (copy), TweenService (copy), u1 (copy), u3 (ref), dprint (copy)
    local success, result = pcall(function() -- Line: 735
        -- upvalues: u152 (copy), u4 (ref), u5 (ref), u2 (ref), viewport (ref), u151 (copy), Camera (ref), u92 (ref), TweenService (ref), u153 (copy), u1 (ref), u3 (ref), u154 (copy)
        local v155;

        if u152.AssetType == "EmoteAnimation" then
            v155 = u4 and u4.RigType == Enum.HumanoidRigType.R6;
        else
            v155 = false;
        end;

        local v156;

        if v155 and u5 then
            v156 = u5:Clone();
        else
            v156 = u2:Clone();
        end;

        local u157 = viewport:Clone();
        v156.Parent = u157.WorldModel;
        local viewport2 = u151:FindFirstChild("viewport");

        if viewport2 then
            viewport2:Destroy();
        end;

        u157.Parent = u151;

        if u152.AssetType ~= "AvatarBackground" then
            local GetItemPreview = u1.GetItemPreview;
            local v158 = {
                Rig = v156,
                HumanoidDescription = u3,
                ItemDetails = u152
            };
            v158.HideSameType = u154 and u154.HideSameType;
            local _, _ = GetItemPreview(v158, function(p159) -- Line: 771
                -- upvalues: TweenService (ref), u157 (copy), u153 (ref)
                TweenService:Create(u157, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ImageTransparency = 0
                }):Play();
                u157.CurrentCamera = p159.Camera;

                if u153 then
                    u153:Play();
                end;
            end);

            return;
        end;

        u157.ZIndex = 2;
        local v160 = Camera:Clone();
        local HumanoidRootPart = v156:FindFirstChild("HumanoidRootPart");
        local EntireBody = u92.EntireBody;

        if EntireBody then
            EntireBody(v160, v156, HumanoidRootPart.CFrame);
        end;

        u157.CurrentCamera = v160;
        TweenService:Create(u157, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0
        }):Play();

        if u153 then
            u153:Play();
        end;
    end);

    if not success then
        dprint("error during AddPreview:", result);
    end;
end;

function u1.Cleanup(p161) -- Line: 785
    for _, child in p161:GetChildren() do
        if child:IsA("ViewportFrame") then
            child:Destroy();
        end;
    end;
end;

return u1;