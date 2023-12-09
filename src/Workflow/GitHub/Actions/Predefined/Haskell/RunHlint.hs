{-# LANGUAGE NoOverloadedStrings #-}

module Workflow.GitHub.Actions.Predefined.Haskell.RunHlint (step, stepMultiplePaths, failOn, FailOn(..)) where

import Workflow.GitHub.Actions qualified as GHA
import qualified Data.Map as M
import Data.Aeson (ToJSON(toJSON))

step :: String -> GHA.Step
step = GHA.actionStep "haskell-actions/hlint-run@v2" . M.singleton "path" . toJSON

stepMultiplePaths :: [String] -> GHA.Step
stepMultiplePaths = GHA.actionStep "haskell-actions/hlint-run@v2" . M.singleton "path" . toJSON

data FailOn = Never | Status | Warning | Suggestion | Error
instance ToJSON FailOn where
  toJSON Never = toJSON "never"
  toJSON Status = toJSON "status"
  toJSON Warning = toJSON "warning"
  toJSON Suggestion = toJSON "suggestion"
  toJSON Error = toJSON "error"

failOn :: FailOn -> GHA.StepModifier
failOn = GHA.stepSetWithParam "fail-on" . toJSON
