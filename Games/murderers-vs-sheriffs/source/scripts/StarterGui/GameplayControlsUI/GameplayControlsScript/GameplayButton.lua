-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfC0NvbnRyb2xUZXh0EFRleHRUcmFuc3BhcmVuY3kLQ29udHJvbEljb24RSW1hZ2VUcmFuc3BhcmVuY3kGQ29sb3IzB2Zyb21SR0ILSW1hZ2VDb2xvcjMHRW5hYmxlZApTZXRFbmFibGVkCUFjdGl2YXRlZARGaXJlCW9uUHJlc3NlZApvblJlbGVhc2VkBE5hbWUMV2FpdEZvckNoaWxkC0ltYWdlQnV0dG9uCEluc3RhbmNlA25ldw1CaW5kYWJsZUV2ZW50DFRvdWNoQmluZGluZwhVSUJ1dHRvbgdQcmVzc2VkB0Nvbm5lY3QIUmVsZWFzZWQKTW91c2VMZWF2ZQRnYW1lB1BsYXllcnMLTG9jYWxQbGF5ZXIJUGxheWVyR3VpDElucHV0Q29udGV4dA9HYW1lcGxheUNvbnRleHQABgcCAgAABwQAAAUCBAE0KgESAAEAAID7AwAATQIDsAAAAACMAwAAMAMCJAEAAAD7AwAATQIDbgIAAACMAwAAMAMCowMAAAD7AgAAjAMAADADAqMDAAAAZQAZAPsDAABNAgOwAAAAAG8DBAAwAwIkAQAAAPsDAABNAgNuAgAAAG8DBAAwAwKjAwAAAPsCAABvAwQAMAMCowMAAAD7AgAApAMHAAAYUICMBAAAjAUAAIwGAACfAwQCMAMCAAgAAAD7AgEAKgECAAEAAACpAwABqQMBADADAvAJAAAAggABAAoDAQMCAwMDBAJmZmZmZmbmPwMFAwYEABhQgAMHAwgADwkBGAAAAQAAAAAAAQAAAAAAAQAAAAACAAAAAAABAAAAAAABAAAAAQAAAAAAAAAAAgAAAAAAAAEQAAAAAAUAAgAAABX7AQAATQAB8AAAAAArAAEAggABAPsAAQCkAQMAAAgQgIwCqgCMA6oAjASqAJ8BBAIwAQAABAAAAPsBAABNAAEeBQAAALwAAN0GAAAAnwACAYIAAQAHAwgDBQMGBAAIEIADBwMKAwsAIAwBGAAAAAABAgAAAAAAAAAAAQAAAAAAASEAAAAABQABAAAACvsAAACkAQIAAAQAgIwCAACMAwAAjAQAAJ8BBAIwAQAAAwAAAIIAAQAEAwUDBgQABACAAwcAKA0BGAAAAAAAAAAAAAEpAAAAAAMAAQAAAAb7AAAAqQIAALwAAN0AAAAAnwADAYIAAQABAwsALgABGAAAAAAAAS8AAAAACAEBAAAANv8BAwAAAAAA+wIAAE0EALoAAAAAvAIC0wEAAACfAgMCqQMBADADAfACAAAAMAABFwMAAACkAwYAABRAgG8EBwCfAwICMAMBHggAAADZAwAAEgAAABIAAQAwAwGeCQAAAA4CHABNAwI7CgAAADAAA1cLAAAA2QMBABIAAQASAAAA2QQCABIAAABNBQKPDAAAAFIHAwC8BQXHDQAAAJ8FAwFNBQLkDgAAAFIHBAC8BQXHDQAAAJ8FAwFNBQDdDwAAANkHAwASAAIAvAUFxw0AAACfBQMBggECABADDgMPAwgDEAMRAxIEABRAgAMTAwoDCQMUAxUDFgMXAxgDGQQAAQIDBhIBGAAAAgAAAAAAAgAAAQABAAAAAAACAAAAAA4BAAAAAgAACAAEAAAAAAABAAAAAAABAAAAAAAAFgcAAAAABQAAAQIAGKMAAAD/AAEAAAAAAKQEAQAAAABATQMEUAIAAABNAgMxAwAAAE0BApkEAAAAbwMFALwBAdMGAAAAnwEDAm8EBwC8AgHTBgAAAJ8CAwLAAwgAEgACADADAO8JAAAAggACAAoDGgQAAABAAxsDHAMdAx4DDwMfBgQDEgEEAQABGAAAAAIAAAAAAAAAAAAAAAEAAAACAAAAQgEAAAAABWksv7M0PqXFaOjAU/u1sSMZNKjHW+jVsg==

local v0 = {};
local l_GameplayContext_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("InputContext"):WaitForChild("GameplayContext");
v0.new = function(v2) --[[ Line: 6 ]] --[[ Name: new ]]
    -- upvalues: l_GameplayContext_0 (copy)
    local v3 = {};
    local v4 = l_GameplayContext_0:WaitForChild(v2.Name);
    v3.Enabled = true;
    v3.ImageButton = v2;
    v3.Activated = Instance.new("BindableEvent");
    v3.SetEnabled = function(_, v6) --[[ Line: 15 ]] --[[ Name: SetEnabled ]]
        -- upvalues: v2 (copy), v3 (copy)
        if v6 == true then
            v2.ControlText.TextTransparency = 0;
            v2.ControlIcon.ImageTransparency = 0;
            v2.ImageTransparency = 0;
        else
            v2.ControlText.TextTransparency = 0.7;
            v2.ControlIcon.ImageTransparency = 0.7;
            v2.ImageTransparency = 0.7;
            v2.ImageColor3 = Color3.fromRGB(0, 0, 0);
        end;
        v3.Enabled = v6 == true;
    end;
    if v4 then
        v4.TouchBinding.UIButton = v2;
        local function v7() --[[ Line: 32 ]] --[[ Name: onPressed ]]
            -- upvalues: v3 (copy), v2 (copy)
            if not v3.Enabled then
                return;
            else
                v2.ImageColor3 = Color3.fromRGB(170, 170, 170);
                v3.Activated:Fire();
                return;
            end;
        end;
        local function v8() --[[ Line: 40 ]] --[[ Name: onReleased ]]
            -- upvalues: v2 (copy)
            v2.ImageColor3 = Color3.fromRGB(0, 0, 0);
        end;
        v4.Pressed:Connect(v7);
        v4.Released:Connect(v8);
        v2.MouseLeave:Connect(function() --[[ Line: 46 ]]
            -- upvalues: v4 (copy)
            v4:Fire(false);
        end);
    end;
    return v3;
end;
return v0;