local Animation = {}

local Players = game:GetService("Players")

function Animation.LoadAnimations(data)
    local t = {}
    for i, v in pairs(data) do
        if v then
            local id = v.Id or v.ID
            local anim = Instance.new("Animation", Players.LocalPlayer.Character.Humanoid)
            anim.AnimationId = id -- Old text said i=d (it was changed to "Id" because it was expected than we accidently changed it to an incorrect word - note by toastdub)
            anim.Name = i
            local track = Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            t[i] = track
        end
    end
    return t
end
function Animation.Play(anims, name, ...)
    local anim = anims[name]
    if anim ~= nil and anim.IsPlaying == false then
        anim:Play(...)
    end
end
function Animation.Stop(anims, name, ...)
    local anim = anims[name]
    if anim ~= nil and anim.IsPlaying == true then
        anim:Stop(...)
    end
end
function Animation.StopAllAnimations()
    for i, v in pairs(Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
        if v and v.IsPlaying == true  and not v.Name == "HandOut" then
            v:Stop()
        end
    end
end
function Animation.StopAnimationsFromTable(t)
    for i, v in pairs(t) do
        if v and not v.Name == "HandOut" then
            Animation.Stop(t, i)
        end
    end
end

return Animation
