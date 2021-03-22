
fx_version 'adamant'
games { 'gta5' };

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/Audio.lua",
    "RageUI/components/Enum.lua",
    "RageUI/components/Keys.lua",
    "RageUI/components/Rectangle.lua",
    "RageUI/components/Sprite.lua",
    "RageUI/components/Text.lua",
    "RageUI/components/Visual.lua",
    "RageUI/menu/elements/ItemsBadge.lua",
    "RageUI/menu/elements/ItemsColour.lua",
    "RageUI/menu/elements/PanelColour.lua",
    "RageUI/menu/items/UIButton.lua",
    "RageUI/menu/items/UICheckBox.lua",
    "RageUI/menu/items/UIList.lua",
    "RageUI/menu/items/UIProgress.lua",
    "RageUI/menu/items/UISeparator.lua",
    "RageUI/menu/items/UISlider.lua",
    "RageUI/menu/items/UISliderHeritage.lua",
    "RageUI/menu/items/UISliderProgress.lua",
    "RageUI/menu/panels/UIButtonPanel.lua",
    "RageUI/menu/panels/UIColourPanel.lua",
    "RageUI/menu/panels/UIGridPanel.lua",
    "RageUI/menu/panels/UIPercentagePanel.lua",
    "RageUI/menu/panels/UIStatisticsPanel.lua",
    "RageUI/menu/windows/UIHeritage.lua",
}

ui_page "client/web/index.html"

files {
    'client/web/js/iziToast.js',
    'client/web/js/main.js',
    'client/web/css/iziToast.css',
    'client/web/index.html',
}


client_scripts {
    "config.lua",
    "client/*.lua",
    "client/inventory/menu.lua",
    "client/inventory/functions.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "config.lua",
    "server/utils.lua",
    "server/testcommands.lua",
    "server/player/*.lua",
    "server/inventory/*.lua",
    "server/society/*.lua",
}


server_exports {
    "AddMoney",
    "RemoveMoney",
    "AddBank",
    "RemoveBank",
    "AddBlack",
    "RemoveBlack",
    "GetMoney",
    "GetBank",
    "GetBlack",
    "HasEnoughBank",
    "HasEnoughCash",
    "HasEnoughBlack",
    "BankToCash",
    "CashToBank",
    "BlackToCash",
    "CashTransfer",
    "BankTransfer",
    "BlackTransfer",
    "AddItem",
    "RemoveItem",
    "AddItemIf",
    "ExhangeItem",
    "GiveMoneyToSociety",
    "GiveBankToSociety",
    "SavePlayerSkin",
    "SavePlayerIdentity",
    "DropItem",
    "CreatePickupItem",
    "SetItemArg",
    "GetSocietyInfo",
    "TransferItemToSociety",
    "TransferItemFromSocietyToPlayer",
    "IsPlayerBoss",
    "RecruitPlayer",
    "LeaveJob",
    "ChangePlayerJobGrade",
    "BuyIfCan",
    "GetPlayerIdentity",
}

exports {
    "GetPlayerJob",
    "GetPlayerMoney",
    "GetPlayerBank",
    "GetPlayerBlack",
    "GetPlayerInv",
    "IsPlayerLoaded",
    "GetPlayerUniqueId",
    "RegisterItemAction",
    "UseItem",
    "GetPlayerPermLevel",
    "GetPlayerIdentity",
    "GetPlayerJobGrade",
    "GetPlayerBossStatus",
    "GetPlayerSkin",
}


