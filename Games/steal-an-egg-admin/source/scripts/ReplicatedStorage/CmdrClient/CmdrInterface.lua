-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local LocalPlayer = game:GetService("Players").LocalPlayer
return function(v1) -- line 7 | captures: LocalPlayer
    local Util = v1.Util
    local v2 = require(script:WaitForChild("Window"))
    v2.Cmdr = v1
    local v3 = require(script:WaitForChild("AutoComplete"))(v1)
    v2.AutoComplete = v3

    function v2.ProcessEntry(v4) -- line 14 | captures: v1, Util, v2, LocalPlayer
        local v5 = Util.TrimString(v4)
        if #v5 == 0 then
            return
        end
        local v6 = v2:GetLabel()
        v2:AddLine(v6 .. " " .. v5, Color3.fromRGB(255, 223, 93))
        v2:AddLine(v1.Dispatcher:EvaluateAndRun(v5, LocalPlayer, { IsHuman = true }))
    end

    function v2.OnTextChanged(v7) -- line 23 | captures: v1, Util, v2, v3, LocalPlayer
        local v8 = v1.Dispatcher:Evaluate(v7, LocalPlayer, true)
        local v9 = Util.SplitString(v7)
        local v10 = table.remove(v9, 1)
        local v11
        if v8 then
            v9 = Util.MashExcessArguments(v9, #v8.Object.Args)
            v11 = #v9 == #v8.Object.Args
        else
            v11 = false
        end
        local v12 = v10 and #v9 > 0
        if v7:sub(#v7, #v7):match("%s") and not v11 then
            v9[#v9 + 1] = ""
            v12 = true
        end
        if v8 then
            if v12 then
                local v13, v14 = v8:Validate()
                v2:SetIsValidInput(v13, ("Validation errors: %s"):format(v14 or ""))
                local v15 = {}
                local v16 = v8:GetArgument(#v9)
                if v16 then
                    local TextSegmentInProgress = v16.TextSegmentInProgress
                    local v17
                    if v16.RawSegmentsAreAutocomplete then
                        v17 = false
                        for v18, v19 in ipairs(v16.RawSegments) do
                            v15[v18] = { v19, v19 }
                            v17 = false
                        end
                    else
                        local v20, v21 = v16:GetAutocomplete()
                        v17 = (v21 or {}).IsPartial or false
                        for v22, v23 in pairs(v20) do
                            v15[v22] = { TextSegmentInProgress, v23 }
                        end
                    end
                    local v24
                    if #TextSegmentInProgress > 0 then
                        v24, v14 = v16:Validate()
                    else
                        v24 = true
                    end
                    if not v11 and v24 then
                        v2:HideInvalidState()
                    end
                    local v25 = {}
                    if v11 then
                        local v26 = if v7:sub(#v7, #v7):match("%s") then -1 else 0
                        v25.at = #v7 - #TextSegmentInProgress + v26
                    else
                        v25.at = v11
                    end
                    if #v16.RawSegments == 1 then
                        v25.prefix = v16.Prefix
                    else
                        v25.prefix = ""
                    end
                    if #v8.Arguments == #v8.ArgumentDefinitions then
                        v25.isLast = #TextSegmentInProgress > 0
                    else
                        v25.isLast = false
                    end
                    v25.numArgs = #v9
                    v25.command = v8
                    v25.arg = v16
                    local v27 = if v16.Required then "" else "?"
                    v25.name = v16.Name .. v27
                    v25.type = v16.Type.DisplayName
                    v25.description = v24 == false and v14 or v16.Object.Description
                    v25.invalid = not v24
                    v25.isPartial = v17
                    return v3:Show(v15, v25)
                end
                v2:SetIsValidInput(false, "Use the help command to see all available commands.")
                v3:Hide()
            end
        else
            if v10 and #v9 == 0 then
                v2:SetIsValidInput(true)
                local v28 = v1.Registry:GetCommand(v10)
                local v29
                if v28 then
                    v29 = {
                        v28.Name,
                        v28.Name
                    }
                    v29.options = {
                        name = v28.Name,
                        description = v28.Description
                    }
                    local Args = v28.Args
                    if Args then
                        Args = v28.Args[1]
                        if type(Args) == "function" then
                            Args = Args(v8)
                        end
                        if Args and not Args.Optional and Args.Default == nil then
                            v2:SetIsValidInput(false, "This command has required arguments.")
                            v2:HideInvalidState()
                        end
                    elseif type(Args) == "function" then
                        Args = Args(v8)
                        if Args and not Args.Optional and Args.Default == nil then
                            v2:SetIsValidInput(false, "This command has required arguments.")
                            v2:HideInvalidState()
                        end
                    end
                else
                    v2:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v10))
                end
                local v30 = { v29 }
                for v31, v32 in pairs(v1.Registry:GetCommandNames()) do
                    if v10:lower() == v32:lower():sub(1, #v10) then
                        if v29 == nil then
                            local v33 = v1.Registry:GetCommand(v32)
                            local v34 = #v30 + 1
                            local v35 = { v10, v32 }
                            v35.options = {
                                name = v33.Name,
                                description = v33.Description
                            }
                            v30[v34] = v35
                        elseif v29[1] == v10 then
                        end
                    end
                end
                return v3:Show(v30)
            end
            v2:SetIsValidInput(false, "Use the help command to see all available commands.")
            v3:Hide()
        end
    end

    v2:UpdateLabel()
    v2:UpdateWindowHeight()
    return {
        Window = v2,
        AutoComplete = v3
    }
end
