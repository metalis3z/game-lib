-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {
    normal = "rbxassetid://3150319038", 
    christmas = "rbxassetid://4521639303", 
    halloween = "http://www.roblox.com/asset/?id=15056209964", 
    valentines = "http://www.roblox.com/asset/?id=12349622103", 
    easter = "http://www.roblox.com/asset/?id=12966773156"
};
local l_CoinIcon_0 = script.Parent.CoinIcon;
if workspace:GetAttribute("isChristmas") then
    l_CoinIcon_0.Image = v0.christmas;
    return;
elseif workspace:GetAttribute("isValentines") then
    l_CoinIcon_0.Image = v0.valentines;
    return;
elseif workspace:GetAttribute("isEaster") then
    l_CoinIcon_0.Image = v0.easter;
    return;
elseif workspace:GetAttribute("isHalloween") then
    l_CoinIcon_0.Image = v0.halloween;
    return;
else
    l_CoinIcon_0.Image = v0.normal;
    return;
end;