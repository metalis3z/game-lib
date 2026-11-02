-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_ContextActionService_0 = game:GetService("ContextActionService");
v0.Bind = function(v2, v3, v4) --[[ Line: 5 ]]
    l_ContextActionService_0:BindAction(v2, function(_, v6) --[[ Line: 6 ]]
        if v6 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v4();
        end;
    end, false, v3);
end;
v0.Unbind = function(v7, _, _) --[[ Line: 14 ]]
    l_ContextActionService_0:UnbindAction(v7);
end;
return v0;