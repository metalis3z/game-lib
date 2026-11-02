-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_ContentProvider_0 = game:GetService("ContentProvider");
local v1 = {};
local v2 = "http://www.roblox.com/Thumbs/Avatar.ashx?x=" .. 250 .. "&y=" .. 250 .. "&Format=Png&userId=";
local v3 = "http://www.roblox.com/Thumbs/Avatar.ashx?x=" .. 250 .. "&y=" .. 250 .. "&Format=Png&username=";
local v4 = Instance.new("BindableFunction", game.ReplicatedStorage);
v4.Name = "GetPlayerImage";
local function v8(v5)
    for v6, v7 in pairs(v1) do
        if v7.Name == v5 or v7.userId == tostring(v5) then
            return v7.Image, v6;
        end;
    end;
    if tonumber(v5) then
        return v2 .. v5, nil;
    else
        return v3 .. v5, nil;
    end;
end;
v4.OnInvoke = v8;
local function v12(v9)
    if v9:IsA("Player") then
        local v10 = v9.Name:find("Guest ") and v2 .. "1" or v9.userId < 1 and v2 .. "1" or v2 .. v9.userId;
        l_ContentProvider_0:Preload(v10);
        local v11 = v10 .. "&bust=" .. math.floor((tick()));
        table.insert(v1, {
            Name = v9.Name, 
            userId = tostring(v9.userId), 
            RawImage = v10, 
            Image = v11
        });
    end;
end;
game.Players.ChildAdded:connect(v12);
game.Players.ChildRemoved:connect(function(v13)
    local _, v15 = v8(v13.Name);
    if v15 then
        table.remove(v1, v15);
    end;
end);
for _, v17 in pairs(game.Players:GetPlayers()) do
    v12(v17);
end;