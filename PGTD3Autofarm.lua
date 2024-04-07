local machine = workspace.Machine
local buttons = machine.Buttons

local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()

local Window = ArrayField:CreateWindow({
    Name = "gambler pro",
    LoadingTitle = "Free roblox hax",
    LoadingSubtitle = "by LuaMadness",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "ArrayField"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using ArrayField may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
       Actions = {
             [1] = {
                 Text = 'Click here to copy the key link <--',
                 OnPress = function()
                     print('Pressed')
                 end,
                 }
             },
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

local Tab = Window:CreateTab('Machine')

local currType = 'Free'
local rolling = false
local buttonType = Tab:CreateDropdown({
	Name = "Button Type",
	CurrentOption = 'Free',
	Options = {'Free', 'Money', 'Star'},
	Callback = function(Value)
		currType = Value
	end    
})
local autoPress = Tab:CreateToggle({
	Name = "Auto Press",
	Default = false,
	Callback = function(Value)
		rolling = Value
	end    
})
task.spawn(function()
    while task.wait(0.01) do
        if rolling then
            fireclickdetector(buttons[currType].ClickDetector)
        else
            task.wait(0.5)
        end
    end
end)

local claiming = false
local autoClaim = Tab:CreateToggle({
	Name = "Auto Claim",
	Default = false,
	Callback = function(Value)
		claiming = Value
	end    
})
 
local newItems = 0
local statsLabel = Tab:CreateLabel("New items: 0")

local function itemClaimed()
    newItems += 1
    statsLabel:Set('New items: '.. newItems)
end

local ignoreList = {}
task.spawn(function()
    while task.wait(0.5) do
        if claiming then
            for i, v in machine:GetDescendants() do
                if table.find(ignoreList, v) then continue end
                if v:IsA('ClickDetector') and v.Parent.ClassName ~= 'Part' then
                    local cd = v
                    local model = v.Parent
                    local tool = model:FindFirstChildOfClass('Tool')
                    local item = model:FindFirstChildOfClass('Model')
                    if tool then
                        rconsoleprint('> NEW WEAPON | ' .. tool.Name)
                    end
                    if item then
                        rconsoleprint('> NEW ITEM |' .. item.Name)
                    end
                    task.wait(0.5)
                    fireclickdetector(cd)
                    rconsoleprint('Claimed')
                    table.insert(ignoreList, v)
                    itemClaimed()
                end
                table.insert(ignoreList, v)
            end
        end
    end
end)

rconsoleclear()
rconsoleprint('New items and more information will appear here!')
