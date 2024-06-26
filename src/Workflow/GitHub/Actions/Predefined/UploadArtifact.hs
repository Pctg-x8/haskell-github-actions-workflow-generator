module Workflow.GitHub.Actions.Predefined.UploadArtifact (step) where

import Data.Aeson (ToJSON (toJSON))
import Data.Map qualified as M
import Workflow.GitHub.Actions.Step (Step, actionStep)

step :: String -> String -> Step
step name path = actionStep "actions/upload-artifact@v4" args
  where
    args = M.fromList [("name", toJSON name), ("path", toJSON path)]
