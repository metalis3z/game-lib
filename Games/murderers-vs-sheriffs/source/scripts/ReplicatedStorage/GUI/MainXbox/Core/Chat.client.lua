-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent.Parent;
local _ = l_Parent_0.Parent;
local l_Chat_0 = l_Parent_0.Chat;
local l_Container_0 = l_Parent_0.Chat.Container;
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local _ = l_Sync_0.Item;
local _ = l_Sync_0.Item;
local v8 = nil;
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = script.Parent.Parent;
local _ = function(v11, v12, v13)
    l_ContextActionService_0:BindAction(v11, function(_, v15)
        if v15 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v13();
        end;
    end, false, v12);
end;
local _ = function(v17, _, _)
    l_ContextActionService_0:UnbindAction(v17);
end;
if not _G.ChatTable then
    _G.ChatTable = {};
end;
local function v27(v21, v22, v23)
    local _, _, v26 = game.ReplicatedStorage.Remotes.Extras.GetPlayerLevel:InvokeServer(v21);
    table.insert(_G.ChatTable, 1, {
        PlayerName = v21 == "Server" and "Server" or (v26 and "[ELITE] " or "") .. v21.Name, 
        Message = v22, 
        Server = v21 == "Server", 
        Item = v23 and v23.ItemName or nil, 
        Color = v26 and Color3.new(0.9098039215686274, 0.16470588235294117, 0.16470588235294117) or Color3.new(0.9019607843137255, 0.9019607843137255, 0.9019607843137255), 
        RarityColor = v23 and v23.RarityColor or nil
    });
    table.remove(_G.ChatTable, 9);
    v8();
end;
local v28 = nil;
local v29 = nil;
game.ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:connect(function(_, v31, v32)
    v28 = v31;
    v29 = v32;
end);
l_LocalPlayer_0.Chatted:connect(function(v33)
    v27(l_LocalPlayer_0, v33, nil, v28, v29);
end);
_G.Chatted = v27;
local v34 = Color3.new(0.8, 0.8, 0.8);
v8 = function()
    l_Container_0:ClearAllChildren();
    for v35, v36 in pairs(_G.ChatTable) do
        local v37 = script:WaitForChild("ChatMessage"):Clone();
        v37.Parent = l_Container_0;
        if not v36.Server then
            v37.Message.Text = v36.Message;
            v37.PlayerName.Text = v36.PlayerName .. ": ";
            v37.PlayerName.TextColor3 = v36.Color;
        else
            v37.PlayerName.Font = Enum.Font.SourceSansItalic;
            v37.PlayerName.TextColor3 = v34;
            if v36.Item then
                v37.Message.Font = Enum.Font.SourceSansBold;
                v37.PlayerName.Text = v36.Message .. " ";
                v37.Message.Text = v36.Item;
                v37.Message.TextColor3 = v36.RarityColor;
            else
                v37.PlayerName.Text = v36.Message;
                v37.Message.Text = "";
            end;
        end;
        v37.Message.Position = UDim2.new(0, v37.PlayerName.TextBounds.X + 10, 0, 3);
        v37.Position = UDim2.new(0, 0, 0.125 * (8 - v35), 0);
    end;
end;
v8();
local function _()
    l_Chat_0.ChatBox:CaptureFocus();
end;
local v39 = {
    "\n", 
    "\r", 
    "\t", 
    "\v", 
    "\f"
};
local function v42(v40)
    v40 = string.sub(v40, 1, 200);
    if v40 ~= "" then
        if v39 then
            for v41 = 1, #v39 do
                if v39[v41] == "\t" then
                    v40 = string.gsub(v40, v39[v41], " ");
                else
                    v40 = string.gsub(v40, v39[v41], "");
                end;
            end;
        end;
        v40 = string.gsub(v40, "\n", "");
        v40 = string.gsub(v40, "[ ]+", " ");
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(v40, "normalchat", true);
    end;
end;
l_Chat_0.ChatBox.FocusLost:connect(function(v43, v44)
    if v43 then
        v42(l_Chat_0.ChatBox.Text);
        v27(l_LocalPlayer_0, l_Chat_0.ChatBox.Text);
        return;
    else
        if v44.KeyCode ~= Enum.KeyCode.ButtonB then
            v42(l_Chat_0.ChatBox.Text);
            v27(l_LocalPlayer_0, l_Chat_0.ChatBox.Text);
        end;
        return;
    end;
end);