-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "currentTreadmillMedia",
    Description = "Print the media key and asset IDs of the treadmill or phone media currently playing for you",
    Group = "Moderator",
    Aliases = { "curVid", "curVideo" },
    Args = {},
    ClientRun = function(v1) -- ClientRun | line 12
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
        local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
        local v2 = TreadmillVideoController.GetActiveMediaEntry()
        if v2 == nil then
            local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local v3
            if PlayerGui == nil then
            else
                v3 = PlayerGui:FindFirstChild("PhoneVideoUI")
            end
            local v4
            if v3 ~= nil and v3:IsA("ScreenGui") and v3.Enabled then
                local Phone = v3:FindFirstChild("Phone")
                local v5
                if Phone == nil then
                else
                    v5 = Phone:FindFirstChild("MainVideo", true)
                end
                if v5 ~= nil and v5:IsA("VideoFrame") and v5.Video ~= "" then
                    v4 = string.match(v5.Video, "%d+")
                end
            end
            if v4 == nil then
                if v2 == nil then
                    return "No media is currently playing (run on a treadmill or open the phone first)"
                end
                local v6 = {}
                v6[1] = ("Key: %* (%*)"):format(TreadmillMediaIdentity.GetMediaKey(v2), "Treadmill")
                v6[2] = ("Kind: %* | Bucket: %* | Release: %*"):format(v2.Kind, v2.BucketType, v2.ReleaseVersion)
                if v2.Kind == "Video" then
                    local v7 = ("Video: %*"):format(v2.Video)
                    table.insert(v6, v7)
                    local v8 = ("Cover: %*"):format(v2.CoverImage or "(none)")
                    table.insert(v6, v8)
                    local Music = v2.Music
                    if Music ~= nil then
                        local v9 = ("Music: %*"):format(Music.SoundId)
                        table.insert(v6, v9)
                    end
                else
                    local v10 = ("Image: %*"):format(v2.Image)
                    table.insert(v6, v10)
                    local v11 = ("Sound: %*"):format(v2.SoundId)
                    table.insert(v6, v11)
                end
                local v12 = table.concat(v6, "\n")
                print((("[currentTreadmillMedia]\n%*"):format(v12)))
                return v12
            end
            local v13 = TreadmillVideoController.GetMediaEntryByKey((("Video:%*"):format(v4)))
            if v13 == nil then
                local v14 = ("Video: %* (Phone, no matching media entry)"):format(v4)
                print((("[currentTreadmillMedia] %*"):format(v14)))
                return v14
            end
            local v15 = {}
            v15[1] = ("Key: %* (%*)"):format(TreadmillMediaIdentity.GetMediaKey(v13), "Phone")
            v15[2] = ("Kind: %* | Bucket: %* | Release: %*"):format(v13.Kind, v13.BucketType, v13.ReleaseVersion)
            if v13.Kind == "Video" then
                local v16 = ("Video: %*"):format(v13.Video)
                table.insert(v15, v16)
                local v17 = ("Cover: %*"):format(v13.CoverImage or "(none)")
                table.insert(v15, v17)
                local Music = v13.Music
                if Music ~= nil then
                    local v18 = ("Music: %*"):format(Music.SoundId)
                    table.insert(v15, v18)
                end
            else
                local v19 = ("Image: %*"):format(v13.Image)
                table.insert(v15, v19)
                local v20 = ("Sound: %*"):format(v13.SoundId)
                table.insert(v15, v20)
            end
            local v21 = table.concat(v15, "\n")
            print((("[currentTreadmillMedia]\n%*"):format(v21)))
            return v21
        end
        local v22 = {}
        v22[1] = ("Key: %* (%*)"):format(TreadmillMediaIdentity.GetMediaKey(v2), "Treadmill")
        v22[2] = ("Kind: %* | Bucket: %* | Release: %*"):format(v2.Kind, v2.BucketType, v2.ReleaseVersion)
        if v2.Kind == "Video" then
            local v23 = ("Video: %*"):format(v2.Video)
            table.insert(v22, v23)
            local v24 = ("Cover: %*"):format(v2.CoverImage or "(none)")
            table.insert(v22, v24)
            local Music = v2.Music
            if Music ~= nil then
                local v25 = ("Music: %*"):format(Music.SoundId)
                table.insert(v22, v25)
            end
        else
            local v26 = ("Image: %*"):format(v2.Image)
            table.insert(v22, v26)
            local v27 = ("Sound: %*"):format(v2.SoundId)
            table.insert(v22, v27)
        end
        local v28 = table.concat(v22, "\n")
        print((("[currentTreadmillMedia]\n%*"):format(v28)))
        return v28
    end
}
