---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUI
---

---@class RageUI
RageUI = {}

---@class Item
RageUI.Item = setmetatable({}, RageUI.Item)

---@class Window
RageUI.Window = setmetatable({}, RageUI.Window)

---@class Panel
RageUI.Panel = setmetatable({}, RageUI.Panel)

---@class RMenu
RMenu = setmetatable({}, RMenu)

---@type table
local TotalMenus = {}

---Add
---@param Type string
---@param Name string
---@param Menu table
---@return RMenu
---@public
function RMenu.Add(Type, Name, Menu)
    if RMenu[Type] == nil then
        RMenu[Type] = {}
    end

    RMenu[Type][Name] = {
        Menu = Menu
    }

    table.insert(TotalMenus, Menu)
end

---Get
---@param Type string
---@param Name string
---@return RageUIMenus
---@public
function RMenu:Get(Type, Name)
    if self[Type] ~= nil and self[Type][Name] ~= nil then
        return self[Type][Name].Menu
    end
end

---GetType
---@param Type string
---@return table
---@public
function RMenu:GetType(Type)
    if self[Type] ~= nil then
        return self[Type]
    end
end

---Settings
---@param Type string
---@param Name string
---@param Settings string
---@param Value any optional
---@return void
---@public
function RMenu:Settings(Type, Name, Settings, Value)
    if Value ~= nil then
        self[Type][Name][Settings] = Value
    else
        return self[Type][Name][Settings]
    end
end

---Delete
---@param Type string
---@param Name string
---@return void
---@public
function RMenu:Delete(Type, Name)
    self[Type][Name] = nil
    collectgarbage()
end

---DeleteType
---@param Type string
---@return void
---@public
function RMenu:DeleteType(Type)
    self[Type] = nil
    collectgarbage()
end

---GetMenus
---@return table
---@public
function RMenu:GetMenus()
    return TotalMenus
end
