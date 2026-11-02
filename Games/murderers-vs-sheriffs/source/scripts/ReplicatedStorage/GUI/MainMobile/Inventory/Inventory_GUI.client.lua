-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_Inventory_0 = l_Parent_0.Lobby.Screens.Inventory;
local l_Nav_0 = l_Inventory_0.Nav;
local l_Main_0 = l_Inventory_0.Main;
local _ = l_Parent_0.Lobby.Dock;
local _ = {
    "Weapons", 
    "Effects", 
    "Perks", 
    "Emotes", 
    "Radios", 
    "Toys", 
    "Pets",
	"Outfits"
};
local v6 = false;
local l_Weapons_0 = l_Inventory_0.Main.Weapons;
local l_Actions_0 = l_Weapons_0.Actions;
local l_Equipped_0 = l_Weapons_0.Equipped;
local l_Items_0 = l_Weapons_0.Items;
local _ = l_Actions_0.ActionContainer.Craft;
local l_Equip_0 = l_Actions_0.Equip;
local l_Craft_1 = l_Actions_0.Craft;
local l_Recycle_0 = l_Actions_0.Recycle;
local _ = {
    [l_Items_0] = {
        [l_Equip_0] = {
            Size = l_Items_0.Size, 
            Position = l_Items_0.Position
        }, 
        [l_Craft_1] = {
            Size = UDim2.new(0, -427, 1, -155), 
            Position = l_Items_0.Position
        }, 
        [l_Recycle_0] = {
            Size = UDim2.new(0, -427, 1, -200), 
            Position = l_Items_0.Position
        }
    }, 
    [l_Actions_0] = {
        [l_Equip_0] = {
            Size = l_Actions_0.Size, 
            Position = l_Actions_0.Position
        }, 
        [l_Craft_1] = {
            Size = UDim2.new(1, 0, 0, 160), 
            Position = UDim2.new(0, 0, 1, -160)
        }, 
        [l_Recycle_0] = {
            Size = UDim2.new(1, 0, 0, 205), 
            Position = UDim2.new(0, 0, 1, -205)
        }
    }, 
    [l_Equipped_0] = {
        [l_Equip_0] = {
            Size = l_Equipped_0.Size, 
            Position = l_Equipped_0.Position
        }, 
        [l_Craft_1] = {
            Size = UDim2.new(0, 130, 1, -155), 
            Position = UDim2.new(1, 0, 0, 0)
        }, 
        [l_Recycle_0] = {
            Size = UDim2.new(0, 130, 1, -200), 
            Position = l_Equipped_0.Position
        }
    }
};
for _, v17 in pairs(l_Nav_0.Main:GetChildren()) do
    if v17:IsA("TextButton") then
        v17.MouseButton1Click:connect(function()
            if not v6 then
                v6 = true;
                l_Nav_0:TweenPosition(UDim2.new(-1, 0, 0, 0), "Out", "Quad", 0.2);
                l_Main_0[v17.Name]:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
                wait(0.2);
                v6 = false;
            end;
        end);
    end;
end;
for _, v19 in pairs(l_Main_0:GetChildren()) do
    local v20 = v19:FindFirstChild("Back") or v19:FindFirstChild("TitleBar") and (v19.TitleBar:FindFirstChild("Back") or v19.TitleBar.Container:FindFirstChild("Back"));
    if v20 then
        v20.MouseButton1Click:connect(function()
            if not v6 then
                v6 = true;
                l_Nav_0:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
                l_Main_0[v19.Name]:TweenPosition(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2);
                wait(0.2);
                v6 = false;
            end;
        end);
    end;
end;
l_Main_0.Radios.Equipped.Container.Songs.MouseButton1Click:connect(function()
    l_Main_0.Radios:TweenPosition(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0);
    l_Main_0.Songs:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0);
end);