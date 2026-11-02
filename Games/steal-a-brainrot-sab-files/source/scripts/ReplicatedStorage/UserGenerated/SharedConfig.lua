

--!native
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local l_UGApp_0 = l_ReplicatedStorage_0:WaitForChild("UGApp");
local v3 = {};
for v4, v5 in pairs(l_UGApp_0:GetAttributes()) do
    v3[v4] = v5;
    l_UGApp_0:SetAttribute(v4, nil);
end;
local function _(v6, v7)
    return v7(v3[v6]);
end;
local l_GameId_0 = game.GameId;
local l_PlaceId_0 = game.PlaceId;
return table.freeze({
    GameId = l_GameId_0, 
    PlaceId = l_PlaceId_0, 
    ClientMajorVersion = 2, 
    ClientMinorVersion = 2, 
    ClientVersion = 131074
});