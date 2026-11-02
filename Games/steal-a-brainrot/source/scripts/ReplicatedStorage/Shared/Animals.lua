
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local _ = require(l_Packages_0.Trove);
local v4 = require(l_Packages_0.Observers);
local v5 = require(l_Packages_0.FFlags);
local v6 = require(l_Packages_0.Trove);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v8 = require(l_Datas_0.Animals);
local v9 = require(l_Datas_0.Game);
local _ = require(l_Datas_0.Rebirth);
local v11 = require(l_Datas_0.Rarities);
local v12 = require(l_Datas_0.Mutations);
local v13 = require(l_Datas_0.Traits);
local v14 = require(l_ReplicatedStorage_0.Shared.GetAnimalBoundingBox);
local l_Animals_0 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local l_MutationSurfaces_0 = l_ReplicatedStorage_0:WaitForChild("MutationSurfaces");
local l_Models_0 = l_ReplicatedStorage_0:WaitForChild("Models");
local l_Animals_1 = l_Models_0.Animals;
local l_Traits_0 = l_Models_0.Traits;
local l_Traits_1 = l_ReplicatedStorage_0:WaitForChild("Vfx").Traits;
local l_Vfx_0 = l_ReplicatedStorage_0:WaitForChild("Vfx");
local v22 = {};
local l_Unit_0 = Vector3.new(-1, 0.25, -1, 0).Unit;
local function v36(v24, v25, v26, v27, v28, v29) --[[ Line: 43 ]] --[[ Name: FitCam ]]
    -- upvalues: v14 (copy), v22 (copy), l_Unit_0 (copy)
    v29 = v29 or 0.5;
    local _, v31 = v14(v25, v26);
    local l_v22_Zoom_0 = v22:GetZoom(v25, v28);
    local v33 = nil;
    v33 = if not (v25 ~= "Tacorita Bicicleta" and v25 ~= "W or L" and v25 ~= "25" and v25 ~= "Cocoa Assassino" and v25 ~= "Los Jolly Combinasionas") or v25 == "Bunny Bunny Bunny Sahur" then v26:GetPivot() + Vector3.new(0, v31.Y * 0.5, 0) else if v25 == "Boppin Bunny" then v26:GetPivot() + Vector3.new(0, v31.Y * 0.65, 0) else v26.PrimaryPart and v26.PrimaryPart.CFrame or v26:GetPivot();
    local v34 = math.max(v31.X, v31.Y, v31.Z);
    local v35 = v34 * 0.5 / math.tan((math.rad(v27 * 0.5))) * l_v22_Zoom_0;
    v24.CFrame = CFrame.new((v33 * CFrame.new(l_Unit_0 * (v35 + v34 * v29))).Position, v33.Position);
end;
local function v39(v37) --[[ Line: 68 ]] --[[ Name: IsSurfaceEye ]]
    local v38 = v37.Size.X * v37.Size.Y * v37.Size.Z;
    if v37.Color ~= Color3.fromRGB(255, 255, 255) and v37.Color ~= Color3.fromRGB(163, 162, 165) then
        return true;
    elseif v38 > 3 then
        return false;
    else
        return true;
    end;
end;
v22.GetZoom = function(_, v41, v42) --[[ Line: 82 ]] --[[ Name: GetZoom ]]
    v42 = v42 or 0.8;
    assert(v42);
    if v41 == "Tacorita Bicicleta" then
        return v42 + 0.2;
    elseif v41 == "25" then
        return v42 - 0.6;
    elseif v41 == "Los Jolly Combinasionas" then
        return v42 - 0.4;
    elseif v41 == "Money Money Reindeer" then
        return v42 + 0.2;
    else
        if v41 == "Boppin Bunny" then
            v42 = v42 + 0.7;
        end;
        return v42;
    end;
end;
v22.GetBoundingBox = function(_, v44, v45) --[[ Line: 103 ]] --[[ Name: GetBoundingBox ]]
    -- upvalues: v14 (copy)
    return v14(v44, v45);
end;
v22.GetSellValue = function(_, v47) --[[ Line: 107 ]] --[[ Name: GetSellValue ]]
    -- upvalues: v22 (copy), v9 (copy)
    return (math.ceil(v22:GetPrice(v47) * v9.Animal.SellModifier));
end;
local function v54(v48) --[[ Line: 111 ]] --[[ Name: GetBiggestInstance ]]
    local v49 = 0;
    local v50 = nil;
    for _, v52 in (v48:QueryDescendants("BasePart:not([Transparency=1])")) do
        local v53 = v52.Size.X * v52.Size.Y * v52.Size.Z;
        if v49 < v53 then
            v49 = v53;
            v50 = v52;
        end;
    end;
    return v50;
end;
local function _(v55, v56) --[[ Line: 126 ]] --[[ Name: ShouldIgnoreColor ]]
    local l_v55_Attribute_0 = v55:GetAttribute((("%*IgnoreColor"):format(v56)));
    if l_v55_Attribute_0 == false then
        return false;
    else
        return v55:GetAttribute("IgnoreColor") or l_v55_Attribute_0;
    end;
end;
v22.ApplyMutation = function(_, v60, v61, v62, v63) --[[ Line: 136 ]] --[[ Name: ApplyMutation ]]
    -- upvalues: v6 (copy), v12 (copy), l_MutationSurfaces_0 (copy), l_ReplicatedStorage_0 (copy), v54 (copy), v39 (copy), l_Vfx_0 (copy)
    local v64 = v6.new();
    if v63 then
        v64:Add(v60.Destroying:Connect(function() --[[ Line: 139 ]]
            -- upvalues: v64 (copy)
            v64:Destroy();
        end));
    else
        v64:Add(v60.AncestryChanged:Connect(function(_, v66) --[[ Line: 143 ]]
            -- upvalues: v64 (copy)
            if v66 then
                return;
            else
                v64:Destroy();
                return;
            end;
        end));
    end;
    local v67 = v12[v62];
    local l_l_MutationSurfaces_0_FirstChild_0 = l_MutationSurfaces_0:FindFirstChild(v61);
    local v69 = tonumber(v60:GetAttribute((("%*Palette"):format(v62))) or v60:GetAttribute("Palette") or 1) or 1;
    if not v67 or not v67.Palettes[v69] then
        v69 = 1;
    end;
    local v70 = {};
    if v62 == "Rainbow" then
        v64:Add(function() --[[ Line: 162 ]]
            -- upvalues: v60 (copy)
            v60:RemoveTag("RainbowModel");
        end);
        for _, v72 in v60:GetDescendants() do
            if v72:IsA("BasePart") and not v72:GetAttribute("IgnoreRainbowColor") then
                local l_SurfaceAppearance_0 = v72:FindFirstChildOfClass("SurfaceAppearance");
                if l_SurfaceAppearance_0 then
                    v64:Add(function() --[[ Line: 173 ]]
                        -- upvalues: v72 (copy), l_SurfaceAppearance_0 (copy)
                        local l_SurfaceAppearance_1 = v72:FindFirstChildOfClass("SurfaceAppearance");
                        if l_SurfaceAppearance_1 then
                            l_SurfaceAppearance_1:Destroy();
                        end;
                        l_SurfaceAppearance_0:Clone().Parent = v72;
                    end);
                else
                    local l_Color_0 = v72.Color;
                    v64:Add(function() --[[ Line: 183 ]]
                        -- upvalues: v72 (copy), l_Color_0 (copy)
                        v72.Color = l_Color_0;
                    end);
                    local l_MaterialVariant_0 = v72.MaterialVariant;
                    if l_MaterialVariant_0 == "Strawberry Stud Light" or l_MaterialVariant_0 == "Strawberry Stud Dark" then
                        v72.MaterialVariant = "";
                        v64:Add(function() --[[ Line: 190 ]]
                            -- upvalues: v72 (copy), l_MaterialVariant_0 (copy)
                            v72.MaterialVariant = l_MaterialVariant_0;
                        end);
                    end;
                end;
            end;
        end;
        v60:AddTag("RainbowModel");
    else
        for _, v78 in v60:GetDescendants() do
            if v78:IsA("BasePart") then
                local l_v78_Attribute_0 = v78:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v78_Attribute_0 ~= false and (v78:GetAttribute("IgnoreColor") or l_v78_Attribute_0)) then
                    local v80 = v67.Palettes[v69];
                    l_v78_Attribute_0 = v67.Palettes[v69];
                    local v81 = tonumber(v78:GetAttribute((("%*Color"):format(v62))) or v78:GetAttribute("Color") or 1) or 1;
                    local v82 = l_v78_Attribute_0[v81] or v80[v81] or l_v78_Attribute_0[math.clamp(v81, 1, #l_v78_Attribute_0)];
                    if v78:GetAttribute("Neon") then
                        local l_Material_0 = v78.Material;
                        v78.Material = Enum.Material.Neon;
                        local l_l_Material_0_0 = l_Material_0 --[[ copy: 19 -> 23 ]];
                        v64:Add(function() --[[ Line: 213 ]]
                            -- upvalues: v78 (copy), l_l_Material_0_0 (copy)
                            v78.Material = l_l_Material_0_0;
                        end);
                    end;
                    local l_SurfaceAppearance_2 = v78:FindFirstChildOfClass("SurfaceAppearance");
                    if l_SurfaceAppearance_2 then
                        l_SurfaceAppearance_2:Destroy();
                        if l_l_MutationSurfaces_0_FirstChild_0 then
                            local v86 = v64:Clone(l_l_MutationSurfaces_0_FirstChild_0);
                            if v62 == "Divine" then
                                v86.Color = l_v78_Attribute_0[1] or v80[1];
                            else
                                v86.Color = v82;
                            end;
                            v86.Parent = v78;
                        end;
                        v64:Add(function() --[[ Line: 232 ]]
                            -- upvalues: v78 (copy), l_SurfaceAppearance_2 (copy)
                            local l_SurfaceAppearance_3 = v78:FindFirstChildOfClass("SurfaceAppearance");
                            if l_SurfaceAppearance_3 then
                                l_SurfaceAppearance_3:Destroy();
                            end;
                            l_SurfaceAppearance_2:Clone().Parent = v78;
                        end);
                    else
                        local l_MaterialVariant_1 = v78.MaterialVariant;
                        if l_MaterialVariant_1 == "Strawberry Stud Light" or l_MaterialVariant_1 == "Strawberry Stud Dark" then
                            v70[v78] = true;
                            v78.MaterialVariant = ("%* Strawberry Stud Light"):format(v62);
                            v64:Add(function() --[[ Line: 245 ]]
                                -- upvalues: v78 (copy), l_MaterialVariant_1 (copy)
                                v78.MaterialVariant = l_MaterialVariant_1;
                            end);
                            if l_MaterialVariant_1 == "Strawberry Stud Light" then
                                continue;
                            end;
                        end;
                        local l_Color_1 = v78.Color;
                        v78.Color = v82;
                        v64:Add(function() --[[ Line: 257 ]]
                            -- upvalues: v78 (copy), l_Color_1 (copy)
                            v78.Color = l_Color_1;
                        end);
                    end;
                end;
            end;
        end;
    end;
    if v62 == "Lava" then
        for _, v91 in v60:GetDescendants() do
            if v91:IsA("BasePart") and not v70[v91] then
                local l_v91_Attribute_0 = v91:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v91_Attribute_0 ~= false and (v91:GetAttribute("IgnoreColor") or l_v91_Attribute_0)) and (v91:GetAttribute((("%*Color"):format(v62))) or v91:GetAttribute("Color")) == 1 then
                    l_v91_Attribute_0 = v91.Material;
                    v91.Material = Enum.Material.Neon;
                    v64:Add(function() --[[ Line: 274 ]]
                        -- upvalues: v91 (copy), l_v91_Attribute_0 (copy)
                        v91.Material = l_v91_Attribute_0;
                    end);
                end;
            end;
        end;
    elseif v62 == "Galaxy" then
        for _, v94 in v60:GetDescendants() do
            if v94:IsA("BasePart") and not v70[v94] then
                local l_v94_Attribute_0 = v94:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v94_Attribute_0 ~= false and (v94:GetAttribute("IgnoreColor") or l_v94_Attribute_0)) then
                    if (v94:GetAttribute((("%*Color"):format(v62))) or v94:GetAttribute("Color")) == 1 then
                        l_v94_Attribute_0 = v94.Material;
                        v94.Material = Enum.Material.Neon;
                        local l_l_v94_Attribute_0_0 = l_v94_Attribute_0 --[[ copy: 16 -> 34 ]];
                        v64:Add(function() --[[ Line: 289 ]]
                            -- upvalues: v94 (copy), l_l_v94_Attribute_0_0 (copy)
                            v94.Material = l_l_v94_Attribute_0_0;
                        end);
                    end;
                    l_v94_Attribute_0 = v94.MaterialVariant;
                    v94.MaterialVariant = "Galaxy Stud";
                    v64:Add(function() --[[ Line: 296 ]]
                        -- upvalues: v94 (copy), l_v94_Attribute_0 (copy)
                        v94.MaterialVariant = l_v94_Attribute_0;
                    end);
                end;
            end;
        end;
    elseif v62 == "YinYang" then
        for _, v98 in v60:GetDescendants() do
            if v98:IsA("BasePart") and not v70[v98] then
                local l_v98_Attribute_0 = v98:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v98_Attribute_0 ~= false and (v98:GetAttribute("IgnoreColor") or l_v98_Attribute_0)) then
                    local v100 = v98:GetAttribute((("%*Color"):format(v62))) or v98:GetAttribute("Color") or 1;
                    l_v98_Attribute_0 = true;
                    if v100 ~= 3 then
                        l_v98_Attribute_0 = v100 == 4;
                    end;
                    if l_v98_Attribute_0 then
                        local l_Material_1 = v98.Material;
                        v98.Material = Enum.Material.Neon;
                        v64:Add(function() --[[ Line: 311 ]]
                            -- upvalues: v98 (copy), l_Material_1 (copy)
                            v98.Material = l_Material_1;
                        end);
                    end;
                end;
            end;
        end;
    elseif v62 == "Radioactive" then
        for _, v103 in v60:GetDescendants() do
            if v103:IsA("BasePart") and not v70[v103] then
                local l_v103_Attribute_0 = v103:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v103_Attribute_0 ~= false and (v103:GetAttribute("IgnoreColor") or l_v103_Attribute_0)) then
                    local l_MaterialVariant_2 = v103.MaterialVariant;
                    l_v103_Attribute_0 = v103.Material;
                    local v106 = v103:GetAttribute((("%*Color"):format(v62))) or v103:GetAttribute("Color") or 1;
                    if v106 == 2 and v69 == 1 or v106 == 2 and v69 == 4 or (not (v106 ~= 2) or v106 == 6) and v69 == 5 then
                        v103.Material = Enum.Material.Neon;
                        v64:Add(function() --[[ Line: 329 ]]
                            -- upvalues: v103 (copy), l_v103_Attribute_0 (copy)
                            v103.Material = l_v103_Attribute_0;
                        end);
                    end;
                    local l_v103_Attribute_1 = v103:GetAttribute((("%*Stud"):format(v62)));
                    if l_v103_Attribute_1 ~= false and (v103.MaterialVariant == "Custom Stud" or l_v103_Attribute_1 == true) and not v103:GetAttribute((("%*Ignore"):format(v62))) then
                        if v103:GetAttribute((("%*MaterialMode"):format(v62))) == 2 or v60:GetAttribute((("%*MaterialMode"):format(v62))) == 2 then
                            if v103:GetAttribute((("%*Material"):format(v62))) == 2 or v60:GetAttribute((("%*Material"):format(v62))) == 2 then
                                v103.Material = Enum.Material.SmoothPlastic;
                                v103.MaterialVariant = "Radioactive Stud";
                                v64:Add(function() --[[ Line: 341 ]]
                                    -- upvalues: v103 (copy), l_MaterialVariant_2 (copy), l_v103_Attribute_0 (copy)
                                    v103.MaterialVariant = l_MaterialVariant_2;
                                    v103.Material = l_v103_Attribute_0;
                                end);
                            else
                                v103.Material = Enum.Material.SmoothPlastic;
                                v103.MaterialVariant = "Radioactive Stud2";
                                v64:Add(function() --[[ Line: 348 ]]
                                    -- upvalues: v103 (copy), l_MaterialVariant_2 (copy), l_v103_Attribute_0 (copy)
                                    v103.MaterialVariant = l_MaterialVariant_2;
                                    v103.Material = l_v103_Attribute_0;
                                end);
                            end;
                        elseif v106 ~= 2 and v106 ~= 6 then
                            if v103:GetAttribute((("%*Material"):format(v62))) == 2 or v60:GetAttribute((("%*Material"):format(v62))) == 2 then
                                v103.Material = Enum.Material.SmoothPlastic;
                                v103.MaterialVariant = "Radioactive Stud";
                                v64:Add(function() --[[ Line: 357 ]]
                                    -- upvalues: v103 (copy), l_MaterialVariant_2 (copy), l_v103_Attribute_0 (copy)
                                    v103.MaterialVariant = l_MaterialVariant_2;
                                    v103.Material = l_v103_Attribute_0;
                                end);
                            else
                                v103.Material = Enum.Material.SmoothPlastic;
                                v103.MaterialVariant = "Radioactive Stud2";
                                v64:Add(function() --[[ Line: 364 ]]
                                    -- upvalues: v103 (copy), l_MaterialVariant_2 (copy), l_v103_Attribute_0 (copy)
                                    v103.MaterialVariant = l_MaterialVariant_2;
                                    v103.Material = l_v103_Attribute_0;
                                end);
                            end;
                        end;
                    elseif l_v103_Attribute_1 == false then
                        v103.MaterialVariant = "";
                        v64:Add(function() --[[ Line: 372 ]]
                            -- upvalues: v103 (copy), l_MaterialVariant_2 (copy)
                            v103.MaterialVariant = l_MaterialVariant_2;
                        end);
                    end;
                end;
            end;
        end;
    elseif v62 == "Cursed" then
        local l_v60_FirstChild_0 = v60:FindFirstChild("_Trait.Zombie");
        if l_v60_FirstChild_0 then
            l_v60_FirstChild_0:Destroy();
        end;
        for _, v110 in v60:GetDescendants() do
            if v110:IsA("BasePart") and not v70[v110] then
                local l_v110_Attribute_0 = v110:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v110_Attribute_0 ~= false and (v110:GetAttribute("IgnoreColor") or l_v110_Attribute_0)) then
                    local l_MaterialVariant_3 = v110.MaterialVariant;
                    l_v110_Attribute_0 = v110.Material;
                    local l_Color_2 = v110.Color;
                    local v114 = v110:GetAttribute((("%*Color"):format(v62))) or v110:GetAttribute("Color") or 1;
                    if v114 == 2 and v69 == 1 or v114 == 2 and v69 == 4 or (not (v114 ~= 2) or v114 == 6) and v69 == 5 then
                        v110.Material = Enum.Material.Neon;
                        v64:Add(function() --[[ Line: 397 ]]
                            -- upvalues: v110 (copy), l_v110_Attribute_0 (copy)
                            v110.Material = l_v110_Attribute_0;
                        end);
                    end;
                    local l_v110_Attribute_1 = v110:GetAttribute((("%*Stud"):format(v62)));
                    if l_v110_Attribute_1 ~= false and (v110.MaterialVariant == "Custom Stud" or l_v110_Attribute_1 == true) and not v110:GetAttribute((("%*Ignore"):format(v62))) then
                        if v114 ~= 2 and v114 ~= 6 or l_v110_Attribute_1 == true then
                            v110.Material = Enum.Material.SmoothPlastic;
                            v110.MaterialVariant = "Cursed Stud";
                            v110.Color = Color3.fromRGB(255, 23, 23);
                            v64:Add(function() --[[ Line: 409 ]]
                                -- upvalues: v110 (copy), l_MaterialVariant_3 (copy), l_v110_Attribute_0 (copy), l_Color_2 (copy)
                                v110.MaterialVariant = l_MaterialVariant_3;
                                v110.Material = l_v110_Attribute_0;
                                v110.Color = l_Color_2;
                            end);
                        end;
                    elseif l_v110_Attribute_1 == false then
                        v110.MaterialVariant = "";
                        v64:Add(function() --[[ Line: 417 ]]
                            -- upvalues: v110 (copy), l_MaterialVariant_3 (copy)
                            v110.MaterialVariant = l_MaterialVariant_3;
                        end);
                    end;
                    local l_SurfaceAppearance_4 = v110:FindFirstChildOfClass("SurfaceAppearance");
                    if l_SurfaceAppearance_4 then
                        if not v110:GetAttribute((("%*IgnoreSurfaceColor"):format(v62))) then
                            l_SurfaceAppearance_4.Color = Color3.fromRGB(255, 23, 23);
                        end;
                        if v110:GetAttribute("IgnoreSurface") then
                            l_SurfaceAppearance_4:Destroy();
                        end;
                    end;
                end;
            end;
        end;
        local l_FirstChild_0 = l_ReplicatedStorage_0.Models.TraitsPerAnimal.Zombie:FindFirstChild(v61);
        if l_FirstChild_0 then
            local v118 = v64:Clone(l_FirstChild_0);
            v118.Name = "_Trait.Zombie";
            v118.Parent = v60;
            local v119 = {};
            for _, v121 in v118:GetChildren() do
                v121.Color = Color3.fromRGB(255, 23, 23);
                local l_Attachment_0 = v121:FindFirstChildOfClass("Attachment");
                local v123 = v119[l_Attachment_0.Name] or v60:FindFirstChild(l_Attachment_0.Name, true);
                if not v123 then
                    v121:Destroy();
                else
                    v121:PivotTo(v123.WorldCFrame);
                    v119[l_Attachment_0.Name] = v123;
                    local l_RigidConstraint_0 = Instance.new("RigidConstraint");
                    l_RigidConstraint_0.Attachment0 = l_Attachment_0;
                    l_RigidConstraint_0.Attachment1 = v123;
                    l_RigidConstraint_0.Parent = l_Attachment_0;
                end;
            end;
        end;
    elseif v62 == "Divine" then
        local l_v60_Attribute_0 = v60:GetAttribute("EmissiveStrength");
        for _, v127 in v60:GetDescendants() do
            if v127:IsA("SurfaceAppearance") then
                local l_EmissiveStrength_0 = v127.EmissiveStrength;
                v127.EmissiveStrength = l_v60_Attribute_0 or 2;
                local l_l_EmissiveStrength_0_0 = l_EmissiveStrength_0 --[[ copy: 16 -> 33 ]];
                v64:Add(function() --[[ Line: 467 ]]
                    -- upvalues: v127 (copy), l_l_EmissiveStrength_0_0 (copy)
                    v127.EmissiveStrength = l_l_EmissiveStrength_0_0;
                end);
            end;
            if v127:IsA("BasePart") and not v70[v127] then
                local l_v127_Attribute_0 = v127:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v127_Attribute_0 ~= false and (v127:GetAttribute("IgnoreColor") or l_v127_Attribute_0)) then
                    local v131 = v127:GetAttribute((("%*Color"):format(v62))) or v127:GetAttribute("Color") or 1;
                    if v131 == 2 and v69 == 1 or v131 == 2 and v69 == 4 or (not (v131 ~= 2) or v131 == 6) and v69 == 5 then
                        local l_Material_2 = v127.Material;
                        v127.Material = Enum.Material.Neon;
                        local l_l_Material_2_0 = l_Material_2 --[[ copy: 18 -> 32 ]];
                        v64:Add(function() --[[ Line: 481 ]]
                            -- upvalues: v127 (copy), l_l_Material_2_0 (copy)
                            v127.Material = l_l_Material_2_0;
                        end);
                    end;
                    local l_v127_Attribute_1 = v127:GetAttribute((("%*Stud"):format(v62)));
                    if l_v127_Attribute_1 ~= false and (v127.MaterialVariant == "Custom Stud" or l_v127_Attribute_1 == true) and not v127:GetAttribute((("%*Ignore"):format(v62))) then
                        if v127:GetAttribute((("%*MaterialMode"):format(v62))) == 2 or v60:GetAttribute((("%*MaterialMode"):format(v62))) == 2 then
                            local l_Material_3 = v127.Material;
                            local l_MaterialVariant_4 = v127.MaterialVariant;
                            v127.Material = Enum.Material.SmoothPlastic;
                            v127.MaterialVariant = "Divine Stud";
                            v64:Add(function() --[[ Line: 494 ]]
                                -- upvalues: v127 (copy), l_MaterialVariant_4 (copy), l_Material_3 (copy)
                                v127.MaterialVariant = l_MaterialVariant_4;
                                v127.Material = l_Material_3;
                            end);
                        elseif v131 ~= 2 and v131 ~= 6 then
                            local l_Material_4 = v127.Material;
                            local l_MaterialVariant_5 = v127.MaterialVariant;
                            v127.Material = Enum.Material.SmoothPlastic;
                            v127.MaterialVariant = "Divine Stud";
                            v64:Add(function() --[[ Line: 503 ]]
                                -- upvalues: v127 (copy), l_MaterialVariant_5 (copy), l_Material_4 (copy)
                                v127.MaterialVariant = l_MaterialVariant_5;
                                v127.Material = l_Material_4;
                            end);
                        end;
                    elseif l_v127_Attribute_1 == false then
                        local l_MaterialVariant_6 = v127.MaterialVariant;
                        v127.MaterialVariant = "";
                        v64:Add(function() --[[ Line: 511 ]]
                            -- upvalues: v127 (copy), l_MaterialVariant_6 (copy)
                            v127.MaterialVariant = l_MaterialVariant_6;
                        end);
                    end;
                end;
            end;
        end;
    elseif v62 == "Cyber" then
        local v140 = v60:FindFirstChild("VfxInstance") or v54(v60);
        local l_PrimaryPart_0 = v60.PrimaryPart;
        if l_PrimaryPart_0 then
            for _, v143 in script.MutationVFX.Cyber.RootPart:GetChildren() do
                v64:Clone(v143).Parent = l_PrimaryPart_0;
            end;
        end;
        for _, v145 in v60:QueryDescendants("BasePart") do
            if not v70[v145] then
                local l_v145_Attribute_0 = v145:GetAttribute((("%*IgnoreColor"):format(v62)));
                if not (l_v145_Attribute_0 ~= false and (v145:GetAttribute("IgnoreColor") or l_v145_Attribute_0)) then
                    if v140 == v145 then
                        for _, v148 in script.MutationVFX.Cyber.BiggestInstance:GetChildren() do
                            v64:Clone(v148).Parent = v145;
                        end;
                    end;
                    if v145.Transparency ~= 1 then
                        local v149 = v145:GetAttribute((("%*Color"):format(v62))) or v145:GetAttribute("Color") or 1;
                        l_v145_Attribute_0 = v145:FindFirstChildOfClass("SurfaceAppearance");
                        if v149 == 7 then
                            local l_Material_5 = v145.Material;
                            v145.Material = Enum.Material.Neon;
                            local l_l_Material_5_0 = l_Material_5 --[[ copy: 19 -> 31 ]];
                            v64:Add(function() --[[ Line: 549 ]]
                                -- upvalues: v145 (copy), l_l_Material_5_0 (copy)
                                v145.Material = l_l_Material_5_0;
                            end);
                        elseif v149 == 1 then
                            local l_Material_6 = v145.Material;
                            local l_Transparency_0 = v145.Transparency;
                            v145.Material = Enum.Material.Glass;
                            v145.Transparency = 0.25;
                            local l_l_Material_6_0 = l_Material_6 --[[ copy: 19 -> 29 ]];
                            local l_l_Transparency_0_0 = l_Transparency_0 --[[ copy: 20 -> 30 ]];
                            v64:Add(function() --[[ Line: 557 ]]
                                -- upvalues: v145 (copy), l_l_Material_6_0 (copy), l_l_Transparency_0_0 (copy)
                                v145.Material = l_l_Material_6_0;
                                v145.Transparency = l_l_Transparency_0_0;
                            end);
                            if not l_v145_Attribute_0 and not v145:GetAttribute("Eyes") and v145.ClassName == "MeshPart" then
                                v64:Add(Instance.new("SurfaceAppearance")).Parent = v145;
                            end;
                        elseif v149 == 3 or v149 == 4 or v69 == 2 and v149 == 2 then
                            if v149 == 4 then
                                local l_Transparency_1 = v145.Transparency;
                                local l_MaterialVariant_7 = v145.MaterialVariant;
                                local l_Material_7 = v145.Material;
                                local l_Color_3 = v145.Color;
                                v145.Transparency = 0.5;
                                v145.Material = Enum.Material.SmoothPlastic;
                                v145.MaterialVariant = "Tech Stud";
                                v145.Color = Color3.fromRGB(62, 155, 255);
                                local l_l_Material_7_0 = l_Material_7 --[[ copy: 21 -> 26 ]];
                                local l_l_Transparency_1_0 = l_Transparency_1 --[[ copy: 19 -> 27 ]];
                                local l_l_MaterialVariant_7_0 = l_MaterialVariant_7 --[[ copy: 20 -> 28 ]];
                                v64:Add(function() --[[ Line: 577 ]]
                                    -- upvalues: v145 (copy), l_Color_3 (copy), l_l_Material_7_0 (copy), l_l_Transparency_1_0 (copy), l_l_MaterialVariant_7_0 (copy)
                                    v145.Color = l_Color_3;
                                    v145.Material = l_l_Material_7_0;
                                    v145.Transparency = l_l_Transparency_1_0;
                                    v145.MaterialVariant = l_l_MaterialVariant_7_0;
                                end);
                            else
                                local _ = v145.Material;
                                local _ = v145.Transparency;
                                v145.Material = Enum.Material.Glass;
                                v145.Transparency = 0.5;
                                if not l_v145_Attribute_0 and not v145:GetAttribute("Eyes") and v145.ClassName == "MeshPart" then
                                    v64:Add(Instance.new("SurfaceAppearance")).Parent = v145;
                                end;
                            end;
                        end;
                        if v145:GetAttribute("Eyes") then
                            local l_Material_9 = v145.Material;
                            local l_Transparency_3 = v145.Transparency;
                            local l_Color_4 = v145.Color;
                            v145.Color = v67.Palettes[v69][7];
                            v145.Transparency = 0.25;
                            v145.Material = Enum.Material.Neon;
                            local l_l_Material_9_0 = l_Material_9 --[[ copy: 19 -> 24 ]];
                            local l_l_Transparency_3_0 = l_Transparency_3 --[[ copy: 20 -> 25 ]];
                            v64:Add(function() --[[ Line: 602 ]]
                                -- upvalues: v145 (copy), l_l_Material_9_0 (copy), l_l_Transparency_3_0 (copy), l_Color_4 (copy)
                                v145.Material = l_l_Material_9_0;
                                v145.Transparency = l_l_Transparency_3_0;
                                v145.Color = l_Color_4;
                            end);
                        end;
                        if l_v145_Attribute_0 then
                            if v39(v145) then
                                local l_Material_10 = v145.Material;
                                local l_Transparency_4 = v145.Transparency;
                                v145.Transparency = 0;
                                v145.Material = Enum.Material.Neon;
                                v64:Add(function() --[[ Line: 615 ]]
                                    -- upvalues: v145 (copy), l_Material_10 (copy), l_Transparency_4 (copy)
                                    v145.Material = l_Material_10;
                                    v145.Transparency = l_Transparency_4;
                                end);
                                l_v145_Attribute_0.AlphaMode = Enum.AlphaMode.Overlay;
                                l_v145_Attribute_0.Color = Color3.fromRGB(35, 75, 115);
                                l_v145_Attribute_0.EmissiveTint = Color3.fromRGB(255, 255, 255);
                                l_v145_Attribute_0.EmissiveStrength = 50;
                            else
                                local l_Material_11 = v145.Material;
                                local l_Transparency_5 = v145.Transparency;
                                v145.Transparency = 0;
                                v145.Material = Enum.Material.Neon;
                                v64:Add(function() --[[ Line: 629 ]]
                                    -- upvalues: v145 (copy), l_Material_11 (copy), l_Transparency_5 (copy)
                                    v145.Material = l_Material_11;
                                    v145.Transparency = l_Transparency_5;
                                end);
                                l_v145_Attribute_0.AlphaMode = Enum.AlphaMode.Overlay;
                                l_v145_Attribute_0.Color = Color3.fromRGB(0, 25, 30);
                                l_v145_Attribute_0.EmissiveTint = Color3.fromRGB(255, 255, 255);
                                l_v145_Attribute_0.EmissiveStrength = 25;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if v61 == "Meowl" then
            local v174 = Color3.fromRGB(62, 155, 255);
            local v175 = ColorSequence.new(v174);
            for _, v177 in (v60:QueryDescendants("ParticleEmitter")) do
                local l_Color_5 = v177.Color;
                v177.Color = v175;
                v64:Add(function() --[[ Line: 648 ]]
                    -- upvalues: v177 (copy), l_Color_5 (copy)
                    v177.Color = l_Color_5;
                end);
            end;
        end;
    end;
    local l_l_Vfx_0_FirstChild_0 = l_Vfx_0:FindFirstChild(v62);
    local l_VfxInstance_0 = v60:FindFirstChild("VfxInstance");
    if l_l_Vfx_0_FirstChild_0 and l_VfxInstance_0 then
        for _, v182 in l_l_Vfx_0_FirstChild_0:GetChildren() do
            v64:Clone(v182).Parent = l_VfxInstance_0;
        end;
    end;
    v60:SetAttribute("__mutation", v62);
    v64:Add(function() --[[ Line: 665 ]]
        -- upvalues: v60 (copy)
        v60:SetAttribute("__mutation", nil);
    end);
    return v64:WrapClean();
end;
v22.ApplyTraits = function(_, v184, v185, v186) --[[ Line: 672 ]] --[[ Name: ApplyTraits ]]
    -- upvalues: v6 (copy), l_Models_0 (copy), v13 (copy), l_ReplicatedStorage_0 (copy), v4 (copy), l_Traits_0 (copy), l_Traits_1 (copy), v22 (copy)
    local v187 = v6.new();
    local v188 = {};
    for _, v190 in v186 do
        v188[v190] = true;
    end;
    local v191 = v188.Skibidi and l_Models_0.TraitsPerAnimal.Skibidi:FindFirstChild(v185);
    for _, v193 in v186 do
        local function v206() --[[ Line: 683 ]] --[[ Name: loadSpecificAnimalModel ]]
            -- upvalues: v13 (ref), v193 (copy), l_Models_0 (ref), v185 (copy), v184 (copy), v187 (copy), l_ReplicatedStorage_0 (ref), v4 (ref)
            if not v13[v193] then
                return;
            else
                local l_FirstChild_1 = l_Models_0.TraitsPerAnimal:FindFirstChild(v193);
                if not l_FirstChild_1 then
                    return;
                else
                    local l_l_FirstChild_1_FirstChild_0 = l_FirstChild_1:FindFirstChild(v185);
                    if not l_l_FirstChild_1_FirstChild_0 then
                        return;
                    elseif v184:FindFirstChild((("_Trait.%*"):format(v193))) then
                        return;
                    else
                        local v196 = v187:Clone(l_l_FirstChild_1_FirstChild_0);
                        v196.Name = ("_Trait.%*"):format(v193);
                        for _, v198 in v196:GetChildren() do
                            local l_Attachment_1 = v198:FindFirstChildOfClass("Attachment");
                            if l_Attachment_1 then
                                local l_v184_FirstChild_0 = v184:FindFirstChild(l_Attachment_1.Name, true);
                                if l_v184_FirstChild_0 then
                                    local l_RigidConstraint_1 = Instance.new("RigidConstraint");
                                    l_RigidConstraint_1.Attachment0 = l_Attachment_1;
                                    l_RigidConstraint_1.Attachment1 = l_v184_FirstChild_0;
                                    l_RigidConstraint_1.Parent = v198;
                                end;
                            end;
                        end;
                        v196.Parent = v184;
                        if v193 == "Jackolantern Pet" or v193 == "Reindeer Pet" or v193 == "Pink Egg" or v193 == "Blue Egg" or v193 == "Green Egg" or v193 == "Orange Egg" then
                            local l_v196_FirstChildWhichIsA_0 = v196:FindFirstChildWhichIsA("Animator", true);
                            if l_v196_FirstChildWhichIsA_0 then
                                l_v196_FirstChildWhichIsA_0:SetAttribute("Animation", (("Animations.Traits.%*"):format(v193)));
                                l_v196_FirstChildWhichIsA_0:AddTag("ClientLoadAnimation");
                                local v203 = l_v196_FirstChildWhichIsA_0:LoadAnimation(l_ReplicatedStorage_0.Animations.Traits[v193].Walk);
                                v187:Add(function() --[[ Line: 715 ]]
                                    -- upvalues: v203 (copy)
                                    v203:Stop(0);
                                    v203:Destroy();
                                end);
                                local v204 = (not (v193 ~= "Pink Egg" and v193 ~= "Blue Egg" and v193 ~= "Green Egg") or v193 == "Orange Egg") and 2 or 1;
                                v187:Add(v4.observeAttribute(v184, "Walking", function(v205) --[[ Line: 724 ]]
                                    -- upvalues: v203 (copy), v204 (copy)
                                    if v205 then
                                        if not v203.IsPlaying then
                                            v203:Play(0.2, 1, v204);
                                        end;
                                    elseif v203.IsPlaying then
                                        v203:Stop();
                                    end;
                                    return nil;
                                end));
                            end;
                        end;
                        return;
                    end;
                end;
            end;
        end;
        local function v223() --[[ Line: 741 ]] --[[ Name: loadModels ]]
            -- upvalues: v13 (ref), v193 (copy), l_Traits_0 (ref), v187 (copy), v184 (copy), v188 (copy), v191 (copy)
            local v207 = v13[v193];
            if not v207 then
                return;
            else
                local l_l_Traits_0_FirstChild_0 = l_Traits_0:FindFirstChild(v193);
                if not l_l_Traits_0_FirstChild_0 then
                    return;
                else
                    local v209 = v187:Clone(l_l_Traits_0_FirstChild_0);
                    v209.Name = ("_Trait.%*"):format(v193);
                    for _, v211 in v209:GetChildren() do
                        local v212 = false;
                        for _, v214 in v211:GetChildren() do
                            if v214:IsA("Attachment") then
                                local l_v184_FirstChild_1 = v184:FindFirstChild(v214.Name, true);
                                if l_v184_FirstChild_1 then
                                    v212 = true;
                                    local v216 = Vector3.new(0, 0, 0, 0);
                                    if v188.Halo and v193 ~= "Halo" then
                                        v216 = v216 + Vector3.new(0, -2, 0, 0);
                                    end;
                                    if (v193 == "10B" or v193 == "26") and v188["10B"] then
                                        v216 = v216 + Vector3.new(0, -1.4589999914169312, 0, 0);
                                    end;
                                    if (v193 == "Taco" or v193 == "10B" or v193 == "26") and v188["RIP Gravestone"] then
                                        v216 = v216 + Vector3.new(0, -3.5820000171661377, 0, 0);
                                    end;
                                    if (v193 == "Taco" or v193 == "10B" or v193 == "26" or v193 == "RIP Gravestone") and v188["Matteo Hat"] then
                                        v216 = v216 + Vector3.new(0, -1.3300000429153442, 0, 0);
                                    end;
                                    if (v193 == "Taco" or v193 == "10B" or v193 == "26" or v193 == "Matteo Hat" or v193 == "RIP Gravestone") and v188["Santa Hat"] then
                                        v216 = v216 + Vector3.new(0, -1.534000039100647, 0, 0);
                                    end;
                                    if (v193 == "Taco" or v193 == "10B" or v193 == "26" or v193 == "Matteo Hat" or v193 == "RIP Gravestone" or v193 == "Santa Hat") and v188["Witch Hat"] then
                                        v216 = v216 + Vector3.new(0, -2.450000047683716, 0, 0);
                                    end;
                                    if (v193 == "Taco" or v193 == "10B" or v193 == "26" or v193 == "Matteo Hat" or v193 == "RIP Gravestone" or v193 == "Santa Hat" or v193 == "Witch Hat") and v188.Sombrero then
                                        v216 = v216 + Vector3.new(0, -2.7279999256134033, 0, 0);
                                    end;
                                    if (v193 == "Taco" or v193 == "10B" or v193 == "26" or v193 == "Matteo Hat" or v193 == "RIP Gravestone" or v193 == "Santa Hat" or v193 == "Witch Hat" or v193 == "Sombrero") and v188.Skibidi then
                                        local l_Name_0 = v214.Name;
                                        if not string.find(l_Name_0, "Forward") then
                                            local v218 = string.find(l_Name_0, "Second");
                                            l_Name_0 = string.find(l_Name_0, "Third") and "ThirdForwardHatAttachment" or v218 and "SecondForwardHatAttachment" or "ForwardHatAttachment";
                                        end;
                                        local l_v191_FirstChild_0 = v191:FindFirstChild(l_Name_0, true);
                                        if l_v191_FirstChild_0 then
                                            v216 = v216 + Vector3.new(0, -(l_v191_FirstChild_0.Parent.Size.Y * 0.5) + l_v191_FirstChild_0.Position.Y, 0);
                                        end;
                                    end;
                                    if v216 ~= Vector3.new(0, 0, 0, 0) then
                                        if v193 == "26" then
                                            v216 = Vector3.new(0, 0, v216.Y);
                                        end;
                                        v214.Position = v214.Position + v216;
                                    end;
                                    local l_RigidConstraint_2 = Instance.new("RigidConstraint");
                                    l_RigidConstraint_2.Attachment0 = v214;
                                    l_RigidConstraint_2.Attachment1 = l_v184_FirstChild_1;
                                    l_RigidConstraint_2.Parent = v211;
                                    if v207.Modify then
                                        v207.Modify(v211, v214, l_v184_FirstChild_1);
                                    end;
                                end;
                            end;
                        end;
                        if not v212 then
                            v211:Destroy();
                        end;
                    end;
                    v209.Parent = v184;
                    if v188.Lightning then
                        local l_v209_FirstChildWhichIsA_0 = v209:FindFirstChildWhichIsA("Animator", true);
                        if l_v209_FirstChildWhichIsA_0 then
                            l_v209_FirstChildWhichIsA_0:SetAttribute("Animation", "Animations.Traits.Lightning");
                            l_v209_FirstChildWhichIsA_0:AddTag("ClientLoadAnimation");
                            return;
                        end;
                    elseif v188.Granny then
                        local l_v209_FirstChildWhichIsA_1 = v209:FindFirstChildWhichIsA("Animator", true);
                        if l_v209_FirstChildWhichIsA_1 then
                            l_v209_FirstChildWhichIsA_1:SetAttribute("Animation", "Animations.Traits.Granny");
                            l_v209_FirstChildWhichIsA_1:AddTag("ClientLoadAnimation");
                        end;
                    end;
                    return;
                end;
            end;
        end;
        local function v231() --[[ Line: 856 ]] --[[ Name: loadVfx ]]
            -- upvalues: v13 (ref), v193 (copy), l_Traits_1 (ref), v184 (copy), v187 (copy), v185 (copy)
            local v224 = v13[v193];
            if not v224 then
                return;
            else
                local l_l_Traits_1_FirstChild_0 = l_Traits_1:FindFirstChild(v193);
                if l_l_Traits_1_FirstChild_0 then
                    for _, v227 in l_l_Traits_1_FirstChild_0:GetChildren() do
                        local l_v184_FirstChild_2 = v184:FindFirstChild(v227.Name);
                        if l_v184_FirstChild_2 then
                            local v229 = v187:Clone(v227);
                            v229.Massless = true;
                            v229.CanCollide = false;
                            v229.CanQuery = false;
                            v229.CanTouch = false;
                            v229.Transparency = 1;
                            v229.CFrame = l_v184_FirstChild_2.CFrame;
                            local v230 = Instance.new("WeldConstraint", v229);
                            v230.Part0 = l_v184_FirstChild_2;
                            v230.Part1 = v229;
                            v229.Parent = v184;
                            v229.Name = ("_%*"):format(v227.Name);
                            if v224.ModifyVFX then
                                v224.ModifyVFX(v229, l_v184_FirstChild_2, v185);
                            end;
                        end;
                    end;
                end;
                return;
            end;
        end;
        if v193 ~= "Strawberry" or v185 ~= "Strawberry Elephant" then
            v206();
            v223();
            v231();
            if v193 == "Strawberry" then
                for _, v233 in v184:QueryDescendants("BasePart") do
                    local l_MaterialVariant_8 = v233.MaterialVariant;
                    local l_Color_6 = v233.Color;
                    if v233:HasTag("Strawberry") then
                        v233.Color = Color3.fromRGB(255, 255, 255);
                        v233.Material = Enum.Material.SmoothPlastic;
                        v233.MaterialVariant = "Strawberry Stud Light";
                        v187:Add(function() --[[ Line: 906 ]]
                            -- upvalues: v233 (copy), l_MaterialVariant_8 (copy), l_Color_6 (copy)
                            v233.MaterialVariant = l_MaterialVariant_8;
                            v233.Color = l_Color_6;
                        end);
                    end;
                    if v233:HasTag("Strawberry2") then
                        v233.Color = Color3.fromRGB(193, 193, 193);
                        v233.Material = Enum.Material.SmoothPlastic;
                        v233.MaterialVariant = "Strawberry Stud Light";
                        v187:Add(function() --[[ Line: 916 ]]
                            -- upvalues: v233 (copy), l_MaterialVariant_8 (copy), l_Color_6 (copy)
                            v233.MaterialVariant = l_MaterialVariant_8;
                            v233.Color = l_Color_6;
                        end);
                    end;
                    if v233:HasTag("Strawberry3") then
                        v233.Color = Color3.fromRGB(147, 147, 147);
                        v233.Material = Enum.Material.SmoothPlastic;
                        v233.MaterialVariant = "Strawberry Stud Light";
                        v187:Add(function() --[[ Line: 926 ]]
                            -- upvalues: v233 (copy), l_MaterialVariant_8 (copy), l_Color_6 (copy)
                            v233.MaterialVariant = l_MaterialVariant_8;
                            v233.Color = l_Color_6;
                        end);
                    end;
                end;
            elseif v193 == "Chocolate" then
                local v236 = v185 == "Strawberry Elephant" and "Chocolate Strawberry Stud" or "Chocolate Stud";
                for _, v238 in v184:QueryDescendants("BasePart") do
                    local l_MaterialVariant_9 = v238.MaterialVariant;
                    local l_Color_7 = v238.Color;
                    if v238:HasTag("Strawberry") then
                        v238.Color = Color3.fromRGB(136, 73, 28);
                        v238.Material = Enum.Material.SmoothPlastic;
                        v238.MaterialVariant = v236;
                        v187:Add(function() --[[ Line: 943 ]]
                            -- upvalues: v238 (copy), l_MaterialVariant_9 (copy), l_Color_7 (copy)
                            v238.MaterialVariant = l_MaterialVariant_9;
                            v238.Color = l_Color_7;
                        end);
                    end;
                    if v238:HasTag("Strawberry2") then
                        v238.Color = Color3.fromRGB(113, 59, 22);
                        v238.Material = Enum.Material.SmoothPlastic;
                        v238.MaterialVariant = v236;
                        v187:Add(function() --[[ Line: 953 ]]
                            -- upvalues: v238 (copy), l_MaterialVariant_9 (copy), l_Color_7 (copy)
                            v238.MaterialVariant = l_MaterialVariant_9;
                            v238.Color = l_Color_7;
                        end);
                    end;
                    if v238:HasTag("Strawberry3") then
                        v238.Color = Color3.fromRGB(91, 46, 16);
                        v238.Material = Enum.Material.SmoothPlastic;
                        v238.MaterialVariant = v236;
                        v187:Add(function() --[[ Line: 963 ]]
                            -- upvalues: v238 (copy), l_MaterialVariant_9 (copy), l_Color_7 (copy)
                            v238.MaterialVariant = l_MaterialVariant_9;
                            v238.Color = l_Color_7;
                        end);
                    end;
                end;
            elseif v193 == "Lucky" then
                for _, v242 in v184:QueryDescendants("BasePart") do
                    local l_MaterialVariant_10 = v242.MaterialVariant;
                    local l_Color_8 = v242.Color;
                    if v242:HasTag("Strawberry") then
                        v242.Color = Color3.fromRGB(255, 255, 255);
                        v242.Material = Enum.Material.SmoothPlastic;
                        v242.MaterialVariant = "Clover Stud";
                        v187:Add(function() --[[ Line: 978 ]]
                            -- upvalues: v242 (copy), l_MaterialVariant_10 (copy), l_Color_8 (copy)
                            v242.MaterialVariant = l_MaterialVariant_10;
                            v242.Color = l_Color_8;
                        end);
                    end;
                    if v242:HasTag("Strawberry2") then
                        v242.Color = Color3.fromRGB(255, 255, 255);
                        v242.Material = Enum.Material.SmoothPlastic;
                        v242.MaterialVariant = "Clover Stud";
                        v187:Add(function() --[[ Line: 988 ]]
                            -- upvalues: v242 (copy), l_MaterialVariant_10 (copy), l_Color_8 (copy)
                            v242.MaterialVariant = l_MaterialVariant_10;
                            v242.Color = l_Color_8;
                        end);
                    end;
                    if v242:HasTag("Strawberry3") then
                        v242.Color = Color3.fromRGB(255, 255, 255);
                        v242.Material = Enum.Material.SmoothPlastic;
                        v242.MaterialVariant = "Clover Stud2";
                        v187:Add(function() --[[ Line: 998 ]]
                            -- upvalues: v242 (copy), l_MaterialVariant_10 (copy), l_Color_8 (copy)
                            v242.MaterialVariant = l_MaterialVariant_10;
                            v242.Color = l_Color_8;
                        end);
                    end;
                end;
            end;
        end;
    end;
    if v185 == "Rosey and Teddy" and v188["Matteo Hat"] then
        local l_v184_Attribute_0 = v184:GetAttribute("__mutation");
        for _, v247 in v184:GetChildren() do
            if v247:IsA("BasePart") and v247.Transparency < 1 then
                local l_Transparency_6 = v247.Transparency;
                v247.Transparency = 1;
                v187:Add(function() --[[ Line: 1014 ]]
                    -- upvalues: v247 (copy), l_Transparency_6 (copy)
                    v247.Transparency = l_Transparency_6;
                end);
            end;
        end;
        local v249 = v187:Clone(script["MatteoHat_Rosey and Teddy"]);
        if l_v184_Attribute_0 then
            v187:Add(v22:ApplyMutation(v249, v185, l_v184_Attribute_0));
        end;
        v249.AnimationController:Destroy();
        local l_Weld_0 = Instance.new("Weld");
        l_Weld_0.Part0 = v249.PrimaryPart;
        l_Weld_0.Part1 = v184.PrimaryPart;
        l_Weld_0.Parent = v249;
        v249.Parent = v184;
    end;
    return v187:WrapClean();
end;
v22.GetAnimatedModel = function(_, v252, v253) --[[ Line: 1037 ]] --[[ Name: GetAnimatedModel ]]
    -- upvalues: l_Animals_1 (copy), l_Animals_0 (copy), v5 (copy)
    local l_l_Animals_1_FirstChild_0 = l_Animals_1:FindFirstChild(v252);
    if not l_l_Animals_1_FirstChild_0 then
        warn((("Animal not found %* in model folder"):format(v252)));
        return nil;
    else
        local v255 = l_l_Animals_1_FirstChild_0:Clone();
        if v255.PrimaryPart then
            v255.PrimaryPart.Anchored = true;
        end;
        v255.Parent = workspace;
        local l_l_Animals_0_FirstChild_0 = l_Animals_0:FindFirstChild(v252);
        local v257 = l_l_Animals_0_FirstChild_0 and l_l_Animals_0_FirstChild_0:FindFirstChild(v253);
        local v258 = v255:FindFirstChild("AnimationController") or Instance.new("AnimationController", v255);
        local v259 = v258:FindFirstChild("Animator") or Instance.new("Animator", v258);
        if v5:GetInstant("Optimisation.HumanoidBrainrotModels", true) then
            v258:Destroy();
            v258 = Instance.new("Humanoid", v255);
            v259 = Instance.new("Animator", v258);
            v258.Name = "AnimationController";
            v258.EvaluateStateMachine = false;
            v258.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            v258.PlatformStand = true;
            v258.Parent = v255;
        end;
        if v257 and v259 then
            local v260 = v259:LoadAnimation(v257);
            v260.Looped = true;
            v260:Play();
        end;
        for _, v262 in v255:GetDescendants() do
            if v262:IsA("BasePart") then
                v262.Massless = true;
                v262.CanCollide = false;
                v262.CanQuery = false;
                v262.CanTouch = false;
                v262.Anchored = false;
            end;
        end;
        return v255;
    end;
end;
v22.AttachOnViewportWithOptimizations = function(_, v264, v265, _, v267, _) --[[ Line: 1094 ]] --[[ Name: AttachOnViewportWithOptimizations ]]
    -- upvalues: v6 (copy), l_Animals_1 (copy), v22 (copy), v4 (copy), l_Animals_0 (copy), v36 (copy)
    local v269 = v6.new();
    local l_l_Animals_1_FirstChild_1 = l_Animals_1:FindFirstChild(v264);
    if not l_l_Animals_1_FirstChild_1 then
        warn((("Animal not found %* in model folder"):format(v264)));
        return v269;
    else
        local v271 = v269:Clone(l_l_Animals_1_FirstChild_1);
        local v272 = v269:Add(Instance.new("WorldModel"));
        v271.Parent = v272;
        local v273 = true;
        v269:Add(function() --[[ Line: 1108 ]]
            -- upvalues: v273 (ref)
            v273 = false;
        end);
        v269:Add(v265.Destroying:Connect(function() --[[ Line: 1112 ]]
            -- upvalues: v269 (copy)
            v269:Destroy();
        end));
        if v267 and v267 ~= "Default" then
            v269:Add(v22:ApplyMutation(v271, v264, v267));
        end;
        local function v274() --[[ Line: 1120 ]] --[[ Name: unparent ]]
            -- upvalues: v273 (ref), v272 (copy)
            if v273 then
                v272.Parent = nil;
            end;
        end;
        local function v285(v275) --[[ Line: 1126 ]] --[[ Name: updateAncestry ]]
            -- upvalues: v274 (copy), v4 (ref), v273 (ref), v272 (copy), v265 (copy), l_Animals_0 (ref), v264 (copy), v271 (copy)
            if not v275 then
                return v274;
            else
                local l_v275_FirstAncestorWhichIsA_0 = v275:FindFirstAncestorWhichIsA("LayerCollector");
                if not l_v275_FirstAncestorWhichIsA_0 then
                    return v274;
                else
                    local l_GuiObject_0 = l_v275_FirstAncestorWhichIsA_0:FindFirstChildWhichIsA("GuiObject");
                    if not l_GuiObject_0 then
                        return v274;
                    else
                        return v4.observeProperty(l_v275_FirstAncestorWhichIsA_0, "Enabled", function(v278) --[[ Line: 1141 ]]
                            -- upvalues: v274 (ref), v4 (ref), l_GuiObject_0 (copy), v273 (ref), v272 (ref), v265 (ref), l_Animals_0 (ref), v264 (ref), v271 (ref)
                            if not v278 then
                                return v274;
                            else
                                return v4.observeProperty(l_GuiObject_0, "Visible", function(v279) --[[ Line: 1146 ]]
                                    -- upvalues: v274 (ref), v273 (ref), v272 (ref), v265 (ref), l_Animals_0 (ref), v264 (ref), v271 (ref)
                                    if not v279 then
                                        return v274;
                                    else
                                        if v273 then
                                            v272.Parent = v265;
                                        end;
                                        task.spawn(function() --[[ Line: 1157 ]]
                                            -- upvalues: v273 (ref), l_Animals_0 (ref), v264 (ref), v271 (ref)
                                            if not v273 then
                                                return;
                                            else
                                                local l_l_Animals_0_FirstChild_1 = l_Animals_0:FindFirstChild(v264);
                                                local v281 = l_l_Animals_0_FirstChild_1 and l_l_Animals_0_FirstChild_1:FindFirstChild("Idle");
                                                local v282 = v271:FindFirstChild("AnimationController") or Instance.new("AnimationController", v271);
                                                local v283 = v282:FindFirstChild("Animator") or Instance.new("Animator", v282);
                                                if v281 and v283 then
                                                    local v284 = v283:LoadAnimation(v281);
                                                    v284.Looped = true;
                                                    v284:Play(0);
                                                end;
                                                return;
                                            end;
                                        end);
                                        return v274;
                                    end;
                                end);
                            end;
                        end);
                    end;
                end;
            end;
        end;
        local v286 = nil;
        local function _(v287) --[[ Line: 1181 ]] --[[ Name: requestUpdateAncestry ]]
            -- upvalues: v286 (ref), v285 (copy)
            if type(v286) == "function" then
                v286();
            end;
            v286 = v285(v287);
        end;
        v269:Add(v265.AncestryChanged:Connect(function(_, v290) --[[ Line: 1189 ]]
            -- upvalues: v286 (ref), v285 (copy)
            if type(v286) == "function" then
                v286();
            end;
            v286 = v285(v290);
        end));
        if v265.Parent then
            local l_Parent_0 = v265.Parent;
            if type(v286) == "function" then
                v286();
            end;
            v286 = v285(l_Parent_0);
        end;
        local v292 = v269:Add(Instance.new("Camera"));
        v292.FieldOfView = 50;
        v292.Parent = v265;
        v265.CurrentCamera = v292;
        v36(v292, v264, v271, v292.FieldOfView, 0.75, 0.7);
        return v269, v271;
    end;
end;
v22.AttachOnViewport = function(_, v294, v295, _, v297, _) --[[ Line: 1208 ]] --[[ Name: AttachOnViewport ]]
    -- upvalues: v22 (copy)
    return v22:AttachOnViewportWithOptimizations(v294, v295, nil, v297);
end;
v22.GetListOfRarity = function(_, v300) --[[ Line: 1285 ]] --[[ Name: GetListOfRarity ]]
    -- upvalues: v8 (copy)
    local v301 = {};
    for v302, v303 in v8 do
        if v303.Rarity == v300 then
            table.insert(v301, v302);
        end;
    end;
    return v301;
end;
v22.GetList = function(_, v305, v306) --[[ Line: 1296 ]] --[[ Name: GetList ]]
    -- upvalues: v8 (copy), v11 (copy)
    local v307 = {};
    for v308, v309 in v8 do
        if not v309.IsEnabled or v309.IsEnabled() then
            table.insert(v307, v308);
        end;
    end;
    if v305 == "Rarity" then
        table.sort(v307, function(v310, v311) --[[ Line: 1307 ]]
            -- upvalues: v8 (ref), v11 (ref), v306 (copy)
            local v312 = v8[v310];
            local v313 = v8[v311];
            local v314 = v312 and v312.Rarity;
            local v315 = v313 and v313.Rarity;
            local v316 = v314 and v11[v314] and v11[v314].Weight or 0;
            local v317 = v315 and v11[v315] and v11[v315].Weight or 0;
            if v306 then
                return v316 < v317;
            else
                return v317 < v316;
            end;
        end);
        return v307;
    elseif v305 == "Price" then
        table.sort(v307, function(v318, v319) --[[ Line: 1323 ]]
            -- upvalues: v8 (ref), v306 (copy)
            local v320 = v8[v318];
            local v321 = v8[v319];
            local v322 = v320 and v320.Price or 0;
            local v323 = v321 and v321.Price or 0;
            if v306 then
                return v322 < v323;
            else
                return v323 < v322;
            end;
        end);
        return v307;
    else
        if v305 == "Generation" then
            table.sort(v307, function(v324, v325) --[[ Line: 1336 ]]
                -- upvalues: v8 (ref), v306 (copy)
                local v326 = v8[v324];
                local v327 = v8[v325];
                local v328 = v326 and v326.Generation or 0;
                local v329 = v327 and v327.Generation or 0;
                if v306 then
                    return v328 < v329;
                else
                    return v329 < v328;
                end;
            end);
        end;
        return v307;
    end;
end;
v22.GetGeneration = function(_, v331, v332, v333, v334) --[[ Line: 1354 ]] --[[ Name: GetGeneration ]]
    -- upvalues: v8 (copy), v9 (copy), v12 (copy), v13 (copy), l_ReplicatedStorage_0 (copy)
    local v335 = 0;
    local v336 = v8[v331];
    if not v336 then
        return v335;
    else
        v335 = if v336.Generation then v335 + v336.Generation else v335 + v336.Price * v9.Game.AnimalGanerationModifier;
        local v337 = 1;
        if v332 then
            v337 = v337 + v12[v332].Modifier;
        end;
        local v338 = false;
        if v333 then
            for _, v340 in v333 do
                local v341 = v13[v340];
                if v341 then
                    if v340 == "Sleepy" then
                        v338 = true;
                    else
                        v337 = v337 + v341.MultiplierModifier;
                    end;
                end;
            end;
        end;
        v335 = v335 * v337;
        if v338 then
            v335 = v335 * 0.5;
        end;
        if v334 then
            v335 = v335 * require(l_ReplicatedStorage_0.Shared.Game):GetPlayerCashMultiplayer(v334);
        end;
        return (math.round(v335));
    end;
end;
v22.GetPrice = function(_, v343, _) --[[ Line: 1405 ]] --[[ Name: GetPrice ]]
    -- upvalues: v8 (copy)
    return v8[v343].Price;
end;
v22.GetRarityStringFormat = function(_, v346) --[[ Line: 1412 ]] --[[ Name: GetRarityStringFormat ]]
    -- upvalues: v11 (copy)
    local v347 = v11[v346];
    if v346 == "OG" then
        return "<og>%s</og>";
    elseif v346 == "Festive" then
        return "<greenred>%s</greenred>";
    elseif v346 == "Admin" or v346 == "Taco" or v346 == "Spooky" then
        return "<yellowred>%s</yellowred>";
    elseif v346 == "Secret" then
        return "<zebra>%s</zebra>";
    elseif v346 == "Brainrot God" then
        return "<rainbow>%s</rainbow>";
    elseif v347 then
        return (("<font color=\"#%*\">%%s</font>"):format((v347.Color:ToHex())));
    else
        return "%s";
    end;
end;
v22.GetAnimalTag = function(_, v349) --[[ Line: 1427 ]] --[[ Name: GetAnimalTag ]]
    -- upvalues: v8 (copy), v22 (copy)
    local v350 = v8[v349];
    if v350 then
        return v22:GetRarityStringFormat(v350.Rarity);
    else
        return "%s";
    end;
end;
v22.GetRarityWeight = function(_, v352) --[[ Line: 1435 ]] --[[ Name: GetRarityWeight ]]
    -- upvalues: v11 (copy)
    local v353 = v11[v352];
    if v353 then
        return v353.Weight;
    else
        return 1;
    end;
end;
v22.ColorBrainrotName = function(v354, v355) --[[ Line: 1445 ]] --[[ Name: ColorBrainrotName ]]
    local l_v354_AnimalTag_0 = v354:GetAnimalTag(v355);
    return string.format(l_v354_AnimalTag_0, v355);
end;
v22.ColorRecipeName = function(v357, v358) --[[ Line: 1451 ]] --[[ Name: ColorRecipeName ]]
    local v359 = string.split(v358, " & ");
    local v360 = {};
    for _, v362 in v359 do
        table.insert(v360, v357:ColorBrainrotName(v362));
    end;
    return table.concat(v360, " & ");
end;
return v22;
