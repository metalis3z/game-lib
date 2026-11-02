-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = {
    ButtonA = true, 
    ButtonB = true, 
    ButtonX = true, 
    ButtonY = true, 
    ButtonL1 = true, 
    ButtonL2 = true, 
    ButtonR1 = true, 
    ButtonR2 = true, 
    ButtonSelect = true
};
local v3 = {
    ButtonA = "http://www.roblox.com/asset/?id=15026911220", 
    ButtonCross = "http://www.roblox.com/asset/?id=15026902225", 
    ButtonB = "http://www.roblox.com/asset/?id=15026912025", 
    ButtonCircle = "http://www.roblox.com/asset/?id=15026903433", 
    ButtonX = "http://www.roblox.com/asset/?id=15026867363", 
    ButtonSquare = "http://www.roblox.com/asset/?id=15026893733", 
    ButtonY = "http://www.roblox.com/asset/?id=15026912593", 
    ButtonTriangle = "http://www.roblox.com/asset/?id=15026902848", 
    ButtonLB = "http://www.roblox.com/asset/?id=15027131598", 
    ButtonL1 = "http://www.roblox.com/asset/?id=15027138014", 
    ButtonLT = "http://www.roblox.com/asset/?id=15027130434", 
    ButtonL2 = "http://www.roblox.com/asset/?id=15027139880", 
    ButtonRB = "http://www.roblox.com/asset/?id=15027131051", 
    ButtonR1 = "http://www.roblox.com/asset/?id=15027138772", 
    ButtonRT = "http://www.roblox.com/asset/?id=15027129964", 
    ButtonR2 = "http://www.roblox.com/asset/?id=15027140259", 
    ButtonSelect = "http://www.roblox.com/asset/?id=285737050", 
    ButtonShare = "http://www.roblox.com/asset/?id=15027162581", 
    ButtonTouchpad = "http://www.roblox.com/asset/?id=15027162581"
};
_G.GetButtonIcon = function(v4)
    return v3[l_UserInputService_0:GetStringForKeyCode(v4)];
end;
local function v11()
    for v5, _ in pairs(v2) do
        local v7 = "ButtonIcon_" .. v5;
        local v8 = v3[l_UserInputService_0:GetStringForKeyCode(v5)];
        for _, v10 in pairs(l_CollectionService_0:GetTagged(v7)) do
            v10.Image = v8;
        end;
    end;
end;
while true do
    wait();
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI") then
        break;
    end;
end;
v11();