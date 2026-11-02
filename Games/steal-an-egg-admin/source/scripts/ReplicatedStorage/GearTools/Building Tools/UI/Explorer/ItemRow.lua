-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local UI = Parent:WaitForChild("UI")
local UserInputService = game:GetService("UserInputService")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(Libraries:WaitForChild("Maid"))
local createElement = v2.createElement
local v4 = require(UI:WaitForChild("Frame"))
local v5 = require(UI:WaitForChild("ImageLabel"))
local v6 = require(UI:WaitForChild("ImageButton"))
local v7 = require(UI:WaitForChild("TextLabel"))
local v8 = require(UI:WaitForChild("TextBox"))
local ItemRow = v2.PureComponent:extend("ItemRow")

function ItemRow.init(v9) -- line 23 | captures: v2
    function v9.OnActivated() -- line 26 | captures: v9
        v9:HandleSelection()
    end

    function v9.OnArrowActivated() -- line 31 | captures: v9
        v9:ToggleExpand()
    end

    function v9.OnLockActivated() -- line 36 | captures: v9
        v9:ToggleLock()
    end

    function v9.OnNameActivated(v10) -- line 41 | captures: v9
        local v11 = tick()
        if not (v9.LastNameClick and v11 - v9.LastNameClick <= 0.25) then
            v9.LastNameClick = v11
            v9:HandleSelection()
        else
            v9:setState({ EditingName = true })
        end
    end

    function v9.OnNameInputBlur(v12, v13) -- line 52 | captures: v9, v2
        if #v12.Text > 0 then
            v9:SetName(v12.Text)
        end
        v9:setState({ EditingName = v2.None })
    end
end

local function GetParts(v14) -- line 61
    local Instance = v14.props.Instance
    if Instance:IsA("BasePart") then
        return { Instance }
    end
    local v15 = {}
    for v16, v17 in pairs(Instance:GetDescendants()) do
        if v17:IsA("BasePart") then
            v15[#v15 + 1] = v17
        end
    end
    return v15
end

ItemRow.GetParts = GetParts

function ItemRow.ToggleLock(v18) -- line 80 | captures: v1
    local props = v18.props
    local v19 = v18:GetParts()
    local v20 = {
        Parts = v19,
        BeforeLocked = v1.GetListMembers(v19, "Locked"),
        AfterLocked = not props.IsLocked
    }

    function v20.Unapply(v21) -- line 91 | captures: props
        props.Core.SyncAPI:Invoke("SetLocked", v21.Parts, v21.BeforeLocked)
    end

    function v20.Apply(v22) -- line 95 | captures: props
        props.Core.SyncAPI:Invoke("SetLocked", v22.Parts, v22.AfterLocked)
    end

    v20:Apply()
    props.Core.History.Add(v20)
end

local function SetName(v23, v24) -- line 107
    local props = v23.props
    local v25 = {
        Items = { props.Instance },
        BeforeName = props.Instance.Name,
        AfterName = v24
    }

    function v25.Unapply(v26) -- line 117 | captures: props
        props.Core.SyncAPI:Invoke("SetName", v26.Items, v26.BeforeName)
    end

    function v25.Apply(v27) -- line 121 | captures: props
        props.Core.SyncAPI:Invoke("SetName", v27.Items, v27.AfterName)
    end

    v25:Apply()
    props.Core.History.Add(v25)
end

ItemRow.SetName = SetName

function ItemRow.HandleSelection(v28) -- line 133 | captures: UserInputService
    local props = v28.props
    local Selection = props.Core.Selection
    local Targeting = props.Core.Targeting
    if UserInputService:IsKeyDown("LeftAlt") or UserInputService:IsKeyDown("RightAlt") then
        Targeting:SetScope(props.Instance)
    elseif UserInputService:IsKeyDown("LeftControl") or UserInputService:IsKeyDown("RightControl") then
        if Selection.IsSelected(props.Instance) then
            Selection.Remove({ props.Instance }, true)
        else
            Selection.Add({ props.Instance }, true)
        end
    else
        Selection.Replace({ props.Instance }, true)
    end
end

local function ToggleExpand(v29) -- line 164
    v29.props.ToggleExpand(v29.props.Id)
end

ItemRow.ToggleExpand = ToggleExpand

function ItemRow.didMount(v30) -- line 168 | captures: v2, v3
    v30.Maid = v3.new()
    local Targeting = v30.props.Core.Targeting
    local Instance = v30.props.Instance
    v30.Maid.TargetListener = Targeting.ScopeTargetChanged:Connect(function(v31) -- line 175 | captures: v30, Instance, v2
        local Targeted = v30.state.Targeted
        if Targeted or not (v31 == Instance) then
            if Targeted and v31 ~= Instance then
                v30:setState({ Targeted = v2.None })
            end
        else
            v30:setState({ Targeted = true })
        end
    end)
end

local function willUnmount(v32) -- line 185
    v32.Maid = v32.Maid:Destroy()
end

ItemRow.willUnmount = willUnmount
ItemRow.ClassIcons = {
    Part = Vector2.new(2, 1),
    MeshPart = Vector2.new(4, 8),
    UnionOperation = Vector2.new(4, 8),
    NegateOperation = Vector2.new(3, 8),
    VehicleSeat = Vector2.new(6, 4),
    Seat = Vector2.new(6, 4),
    TrussPart = Vector2.new(2, 1),
    CornerWedgePart = Vector2.new(2, 1),
    WedgePart = Vector2.new(2, 1),
    SpawnLocation = Vector2.new(6, 3),
    Model = Vector2.new(3, 1),
    Folder = Vector2.new(8, 8),
    Tool = Vector2.new(8, 2),
    Workspace = Vector2.new(10, 2),
    Accessory = Vector2.new(3, 4),
    Accoutrement = Vector2.new(3, 4)
}

function ItemRow.render(v33) -- line 208 | captures: v2, createElement, v4, v5, v6, v7, v8, ItemRow
    local props = v33.props
    local state = v33.state
    local v34 = ItemRow.ClassIcons[props.Class] or Vector2.new(1, 1)
    local v35 = {
        Layout = "List",
        LayoutDirection = "Horizontal",
        VerticalAlignment = "Center"
    }
    local v36 = {
        StartSpacer = createElement(v4, {
            LayoutOrder = 0,
            AspectRatio = (5 + 10 * props.Depth) / 18
        }),
        Icon = createElement(v5, {
            AspectRatio = 1,
            Image = "rbxassetid://2245672825",
            LayoutOrder = 1,
            ImageRectOffset = (v34 - Vector2.new(1, 1)) * Vector2.new(16, 16),
            ImageRectSize = Vector2.new(16, 16),
            Size = UDim2.new(1, 0, 0.6666666666666666, 0)
        }),
        IconSpacer = createElement(v4, {
            AspectRatio = 0.2777777777777778,
            LayoutOrder = 2
        })
    }
    local v37 = {
        Layout = "List",
        Width = "WRAP_CONTENT",
        LayoutOrder = 3
    }
    v37[v2.Event.Activated] = v33.OnNameActivated
    local v38 = {}
    v38.Name = not state.EditingName and
    createElement(v7, {
        TextSize = 13,
        TextColor = "FFFFFF",
        Width = "WRAP_CONTENT",
        Text = props.Name
    })
    local EditingName = state.EditingName
    if EditingName then
        local v39 = {
            TextSize = 13,
            TextColor = "FFFFFF",
            Text = props.Name,
            Width = "WRAP_CONTENT"
        }
        v39[v2.Event.FocusLost] = v33.OnNameInputBlur
        EditingName = createElement(v8, v39)
    end
    v38.NameInput = EditingName
    v36.NameContainer = createElement(v6, v37, v38)
    local v40 = createElement(v4, v35, v36)
    local v41 = {
        Layout = "List",
        LayoutDirection = "Horizontal",
        HorizontalAlignment = "Right",
        VerticalAlignment = "Center",
        Width = "WRAP_CONTENT",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0)
    }
    local v42 = {}
    local v43 = {
        AspectRatio = 1,
        DominantAxis = "Height",
        Image = "rbxassetid://2244452978"
    }
    local new = Vector2.new
    local v44 = if props.IsLocked then 2 else 1
    v43.ImageRectOffset = new(14 * v44, 0) * 2
    v43.ImageRectSize = Vector2.new(14, 14) * 2
    v43.Size = UDim2.new(1, 0, 0.6666666666666666, 0)
    local v45 = if props.IsLocked then 0.75 else 0.15
    v43.ImageTransparency = 1 - v45
    v43.LayoutOrder = 0
    v43[v2.Event.Activated] = v33.OnLockActivated
    v42.Lock = createElement(v6, v43)
    v42.Spacer = createElement(v4, {
        LayoutOrder = 1,
        AspectRatio = 0.1
    })
    local v46 = next(props.Children)
    if v46 then
        local v47 = {
            AspectRatio = 1,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0.7777777777777778, 0)
        }
        local v48 = {}
        local v49 = {
            Image = "rbxassetid://2244452978",
            ImageRectOffset = Vector2.new(42, 0) * 2,
            ImageRectSize = Vector2.new(14, 14) * 2
        }
        if props.Expanded then
            v49.Rotation = 180
        else
            v49.Rotation = 90
        end
        v49.ImageTransparency = 0.85
        v49[v2.Event.Activated] = v33.OnArrowActivated
        v48.Arrow = createElement(v6, v49)
        v42.ArrowWrapper = createElement(v4, v47, v48)
    else
        v42.ArrowWrapper = v46
    end
    v42.EndSpacer = createElement(v4, {
        LayoutOrder = 3,
        AspectRatio = 0.05
    })
    local v50 = createElement(v4, v41, v42)
    local v51
    if props.Selected then
        v51 = 0.85
    elseif state.Targeted then
        v51 = 0.95
    else
        v51 = 1
    end
    local v52 = {
        LayoutOrder = props.Order,
        Size = UDim2.new(1, 0, 0, props.Height),
        AutoButtonColor = false,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = v51
    }
    v52[v2.Event.Activated] = v33.OnActivated
    return createElement(v6, v52, {
        Metadata = v40,
        Buttons = v50
    })
end

return ItemRow
