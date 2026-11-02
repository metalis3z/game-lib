--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  Includes: Script & GUI
  StarterGui: >>> DELETE ME <<< Delete This Gui
  Discord: discord.gg/nDWm6PkFrT
--]]

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Datas.ServerData)
local v_u_4 = require(v1.Utils.TimeUtils)
local v_u_5 = require(v1.Packages.FFlags)
local v_u_6 = require(v1.Packages.Timer)
local v_u_7 = v2.LocalPlayer.PlayerGui:WaitForChild("TopUI").Frame.Countdown
return {
    ["Start"] = function(_)
        -- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_5, (copy) v_u_4, (copy) v_u_6
        if v_u_3.IsDuelsServer() then
            v_u_7.Visible = false
        else
            local v_u_8 = nil
            local v_u_9 = nil
            local v_u_10 = nil
            local function v16()
                -- upvalues: (ref) v_u_5, (ref) v_u_8, (ref) v_u_7, (ref) v_u_4, (ref) v_u_10, (ref) v_u_9
                local v11 = workspace:GetServerTimeNow()
                local v12 = v_u_5:GetInstant("GlobalCountdown")
                if v12 and v12.timestamp >= v11 then
                    if v_u_8 ~= true then
                        v_u_8 = true
                        v_u_7.Visible = true
                    end
                    local v13 = v_u_7.Timer
                    local v14 = v_u_4
                    local v15 = v12.timestamp - v11
                    v13.Text = v14:E((math.max(v15, 0)))
                    if v_u_10 ~= v12.title then
                        v_u_10 = v12.title
                        v_u_7.Title.Text = v12.title
                    end
                    if v_u_9 ~= v12.color then
                        v_u_9 = v12.color
                        v_u_7.Title.TextColor3 = Color3.fromHex(v12.color or "ffea00")
                    end
                elseif v_u_8 ~= false then
                    v_u_8 = false
                    v_u_7.Visible = false
                end
            end
            v_u_6.Simple(1, v16, true)
        end
    end
}