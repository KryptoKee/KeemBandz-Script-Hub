local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Create the GUI
local Window = Library.CreateLib("KeemBandz Hoop Simulator Auto Farm", "Synapse")
local Tab = Window:NewTab("Main")
local MainSection = Tab:NewSection("Settings")

local LoopEnabled = false
local A_1 = 1
local Event = game:GetService("ReplicatedStorage")["events-shared/core/events.module@GlobalEvents"].throwBall

local function ExecuteCode()
    Event:FireServer(A_1)
end

MainSection:NewToggle("Auto Farm", "Stand within range of hoop to farm", function(state)
    LoopEnabled = state

    if LoopEnabled then
        print("Toggle On")
        while LoopEnabled do
            ExecuteCode()
            wait(4)
        end
    else
        print("Toggle Off")
    end
end)

-- Start the loop
Library:Init()
