-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

if task then
    return {
        spawn = task.spawn,
        wait = task.wait,
        cancel = task.cancel,
        step = function() -- step | line 10
        end
    }
end
return require("../test/task")
