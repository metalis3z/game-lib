-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local LocalPlayer = game:GetService("Players").LocalPlayer
return function(v1) -- line 7 | captures: LocalPlayer
    local v2 = {
        SelectedItem = 0,
        Items = {}
    }
    v2.ItemOptions = {}
    local Util = v1.Util
    local Autocomplete = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete")
    local TextButton = Autocomplete:WaitForChild("TextButton")
    local Title = Autocomplete:WaitForChild("Title")
    local Description = Autocomplete:WaitForChild("Description")
    local Entry = Autocomplete.Parent:WaitForChild("Frame"):WaitForChild("Entry")
    TextButton.Parent = nil
    local ScrollBarThickness = Autocomplete.ScrollBarThickness

    local function SetText(v3, v4, v5, v6) -- line 22 | captures: Util
        v3.Visible = v5 ~= nil
        v4.Text = v5 or ""
        if v6 then
            local v7 = Vector2.new(1000, 1000)
            v4.Size = UDim2.new(0, Util.GetTextSize(v5 or "", v4, v7, 1, 0).X, v3.Size.Y.Scale, v3.Size.Y.Offset)
        end
    end

    local function UpdateContainerSize() -- line 31 | captures: Autocomplete, Title
        local v8 = Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X
        local Offset = Autocomplete.Size.X.Offset
        local v9 = math.max(v8, Offset)
        local new = UDim2.new
        local Y = Autocomplete.UIListLayout.AbsoluteContentSize.Y
        local v10 = Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10
        Autocomplete.Size = new(0, v9, 0, (math.min(Y, v10)))
    end

    local function UpdateInfoDisplay(v11) -- line 35 | captures: Autocomplete, Title, Description, ScrollBarThickness, SetText, UpdateContainerSize
        SetText(Title, Title.Field, v11.name, true)
        local v12 = v11.type and ": " .. v11.type:sub(1, 1):upper() .. v11.type:sub(2)
        local v13 = v12 ~= nil
        Title.Field.Type.Visible = v13
        Title.Field.Type.Text = v12 or ""
        local description = v11.description
        local v14 = description ~= nil
        Description.Visible = v14
        Description.Label.Text = description or ""
        local Label = Description.Label
        if v11.invalid then
            Label.TextColor3 = Color3.fromRGB(255, 73, 73)
        else
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        Description.Size = UDim2.new(1, 0, 0, 40)
        while true do
            if Description.Label.TextFits then
                break
            end
            Description.Size += UDim2.new(0, 0, 0, 2)
            if Description.Size.Y.Offset > 500 then
                break
            end
        end
        task.wait()
        Autocomplete.UIListLayout:ApplyLayout()
        UpdateContainerSize()
        Autocomplete.ScrollBarThickness = ScrollBarThickness
    end

    function v2.Show(v15, v16, v17) -- line 69 | captures: Util, Autocomplete, TextButton, Entry, UpdateInfoDisplay
        local v18 = v17 or {}
        for v19, v20 in pairs(v15.Items) do
            if v20.gui then
                v20.gui:Destroy()
            end
        end
        v15.SelectedItem = 1
        v15.Items = v16
        v15.Prefix = v18.prefix or ""
        v15.LastItem = v18.isLast or false
        v15.Command = v18.command
        v15.Arg = v18.arg
        v15.NumArgs = v18.numArgs
        v15.IsPartial = v18.isPartial
        Autocomplete.ScrollBarThickness = 0
        local v21 = 200
        for v22, v23 in pairs(v15.Items) do
            local v24 = v23[1]
            local v25 = v23[2]
            local v26 = TextButton:Clone()
            v26.Name = v24 .. v25
            if v22 == v15.SelectedItem then
                v26.BackgroundTransparency = 0.5
            else
                v26.BackgroundTransparency = 1
            end
            local v27 = v25:lower()
            local v28 = v24:lower()
            local v29, v30 = string.find(v27, v28, 1, true)
            local v31 = string.rep(" ", v29 - 1)
            v26.Typed.Text = v31 .. v24
            local v32 = v29 - 1
            local v33 = string.sub(v25, 0, v32)
            local v34 = string.rep(" ", #v24)
            local Suggest = v26.Suggest
            local v35 = v30 + 1
            Suggest.Text = v33 .. v34 .. string.sub(v25, v35)
            v26.Parent = Autocomplete
            v26.LayoutOrder = v22
            local X = v26.Typed.TextBounds.X
            local X_2 = v26.Suggest.TextBounds.X
            local v36 = math.max(X, X_2) + 20
            if v21 < v36 then
                v21 = v36
            end
            v23.gui = v26
        end
        Autocomplete.UIListLayout:ApplyLayout()
        local Text = Entry.TextBox.Text
        local v37 = Util.SplitString(Text)
        if Text:sub(#Text, #Text) == " " and not v18.at then
            v37[#v37 + 1] = "e"
        end
        table.remove(v37, #v37)
        local v38 = if v18.at then v18.at else #table.concat(v37, " ") + 1
        Autocomplete.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + v38 * 7, 0, Entry.TextBox.AbsolutePosition.Y + 30)
        Autocomplete.Size = UDim2.new(0, v21, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
        Autocomplete.Visible = true
        if v15.Items[1] then
            v18 = v15.Items[1].options or v18
        end
        UpdateInfoDisplay(v18)
    end

    function v2.GetSelectedItem(v39) -- line 146 | captures: v2, Autocomplete
        if Autocomplete.Visible == false then
            return nil
        end
        return v2.Items[v2.SelectedItem]
    end

    function v2.Hide(v40) -- line 152 | captures: Autocomplete
        Autocomplete.Visible = false
    end

    function v2.IsVisible(v41) -- line 155 | captures: Autocomplete
        return Autocomplete.Visible
    end

    function v2.Select(v42, v43) -- line 158 | captures: Autocomplete, TextButton, Title, Description, UpdateInfoDisplay
        if not Autocomplete.Visible then
            return
        end
        v42.SelectedItem += v43
        if #v42.Items < v42.SelectedItem then
            v42.SelectedItem = 1
        elseif v42.SelectedItem < 1 then
            v42.SelectedItem = #v42.Items
        end
        for v44, v45 in pairs(v42.Items) do
            local v46 = if v44 == v42.SelectedItem then 0.5 else 1
            v45.gui.BackgroundTransparency = v46
        end
        local v47 = Title.Size.Y.Offset + Description.Size.Y.Offset + v42.SelectedItem * TextButton.Size.Y.Offset
        local new = Vector2.new
        local v48 = v47 - Autocomplete.Size.Y.Offset
        Autocomplete.CanvasPosition = new(0, (math.max(0, v48)))
        if v42.Items[v42.SelectedItem] and v42.Items[v42.SelectedItem].options then
            local v49 = v42.Items[v42.SelectedItem].options or {}
            UpdateInfoDisplay(v49)
        end
    end

    Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)
    return v2
end
