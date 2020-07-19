--[[
set skin

skin = {
   ped = "",
   faceMum = 1,
   faceDad = 1,
   ressemblance = 1,
   skinMix = 1,
   eyebrowHeight = 1,
   eyebrowForward = 1,
   eyeOpening = 1,
   noseWidth = 1,
   nosePeaklowering = 1,
   noseBoneHeight = 1,
   noseBoneTwist = 1,
   nosePeakHeight = 1,
   nosePeakLength = 1,
   cheeksBoneHeight = 1,
   cheeksBoneWidth = 1,
   lipsThickness = 1,
   jawBoneWidth = 1,
   jawBoneBackLength = 1,
   chimpBoneLength = 1,
   chimpBoneWidth = 1,
   chimpHole = 1,
   chimpBoneLowering = 1,
   hairStyle = 1,
   hairColor = { [1] = 1, [2] = 1 },
   blemishesStyle = 1,
   blemishesOpacity = 1,
   ageingStyle = 1,
   complexionStyle = 1,
   eyeStyle = 1,
   lipstickStyle = 1,
   lipstickOpacity = 1,
   lipstickColor = { [1] = 1, [2] = 1 },
   makeupStyle = 1,
   makeupOpacity = 1,
   makeupColor = { [1] = 1, [2] = 1 },
   beardStyle = 1,
   beardOpacity = 1,
   beardColor = { [1] = 1, [2] = 1 },
   ageingOpacity = 1,
   skinAspectStyle = 1,
   skinAspectOpacity = 1,
   frecklesStyle = 1,
   frecklesOpacity = 1,
   complexionOpacity = 1,
}

setPlayerSkin(ped, table) 

]]

function setPlayerPed(skin)
   local hash = skin
   RequestModel(hash)
   while not HasModelLoaded(hash) do
       Citizen.Wait(500)
   end
   SetPlayerModel(PlayerId(), hash)
   SetPedDefaultComponentVariation(PlayerPedId())
   SetEntityAsMissionEntity(PlayerPedId(), true, true)
   SetModelAsNoLongerNeeded(PlayerPedId())
end

function setPlayerSkin(ped, table) 
   SetPedHeadBlendData(ped, table.faceMum, table.faceDad, 0, table.faceMum, table.faceDad, 0, table.ressemblance, table.skinMix, 0, false)
   SetPedFaceFeature(ped, 0, table.noseWidth)
   SetPedFaceFeature(ped, 1, table.nosePeakHeight)
   SetPedFaceFeature(ped, 2, table.nosePeakLength)
   SetPedFaceFeature(ped, 3, table.noseBoneHeight)
   SetPedFaceFeature(ped, 4, table.nosePeaklowering)
   SetPedFaceFeature(ped, 5, table.noseBoneTwist)
   SetPedFaceFeature(ped, 6, table.eyebrowHeight)
   SetPedFaceFeature(ped, 7, table.eyebrowForward)
   SetPedFaceFeature(ped, 8, table.cheeksBoneHeight)
   SetPedFaceFeature(ped, 9, table.cheeksBoneWidth)
   SetPedFaceFeature(ped, 11, table.eyeOpening)
   SetPedFaceFeature(ped, 12, table.lipsThickness)
   SetPedFaceFeature(ped, 13, table.jawBoneWidth)
   SetPedFaceFeature(ped, 14, table.jawBoneBackLength)
   SetPedFaceFeature(ped, 15, table.chimpBoneLowering)
   SetPedFaceFeature(ped, 16, table.chimpBoneLength)
   SetPedFaceFeature(ped, 17, table.chimpBoneWidth)
   SetPedFaceFeature(ped, 18, table.chimpHole)
   SetPedComponentVariation(ped, 2, table.hairStyle, 0, 0)
   SetPedHairColor(ped, table.hairColor[1], table.hairColor[2])
   SetPedHeadOverlay(ped, 1, table.beardStyle, table.beardOpacity)
   SetPedHeadOverlayColor(ped, 1, 1, table.beardColor[1], table.beardColor[2])
   SetPedHeadOverlay(ped, 3, table.ageingStyle, table.ageingOpacity)
   SetPedHeadOverlay(ped, 8, table.lipstickStyle, table.lipstickOpacity)
   SetPedHeadOverlayColor(ped, 8, 1, table.lipstickColor[1], table.lipstickColor[2])
   SetPedHeadOverlay(ped, 4, table.makeupStyle, table.makeupOpacity)
   SetPedHeadOverlayColor(ped, 4, 1, table.makeupColor[1], table.makeupColor[2])
   SetPedEyeColor(ped, table.eyeStyle)
   SetPedHeadOverlay(ped, 0, table.blemishesStyle, table.blemishesOpacity)
   SetPedHeadOverlay(ped, 6, table.complexionStyle, table.complexionStyle)
   SetPedHeadOverlay(ped, 7, table.skinAspectStyle, table.skinAspectOpacity)
   SetPedHeadOverlay(ped, 9, table.frecklesStyle, table.frecklesOpacity)
end
