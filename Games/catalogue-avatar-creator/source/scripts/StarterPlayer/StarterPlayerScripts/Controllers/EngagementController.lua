-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local StarterGui = game:GetService("StarterGui");
local AvatarEditorService = game:GetService("AvatarEditorService");
local Events = script.Parent.Parent:WaitForChild("Events");
local GroupMembershipController = require(script.Parent:WaitForChild("GroupMembershipController"));
task.delay(400, function() -- Line: 13
    -- upvalues: StarterGui (copy)
    StarterGui:SetCore(
        "SendNotification",
        {
            Title = "Having fun?",
            Text = "👍 Like the game to help us improve!",
            Icon = "rbxassetid://139110315298483",
            Duration = 15,
            Button1 = "Okay"
        }
    );
end);
task.delay(300, function() -- Line: 23
    -- upvalues: AvatarEditorService (copy), Events (copy), StarterGui (copy)
    local BindableFunction = Instance.new("BindableFunction");

    function BindableFunction.OnInvoke(p1) -- Line: 26
        -- upvalues: AvatarEditorService (ref), Events (ref)
        if p1 == "Yes" then
            AvatarEditorService:PromptSetFavorite(77187847593796, 1, true);
            AvatarEditorService.PromptSetFavoriteCompleted:Once(function(p2) -- Line: 30
                -- upvalues: Events (ref)
                if p2 == Enum.AvatarPromptResult.Success then
                    Events.Notify:Fire("⭐ Thank you for supporting our game!");
                    Events.Notify:Fire("👍 Please like the game to help it become even better.");
                end;
            end);
        end;
    end;

    StarterGui:SetCore("SendNotification", {
        Title = "Enjoying your stay?",
        Text = "⭐ Would you like to favorite the game?",
        Icon = "rbxassetid://139110315298483",
        Duration = 30,
        Button1 = "Yes",
        Button2 = "No",
        Callback = BindableFunction
    });
end);
task.delay(480, function() -- Line: 50
    -- upvalues: GroupMembershipController (copy), Events (copy), StarterGui (copy)
    if GroupMembershipController.IsJoined() then
        return;
    end;

    local BindableFunction = Instance.new("BindableFunction");

    function BindableFunction.OnInvoke(p3) -- Line: 57
        -- upvalues: GroupMembershipController (ref), Events (ref)
        if p3 == "Yes" then
            local v4, v5 = GroupMembershipController.PromptJoin();

            if v4 and v5 == Enum.GroupMembershipStatus.Joined then
                Events.Notify:Fire("⭐ Thank you for joining our group!");
                Events.Notify:Fire("👍 Please like the game to help it become even better.");
            end;
        end;
    end;

    StarterGui:SetCore("SendNotification", {
        Title = "Join our community!",
        Text = "Would you like to join our Roblox group?",
        Icon = "rbxassetid://139110315298483",
        Duration = 30,
        Button1 = "Yes",
        Button2 = "No",
        Callback = BindableFunction
    });
end);

return {};