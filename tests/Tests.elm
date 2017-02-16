module Tests exposing (..)

import Test exposing (..)
import Expect
import RemainingDays.Model as RemainingDaysModel
import Date exposing (..)
import Date.Extra as Date exposing (..)


currentDate : Date
currentDate =
    Date.fromCalendarDate 2017 Feb 18


maybeCurrentDate : Maybe Date
maybeCurrentDate =
    Just (currentDate)


maybeTwoDaysAfterCurrentDate : Maybe Date
maybeTwoDaysAfterCurrentDate =
    Just (Date.add Week 2 currentDate)


all : Test
all =
    describe "Model Unit Tests"
        [ describe "Remaining Days between two dates"
            [ test "returns 0 when startDate is not provided" <|
                \() ->
                    Expect.equal 0
                        (RemainingDaysModel.remaining
                            { startDate = Nothing
                            , endDate = maybeCurrentDate
                            , description = "Title"
                            }
                        )
            , test "returns 0 when endDate is not provided" <|
                \() ->
                    Expect.equal 0
                        (RemainingDaysModel.remaining
                            { startDate = maybeCurrentDate
                            , endDate = Nothing
                            , description = "Title"
                            }
                        )
            , test "returns 0 when both dates are not provided" <|
                \() ->
                    Expect.equal 0
                        (RemainingDaysModel.remaining
                            { startDate = Nothing
                            , endDate = Nothing
                            , description = "Title"
                            }
                        )
            , test "returns 14 when difference between days is 2 weeks" <|
                \() ->
                    Expect.equal 14
                        (RemainingDaysModel.remaining
                            { startDate = maybeCurrentDate
                            , endDate = maybeTwoDaysAfterCurrentDate
                            , description = "Title"
                            }
                        )
            ]
        , describe "Updates today date"
            [ test "returns today's date as a start date" <|
                \() ->
                    Expect.equal
                        { startDate = maybeCurrentDate
                        , endDate = maybeTwoDaysAfterCurrentDate
                        , description = "Title"
                        }
                        (RemainingDaysModel.updateTodayDate
                            { startDate = Nothing
                            , endDate = maybeTwoDaysAfterCurrentDate
                            , description = "Title"
                            }
                            (Date.toTime currentDate)
                        )
            ]
        ]
