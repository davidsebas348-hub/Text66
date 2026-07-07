-- getgenv().StageNumber = 10
local remote = game:GetService("ReplicatedStorage")
    :WaitForChild("RemoteEventsFolder")
    :WaitForChild("StageChange")

remote:FireServer(getgenv().StageNumber)
