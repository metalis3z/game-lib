-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 10
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = {};
    v2:_Init();

    return v2;
end;

function u1._ObjectRemoved(p3, p4) -- Line: 30
    if p3._connections[p4] then
        p3._connections[p4]:Disconnect();
        p3._connections[p4] = nil;
    end;
end;

function u1._ObjectAdded(p5, u6) -- Line: 37
    -- upvalues: Pages (copy)
    p5:_ObjectRemoved(u6);
    p5._connections[u6] = u6.Triggered:Connect(function() -- Line: 40
        -- upvalues: Pages (ref), u6 (copy)
        wait(0.06);
        Pages.PageSystem:OpenPage(u6:GetAttribute("PageName"), true);
        local Attribute = u6:GetAttribute("ShopViewBundleName");
        local Attribute2 = u6:GetAttribute("ShopViewShopEntryName");

        if Attribute then
            local v7;

            if #Attribute >= 9 and string.sub(Attribute, 1, 9) == "keybundle" then
                v7 = true;
            elseif #Attribute >= 19 then
                v7 = string.sub(Attribute, 1, 19) == "eventcurrencybundle";
            else
                v7 = false;
            end;

            Pages.PageSystem:WaitForPage("Shop"):SetPage(v7 and "Currency" or "Bundles");
            Pages.PageSystem:WaitForPage("Shop"):InspectBundle(Attribute);
        elseif Attribute2 then
            Pages.PageSystem:WaitForPage("Shop"):SetPage("Home");
            Pages.PageSystem:WaitForPage("Shop"):InspectShopEntry(Attribute2);
        end;

        local Attribute3 = u6:GetAttribute("ShopViewPage");

        if Attribute3 then
            Pages.PageSystem:WaitForPage("Shop"):SetPage(Attribute3);
        end;

        local Attribute4 = u6:GetAttribute("DialogLobbyNPCName");

        if Attribute4 then
            Pages.PageSystem:WaitForPage("DialogLobby"):SetNPCName(Attribute4);
        end;

        local Attribute5 = u6:GetAttribute("MatchmakingScrollTo");

        if Attribute5 then
            Pages.PageSystem:WaitForPage("Matchmaking"):ScrollTo(Attribute5, 0.25);
        end;

        local Attribute6 = u6:GetAttribute("InspectUGC");

        if Attribute6 then
            Pages.PageSystem:WaitForPage("UGCShop"):Buy(Attribute6);
        end;

        local Attribute7 = u6:GetAttribute("TasksScrollTo");

        if Attribute7 then
            Pages.PageSystem:WaitForPage("Tasks"):ScrollTo(Attribute7, 0.25);
        end;
    end);
end;

function u1._Init(u8) -- Line: 90
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyOpenPagePrompt"):Connect(function(p9) -- Line: 91
        -- upvalues: u8 (copy)
        u8:_ObjectAdded(p9);
    end);
    CollectionService:GetInstanceRemovedSignal("LobbyOpenPagePrompt"):Connect(function(p10) -- Line: 95
        -- upvalues: u8 (copy)
        u8:_ObjectRemoved(p10);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyOpenPagePrompt")) do
        task.spawn(u8._ObjectAdded, u8, v);
    end;
end;

return u1._new();