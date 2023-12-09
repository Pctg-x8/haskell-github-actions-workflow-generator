module Workflow.GitHub.Actions.Predefined.Haskell.SetupHlint (step, version) where

import Workflow.GitHub.Actions qualified as GHA
import Data.Aeson (ToJSON(toJSON))

step :: GHA.Step
step = GHA.actionStep "haskell-actions/hlint-setup@v2" mempty

version :: String -> GHA.StepModifier
version = GHA.stepSetWithParam "version" . toJSON
