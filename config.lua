config = {
    prefix = "rFw:", -- Events prefix, i suggest you to change that
    defaultBank = 2000,
    defaultMoney = 500,
    defaultBlack = 200,

    defaultWeightLimit = 50,

    defaultPos = vector3(0.0, 0.0, 0.0),

    savingAllPlayers = 5, -- in minutes, exemple 5 will mean every 5 minutes every players are saved

    inventoryKey = "F2",

    items = {
        ["test"] = {label = "Item test", weight = 1},
    },


    society = {
        ["police"] = {
            {grade = 1, label = "Cadet"},
            {grade = 2, label = "Officier"},
            {grade = 3, label = "Commandant"},
        }
    }
}