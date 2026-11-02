-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("TweenService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v9 = require(l_Packages_0.Net);
local v10 = require(l_Packages_0.Trove);
local v11 = require(l_Controllers_0.InterfaceController);
local _ = require(l_Controllers_0.CameraController);
local v13 = require(l_Classes_0.AnimatedButton);
local v14 = require(l_Packages_0.Synchronizer);
local v15 = require(l_Utils_0.NumberUtils);
local v16 = require(l_Datas_0.ShopItems);
local v17 = require(l_Controllers_0.NotificationController);
local v18 = require(l_Controllers_0.SoundController);
local v19 = require(l_Shared_0.Updates);
local v20 = v9:RemoteFunction("CoinsShopService/RequestBuy");
local v21 = v9:RemoteFunction("CoinsShopService/ToggleAutoBuy");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v24 = {};
local v25 = nil;
local l_CoinsShop_0 = l_PlayerGui_0:WaitForChild("CoinsShop"):WaitForChild("CoinsShop");
local l_Items_0 = l_CoinsShop_0.Content.Items;
local l_Template_0 = l_Items_0.Template;
local l_Close_0 = l_CoinsShop_0.Header.Close;
local v30 = nil;
local v31 = v10.new();
local v32 = {};
local function v60(v33, v34)
    v31:Destroy();
    if #l_Items_0:GetChildren() >= 1 then
        for _, v36 in ipairs(l_Items_0:GetChildren()) do
            if v36.Name ~= "Template" and v36:IsA("ImageLabel") then
                v36:Destroy();
            end;
        end;
    end;
    for v37, v38 in pairs(v16) do
        if v38.Currency == "Coins" then
            local v39 = l_Template_0:Clone();
            local l_ItemInformation_0 = v39.ItemInformation;
            local l_ItemName_0 = l_ItemInformation_0.ItemName;
            local l_ItemDescription_0 = l_ItemInformation_0.ItemDescription;
            local l_ItemImage_0 = v39.ItemImage;
            local l_Buy_0 = v39.Buy;
            local l_Auto_0 = v39.Auto;
            local _ = v39.AutoLabel;
            local l_Price_0 = l_Buy_0.Price;
            local l_Locked_0 = v39.Locked;
            local l_Txt_0 = l_Locked_0.Txt;
            v39.Name = v37;
            l_ItemName_0.Text = v37;
            l_ItemDescription_0.Text = v38.Description;
            l_ItemImage_0.Image = v38.Icon;
            l_Price_0.Text = v24[v37] and "OWNED" or "$ " .. v15:ToString(v38.Price, 2);
            v39.LayoutOrder = v38.LayoutOrder or 0;
            local v50 = false;
            if v37 == "Trap" then
                v50 = (l_LocalPlayer_0:GetAttribute("TrapCount") or 0) < 5;
                l_Price_0.Text = v50 and "$ " .. v15:ToString(v38.Price, 2) or "OWNED";
            else
                local v51 = false;
                if v38.Price <= v34 then
                    v51 = not v24[v37];
                end;
                v50 = v51;
            end;
            if v38.RebirthRequired then
                if v38.RebirthRequired <= v33 then
                    l_Locked_0.Visible = false;
                else
                    l_Txt_0.Text = "YOU NEED " .. v38.RebirthRequired .. " REBIRTHS";
                    l_Buy_0.Visible = false;
                end;
            else
                l_Locked_0.Visible = false;
                l_Txt_0.Visible = false;
            end;
            l_Auto_0.Visible = v50;
            local v52 = v13.new(l_Auto_0);
            v52:Animate();
            v52.OnActivated:Connect(function()
                local v53, v54 = v21:InvokeServer(v37);
                if not v53 then
                    if v54 then
                        v17:Error(v54);
                    end;
                    v18:PlaySound("Sounds.Sfx.Error");
                end;
            end);
            l_Auto_0.Yes.Visible = v25:Get((("AutoBuy.%*"):format(v37))) == true;
            v31:Add(v25:OnChanged(("AutoBuy.%*"):format(v37), function(v55)
                l_Auto_0.Yes.Visible = v55 == true;
            end));
            if v50 then
                local v56 = v13.new(l_Buy_0);
                v56:Animate();
                v56.OnActivated:Connect(function()
                    local v57, v58 = v20:InvokeServer(v37);
                    if v57 then
                        v17:Success(v58);
                        v18:PlaySound("Sounds.Sfx.Success");
                        v24[v37] = (v24[v37] or 0) + 1;
                        return;
                    else
                        v17:Error(v58);
                        v18:PlaySound("Sounds.Sfx.Error");
                        return;
                    end;
                end);
            else
                l_Buy_0.ImageColor3 = Color3.fromRGB(138, 138, 138);
            end;
            local _ = nil;
            v39.Visible = not v38.IsEnabled or v38.IsEnabled();
            v39.Parent = l_Items_0;
        end;
    end;
end;
v32.Start = function(_)
    local v62 = 0;
    local v63 = 0;
    v30 = v11:Register("CoinsShop", l_CoinsShop_0, "TopQuint");
    v30:AttachCloseButton(l_Close_0);
    v30:Close();
    v14:WaitAndCall(l_LocalPlayer_0, function(v64)
        v25 = v64;
        v64:OnChanged("Rebirth", function(v65)
            v62 = v65;
            v60(v62, v63);
        end, true);
        v64:OnChanged("Coins", function(v66)
            v63 = v66;
            v60(v62, v63);
        end, true);
        v19.OnUpdateEnabled:Connect(function()
            v60(v62, v63);
        end);
        v19.OnUpdateDisabled:Connect(function()
            v60(v62, v63);
        end);
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("TrapCount"):Connect(function()
        if not v25 then
            return;
        else
            v60(v62, v63);
            return;
        end;
    end);
end;
return v32;