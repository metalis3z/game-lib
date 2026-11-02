-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_ShopFrame_0 = require(script.Parent.Parent:WaitForChild("Handlers"):WaitForChild("ShopFrame"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = l_Knit_0.CreateController({
    Name = "ShopFrameController"
});
v5.KnitInit = function(v6) --[[ Line: 13 ]] --[[ Name: KnitInit ]]
    v6.PlayerGui = nil;
    v6.ShopFrameGui = nil;
    v6.ShopFrameObject = nil;
end;
v5.KnitStart = function(v7) --[[ Line: 19 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v7.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v7:_initShopFrame();
end;
v5._findShopFrame = function(v8) --[[ Line: 24 ]] --[[ Name: _findShopFrame ]]
    local l_ScreenFrames_0 = v8.PlayerGui:FindFirstChild("ScreenFrames");
    if not l_ScreenFrames_0 then
        return nil;
    else
        local l_ShopFrame_1 = l_ScreenFrames_0:FindFirstChild("ShopFrame");
        if l_ShopFrame_1 and l_ShopFrame_1:IsA("Frame") then
            return l_ShopFrame_1;
        else
            return nil;
        end;
    end;
end;
v5._initShopFrame = function(v11) --[[ Line: 38 ]] --[[ Name: _initShopFrame ]]
    -- upvalues: l_ShopFrame_0 (copy)
    local v12 = v11:_findShopFrame();
    if not v12 then
        warn("[ShopFrameController] Could not find PlayerGui.ScreenFrames.ShopFrame");
        return;
    else
        v11.ShopFrameGui = v12;
        if v11.ShopFrameObject then
            v11.ShopFrameObject:Destroy();
            v11.ShopFrameObject = nil;
        end;
        v11.ShopFrameObject = l_ShopFrame_0.new(v12);
        v11.ShopFrameObject:Init();
        return;
    end;
end;
v5.GetShopFrameObject = function(v13) --[[ Line: 56 ]] --[[ Name: GetShopFrameObject ]]
    return v13.ShopFrameObject;
end;
return v5;