-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseUpgradeTransitionLifecycle = require(ReplicatedStorage.Client.BaseUpgradeTransitionLifecycle)
local Audio = require(ReplicatedStorage.Shared.Audio)
local v1 = {
    soundId = 76223608697985,
    volume = 1.5,
    pitchRange = { 0.9, 1.1 }
}
return function(v2) -- line 14 | captures: BaseUpgradeTransitionLifecycle, Audio, v1
    local v3 = workspace.CurrentCamera ~= nil
    assert(v3, "no render camera is bound on this client")
    BaseUpgradeTransitionLifecycle.Begin()
    Audio.Play(v1.soundId, script, {
        PlaybackSpeed = v1.pitchRange,
        Volume = v1.volume
    })
    task.spawn(v2)
    BaseUpgradeTransitionLifecycle.Complete()
end
