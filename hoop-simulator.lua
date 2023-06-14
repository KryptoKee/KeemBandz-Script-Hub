local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create the GUI
local Window = Library.CreateLib("KeemBandz Hoop Simulator Auto Farm", "Synapse")
local Tab = Window:NewTab("Main")
local MainSection = Tab:NewSection("Settings")

local farmingEnabled = false
local waitTime = 4

MainSection:NewToggle("Auto Farm", "Stand within range of hoop to farm", function(state)
    farmingEnabled = state
    
    if farmingEnabled then
        -- Start the loop when the toggle is turned on
        while farmingEnabled do
            local A_1 = 1
            local Event = game:GetService("ReplicatedStorage")["events-shared/core/events.module@GlobalEvents"].throwBall
            Event:FireServer(A_1)
            
            -- Wait for the user-defined wait time
            wait(waitTime)
        end
    else
        print("Toggle Off")
    end
end)

MainSection:NewSlider("Wait Time", "Adjust the wait time from 1 to 15", 15, 1, function(value)
    waitTime = value
end)

MainSection:NewButton("Perfect Shot!", "Will be a perfect 100 power shot", function()
    local A_1 = 1
local Event = game:GetService("ReplicatedStorage")["events-shared/core/events.module@GlobalEvents"].throwBall
Event:FireServer(A_1)
end)

-- Start the GUI
Library:Init()
