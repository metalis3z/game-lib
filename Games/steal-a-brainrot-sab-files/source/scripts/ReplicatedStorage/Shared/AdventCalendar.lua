

local val1 = DateTime.fromUniversalTime(2025, 12, 1, 0, 0, 0).UnixTimestamp

local flag = {

    [1] = {
        type = "brainrot",
        name = "Admin Lucky Block"
    },
    [2] = {
        type = "luck",
        multiplier = "2x"
    },
    [3] = {
        type = "brainrot",
        name = "Los Lucky Blocks"
    },
    [4] = {
        type = "luck",
        multiplier = "2x"
    },
    [5] = {
        type = "brainrot",
        name = "Ballerina Peppermintina"
    },
    [6] = {
        type = "luck",
        multiplier = "2x"
    },
    [7] = {
        type = "skipfuse"
    },
    [8] = {
        type = "brainrot",
        name = "Admin Lucky Block",
        quantity = 2
    },
    [9] = {
        type = "luck",
        multiplier = "2x"
    },
    [10] = {
        type = "brainrot",
        name = "Please my Present"
    },
    [11] = {
        type = "luck",
        multiplier = "2x"
    },
    [12] = {
        type = "brainrot",
        name = "Los Lucky Blocks",
        quantity = 2
    },
    [13] = {
        type = "skipfuse"
    },
    [14] = {
        type = "luck",
        multiplier = "2x"
    },
    [15] = {
        type = "candyCane",
        quantity = 50
    },
    [16] = {
        type = "skipfuse"
    },
    [17] = {
        type = "luck",
        multiplier = "2x"
    },
    [18] = {
        type = "candyCane",
        quantity = 50
    },
    [19] = {
        type = "skipfuse"
    },
    [20] = {
        type = "brainrot",
        name = "Festive Lucky Block",
        quantity = 1
    },
    [21] = {
        type = "candyCane",
        quantity = 50
    },
    [22] = {
        type = "skipfuse"
    },
    [23] = {
        type = "candyCane",
        quantity = 50
    },
    [24] = {
        type = "brainrot",
        name = "Bunnyman",
        quantity = 1
    },
    [25] = {
        type = "brainrot",
        name = "Festive Lucky Block",
        quantity = 1
    }
}
local val9 = {
    [3] = {
        type = "brainrot",
        name = "Admin Lucky Block",
        quantity = 3
    },
    [7] = {
        type = "brainrot",
        name = "Los Lucky Blocks",
        quantity = 1
    },
    [14] = {
        type = "brainrot",
        name = "Festive Lucky Block",
        quantity = 3
    },
    [25] = {
        type = "brainrot",
        name = "25"
    }
}
local getCurrentDayObj = {
    Rewards = {
        Calendar = flag,
        Streak = val9
    },
    TotalDays = 25,
    getCurrentDay = function(val10)

        return ((val10 or workspace:GetServerTimeNow() // 1) - val1) // 86400 + 1
    end,
    timeToReward = function(val11)

        if not flag[val11] then

            return nil
        else

            return val1 + (val11 - 1) * 86400
        end
    end
}

getCurrentDayObj.getNextRewardTimestamp = function(getCurrentDayArg)

    local val12 = getCurrentDayObj.getCurrentDay(getCurrentDayArg)

    return getCurrentDayObj.timeToReward(val12 + 1)
end

getCurrentDayObj.getCalendarReward = function(val13)

    return flag[val13]
end

getCurrentDayObj.getStreakReward = function(val14)

    return val9[val14]
end

getCurrentDayObj.getStreak = function(flag_2, val2, val3)

    local val4 = val2 or getCurrentDayObj.getCurrentDay(val3)
    local val5 = 0
    for i = 1, val4 do
        if flag_2[tostring(i)] ~= nil then
            val5 = val5 + 1
        else
            val5 = 0
        end
    end

    return val5
end

getCurrentDayObj.getLastFailedDay = function(flag_3, val6, val7)

    local val8 = val6 or getCurrentDayObj.getCurrentDay(val7)
    for i_2 = val8 - 1, 1, -1 do
        if flag_3[tostring(i_2)] == nil then

            return i_2
        end
    end

    return nil
end

return getCurrentDayObj
