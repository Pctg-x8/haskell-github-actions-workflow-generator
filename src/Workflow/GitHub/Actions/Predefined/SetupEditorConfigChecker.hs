module Workflow.GitHub.Actions.Predefined.SetupEditorConfigChecker (step, version) where

import Workflow.GitHub.Actions qualified as GHA
import Data.Aeson (ToJSON(toJSON))

step :: GHA.Step
step = GHA.actionStep "editorconfig-checker/action-editorconfig-checker@v2" mempty

version :: String -> GHA.StepModifier
version = GHA.stepSetWithParam "version" . toJSON
