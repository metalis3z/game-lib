local Util = require(script.Parent.Parent.Shared.Util)

local unitTable = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1
}

local searchKeyTable = {}
for key, _ in pairs(unitTable) do
    table.insert(searchKeyTable, key)
end
local unitFinder = Util.MakeFuzzyFinder(searchKeyTable)

local function stringToSecondDuration(stringDuration)
    if stringDuration == nil or stringDuration == "" then
        return nil
    end
    local durationNum = tonumber(stringDuration)
    if durationNum and durationNum == 0 then
        return 0, 0, true
    end
    local endOnlyString = stringDuration:gsub("-?%d+%a+", "")
    local endNumber = endOnlyString:match("-?%d+")
    if endNumber then
        return nil, tonumber(endNumber), true
    end
    local seconds = nil
    local rawNum, rawUnit
    for rawComponent in stringDuration:gmatch("-?%d+%a+") do
        rawNum, rawUnit = rawComponent:match("(-?%d+)(%a+)")
        local unitNames = unitFinder(rawUnit)
        if #unitNames == 0 then
            return nil, tonumber(rawNum)
        end
        if seconds == nil then seconds = 0 end
        seconds = seconds + (rawUnit:lower() == "m" and 60 or unitTable[unitNames[1]]) * tonumber(rawNum)
    end
    if seconds == nil then
        return nil
    else
        return seconds, tonumber(rawNum)
    end
end

local function mapUnits(units, rawText, lastNumber, subStart)
    subStart = subStart or 1
    local returnTable = {}
    for i, unit in pairs(units) do
        if lastNumber == 1 then
            returnTable[i] = rawText .. unit:sub(subStart, #unit - 1)
        else
            returnTable[i] = rawText .. unit:sub(subStart)
        end
    end
    return returnTable
end

local durationType = {
    Transform = function(text)
        return text, stringToSecondDuration(text)
    end;

    Validate = function(_, duration)
        return duration ~= nil
    end;

    Autocomplete = function(rawText, duration, lastNumber, isUnitMissing, matchedUnits)
        local returnTable = {}
        if isUnitMissing or matchedUnits then
            local unitsTable = isUnitMissing == true and unitFinder("") or matchedUnits
            if isUnitMissing == true then
                returnTable = mapUnits(unitsTable, rawText, lastNumber)
            else
                local existingUnitLength = rawText:match("^.*(%a+)$"):len()
                returnTable = mapUnits(unitsTable, rawText, existingUnitLength + 1)
            end
        elseif duration ~= nil then
            local endingUnit = rawText:match("^.*-?%d+(%a+)$")
            local fuzzyUnits = unitFinder(endingUnit)
            returnTable = mapUnits(fuzzyUnits, rawText, lastNumber, #endingUnit + 1)
            table.sort(returnTable)
        end
        return returnTable
    end;

    Parse = function(_, duration)
        return duration
    end;
}

return function(registry)
    registry:RegisterType("duration", durationType)
    registry:RegisterType("durations", Util.MakeListableType(durationType))
end