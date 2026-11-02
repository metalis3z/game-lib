local newDefaults = {
    ["Part"] = {
        FormFactor = "Custom";
        TopSurface = "Smooth";
        BottomSurface = "Smooth";
    };
   
    ["WedgePart"] = {
        FormFactor = "Custom";
        BottomSurface = "Smooth";
    };
}
 
function SetProperties(instance, properties)
    if properties["FormFactor"] then
        instance.FormFactor = properties["FormFactor"]
    end
   
    for property,value in pairs(properties) do
        if property ~= "Parent" and property ~= "FormFactor" then
            instance[property] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
end

local Instance = {
    new = function(className, secondParameter)
        local instance = Instance.new(className)
        if newDefaults[className] then
            SetProperties(instance, newDefaults[className])
        end
       
        if type(secondParameter) == "table" then
            SetProperties(instance, secondParameter)
        else
            instance.Parent = secondParameter
        end
       
        return instance
    end;
}
 
return Instance

