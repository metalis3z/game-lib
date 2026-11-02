-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Rarity_0 = l_Sync_0.Rarity;
if not _G.Cache then
    _G.Cache = {};
end;
local function v6(v4) --[[ Line: 15 ]] --[[ Name: GetImage ]]
    if _G.Cache[v4] ~= nil then
        return _G.Cache[v4];
    else
        local v5 = (tonumber(v4) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v4 or v4) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v4] = v5;
        return v5;
    end;
end;
local v7 = {
    Classic = 1, 
    Common = 2, 
    Uncommon = 3, 
    Rare = 4, 
    Legendary = 5, 
    Godly = 6, 
    Victim = 7, 
    Unique = 7, 
    Christmas = 1.5, 
    Halloween = 1.6, 
    Ancient = 6.5
};
local function v8(v9) --[[ Line: 29 ]] --[[ Name: CopyTable ]]
    local v10 = {};
    for v11, v12 in pairs(v9) do
        if type(v12) == "table" then
            v12 = v8(v12);
        end;
        v10[v11] = v12;
    end;
    return v10;
end;
v0.GetImage = v6;
v0.GetSortedInventory = function() --[[ Line: 44 ]]
    local v13 = v8(l_ProfileData_0.Weapons);
    local v14 = {};
    for v15, v16 in pairs(v13.Owned) do
        table.insert(v14, {
            ItemID = v15, 
            Amount = v16
        });
    end;
    table.sort(v14, function(v17, v18) --[[ Line: 54 ]]
        local v19 = {
            v17.ItemID, 
            v18.ItemID
        };
        local v20 = {
            v17.Amount, 
            v18.Amount
        };
        local v21 = {
            l_Sync_0.Item[v19[1]], 
            l_Sync_0.Item[v19[2]]
        };
		local r1 = v21[1] and v7[v21[1].Rarity] or 0
		local r2 = v21[2] and v7[v21[2].Rarity] or 0
		local v22 = { r1, r2 }
        if v19[1] == "DefaultKnife" then
            return true;
        elseif v19[2] == "DefaultKnife" then
            return false;
        elseif v19[1] == "DefaultGun" then
            return true;
        elseif v19[2] == "DefaultGun" then
            return false;
        elseif v22[1] ~= v22[2] then
            return v22[1] > v22[2];
        elseif v20[1] ~= v20[2] then
            return v20[1] > v20[2];
        else
            return v21[1].ItemName < v21[2].ItemName;
        end;
    end);
    return v14;
end;
v0.CreateFrame = function(v23, v24, v25, v26, _, v28, _, v30) --[[ Line: 84 ]]
    local v31 = v26:Clone();
    v31.Name = v30 or v24.ID or v24.ItemID or tostring(v26.Name .. v28);
    v25(v31, v24, v23);
    return v31;
end;
v0.CreateGrid = function(v32, v33, v34, v35) --[[ Line: 98 ]]
    local v36 = 0;
    local l_Container_0 = v35.Container;
    local l_Scale_0 = v33.Size.X.Scale;
    local v39 = nil;
    l_Container_0:ClearAllChildren();
    for v40, v41 in pairs(v34) do
        local v42 = true;
        if v41.ItemID ~= "DefaultKnife" then
            v42 = v41.ItemID == "DefaultGun";
        end;
        if not v42 then
            local v43 = math.floor(v36 / math.floor(1 / l_Scale_0));
            local v44 = v36 % math.floor(1 / l_Scale_0);
            local v45 = v0.CreateFrame(v40, v41, v32, v33, v35, v36, v43);
            v45.Parent = l_Container_0;
            if not v39 then
                v39 = v45.AbsoluteSize;
            end;
            v45.Position = UDim2.new(l_Scale_0 * v44, 0, 0, v39.Y * v43);
            if v35:IsA("ScrollingFrame") then
                v35.CanvasSize = UDim2.new(0, 0, 0, (v43 + 1) * v39.Y);
            end;
            v36 = v36 + 1;
        end;
    end;
end;
v0.CreateList = function(v46, v47, v48, v49) --[[ Line: 131 ]]
    local v50 = 0;
    local l_Container_1 = v49.Container;
    l_Container_1:ClearAllChildren();
    for v52, v53 in v48 do
        local v54 = math.floor(v50 / 1);
        local v55 = v0.CreateFrame(v52, v53, v46, v47, v49, v50, v54);
        v55.Parent = l_Container_1;
        v55.Position = UDim2.new(0, 0, 0, v55.AbsoluteSize.Y * v54);
        v49.CanvasSize = UDim2.new(0, 0, 0, (v54 + 1) * v55.AbsoluteSize.Y);
        v50 = v50 + 1;
    end;
end;
v0.CreatePass = function(v56, v57, v58, v59, v60) --[[ Line: 151 ]]
    local v61 = 0;
    for v62 = 1, v58.TotalTiers do
        local v63 = tostring(v62);
        local v64 = math.floor(v61 / 5);
        local v65 = v61 % 5;
        local l_v59_FirstChild_0 = v59:FindFirstChild("Page" .. v64);
        if not l_v59_FirstChild_0 then
            l_v59_FirstChild_0 = v60:Clone();
            l_v59_FirstChild_0.Name = "Page" .. v64;
            l_v59_FirstChild_0.Parent = v59;
        end;
        local v67 = v58.Rewards[v63] or {};
        local l_l_v59_FirstChild_0_FirstChild_0 = l_v59_FirstChild_0:FindFirstChild("Tier" .. v63);
        if not l_l_v59_FirstChild_0_FirstChild_0 then
            local v69 = v0.CreateFrame(v62, v67, v56, v57, nil, v65, nil, "Tier" .. v63);
            v69.Parent = l_v59_FirstChild_0;
            v69.Position = UDim2.new(0, v69.AbsoluteSize.X * v65, 0, 0);
        else
            v56(l_l_v59_FirstChild_0_FirstChild_0, v67, v62);
        end;
        v61 = v61 + 1;
    end;
end;
v0.MakeItemFrame = function(v70, v71, v72) --[[ Line: 188 ]]
    local l_ItemID_0 = v71.ItemID;
    local l_Amount_0 = v71.Amount;
    if v70:FindFirstChild("Container") then
        v70 = v70.Container;
    end;
    local v75 = v70.Icon:FindFirstChild("ItemName") or v70.ItemName;
    local v76 = (l_Sync_0[v71.ItemType] or l_Sync_0.Item)[l_ItemID_0] or l_ItemID_0 or {
        Image = "", 
        ItemName = "", 
        Rarity = "Common"
    };
    local l_Icon_0 = v70.Icon;
    local l_Image_0 = v76.Image;
    local v79;
    if _G.Cache[l_Image_0] ~= nil then
        v79 = _G.Cache[l_Image_0];
    else
        local v80 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[l_Image_0] = v80;
        v79 = v80;
    end;
    l_Icon_0.Image = v79;
    v75.Text = v76.ItemName or v76.Name;
    v75.TextColor3 = l_Rarity_0[v76.Rarity or "Common"];
    if l_Amount_0 then
        v70.Rarity.Text = v76.Rarity;
        v70.Rarity.TextColor3 = l_Rarity_0[v76.Rarity];
        v70.Year.Text = v76.Year or "";
        v70.Event.Text = v76.Event or "";
        v70.Event.TextColor3 = v76.Event and l_Rarity_0[v76.Event] or Color3.new();
        if l_Amount_0 > 1 then
            v70.Amount.Text = "x" .. math.floor(l_Amount_0);
        end;
        if v72 == nil then
            v70.MouseEnter:connect(function() --[[ Line: 216 ]]
                v70.Rarity.Visible = true;
                v70.Year.Visible = true;
                v70.Event.Visible = true;
            end);
            v70.MouseLeave:connect(function() --[[ Line: 217 ]]
                v70.Rarity.Visible = false;
                v70.Year.Visible = false;
                v70.Event.Visible = false;
            end);
        end;
    end;
end;
v0.Commafy = function(v81) --[[ Line: 228 ]]
    local l_v81_0 = v81;
    repeat
        local v83, v84 = string.gsub(l_v81_0, "^(-?%d+)(%d%d%d)", "%1,%2");
        k = v84;
        l_v81_0 = v83;
    until k == 0;
    return l_v81_0;
end;
v0.Pluralize = function(v85, v86) --[[ Line: 239 ]]
    if v85 == 1 then
        return v86;
    else
        return v86 .. "s";
    end;
end;
v0.ConvertTimestamp = function(v87) --[[ Line: 247 ]]
    local v88 = math.floor(v87 / 86400);
    local v89 = math.floor(v87 % 86400 / 3600);
    local v90 = v88 .. "d, " .. v89 .. "h";
    if v88 < 1 then
        v90 = v89 .. "h";
        if v89 == 1 then
            v90 = "Less than 2 hours";
        end;
    end;
    if v87 <= 3600 then
        v90 = "Less than 1 hour!";
    end;
    if v87 <= 0 then
        v90 = "ENDED!";
    end;
    return v90;
end;
return v0;