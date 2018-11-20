//
//  Signs.swift
//  cv-assist-ios
//
//  Created by Maksim Vaniukevich on 3/21/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

extension SignValue {
    func icon(over: Bool, market: Market) -> ImageAsset? {
        switch type {
        case .unknown:
            return nil
        case .mass:
            return nil
        case .speedLimit:
            switch market {
            case .us:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitUS5Over : Asset.Signs.speedLimitUS5
                case 15:
                    return over ? Asset.Signs.speedLimitUS15Over : Asset.Signs.speedLimitUS15
                case 25:
                    return over ? Asset.Signs.speedLimitUS25Over : Asset.Signs.speedLimitUS25
                case 35:
                    return over ? Asset.Signs.speedLimitUS35Over : Asset.Signs.speedLimitUS35
                case 45:
                    return over ? Asset.Signs.speedLimitUS45Over : Asset.Signs.speedLimitUS45
                case 55:
                    return over ? Asset.Signs.speedLimitUS55Over : Asset.Signs.speedLimitUS55
                case 65:
                    return over ? Asset.Signs.speedLimitUS65Over : Asset.Signs.speedLimitUS65
                case 75:
                    return over ? Asset.Signs.speedLimitUS75Over : Asset.Signs.speedLimitUS75
                case 10:
                    return over ? Asset.Signs.speedLimitUS10Over : Asset.Signs.speedLimitUS10
                case 20:
                    return over ? Asset.Signs.speedLimitUS20Over : Asset.Signs.speedLimitUS20
                case 30:
                    return over ? Asset.Signs.speedLimitUS30Over : Asset.Signs.speedLimitUS30
                case 40:
                    return over ? Asset.Signs.speedLimitUS40Over : Asset.Signs.speedLimitUS40
                case 50:
                    return over ? Asset.Signs.speedLimitUS50Over : Asset.Signs.speedLimitUS50
                case 60:
                    return over ? Asset.Signs.speedLimitUS60Over : Asset.Signs.speedLimitUS60
                case 70:
                    return over ? Asset.Signs.speedLimitUS70Over : Asset.Signs.speedLimitUS70
                case 80:
                    return over ? Asset.Signs.speedLimitUS80Over : Asset.Signs.speedLimitUS80
                case 85:
                    return over ? Asset.Signs.speedLimitUS85Over : Asset.Signs.speedLimitUS85
                case 90:
                    return over ? Asset.Signs.speedLimitUS90Over : Asset.Signs.speedLimitUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitEnd:
            switch market {
            case .us:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitEndUS5Over : Asset.Signs.speedLimitEndUS5
                case 15:
                    return over ? Asset.Signs.speedLimitEndUS15Over : Asset.Signs.speedLimitEndUS15
                case 25:
                    return over ? Asset.Signs.speedLimitEndUS25Over : Asset.Signs.speedLimitEndUS25
                case 35:
                    return over ? Asset.Signs.speedLimitEndUS35Over : Asset.Signs.speedLimitEndUS35
                case 45:
                    return over ? Asset.Signs.speedLimitEndUS45Over : Asset.Signs.speedLimitEndUS45
                case 55:
                    return over ? Asset.Signs.speedLimitEndUS55Over : Asset.Signs.speedLimitEndUS55
                case 65:
                    return over ? Asset.Signs.speedLimitEndUS65Over : Asset.Signs.speedLimitEndUS65
                case 75:
                    return over ? Asset.Signs.speedLimitEndUS75Over : Asset.Signs.speedLimitEndUS75
                case 10:
                    return over ? Asset.Signs.speedLimitEndUS10Over : Asset.Signs.speedLimitEndUS10
                case 20:
                    return over ? Asset.Signs.speedLimitEndUS20Over : Asset.Signs.speedLimitEndUS20
                case 30:
                    return over ? Asset.Signs.speedLimitEndUS30Over : Asset.Signs.speedLimitEndUS30
                case 40:
                    return over ? Asset.Signs.speedLimitEndUS40Over : Asset.Signs.speedLimitEndUS40
                case 50:
                    return over ? Asset.Signs.speedLimitEndUS50Over : Asset.Signs.speedLimitEndUS50
                case 60:
                    return over ? Asset.Signs.speedLimitEndUS60Over : Asset.Signs.speedLimitEndUS60
                case 70:
                    return over ? Asset.Signs.speedLimitEndUS70Over : Asset.Signs.speedLimitEndUS70
                case 80:
                    return over ? Asset.Signs.speedLimitEndUS80Over : Asset.Signs.speedLimitEndUS80
                case 85:
                    return over ? Asset.Signs.speedLimitEndUS85Over : Asset.Signs.speedLimitEndUS85
                case 90:
                    return over ? Asset.Signs.speedLimitEndUS90Over : Asset.Signs.speedLimitEndUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitMin:
            switch market {
            case .us:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitMinUS5Over : Asset.Signs.speedLimitMinUS5
                case 15:
                    return over ? Asset.Signs.speedLimitMinUS15Over : Asset.Signs.speedLimitMinUS15
                case 25:
                    return over ? Asset.Signs.speedLimitMinUS25Over : Asset.Signs.speedLimitMinUS25
                case 35:
                    return over ? Asset.Signs.speedLimitMinUS35Over : Asset.Signs.speedLimitMinUS35
                case 45:
                    return over ? Asset.Signs.speedLimitMinUS45Over : Asset.Signs.speedLimitMinUS45
                case 55:
                    return over ? Asset.Signs.speedLimitMinUS55Over : Asset.Signs.speedLimitMinUS55
                case 65:
                    return over ? Asset.Signs.speedLimitMinUS65Over : Asset.Signs.speedLimitMinUS65
                case 75:
                    return over ? Asset.Signs.speedLimitMinUS75Over : Asset.Signs.speedLimitMinUS75
                case 10:
                    return over ? Asset.Signs.speedLimitMinUS10Over : Asset.Signs.speedLimitMinUS10
                case 20:
                    return over ? Asset.Signs.speedLimitMinUS20Over : Asset.Signs.speedLimitMinUS20
                case 30:
                    return over ? Asset.Signs.speedLimitMinUS30Over : Asset.Signs.speedLimitMinUS30
                case 40:
                    return over ? Asset.Signs.speedLimitMinUS40Over : Asset.Signs.speedLimitMinUS40
                case 50:
                    return over ? Asset.Signs.speedLimitMinUS50Over : Asset.Signs.speedLimitMinUS50
                case 60:
                    return over ? Asset.Signs.speedLimitMinUS60Over : Asset.Signs.speedLimitMinUS60
                case 70:
                    return over ? Asset.Signs.speedLimitMinUS70Over : Asset.Signs.speedLimitMinUS70
                case 80:
                    return over ? Asset.Signs.speedLimitMinUS80Over : Asset.Signs.speedLimitMinUS80
                case 85:
                    return over ? Asset.Signs.speedLimitMinUS85Over : Asset.Signs.speedLimitMinUS85
                case 90:
                    return over ? Asset.Signs.speedLimitMinUS90Over : Asset.Signs.speedLimitMinUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitTrucks:
            switch market {
            case .us:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitTrucksUS5Over : Asset.Signs.speedLimitTrucksUS5
                case 15:
                    return over ? Asset.Signs.speedLimitTrucksUS15Over : Asset.Signs.speedLimitTrucksUS15
                case 25:
                    return over ? Asset.Signs.speedLimitTrucksUS25Over : Asset.Signs.speedLimitTrucksUS25
                case 35:
                    return over ? Asset.Signs.speedLimitTrucksUS35Over : Asset.Signs.speedLimitTrucksUS35
                case 45:
                    return over ? Asset.Signs.speedLimitTrucksUS45Over : Asset.Signs.speedLimitTrucksUS45
                case 55:
                    return over ? Asset.Signs.speedLimitTrucksUS55Over : Asset.Signs.speedLimitTrucksUS55
                case 65:
                    return over ? Asset.Signs.speedLimitTrucksUS65Over : Asset.Signs.speedLimitTrucksUS65
                case 75:
                    return over ? Asset.Signs.speedLimitTrucksUS75Over : Asset.Signs.speedLimitTrucksUS75
                case 10:
                    return over ? Asset.Signs.speedLimitTrucksUS10Over : Asset.Signs.speedLimitTrucksUS10
                case 20:
                    return over ? Asset.Signs.speedLimitTrucksUS20Over : Asset.Signs.speedLimitTrucksUS20
                case 30:
                    return over ? Asset.Signs.speedLimitTrucksUS30Over : Asset.Signs.speedLimitTrucksUS30
                case 40:
                    return over ? Asset.Signs.speedLimitTrucksUS40Over : Asset.Signs.speedLimitTrucksUS40
                case 50:
                    return over ? Asset.Signs.speedLimitTrucksUS50Over : Asset.Signs.speedLimitTrucksUS50
                case 60:
                    return over ? Asset.Signs.speedLimitTrucksUS60Over : Asset.Signs.speedLimitTrucksUS60
                case 70:
                    return over ? Asset.Signs.speedLimitTrucksUS70Over : Asset.Signs.speedLimitTrucksUS70
                case 80:
                    return over ? Asset.Signs.speedLimitTrucksUS80Over : Asset.Signs.speedLimitTrucksUS80
                case 85:
                    return over ? Asset.Signs.speedLimitTrucksUS85Over : Asset.Signs.speedLimitTrucksUS85
                case 90:
                    return over ? Asset.Signs.speedLimitTrucksUS90Over : Asset.Signs.speedLimitTrucksUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitNight:
            switch market {
            case .us:
                switch number {
                case 5:
                    return over ? Asset.Signs.speedLimitNightUS5Over : Asset.Signs.speedLimitNightUS5
                case 15:
                    return over ? Asset.Signs.speedLimitNightUS15Over : Asset.Signs.speedLimitNightUS15
                case 25:
                    return over ? Asset.Signs.speedLimitNightUS25Over : Asset.Signs.speedLimitNightUS25
                case 35:
                    return over ? Asset.Signs.speedLimitNightUS35Over : Asset.Signs.speedLimitNightUS35
                case 45:
                    return over ? Asset.Signs.speedLimitNightUS45Over : Asset.Signs.speedLimitNightUS45
                case 55:
                    return over ? Asset.Signs.speedLimitNightUS55Over : Asset.Signs.speedLimitNightUS55
                case 65:
                    return over ? Asset.Signs.speedLimitNightUS65Over : Asset.Signs.speedLimitNightUS65
                case 75:
                    return over ? Asset.Signs.speedLimitNightUS75Over : Asset.Signs.speedLimitNightUS75
                case 10:
                    return over ? Asset.Signs.speedLimitNightUS10Over : Asset.Signs.speedLimitNightUS10
                case 20:
                    return over ? Asset.Signs.speedLimitNightUS20Over : Asset.Signs.speedLimitNightUS20
                case 30:
                    return over ? Asset.Signs.speedLimitNightUS30Over : Asset.Signs.speedLimitNightUS30
                case 40:
                    return over ? Asset.Signs.speedLimitNightUS40Over : Asset.Signs.speedLimitNightUS40
                case 50:
                    return over ? Asset.Signs.speedLimitNightUS50Over : Asset.Signs.speedLimitNightUS50
                case 60:
                    return over ? Asset.Signs.speedLimitNightUS60Over : Asset.Signs.speedLimitNightUS60
                case 70:
                    return over ? Asset.Signs.speedLimitNightUS70Over : Asset.Signs.speedLimitNightUS70
                case 80:
                    return over ? Asset.Signs.speedLimitNightUS80Over : Asset.Signs.speedLimitNightUS80
                case 85:
                    return over ? Asset.Signs.speedLimitNightUS85Over : Asset.Signs.speedLimitNightUS85
                case 90:
                    return over ? Asset.Signs.speedLimitNightUS90Over : Asset.Signs.speedLimitNightUS90
                default: return nil
                }
            case .china:
                return nil
            }
        case .speedLimitComplementary:
            switch number {
            case 5:
                return over ? Asset.Signs.speedLimitCompUS5Over : Asset.Signs.speedLimitCompUS5
            case 15:
                return over ? Asset.Signs.speedLimitCompUS15Over : Asset.Signs.speedLimitCompUS15
            case 25:
                return over ? Asset.Signs.speedLimitCompUS25Over : Asset.Signs.speedLimitCompUS25
            case 35:
                return over ? Asset.Signs.speedLimitCompUS35Over : Asset.Signs.speedLimitCompUS35
            case 45:
                return over ? Asset.Signs.speedLimitCompUS45Over : Asset.Signs.speedLimitCompUS45
            case 55:
                return over ? Asset.Signs.speedLimitCompUS55Over : Asset.Signs.speedLimitCompUS55
            case 65:
                return over ? Asset.Signs.speedLimitCompUS65Over : Asset.Signs.speedLimitCompUS65
            case 75:
                return over ? Asset.Signs.speedLimitCompUS75Over : Asset.Signs.speedLimitCompUS75
            case 85:
                return over ? Asset.Signs.speedLimitCompUS85Over : Asset.Signs.speedLimitCompUS85
            case 10:
                return over ? Asset.Signs.speedLimitCompUS10Over : Asset.Signs.speedLimitCompUS10
            case 20:
                return over ? Asset.Signs.speedLimitCompUS20Over : Asset.Signs.speedLimitCompUS20
            case 30:
                return over ? Asset.Signs.speedLimitCompUS30Over : Asset.Signs.speedLimitCompUS30
            case 40:
                return over ? Asset.Signs.speedLimitCompUS40Over : Asset.Signs.speedLimitCompUS40
            case 50:
                return over ? Asset.Signs.speedLimitCompUS50Over : Asset.Signs.speedLimitCompUS50
            case 60:
                return over ? Asset.Signs.speedLimitCompUS60Over : Asset.Signs.speedLimitCompUS60
            case 70:
                return over ? Asset.Signs.speedLimitCompUS70Over : Asset.Signs.speedLimitCompUS70
            case 80:
                return over ? Asset.Signs.speedLimitCompUS80Over : Asset.Signs.speedLimitCompUS80
            case 90:
                return over ? Asset.Signs.speedLimitCompUS90Over : Asset.Signs.speedLimitCompUS90
            default: return nil
            }
        case .speedLimitExit:
            switch number {
            case 5:
                return over ? Asset.Signs.warningExitUS5Over : Asset.Signs.warningExitUS5
            case 15:
                return over ? Asset.Signs.warningExitUS15Over : Asset.Signs.warningExitUS15
            case 25:
                return over ? Asset.Signs.warningExitUS25Over : Asset.Signs.warningExitUS25
            case 35:
                return over ? Asset.Signs.warningExitUS35Over : Asset.Signs.warningExitUS35
            case 45:
                return over ? Asset.Signs.warningExitUS45Over : Asset.Signs.warningExitUS45
            case 55:
                return over ? Asset.Signs.warningExitUS55Over : Asset.Signs.warningExitUS55
            case 65:
                return over ? Asset.Signs.warningExitUS65Over : Asset.Signs.warningExitUS65
            case 75:
                return over ? Asset.Signs.warningExitUS75Over : Asset.Signs.warningExitUS75
            case 85:
                return over ? Asset.Signs.warningExitUS85Over : Asset.Signs.warningExitUS85
            case 10:
                return over ? Asset.Signs.warningExitUS10Over : Asset.Signs.warningExitUS10
            case 20:
                return over ? Asset.Signs.warningExitUS20Over : Asset.Signs.warningExitUS20
            case 30:
                return over ? Asset.Signs.warningExitUS30Over : Asset.Signs.warningExitUS30
            case 40:
                return over ? Asset.Signs.warningExitUS40Over : Asset.Signs.warningExitUS40
            case 50:
                return over ? Asset.Signs.warningExitUS50Over : Asset.Signs.warningExitUS50
            case 60:
                return over ? Asset.Signs.warningExitUS60Over : Asset.Signs.warningExitUS60
            case 70:
                return over ? Asset.Signs.warningExitUS70Over : Asset.Signs.warningExitUS70
            case 80:
                return over ? Asset.Signs.warningExitUS80Over : Asset.Signs.warningExitUS80
            case 90:
                return over ? Asset.Signs.warningExitUS90Over : Asset.Signs.warningExitUS90
            default: return nil
            }
        case .speedLimitRamp:
            switch number {
            case 5:
                return over ? Asset.Signs.warningRampUS5Over : Asset.Signs.warningRampUS5
            case 15:
                return over ? Asset.Signs.warningRampUS15Over : Asset.Signs.warningRampUS15
            case 25:
                return over ? Asset.Signs.warningRampUS25Over : Asset.Signs.warningRampUS25
            case 35:
                return over ? Asset.Signs.warningRampUS35Over : Asset.Signs.warningRampUS35
            case 45:
                return over ? Asset.Signs.warningRampUS45Over : Asset.Signs.warningRampUS45
            case 55:
                return over ? Asset.Signs.warningRampUS55Over : Asset.Signs.warningRampUS55
            case 65:
                return over ? Asset.Signs.warningRampUS65Over : Asset.Signs.warningRampUS65
            case 75:
                return over ? Asset.Signs.warningRampUS75Over : Asset.Signs.warningRampUS75
            case 85:
                return over ? Asset.Signs.warningRampUS85Over : Asset.Signs.warningRampUS85
            case 10:
                return over ? Asset.Signs.warningRampUS10Over : Asset.Signs.warningRampUS10
            case 20:
                return over ? Asset.Signs.warningRampUS20Over : Asset.Signs.warningRampUS20
            case 30:
                return over ? Asset.Signs.warningRampUS30Over : Asset.Signs.warningRampUS30
            case 40:
                return over ? Asset.Signs.warningRampUS40Over : Asset.Signs.warningRampUS40
            case 50:
                return over ? Asset.Signs.warningRampUS50Over : Asset.Signs.warningRampUS50
            case 60:
                return over ? Asset.Signs.warningRampUS60Over : Asset.Signs.warningRampUS60
            case 70:
                return over ? Asset.Signs.warningRampUS70Over : Asset.Signs.warningRampUS70
            case 80:
                return over ? Asset.Signs.warningRampUS80Over : Asset.Signs.warningRampUS80
            case 90:
                return over ? Asset.Signs.warningRampUS90Over : Asset.Signs.warningRampUS90
            default: return nil
            }
        case .warningTurnLeft:
            return Asset.Signs.warningTurnLeftUS
        case .warningTurnRight:
            return Asset.Signs.warningTurnRightUS
        case .warningHairpinCurveLeft:
            return Asset.Signs.warningHairpinCurveLeftUS
        case .warningRoundabout:
            return Asset.Signs.warningRoundaboutUS
        case .warningSpeedBump:
            return Asset.Signs.warningSpeedBumpUS
        case .warningWindingRoad:
            return Asset.Signs.warningWindingRoadUS
        case .informationBikeRoute:
            return Asset.Signs.informationBikeRouteUS
        case .informationParking:
            return Asset.Signs.informationParkingUS
        case .regulatoryAllDirectionsPermitted:
            return Asset.Signs.regulatoryAllDirectionsPermittedUS
        case .regulatoryBicyclesOnly:
            return Asset.Signs.regulatoryBicyclesOnlyUS
        case .regulatoryDoNotPass:
            return Asset.Signs.regulatoryDoNotPassUS
        case .regulatoryDoNotDriveOnShoulder:
            return Asset.Signs.regulatoryDoNotDriveOnShoulderUS
        case .regulatoryDualLanesAllDirectionsOnRight:
            return Asset.Signs.regulatoryDualLanesAllDirectionsOnRightUS
        case .regulatoryDualLanesGoLeftOrRight:
            return Asset.Signs.regulatoryDualLanesGoLeftOrRightUS
        case .regulatoryDualLanesGoStraightOnLeft:
            return Asset.Signs.regulatoryDualLanesGoStraightOnLeftUS
        case .regulatoryDualLanesGoStraightOnRight:
            return Asset.Signs.regulatoryDualLanesGoStraightOnRightUS
        case .regulatoryDualLanesTurnLeft:
            return Asset.Signs.regulatoryDualLanesTurnLeftUS
        case .regulatoryDualLanesTurnLeftOrStraight:
            return Asset.Signs.regulatoryDualLanesTurnLeftOrStraightUS
        case .regulatoryDualLanesTurnRightOrStraight:
            return Asset.Signs.regulatoryDualLanesTurnRightOrStraightUS
        case .regulatoryEndOfSchoolZone:
            return Asset.Signs.regulatoryEndOfSchoolZoneUS
        case .regulatoryGoStraight:
            return Asset.Signs.regulatoryGoStraightUS
        case .regulatoryGoStraightOrTurnLeft:
            return Asset.Signs.regulatoryGoStraightOrTurnLeftUS
        case .regulatoryGoStraightOrTurnRight:
            return Asset.Signs.regulatoryGoStraightOrTurnRightUS
        case .regulatoryHeightLimit:
            return Asset.Signs.regulatoryHeightLimitUS
        case .regulatoryLeftTurnYieldOnGreen:
            return Asset.Signs.regulatoryLeftTurnYieldOnGreenUS
        case .regulatoryNoBicycles:
            return Asset.Signs.regulatoryNoBicyclesUS
        case .regulatoryNoEntry:
            return Asset.Signs.regulatoryNoEntryUS
        case .regulatoryNoLeftOrUTurn:
            return Asset.Signs.regulatoryNoLeftOrUTurnUS
        case .regulatoryNoLeftTurn:
            return Asset.Signs.regulatoryNoLeftTurnUS
        case .regulatoryNoMotorVehicles:
            return Asset.Signs.regulatoryNoMotorVehiclesUS
        case .regulatoryNoParking:
            return Asset.Signs.regulatoryNoParkingUS
        case .regulatoryNoParkingOrNoStopping:
            return Asset.Signs.regulatoryNoParkingOrNoStoppingUS
        case .regulatoryNoPedestrians:
            return Asset.Signs.regulatoryNoPedestriansUS
        case .regulatoryNoRightTurn:
            return Asset.Signs.regulatoryNoRightTurnUS
        case .regulatoryNoStopping:
            return Asset.Signs.regulatoryNoStoppingUS
        case .regulatoryNoStraightThrough:
            return Asset.Signs.regulatoryNoStraightThroughUS
        case .regulatoryNoUTurn:
            return Asset.Signs.regulatoryNoUTurnUS
        case .regulatoryOneWayStraight:
            return Asset.Signs.regulatoryOneWayStraightUS
        case .regulatoryReversibleLanes:
            return Asset.Signs.regulatoryReversibleLanesUS
        case .regulatoryRoadClosedToVehicles:
            return Asset.Signs.regulatoryRoadClosedToVehiclesUS
        case .regulatoryStop:
            return Asset.Signs.regulatoryStopUS
        case .regulatoryTrafficSignalPhotoEnforced:
            return Asset.Signs.regulatoryTrafficSignalPhotoEnforcedUS
        case .regulatoryTripleLanesGoStraightCenterLane:
            return Asset.Signs.regulatoryTripleLanesGoStraightCenterLaneUS
        case .warningBicyclesCrossing:
            return Asset.Signs.warningBicyclesCrossingUS
        case .warningHeightRestriction:
            return Asset.Signs.warningHeightRestrictionUS
        case .warningPassLeftOrRight:
            return Asset.Signs.warningPassLeftOrRightUS
        case .warningPedestriansCrossing:
            return Asset.Signs.warningPedestriansCrossingUS
        case .warningRoadNarrowsLeft:
            return Asset.Signs.warningRoadNarrowsLeftUS
        case .warningRoadNarrowsRight:
            return Asset.Signs.warningRoadNarrowsRightUS
        case .warningSchoolZone:
            return Asset.Signs.warningSchoolZoneUS
        case .warningStopAhead:
            return Asset.Signs.warningStopAheadUS
        case .warningTrafficSignals:
            return Asset.Signs.warningTrafficSignalsUS
        case .warningTwoWayTraffic:
            return Asset.Signs.warningTwoWayTrafficUS
        case .warningYieldAhead:
            return Asset.Signs.warningYieldAheadUS
        case .informationHighway:
            return Asset.Signs.informationHighwayUS
        case .regulatoryDoNotBlockIntersection:
            return Asset.Signs.regulatoryDoNotBlockIntersectionUS
        case .regulatoryKeepRightPicture:
            return Asset.Signs.regulatoryKeepRightPictureUS
        case .regulatoryKeepRightText:
            return Asset.Signs.regulatoryKeepRightTextUS
        case .regulatoryNoHeavyGoodsVehiclesPicture:
            return Asset.Signs.regulatoryNoHeavyGoodsVehiclesPictureUS
        case .regulatoryNoLeftTurnText:
            return Asset.Signs.regulatoryNoLeftTurnTextUS
        case .regulatoryOneWayLeftArrow:
            return Asset.Signs.regulatoryOneWayLeftArrowUS
        case .regulatoryOneWayLeftArrowText:
            return Asset.Signs.regulatoryOneWayLeftArrowTextUS
        case .regulatoryOneWayLeftText:
            return Asset.Signs.regulatoryOneWayLeftTextUS
        case .regulatoryOneWayRightArrow:
            return Asset.Signs.regulatoryOneWayRightArrowUS
        case .regulatoryOneWayRightArrowText:
            return Asset.Signs.regulatoryOneWayRightArrowTextUS
        case .regulatoryOneWayRightText:
            return Asset.Signs.regulatoryOneWayRightTextUS
        case .regulatoryTurnLeftAhead:
            return Asset.Signs.regulatoryTurnLeftAheadUS
        case .regulatoryTurnLeft:
            return Asset.Signs.regulatoryTurnLeftUS
        case .regulatoryTurnLeftOrRight:
            return Asset.Signs.regulatoryTurnLeftOrRightUS
        case .regulatoryTurnRightAhead:
            return Asset.Signs.regulatoryTurnRightAheadUS
        case .regulatoryYield:
            return Asset.Signs.regulatoryYieldUS
        case .warningRailwayCrossing:
            return Asset.Signs.warningRailwayCrossingUS
        case .warningHairpinCurveRight:
            return Asset.Signs.warningHairpinCurveRightUS
        case .complementaryOneDirectionLeft:
            return Asset.Signs.complementaryOneDirectionLeftUS
        case .complementaryOneDirectionRight:
            return Asset.Signs.complementaryOneDirectionRightUS
        case .warningCurveLeft:
            return Asset.Signs.warningCurveLeftUS
        case .warningCurveRight:
            return Asset.Signs.warningCurveRightUS
        case .warningHorizontalAlignmentLeft:
            return Asset.Signs.warningHorizontalAlignmentLeftUS
        case .warningHorizontalAlignmentRight:
            return Asset.Signs.warningHorizontalAlignmentRightUS
        case .regulatoryTurnRight:
            return Asset.Signs.regulatoryTurnRightUS
        case .whiteTablesText:
            return Asset.Signs.whiteTablesTextUS
        case .lanes:
            return Asset.Signs.lanesUS
        case .greenPlates:
            return Asset.Signs.greenPlatesUS
        case .warningText:
            return Asset.Signs.warningTextUS
        case .warningCrossroads:
            return Asset.Signs.warningCrossroadsUS
        case .warningPicture:
            return Asset.Signs.warningPictureUS
        case .complementaryKeepLeft:
            return Asset.Signs.complementaryKeepLeftUS
        case .complementaryKeepRight:
            return Asset.Signs.complementaryKeepRightUS
        case .regulatoryExceptBicycle:
            return Asset.Signs.regulatoryExceptBicycleUS
        case .warningAddedLaneRight:
            return Asset.Signs.warningAddedLaneRightUS
        case .warningDeadEndText:
            return Asset.Signs.warningDeadEndTextUS
        case .warningDipText:
            return Asset.Signs.warningDipTextUS
        case .warningEmergencyVehicles:
            return Asset.Signs.warningEmergencyVehiclesUS
        case .warningEndText:
            return Asset.Signs.warningEndTextUS
        case .warningFallingRocksOrDebrisRight:
            return Asset.Signs.warningFallingRocksOrDebrisRightUS
        case .warningLowGroundClearance:
            return Asset.Signs.warningLowGroundClearanceUS
        case .warningObstructionMarker:
            return Asset.Signs.warningObstructionMarkerUS
        case .warningPlayground:
            return Asset.Signs.warningPlaygroundUS
        case .warningSecondRoadRight:
            return Asset.Signs.warningSecondRoadRightUS
        case .warningTurnLeftOnlyArrow:
            return Asset.Signs.warningTurnLeftOnlyArrowUS
        case .warningTurnLeftOrRightOnlyArrow:
            return Asset.Signs.warningTurnLeftOrRightOnlyArrowUS
        case .warningTramsCrossing:
            return Asset.Signs.warningTramsCrossingUS
        case .warningUnevenRoad:
            return Asset.Signs.warningUnevenRoadUS
        case .warningWildAnimals:
            return Asset.Signs.warningWildAnimalsUS
        case .regulatoryParkingRestrictions:
            return Asset.Signs.regulatoryParkingRestrictionsUS
        case .regulatoryYieldOrStopForPedestrians:
            return Asset.Signs.regulatoryYieldOrStopForPedestriansUS
        }
    }
}
