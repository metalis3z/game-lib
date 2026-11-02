local ColorSequenceUtils = require(script.Parent.Parent.ColorSequenceUtils)
local gradientSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.7, 0.3, 1)), 
    ColorSequenceKeypoint.new(0.5, Color3.new(0.3, 0.1, 0.5)), 
    ColorSequenceKeypoint.new(1, Color3.new(0.7, 0.3, 1))
})
local timeOffset = 0

return {
    simulate = function(deltaTime)
        timeOffset = timeOffset + deltaTime * 1
        return {
            main = ColorSequenceUtils.calculateColorSequence(gradientSequence, timeOffset)
        }
    end, 
    
    apply = function(textLabel)
        local cleanupFunctions = {}
        
        local function modifyAndRestore(object, property, newValue)
            local oldValue = object[property]
            object[property] = newValue
            table.insert(cleanupFunctions, 1, function()
                object[property] = oldValue
            end)
        end
        
        local function useOrCreate(parent, className)
            local existing = parent:FindFirstChildWhichIsA(className)
            if not existing then
                local new = Instance.new(className)
                new.Parent = parent
                table.insert(cleanupFunctions, 1, function()
                    new:Destroy()
                end)
                existing = new
            end
            return existing
        end
        
        if textLabel:IsA("TextLabel") then
            local whiteColor = Color3.new(1, 1, 1)
            local originalTextColor = textLabel.TextColor3
            textLabel.TextColor3 = whiteColor
            table.insert(cleanupFunctions, 1, function()
                textLabel.TextColor3 = originalTextColor
            end)
        end
        
        local mainGradient = useOrCreate(textLabel, "UIGradient")
        local stroke = useOrCreate(textLabel, "UIStroke")
        local strokeGradient = useOrCreate(stroke, "UIGradient")
        
        local blackColor = Color3.new(0, 0, 0)
        local originalStrokeColor = stroke.Color
        stroke.Color = blackColor
        table.insert(cleanupFunctions, 1, function()
            stroke.Color = originalStrokeColor
        end)
        
        local originalRotation = mainGradient.Rotation
        mainGradient.Rotation = 90
        table.insert(cleanupFunctions, 1, function()
            mainGradient.Rotation = originalRotation
        end)
        
        local originalTransparency = mainGradient.Transparency
        mainGradient.Transparency = NumberSequence.new(0)
        table.insert(cleanupFunctions, 1, function()
            mainGradient.Transparency = originalTransparency
        end)
        
        local originalStrokeRotation = strokeGradient.Rotation
        strokeGradient.Rotation = 90
        table.insert(cleanupFunctions, 1, function()
            strokeGradient.Rotation = originalStrokeRotation
        end)
        
        local originalStrokeTransparency = strokeGradient.Transparency
        strokeGradient.Transparency = NumberSequence.new(0)
        table.insert(cleanupFunctions, 1, function()
            strokeGradient.Transparency = originalStrokeTransparency
        end)
        
        return {
            main = mainGradient, 
            stroke = strokeGradient, 
            cleanup = function()
                for _, cleanupFunc in cleanupFunctions do
                    cleanupFunc()
                end
            end
        }
    end
}