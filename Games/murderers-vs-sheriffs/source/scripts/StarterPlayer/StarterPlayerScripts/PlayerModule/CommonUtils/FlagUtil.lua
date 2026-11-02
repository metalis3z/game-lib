-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    getUserFlag = function(v0)
        local l_status_0, l_result_0 = pcall(function()
            return UserSettings():IsUserFeatureEnabled(v0);
        end);
        return l_status_0 and l_result_0;
    end
};