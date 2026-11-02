-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Signal = require(script.Parent.Signal)
local AvatarAssetTypes = require(script.AvatarAssetTypes)
local AssetAccessoryTypes = require(script.AssetAccessoryTypes)
local Future = require(script.Parent.Future)
local TableUtil = require(script.Parent.TableUtil)

local function Extract(v1, v2) -- line 77
    local function v3(v4, ...)
        table.insert(v4, ...)
    end

    local v5 = {}
    for v6, v7 in pairs(v1) do
        v3(v5, v2(v6, v7))
    end
    return v5
end

local function UnpackInto(v8, v9) -- line 86
    for v10, v11 in ipairs(v9) do
        table.insert(v8, v11)
    end
end

local function New(v12) -- line 92 | captures: MarketplaceService, Signal, AvatarAssetTypes, AssetAccessoryTypes, Future, TableUtil, Extract
    local v13 = {
        Data = {
            Face = 0,
            Accessories = {},
            Emotes = {},
            Scale = {
                BodyType = 0,
                Depth = 0,
                Head = 0,
                Height = 0,
                Proportion = 0,
                Width = 0
            },
            Animations = {
                Walk = 0,
                Run = 0,
                Fall = 0,
                Climb = 0,
                Swim = 0,
                Idle = 0,
                Mood = 0,
                Jump = 0
            },
            BodyParts = {
                Head = 0,
                Torso = 0,
                LeftArm = 0,
                RightArm = 0,
                LeftLeg = 0,
                RightLeg = 0
            },
            BodyPartColors = {
                Head = Color3.fromRGB(0, 0, 0),
                Torso = Color3.fromRGB(0, 0, 0),
                LeftArm = Color3.fromRGB(0, 0, 0),
                RightArm = Color3.fromRGB(0, 0, 0),
                LeftLeg = Color3.fromRGB(0, 0, 0),
                RightLeg = Color3.fromRGB(0, 0, 0)
            },
            Clothing = {
                Shirt = 0,
                TShirt = 0,
                Pants = 0
            }
        },
        HumanoidDescription = Instance.new("HumanoidDescription"),
        Updated = Signal.new()
    }

    function v13.EquipAsset(v14, v15, v16) -- line 142
        if not v14:IsAssetEquipped(v15, v16) then
            v14:SetAssetEquipped(v15, v16, true)
        end
    end

    function v13.UnequipAsset(v17, v18, v19) -- line 148
        if v17:IsAssetEquipped(v18, v19) then
            v17:SetAssetEquipped(v18, v19, false)
        end
    end

    function v13.SetAssetEquipped(v20, v21, v22, v23) -- line 154 | captures: MarketplaceService, AvatarAssetTypes, AssetAccessoryTypes, Future
        local v24 = v20:IsAssetEquipped(v21, v22)
        if table.find(AvatarAssetTypes.Types.Accessories, v22) then
            local v25 = AssetAccessoryTypes[v22]
            if v25 then
                if v23 then
                    if not v24 then
                        v20:AddAccessory({
                            Order = 1,
                            AssetId = v21,
                            AccessoryType = v25
                        })
                    end
                else
                    v20:RemoveAccessory(v21)
                end
            end
        elseif v22 == Enum.AvatarAssetType.Face then
            v20:UpdateData(function(v26) -- line 173 | captures: v21, v23, v24
                local v27
                if v23 then
                    v27 = v24
                else
                    v26.Face = 0
                end
                if not (v23 and v27 or not v23) then
                    v26.Face = v21
                end
                return v26
            end)
        elseif table.find(AvatarAssetTypes.Types.Clothing, v22) then
            v20:UpdateData(function(v28) -- line 185 | captures: v21, v22, v23, v24
                local v29
                if v23 then
                    v29 = v24
                else
                    v28.Clothing[v22.Name] = 0
                end
                if not (v23 and v29 or not v23) then
                    v28.Clothing[v22.Name] = v21
                end
                return v28
            end)
        elseif v22 == Enum.AvatarAssetType.EmoteAnimation then
            local v30, v31 = v20:GetEmoteByAssetId(v21)
            local v32 = v30
            local v33 = v31
            if v30 == nil then
                Future.Try(function() -- line 200 | captures: v32, v33, v20, v21, MarketplaceService
                    local v34 = MarketplaceService:GetProductInfo(v21, Enum.InfoType.Asset)
                    if not v34 then
                        return
                    end
                    v32 = v34.Name
                    v33 = { v34.AssetId }
                    v20:SetEmote(v32, v33)
                end):Await()
            end
            v20:SetEmoteEquipped(v32, not v24)
        elseif table.find(AvatarAssetTypes.Types.Animations, v22) then
            v20:UpdateData(function(v35) -- line 213 | captures: v21, v22, v23, v24
                local v36 = string.gsub(v22.Name, "Animation", "", 1)
                if v35.Animations[v36] then
                    if v23 then
                        if not v24 then
                            v35.Animations[v36] = v21
                            return v35
                        end
                    else
                        v35.Animations[v36] = 0
                    end
                end
                return v35
            end)
        elseif table.find(AvatarAssetTypes.Types.BodyParts, v22) then
            v20:UpdateData(function(v37) -- line 229 | captures: v21, v22, v23, v24
                local Name = v22.Name
                if Name == "DynamicHead" then
                    Name = "Head"
                end
                if v37.BodyParts[Name] then
                    if v23 then
                        if not v24 then
                            v37.BodyParts[Name] = v21
                            return v37
                        end
                    else
                        v37.BodyParts[Name] = 0
                    end
                end
                return v37
            end)
        end
    end

    function v13.IsAssetEquipped(v38, v39, v40) -- line 251 | captures: AvatarAssetTypes
        local v41 = v38:GetData()
        if table.find(AvatarAssetTypes.Types.Accessories, v40) then
            return v38:GetAccessory(v39) ~= nil
        end
        if v40 == Enum.AvatarAssetType.Face then
            return v41.Face == v39
        end
        if table.find(AvatarAssetTypes.Types.Clothing, v40) then
            return v41.Clothing[v40.Name] == v39
        end
        if v40 == Enum.AvatarAssetType.EmoteAnimation then
            return v38:GetEquippedEmote((v38:GetEmoteByAssetId(v39))) ~= nil
        end
        if table.find(AvatarAssetTypes.Types.Animations, v40) then
            local v42 = string.gsub(v40.Name, "Animation", "", 1)
            return v41.Animations[v42] == v39
        end
        if table.find(AvatarAssetTypes.Types.BodyParts, v40) then
            local Name = v40.Name
            if Name == "DynamicHead" then
                Name = "Head"
            end
            return v41.BodyParts[Name] == v39
        end
        return false
    end

    function v13.SetEmoteEquipped(v43, v44, v45, v46) -- line 282
        local v47 = v46
        local v48 = v43:GetData()
        if v46 == nil then
            if v45 then
                local v49 = {}
                table.insert(v49, 1)
                table.insert(v49, 2)
                table.insert(v49, 3)
                table.insert(v49, 4)
                table.insert(v49, 5)
                table.insert(v49, 6)
                table.insert(v49, 7)
                table.insert(v49, 8)
                for v50, v51 in ipairs(v48.EquippedEmotes) do
                    local v52 = table.find(v49, v51.Slot)
                    if v52 then
                        table.remove(v49, v52)
                    end
                end
                v47 = v49[1] or 8
            else
                local v53, v54 = v43:GetEquippedEmote(v44)
                if v54 then
                    v47 = v54.Slot
                else
                    v47 = 8
                end
            end
        end
        v43:UpdateData(function(v55) -- line 311 | captures: v47, v43, v44, v45
            local v56 = v43:GetEquippedEmoteBySlot(v47)
            if v56 then
                table.remove(v55.EquippedEmotes, v56)
            end
            if v45 then
                local EquippedEmotes = v55.EquippedEmotes
                local v57 = {
                    Name = v44,
                    Slot = v47
                }
                table.insert(EquippedEmotes, v57)
            end
            return v55
        end)
    end

    function v13.GetEquippedEmoteBySlot(v58, v59) -- line 329
        local v60 = v58:GetData()
        for v61, v62 in ipairs(v60.EquippedEmotes) do
            if v62.Slot == v59 then
                return v61, v62
            end
        end
        return nil
    end

    function v13.GetEquippedEmote(v63, v64) -- line 341
        local v65 = v63:GetData()
        for v66, v67 in ipairs(v65.EquippedEmotes) do
            if v67.Name == v64 then
                return v66, v67
            end
        end
        return nil
    end

    function v13.SetEmote(v68, v69, v70) -- line 353
        v68:UpdateData(function(v71) -- line 354 | captures: v69, v70
            v71.Emotes[v69] = v70
            return v71
        end)
    end

    function v13.GetEmoteByAssetId(v72, v73) -- line 360
        local v74 = v72:GetData()
        for v75, v76 in pairs(v74.Emotes) do
            if table.find(v76, v73) ~= nil then
                return v75, v76
            end
        end
        return nil
    end

    function v13.GetEmote(v77, v78) -- line 372
        local v79 = v77:GetData()
        for v80, v81 in pairs(v79.Emotes) do
            if v80 == v78 then
                return v81
            end
        end
        return nil
    end

    function v13.ToggleAccessory(v82, v83) -- line 384
        if v82:GetAccessory(v83.AssetId) then
            v82:RemoveAccessory(v83.AssetId)
        else
            v82:AddAccessory(v83)
        end
    end

    function v13.AddAccessory(v84, v85) -- line 392
        if v84:GetAccessory(v85.AssetId) == nil then
            v84:UpdateData(function(v86) -- line 396 | captures: v85
                local Accessories = v86.Accessories
                table.insert(Accessories, v85)
                return v86
            end)
        end
    end

    function v13.RemoveAccessory(v87, v88) -- line 403
        local v89 = v87:GetAccessory(v88)
        if v89 ~= nil then
            v87:UpdateData(function(v90) -- line 407 | captures: v89
                table.remove(v90.Accessories, v89)
                return v90
            end)
        end
    end

    function v13.GetAccessory(v91, v92) -- line 414
        local v93 = v91:GetData()
        for v94, v95 in ipairs(v93.Accessories) do
            if v95.AssetId == v92 then
                return v94, v95
            end
        end
        return nil
    end

    function v13.GetAssets(v96, v97) -- line 426 | captures: Extract
        local v98 = v96:GetData()
        local v99 = { v98.Face }
        local v100 = Extract(v98.Accessories, function(v101, v102) -- line 435
            return v102.AssetId
        end)
        for v103, v104 in ipairs(v100) do
            table.insert(v99, v104)
        end
        local v105 = Extract(v98.Emotes, function(v106, v107) -- line 441
            return table.unpack(v107)
        end)
        for v108, v109 in ipairs(v105) do
            table.insert(v99, v109)
        end
        local v110 = Extract(v98.Clothing, function(v111, v112) -- line 447
            return v112
        end)
        for v113, v114 in ipairs(v110) do
            table.insert(v99, v114)
        end
        if not v97 then
            local v115 = Extract(v98.Animations, function(v116, v117) -- line 455
                return v117
            end)
            for v118, v119 in ipairs(v115) do
                table.insert(v99, v119)
            end
            local v120 = Extract(v98.BodyParts, function(v121, v122) -- line 461
                return v122
            end)
            for v123, v124 in ipairs(v120) do
                table.insert(v99, v124)
            end
        end
        local v125 = {}
        for v126, v127 in ipairs(v99) do
            if v127 == nil or v127 == 0 or table.find(v99, v127, v126 + 1) ~= nil then
                table.insert(v125, v127)
            end
        end
        for v128, v129 in ipairs(v125) do
            local v130 = table.find(v99, v129)
            if v130 ~= nil then
                table.remove(v99, v130)
            end
        end
        return v99
    end

    function v13.ReadFromDescription(v131, v132) -- line 484
        v131.HumanoidDescription = v132
        local v133 = {
            Face = v131.HumanoidDescription.Face,
            Accessories = v131.HumanoidDescription:GetAccessories(true),
            Emotes = v131.HumanoidDescription:GetEmotes(),
            EquippedEmotes = v131.HumanoidDescription:GetEquippedEmotes(),
            Scale = {
                BodyType = v131.HumanoidDescription.BodyTypeScale,
                Depth = v131.HumanoidDescription.DepthScale,
                Head = v131.HumanoidDescription.HeadScale,
                Height = v131.HumanoidDescription.HeightScale,
                Proportion = v131.HumanoidDescription.ProportionScale,
                Width = v131.HumanoidDescription.WidthScale
            },
            BodyParts = {
                Head = v131.HumanoidDescription.Head,
                Torso = v131.HumanoidDescription.Torso,
                LeftLeg = v131.HumanoidDescription.LeftLeg,
                RightLeg = v131.HumanoidDescription.RightLeg,
                LeftArm = v131.HumanoidDescription.LeftArm,
                RightArm = v131.HumanoidDescription.RightArm
            },
            Animations = {
                Idle = v131.HumanoidDescription.IdleAnimation,
                Walk = v131.HumanoidDescription.WalkAnimation,
                Run = v131.HumanoidDescription.RunAnimation,
                Fall = v131.HumanoidDescription.FallAnimation,
                Jump = v131.HumanoidDescription.JumpAnimation,
                Mood = v131.HumanoidDescription.MoodAnimation,
                Swim = v131.HumanoidDescription.SwimAnimation,
                Climb = v131.HumanoidDescription.ClimbAnimation
            },
            Clothing = {
                Shirt = v131.HumanoidDescription.Shirt,
                TShirt = v131.HumanoidDescription.GraphicTShirt,
                Pants = v131.HumanoidDescription.Pants
            },
            BodyPartColors = {
                Head = v131.HumanoidDescription.HeadColor,
                Torso = v131.HumanoidDescription.TorsoColor,
                LeftLeg = v131.HumanoidDescription.LeftLegColor,
                RightLeg = v131.HumanoidDescription.RightLegColor,
                LeftArm = v131.HumanoidDescription.LeftArmColor,
                RightArm = v131.HumanoidDescription.RightArmColor
            }
        }
        v131:UpdateData(function() -- line 533 | captures: v133
            return v133
        end, false)
    end

    function v13._UpdateHumanoidDescription(v134) -- line 538
        local v135 = v134:GetData()
        local v136 = {
            Face = v135.Face,
            BodyTypeScale = v135.Scale.BodyType,
            DepthScale = v135.Scale.Depth,
            HeadScale = v135.Scale.Head,
            HeightScale = v135.Scale.Height,
            ProportionScale = v135.Scale.Proportion,
            WidthScale = v135.Scale.Width,
            WalkAnimation = v135.Animations.Walk,
            RunAnimation = v135.Animations.Run,
            FallAnimation = v135.Animations.Fall,
            ClimbAnimation = v135.Animations.Climb,
            SwimAnimation = v135.Animations.Swim,
            IdleAnimation = v135.Animations.Idle,
            MoodAnimation = v135.Animations.Mood,
            JumpAnimation = v135.Animations.Jump,
            Head = v135.BodyParts.Head,
            Torso = v135.BodyParts.Torso,
            LeftArm = v135.BodyParts.LeftArm,
            RightArm = v135.BodyParts.RightArm,
            LeftLeg = v135.BodyParts.LeftLeg,
            RightLeg = v135.BodyParts.RightLeg,
            HeadColor = v135.BodyPartColors.Head,
            TorsoColor = v135.BodyPartColors.Torso,
            LeftArmColor = v135.BodyPartColors.LeftArm,
            RightArmColor = v135.BodyPartColors.RightArm,
            LeftLegColor = v135.BodyPartColors.LeftLeg,
            RightLegColor = v135.BodyPartColors.RightLeg,
            Shirt = v135.Clothing.Shirt,
            GraphicTShirt = v135.Clothing.TShirt,
            Pants = v135.Clothing.Pants
        }
        for v137, v138 in pairs(v136) do
            if v134.HumanoidDescription[v137] ~= v138 then
                v134.HumanoidDescription[v137] = v138
            end
        end
        v134.HumanoidDescription:SetAccessories(v135.Accessories, true)
        v134.HumanoidDescription:SetEmotes(v135.Emotes)
        v134.HumanoidDescription:SetEquippedEmotes(v135.EquippedEmotes)
    end

    function v13.UpdateData(v139, v140, v141) -- line 589
        local v142 = if v141 == nil then true else v141
        local v143 = v139:GetData()
        local v144 = v140(v139:GetData())
        if v144 == nil then
            assert(false, "Data was not returned.")
        else
            v139.Data = v144
            if v142 then
                v139:_UpdateHumanoidDescription()
            end
            v139.Updated:Fire(v143, v144)
        end
    end

    function v13.GetData(v145) -- line 610 | captures: TableUtil
        return TableUtil.Copy(v145.Data, true)
    end

    function v13.Destroy(v146) -- line 614
        v146.Updated:Destroy()
    end

    v13:ReadFromDescription(v12)
    return v13
end

return New
