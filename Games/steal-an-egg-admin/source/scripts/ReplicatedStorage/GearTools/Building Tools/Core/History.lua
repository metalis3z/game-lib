-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Libraries = script.Parent.Parent:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("Signal"))

History = {
    Index = 0,
    Stack = {},
    Changed = v1.new()
}

local function Undo() -- line 20
    if History.Index - 1 < 0 then
        return
    end
    History.Stack[History.Index]:Unapply()
    History.Index = History.Index - 1
    History.Changed:Fire()
end

History.Undo = Undo

local function Redo() -- line 40
    local v2 = History.Index + 1
    if #History.Stack < v2 then
        return
    end
    History.Index = History.Index + 1
    History.Stack[History.Index]:Apply()
    History.Changed:Fire()
end

History.Redo = Redo

local function Add(v3) -- line 60
    History.Index = History.Index + 1
    History.Stack[History.Index] = v3
    local v4 = History.Index + 1
    local v5 = #History.Stack
    for v6 = v4, v5 do
        History.Stack[v6] = nil
    end
    History.Changed:Fire()
end

History.Add = Add
return History
